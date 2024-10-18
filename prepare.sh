#!/bin/bash

# This script downloads and patches a Chromium release to be built with fv8 modifications applied over the V8 engine

# Ensure all Git submodules are up to date
update_submodules() {
	git submodule update --checkout
}

# Activate Chromium depot_tools for checking out code
activate_depot_tools() {
	export PATH="$PWD/depot_tools:$PATH"
}
# Fetch Chromium sources
checkout_sources() {
	mkdir -p chromium
	cd chromium
	fetch --nohooks chromium
	cd src
	gclient sync --with_branch_heads --with_tags
	git fetch
}

# Apply FV8 patches to v8
patch_v8() {
	fv8_patch="$PWD/fv8/patches/V8_patch_122.diff"
	cd chromium/src/v8/src
	patch -p1 $fv8_patch
}

# Run pre-build hooks
run_hooks() {
	cd chromium/src
	gclient runhooks
}

# Configure build options
configure_build() {
	cd chromium/src
}

update_submodules
activate_depot_tools
(checkout_sources)
#patch_v8
#(run_hooks)
#(configure_build)

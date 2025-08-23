Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B5D34CF9
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 03:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755921366; cv=none; b=rLx4ZVW/33e298JD5A50x/Ic60Z781vMOwsPoon30YdtK4Nx5xbxNFE0LK1WeV9ga3Pkk7iN7ZRVhm2XbJREd1w+e23OZBhLUZiW305EgvsETgzP08LSCdi/MKJ2/rJjFi7uuL77pOQnK3rPFitUoXDbYQDE5PihugvLyK1J0Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755921366; c=relaxed/simple;
	bh=WMHbEOGQayquDu09+eYl0UBBQnbGwL+gyQCmfc4ZjbY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MHsVwr8qE2/SqDs3c3K56G0Nnr9CG57NyUw4kCs3BopMaauc1/6ht1avYB1RrGYBWwIzm7x9LvmtPohvBs1pN32klALkqioSSK2PbnbUVb/VhtcqM7YYc+us2L2FwaU611QqKqtk7AHEk/jLAdL9H6O8kIwA4Zd8m4lye8jQ25I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ri5gs/BL; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ri5gs/BL"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b065d58so22487925e9.1
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 20:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755921361; x=1756526161; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2IpEgdRALkrM6UJvJxygqhZ4itNl+VlAsmOZZ6Rr4NQ=;
        b=Ri5gs/BLQbJItluR6kRTQtv+Xu+wgs/e20On9yKTgvsWoe2IYT0eArT1qIo6lfo/TU
         dE9I1+QoPxbxfF8bEKTm63yuAFQEWgwNs7NTMSx6q5+hDHIq8PjwVf4JDhr5uxCFOasc
         W5wZSpEXbQqHb1hrTPaxQel88tnPCWr/hBUXHJq8Vy5GniBE3Kg6Fbrda2J42STffWiu
         XFj5LgARORqQhspVt1IkS8yofmYlgp7IAjGE4rCmpCL8kDNEFGhy7oqymY2asvanCqIr
         dYbVNHfLb1Cj6TEXJq8zKX26+cczXt1vHJt4OD+CVPBvRfK5ViTGrQa4uWamvb/oG4SL
         ujwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755921361; x=1756526161;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2IpEgdRALkrM6UJvJxygqhZ4itNl+VlAsmOZZ6Rr4NQ=;
        b=pHWhtFdYFe0SyF/yi0AqurRzelw6r1c37mutUgNFo2+rl1SqET+fVxZ5AGEGQLsrLg
         9jWel3lbAx7IiLlQU3oJ6zxwbpuEJ1NwGc5QXfxS3wD26pruUwUI3mfGwFwH7b+05bd0
         /WH3PnAwuJiMNz2HDfViIpzIUpPjP6PRJ6oKLAFgCTEeFX/y7DWQCetOqwH2ALDl865h
         jWQ9rXC7sE1fzQF7gHCe52GXpQySkEQn9imxGmodvAPXopbt9B3PVuz+T932JWrzvzTS
         sLJ+AsjUfdDCDi4YKJhxzp7rTOO54A54JNcT8ZoKWhtDk/TSJxa6qRNCuEGEj+F2XvG2
         IKQw==
X-Gm-Message-State: AOJu0YzfVVH/TSk3pY3N1vMmAsu1woj0h4fdyxBhlVle9st2pRnZI0hr
	3kLpDb30M6PHH4TJYNwpttmfdql2md6do2SCoYux1Ii22pOPh+JMKa4VLvmPJg==
X-Gm-Gg: ASbGncudyGumxu6ym2pXZDsXVpmHAvt52q3f5xhPSYoKVjb+pU1TuqFR8EIXYMQXLuz
	r3cMHuEDuVUYcEiNZM6+o31+yKYmzcTQ1IPXWNCuZzDypSL/1j/FN8FOkjkJZlg5GsmmwpztekG
	nIIiONg5w2Y0IACUZsBnpa2HTANkwpjVI7YgVctrG53USgAHNst6x3H0qeo2kLecOCPKF+Rpk5Z
	0uuQHmY35XHwOhn0O5YqgzHAcnxj/sC0GW4qjox2McwMY0SHppneITJi/juJacAmN8lctgkBy6d
	f+2tZJLPzUmEVfr9PCyikQlc9kehXBOhUscxnOJ2PPWFhrttY0/0UUlD03zp88ti1J3/c+YiChR
	XI7IRUprxdXXCB8b94ZXhmx/zxeEBULmaM824cQ==
X-Google-Smtp-Source: AGHT+IFQXaopEnihbmk3zWDTJgystcGQNb2J2G1GnRVKYbE9nFHl2VlRdPDsaTpYtC2cXVF9c2J5JQ==
X-Received: by 2002:a05:600c:1d14:b0:43c:ec0a:ddfd with SMTP id 5b1f17b1804b1-45b51798f3bmr48089635e9.6.1755921360151;
        Fri, 22 Aug 2025 20:56:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711f89a1csm1836080f8f.63.2025.08.22.20.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 20:55:59 -0700 (PDT)
Message-Id: <pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
In-Reply-To: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
References: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Aug 2025 03:55:41 +0000
Subject: [PATCH v3 00/15] RFC: Cleanup xdiff and begin its rustification
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Taylor Blau <me@ttaylorr.com>,
    Christian Brabandt <cb@256bit.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Eli Schwartz <eschwartz@gentoo.org>,
    "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
    Patrick Steinhardt <ps@pks.im>,
    Sam James <sam@gentoo.org>,
    Collin Funk <collin.funk1@gmail.com>,
    Mike Hommey <mh@glandium.org>,
    Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Ramsay Jones <ramsay@ramsayjones.plus.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

In order to facilitate the quick adoption of am/xdiff-hash-tweak, this round
drops the changes to hashing in xdiff and instead modifies another part of
xdiff.

A high level overview of v3:

 * patch 1: add a policy for using Rust (brian's patch, with a small tweak)
 * patch 2: introduce Rust to the codebase
 * patches 3-5: adapt CI (github workflows) to build Git with Rust
 * patch 6: introduce the ivec type
 * patches 7-14: xdiff code cleanup in preparation for translating to Rust
 * patch 15: translate a C function into Rust and call it from C

I'm particularly interested in what folks think of the new ivec type for
sharing data across the language barrier. Thoughts?

Build results for these changes:
https://github.com/git/git/actions/runs/17170212383

Links to older versions, which focused on hashing in xdiff:

 * v1:
   https://lore.kernel.org/git/pull.1980.git.git.1752784344.gitgitgadget@gmail.com/
 * v2:
   https://lore.kernel.org/git/pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com/

Ezekiel Newren (13):
  xdiff: introduce rust
  github workflows: install rust
  github workflows: upload Cargo.lock
  ivec: create a vector type that is interoperable between C and Rust
  xdiff/xprepare: remove superfluous forward declarations
  xdiff: delete unnecessary fields from xrecord_t and xdfile_t
  xdiff: make fields of xrecord_t Rust friendly
  xdiff: use one definition for freeing xdfile_t
  xdiff: replace chastore with an ivec in xdfile_t
  xdiff: delete nrec field from xdfile_t
  xdiff: delete recs field from xdfile_t
  xdiff: make xdfile_t more rust friendly
  xdiff: implement xdl_trim_ends() in Rust

Johannes Schindelin (1):
  win+Meson: do allow linking with the Rust-built xdiff

brian m. carlson (1):
  doc: add a policy for using Rust

 .github/workflows/main.yml                    |  89 +++-
 .gitignore                                    |   3 +
 Documentation/Makefile                        |   1 +
 Documentation/technical/platform-support.adoc |   2 +
 Documentation/technical/rust-support.adoc     | 142 ++++++
 Makefile                                      |  69 ++-
 build_rust.sh                                 |  57 +++
 ci/install-dependencies.sh                    |  14 +-
 ci/install-rust-toolchain.sh                  |  30 ++
 ci/install-rustup.sh                          |  25 +
 ci/lib.sh                                     |   1 +
 ci/make-test-artifacts.sh                     |   9 +
 ci/run-build-and-tests.sh                     |  13 +
 config.mak.uname                              |   4 +
 git-compat-util.h                             |  17 +
 interop/ivec.c                                | 151 ++++++
 interop/ivec.h                                |  52 ++
 meson.build                                   |  54 +-
 rust/Cargo.toml                               |   6 +
 rust/interop/Cargo.toml                       |  14 +
 rust/interop/src/ivec.rs                      | 462 ++++++++++++++++++
 rust/interop/src/lib.rs                       |  10 +
 rust/xdiff/Cargo.toml                         |  15 +
 rust/xdiff/src/lib.rs                         |  15 +
 rust/xdiff/src/xprepare.rs                    |  27 +
 rust/xdiff/src/xtypes.rs                      |  19 +
 xdiff/xdiffi.c                                |  60 +--
 xdiff/xdiffi.h                                |   8 +-
 xdiff/xemit.c                                 |  24 +-
 xdiff/xhistogram.c                            |   2 +-
 xdiff/xmerge.c                                |  72 +--
 xdiff/xpatience.c                             |  16 +-
 xdiff/xprepare.c                              | 271 ++++------
 xdiff/xtypes.h                                |  27 +-
 xdiff/xutils.c                                |  12 +-
 35 files changed, 1474 insertions(+), 319 deletions(-)
 create mode 100644 Documentation/technical/rust-support.adoc
 create mode 100755 build_rust.sh
 create mode 100755 ci/install-rust-toolchain.sh
 create mode 100755 ci/install-rustup.sh
 create mode 100644 interop/ivec.c
 create mode 100644 interop/ivec.h
 create mode 100644 rust/Cargo.toml
 create mode 100644 rust/interop/Cargo.toml
 create mode 100644 rust/interop/src/ivec.rs
 create mode 100644 rust/interop/src/lib.rs
 create mode 100644 rust/xdiff/Cargo.toml
 create mode 100644 rust/xdiff/src/lib.rs
 create mode 100644 rust/xdiff/src/xprepare.rs
 create mode 100644 rust/xdiff/src/xtypes.rs


base-commit: 16bd9f20a403117f2e0d9bcda6c6e621d3763e77
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1980%2Fezekielnewren%2Fxdiff_rust_speedup-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1980/ezekielnewren/xdiff_rust_speedup-v3
Pull-Request: https://github.com/git/git/pull/1980

Range-diff vs v2:

  1:  75dfb40ead3 !  1:  6d065f550fe doc: add a policy for using Rust
     @@ Commit message
          contributors.
      
          Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     +    [en: Added some comments about types, and changed the recommondations
     +         about cbindgen, bindgen, rustix, libc.]
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## Documentation/Makefile ##
     @@ Documentation/technical/platform-support.adoc: meet the following minimum requir
       
       * Has active security support (taking security releases of dependencies, etc)
       
     -+* Supports Rust and the toolchain version specified in link:rust-support.txt[].
     ++* Supports Rust and the toolchain version specified in link:rust-support.adoc[].
      +
       These requirements are a starting point, and not sufficient on their own for the
       Git community to be enthusiastic about supporting your platform. Maintainers of
     @@ Documentation/technical/rust-support.adoc (new)
      +caused by porting a binary wholesale from one language to another that might
      +introduce bugs.
      +
     -+We will use the `bindgen` and `cbindgen` crates for handling C-compatible
     -+bindings and the `rustix` crate for POSIX-compatible interfaces.  The `libc`
     -+crate, which is used by `rustix`, does not expose safe interfaces and does not
     -+handle differences between platforms, such as differing 64-bit `stat` call
     -+names, and so is less desirable as a target than `rustix`.  We may still choose
     -+to use it in some cases if `rustix` does not offer suitable interfaces.
     ++Crates like libc or rustix define types like c_long, but in ways that are not
     ++safe across platforms.
     ++From https://docs.rs/rustix/latest/rustix/ffi/type.c_long.html:
     ++
     ++    This type will always be i32 or i64.  Most notably, many Linux-based
     ++    systems assume an i64, but Windows assumes i32.  The C standard technically
     ++    only requires that this type be a signed integer that is at least 32 bits
     ++    and at least the size of an int, although in practice, no system would
     ++    have a long that is neither an i32 nor i64.
     ++
     ++Also, note that other locations, such as
     ++https://docs.rs/libc/latest/libc/type.c_long.html, just hardcode c_long as i64
     ++even though C may mean i32 on some platforms.
     ++
     ++As such, using the c_long type would give us portability issues, and
     ++perpetuate some of the bugs git has faced across platforms.  Avoid using C's
     ++types (long, unsigned, char, etc.), and switch to unambiguous types (e.g. i32
     ++or i64) before trying to make C and Rust interoperate.
     ++
     ++Crates like libc and rustix may have also traditionally aided interoperability
     ++with older versions of Rust (e.g.  when worrying about stat[64] system calls),
     ++but the Rust standard library in newer versions of Rust handle these concerns
     ++in a platform agnostic way.  There may arise cases where we need to consider
     ++these crates, but for now we omit them.
     ++
     ++Tools like bindgen and cbindgen create C-styled unsafe Rust code rather than
     ++idiomatic Rust; where possible, we prefer to switch to idiomatic Rust.  Any
     ++standard C library functions that are needed can be manually wrapped on the
     ++Rust side.
      +
      +Rust upstream releases every six weeks and only supports the latest stable
      +release.  While it is nice that upstream is active, we would like our software
  2:  7709e5eddba <  -:  ----------- xdiff: introduce rust
  8:  7dc241e6682 !  2:  03939951256 github workflows: install rust
     @@ Metadata
      Author: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## Commit message ##
     -    github workflows: install rust
     +    xdiff: introduce rust
      
     -    Since we have introduced rust, it needs to be installed for the
     -    continuous integration build targets. Create an install script
     -    (build_rust.sh) that needs to be run as the same user that builds git.
     -    Because of the limitations of meson, create build_rust.sh which makes
     -    it easy to centralize how rust is built between meson and make.
     +    Upcoming patches will simplify xdiff, while also porting parts of it to
     +    Rust. In preparation, add some stubs and setup the Rust build. For now,
     +    it is easier to let cargo build rust and have make or meson merely link
     +    against the static library that cargo builds. In line with ongoing
     +    libification efforts, use multiple crates to allow more modularity on
     +    the Rust side. xdiff is the crate that this series will focus on, but
     +    we also introduce the interop crate for future patch series.
      
     -    There are 2 interesting decisions worth calling out in this commit:
     -
     -    * The 'output' field of custom_target() does not allow specifying a
     -      file nested inside the build directory. Thus create build_rust.sh to
     -      build rust with all of its parameters and then moves libxdiff.a to
     -      the root of the build directory.
     -
     -    * Install curl, to facilitate the rustup install script.
     +    In order to facilitate interoperability between C and Rust, introduce C
     +    definitions for Rust primitive types in git-compat-util.h.
      
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
     - ## .github/workflows/main.yml ##
     -@@ .github/workflows/main.yml: on: [push, pull_request]
     - 
     - env:
     -   DEVELOPER: 1
     -+  RUST_VERSION: 1.87.0
     - 
     - # If more than one workflow run is triggered for the very same commit hash
     - # (which happens when multiple branches pointing to the same commit), only
     + ## .gitignore ##
     +@@ .gitignore: Release/
     + /contrib/buildsystems/out
     + /contrib/libgit-rs/target
     + /contrib/libgit-sys/target
     ++/.idea/
     ++/rust/target/
     ++/rust/Cargo.lock
      
       ## Makefile ##
      @@ Makefile: TEST_SHELL_PATH = $(SHELL_PATH)
     @@ Makefile: TEST_SHELL_PATH = $(SHELL_PATH)
      +
      +EXTLIBS =
      +
     - ifeq ($(DEBUG), 1)
     --RUST_LIB = rust/target/debug/libxdiff.a
     ++ifeq ($(DEBUG), 1)
      +  RUST_BUILD_MODE = debug
     - else
     --RUST_LIB = rust/target/release/libxdiff.a
     ++else
      +  RUST_BUILD_MODE = release
      +endif
      +
     @@ Makefile: TEST_SHELL_PATH = $(SHELL_PATH)
      +UNAME_S := $(shell uname -s)
      +ifeq ($(UNAME_S),Linux)
      +  EXTLIBS += -ldl
     - endif
     ++endif
      +
       REFTABLE_LIB = reftable/libreftable.a
       
     @@ Makefile: UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
       # xdiff and reftable libs may in turn depend on what is in libgit.a
       GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
      -EXTLIBS =
     - 
     --GITLIBS += $(RUST_LIB)
     ++
       
       GIT_USER_AGENT = git/$(GIT_VERSION)
       
     @@ Makefile: $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
       	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
       		$(filter %.o,$^) $(LIBS)
       
     +@@ Makefile: $(LIB_FILE): $(LIB_OBJS)
     + $(XDIFF_LIB): $(XDIFF_OBJS)
     + 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
     + 
     ++
     + $(REFTABLE_LIB): $(REFTABLE_OBJS)
     + 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
     + 
      @@ Makefile: perf: all
       
       t/helper/test-tool$X: $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS)) $(UNIT_TEST_DIR)/test-lib.o
     @@ Makefile: perf: all
       	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
       
       check-sha1:: t/helper/test-tool$X
     +@@ Makefile: cocciclean:
     + 	$(RM) -r .build/contrib/coccinelle
     + 	$(RM) contrib/coccinelle/*.cocci.patch
     + 
     +-clean: profile-clean coverage-clean cocciclean
     ++rustclean:
     ++	cd rust && cargo clean
     ++
     ++clean: profile-clean coverage-clean cocciclean rustclean
     + 	$(RM) -r .build $(UNIT_TEST_BIN)
     + 	$(RM) GIT-TEST-SUITES
     + 	$(RM) po/git.pot po/git-core.pot
      @@ Makefile: FUZZ_CXXFLAGS ?= $(ALL_CFLAGS)
       .PHONY: fuzz-all
       fuzz-all: $(FUZZ_PROGRAMS)
     @@ build_rust.sh (new)
      @@
      +#!/bin/sh
      +
     -+if [ -z "$CARGO_HOME" ]; then
     -+  export CARGO_HOME=$HOME/.cargo
     -+  echo >&2 "::warning:: CARGO_HOME is not set"
     -+fi
     -+echo "CARGO_HOME=$CARGO_HOME"
      +
     -+rustc -vV
     -+cargo --version
     ++rustc -vV || exit $?
     ++cargo --version || exit $?
      +
      +dir_git_root=${0%/*}
      +dir_build=$1
     -+rust_target=$2
     ++rust_build_profile=$2
      +crate=$3
      +
      +dir_rust=$dir_git_root/rust
     @@ build_rust.sh (new)
      +  exit 1
      +fi
      +
     -+if [ "$rust_target" = "" ]; then
     -+  echo "did not specify the rust_target"
     ++if [ "$rust_build_profile" = "" ]; then
     ++  echo "did not specify the rust_build_profile"
      +  exit 1
      +fi
      +
     -+if [ "$rust_target" = "release" ]; then
     ++if [ "$rust_build_profile" = "release" ]; then
      +  rust_args="--release"
     -+  export RUSTFLAGS='-Aunused_imports -Adead_code'
     -+elif [ "$rust_target" = "debug" ]; then
     ++  export RUSTFLAGS=''
     ++elif [ "$rust_build_profile" = "debug" ]; then
      +  rust_args=""
     -+  export RUSTFLAGS='-Aunused_imports -Adead_code -C debuginfo=2 -C opt-level=1 -C force-frame-pointers=yes'
     ++  export RUSTFLAGS='-C debuginfo=2 -C opt-level=1 -C force-frame-pointers=yes'
      +else
     -+  echo "illegal rust_target value $rust_target"
     ++  echo "illegal rust_build_profile value $rust_build_profile"
      +  exit 1
      +fi
      +
     -+cd $dir_rust && cargo clean && pwd && cargo build -p $crate $rust_args; cd ..
     ++cd $dir_rust && cargo clean && pwd && cargo build -p $crate $rust_args; cd $dir_git_root
      +
      +libfile="lib${crate}.a"
     ++if rustup show active-toolchain | grep windows-msvc; then
     ++  libfile="${crate}.lib"
     ++fi
      +dst=$dir_build/$libfile
      +
      +if [ "$dir_git_root" != "$dir_build" ]; then
     -+  src=$dir_rust/target/$rust_target/$libfile
     ++  src=$dir_rust/target/$rust_build_profile/$libfile
      +  if [ ! -f $src ]; then
     -+    echo >&2 "::error:: cannot find path of static library"
     ++    echo >&2 "::error:: cannot find path of static library $src is not a file or does not exist"
      +    exit 5
      +  fi
      +
     @@ build_rust.sh (new)
      +  mv $src $dst
      +fi
      
     - ## ci/install-dependencies.sh ##
     -@@ ci/install-dependencies.sh: fi
     - 
     - case "$distro" in
     - alpine-*)
     --	apk add --update shadow sudo meson ninja-build gcc libc-dev curl-dev openssl-dev expat-dev gettext \
     -+	apk add --update shadow sudo meson ninja-build gcc libc-dev curl curl-dev openssl-dev expat-dev gettext \
     - 		zlib-ng-dev pcre2-dev python3 musl-libintl perl-utils ncurses \
     - 		apache2 apache2-http2 apache2-proxy apache2-ssl apache2-webdav apr-util-dbd_sqlite3 \
     - 		bash cvs gnupg perl-cgi perl-dbd-sqlite perl-io-tty >/dev/null
     - 	;;
     - fedora-*|almalinux-*)
     - 	dnf -yq update >/dev/null &&
     --	dnf -yq install shadow-utils sudo make gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
     -+	dnf -yq install shadow-utils sudo make gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl curl-devel pcre2-devel >/dev/null
     - 	;;
     - ubuntu-*|i386/ubuntu-*|debian-*)
     - 	# Required so that apt doesn't wait for user input on certain packages.
     -@@ ci/install-dependencies.sh: ubuntu-*|i386/ubuntu-*|debian-*)
     - 	sudo apt-get -q update
     - 	sudo apt-get -q -y install \
     - 		$LANGUAGES apache2 cvs cvsps git gnupg $SVN \
     --		make libssl-dev libcurl4-openssl-dev libexpat-dev wget sudo default-jre \
     --		tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl \
     -+		make libssl-dev curl libcurl4-openssl-dev libexpat-dev wget sudo default-jre \
     -+		tcl tk gettext zlib1g zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl \
     - 		libemail-valid-perl libio-pty-perl libio-socket-ssl-perl libnet-smtp-ssl-perl libdbd-sqlite3-perl libcgi-pm-perl \
     - 		libsecret-1-dev libpcre2-dev meson ninja-build pkg-config \
     - 		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE
     -@@ ci/install-dependencies.sh: ClangFormat)
     - 	;;
     - StaticAnalysis)
     - 	sudo apt-get -q update
     --	sudo apt-get -q -y install coccinelle libcurl4-openssl-dev libssl-dev \
     -+	sudo apt-get -q -y install coccinelle curl libcurl4-openssl-dev libssl-dev \
     - 		libexpat-dev gettext make
     - 	;;
     - sparse)
     - 	sudo apt-get -q update -q
     --	sudo apt-get -q -y install libssl-dev libcurl4-openssl-dev \
     --		libexpat-dev gettext zlib1g-dev sparse
     -+	sudo apt-get -q -y install libssl-dev curl libcurl4-openssl-dev \
     -+		libexpat-dev gettext zlib1g zlib1g-dev sparse
     - 	;;
     - Documentation)
     - 	sudo apt-get -q update
     + ## git-compat-util.h ##
     +@@ git-compat-util.h: static inline int is_xplatform_dir_sep(int c)
     + #include "compat/msvc.h"
     + #endif
     + 
     ++/* rust types */
     ++typedef uint8_t   u8;
     ++typedef uint16_t  u16;
     ++typedef uint32_t  u32;
     ++typedef uint64_t  u64;
     ++
     ++typedef int8_t    i8;
     ++typedef int16_t   i16;
     ++typedef int32_t   i32;
     ++typedef int64_t   i64;
     ++
     ++typedef float     f32;
     ++typedef double    f64;
     ++
     ++typedef size_t    usize;
     ++typedef ptrdiff_t isize;
     ++
     + /* used on Mac OS X */
     + #ifdef PRECOMPOSE_UNICODE
     + #include "compat/precompose_utf8.h"
      
     - ## ci/install-rust.sh (new) ##
     -@@
     -+#!/bin/sh
     -+
     -+if [ "$(id -u)" -eq 0 ]; then
     -+  echo >&2 "::warning:: installing rust as root"
     -+fi
     -+
     -+if [ "$CARGO_HOME" = "" ]; then
     -+  echo >&2 "::warning:: CARGO_HOME is not set"
     -+  export CARGO_HOME=$HOME/.cargo
     -+fi
     -+
     -+export RUSTUP_HOME=$CARGO_HOME
     -+
     -+if [ "$RUST_VERSION" = "" ]; then
     -+  echo >&2 "::error:: RUST_VERSION is not set"
     -+  exit 2
     -+fi
     -+
     -+## install rustup
     -+curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain none -y
     -+if [ ! -f $CARGO_HOME/env ]; then
     -+  echo "PATH=$CARGO_HOME/bin:\$PATH" > $CARGO_HOME/env
     -+fi
     -+## install a specific version of rust
     -+if [ "$BITNESS" = "32" ]; then
     -+  $CARGO_HOME/bin/rustup set default-host i686-unknown-linux-gnu || exit $?
     -+  $CARGO_HOME/bin/rustup install $RUST_VERSION || exit $?
     -+  $CARGO_HOME/bin/rustup default --force-non-host $RUST_VERSION || exit $?
     -+else
     -+  $CARGO_HOME/bin/rustup default $RUST_VERSION || exit $?
     -+fi
     -+
     -+. $CARGO_HOME/env
     -
     - ## ci/lib.sh ##
     -@@
     - # Library of functions shared by all CI scripts
     - 
     -+
     -+export BITNESS="64"
     -+if command -v getconf >/dev/null && [ "$(getconf LONG_BIT 2>/dev/null)" = "32" ]; then
     -+  export BITNESS="32"
     -+fi
     -+echo "BITNESS=$BITNESS"
     -+
     -+
     - if test true = "$GITHUB_ACTIONS"
     - then
     - 	begin_group () {
     -
     - ## ci/make-test-artifacts.sh ##
     -@@ ci/make-test-artifacts.sh: mkdir -p "$1" # in case ci/lib.sh decides to quit early
     - 
     - . ${0%/*}/lib.sh
     - 
     -+## install rust per user rather than system wide
     -+. ${0%/*}/install-rust.sh
     -+
     - group Build make artifacts-tar ARTIFACTS_DIRECTORY="$1"
     - 
     -+if [ -d "$CARGO_HOME" ]; then
     -+  rm -rf $CARGO_HOME
     -+fi
     -+
     - check_unignored_build_artifacts
     -
     - ## ci/run-build-and-tests.sh ##
     -@@
     - 
     - . ${0%/*}/lib.sh
     + ## meson.build ##
     +@@ meson.build: version_gen_environment.set('GIT_DATE', get_option('build_date'))
     + version_gen_environment.set('GIT_USER_AGENT', get_option('user_agent'))
     + version_gen_environment.set('GIT_VERSION', get_option('version'))
       
     -+## install rust per user rather than system wide
     -+. ${0%/*}/install-rust.sh
     ++if get_option('optimization') in ['2', '3', 's', 'z']
     ++  rust_build_profile = 'release'
     ++else
     ++  rust_build_profile = 'debug'
     ++endif
      +
     -+rustc -vV
     -+cargo --version || exit $?
     ++# Run `rustup show active-toolchain` and capture output
     ++rustup_out = run_command('rustup', 'show', 'active-toolchain',
     ++                         check: true).stdout().strip()
     ++
     ++rust_crates = ['xdiff']
     ++rust_builds = []
     ++
     ++foreach crate : rust_crates
     ++  if rustup_out.contains('windows-msvc')
     ++    libfile = crate + '.lib'
     ++  else
     ++    libfile = 'lib' + crate + '.a'
     ++  endif
     ++
     ++  rust_builds += custom_target(
     ++    'rust_build_'+crate,
     ++    output: libfile,
     ++    build_by_default: true,
     ++    build_always_stale: true,
     ++    command: [
     ++      meson.project_source_root() / 'build_rust.sh',
     ++      meson.current_build_dir(), rust_build_profile, crate,
     ++    ],
     ++    install: false,
     ++  )
     ++endforeach
      +
     - run_tests=t
     - 
     - case "$jobname" in
     -@@ ci/run-build-and-tests.sh: case "$jobname" in
     - 	;;
     - esac
     - 
     -+if [ -d "$CARGO_HOME" ]; then
     -+  rm -rf $CARGO_HOME
     -+fi
      +
     - check_unignored_build_artifacts
     - save_good_tree
     -
     - ## meson.build ##
     -@@ meson.build: else
     -   rustflags = '-Aunused_imports -Adead_code -C debuginfo=2 -C opt-level=1 -C force-frame-pointers=yes'
     - endif
     - 
     --
     --rust_leaf = custom_target('rust_leaf',
     -+rust_build_xdiff = custom_target('rust_build_xdiff',
     -   output: 'libxdiff.a',
     -   build_by_default: true,
     -   build_always_stale: true,
     --  command: ['cargo', 'build',
     --            '--manifest-path', meson.project_source_root() / 'rust/Cargo.toml'
     --  ] + rust_args,
     --  env: {
     --    'RUSTFLAGS': rustflags,
     --  },
     -+  command: [
     -+    meson.project_source_root() / 'build_rust.sh',
     -+    meson.current_build_dir(), rust_target, 'xdiff',
     -+  ],
     -   install: false,
     - )
     - 
     --rust_xdiff_dep = declare_dependency(
     --  link_args: ['-L' + meson.project_source_root() / 'rust/target' / rust_target, '-lxdiff'],
     --#  include_directories: include_directories('xdiff/include'),  # Adjust if you expose headers
     --)
     --
     --
       compiler = meson.get_compiler('c')
       
       libgit_sources = [
      @@ meson.build: version_def_h = custom_target(
     - )
       libgit_sources += version_def_h
       
     --libgit_dependencies += rust_xdiff_dep
     --
       libgit = declare_dependency(
      -  link_with: static_library('git',
      -    sources: libgit_sources,
     @@ meson.build: version_def_h = custom_target(
      +      dependencies: libgit_dependencies,
      +      include_directories: libgit_include_directories,
      +    ),
     -+    rust_build_xdiff,
     -+  ],
     ++  ] + rust_builds,
         compile_args: libgit_c_args,
         dependencies: libgit_dependencies,
         include_directories: libgit_include_directories,
     +
     + ## rust/Cargo.toml (new) ##
     +@@
     ++[workspace]
     ++members = [
     ++    "xdiff",
     ++    "interop",
     ++]
     ++resolver = "2"
     +
     + ## rust/interop/Cargo.toml (new) ##
     +@@
     ++[package]
     ++name = "interop"
     ++version = "0.1.0"
     ++edition = "2021"
     ++
     ++[lib]
     ++name = "interop"
     ++path = "src/lib.rs"
     ++## staticlib to generate xdiff.a for use by gcc
     ++## cdylib (optional) to generate xdiff.so for use by gcc
     ++## rlib is required by the rust unit tests
     ++crate-type = ["staticlib", "rlib"]
     ++
     ++[dependencies]
     +
     + ## rust/interop/src/lib.rs (new) ##
     +
     + ## rust/xdiff/Cargo.toml (new) ##
     +@@
     ++[package]
     ++name = "xdiff"
     ++version = "0.1.0"
     ++edition = "2021"
     ++
     ++[lib]
     ++name = "xdiff"
     ++path = "src/lib.rs"
     ++## staticlib to generate xdiff.a for use by gcc
     ++## cdylib (optional) to generate xdiff.so for use by gcc
     ++## rlib is required by the rust unit tests
     ++crate-type = ["staticlib", "rlib"]
     ++
     ++[dependencies]
     ++interop = { path = "../interop" }
     +
     + ## rust/xdiff/src/lib.rs (new) ##
 12:  fffdb326710 !  3:  a98d9e4d21b github workflows: define rust versions and targets in the same place
     @@ Metadata
      Author: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## Commit message ##
     -    github workflows: define rust versions and targets in the same place
     +    github workflows: install rust
      
     -    Consolidate the Rust toolchain definitions in main.yaml. Prefer using
     -    actions-rs/toolchain@v1 where possible, but for docker targets use
     -    a script to install the Rust toolchain. Four overrides are used in
     +    Prefer using actions-rs/toolchain@v1 where possible to install rustup,
     +    but for docker targets use a script to install rustup. Consolidate the
     +    Rust toolchain definitions in main.yaml. Use install-rust-toolchain.sh
     +    to ensure the correct toolchain is used. Five overrides are used in
          main.yaml:
      
            * On Windows: Rust didn't resolve the bcrypt library on Windows
              correctly until version 1.78.0. Also since rustup mis-identifies
              the Rust toolchain, the Rust target triple must be set to
     -        x86_64-pc-windows-gnu.
     +        x86_64-pc-windows-gnu for make (win build), and
     +        x86_64-pc-windows-msvc for meson (win+Meson build).
            * On musl: libc differences, such as ftruncate64 vs ftruncate, were
              not accounted for until Rust version 1.72.0. No older version of
              Rust will work on musl for our needs.
            * In a 32-bit docker container running on a 64-bit host, we need to
              override the Rust target triple. This is because rustup asks the
              kernel for the bitness of the system and it says 64, even though
     -        the container will only run 32-bit. This also allows us to remove
     -        the BITNESS environment variable in ci/lib.sh.
     +        the container is 32-bit. This also allows us to remove the
     +        BITNESS environment variable in ci/lib.sh.
      
     +    The logic for selecting library names was initially provided in a patch
     +    from Johannes, but was reworked and squashed into this commit.
     +
     +    Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## .github/workflows/main.yml ##
     -@@ .github/workflows/main.yml: on: [push, pull_request]
     - 
     - env:
     -   DEVELOPER: 1
     --  RUST_VERSION: 1.87.0
     - 
     - # If more than one workflow run is triggered for the very same commit hash
     - # (which happens when multiple branches pointing to the same commit), only
      @@ .github/workflows/main.yml: jobs:
           outputs:
             enabled: ${{ steps.check-ref.outputs.enabled }}${{ steps.skip-if-redundant.outputs.enabled }}
     @@ .github/workflows/main.yml: jobs:
      +      rust_version_windows: 1.78.0
      +      rust_version_musl: 1.72.0
      +      ## the rust target is inferred by rustup unless specified
     -+      rust_target_windows: x86_64-pc-windows-gnu
     ++      rust_target_windows_make: x86_64-pc-windows-gnu
     ++      rust_target_windows_meson: x86_64-pc-windows-msvc
      +      rust_target_32bit_linux: i686-unknown-linux-gnu
           steps:
             - name: try to clone ci-config branch
               run: |
      @@ .github/workflows/main.yml: jobs:
     -           /c/Program\ Files/Git/mingw64/bin/curl -Lo libuserenv.a \
     -             https://github.com/git-for-windows/git-sdk-64/raw/HEAD/mingw64/lib/libuserenv.a
     -         }
     -+    - name: Install Rust
     +     needs: ci-config
     +     if: needs.ci-config.outputs.enabled == 'yes'
     +     runs-on: windows-latest
     ++    env:
     ++      CARGO_HOME: "/c/Users/runneradmin/.cargo"
     +     concurrency:
     +       group: windows-build-${{ github.ref }}
     +       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     +     steps:
     +     - uses: actions/checkout@v4
     +     - uses: git-for-windows/setup-git-for-windows-sdk@v1
     ++    - name: Install rustup via github actions
      +      uses: actions-rs/toolchain@v1
      +      with:
     -+        toolchain: ${{ needs.ci-config.outputs.rust_version_windows }}
     -+        target: ${{ needs.ci-config.outputs.rust_target_windows }}
     ++        toolchain: stable
      +        profile: minimal
     -+        override: true
     ++        override: false
     ++    - name: Install Rust toolchain
     ++      shell: bash
     ++      env:
     ++        RUST_VERSION: ${{ needs.ci-config.outputs.rust_version_windows }}
     ++        RUST_TARGET: ${{ needs.ci-config.outputs.rust_target_windows_make }}
     ++      run: ci/install-rust-toolchain.sh
           - name: build
             shell: bash
             env:
     -         HOME: ${{runner.workspace}}
     -         NO_PERL: 1
     -+        CARGO_HOME: "/c/Users/runneradmin/.cargo"
     -       run: . /etc/profile && ci/make-test-artifacts.sh artifacts
     -     - name: zip up tracked files
     -       run: git archive -o artifacts/tracked.tar.gz HEAD
      @@ .github/workflows/main.yml: jobs:
     +     needs: ci-config
     +     if: needs.ci-config.outputs.enabled == 'yes'
     +     runs-on: windows-latest
     ++    env:
     ++      CARGO_HOME: "/c/Users/runneradmin/.cargo"
     +     concurrency:
     +       group: windows-meson-build-${{ github.ref }}
     +       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
           steps:
           - uses: actions/checkout@v4
           - uses: actions/setup-python@v5
     -+    - name: Install Rust
     ++    - name: Install rustup via github actions
      +      uses: actions-rs/toolchain@v1
      +      with:
     -+        toolchain: ${{ needs.ci-config.outputs.rust_version_windows }}
     -+        target: ${{ needs.ci-config.outputs.rust_target_windows }}
     ++        toolchain: stable
      +        profile: minimal
     -+        override: true
     ++        override: false
     ++    - name: Install Rust toolchain
     ++      shell: bash
     ++      env:
     ++        RUST_VERSION: ${{ needs.ci-config.outputs.rust_version_windows }}
     ++        RUST_TARGET: ${{ needs.ci-config.outputs.rust_target_windows_meson }}
     ++      run: ci/install-rust-toolchain.sh
           - name: Set up dependencies
             shell: pwsh
             run: pip install meson ninja
      @@ .github/workflows/main.yml: jobs:
     +       jobname: ${{matrix.vector.jobname}}
     +       CI_JOB_IMAGE: ${{matrix.vector.pool}}
     +       TEST_OUTPUT_DIRECTORY: ${{github.workspace}}/t
     ++      CARGO_HOME: "/Users/runner/.cargo"
     +     runs-on: ${{matrix.vector.pool}}
           steps:
           - uses: actions/checkout@v4
           - run: ci/install-dependencies.sh
     -+    - name: Install Rust
     +-    - run: ci/run-build-and-tests.sh
     ++    - name: Install rustup via github actions
      +      uses: actions-rs/toolchain@v1
      +      with:
     -+        toolchain: ${{ needs.ci-config.outputs.rust_version_minimum }}
     ++        toolchain: stable
      +        profile: minimal
     -+        override: true
     -     - run: ci/run-build-and-tests.sh
     ++        override: false
     ++    - name: Install Rust toolchain
     ++      shell: bash
     ++      env:
     ++        RUST_VERSION: ${{ needs.ci-config.outputs.rust_version_minimum }}
     ++      run: ci/install-rust-toolchain.sh
     ++    - name: Run build and tests
     ++      run: ci/run-build-and-tests.sh
           - name: print test failures
             if: failure() && env.FAILED_TEST_ARTIFACTS != ''
     +       run: ci/print-test-failures.sh
      @@ .github/workflows/main.yml: jobs:
                 cc: gcc
               - jobname: linux-musl-meson
     @@ .github/workflows/main.yml: jobs:
             CI_JOB_IMAGE: ${{matrix.vector.image}}
      +      CI_IS_DOCKER: "true"
             CUSTOM_PATH: /custom
     -+      RUST_VERSION: ${{ matrix.vector.rust_version_override || needs.ci-config.outputs.rust_version_minimum }}
     -+      RUST_TARGET: ${{ matrix.vector.rust_target_override || '' }}
      +      CARGO_HOME: /home/builder/.cargo
           runs-on: ubuntu-latest
           container: ${{matrix.vector.image}}
           steps:
     +@@ .github/workflows/main.yml: jobs:
     +     - run: ci/install-dependencies.sh
     +     - run: useradd builder --create-home
     +     - run: chown -R builder .
     ++    - name: Install rustup via script
     ++      run: sudo --preserve-env --set-home --user=builder ci/install-rustup.sh
     ++    - name: Install Rust toolchain
     ++      env:
     ++        RUST_VERSION: ${{ matrix.vector.rust_version_override || needs.ci-config.outputs.rust_version_minimum }}
     ++        RUST_TARGET: ${{ matrix.vector.rust_target_override || '' }}
     ++      run: sudo --preserve-env --set-home --user=builder ci/install-rust-toolchain.sh
     +     - run: sudo --preserve-env --set-home --user=builder ci/run-build-and-tests.sh
     +     - name: print test failures
     +       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
      
     - ## build_rust.sh ##
     -@@
     - #!/bin/sh
     - 
     --if [ -z "$CARGO_HOME" ]; then
     --  export CARGO_HOME=$HOME/.cargo
     --  echo >&2 "::warning:: CARGO_HOME is not set"
     --fi
     --echo "CARGO_HOME=$CARGO_HOME"
     + ## ci/install-dependencies.sh ##
     +@@ ci/install-dependencies.sh: fi
       
     --rustc -vV
     --cargo --version
     + case "$distro" in
     + alpine-*)
     +-	apk add --update shadow sudo meson ninja-build gcc libc-dev curl-dev openssl-dev expat-dev gettext \
     ++	apk add --update shadow sudo meson ninja-build gcc libc-dev curl curl-dev openssl-dev expat-dev gettext \
     + 		zlib-ng-dev pcre2-dev python3 musl-libintl perl-utils ncurses \
     + 		apache2 apache2-http2 apache2-proxy apache2-ssl apache2-webdav apr-util-dbd_sqlite3 \
     + 		bash cvs gnupg perl-cgi perl-dbd-sqlite perl-io-tty >/dev/null
     + 	;;
     + fedora-*|almalinux-*)
     + 	dnf -yq update >/dev/null &&
     +-	dnf -yq install shadow-utils sudo make gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
     ++	dnf -yq install shadow-utils sudo make gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl curl-devel pcre2-devel >/dev/null
     + 	;;
     + ubuntu-*|i386/ubuntu-*|debian-*)
     + 	# Required so that apt doesn't wait for user input on certain packages.
     +@@ ci/install-dependencies.sh: ubuntu-*|i386/ubuntu-*|debian-*)
     + 	sudo apt-get -q update
     + 	sudo apt-get -q -y install \
     + 		$LANGUAGES apache2 cvs cvsps git gnupg $SVN \
     +-		make libssl-dev libcurl4-openssl-dev libexpat-dev wget sudo default-jre \
     +-		tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl \
     ++		make libssl-dev curl libcurl4-openssl-dev libexpat-dev wget sudo default-jre \
     ++		tcl tk gettext zlib1g zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl \
     + 		libemail-valid-perl libio-pty-perl libio-socket-ssl-perl libnet-smtp-ssl-perl libdbd-sqlite3-perl libcgi-pm-perl \
     + 		libsecret-1-dev libpcre2-dev meson ninja-build pkg-config \
     + 		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE
     +@@ ci/install-dependencies.sh: ClangFormat)
     + 	;;
     + StaticAnalysis)
     + 	sudo apt-get -q update
     +-	sudo apt-get -q -y install coccinelle libcurl4-openssl-dev libssl-dev \
     ++	sudo apt-get -q -y install coccinelle curl libcurl4-openssl-dev libssl-dev \
     + 		libexpat-dev gettext make
     + 	;;
     + sparse)
     + 	sudo apt-get -q update -q
     +-	sudo apt-get -q -y install libssl-dev libcurl4-openssl-dev \
     +-		libexpat-dev gettext zlib1g-dev sparse
     ++	sudo apt-get -q -y install libssl-dev curl libcurl4-openssl-dev \
     ++		libexpat-dev gettext zlib1g zlib1g-dev sparse
     + 	;;
     + Documentation)
     + 	sudo apt-get -q update
     +
     + ## ci/install-rust-toolchain.sh (new) ##
     +@@
     ++#!/bin/sh
     ++
     ++if [ "$CARGO_HOME" = "" ]; then
     ++  echo >&2 "::error:: CARGO_HOME is not set"
     ++  exit 2
     ++fi
     ++export PATH="$CARGO_HOME/bin:$PATH"
     ++rustup -vV || exit $?
     ++
     ++## Enforce the correct Rust toolchain
     ++rustup override unset || true
     ++
     ++## install a specific version of rust
     ++if [ "$RUST_TARGET" != "" ]; then
     ++  rustup default --force-non-host "$RUST_VERSION-$RUST_TARGET" || exit $?
     ++else
     ++  rustup default "$RUST_VERSION" || exit $?
     ++fi
     ++
      +rustc -vV || exit $?
     -+cargo --version || exit $?
     - 
     - dir_git_root=${0%/*}
     - dir_build=$1
     -@@ build_rust.sh: dst=$dir_build/$libfile
     - if [ "$dir_git_root" != "$dir_build" ]; then
     -   src=$dir_rust/target/$rust_target/$libfile
     -   if [ ! -f $src ]; then
     --    echo >&2 "::error:: cannot find path of static library"
     -+    echo >&2 "::error:: cannot find path of static library $src is not a file or does not exist"
     -     exit 5
     -   fi
     - 
     ++
     ++RE_RUST_TARGET="$RUST_TARGET"
     ++if [ "$RUST_TARGET" = "" ]; then
     ++  RE_RUST_TARGET="[^ ]+"
     ++fi
     ++
     ++if ! rustup show active-toolchain | grep -E "^$RUST_VERSION-$RE_RUST_TARGET \(default\)$"; then
     ++  echo >&2 "::error:: wrong Rust toolchain, active-toolchain: $(rustup show active-toolchain)"
     ++  exit 3
     ++fi
      
     - ## ci/install-rust.sh (mode change 100644 => 100755) ##
     + ## ci/install-rustup.sh (new) ##
      @@
     - #!/bin/sh
     - 
     ++#!/bin/sh
     ++
      +## github workflows actions-rs/toolchain@v1 doesn't work for docker
      +## targets. This script should only be used if the ci pipeline
      +## doesn't support installing rust on a particular target.
      +
     - if [ "$(id -u)" -eq 0 ]; then
     -   echo >&2 "::warning:: installing rust as root"
     - fi
     - 
     --if [ "$CARGO_HOME" = "" ]; then
     --  echo >&2 "::warning:: CARGO_HOME is not set"
     --  export CARGO_HOME=$HOME/.cargo
     --fi
     --
     --export RUSTUP_HOME=$CARGO_HOME
     --
     - if [ "$RUST_VERSION" = "" ]; then
     -   echo >&2 "::error:: RUST_VERSION is not set"
     -+  exit 1
     ++if [ "$(id -u)" -eq 0 ]; then
     ++  echo >&2 "::warning:: installing rust as root"
      +fi
      +
      +if [ "$CARGO_HOME" = "" ]; then
      +  echo >&2 "::error:: CARGO_HOME is not set"
     -   exit 2
     - fi
     - 
     ++  exit 2
     ++fi
     ++
      +export RUSTUP_HOME=$CARGO_HOME
      +
     - ## install rustup
     - curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain none -y
     - if [ ! -f $CARGO_HOME/env ]; then
     -   echo "PATH=$CARGO_HOME/bin:\$PATH" > $CARGO_HOME/env
     - fi
     ++## install rustup
     ++curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain none -y
     ++if [ ! -f $CARGO_HOME/env ]; then
     ++  echo "PATH=$CARGO_HOME/bin:\$PATH" > $CARGO_HOME/env
     ++fi
      +. $CARGO_HOME/env
      +
     - ## install a specific version of rust
     --if [ "$BITNESS" = "32" ]; then
     --  $CARGO_HOME/bin/rustup set default-host i686-unknown-linux-gnu || exit $?
     --  $CARGO_HOME/bin/rustup install $RUST_VERSION || exit $?
     --  $CARGO_HOME/bin/rustup default --force-non-host $RUST_VERSION || exit $?
     -+if [ "$RUST_TARGET" != "" ]; then
     -+  rustup default --force-non-host "$RUST_VERSION-$RUST_TARGET" || exit $?
     - else
     --  $CARGO_HOME/bin/rustup default $RUST_VERSION || exit $?
     --  if [ "$CI_OS_NAME" = "windows" ]; then
     --    $CARGO_HOME/bin/rustup target add x86_64-pc-windows-gnu || exit $?
     --  fi
     -+  rustup default "$RUST_VERSION" || exit $?
     - fi
     - 
     --. $CARGO_HOME/env
     -+rustc -vV || exit $?
     ++rustup -vV
      
       ## ci/lib.sh ##
      @@
       # Library of functions shared by all CI scripts
       
     - 
     --export BITNESS="64"
     --if command -v getconf >/dev/null && [ "$(getconf LONG_BIT 2>/dev/null)" = "32" ]; then
     --  export BITNESS="32"
     --fi
     --echo "BITNESS=$BITNESS"
     --
     --
     ++
       if test true = "$GITHUB_ACTIONS"
       then
       	begin_group () {
     @@ ci/make-test-artifacts.sh: mkdir -p "$1" # in case ci/lib.sh decides to quit ear
       
       . ${0%/*}/lib.sh
       
     --## install rust per user rather than system wide
     --. ${0%/*}/install-rust.sh
     -+if [ -z "$CARGO_HOME" ]; then
     ++## ensure rustup is in the PATH variable
     ++if [ "$CARGO_HOME" = "" ]; then
      +  echo >&2 "::error:: CARGO_HOME is not set"
     -+  exit 1
     ++  exit 2
      +fi
     - 
     --group Build make artifacts-tar ARTIFACTS_DIRECTORY="$1"
      +export PATH="$CARGO_HOME/bin:$PATH"
     - 
     --if [ -d "$CARGO_HOME" ]; then
     --  rm -rf $CARGO_HOME
     --fi
     -+group Build make artifacts-tar ARTIFACTS_DIRECTORY="$1"
     ++
     ++rustc -vV
     ++
     + group Build make artifacts-tar ARTIFACTS_DIRECTORY="$1"
       
       check_unignored_build_artifacts
      
     @@ ci/run-build-and-tests.sh
       
       . ${0%/*}/lib.sh
       
     --## install rust per user rather than system wide
     --. ${0%/*}/install-rust.sh
     -+## actions-rs/toolchain@v1 doesn't work for docker targets.
     -+if [ "$CI_IS_DOCKER" = "true" ]; then
     -+  . ${0%/*}/install-rust.sh
     ++## ensure rustup is in the PATH variable
     ++if [ "$CARGO_HOME" = "" ]; then
     ++  echo >&2 "::error:: CARGO_HOME is not set"
     ++  exit 2
      +fi
     - 
     --rustc -vV
     ++. $CARGO_HOME/env
     ++
      +rustc -vV || exit $?
     - cargo --version || exit $?
     - 
     ++
       run_tests=t
     -
     - ## meson.build ##
     -@@ meson.build: rust_build_xdiff = custom_target('rust_build_xdiff',
     -     meson.project_source_root() / 'build_rust.sh',
     -     meson.current_build_dir(), rust_target, 'xdiff',
     -   ],
     -+  env: script_environment,
     -   install: false,
     - )
       
     + case "$jobname" in
     +@@ ci/run-build-and-tests.sh: case "$jobname" in
     + 	;;
     + esac
     + 
     ++if [ -d "$CARGO_HOME" ]; then
     ++  rm -rf $CARGO_HOME
     ++fi
     ++
     + check_unignored_build_artifacts
     + save_good_tree
 11:  382067a09e3 !  4:  0d2b39c3e03 win+Meson: do allow linking with the Rust-built xdiff
     @@ .github/workflows/main.yml: jobs:
      +          /c/Program\ Files/Git/mingw64/bin/curl -Lo libuserenv.a \
      +            https://github.com/git-for-windows/git-sdk-64/raw/HEAD/mingw64/lib/libuserenv.a
      +        }
     -     - name: build
     -       shell: bash
     -       env:
     +     - name: Install rustup via github actions
     +       uses: actions-rs/toolchain@v1
     +       with:
      
       ## config.mak.uname ##
      @@ config.mak.uname: ifeq ($(uname_S),MINGW)
     - 
     - 	export CARGO_BUILD_TARGET
     - 	RUST_TARGET_DIR = rust/target/$(CARGO_BUILD_TARGET)/$(RUST_BUILD_MODE)
     + 		COMPAT_CFLAGS += -D_USE_32BIT_TIME_T
     + 		BASIC_LDFLAGS += -Wl,--large-address-aware
     +         endif
     ++
      +	# Unfortunately now needed because of Rust
      +	EXTLIBS += -luserenv
     - 
     ++
       	CC = gcc
       	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
     + 		-fstack-protector-strong
      
       ## meson.build ##
      @@ meson.build: elif host_machine.system() == 'windows'
 13:  44784f0d672 =  5:  e65488ab993 github workflows: upload Cargo.lock
  -:  ----------- >  6:  db5d22b1887 ivec: create a vector type that is interoperable between C and Rust
  3:  56c96d35554 =  7:  d4bed954632 xdiff/xprepare: remove superfluous forward declarations
  4:  ebec3689dce =  8:  7c68ce5349c xdiff: delete unnecessary fields from xrecord_t and xdfile_t
  5:  769d1a5b9d2 =  9:  e516ccc8c0a xdiff: make fields of xrecord_t Rust friendly
  6:  87623495994 ! 10:  21bfb9f0883 xdiff: separate parsing lines from hashing them
     @@ Metadata
      Author: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## Commit message ##
     -    xdiff: separate parsing lines from hashing them
     +    xdiff: use one definition for freeing xdfile_t
      
     -    We want to use xxhash for faster hashing. To facilitate that
     -    and to simplify the code. Separate the concerns of parsing
     -    and hashing into discrete steps. This makes swapping the hash
     -    function much easier. Since xdl_hash_record() both parses and
     -    hashses lines, this requires some slight code restructuring.
     +    Simplify xdl_prepare_ctx() by using xdl_free_ctx() instead of using
     +    local variables with hand rolled memory management.
      
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
     @@ xdiff/xprepare.c: static int xdl_classify_record(unsigned int pass, xdlclassifie
       }
       
       
     -+static void xdl_parse_lines(mmfile_t *mf, long narec, xdfile_t *xdf) {
     -+	u8 const* ptr = (u8 const*) mf->ptr;
     -+	usize len = (usize) mf->size;
     -+
     -+	xdf->recs = NULL;
     -+	xdf->nrec = 0;
     -+	XDL_ALLOC_ARRAY(xdf->recs, narec);
     -+
     -+	while (len > 0) {
     -+		xrecord_t *rec = NULL;
     -+		usize length;
     -+		u8 const* result = memchr(ptr, '\n', len);
     -+		if (result) {
     -+			length = result - ptr + 1;
     -+		} else {
     -+			length = len;
     -+		}
     -+		if (XDL_ALLOC_GROW(xdf->recs, xdf->nrec + 1, narec))
     -+			die("XDL_ALLOC_GROW failed");
     -+		rec = xdl_cha_alloc(&xdf->rcha);
     -+		rec->ptr = ptr;
     -+		rec->size = length;
     -+		rec->ha = 0;
     -+		xdf->recs[xdf->nrec++] = rec;
     -+		ptr += length;
     -+		len -= length;
     -+	}
     -+
     ++static void xdl_free_ctx(xdfile_t *xdf) {
     ++	xdl_free(xdf->rindex);
     ++	xdl_free(xdf->rchg - 1);
     ++	xdl_free(xdf->ha);
     ++	xdl_free(xdf->recs);
     ++	xdl_cha_free(&xdf->rcha);
      +}
      +
      +
       static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_t const *xpp,
       			   xdlclassifier_t *cf, xdfile_t *xdf) {
      -	long nrec, bsize;
     --	unsigned long hav;
     --	char const *blk, *cur, *top, *prev;
     --	xrecord_t *crec;
     ++	long bsize;
     + 	unsigned long hav;
     + 	char const *blk, *cur, *top, *prev;
     + 	xrecord_t *crec;
      -	xrecord_t **recs;
     - 	unsigned long *ha;
     - 	char *rchg;
     - 	long *rindex;
     -@@ xdiff/xprepare.c: static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
     - 	ha = NULL;
     - 	rindex = NULL;
     - 	rchg = NULL;
     +-	unsigned long *ha;
     +-	char *rchg;
     +-	long *rindex;
     + 
     +-	ha = NULL;
     +-	rindex = NULL;
     +-	rchg = NULL;
      -	recs = NULL;
     ++	xdf->ha = NULL;
     ++	xdf->rindex = NULL;
     ++	xdf->rchg = NULL;
     ++	xdf->recs = NULL;
     ++	xdf->nrec = 0;
       
       	if (xdl_cha_init(&xdf->rcha, sizeof(xrecord_t), narec / 4 + 1) < 0)
       		goto abort;
      -	if (!XDL_ALLOC_ARRAY(recs, narec))
     --		goto abort;
     ++	if (!XDL_ALLOC_ARRAY(xdf->recs, narec))
     + 		goto abort;
       
      -	nrec = 0;
     --	if ((cur = blk = xdl_mmfile_first(mf, &bsize))) {
     --		for (top = blk + bsize; cur < top; ) {
     --			prev = cur;
     --			hav = xdl_hash_record(&cur, top, xpp->flags);
     + 	if ((cur = blk = xdl_mmfile_first(mf, &bsize))) {
     + 		for (top = blk + bsize; cur < top; ) {
     + 			prev = cur;
     + 			hav = xdl_hash_record(&cur, top, xpp->flags);
      -			if (XDL_ALLOC_GROW(recs, nrec + 1, narec))
     --				goto abort;
     --			if (!(crec = xdl_cha_alloc(&xdf->rcha)))
     --				goto abort;
     --			crec->ptr = (u8 const*) prev;
     --			crec->size = (long) (cur - prev);
     --			crec->ha = hav;
     ++			if (XDL_ALLOC_GROW(xdf->recs, xdf->nrec + 1, narec))
     + 				goto abort;
     + 			if (!(crec = xdl_cha_alloc(&xdf->rcha)))
     + 				goto abort;
     + 			crec->ptr = (u8 const*) prev;
     + 			crec->size = (long) (cur - prev);
     + 			crec->ha = hav;
      -			recs[nrec++] = crec;
     --			if (xdl_classify_record(pass, cf, crec) < 0)
     --				goto abort;
     --		}
     -+	xdl_parse_lines(mf, narec, xdf);
     -+
     -+	for (usize i = 0; i < (usize) xdf->nrec; i++) {
     -+		xrecord_t *rec = xdf->recs[i];
     -+		char const* dump = (char const*) rec->ptr;
     -+		rec->ha = xdl_hash_record(&dump, (char const*) (rec->ptr + rec->size), xpp->flags);
     -+		xdl_classify_record(pass, cf, rec);
     ++			xdf->recs[xdf->nrec++] = crec;
     + 			if (xdl_classify_record(pass, cf, crec) < 0)
     + 				goto abort;
     + 		}
       	}
       
      -	if (!XDL_CALLOC_ARRAY(rchg, nrec + 2))
     -+
     -+	if (!XDL_CALLOC_ARRAY(rchg, xdf->nrec + 2))
     ++	if (!XDL_CALLOC_ARRAY(xdf->rchg, xdf->nrec + 2))
       		goto abort;
       
       	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
       	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF)) {
      -		if (!XDL_ALLOC_ARRAY(rindex, nrec + 1))
     -+		if (!XDL_ALLOC_ARRAY(rindex, xdf->nrec + 1))
     ++		if (!XDL_ALLOC_ARRAY(xdf->rindex, xdf->nrec + 1))
       			goto abort;
      -		if (!XDL_ALLOC_ARRAY(ha, nrec + 1))
     -+		if (!XDL_ALLOC_ARRAY(ha, xdf->nrec + 1))
     ++		if (!XDL_ALLOC_ARRAY(xdf->ha, xdf->nrec + 1))
       			goto abort;
       	}
       
      -	xdf->nrec = nrec;
      -	xdf->recs = recs;
     - 	xdf->rchg = rchg + 1;
     - 	xdf->rindex = rindex;
     +-	xdf->rchg = rchg + 1;
     +-	xdf->rindex = rindex;
     ++	xdf->rchg += 1;
       	xdf->nreff = 0;
     - 	xdf->ha = ha;
     +-	xdf->ha = ha;
       	xdf->dstart = 0;
      -	xdf->dend = nrec - 1;
      +	xdf->dend = xdf->nrec - 1;
       
       	return 0;
       
     -@@ xdiff/xprepare.c: abort:
     - 	xdl_free(ha);
     - 	xdl_free(rindex);
     - 	xdl_free(rchg);
     + abort:
     +-	xdl_free(ha);
     +-	xdl_free(rindex);
     +-	xdl_free(rchg);
      -	xdl_free(recs);
     -+	xdl_free(xdf->recs);
     - 	xdl_cha_free(&xdf->rcha);
     +-	xdl_cha_free(&xdf->rcha);
     ++	xdl_free_ctx(xdf);
       	return -1;
       }
     + 
     + 
     +-static void xdl_free_ctx(xdfile_t *xdf) {
     +-	xdl_free(xdf->rindex);
     +-	xdl_free(xdf->rchg - 1);
     +-	xdl_free(xdf->ha);
     +-	xdl_free(xdf->recs);
     +-	xdl_cha_free(&xdf->rcha);
     +-}
     +-
     +-
     + void xdl_free_env(xdfenv_t *xe) {
     + 
     + 	xdl_free_ctx(&xe->xdf2);
  7:  d74fd4ef67a <  -:  ----------- xdiff: conditionally use Rust's implementation of xxhash
  9:  96041a10d54 <  -:  ----------- Do support Windows again after requiring Rust
 10:  1194de3f39c <  -:  ----------- win+Meson: allow for xdiff to be compiled with MSVC
 14:  f20efdff7aa <  -:  ----------- xdiff: implement a white space iterator in Rust
  -:  ----------- > 11:  6ce0e252b38 xdiff: replace chastore with an ivec in xdfile_t
  -:  ----------- > 12:  0cfc6cf26b7 xdiff: delete nrec field from xdfile_t
  -:  ----------- > 13:  cf0387d851c xdiff: delete recs field from xdfile_t
  -:  ----------- > 14:  ea699135f95 xdiff: make xdfile_t more rust friendly
 15:  c8d41173274 ! 15:  b18544b74f3 xdiff: create line_hash() and line_equal()
     @@ Metadata
      Author: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## Commit message ##
     -    xdiff: create line_hash() and line_equal()
     +    xdiff: implement xdl_trim_ends() in Rust
      
     -    These functions use the whitespace iterator, when applicable, to hash,
     -    and compare lines.
     +    Replace the C implementation of xdl_trim_ends() with a Rust
     +    implementation.
      
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## rust/xdiff/src/lib.rs ##
      @@
     -+use std::hash::Hasher;
     -+use xxhash_rust::xxh3::Xxh3Default;
     -+use crate::xutils::*;
     -+
     - pub mod xutils;
     ++pub mod xprepare;
     ++pub mod xtypes;
       
     - pub const XDF_IGNORE_WHITESPACE: u64 = 1 << 1;
     -@@ rust/xdiff/src/lib.rs: unsafe extern "C" fn xxh3_64(ptr: *const u8, size: usize) -> u64 {
     -     let slice = std::slice::from_raw_parts(ptr, size);
     -     xxhash_rust::xxh3::xxh3_64(slice)
     - }
     ++use crate::xprepare::trim_ends;
     ++use crate::xtypes::xdfile;
      +
      +#[no_mangle]
     -+unsafe extern "C" fn xdl_line_hash(ptr: *const u8, size: usize, flags: u64) -> u64 {
     -+    let line = std::slice::from_raw_parts(ptr, size);
     -+
     -+    line_hash(line, flags)
     -+}
     ++unsafe extern "C" fn xdl_trim_ends(xdf1: *mut xdfile, xdf2: *mut xdfile) -> i32 {
     ++    let xdf1 = xdf1.as_mut().expect("null pointer");
     ++    let xdf2 = xdf2.as_mut().expect("null pointer");
      +
     -+#[no_mangle]
     -+unsafe extern "C" fn xdl_line_equal(lhs: *const u8, lhs_len: usize, rhs: *const u8, rhs_len: usize, flags: u64) -> bool {
     -+    let lhs_line = std::slice::from_raw_parts(lhs, lhs_len);
     -+    let rhs_line = std::slice::from_raw_parts(rhs, rhs_len);
     ++    trim_ends(xdf1, xdf2);
      +
     -+    line_equal(lhs_line, rhs_line, flags)
     ++    0
      +}
      
     - ## rust/xdiff/src/xutils.rs ##
     + ## rust/xdiff/src/xprepare.rs (new) ##
      @@
     - use crate::*;
     -+use xxhash_rust::xxh3::xxh3_64;
     - 
     - pub(crate) fn xdl_isspace(v: u8) -> bool {
     -     match v {
     -@@ rust/xdiff/src/xutils.rs: where
     -     run_option0.is_none() && run_option1.is_none()
     - }
     - 
     ++use crate::xtypes::xdfile;
      +
     -+pub fn line_hash(line: &[u8], flags: u64) -> u64 {
     -+    if (flags & XDF_WHITESPACE_FLAGS) == 0 {
     -+        return xxh3_64(line);
     -+    }
     ++///
     ++/// Early trim initial and terminal matching records.
     ++///
     ++pub(crate) fn trim_ends(xdf1: &mut xdfile, xdf2: &mut xdfile) {
     ++    let mut lim = std::cmp::min(xdf1.record.len(), xdf2.record.len());
      +
     -+    let mut hasher = Xxh3Default::new();
     -+    for chunk in WhitespaceIter::new(line, flags) {
     -+        hasher.update(chunk);
     ++    for i in 0..lim {
     ++        if xdf1.record[i].ha != xdf2.record[i].ha {
     ++            xdf1.dstart = i as isize;
     ++            xdf2.dstart = i as isize;
     ++            lim -= i;
     ++            break;
     ++        }
      +    }
      +
     -+    hasher.finish()
     -+}
     -+
     -+
     -+pub fn line_equal(lhs: &[u8], rhs: &[u8], flags: u64) -> bool {
     -+    if (flags & XDF_WHITESPACE_FLAGS) == 0 {
     -+        return lhs == rhs;
     ++    for i in 0..lim {
     ++        let f1i = xdf1.record.len() - 1 - i;
     ++        let f2i = xdf2.record.len() - 1 - i;
     ++        if xdf1.record[f1i].ha != xdf2.record[f2i].ha {
     ++            xdf1.dend = f1i as isize;
     ++            xdf2.dend = f2i as isize;
     ++            break;
     ++        }
      +    }
     -+
     -+    let lhs_it = WhitespaceIter::new(lhs, flags);
     -+    let rhs_it = WhitespaceIter::new(rhs, flags);
     -+
     -+    chunked_iter_equal(lhs_it, rhs_it)
      +}
     +
     + ## rust/xdiff/src/xtypes.rs (new) ##
     +@@
     ++use interop::ivec::IVec;
      +
     ++#[repr(C)]
     ++pub(crate) struct xrecord {
     ++    pub(crate) ptr: *const u8,
     ++    pub(crate) size: usize,
     ++    pub(crate) ha: u64,
     ++}
      +
     - #[cfg(test)]
     - mod tests {
     -     use crate::*;
     ++#[repr(C)]
     ++pub(crate) struct xdfile {
     ++    pub(crate) record: IVec<xrecord>,
     ++    pub(crate) dstart: isize,
     ++    pub(crate) dend: isize,
     ++    pub(crate) rchg: *mut u8,
     ++    pub(crate) rindex: *mut usize,
     ++    pub(crate) nreff: usize,
     ++    pub(crate) ha: *mut u64,
     ++}
     +
     + ## xdiff/xprepare.c ##
     +@@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
     + }
     + 
     + 
     +-/*
     +- * Early trim initial and terminal matching records.
     +- */
     +-static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2) {
     +-	long i, lim;
     +-	xrecord_t *recs1, *recs2;
     +-
     +-	recs1 = xdf1->record.ptr;
     +-	recs2 = xdf2->record.ptr;
     +-	for (i = 0, lim = XDL_MIN(xdf1->record.length, xdf2->record.length); i < lim;
     +-	     i++, recs1++, recs2++)
     +-		if (recs1->ha != recs2->ha)
     +-			break;
     +-
     +-	xdf1->dstart = xdf2->dstart = i;
     +-
     +-	recs1 = xdf1->record.ptr + xdf1->record.length - 1;
     +-	recs2 = xdf2->record.ptr + xdf2->record.length - 1;
     +-	for (lim -= i, i = 0; i < lim; i++, recs1--, recs2--)
     +-		if (recs1->ha != recs2->ha)
     +-			break;
     +-
     +-	xdf1->dend = xdf1->record.length - i - 1;
     +-	xdf2->dend = xdf2->record.length - i - 1;
     +-
     +-	return 0;
     +-}
     ++extern i32 xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2);
     + 
     + 
     + static int xdl_optimize_ctxs(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
 16:  f7829c55871 <  -:  ----------- xdiff: optimize case where --ignore-cr-at-eol is the only whitespace flag
 17:  395609aff4b <  -:  ----------- xdiff: use rust's version of whitespace processing

-- 
gitgitgadget

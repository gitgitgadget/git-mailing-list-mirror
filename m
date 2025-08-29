Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A084D241695
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 19:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496547; cv=none; b=VJx9k3IbARDJfmslDFt6MOQ3NMQcqBNgQJQ4EC2XHI5iIDPYB5d5Kdc1AMlJ7AWQLu5tIQIVQ0bhPVTYFxobzYMOTuvmLFCY1PpREJDvc5JhVZtmphGeQD0iyyBBw1k52dCeK8AoWVlg3sSllUu+0Nk0+zblFuhfsuaEzlyAfRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496547; c=relaxed/simple;
	bh=qIhY3EJkKuNm7rn3xk++5XwRZ2Pkmv27uPzdRtI8Jbc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uFIFdEwXZojCYKpzWo+FdLa3BI5PCdjfv8E5/orW0i37XMKzE3PD+5zbhk3xXhQelZURwRjJwReqvv1uB3ngwL1fxZaf0YlZHXabM5nizY27eNaRzsnGTPkJkjTVk5omft7aoiLfuqy9t0/g4gTWy5J3VLWV6Doln5Z3hMojLtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYulAJlk; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYulAJlk"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2445806e03cso26595105ad.1
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 12:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756496544; x=1757101344; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fS9khvImoUnlpMu58uWHziCWZFyDhnpP3Z47UD0cjy0=;
        b=AYulAJlkTsfg1fYztv2N70+GbXhKZ+w1gbiwwvrEYgSYqgmE39NWVOPKvlHvBFOuwF
         IbHcowSashh9fT0ApyQqspCIe+c41wvzibqaMNjNI7dujAbwYpVDwLCH4kxJo8rSyQHU
         Ut7GZFvKZkgOD9LZ3MmsnLpXKuAKts5klXJZ9RHmeiY1Y0sZ4M90fPWb8nNJfTs9FF0D
         zd+aeTxM76HcxLFZDBjSH2K7WGKwaxVKEeLbvNK2UlT4xv8YqGa+NDKKJyI6Udd1qBle
         x2DbJ0ewKNb58mdugLrZw1wwjq01OQ1bUU8HX0fDRyW4cN4PY8o+KquRazUqCoCSZYem
         Y+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756496544; x=1757101344;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fS9khvImoUnlpMu58uWHziCWZFyDhnpP3Z47UD0cjy0=;
        b=blDCtydLsuO+WiMjHFf+ABiJcBOZqTHgiOeAf/XXvIQ4GrVU7n+8sAnrhfF7v618l0
         csCziWRd/DmEDciM8O/bq8AvlqoK0MJ0ZnPQS6bCRwJuntUJJPr7w4Mz2VvjoLXVEXOM
         bJL7Z19QSJ93z134YuHYFe9TGhukihqhAWScQUJ5YUGf0RrySyX9UGfbT4cDGyPK9EvL
         olwA1fg046Fi6PWGPSebtWzLV3RGWjJquc3dfJ+n707iCgBdKaOC868blEEp2vPJnpCt
         BLKifmScThDPtGuNvJb5R607k103GHK7meoXj7YPIdvyTZqG2wp39H8lMTXW8JhOq+8S
         JTlA==
X-Gm-Message-State: AOJu0YwGL+DeUxocaMf9lVdtT2WFCDBGJQ5Le9hMN3BgOv/1rJn8Cnja
	dXuypSgeYHvFH6a2KkxWRSwAVi+9cnbZV7O/OKAnpnUFc/p4vL6l8EZorZIYTA==
X-Gm-Gg: ASbGncsX4tkTj7gOWNkdqZ9CyP+CB4Lqw0q/VkjZFECCluDf+r0YWt6lpAGcaNZ2rD/
	9YkvMffZcvZLndkwe4ctG55ARqtxnCgLekMSERxXL3ZtZNVdwnIJul0CmczfwN+drYcAMcBG79U
	vl8e6YoKE6Ddvl1e4cr+WlZ/Szj1e89/3BJePDMJmF58plupH4G009rtQHpQLqnQXWKBnL43POs
	w3bw+P1Cdixjdi3poqCjdXkOdqaZfJ/NjG94fAaVEtQz7eLsqoapui/aHq8fFM2vYquJfEK2vEM
	6/XyFpmzVcwbWGyQOY0iC5EuqqTj9E3tuhcgYsTHn3z5Ofm39dSUvIRBLXlmcCzrkDqbjynXftx
	b7YobIKk0Fcpn13zDNNSV+cHyJ9I=
X-Google-Smtp-Source: AGHT+IHSSEbrNq3bX3wQtqLxpf4PTNPJl5+CuYMyY9RwaWAHDy+kHLgGDkXgZwmDiI3mD3okF/HOQA==
X-Received: by 2002:a17:903:124c:b0:234:d292:be7a with SMTP id d9443c01a7336-2462ee0b991mr385741305ad.1.1756496544361;
        Fri, 29 Aug 2025 12:42:24 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.195.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490372734asm33014525ad.42.2025.08.29.12.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 12:42:23 -0700 (PDT)
Message-Id: <cc9cf877754c050ebb2014ab63f2dce431df646a.1756496539.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 Aug 2025 19:42:06 +0000
Subject: [PATCH 02/15] xdiff: introduce rust
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Upcoming patches will simplify xdiff, while also porting parts of it to
Rust. In preparation, add some stubs and setup the Rust build. For now,
it is easier to let cargo build rust and have make or meson merely link
against the static library that cargo builds. In line with ongoing
libification efforts, use multiple crates to allow more modularity on
the Rust side. xdiff is the crate that this series will focus on, but
we also introduce the interop crate for future patch series.

In order to facilitate interoperability between C and Rust, introduce C
definitions for Rust primitive types in git-compat-util.h.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 .gitignore              |  3 +++
 Makefile                | 53 ++++++++++++++++++++++++++++----------
 build_rust.sh           | 57 +++++++++++++++++++++++++++++++++++++++++
 git-compat-util.h       | 17 ++++++++++++
 meson.build             | 52 +++++++++++++++++++++++++++++++------
 rust/Cargo.toml         |  6 +++++
 rust/interop/Cargo.toml | 14 ++++++++++
 rust/interop/src/lib.rs |  0
 rust/xdiff/Cargo.toml   | 15 +++++++++++
 rust/xdiff/src/lib.rs   |  0
 10 files changed, 196 insertions(+), 21 deletions(-)
 create mode 100755 build_rust.sh
 create mode 100644 rust/Cargo.toml
 create mode 100644 rust/interop/Cargo.toml
 create mode 100644 rust/interop/src/lib.rs
 create mode 100644 rust/xdiff/Cargo.toml
 create mode 100644 rust/xdiff/src/lib.rs

diff --git a/.gitignore b/.gitignore
index 04c444404e..ff81e3580c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -254,3 +254,6 @@ Release/
 /contrib/buildsystems/out
 /contrib/libgit-rs/target
 /contrib/libgit-sys/target
+/.idea/
+/rust/target/
+/rust/Cargo.lock
diff --git a/Makefile b/Makefile
index 70d1543b6b..1ec0c1ee66 100644
--- a/Makefile
+++ b/Makefile
@@ -919,6 +919,29 @@ TEST_SHELL_PATH = $(SHELL_PATH)
 
 LIB_FILE = libgit.a
 XDIFF_LIB = xdiff/lib.a
+
+EXTLIBS =
+
+ifeq ($(DEBUG), 1)
+  RUST_BUILD_MODE = debug
+else
+  RUST_BUILD_MODE = release
+endif
+
+RUST_TARGET_DIR = rust/target/$(RUST_BUILD_MODE)
+RUST_FLAGS_FOR_C = -L$(RUST_TARGET_DIR)
+
+.PHONY: compile_rust
+compile_rust:
+	./build_rust.sh . $(RUST_BUILD_MODE) xdiff
+
+EXTLIBS += ./$(RUST_TARGET_DIR)/libxdiff.a
+
+UNAME_S := $(shell uname -s)
+ifeq ($(UNAME_S),Linux)
+  EXTLIBS += -ldl
+endif
+
 REFTABLE_LIB = reftable/libreftable.a
 
 GENERATED_H += command-list.h
@@ -1390,7 +1413,7 @@ UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
 
 # xdiff and reftable libs may in turn depend on what is in libgit.a
 GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
-EXTLIBS =
+
 
 GIT_USER_AGENT = git/$(GIT_VERSION)
 
@@ -2541,7 +2564,7 @@ git.sp git.s git.o: EXTRA_CPPFLAGS = \
 	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
 	'-DGIT_INFO_PATH="$(infodir_relative_SQ)"'
 
-git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
+git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS) compile_rust
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(LIBS)
 
@@ -2891,17 +2914,17 @@ headless-git.o: compat/win32/headless.c GIT-CFLAGS
 headless-git$X: headless-git.o git.res GIT-LDFLAGS
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) $(ALL_LDFLAGS) -mwindows -o $@ $< git.res
 
-git-%$X: %.o GIT-LDFLAGS $(GITLIBS)
+git-%$X: %.o GIT-LDFLAGS $(GITLIBS) compile_rust
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
-git-imap-send$X: imap-send.o $(IMAP_SEND_BUILDDEPS) GIT-LDFLAGS $(GITLIBS)
+git-imap-send$X: imap-send.o $(IMAP_SEND_BUILDDEPS) GIT-LDFLAGS $(GITLIBS) compile_rust
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(IMAP_SEND_LDFLAGS) $(LIBS)
 
-git-http-fetch$X: http.o http-walker.o http-fetch.o GIT-LDFLAGS $(GITLIBS)
+git-http-fetch$X: http.o http-walker.o http-fetch.o GIT-LDFLAGS $(GITLIBS) compile_rust
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(CURL_LIBCURL) $(LIBS)
-git-http-push$X: http.o http-push.o GIT-LDFLAGS $(GITLIBS)
+git-http-push$X: http.o http-push.o GIT-LDFLAGS $(GITLIBS) compile_rust
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
 
@@ -2911,11 +2934,11 @@ $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
 	ln -s $< $@ 2>/dev/null || \
 	cp $< $@
 
-$(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS)
+$(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS) compile_rust
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
 
-scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
+scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS) compile_rust
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(LIBS)
 
@@ -2925,6 +2948,7 @@ $(LIB_FILE): $(LIB_OBJS)
 $(XDIFF_LIB): $(XDIFF_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
+
 $(REFTABLE_LIB): $(REFTABLE_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
@@ -3294,7 +3318,7 @@ perf: all
 
 t/helper/test-tool$X: $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS)) $(UNIT_TEST_DIR)/test-lib.o
 
-t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS)
+t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS) compile_rust
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
 
 check-sha1:: t/helper/test-tool$X
@@ -3756,7 +3780,10 @@ cocciclean:
 	$(RM) -r .build/contrib/coccinelle
 	$(RM) contrib/coccinelle/*.cocci.patch
 
-clean: profile-clean coverage-clean cocciclean
+rustclean:
+	cd rust && cargo clean
+
+clean: profile-clean coverage-clean cocciclean rustclean
 	$(RM) -r .build $(UNIT_TEST_BIN)
 	$(RM) GIT-TEST-SUITES
 	$(RM) po/git.pot po/git-core.pot
@@ -3911,13 +3938,13 @@ FUZZ_CXXFLAGS ?= $(ALL_CFLAGS)
 .PHONY: fuzz-all
 fuzz-all: $(FUZZ_PROGRAMS)
 
-$(FUZZ_PROGRAMS): %: %.o oss-fuzz/dummy-cmd-main.o $(GITLIBS) GIT-LDFLAGS
+$(FUZZ_PROGRAMS): %: %.o oss-fuzz/dummy-cmd-main.o $(GITLIBS) GIT-LDFLAGS compile_rust
 	$(QUIET_LINK)$(FUZZ_CXX) $(FUZZ_CXXFLAGS) -o $@ $(ALL_LDFLAGS) \
 		-Wl,--allow-multiple-definition \
 		$(filter %.o,$^) $(filter %.a,$^) $(LIBS) $(LIB_FUZZING_ENGINE)
 
 $(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o $(UNIT_TEST_OBJS) \
-	$(GITLIBS) GIT-LDFLAGS
+	$(GITLIBS) GIT-LDFLAGS compile_rust
 	$(call mkdir_p_parent_template)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(filter %.a,$^) $(LIBS)
@@ -3936,7 +3963,7 @@ $(UNIT_TEST_DIR)/clar.suite: $(UNIT_TEST_DIR)/clar-decls.h $(UNIT_TEST_DIR)/gene
 $(UNIT_TEST_DIR)/clar/clar.o: $(UNIT_TEST_DIR)/clar.suite
 $(CLAR_TEST_OBJS): $(UNIT_TEST_DIR)/clar-decls.h
 $(CLAR_TEST_OBJS): EXTRA_CPPFLAGS = -I$(UNIT_TEST_DIR)
-$(CLAR_TEST_PROG): $(UNIT_TEST_DIR)/clar.suite $(CLAR_TEST_OBJS) $(GITLIBS) GIT-LDFLAGS
+$(CLAR_TEST_PROG): $(UNIT_TEST_DIR)/clar.suite $(CLAR_TEST_OBJS) $(GITLIBS) GIT-LDFLAGS compile_rust
 	$(call mkdir_p_parent_template)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
diff --git a/build_rust.sh b/build_rust.sh
new file mode 100755
index 0000000000..192385a1d9
--- /dev/null
+++ b/build_rust.sh
@@ -0,0 +1,57 @@
+#!/bin/sh
+
+
+rustc -vV || exit $?
+cargo --version || exit $?
+
+dir_git_root=${0%/*}
+dir_build=$1
+rust_build_profile=$2
+crate=$3
+
+dir_rust=$dir_git_root/rust
+
+if [ "$dir_git_root" = "" ]; then
+  echo "did not specify the directory for the root of git"
+  exit 1
+fi
+
+if [ "$dir_build" = "" ]; then
+  echo "did not specify the build directory"
+  exit 1
+fi
+
+if [ "$rust_build_profile" = "" ]; then
+  echo "did not specify the rust_build_profile"
+  exit 1
+fi
+
+if [ "$rust_build_profile" = "release" ]; then
+  rust_args="--release"
+  export RUSTFLAGS=''
+elif [ "$rust_build_profile" = "debug" ]; then
+  rust_args=""
+  export RUSTFLAGS='-C debuginfo=2 -C opt-level=1 -C force-frame-pointers=yes'
+else
+  echo "illegal rust_build_profile value $rust_build_profile"
+  exit 1
+fi
+
+cd $dir_rust && cargo clean && pwd && cargo build -p $crate $rust_args; cd $dir_git_root
+
+libfile="lib${crate}.a"
+if rustup show active-toolchain | grep windows-msvc; then
+  libfile="${crate}.lib"
+fi
+dst=$dir_build/$libfile
+
+if [ "$dir_git_root" != "$dir_build" ]; then
+  src=$dir_rust/target/$rust_build_profile/$libfile
+  if [ ! -f $src ]; then
+    echo >&2 "::error:: cannot find path of static library $src is not a file or does not exist"
+    exit 5
+  fi
+
+  rm $dst 2>/dev/null
+  mv $src $dst
+fi
diff --git a/git-compat-util.h b/git-compat-util.h
index 4678e21c4c..82dc99764a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -196,6 +196,23 @@ static inline int is_xplatform_dir_sep(int c)
 #include "compat/msvc.h"
 #endif
 
+/* rust types */
+typedef uint8_t   u8;
+typedef uint16_t  u16;
+typedef uint32_t  u32;
+typedef uint64_t  u64;
+
+typedef int8_t    i8;
+typedef int16_t   i16;
+typedef int32_t   i32;
+typedef int64_t   i64;
+
+typedef float     f32;
+typedef double    f64;
+
+typedef size_t    usize;
+typedef ptrdiff_t isize;
+
 /* used on Mac OS X */
 #ifdef PRECOMPOSE_UNICODE
 #include "compat/precompose_utf8.h"
diff --git a/meson.build b/meson.build
index 596f5ac711..324f968338 100644
--- a/meson.build
+++ b/meson.build
@@ -267,6 +267,40 @@ version_gen_environment.set('GIT_DATE', get_option('build_date'))
 version_gen_environment.set('GIT_USER_AGENT', get_option('user_agent'))
 version_gen_environment.set('GIT_VERSION', get_option('version'))
 
+if get_option('optimization') in ['2', '3', 's', 'z']
+  rust_build_profile = 'release'
+else
+  rust_build_profile = 'debug'
+endif
+
+# Run `rustup show active-toolchain` and capture output
+rustup_out = run_command('rustup', 'show', 'active-toolchain',
+                         check: true).stdout().strip()
+
+rust_crates = ['xdiff']
+rust_builds = []
+
+foreach crate : rust_crates
+  if rustup_out.contains('windows-msvc')
+    libfile = crate + '.lib'
+  else
+    libfile = 'lib' + crate + '.a'
+  endif
+
+  rust_builds += custom_target(
+    'rust_build_'+crate,
+    output: libfile,
+    build_by_default: true,
+    build_always_stale: true,
+    command: [
+      meson.project_source_root() / 'build_rust.sh',
+      meson.current_build_dir(), rust_build_profile, crate,
+    ],
+    install: false,
+  )
+endforeach
+
+
 compiler = meson.get_compiler('c')
 
 libgit_sources = [
@@ -1678,14 +1712,16 @@ version_def_h = custom_target(
 libgit_sources += version_def_h
 
 libgit = declare_dependency(
-  link_with: static_library('git',
-    sources: libgit_sources,
-    c_args: libgit_c_args + [
-      '-DGIT_VERSION_H="' + version_def_h.full_path() + '"',
-    ],
-    dependencies: libgit_dependencies,
-    include_directories: libgit_include_directories,
-  ),
+  link_with: [
+    static_library('git',
+      sources: libgit_sources,
+      c_args: libgit_c_args + [
+        '-DGIT_VERSION_H="' + version_def_h.full_path() + '"',
+      ],
+      dependencies: libgit_dependencies,
+      include_directories: libgit_include_directories,
+    ),
+  ] + rust_builds,
   compile_args: libgit_c_args,
   dependencies: libgit_dependencies,
   include_directories: libgit_include_directories,
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
new file mode 100644
index 0000000000..ed3d79d7f8
--- /dev/null
+++ b/rust/Cargo.toml
@@ -0,0 +1,6 @@
+[workspace]
+members = [
+    "xdiff",
+    "interop",
+]
+resolver = "2"
diff --git a/rust/interop/Cargo.toml b/rust/interop/Cargo.toml
new file mode 100644
index 0000000000..045e3b01cf
--- /dev/null
+++ b/rust/interop/Cargo.toml
@@ -0,0 +1,14 @@
+[package]
+name = "interop"
+version = "0.1.0"
+edition = "2021"
+
+[lib]
+name = "interop"
+path = "src/lib.rs"
+## staticlib to generate xdiff.a for use by gcc
+## cdylib (optional) to generate xdiff.so for use by gcc
+## rlib is required by the rust unit tests
+crate-type = ["staticlib", "rlib"]
+
+[dependencies]
diff --git a/rust/interop/src/lib.rs b/rust/interop/src/lib.rs
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/rust/xdiff/Cargo.toml b/rust/xdiff/Cargo.toml
new file mode 100644
index 0000000000..eb7966aada
--- /dev/null
+++ b/rust/xdiff/Cargo.toml
@@ -0,0 +1,15 @@
+[package]
+name = "xdiff"
+version = "0.1.0"
+edition = "2021"
+
+[lib]
+name = "xdiff"
+path = "src/lib.rs"
+## staticlib to generate xdiff.a for use by gcc
+## cdylib (optional) to generate xdiff.so for use by gcc
+## rlib is required by the rust unit tests
+crate-type = ["staticlib", "rlib"]
+
+[dependencies]
+interop = { path = "../interop" }
diff --git a/rust/xdiff/src/lib.rs b/rust/xdiff/src/lib.rs
new file mode 100644
index 0000000000..e69de29bb2
-- 
gitgitgadget


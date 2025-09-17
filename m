Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119AB2222B2
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 01:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758071812; cv=none; b=EX04/xOo7KDA90UG7abkiA93GllBqbR0ZhS+lkfDAhe6DPrqswz0L9mSCAmQg7PaIg+tGvH+lttEMiz/Hc7uUlK7Pc2WfdafzQJNhN4k70MmWkL2asRVrIezZnD1d7nFB0Pkuu5zLFAJBz3TM5xAbNohIbZ1NOT9w2mfzBGRWlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758071812; c=relaxed/simple;
	bh=9bsEv9ow4v9iSRDjTjVvDYmkjFBGF7F3wirHFB8nc+E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TWm8xznsqRJu511+1uZJ0ByspjTpuNf0JFpGN7qCr7EEUUNRmsOenaozGccrpE4W/9JhlDl/kpX82djI5IHlKVNXaW174Di8oVyajQ4FatQAoKmnJpzuS1Kf8LDFQF7NEaUvs12iwn8qGksO4xrio961RdZK6bl+aqkysWzaLzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ah0peo+s; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ah0peo+s"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-25e5e1cd552so30038005ad.1
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 18:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758071809; x=1758676609; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TO596GvWeYkQqRi3B7MdgzeDnJxd00rg+pxZLR34Hy0=;
        b=ah0peo+sjCKXMIlvzzbyDmKStAOm3a/MkLU1Xg3lGKodVCsMTBlxRIv924ZZp9X7kE
         cLgcMgfTX93UQ5Y4OzNnRHzLZocNYz5xjgK+fOUrDrLSooeMtNtVpoBUKLlhuWm8Zbcj
         nYSHx2Gxd91bCzv3TapuGk1T46O/2ODCrAAeCkf6H9bonUFtwAhd83rHhS/NoREjLb9o
         Uw0RHIr0wCp80Qpd8y7JAnERzK+BJ6DAIA4EebMG3o9r3awNQSINzy1MKkkxIQL9pb25
         j0ce+vL/99ugMRHI/3/Xm8BV2BubFVmTNtv4Ew2zYfvu5VR42s67GTvA9K/LAsTFrXH2
         oEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758071809; x=1758676609;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TO596GvWeYkQqRi3B7MdgzeDnJxd00rg+pxZLR34Hy0=;
        b=tEyuioh/BBaZF4qIaJn4GBITw8fFkLfe9276oINP7ELzbJexezpy4E9oaIYeJoQRvZ
         XwU/ZGtfNKvJ+bFv3eoSSY7NO1x8T7MMzTgGQ7fgmeEQq9qS3M5FZMe3Nay9jsCP9/5D
         wexWRfNrBfLZKBcYD4KQYTAWjXy/9bcRfYsRouaMOlFMfmT/uExxZtpEMWlE79kzlEQb
         Ah4ZLdAJLfFx4IcTJGOHes1qeEtzr9/JqokbVbMKbunVOWQU4QsxCps6Xrkjke7I4hDF
         RSP4anclbWb4eeW6tPM9yXdZAFFGltsBnYvy40kWhMMpMCVFE20kYVu24jIWeWV1yz1y
         0ZdQ==
X-Gm-Message-State: AOJu0YyqiJXHXvBSe8Au5QuTcJlh43kR17YVg/BXRhhhktl5O1ED42Dx
	xzrastyx5SZKCRFxl86XgJNd1+47FUaEZqNefIyVsgrFgdUTNlvVBf1gCDBrXw==
X-Gm-Gg: ASbGnctr36bg8EGJbyvfwzgW70aXd9RC2Dvc4/xsYLPcMq8gWB/DJTl5p/oSuNetU5Z
	ONZN6gB1gz0L5U41XL9ECclAjO1SYKR3blpgy4nyvjJ/TolW8s+KRpFIY38xV5YlaQ7+tesp76a
	IcNT6dnPn4PDowkETzvGoaRDqXGqIEzgJlDGQBN3OijbcAt44pxYKGI18klVtUkHs/BX6nBM6YD
	OKgo1Nfg6Caj0uKf49QS9R98Db3k9auh/E8qPfSFa0G9fgXUJLQKWX1ZPt1c1IFDnydVNZ0JxM8
	Y9tubgJiknEtbEAWZ8sboNqZ7InehbOk9HW/WNu7YtPZcp4UbacmOajDUNytifURxhMpO8GAzMH
	+s+reF75d7droP7f2Q/XWU5rRW9Q=
X-Google-Smtp-Source: AGHT+IF8bFmhKgG1FxybbRgF4qRSp+v2Je6BQSNglXBXA3r0ddtAPK47+EfmOm56LKRHwQGVQ43hNg==
X-Received: by 2002:a17:902:f645:b0:24e:e5c9:ed13 with SMTP id d9443c01a7336-26813903d86mr3258025ad.47.1758071808640;
        Tue, 16 Sep 2025 18:16:48 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-261dc74d57asm108883905ad.50.2025.09.16.18.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 18:16:48 -0700 (PDT)
Message-Id: <6032a8740c0ba72420f42c3d8d801e1bdeec12d0.1758071798.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
	<pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Sep 2025 01:16:27 +0000
Subject: [PATCH v2 07/18] build: introduce rust
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
the Rust side. The xdiff and ivec crates are the focal point for this
series.

cbindgen will be used to generate header files for each Rust crate for
C interoperability.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 .gitignore        |  3 ++
 Makefile          | 81 +++++++++++++++++++++++++++++++++++++++--------
 build_rust.sh     | 60 +++++++++++++++++++++++++++++++++++
 meson.build       | 72 ++++++++++++++++++++++++++++++++++++-----
 meson_options.txt |  2 ++
 rust/Cargo.toml   |  3 ++
 6 files changed, 200 insertions(+), 21 deletions(-)
 create mode 100755 build_rust.sh
 create mode 100644 rust/Cargo.toml

diff --git a/.gitignore b/.gitignore
index 04c444404e..24292eb473 100644
--- a/.gitignore
+++ b/.gitignore
@@ -254,3 +254,6 @@ Release/
 /contrib/buildsystems/out
 /contrib/libgit-rs/target
 /contrib/libgit-sys/target
+.idea/
+/rust/target/
+/rust/Cargo.lock
diff --git a/Makefile b/Makefile
index ffb898b611..ef55a8183c 100644
--- a/Makefile
+++ b/Makefile
@@ -483,6 +483,14 @@ include shared.mak
 # Define LIBPCREDIR=/foo/bar if your PCRE header and library files are
 # in /foo/bar/include and /foo/bar/lib directories.
 #
+# == Optional Rust support ==
+#
+# Define WITH_RUST=false if you don't want to include features and subsystems
+# written in Rust into Git. For now, Rust is still an optional feature of the
+# build process. With Git 3.0 though, Rust will be mandatory.
+#
+# Building Rust code requires Cargo.
+#
 # == SHA-1 and SHA-256 defines ==
 #
 # === SHA-1 backend ===
@@ -916,6 +924,51 @@ TEST_SHELL_PATH = $(SHELL_PATH)
 
 LIB_FILE = libgit.a
 
+EXTLIBS =
+
+GIT_BUILD_DIR := $(CURDIR)
+export GIT_BUILD_DIR
+
+RUST_CRATES :=
+.PHONY: compile_rust rustclean
+
+WITH_RUST ?= true
+ifeq ($(WITH_RUST),true)
+
+ifeq ($(DEBUG), 1)
+	RUST_BUILD_MODE := debug
+else
+	RUST_BUILD_MODE := release
+endif
+
+RUST_TARGET_DIR := $(GIT_BUILD_DIR)/$(RUST_BUILD_MODE)
+
+RUST_LIBS := $(foreach c,$(RUST_CRATES),$(GIT_BUILD_DIR)/lib$(c).a)
+
+EXTLIBS += $(RUST_LIBS)
+
+compile_rust: $(RUST_LIBS)
+rustclean:
+	$(RM) $(RUST_LIBS)
+	cd rust && cargo clean
+
+$(GIT_BUILD_DIR)/lib%.a:
+	./build_rust.sh $(GIT_BUILD_DIR) $(RUST_BUILD_MODE) $*
+
+UNAME_S := $(shell uname -s)
+ifeq ($(UNAME_S),Linux)
+	EXTLIBS += -ldl
+endif
+
+else ifeq ($(WITH_RUST),false)
+compile_rust:
+	:
+rustclean:
+	:
+else
+$(error 'WITH_RUST' must be true or false)
+endif
+
 GENERATED_H += command-list.h
 GENERATED_H += config-list.h
 GENERATED_H += hook-list.h
@@ -1403,7 +1456,6 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
 
 GITLIBS = common-main.o $(LIB_FILE)
-EXTLIBS =
 
 GIT_USER_AGENT = git/$(GIT_VERSION)
 
@@ -1421,6 +1473,9 @@ CC_LD_DYNPATH = -Wl,-rpath,
 BASIC_CFLAGS = -I. -fPIE
 BASIC_LDFLAGS =
 
+ifeq ($(WITH_RUST),true)
+BASIC_CFLAGS += -DWITH_RUST
+endif
 # library flags
 ARFLAGS = rcs
 PTHREAD_CFLAGS =
@@ -2551,7 +2606,7 @@ git.sp git.s git.o: EXTRA_CPPFLAGS = \
 	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
 	'-DGIT_INFO_PATH="$(infodir_relative_SQ)"'
 
-git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
+git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS) compile_rust
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(LIBS)
 
@@ -2876,17 +2931,17 @@ headless-git.o: compat/win32/headless.c GIT-CFLAGS
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
 
@@ -2896,11 +2951,11 @@ $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
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
 
@@ -3273,7 +3328,7 @@ perf: all
 
 t/helper/test-tool$X: $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS)) $(UNIT_TEST_DIR)/test-lib.o
 
-t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS)
+t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS) compile_rust
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
 
 check-sha1:: t/helper/test-tool$X
@@ -3738,7 +3793,7 @@ cocciclean:
 	$(RM) -r .build/contrib/coccinelle
 	$(RM) contrib/coccinelle/*.cocci.patch
 
-clean: profile-clean coverage-clean cocciclean
+clean: profile-clean coverage-clean cocciclean rustclean
 	$(RM) -r .build $(UNIT_TEST_BIN)
 	$(RM) GIT-TEST-SUITES
 	$(RM) po/git.pot po/git-core.pot
@@ -3893,13 +3948,13 @@ FUZZ_CXXFLAGS ?= $(ALL_CFLAGS)
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
@@ -3918,7 +3973,7 @@ $(UNIT_TEST_DIR)/clar.suite: $(UNIT_TEST_DIR)/clar-decls.h $(UNIT_TEST_DIR)/gene
 $(UNIT_TEST_DIR)/clar/clar.o: $(UNIT_TEST_DIR)/clar.suite
 $(CLAR_TEST_OBJS): $(UNIT_TEST_DIR)/clar-decls.h
 $(CLAR_TEST_OBJS): EXTRA_CPPFLAGS = -I$(UNIT_TEST_DIR)
-$(CLAR_TEST_PROG): $(UNIT_TEST_DIR)/clar.suite $(CLAR_TEST_OBJS) $(GITLIBS) GIT-LDFLAGS
+$(CLAR_TEST_PROG): $(UNIT_TEST_DIR)/clar.suite $(CLAR_TEST_OBJS) $(GITLIBS) GIT-LDFLAGS compile_rust
 	$(call mkdir_p_parent_template)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
diff --git a/build_rust.sh b/build_rust.sh
new file mode 100755
index 0000000000..b020f2d37a
--- /dev/null
+++ b/build_rust.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
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
+libfile="lib${crate}.a"
+if rustup show active-toolchain | grep windows-msvc; then
+  libfile="${crate}.lib"
+  PATH="$(echo $PATH | tr ':' '\n' | grep -Ev "^(/mingw64/bin|/usr/bin)$" | paste -sd: -):/mingw64/bin:/usr/bin"
+fi
+
+CARGO_TARGET_DIR=$dir_git_root/.build/rust/$crate
+export CARGO_TARGET_DIR
+
+cd $dir_rust && cargo clean && pwd && USE_LINKING="false" cargo build -p $crate $rust_args; cd $dir_git_root
+
+src=$CARGO_TARGET_DIR/$rust_build_profile/$libfile
+dst=$dir_build/$libfile
+
+if [ ! -f $src ]; then
+  echo >&2 "::error:: cannot find path of static library $src is not a file or does not exist"
+  exit 5
+fi
+
+rm $dst 2>/dev/null
+echo mv $src $dst
+mv $src $dst
diff --git a/meson.build b/meson.build
index 5dd299b496..cbe1afac83 100644
--- a/meson.build
+++ b/meson.build
@@ -267,6 +267,55 @@ version_gen_environment.set('GIT_DATE', get_option('build_date'))
 version_gen_environment.set('GIT_USER_AGENT', get_option('user_agent'))
 version_gen_environment.set('GIT_VERSION', get_option('version'))
 
+rust_crates = []
+
+rust_builds = []
+with_rust = get_option('with_rust')
+if with_rust
+  rustc = find_program('rustc', required : false)
+  cargo = find_program('cargo', required : false)
+
+  if not rustc.found() or not cargo.found()
+    error('Rust toolchain not found. Reconfigure with -Dwith_rust=false')
+  endif
+
+  if get_option('optimization') in ['2', '3', 's', 'z']
+    rust_build_profile = 'release'
+  else
+    rust_build_profile = 'debug'
+  endif
+
+  # Run `rustup show active-toolchain` and capture output
+  rustup_out = run_command('rustup', 'show', 'active-toolchain',
+                           check: true).stdout().strip()
+
+  rust_environment = script_environment
+
+  foreach crate : rust_crates
+    if rustup_out.contains('windows-msvc')
+      libfile = crate + '.lib'
+    else
+      libfile = 'lib' + crate + '.a'
+    endif
+
+    rust_builds += custom_target(
+      'rust_build_'+crate,
+      output: libfile,
+      build_by_default: true,
+      build_always_stale: true,
+      command: [
+        meson.project_source_root() / 'build_rust.sh',
+        meson.current_build_dir(), rust_build_profile, crate,
+      ],
+      install: false,
+      env: rust_environment,
+    )
+  endforeach
+else
+  message('Rust components disabled (-Dwith_rust=false)')
+endif
+
+
 compiler = meson.get_compiler('c')
 
 libgit_sources = [
@@ -774,6 +823,10 @@ libgit_c_args = [
   '-DSHELL_PATH="' + fs.as_posix(target_shell.full_path()) + '"',
 ]
 
+if with_rust
+  libgit_c_args += '-DWITH_RUST'
+endif
+
 system_attributes = get_option('gitattributes')
 if system_attributes != ''
   libgit_c_args += '-DETC_GITATTRIBUTES="' + system_attributes + '"'
@@ -1266,6 +1319,7 @@ elif host_machine.system() == 'windows'
   ]
 
   libgit_dependencies += compiler.find_library('ntdll')
+  libgit_dependencies += compiler.find_library('userenv')
   libgit_include_directories += 'compat/win32'
   if compiler.get_id() == 'msvc'
     libgit_include_directories += 'compat/vcbuild/include'
@@ -1702,14 +1756,16 @@ version_def_h = custom_target(
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
diff --git a/meson_options.txt b/meson_options.txt
index 1668f260a1..362e928c79 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -69,6 +69,8 @@ option('zlib_backend', type: 'combo', choices: ['auto', 'zlib', 'zlib-ng'], valu
   description: 'The backend used for compressing objects and other data.')
 
 # Build tweaks.
+option('with_rust', type: 'boolean', value: true,
+       description: 'Enable building with Rust, true by default.')
 option('breaking_changes', type: 'boolean', value: false,
   description: 'Enable upcoming breaking changes.')
 option('macos_use_homebrew_gettext', type: 'boolean', value: true,
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
new file mode 100644
index 0000000000..9bc2f769fb
--- /dev/null
+++ b/rust/Cargo.toml
@@ -0,0 +1,3 @@
+[workspace]
+members = []
+resolver = "2"
-- 
gitgitgadget


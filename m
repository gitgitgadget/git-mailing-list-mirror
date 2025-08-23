Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D203205E26
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 03:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755921366; cv=none; b=urPOMRu/K3kGD/7hYgx0fpiJjpuE+lXmcyfpvCa99hwSpjCDgtUxBsLJG7mxXIB/EUBqB3Us27Pyo6gu/kX5ui6sTJaRDwYm4F+FF0sDFot8iBO4DtETXE5FbCUwgio9XoGW4CE46F/bJC4tBgvpZYE8iwOs+3MkEay2ZB641Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755921366; c=relaxed/simple;
	bh=72NjIrnZi7l6khB+RDjxUR3MI7LapWGWjlj6gTefHtM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VQlw01BLSKl2kMVASaE/148hy/huptRiwRPwywqEeaIweB2JATQEPoyBw2QAwhG+0JkVFJUBAaB9mPX7FEPU7TVBJswTkQK4h4/czClg/vucI446PUsx4ex3Afao9TgCml3ZlTI6e4+RLzJkFuZvlBe171D5AL3dBn1RiCfplNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BajHQPeC; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BajHQPeC"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3c763484ccdso89489f8f.0
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 20:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755921362; x=1756526162; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPUPCZT4ujn8EGmaUAJ/YDQXZWRpAPu4aBjS2hFp69k=;
        b=BajHQPeC7PW3ku79p2WNqRt1wDFJstAIFTnK8nacQJzpshqdeUuM1hE3hy0thbH5fQ
         KalI5ExVfWzrTg4cDmwyHt2BM3WV+7gqBTa9tvmGY0p5yqLdaY7VrPTsp0HXe1IUNjnV
         rpZ6EQakW4rxsAJKXpHoXpr12xaHLk9aLdyER6MfQxnRFH48kOmoHhPCLaqiY28VAmLA
         Tx2Y/sbktCnWecx40jikCQ/BcsHYzxEMyy5W8OzKQBovZgh1IiFZznC1vrdyGkMaFzwo
         sFVponoO0mgdmb5n59NZgaazqpw5DT4Xd24TZxMFy/GwVlCR/OzqeTcM1+2eYWZi1dsC
         W8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755921362; x=1756526162;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPUPCZT4ujn8EGmaUAJ/YDQXZWRpAPu4aBjS2hFp69k=;
        b=iqh42J7vkpfoqFpFecP2/MeYhZPZ8LfTQE85r4PMjb3XMhO/tLvtwK1uKQcmPZNMBW
         VwQFyCZfvdnGRFwTObQBcR97d1DA/NunZwHRlkzse6xICIlZpU7vgEOlHKiTl2msnkwA
         Q0/xOkohwpkDLsK3YhJIy8UElfBlJmBtMu0OdqNxTATKvxlk0sblMcmM7YrlPu/xXOZk
         LV5gbXq3lvIhaejPIC2vt7Kvd6niGVEtZydW8SnEG5ynOZFYSfL2SumUUn59LKec/chs
         jP0ZnfApVOvE1WbulS869Ca+hNXMNWUcRIQ02UgqIS4dPemlEcmtnG5TMENJmdmAdgN8
         /Tlw==
X-Gm-Message-State: AOJu0YyoD89qtpfqnHzH1RWmid7ELbzXeEsTELfoA2toXcEAXQr8NcoF
	g/JJIsoT6vLo5LdVDYBIdzmFUtABWK2J6eCHKXkHoaHzxzmk9mSoYFeoOU6BTw==
X-Gm-Gg: ASbGncsEi4Rz9XY6/Oqk4Rjo3XUHh8Leqfag2T4hGfmrbUL01zIKJ57v0xVSTDRNT/i
	wZuMPmBa6UZ3VbUDhCH5gYU3GcCosokbwgIzmCAegQPkWU8bhIbLn/0LZpa7oblyYN+Y7XO5nAS
	jvkKtgJV71lkXWpSvzVdXVMMMyeSpyzK3P94HbUh7obmGlK8MCkLDftrRF28XypDAUgh4kqldnu
	aWL+C5VRvkbfM8Vm8I/jSBB0/qMFnT7ZpCB177SkpuA1aTqC1RQDUGra3BYgT1bfu/LZrEVwuFZ
	n6M/fBrkzQ7sRRcHehvoNA1mZ/pCULEn4BIoBl99RWgQkz6DdIpHadaC1P3O14MnF8XQmxdlBas
	rMomWygQB1V9BmABM3m89Low3yBs=
X-Google-Smtp-Source: AGHT+IE92tYuJ0325weEB8feqJkb0Kk2Pq1Bxbx+dHvDErh5XlpTk+r4NBAGGzWw2fTI+F5vSMlE7g==
X-Received: by 2002:a05:6000:2509:b0:3a4:cec5:b59c with SMTP id ffacd0b85a97d-3c4b0c15702mr5501813f8f.25.1755921362035;
        Fri, 22 Aug 2025 20:56:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70ef568e5sm1814309f8f.25.2025.08.22.20.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 20:56:01 -0700 (PDT)
Message-Id: <03939951256baaaec3fcc690cfa38ee12fb553ce.1755921357.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
References: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
	<pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Aug 2025 03:55:43 +0000
Subject: [PATCH v3 02/15] xdiff: introduce rust
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
    Ezekiel Newren <ezekielnewren@gmail.com>,
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
index 04c444404e4b..ff81e3580c4e 100644
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
index 70d1543b6b86..1ec0c1ee6603 100644
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
index 000000000000..192385a1d961
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
index 4678e21c4cb8..82dc99764ac0 100644
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
index 596f5ac7110e..324f968338b9 100644
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
index 000000000000..ed3d79d7f827
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
index 000000000000..045e3b01cfad
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
index 000000000000..e69de29bb2d1
diff --git a/rust/xdiff/Cargo.toml b/rust/xdiff/Cargo.toml
new file mode 100644
index 000000000000..eb7966aada64
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
index 000000000000..e69de29bb2d1
-- 
gitgitgadget


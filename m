Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA851448E0
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 01:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755220980; cv=none; b=FEWZ65Oh+WmZLY1MGrGEuXvro+PgoGf1t4jErT2kEWnjKH3PDUIwV7CqgQ/8lQ04fMplqZsjht+f7AmYU0EIuTPDA0F2EswpbatdNPzGGV13oxE5to3HUy8iaIZSE08SMuxqz5NZE3eBRidNugetBUUJy06pNF6o0FK2Jqnu/bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755220980; c=relaxed/simple;
	bh=+6HY2/oeH9j5LYIRHMroeuUv2dq90ZyCsnGwrS3zDks=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uO4L6C9F9L41UX5pNlfCQF070opwsmw82Imzi+loCzZ12C2p3C6I9nsPAVdx8pkapX27KeaXVrJ/TZbotZl4nOlM32XkvNG7wcBxqxEY90b64F5UH/jWVeUAx/MQpiVRKSPqCgKZN5bZiSl1TIqpkBqN/DsVt6eCx4szykNqFcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLeQF1wN; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLeQF1wN"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b916fda762so1232190f8f.0
        for <git@vger.kernel.org>; Thu, 14 Aug 2025 18:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755220977; x=1755825777; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBK4AovKEIcsh5G1PJwgviDIExbPfBRO9qD70WeIHrI=;
        b=KLeQF1wNtavDvnBQ5y772YvMZo781vS2gW9yDLObgzgx8NuVyhI+EwvvJB0jv/fjqB
         G39IOocUxZ23qMUZRwMyLA+I+OMjONYPr9wl9LBeQxl4RucB79bcetiAcFIYtIEhjtzn
         j4U7sPq8E9jfknow91f3GfHfC+cy3Mepi+GrCq84ZCr6rxicQSoaAWmlNc3OWJLNI5pX
         qBk+G+KTYS/TI4WDHvA8lSwILBwbPkSJQozPAD56moO5WZS8lvy32rZZE6ZRkPCeLalP
         8mPT2fu84HBCp+IkS0ju1e8NePH0uF0lLam6lZcD3jYihektKJu7nQ1k0NClP5iQz2dF
         eNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755220977; x=1755825777;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBK4AovKEIcsh5G1PJwgviDIExbPfBRO9qD70WeIHrI=;
        b=DmgWM3fnrPOoFmQGvSR7hJVyeW5Cyv+r9lqRHYJp3RkkUlcDRQJiWys35YLbzM2nxt
         9utyWeKpGYLuqrdNkqBAh/cR7sGmWhHZKepZFUq88QYIymK61SU/SGAxB/wjEXtoccD3
         utDl/rb2FYA+VMIXpmN1ruRuUSEWQg11Swgej3PEZll9hng9Tcw/LuaRqjaHYf0TrYDf
         Ihknpwmd5I2tzzQAC6UD2N0bBF9d/KkWzaSc38e9DiYLRnkvpFIWNnDfoPP5SDFRd8pR
         MVZj34SWzhafVuUWiU+Ew5icESqYOo1ZFoig1iYIdPzyEnqe5QQVwetdxm1XQ1FLl9JI
         oMuQ==
X-Gm-Message-State: AOJu0Yyd28l/1t2ek/QEJUgAR1bowxQyTUuNWmNWOCueiHpWyNFhyi/T
	FCMYZ8gDMff1yHWD1fL4jEvDUbLquMSEOcO68faxmrO9hs8ycdshKRN7PpxhOw==
X-Gm-Gg: ASbGncuUuXqasWGdGV4soa9FlY/TylNQfkTg9ghWA3xW6GNtT4ZFZs5lCCHaA9y0eE+
	pKPp/UDNPmZQi4nTHu0t3U51+NxaX9qlnvQy0KQtIpm65aNsr85yOmU2KcVDjz3Gfy26qqaz9i0
	PWRc6w+c1lvnaYo7UZBO1LGL+Tnvy/X343SRlTbnOglFZdFnH5oHNthU5n91QRJjzIw7Cvacrt0
	9KYhcQ1IY9ppMDzbgc30tFKFrVmOkBPeXoON4bJY6lxOc5l6lmsFv0l56FW2hKkfQPNQiYGjAeV
	brTRRjlKNBjEc5T2UTi1Q7CaJecHD3Jb0HdkfY3tuoxyBmgZw2TQBiYaZp1gITMhrty662yzORY
	+UhuKGXWNI3aLywxeCM1GDa4=
X-Google-Smtp-Source: AGHT+IH4O7xVH7Tym9TP1DK8YOWYx3axraOTku4CV0L6JOP+XqlHeyNzjYmGggnYDrT2O8SyUAg0nQ==
X-Received: by 2002:a05:6000:24ca:b0:3b8:de54:6e64 with SMTP id ffacd0b85a97d-3bb4d23f605mr272283f8f.26.1755220976487;
        Thu, 14 Aug 2025 18:22:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb676c96dasm108604f8f.43.2025.08.14.18.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 18:22:55 -0700 (PDT)
Message-Id: <7709e5eddba671db0e772724c0c71516d18f2cb2.1755220973.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
	<pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 Aug 2025 01:22:37 +0000
Subject: [PATCH v2 02/17] xdiff: introduce rust
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
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Upcoming patches will accelerate and simplify xdiff, while also
porting parts of it to Rust. In preparation, add some stubs and setup
the Rust build. For now, it is easier to let cargo build rust and
have make or meson merely link against the static library that cargo
builds. In line with ongoing libification efforts, use multiple
crates to allow more modularity on the Rust side. xdiff is the crate
that this series will focus on, but we also introduce the interop
crate for future patch series.

In order to facilitate interoperability between C and Rust, introduce
C definitions for Rust primitive types in git-compat-util.h.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 .gitignore              |  3 +++
 Makefile                | 20 +++++++++++++++++++-
 git-compat-util.h       | 17 +++++++++++++++++
 meson.build             | 32 ++++++++++++++++++++++++++++++++
 rust/Cargo.toml         |  6 ++++++
 rust/interop/Cargo.toml | 14 ++++++++++++++
 rust/interop/src/lib.rs |  0
 rust/xdiff/Cargo.toml   | 15 +++++++++++++++
 rust/xdiff/src/lib.rs   |  0
 9 files changed, 106 insertions(+), 1 deletion(-)
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
index 70d1543b6b86..db39e6e1c28e 100644
--- a/Makefile
+++ b/Makefile
@@ -919,6 +919,11 @@ TEST_SHELL_PATH = $(SHELL_PATH)
 
 LIB_FILE = libgit.a
 XDIFF_LIB = xdiff/lib.a
+ifeq ($(DEBUG), 1)
+RUST_LIB = rust/target/debug/libxdiff.a
+else
+RUST_LIB = rust/target/release/libxdiff.a
+endif
 REFTABLE_LIB = reftable/libreftable.a
 
 GENERATED_H += command-list.h
@@ -1392,6 +1397,8 @@ UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
 GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
 EXTLIBS =
 
+GITLIBS += $(RUST_LIB)
+
 GIT_USER_AGENT = git/$(GIT_VERSION)
 
 ifeq ($(wildcard sha1collisiondetection/lib/sha1.h),sha1collisiondetection/lib/sha1.h)
@@ -2925,6 +2932,14 @@ $(LIB_FILE): $(LIB_OBJS)
 $(XDIFF_LIB): $(XDIFF_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
+.PHONY: $(RUST_LIB)
+$(RUST_LIB):
+ifeq ($(DEBUG), 1)
+	cd rust && RUSTFLAGS="-Aunused_imports -Adead_code" cargo build --verbose
+else
+	cd rust && RUSTFLAGS="-Aunused_imports -Adead_code" cargo build --verbose --release
+endif
+
 $(REFTABLE_LIB): $(REFTABLE_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
@@ -3756,7 +3771,10 @@ cocciclean:
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
index 596f5ac7110e..2d8da17f6515 100644
--- a/meson.build
+++ b/meson.build
@@ -267,6 +267,36 @@ version_gen_environment.set('GIT_DATE', get_option('build_date'))
 version_gen_environment.set('GIT_USER_AGENT', get_option('user_agent'))
 version_gen_environment.set('GIT_VERSION', get_option('version'))
 
+if get_option('optimization') in ['2', '3', 's', 'z']
+  rust_target = 'release'
+  rust_args = ['--release']
+  rustflags = '-Aunused_imports -Adead_code'
+else
+  rust_target = 'debug'
+  rust_args = []
+  rustflags = '-Aunused_imports -Adead_code -C debuginfo=2 -C opt-level=1 -C force-frame-pointers=yes'
+endif
+
+
+rust_leaf = custom_target('rust_leaf',
+  output: 'libxdiff.a',
+  build_by_default: true,
+  build_always_stale: true,
+  command: ['cargo', 'build',
+            '--manifest-path', meson.project_source_root() / 'rust/Cargo.toml'
+  ] + rust_args,
+  env: {
+    'RUSTFLAGS': rustflags,
+  },
+  install: false,
+)
+
+rust_xdiff_dep = declare_dependency(
+  link_args: ['-L' + meson.project_source_root() / 'rust/target' / rust_target, '-lxdiff'],
+#  include_directories: include_directories('xdiff/include'),  # Adjust if you expose headers
+)
+
+
 compiler = meson.get_compiler('c')
 
 libgit_sources = [
@@ -1677,6 +1707,8 @@ version_def_h = custom_target(
 )
 libgit_sources += version_def_h
 
+libgit_dependencies += rust_xdiff_dep
+
 libgit = declare_dependency(
   link_with: static_library('git',
     sources: libgit_sources,
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


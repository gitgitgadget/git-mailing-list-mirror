Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A6D1DB127
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 20:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752784350; cv=none; b=lwyiNd/KD5s2OPf+eC5MrQJxV9sqi8rf/JwT08NB6rP6xLBHqCAvKDkAE1x4/4L+EVgGxNiWqbV8sOvCaT9hTSfDpT9RBfk//EOPGeYHVpQZ68Cck+I6vq3DY0WlyDkZ2BmqwgYEMSkYDzt1qc9Ii+D7Whii6UcHY9M66mgCPI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752784350; c=relaxed/simple;
	bh=2EAbpZqBofj/DrkQIjuoDmwWrIdnwjL/fcncNZo6oy8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PKjRxtIlgPheYaabDUPNSOhi/FoGWPLsmy83Uyi9Gut7p/czF0blIPLXnw/TWiKBfhb2Ol0cQGsW1fL6T2ydQfC+tsL4WRvtBxJBwaks08OsS2HMAaB7oDXw3wVjcQcg/amTPooSHHxigfThf1XlgXpeI7NNYBBkDLpRWYVp66c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRltiNNv; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRltiNNv"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so1559879f8f.1
        for <git@vger.kernel.org>; Thu, 17 Jul 2025 13:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752784347; x=1753389147; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJWwypYEEhBSRw7y+1nLeVPmmueBioLcN48P/FH+X0I=;
        b=hRltiNNvtotbMBw0b6m+QgxaWICH4xp3WNCKRXpIRYLkaTdsIvSvhfrdX07OJzGkaf
         mXFFjvo7g1HEq+mUGUlzXpEWHj8fpzkcPYd4RZ8uSdiB6z+I+37x9/WgoHXBv02Ulfxz
         bscpFXdsBWpNWI9+tiWsTqLnObsdTB2RzXauROQHdRaikDofLL6B3lXnX+COCVDBIUC+
         Abq45EEUy9gruVbgSvshBTEEBX6ZIR2HGw/Ge+z5XPrnE7oQ5Sko/6E2AQMyXnpYK0Af
         tFNzueWawujpCBY+q1OkqUPU8XzwaBqeB/EjnjVnuqnvAiv9XsLzvULYgEbPpeBwloA1
         E2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752784347; x=1753389147;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJWwypYEEhBSRw7y+1nLeVPmmueBioLcN48P/FH+X0I=;
        b=K7ClZAEEXCC/f6ZZcJlKoIWqWy/IrvLGLfMFrtTU4KrADYcqGtIiIChkgf2FpMDmC5
         rWG16qnYty03kDea0heaj5VbCsdpxj+Kbqf9QnpJPpXqLlesNMm62wnBrbFOLDbDrLvq
         Md694ymIZZgZvprB5iFvs5BWtlpNHFB6m6FkP+1M1DfdvAx9x+lnsjohdHsNcFGY/KM/
         v41Adni4LOW/EIaqsT/Izm6Cd8F1Z/5ZNr6Bz3i9qk5z0XAMzae3Wb3x+NSyF22/Lvsy
         WSRq4TRtr6KIn/Ziv2jqGP38myGMeW1W00q4wAeZJ9S/OK9hR4CUY+82B72N9Ou8exL3
         wklg==
X-Gm-Message-State: AOJu0Ywt9+g+lGO9SzV96r/mVtI/YMv0mE8xPbDX3nEeVuSEl1Vdvu6B
	U0L00pTMpyCi3RrEu3TVsif6S3Fh+qlO9G8sg4LD/UZiccTL3+eoq/uUyxXRhQ==
X-Gm-Gg: ASbGncvh4oaajbPODoK0oDBRRzShTFJoit/6e2cT/9qWjsf1+mSBFzaYra2Ngqm9Y0P
	Z0Ue/wiNyvhLfJjq6W62tCXYlRGDmdaqPhjygIvfFNG1eGkf42RlMdeOzOzxxPaGdfh240Iz5TX
	CZNfpcbQ0BoAw7piDRA1CJkdoP6TOCRc1ghaNkK4qj6JM1b20JkFOArkZy9OSW+oryu75hB9T98
	ti7Z61cSSZxTgNiSw/YcQbXVtyQi4t4kbNBIxbE07vDU7oFomlY8Ed1p4YToTjGkePOS3h+9NHR
	NwiX6tqQa0mg1tpkb3DbUCML06mqnhHTvZi7zkc+pNNvYcpxMQTt8+sqBeP58TtcL7e7UPQ0FkF
	Ugobs6D3o5i71DQCBo9OpCow=
X-Google-Smtp-Source: AGHT+IGhFtHajbMDEnIzHmMKxSxbzuUohSM8cIWzFaEt60EfsjU+Z29E5OwIVuMSYg4A5qZ3OxB62A==
X-Received: by 2002:a05:6000:2383:b0:3a3:64b9:773 with SMTP id ffacd0b85a97d-3b613ab2bb8mr3988855f8f.10.1752784346919;
        Thu, 17 Jul 2025 13:32:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d867sm21823147f8f.61.2025.07.17.13.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 13:32:26 -0700 (PDT)
Message-Id: <2a1f4be13dfbdee21811b7a4907f99042c791c2d.1752784344.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 17 Jul 2025 20:32:18 +0000
Subject: [PATCH 1/7] xdiff: introduce rust
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
 Makefile                | 20 +++++++++++++++++++-
 git-compat-util.h       | 17 +++++++++++++++++
 meson.build             | 32 ++++++++++++++++++++++++++++++++
 rust/Cargo.lock         | 14 ++++++++++++++
 rust/Cargo.toml         |  6 ++++++
 rust/interop/Cargo.toml | 14 ++++++++++++++
 rust/interop/src/lib.rs |  0
 rust/xdiff/Cargo.toml   | 15 +++++++++++++++
 rust/xdiff/src/lib.rs   |  0
 9 files changed, 117 insertions(+), 1 deletion(-)
 create mode 100644 rust/Cargo.lock
 create mode 100644 rust/Cargo.toml
 create mode 100644 rust/interop/Cargo.toml
 create mode 100644 rust/interop/src/lib.rs
 create mode 100644 rust/xdiff/Cargo.toml
 create mode 100644 rust/xdiff/src/lib.rs

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
diff --git a/rust/Cargo.lock b/rust/Cargo.lock
new file mode 100644
index 000000000000..fb1eac690b39
--- /dev/null
+++ b/rust/Cargo.lock
@@ -0,0 +1,14 @@
+# This file is automatically @generated by Cargo.
+# It is not intended for manual editing.
+version = 4
+
+[[package]]
+name = "interop"
+version = "0.1.0"
+
+[[package]]
+name = "xdiff"
+version = "0.1.0"
+dependencies = [
+ "interop",
+]
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


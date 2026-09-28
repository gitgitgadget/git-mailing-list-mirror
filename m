Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D256534C98C
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 15:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610699; cv=none; b=aShm4G07QpEaWPpDVIuXKsXWYuv663vR0cCAIhuo67K9xNnfABM5izBh1mtsI4rN2kv9LBKLcbI1EfSvc3unVXjrQfrTMN1ohdhWCxPL91XkTxyQIsyMdBK1Css3/yuqxpZiqxsh51tNMMsMMutFpbE7iU2B0RFb11ZwBkMnnrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610699; c=relaxed/simple;
	bh=NZtREitMkzEy+JHtTdUgD2gG3I5drhugsrgz9STxjeo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=F00st0NkaMIbJh+RHAbTfBPBlQQXQHt0y0Fn0tbv2E4QEvhEh3+oSPTlnqytNa6jm+e2j+xv0i6NCtVsJfTI6Fula976+pKHhNT2JcTcP2+RA1mhppf+SVgBgy+okd8MI/S0dgQ68PacH5VgRCDoRkTY1+ZrAhbQ0bBUuWIw/bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9MhqNBu; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9MhqNBu"
Received: by mail-pz2-f39.google.com with SMTP id d2e1a72fcca58-88103e47f72so2017550b3a.2
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 08:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790610696; x=1791215496; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wG8JygTXqyEaNqCev8qItqD5DwoXyqYoCUd3h/NMLfM=;
        b=W9MhqNBuKDd5EndJ+YG47QVTkUMS289Wo1vknOCydSq9g5txmoaCwG1VfaWzmaNAHb
         zfKK/dQcuZ7FWMlB1iECTVQHDbdQajKOayjSWWLv2kUjuAbyp9K/XdFxVZs8yBY4gIRw
         FXz92F8396ISqCVNzs+BvuJBEBZ3MyLroNOJbnqXBq6DTu03/oP4XK/uTnr32srpN+j1
         x05xZNaTqJcKP2I8X7sGVgvhGENrOZjmwHnIoW1138KAljNuh8qd37v9UogoPzCwaT2f
         J4HBL3m6pj5WfCa6JxCZD/3JX6BKDJJZzjzB4wMEWwBsHTuZ2mEie2RosMAEA7U6tS0r
         rtew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790610696; x=1791215496;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wG8JygTXqyEaNqCev8qItqD5DwoXyqYoCUd3h/NMLfM=;
        b=vP0rmhbzHwC2xwfuDqc4bQ8Udyo2nguW2Bbhzvy6r3TINZI1fVYjLaOkxRwRo0MQ77
         9jIOYrNqNjIrPMrE05XFVjIuFSYi4lQ8fsponEFf+DEu7jaNiaD0eUrdnz8AMqDcm/gM
         Ab2n2gp7IvNdAVlET/7menssobbGrF9aFE6+OAucVWLGoOXQ1lNHshlf3Zu1xMTxUBie
         HFl7JAeEeLyWWZGxG82s1ALWN45g/PXzuqrN4DB63x0mH49aCDNq15YLwcmZqfWzkTjy
         yQwFKVIswgLq+hns3nAw3KE8AXO/yX8DU+HSVq9unhlK9f98GQH5I0jD8xlm3Kfqw7e2
         s19w==
X-Gm-Message-State: AFuF++n7NupmHzcF7pJMebsEDU+3qIsIjWd2rC+uUSR6Eg26NATLlLzl
	Mqm4Gf1k3Cf4Aj6GY3NqCLXB5OV37p6kf/DQ8m/ehxv3CJjOA70b88nVdbr2Bze+
X-Gm-Gg: AYBFou2EXFQpC6b0OJmeexi3F3Bmt5rbBte3Ovzt+5l0XRoNNjig/UuM8ds89dyPv0G
	LGBE7/icKWs6UMEyHkIAR2kli1MPnqLzxCsEOZ7pYyImeLlQ0Fn0oWlSbwhiYouzG+QYQHKrV/P
	/O8QiFU8RxpEl196kaLCYNK3dYKGnYDc68EALeCNGbIRGc+W+q9T+my3rHt9YA7nUOy0qjEMRbL
	Ka/7WKxTSdFEtKO/A6pam1T9d0Tug3UFzVlwP7/1RNa037lpb0Sl6LrTN11Hs/o1skIzjnBCkL6
	D7WI5fk2GaxFYlU9lYOvIXas28URi1LMsqS8brghbHv+AoX3DO/qbhRrAqLnErb5RFoAJ5ccjdp
	PFxir3ngxwGrCz2pF2jvWF5QDznOjGwhuB0iVnJH4/gHOcEn7RLr6/TB5iQXMsSaVLq/pVD2uYt
	dC9a89E6/KgiIM5qdjBcsLSfAiZu91FsL3VAh8vIsnQVuhiTAyi3STzqKds51dYwvMRn1SysGtJ
	w==
X-Received: by 2002:a05:6a00:428d:b0:878:34d7:6a24 with SMTP id d2e1a72fcca58-87e9b3ba9b1mr9855721b3a.38.1790610695877;
        Mon, 28 Sep 2026 08:51:35 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.102.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87fea889d20sm4373516b3a.28.2026.09.28.08.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 08:51:35 -0700 (PDT)
Message-Id: <5a414a4babf9cb755b4cf43eb42d1f06c8b45d6c.1790610691.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2240.git.1790610691.gitgitgadget@gmail.com>
References: <pull.2240.git.1790610691.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 28 Sep 2026 15:51:29 +0000
Subject: [PATCH 2/4] sha1dc: allow selecting the C backend without rebuilding
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The Rust `sha1dc` create is really new. While it produced only correct
hashes in my hands, before unleashing this to the masses, we need to
provide an "escape hatch" in case it doesn't do the right thing.

Therefore, when building with `DC_SHA1_RS`, use the Rust `sha1dc` by
default, yet also offer to use the C version of `sha1dc` via
`core.sha1dcBackend=c` (and `core.sha1dcBackend=rust` to select Rust
explicitly).

This is made possible by a set of function pointers that are initialized
upon the first call to the `git_hash_init()` function.

Note that the order in which `hex.h` and `sha1dc_git.h` are included in
`sha1dc_git.c` now have to be turned the other way round, to avoid
redefining the `platform_SHA*` constants.

Assisted-by: GPT-6 Sol
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config/core.adoc |  5 +++
 Makefile                       | 10 +++---
 sha1dc_git.c                   | 60 +++++++++++++++++++++++++++++++---
 sha1dc_git.h                   |  5 +--
 sha1dc_rs.h                    | 30 ++++++++++++-----
 src/sha1dc_rs.rs               | 18 ++++++----
 t/helper/test-sha1.c           | 19 ++++++++++-
 t/t0013-sha1dc.sh              | 21 +++++++++++-
 8 files changed, 141 insertions(+), 27 deletions(-)

diff --git a/Documentation/config/core.adoc b/Documentation/config/core.adoc
index 340329edc3..2ef56a107e 100644
--- a/Documentation/config/core.adoc
+++ b/Documentation/config/core.adoc
@@ -382,6 +382,11 @@ core.repositoryFormatVersion::
 	Internal variable identifying the repository format and layout
 	version. See linkgit:gitrepository-layout[5].
 
+core.sha1dcBackend::
+	Select the collision-detecting SHA-1 implementation when Git is built
+	with `DC_SHA1_RS`: valid values are `rust` (the default) and `c` (the C
+	fallback). This setting has no effect with other SHA-1 backends.
+
 core.sharedRepository::
 	When 'group' (or 'true'), the repository is made shareable between
 	several users in a group (making sure all the files and objects are
diff --git a/Makefile b/Makefile
index 0c321494cf..31afa7d917 100644
--- a/Makefile
+++ b/Makefile
@@ -567,8 +567,9 @@ include shared.mak
 # by the git project to migrate to using sha1collisiondetection as a
 # submodule.
 #
-# Define DC_SHA1_RS to use the sha1dc Rust crate instead of the default
-# C implementation. This requires Rust 1.87 or newer.
+# Define DC_SHA1_RS to use the sha1dc Rust crate by default, with the C
+# implementation available via core.sha1dcBackend=c. This requires Rust
+# 1.87 or newer.
 #
 # === SHA-256 backend ===
 #
@@ -2170,6 +2171,7 @@ ifdef APPLE_COMMON_CRYPTO_SHA1
 	BASIC_CFLAGS += -DSHA1_APPLE
 else
 	BASIC_CFLAGS += -DSHA1_DC
+	LIB_OBJS += sha1dc_git.o
 ifdef DC_SHA1_RS
 	BASIC_CFLAGS += -DDC_SHA1_RS
 	CARGO_ARGS += --features sha1dc-rs
@@ -2177,8 +2179,7 @@ ifdef DC_SHA1_RS
 ifeq ($(uname_S),MINGW)
 	EXTLIBS += -luserenv
 endif
-else
-	LIB_OBJS += sha1dc_git.o
+endif
 ifdef DC_SHA1_EXTERNAL
         ifdef DC_SHA1_SUBMODULE
                 ifneq ($(DC_SHA1_SUBMODULE),auto)
@@ -2205,7 +2206,6 @@ endif
 endif
 endif
 endif
-endif
 
 ifdef OPENSSL_SHA1_UNSAFE
 ifndef OPENSSL_SHA1
diff --git a/sha1dc_git.c b/sha1dc_git.c
index fe58d7962a..dcc5c1ca8e 100644
--- a/sha1dc_git.c
+++ b/sha1dc_git.c
@@ -1,6 +1,13 @@
+#ifdef DC_SHA1_RS
+#define USE_THE_REPOSITORY_VARIABLE
+#endif
 #include "git-compat-util.h"
-#include "sha1dc_git.h"
 #include "hex.h"
+#include "sha1dc_git.h"
+#ifdef DC_SHA1_RS
+#include "config.h"
+#include "repository.h"
+#endif
 
 #ifdef DC_SHA1_EXTERNAL
 /*
@@ -16,12 +23,13 @@ void git_SHA1DCInit(SHA1_CTX *ctx)
 /*
  * Same as SHA1DCFinal, but convert collision attack case into a verbose die().
  */
-void git_SHA1DCFinal(unsigned char hash[20], SHA1_CTX *ctx)
+void git_SHA1DCFinal(unsigned char hash[20], SHA1_CTX *ctx,
+		     void (*die_fn)(const char *, ...))
 {
 	if (!SHA1DCFinal(hash, ctx))
 		return;
-	die("SHA-1 appears to be part of a collision attack: %s",
-	    hash_to_hex_algop(hash, &hash_algos[GIT_HASH_SHA1]));
+	die_fn("SHA-1 appears to be part of a collision attack: %s",
+	       hash_to_hex_algop(hash, &hash_algos[GIT_HASH_SHA1]));
 }
 
 /*
@@ -37,3 +45,47 @@ void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *vdata, size_t len)
 	}
 	SHA1DCUpdate(ctx, data, len);
 }
+
+#ifdef DC_SHA1_RS
+static void sha1dc_c_clone(SHA1_CTX *dst, const SHA1_CTX *src)
+{
+	*dst = *src;
+}
+
+static void sha1dc_c_discard(SHA1_CTX *ctx UNUSED)
+{
+	/* The C context owns no resources. */
+}
+
+/* The first SHA-1 initialization must precede concurrent hashing. */
+static void sha1dc_choose(SHA1_CTX *ctx);
+
+void (*sha1dc_init)(SHA1_CTX *) = sha1dc_choose;
+void (*sha1dc_clone)(SHA1_CTX *, const SHA1_CTX *);
+void (*sha1dc_update)(SHA1_CTX *, const void *, size_t);
+void (*sha1dc_final)(unsigned char [20], SHA1_CTX *,
+		     void (*die_fn)(const char *, ...));
+void (*sha1dc_discard)(SHA1_CTX *);
+
+static void sha1dc_choose(SHA1_CTX *ctx)
+{
+	const char *backend;
+	int use_c = 0;
+
+	if (!repo_config_get_string_tmp(the_repository, "core.sha1dcbackend",
+					&backend)) {
+		if (!strcasecmp(backend, "c"))
+			use_c = 1;
+		else if (strcasecmp(backend, "rust"))
+			die("invalid value for core.sha1dcBackend: '%s'",
+			    backend);
+	}
+
+	sha1dc_clone = use_c ? sha1dc_c_clone : sha1dc_rs_clone;
+	sha1dc_update = use_c ? git_SHA1DCUpdate : sha1dc_rs_update;
+	sha1dc_final = use_c ? git_SHA1DCFinal : sha1dc_rs_final;
+	sha1dc_discard = use_c ? sha1dc_c_discard : sha1dc_rs_discard;
+	sha1dc_init = use_c ? git_SHA1DCInit : sha1dc_rs_init;
+	sha1dc_init(ctx);
+}
+#endif
diff --git a/sha1dc_git.h b/sha1dc_git.h
index 0bcf1aa84b..4c4aefe3e8 100644
--- a/sha1dc_git.h
+++ b/sha1dc_git.h
@@ -14,7 +14,8 @@ void git_SHA1DCInit(SHA1_CTX *);
 #define git_SHA1DCInit	SHA1DCInit
 #endif
 
-void git_SHA1DCFinal(unsigned char [20], SHA1_CTX *);
+void git_SHA1DCFinal(unsigned char [20], SHA1_CTX *,
+		    void (*die_fn)(const char *, ...));
 void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *data, size_t len);
 
 #define platform_SHA_IS_SHA1DC /* used by "test-tool sha1-is-sha1dc" */
@@ -23,5 +24,5 @@ void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *data, size_t len);
 #define platform_SHA_CTX SHA1_CTX
 #define platform_SHA1_Init git_SHA1DCInit
 #define platform_SHA1_Update git_SHA1DCUpdate
-#define platform_SHA1_Final git_SHA1DCFinal
+#define platform_SHA1_Final(hash, ctx) git_SHA1DCFinal((hash), (ctx), die)
 #endif
diff --git a/sha1dc_rs.h b/sha1dc_rs.h
index 35e3865d72..e5d6345363 100644
--- a/sha1dc_rs.h
+++ b/sha1dc_rs.h
@@ -1,9 +1,15 @@
 #ifndef SHA1DC_RS_H
 #define SHA1DC_RS_H
 
-#define platform_SHA_IS_SHA1DC /* used by "test-tool sha1-is-sha1dc" */
+#define platform_SHA_CTX union sha1dc_ctx
+#include "sha1dc_git.h"
 
-typedef struct sha1dc_rs_hasher *SHA1_CTX;
+typedef struct sha1dc_rs_hasher *sha1dc_rs_ctx;
+
+union sha1dc_ctx {
+	SHA1_CTX c;
+	sha1dc_rs_ctx rs;
+};
 
 void sha1dc_rs_init(SHA1_CTX *);
 void sha1dc_rs_clone(SHA1_CTX *, const SHA1_CTX *);
@@ -12,12 +18,20 @@ void sha1dc_rs_final(unsigned char [20], SHA1_CTX *,
 		     void (*die_fn)(const char *, ...));
 void sha1dc_rs_discard(SHA1_CTX *);
 
-#define platform_SHA_CTX SHA1_CTX
-#define platform_SHA1_Init sha1dc_rs_init
-#define platform_SHA1_Update sha1dc_rs_update
-#define platform_SHA1_Final(hash, ctx) sha1dc_rs_final((hash), (ctx), die)
+extern void (*sha1dc_init)(SHA1_CTX *);
+extern void (*sha1dc_clone)(SHA1_CTX *, const SHA1_CTX *);
+extern void (*sha1dc_update)(SHA1_CTX *, const void *, size_t);
+extern void (*sha1dc_final)(unsigned char [20], SHA1_CTX *,
+			    void (*die_fn)(const char *, ...));
+extern void (*sha1dc_discard)(SHA1_CTX *);
+
+#define platform_SHA1_Init(ctx) sha1dc_init(&(ctx)->c)
+#define platform_SHA1_Update(ctx, data, len) \
+	sha1dc_update(&(ctx)->c, (data), (len))
+#define platform_SHA1_Final(hash, ctx) \
+	sha1dc_final((hash), &(ctx)->c, die)
 #define SHA1_NEEDS_CLONE_HELPER
-#define platform_SHA1_Clone sha1dc_rs_clone
-#define platform_SHA1_Discard sha1dc_rs_discard
+#define platform_SHA1_Clone(dst, src) sha1dc_clone(&(dst)->c, &(src)->c)
+#define platform_SHA1_Discard(ctx) sha1dc_discard(&(ctx)->c)
 
 #endif
diff --git a/src/sha1dc_rs.rs b/src/sha1dc_rs.rs
index df075a5d83..b9c430d0dc 100644
--- a/src/sha1dc_rs.rs
+++ b/src/sha1dc_rs.rs
@@ -1,5 +1,5 @@
 use sha1dc::Hasher;
-use std::ffi::CString;
+use std::ffi::{c_void, CString};
 use std::os::raw::c_char;
 use std::{ptr, slice};
 
@@ -8,7 +8,8 @@ use std::{ptr, slice};
 /// # Safety
 /// `ctx` must point to an uninitialized SHA-1 context.
 #[no_mangle]
-pub unsafe extern "C" fn sha1dc_rs_init(ctx: *mut *mut Hasher) {
+pub unsafe extern "C" fn sha1dc_rs_init(ctx: *mut c_void) {
+    let ctx = ctx.cast::<*mut Hasher>();
     *ctx = Box::into_raw(Box::new(Hasher::new()));
 }
 
@@ -17,7 +18,9 @@ pub unsafe extern "C" fn sha1dc_rs_init(ctx: *mut *mut Hasher) {
 /// # Safety
 /// Both contexts must be initialized.
 #[no_mangle]
-pub unsafe extern "C" fn sha1dc_rs_clone(dst: *mut *mut Hasher, src: *const *mut Hasher) {
+pub unsafe extern "C" fn sha1dc_rs_clone(dst: *mut c_void, src: *const c_void) {
+    let dst = dst.cast::<*mut Hasher>();
+    let src = src.cast::<*mut Hasher>();
     let hasher = Box::new((**src).clone());
     drop(Box::from_raw(*dst));
     *dst = Box::into_raw(hasher);
@@ -29,7 +32,8 @@ pub unsafe extern "C" fn sha1dc_rs_clone(dst: *mut *mut Hasher, src: *const *mut
 /// `ctx` must be initialized and `data` must point to `len` bytes unless
 /// `len` is zero.
 #[no_mangle]
-pub unsafe extern "C" fn sha1dc_rs_update(ctx: *mut *mut Hasher, data: *const c_char, len: usize) {
+pub unsafe extern "C" fn sha1dc_rs_update(ctx: *mut c_void, data: *const c_void, len: usize) {
+    let ctx = ctx.cast::<*mut Hasher>();
     if len != 0 {
         (**ctx).update(slice::from_raw_parts(data.cast::<u8>(), len));
     }
@@ -43,9 +47,10 @@ pub unsafe extern "C" fn sha1dc_rs_update(ctx: *mut *mut Hasher, data: *const c_
 #[no_mangle]
 pub unsafe extern "C" fn sha1dc_rs_final(
     hash: *mut u8,
-    ctx: *mut *mut Hasher,
+    ctx: *mut c_void,
     die: unsafe extern "C" fn(*const c_char, ...) -> !,
 ) {
+    let ctx = ctx.cast::<*mut Hasher>();
     let hasher = *Box::from_raw(*ctx);
     *ctx = ptr::null_mut();
     match hasher.finalize() {
@@ -66,7 +71,8 @@ pub unsafe extern "C" fn sha1dc_rs_final(
 /// # Safety
 /// `ctx` must be initialized.
 #[no_mangle]
-pub unsafe extern "C" fn sha1dc_rs_discard(ctx: *mut *mut Hasher) {
+pub unsafe extern "C" fn sha1dc_rs_discard(ctx: *mut c_void) {
+    let ctx = ctx.cast::<*mut Hasher>();
     drop(Box::from_raw(*ctx));
     *ctx = ptr::null_mut();
 }
diff --git a/t/helper/test-sha1.c b/t/helper/test-sha1.c
index 349540c4df..827fd2d6d5 100644
--- a/t/helper/test-sha1.c
+++ b/t/helper/test-sha1.c
@@ -1,13 +1,30 @@
+#define USE_THE_REPOSITORY_VARIABLE
 #include "test-tool.h"
 #include "hash.h"
+#include "setup.h"
 
 int cmd__sha1(int ac, const char **av)
 {
 	return cmd_hash_impl(ac, av, GIT_HASH_SHA1, 0);
 }
 
-int cmd__sha1_is_sha1dc(int argc UNUSED, const char **argv UNUSED)
+int cmd__sha1_is_sha1dc(int argc, const char **argv)
 {
+#ifdef DC_SHA1_RS
+	if (argc == 2 && !strcmp(argv[1], "--backend")) {
+		git_SHA_CTX ctx;
+		int nongit;
+
+		setup_git_directory_gently(the_repository, &nongit);
+		git_SHA1_Init(&ctx);
+		puts(sha1dc_init == git_SHA1DCInit ? "c" : "rust");
+		git_SHA1_Discard(&ctx);
+		return 0;
+	}
+#else
+	if (argc == 2 && !strcmp(argv[1], "--backend"))
+		return 1;
+#endif
 #ifdef platform_SHA_IS_SHA1DC
 	return 0;
 #endif
diff --git a/t/t0013-sha1dc.sh b/t/t0013-sha1dc.sh
index 3ea3169d92..9f6b72f8ef 100755
--- a/t/t0013-sha1dc.sh
+++ b/t/t0013-sha1dc.sh
@@ -13,10 +13,29 @@ then
 	test_done
 fi
 
+test_lazy_prereq SHA1DC_RS '
+	test rust = "$(GIT_CONFIG_PARAMETERS="${SQ}core.sha1dcBackend=rust${SQ}" \
+		test-tool sha1-is-sha1dc --backend)"
+'
+
 test_expect_success 'test-sha1 detects shattered pdf' '
 	test_must_fail test-tool sha1 <"$TEST_DATA/shattered-1.pdf" 2>err &&
 	test_grep collision err &&
-	test_grep 38762cf7f55934b34d179ae6a4c80cadccbb7f0a err
+	test_grep 38762cf7f55934b34d179ae6a4c80cadccbb7f0a err &&
+	if test_have_prereq SHA1DC_RS
+	then
+		test_must_fail env \
+			GIT_CONFIG_PARAMETERS="${SQ}core.sha1dcBackend=c${SQ}" \
+			test-tool sha1 <"$TEST_DATA/shattered-1.pdf" 2>err &&
+		test_grep collision err &&
+		test_grep 38762cf7f55934b34d179ae6a4c80cadccbb7f0a err
+	fi
+'
+
+test_expect_success SHA1DC_RS 'select SHA1DC backend via config' '
+	test rust = "$(test-tool sha1-is-sha1dc --backend)" &&
+	test_config core.sha1dcBackend c &&
+	test c = "$(test-tool sha1-is-sha1dc --backend)"
 '
 
 test_done
-- 
gitgitgadget


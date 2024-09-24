Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6141AC424
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 17:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727199152; cv=none; b=LZSZ5pkBSA2Ijb4AG3dOLN4IXtQc8S+jpW+VTo5Zs+eogKUqzadCOhZPAcITjKyfNwMXYNoiqY9clH5ImcY2PBivO9rgBlGkSjSX02LMUF4nDOucEnW2jgP43d++rOBkY7zpsRUElXSpkubz1873Zo43a/mHXbhm/ccqsZq9ucg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727199152; c=relaxed/simple;
	bh=b63aMYZVWbypZvi/m4XzJBZmH5tJUPBB/lQITUpb0yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poQhmTq/RZ/TF2mhDpiQekD60Fx+VJuRU72AHsgdNG6MfZkqw7lAdWKCvs056UKiv6ols/wxv10xPPZZ/kOZT7ekdOjXRbirXzfs84fXl9c65a2DKLhjcnYvqTCkIlkthwGxRkJlK2shPAjLTd333xHOORBgRjLoPsybUuA15LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ChX7hMWW; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ChX7hMWW"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e1a989bd17aso5045324276.1
        for <git@vger.kernel.org>; Tue, 24 Sep 2024 10:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727199149; x=1727803949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OAJw+96cLZL7uSh3byPCWym4U1G0sQPREeuewVhiFZQ=;
        b=ChX7hMWW4Xr3RjjAoNmaRN6KWlaunORs/d8m7oq4VH34zM+Z949r9p/BN+1OKo2xjL
         yV+G+dT1rqQwO+/TM/obKU3lCzUt9W1UU5lSF0g2rzcMEfyt/XJpOxCw2nLlpbD8sJlj
         zy2/xQwXctrDKk7n0WbGOEHaNJaoSVnSq9QkT0A8Gy9utLPKFSVh37NEWHTMpEYWgnKS
         Mw8yypWK5z7wRX+6eThp7p++uOzvlc3fuCip5wjnwFBNl+FhXf3j8riCyIIaR3W7jxjL
         T7rDeaHnIWkF1XXhcJBqxrhjASzzaCnMbpJoSxpk97sHj7dFKo66PfDiElcPP6pO95Ud
         L0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727199149; x=1727803949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAJw+96cLZL7uSh3byPCWym4U1G0sQPREeuewVhiFZQ=;
        b=i7Z6hLcA1ivOfJJR3aX1Aeuvc9wq6g0MBwqFrOCH/uEgGsaKcnA0Oz+VQXyR0b111S
         1aws89sFdOOG7vZcPsMKVz7YrKC46YdsbUcCeJMbR6UcS4BKxeFiKuZsocALTL2TeHGf
         Exg26pXQuFMI+Z58jBgp4btx8MpWnPFBzYCCEK8M0+z1cgEh60FXgozVnYp8p8tZlWHv
         T8fOYKskOoiY16C5wV7V53e9WkHgPgtJCgjoDmO0+hfIzaj5NH87k8BJccPtp8BYtMOZ
         SX3QO/+xzKNidEVCIs9RSOYcF45quPHv1m1KcEZztRbrG9NWZEvNr0K1xvHUzmfiSlrJ
         X4gQ==
X-Gm-Message-State: AOJu0YzhRbe8PE7yzIXqMoyS/NeoktCbnLAi6HT53rw+6S8MVA+k8BXj
	FooZqkB6O9k7kfaRdOsdD2//+2JbL1GBUd4STfYhhfxAx32iOxuS20TUEZcg60IOQmyGn4cpjXR
	P5MA=
X-Google-Smtp-Source: AGHT+IG8fhsGrrswbdUdYosu/Ge5BNoDAuEQmWrlKgAVJdK5096wL/JJ5z7jOg3c8MQEhyOVr5Ui4g==
X-Received: by 2002:a05:6902:250a:b0:e1f:eb2b:5502 with SMTP id 3f1490d57ef6-e2250c3b434mr11405535276.13.1727199149664;
        Tue, 24 Sep 2024 10:32:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2499c63d11sm317292276.42.2024.09.24.10.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 10:32:29 -0700 (PDT)
Date: Tue, 24 Sep 2024 13:32:28 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 6/8] hash.h: scaffolding for _unsafe hashing variants
Message-ID: <d300e9c68879faf837c65455e39b4aa07c1e1b03.1727199118.git.me@ttaylorr.com>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1727199118.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1727199118.git.me@ttaylorr.com>

Git's default SHA-1 implementation is collision-detecting, which hardens
us against known SHA-1 attacks against Git objects. This makes Git
object writes safer at the expense of some speed when hashing through
the collision-detecting implementation, which is slower than
non-collision detecting alternatives.

Prepare for loading a separate "unsafe" SHA-1 implementation that can be
used for non-cryptographic purposes, like computing the checksum of
files that use the hashwrite() API.

This commit does not actually introduce any new compile-time knobs to
control which implementation is used as the unsafe SHA-1 variant, but
does add scaffolding so that the "git_hash_algo" structure has five new
function pointers which are "unsafe" variants of the five existing
hashing-related function pointers:

  - git_hash_init_fn unsafe_init_fn
  - git_hash_clone_fn unsafe_clone_fn
  - git_hash_update_fn unsafe_update_fn
  - git_hash_final_fn unsafe_final_fn
  - git_hash_final_oid_fn unsafe_final_oid_fn

The following commit will introduce compile-time knobs to specify which
SHA-1 implementation is used for non-cryptographic uses.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 hash.h        | 42 ++++++++++++++++++++++++++++++++++++++++++
 object-file.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/hash.h b/hash.h
index 72ffbc862e5..96458b129f9 100644
--- a/hash.h
+++ b/hash.h
@@ -44,14 +44,32 @@
 #define platform_SHA1_Final    	SHA1_Final
 #endif
 
+#ifndef platform_SHA_CTX_unsafe
+#  define platform_SHA_CTX_unsafe      platform_SHA_CTX
+#  define platform_SHA1_Init_unsafe    platform_SHA1_Init
+#  define platform_SHA1_Update_unsafe  platform_SHA1_Update
+#  define platform_SHA1_Final_unsafe   platform_SHA1_Final
+#  ifdef platform_SHA1_Clone
+#    define platform_SHA1_Clone_unsafe platform_SHA1_Clone
+#  endif
+#endif
+
 #define git_SHA_CTX		platform_SHA_CTX
 #define git_SHA1_Init		platform_SHA1_Init
 #define git_SHA1_Update		platform_SHA1_Update
 #define git_SHA1_Final		platform_SHA1_Final
 
+#define git_SHA_CTX_unsafe	platform_SHA_CTX_unsafe
+#define git_SHA1_Init_unsafe	platform_SHA1_Init_unsafe
+#define git_SHA1_Update_unsafe	platform_SHA1_Update_unsafe
+#define git_SHA1_Final_unsafe	platform_SHA1_Final_unsafe
+
 #ifdef platform_SHA1_Clone
 #define git_SHA1_Clone	platform_SHA1_Clone
 #endif
+#ifdef platform_SHA1_Clone_unsafe
+#  define git_SHA1_Clone_unsafe platform_SHA1_Clone_unsafe
+#endif
 
 #ifndef platform_SHA256_CTX
 #define platform_SHA256_CTX	SHA256_CTX
@@ -81,6 +99,13 @@ static inline void git_SHA1_Clone(git_SHA_CTX *dst, const git_SHA_CTX *src)
 	memcpy(dst, src, sizeof(*dst));
 }
 #endif
+#ifndef SHA1_NEEDS_CLONE_HELPER_UNSAFE
+static inline void git_SHA1_Clone_unsafe(git_SHA_CTX_unsafe *dst,
+				       const git_SHA_CTX_unsafe *src)
+{
+	memcpy(dst, src, sizeof(*dst));
+}
+#endif
 
 #ifndef SHA256_NEEDS_CLONE_HELPER
 static inline void git_SHA256_Clone(git_SHA256_CTX *dst, const git_SHA256_CTX *src)
@@ -178,6 +203,8 @@ enum get_oid_result {
 /* A suitably aligned type for stack allocations of hash contexts. */
 union git_hash_ctx {
 	git_SHA_CTX sha1;
+	git_SHA_CTX_unsafe sha1_unsafe;
+
 	git_SHA256_CTX sha256;
 };
 typedef union git_hash_ctx git_hash_ctx;
@@ -222,6 +249,21 @@ struct git_hash_algo {
 	/* The hash finalization function for object IDs. */
 	git_hash_final_oid_fn final_oid_fn;
 
+	/* The non-cryptographic hash initialization function. */
+	git_hash_init_fn unsafe_init_fn;
+
+	/* The non-cryptographic hash context cloning function. */
+	git_hash_clone_fn unsafe_clone_fn;
+
+	/* The non-cryptographic hash update function. */
+	git_hash_update_fn unsafe_update_fn;
+
+	/* The non-cryptographic hash finalization function. */
+	git_hash_final_fn unsafe_final_fn;
+
+	/* The non-cryptographic hash finalization function. */
+	git_hash_final_oid_fn unsafe_final_oid_fn;
+
 	/* The OID of the empty tree. */
 	const struct object_id *empty_tree;
 
diff --git a/object-file.c b/object-file.c
index b9a3a1f62db..196c9e2df8b 100644
--- a/object-file.c
+++ b/object-file.c
@@ -115,6 +115,33 @@ static void git_hash_sha1_final_oid(struct object_id *oid, git_hash_ctx *ctx)
 	oid->algo = GIT_HASH_SHA1;
 }
 
+static void git_hash_sha1_init_unsafe(git_hash_ctx *ctx)
+{
+	git_SHA1_Init_unsafe(&ctx->sha1_unsafe);
+}
+
+static void git_hash_sha1_clone_unsafe(git_hash_ctx *dst, const git_hash_ctx *src)
+{
+	git_SHA1_Clone_unsafe(&dst->sha1_unsafe, &src->sha1_unsafe);
+}
+
+static void git_hash_sha1_update_unsafe(git_hash_ctx *ctx, const void *data,
+				      size_t len)
+{
+	git_SHA1_Update_unsafe(&ctx->sha1_unsafe, data, len);
+}
+
+static void git_hash_sha1_final_unsafe(unsigned char *hash, git_hash_ctx *ctx)
+{
+	git_SHA1_Final_unsafe(hash, &ctx->sha1_unsafe);
+}
+
+static void git_hash_sha1_final_oid_unsafe(struct object_id *oid, git_hash_ctx *ctx)
+{
+	git_SHA1_Final_unsafe(oid->hash, &ctx->sha1_unsafe);
+	memset(oid->hash + GIT_SHA1_RAWSZ, 0, GIT_MAX_RAWSZ - GIT_SHA1_RAWSZ);
+	oid->algo = GIT_HASH_SHA1;
+}
 
 static void git_hash_sha256_init(git_hash_ctx *ctx)
 {
@@ -189,6 +216,11 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		.update_fn = git_hash_unknown_update,
 		.final_fn = git_hash_unknown_final,
 		.final_oid_fn = git_hash_unknown_final_oid,
+		.unsafe_init_fn = git_hash_unknown_init,
+		.unsafe_clone_fn = git_hash_unknown_clone,
+		.unsafe_update_fn = git_hash_unknown_update,
+		.unsafe_final_fn = git_hash_unknown_final,
+		.unsafe_final_oid_fn = git_hash_unknown_final_oid,
 		.empty_tree = NULL,
 		.empty_blob = NULL,
 		.null_oid = NULL,
@@ -204,6 +236,11 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		.update_fn = git_hash_sha1_update,
 		.final_fn = git_hash_sha1_final,
 		.final_oid_fn = git_hash_sha1_final_oid,
+		.unsafe_init_fn = git_hash_sha1_init_unsafe,
+		.unsafe_clone_fn = git_hash_sha1_clone_unsafe,
+		.unsafe_update_fn = git_hash_sha1_update_unsafe,
+		.unsafe_final_fn = git_hash_sha1_final_unsafe,
+		.unsafe_final_oid_fn = git_hash_sha1_final_oid_unsafe,
 		.empty_tree = &empty_tree_oid,
 		.empty_blob = &empty_blob_oid,
 		.null_oid = &null_oid_sha1,
@@ -219,6 +256,11 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		.update_fn = git_hash_sha256_update,
 		.final_fn = git_hash_sha256_final,
 		.final_oid_fn = git_hash_sha256_final_oid,
+		.unsafe_init_fn = git_hash_sha256_init,
+		.unsafe_clone_fn = git_hash_sha256_clone,
+		.unsafe_update_fn = git_hash_sha256_update,
+		.unsafe_final_fn = git_hash_sha256_final,
+		.unsafe_final_oid_fn = git_hash_sha256_final_oid,
 		.empty_tree = &empty_tree_oid_sha256,
 		.empty_blob = &empty_blob_oid_sha256,
 		.null_oid = &null_oid_sha256,
-- 
2.46.2.636.g4b83dd05e9f


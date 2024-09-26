Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462AE155A3C
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 15:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727364172; cv=none; b=Nu0tgO83utULPY1LTnCvvQd4KcnesKbTLLHV4GOciu9VcqXtt1WuZUcdsVsVBFIHb/6cPPK6KvgSfMWx5A71KmH8XqTLi17ufr69D1JRINBvEsjaVNSlIkuAi8m6sN19WdUR1PRihAO6/ZDk0eqzxT3hUwNVYpAm7nJeYuomWBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727364172; c=relaxed/simple;
	bh=EyPTsi82CiaV3UclfaKd1z4+2WdXKhmm/BLFlDoj5vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFnWpjHEfxPFk9Q0u/qUj6l3gjFe4ahO1RCbI/kw4Lz0AF2FNviNxX1JfWONJ6ZbBHU/yExbrI8ip9drtz9RxCexWi5/774l2Y5KDLRVre166JJxSc3pu43XCRvZJxItQ5Z0AZuNZHLo7QHDY30fC8ZKLHQ2uoFWu/VpuNSwxh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=KrYjqsrn; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="KrYjqsrn"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e23b300bf9so5530727b3.3
        for <git@vger.kernel.org>; Thu, 26 Sep 2024 08:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727364169; x=1727968969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XPPI7wjVu8AX0Acif3L3I5PDWtypISmumVJ9KRiyCqs=;
        b=KrYjqsrnl5BvN0ydElyUjg3UZxKXdbK/mn+Fm9K3Pto289Bu5yBxGzeYuUrKXMryd/
         a78n3tRc89oUBNbVaLsszFKbPLvTJHxZFZW+joQoDhy9iAstfQG0r20jNjxOJvnaY3Me
         TmOE9BFGGh0shpx6nXNpZ894T94mI5sWhckJAyDBoWfI9crwfU0OfxwWkckkAqUuHS5P
         WSupDLYLUiu0c9otQghswOIhU0fLimA6vwVvLF6N5ZDHsGop0Ol3u4QchekGqi0aUaJX
         np3Vj/O7Vj/Y1zu73I2E66KvopNJRr2PikXvIUR045aem5hE7Dk/v4IaWo+wNCTzwK3Z
         5DWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727364169; x=1727968969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPPI7wjVu8AX0Acif3L3I5PDWtypISmumVJ9KRiyCqs=;
        b=QKQNelkkOafIm8vMi2nt25xSW/oQmRwFsAmUwR1b2x6uFYtNKvXoGFx2J28vsq2Iyy
         Y1oNdLjefOlmqQVaaEb5knEAtyjGSqurJj5wX8/7KeeLy76Sau/yHGhqI26jlJ3gTYlI
         fN9WxU06oDjEIT8OnptJpIwZU/tgpkqmK3gxSF8uEiQwmT8eyeoZ14p2FgorOw8aLZzR
         34e39Se9IXzVTyk/RDHOS5vKelEPmNGQjwsIiLpbU9HrzZBiHer7YoYaE1t0028eqXn+
         jSQTRxv9uDj8hMsTwSE9a6zE8uiuArTE82NHTeySFEa7m13UOVk3H45Ne6n+IUqdVFGO
         N8Ug==
X-Gm-Message-State: AOJu0YzAbfDu8UhUsRypCgqrj6uGt4LddU/aiWMaFQsbnssYcceHyl54
	6nYWJMj2Y0FGd4434aCdM3LMB6MdRXkQf9nPyjiLMHZVfxi2vnJcby1BfNn5EbrbRds9Yrdj5IS
	Uvus=
X-Google-Smtp-Source: AGHT+IFS0seCY5LO7NeOqN+4g6Ut1vCRJ+ndMF2yLM4FpuBy8S4oy+C25Yimvcf1vLBxt3yZ6M9lfQ==
X-Received: by 2002:a05:690c:7181:b0:6db:e368:3ff3 with SMTP id 00721157ae682-6e21d9f3b40mr49040827b3.40.1727364169018;
        Thu, 26 Sep 2024 08:22:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e245318153sm180387b3.60.2024.09.26.08.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 08:22:48 -0700 (PDT)
Date: Thu, 26 Sep 2024 11:22:47 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 6/8] hash.h: scaffolding for _unsafe hashing variants
Message-ID: <65de6d724d646082332e65799cf23a5a412ac68f.1727364141.git.me@ttaylorr.com>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1727364141.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1727364141.git.me@ttaylorr.com>

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
index 72ffbc862e..96458b129f 100644
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
index b9a3a1f62d..196c9e2df8 100644
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
2.46.1.507.gffd0c9a15b2.dirty


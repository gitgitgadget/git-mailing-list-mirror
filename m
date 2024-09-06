Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218B41D7E50
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 19:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725651989; cv=none; b=RSJbttCFWXwoya/ngLGUr3SJK/2jg3M4PghzcniU//72RrZieGG+lY82QxzALU9uQgMAJGAo92w+1qlTAxzUoWK/iZE4wiSXa/WN4aG3J0OAxI+z9nhJb6/Q/PDe1qOh3Zq0OM2HryvfbcCjZ6SfvonT6jL7esuwQmmSPjBD/xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725651989; c=relaxed/simple;
	bh=ATDIYSnRo4sAen/XWHemEaumGXJ96Qa7ZNUR52P021I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oejWS89Z/8flGNJVPId+q/L23vyG6pqZeStLp6V2DlNUWwuw6caKCEkmyEy1di8kE7QyoWscS6zkSH9sURq8FCC3zopFC4BcSsEHlzd3ON+QkQTVUjevO/vWLcdagD+1Xpt7xqwa8gnDFQ5s/1crKPXi8cpw+t6MNaVXT3d6JDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=qX61LjEE; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="qX61LjEE"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6db20e22c85so23207977b3.0
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 12:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1725651987; x=1726256787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=atLEk9aAusYisCBU6u9KPSlIFmocU+G7V2Azz6cGz1o=;
        b=qX61LjEEdze/J6DXAETa8parKUdeVPVmp+o01X6jyrIw+gY+ByVldOGam64/+czYaB
         EPJA2HFX03/BYANWLMOpuxA/c9pqdo/x07a264K19dM7BCH0YcfHn0E4ghsM4tp/ooQR
         1t1ZSsb4NqHOymWudrSc27L/4FpUW/7ani/mLT1icqa76eYyT+1zZqVQ6tmL+y2pcTz0
         +ElKmNq1Kt/i72NWhdW7dovXa3eQ9Dg6LiuP60nONcKrA60vl0dOCnNxER5xyzNRlsZP
         QxFhsHbpqH05qJCUyW7t789QUxYL6no9i9xwrDXEs0CgRxOHZ0ayQztIR8zOgh6iZkG9
         /bOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725651987; x=1726256787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atLEk9aAusYisCBU6u9KPSlIFmocU+G7V2Azz6cGz1o=;
        b=vgvLYQScz2hWrzgKujK0IsEut0lYoxz83bFQjhVDN21qoyXG1lCyeQ6SePqiB8Li9B
         aeQpOAFLg1sTEWQuT38sR5yc8QGzr3J39N6DjTBBuSSgRGtO+zju7BIJb6n3lSnigc9a
         wGNkCmJNi+/3sMNDCxiqCgUhG+FhENNw11W+jxYVqdnFYK7pUk8VAoj4y4MYo4Ps2nkY
         ES6Pirpha1iYA0b2dUXGW3WjFM1QeouX1qAUe5L33ykmwzXg4fFGfnkGBh6DKsngmDRG
         +sxqpxVTakHBgxX9TBXLalKCmcG2OKi8u9fywF0ytUjVR3CwXSH4HprRc9EcutHh2kL/
         moDQ==
X-Gm-Message-State: AOJu0YwDT99y267eoXMNgRr58P/sVS0/Pn0cyH3gJ8qAP7DeyLsXToE2
	/BGunwA+pX6On6qEz0ABU9GCHh2NuAi15foqsAwA3/3Xv7GWCNiXjglQhKcacoNt1EeQhCbvwtu
	uYpQ=
X-Google-Smtp-Source: AGHT+IFlv9MN4xHV6AqZAbsa6PDQahZ0Gwcy9vR8igQ2VKz0Ts7UE6NPU+VgpGxYv4QqXGv+NTIdXw==
X-Received: by 2002:a05:690c:60ca:b0:64a:9832:48a with SMTP id 00721157ae682-6db44a5b400mr55853997b3.0.1725651986803;
        Fri, 06 Sep 2024 12:46:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6db565ab8d3sm1130587b3.90.2024.09.06.12.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 12:46:26 -0700 (PDT)
Date: Fri, 6 Sep 2024 15:46:25 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 7/9] hash.h: scaffolding for _fast hashing variants
Message-ID: <119c318d8123fd9ef404730a923968f29ee184d8.1725651952.git.me@ttaylorr.com>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1725651952.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1725651952.git.me@ttaylorr.com>

Git's default SHA-1 implementation is collision-detecting, which hardens
us against known SHA-1 attacks against Git objects. This makes Git
object writes safer at the expense of some speed when hashing through
the collision-detecting implementation, which is slower than
non-collision detecting alternatives.

Prepare for loading a separate "fast" SHA-1 implementation that can be
used for non-cryptographic purposes, like computing the checksum of
files that use the hashwrite() API.

This commit does not actually introduce any new compile-time knobs to
control which implementation is used as the fast SHA-1 variant, but does
add scaffolding so that the "git_hash_algo" structure has five new
function pointers which are "fast" variants of the five existing
hashing-related function pointers:

  - git_hash_init_fn fast_init_fn
  - git_hash_clone_fn fast_clone_fn
  - git_hash_update_fn fast_update_fn
  - git_hash_final_fn fast_final_fn
  - git_hash_final_oid_fn fast_final_oid_fn

The following commit will introduce compile-time knobs to specify which
SHA-1 implementation is used for non-cryptographic uses.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 hash.h        | 42 ++++++++++++++++++++++++++++++++++++++++++
 object-file.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/hash.h b/hash.h
index 72ffbc862e5..5e5b8205b58 100644
--- a/hash.h
+++ b/hash.h
@@ -44,14 +44,32 @@
 #define platform_SHA1_Final    	SHA1_Final
 #endif
 
+#ifndef platform_SHA_CTX_fast
+#  define platform_SHA_CTX_fast     platform_SHA_CTX
+#  define platform_SHA1_Init_fast   platform_SHA1_Init
+#  define platform_SHA1_Update_fast platform_SHA1_Update
+#  define platform_SHA1_Final_fast  platform_SHA1_Final
+#  ifdef platform_SHA1_Clone
+#    define platform_SHA1_Clone_fast platform_SHA1_Clone
+#  endif
+#endif
+
 #define git_SHA_CTX		platform_SHA_CTX
 #define git_SHA1_Init		platform_SHA1_Init
 #define git_SHA1_Update		platform_SHA1_Update
 #define git_SHA1_Final		platform_SHA1_Final
 
+#define git_SHA_CTX_fast	platform_SHA_CTX_fast
+#define git_SHA1_Init_fast	platform_SHA1_Init_fast
+#define git_SHA1_Update_fast	platform_SHA1_Update_fast
+#define git_SHA1_Final_fast	platform_SHA1_Final_fast
+
 #ifdef platform_SHA1_Clone
 #define git_SHA1_Clone	platform_SHA1_Clone
 #endif
+#ifdef platform_SHA1_Clone_fast
+#  define git_SHA1_Clone_fast platform_SHA1_Clone_fast
+#endif
 
 #ifndef platform_SHA256_CTX
 #define platform_SHA256_CTX	SHA256_CTX
@@ -81,6 +99,13 @@ static inline void git_SHA1_Clone(git_SHA_CTX *dst, const git_SHA_CTX *src)
 	memcpy(dst, src, sizeof(*dst));
 }
 #endif
+#ifndef SHA1_NEEDS_CLONE_HELPER_FAST
+static inline void git_SHA1_Clone_fast(git_SHA_CTX_fast *dst,
+				       const git_SHA_CTX_fast *src)
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
+	git_SHA_CTX_fast sha1_fast;
+
 	git_SHA256_CTX sha256;
 };
 typedef union git_hash_ctx git_hash_ctx;
@@ -222,6 +249,21 @@ struct git_hash_algo {
 	/* The hash finalization function for object IDs. */
 	git_hash_final_oid_fn final_oid_fn;
 
+	/* The fast / non-cryptographic hash initialization function. */
+	git_hash_init_fn fast_init_fn;
+
+	/* The fast / non-cryptographic hash context cloning function. */
+	git_hash_clone_fn fast_clone_fn;
+
+	/* The fast / non-cryptographic hash update function. */
+	git_hash_update_fn fast_update_fn;
+
+	/* The fast / non-cryptographic hash finalization function. */
+	git_hash_final_fn fast_final_fn;
+
+	/* The fast / non-cryptographic hash finalization function. */
+	git_hash_final_oid_fn fast_final_oid_fn;
+
 	/* The OID of the empty tree. */
 	const struct object_id *empty_tree;
 
diff --git a/object-file.c b/object-file.c
index 85f91516429..84dd7d0fab6 100644
--- a/object-file.c
+++ b/object-file.c
@@ -115,6 +115,33 @@ static void git_hash_sha1_final_oid(struct object_id *oid, git_hash_ctx *ctx)
 	oid->algo = GIT_HASH_SHA1;
 }
 
+static void git_hash_sha1_init_fast(git_hash_ctx *ctx)
+{
+	git_SHA1_Init_fast(&ctx->sha1_fast);
+}
+
+static void git_hash_sha1_clone_fast(git_hash_ctx *dst, const git_hash_ctx *src)
+{
+	git_SHA1_Clone_fast(&dst->sha1_fast, &src->sha1_fast);
+}
+
+static void git_hash_sha1_update_fast(git_hash_ctx *ctx, const void *data,
+				      size_t len)
+{
+	git_SHA1_Update_fast(&ctx->sha1_fast, data, len);
+}
+
+static void git_hash_sha1_final_fast(unsigned char *hash, git_hash_ctx *ctx)
+{
+	git_SHA1_Final_fast(hash, &ctx->sha1_fast);
+}
+
+static void git_hash_sha1_final_oid_fast(struct object_id *oid, git_hash_ctx *ctx)
+{
+	git_SHA1_Final_fast(oid->hash, &ctx->sha1_fast);
+	memset(oid->hash + GIT_SHA1_RAWSZ, 0, GIT_MAX_RAWSZ - GIT_SHA1_RAWSZ);
+	oid->algo = GIT_HASH_SHA1;
+}
 
 static void git_hash_sha256_init(git_hash_ctx *ctx)
 {
@@ -189,6 +216,11 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		.update_fn = git_hash_unknown_update,
 		.final_fn = git_hash_unknown_final,
 		.final_oid_fn = git_hash_unknown_final_oid,
+		.fast_init_fn = git_hash_unknown_init,
+		.fast_clone_fn = git_hash_unknown_clone,
+		.fast_update_fn = git_hash_unknown_update,
+		.fast_final_fn = git_hash_unknown_final,
+		.fast_final_oid_fn = git_hash_unknown_final_oid,
 		.empty_tree = NULL,
 		.empty_blob = NULL,
 		.null_oid = NULL,
@@ -204,6 +236,11 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		.update_fn = git_hash_sha1_update,
 		.final_fn = git_hash_sha1_final,
 		.final_oid_fn = git_hash_sha1_final_oid,
+		.fast_init_fn = git_hash_sha1_init_fast,
+		.fast_clone_fn = git_hash_sha1_clone_fast,
+		.fast_update_fn = git_hash_sha1_update_fast,
+		.fast_final_fn = git_hash_sha1_final_fast,
+		.fast_final_oid_fn = git_hash_sha1_final_oid_fast,
 		.empty_tree = &empty_tree_oid,
 		.empty_blob = &empty_blob_oid,
 		.null_oid = &null_oid_sha1,
@@ -219,6 +256,11 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		.update_fn = git_hash_sha256_update,
 		.final_fn = git_hash_sha256_final,
 		.final_oid_fn = git_hash_sha256_final_oid,
+		.fast_init_fn = git_hash_sha256_init,
+		.fast_clone_fn = git_hash_sha256_clone,
+		.fast_update_fn = git_hash_sha256_update,
+		.fast_final_fn = git_hash_sha256_final,
+		.fast_final_oid_fn = git_hash_sha256_final_oid,
 		.empty_tree = &empty_tree_oid_sha256,
 		.empty_blob = &empty_blob_oid_sha256,
 		.null_oid = &null_oid_sha256,
-- 
2.46.0.430.gca674632b70


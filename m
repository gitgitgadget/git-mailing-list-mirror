Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2641E515
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 19:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736363686; cv=none; b=KVCPaQ7Q9aH3NpEtzfzSQbIPqs+TKCpKQ24ddK1u1lQMRjYw+IL6one+HoMUe9NcWvEmsQaBbnvdo9IZE+OCj+DTU0xeY+Igq4QsAOXeUvu4f/1ymiZ1f3jG4sRnZnXqa6CGrRZziu++Ca3y32Y1AhLP9HWiyFzFITzyjj6JmCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736363686; c=relaxed/simple;
	bh=hWJ5m+6JIV2StaPUhvhWkY/RO0LOEQwoY3LStCgaWbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0dagPtQfn5+ggpgKH7o9o/vvMgwNydtGeWH00wt9xEf/jYm44N3ZexwJchuDq5hh5ba5KqzEKPgsDtqpfVtT+opXdlxqPjDvhk4VCUBpxwzWyoIsGxzNrgZmO+1HaMZ8A2B09B24sv4EM0ZZKF9DKO+e7slX/WRUlGyAAm78/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ipwbnmrn; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ipwbnmrn"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e46c6547266so72881276.3
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 11:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1736363684; x=1736968484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wvoe2VC0QAEm2MWq7n2gKbgG8Tdc7EQmwXMOqmfT8dY=;
        b=ipwbnmrnCHvTFeKJ8c9RrZBmPaWF9aPi/VUAV4EBR2Tv86gl6PVdeqzttljkf3wa0i
         eF5X/MD0FM1yHI6xz+CDYnI1Maj4kAehjlUyXu3M4AEewjoWeOiNGKbpGbh98aZGf+hj
         jhkqUvyhur11A/jP50xqw8iL5aGKscwBi9GNPUA90JeRh5RKYvRorKXoxHm2aicdp8pT
         o3C/adWMC8faqh1QHko4EKzI+F/YmPOSII7oF8HNZd0LQ5mm9G52KnVexdHMIoAeq17i
         80r9BX5cphGEsrz5cWPhR1CRqZLnhiAlLkWP1i/NA5oCy4mXXcM+cZCBf6vWCVffv9x7
         n17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736363684; x=1736968484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wvoe2VC0QAEm2MWq7n2gKbgG8Tdc7EQmwXMOqmfT8dY=;
        b=ZbCfnzk0oXg+75siSSwb/SbGMIdS4Ufd4SoBKdt3slORqw+YpoahyTlbyGj97/L80o
         yz9/CflbhscWAEIAmJLBf/w7JPQlrxf1JteuJMDNw6yZizGm64lqfHqG0lTCXo932flm
         eNC1CfBzGCUpV/CAFjihsLpX0o0T8mXF9atS96UGiC4U3t0z38HTQt82hzQ61iZyJFeq
         jvoCiDpjjClH8LvPpBMr/vN9NyX/kJ7FMcOVrGuj20tAE4b+ilAqR8JPeGlloTLevDpZ
         nYqcierEQTvPeaVXcxmKmCDuBw6NRqmcuAp+4w//YQXwCizOxCi2IO0LoEsx7pwTV+Qi
         O5rw==
X-Gm-Message-State: AOJu0YwSR7gIKAUJvZuSY6oZbqJ4jXCUdbZvZKCzsmmHyzHVeo0g3Zz2
	lNmUwB8qxRQ3wLaFUlKc2XuIT7yZaH9Wp4xMapSvQFqaeviZRF5WxeW5M6TNYEZKKDmyaPzORf5
	bVc0=
X-Gm-Gg: ASbGnctvZez1O+R7qxigC0LexrcKoD39ctFTpsIXXatI3S18obZcSVd8CGPcEehC04R
	Fn1al7mf5M0lifTgxSQ0qRHzJ01cN/oGMmD2OV99aWgsJYpFFGk287FLgiBPdSUyKs82MA1K9k4
	NZeqsRgZ9nfOTN9aC3kXaEYl0Bfeq20x/wqThdVFzuVEokgUUMF+zWRuJeIgAWBAtNbSYcqQ/3t
	AbG5ULQTLw2WcOFuWJL4pqu/xMa+WZK9zj3pSt2Y2mpLAGySaib2BMqeyT7quNAQ/7LxHFlxx1q
	UBp5aKRUQZRRj+v3VYK1gVCnkrXn
X-Google-Smtp-Source: AGHT+IFOkGuQufZ/xE3B64qIHfBuHR1MgB9FNG6vMjiaOP5nEwyCZqi8/d61E83ZCrRunhHuFycC0Q==
X-Received: by 2002:a05:690c:7348:b0:6ef:4c6c:3049 with SMTP id 00721157ae682-6f531220b04mr33898297b3.14.1736363683735;
        Wed, 08 Jan 2025 11:14:43 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f3e77ed520sm95206387b3.97.2025.01.08.11.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 11:14:43 -0800 (PST)
Date: Wed, 8 Jan 2025 14:14:42 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 4/8] hash.h: introduce `unsafe_hash_algo()`
Message-ID: <99dcbe2e7165d96e3a9c025540995a75f74b2489.1736363652.git.me@ttaylorr.com>
References: <cover.1732130001.git.me@ttaylorr.com>
 <cover.1736363652.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1736363652.git.me@ttaylorr.com>

In 253ed9ecff (hash.h: scaffolding for _unsafe hashing variants,
2024-09-26), we introduced "unsafe" variants of the SHA-1 hashing
functions by introducing new functions like "unsafe_init_fn()" and so
on.

This approach has a major shortcoming that callers must remember to
consistently use one variant or the other. Failing to consistently use
(or not use) the unsafe variants can lead to crashes at best, or subtle
memory corruption issues at worst.

In the hashfile API, this isn't difficult to achieve, but verifying that
all callers consistently use the unsafe variants is somewhat of a chore
given how spread out all of the callers are. In the sha1 and sha1-unsafe
test helpers, all of the calls to various hash functions are guarded by
an "if (unsafe)" conditional, which is repetitive and cumbersome.

Address these issues by introducing a new pattern whereby one
'git_hash_algo' can return a pointer to another 'git_hash_algo' that
represents the unsafe version of itself. So instead of having something
like:

    if (unsafe)
      the_hash_algo->init_fn(...);
      the_hash_algo->update_fn(...);
      the_hash_algo->final_fn(...);
    else
      the_hash_algo->unsafe_init_fn(...);
      the_hash_algo->unsafe_update_fn(...);
      the_hash_algo->unsafe_final_fn(...);

we can instead write:

    struct git_hash_algo *algop = the_hash_algo;
    if (unsafe)
      algop = unsafe_hash_algo(algop);

    the_hash_algo->init_fn(...);
    the_hash_algo->update_fn(...);
    the_hash_algo->final_fn(...);

This removes the existing shortcoming by no longer forcing the caller to
"remember" which variant of the hash functions it wants to call, only to
hold onto a 'struct git_hash_algo' pointer that is initialized once.

Similarly, while there currently is still a way to "mix" safe and unsafe
functions, this too will go away after subsequent commits remove all
direct calls to the unsafe_ variants.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 hash.h        |  5 +++++
 object-file.c | 26 ++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/hash.h b/hash.h
index 756166ce5e8..23cf6876e50 100644
--- a/hash.h
+++ b/hash.h
@@ -305,6 +305,9 @@ struct git_hash_algo {
 
 	/* The all-zeros OID. */
 	const struct object_id *null_oid;
+
+	/* The unsafe variant of this hash function, if one exists. */
+	const struct git_hash_algo *unsafe;
 };
 extern const struct git_hash_algo hash_algos[GIT_HASH_NALGOS];
 
@@ -323,6 +326,8 @@ static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
 	return p - hash_algos;
 }
 
+const struct git_hash_algo *unsafe_hash_algo(const struct git_hash_algo *algop);
+
 const struct object_id *null_oid(void);
 
 static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2, const struct git_hash_algo *algop)
diff --git a/object-file.c b/object-file.c
index 5b792b3dd42..43efa4ca361 100644
--- a/object-file.c
+++ b/object-file.c
@@ -202,6 +202,22 @@ static void git_hash_unknown_final_oid(struct object_id *oid UNUSED,
 	BUG("trying to finalize unknown hash");
 }
 
+static const struct git_hash_algo sha1_unsafe_algo = {
+	.name = "sha1",
+	.format_id = GIT_SHA1_FORMAT_ID,
+	.rawsz = GIT_SHA1_RAWSZ,
+	.hexsz = GIT_SHA1_HEXSZ,
+	.blksz = GIT_SHA1_BLKSZ,
+	.init_fn = git_hash_sha1_init_unsafe,
+	.clone_fn = git_hash_sha1_clone_unsafe,
+	.update_fn = git_hash_sha1_update_unsafe,
+	.final_fn = git_hash_sha1_final_unsafe,
+	.final_oid_fn = git_hash_sha1_final_oid_unsafe,
+	.empty_tree = &empty_tree_oid,
+	.empty_blob = &empty_blob_oid,
+	.null_oid = &null_oid_sha1,
+};
+
 const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 	{
 		.name = NULL,
@@ -239,6 +255,7 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		.unsafe_update_fn = git_hash_sha1_update_unsafe,
 		.unsafe_final_fn = git_hash_sha1_final_unsafe,
 		.unsafe_final_oid_fn = git_hash_sha1_final_oid_unsafe,
+		.unsafe = &sha1_unsafe_algo,
 		.empty_tree = &empty_tree_oid,
 		.empty_blob = &empty_blob_oid,
 		.null_oid = &null_oid_sha1,
@@ -305,6 +322,15 @@ int hash_algo_by_length(int len)
 	return GIT_HASH_UNKNOWN;
 }
 
+const struct git_hash_algo *unsafe_hash_algo(const struct git_hash_algo *algop)
+{
+	/* If we have a faster "unsafe" implementation, use that. */
+	if (algop->unsafe)
+		return algop->unsafe;
+	/* Otherwise use the default one. */
+	return algop;
+}
+
 /*
  * This is meant to hold a *small* number of objects that you would
  * want repo_read_object_file() to be able to return, but yet you do not want
-- 
2.48.0.rc2.33.gaab3d23ed4c


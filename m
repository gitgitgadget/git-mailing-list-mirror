Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7104B1AB6CD
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 19:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732130035; cv=none; b=RPGyzRQUx+qz7dA0IvfhuNl1Qeqve83yVTkTpCH+Eis9unOjWwvV6Y3JdSVKgdyeUH3lICKZPhoSvHHEjTya3pyy7cj1C7u4B2SFG8H5lNRaJd+bsLzPjzQXOLlvpKOvS0p4u45gQx+NlCq9f7MrhwTlDLxOhYeebpPtnAN6fKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732130035; c=relaxed/simple;
	bh=d7uSPrdyswNUWPJX18eK+kp1UHZ4N/5Qx8z7qzMHmsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhDXIbcLS5YelyELimog1/25DcVZLaw+Pk8BXL2Ia71U7BAG1/KheA2NaZMOwproPTcS7l6QTVpERxUwihIXm1J7lPJ+pt6yI6WruH8As80kaDWeTaaxUIzeKPhyG2KpjpNZqROzoD6DpoUgTvZO6TGQWGB03D93ew4/42dmFIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=vHYWwAGr; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="vHYWwAGr"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6eebae6f013so164427b3.0
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 11:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732130032; x=1732734832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R5Ymu9EwaSaPZMf/gHFx8uZWWIVfqCC9/p2shHrpc0s=;
        b=vHYWwAGrynkYtD7hQMhM7VXn5MC0IYlBFPcf5E07HzywnUkURNVZzPfV8MI5V1eKLm
         +PVbx7pS5nX+UQIFxjCr+fm6zg0ubERpQCC2FdeLbYP/Xx4HNODxkmkz5RKNgSyFtG0/
         lEWqbCbK9/+fD1XIjK/NF+Kqci2YrN0Um2AhPECVNCKPTeOgx9ZGUZUoJMvP4VM5mehL
         vjjs5z71kZfuTzWnAQxe2zlfmWyzcUsv/NtJnJa9ZrIBiZ4n9OIgBrk/Qgs6BjS/cRKG
         ii5B3n07pUDjMxDxbzvqfJ32uUEx6tsDlOfcyJhFrFmw4fQbFIXj+shCETEjSXHFDj1H
         imAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732130032; x=1732734832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5Ymu9EwaSaPZMf/gHFx8uZWWIVfqCC9/p2shHrpc0s=;
        b=TJvcHBffC4ryK+khMrOG/sMDNMCYdY+ggZWKV6uuDp3CGxqakTo5Q98hrKRZOipLlf
         8HAyioyXurNHpD5Md/RuJt+sqPEHHjbr1d+FPvUodxQm1Gv0pJvFq8bH9JzYdAX1G7G4
         e79ERgtYeWu+NysQJ96knj1sXV1XNnvPZ4DLC5m0amLrcAtdi8GBpt5KnDzUa5ZJkwOJ
         JfvI8fVpDxMQM7XMqQ9K5NmcdCb1Tl/aZQtleJIWniDVO6o3RgIOFGrTv8ynX62oDezC
         gJyFrM7gYdigpRBgCk4xFZOPo0semU8qUIB3giNRJXwlbp2WOq61h2JmJhyc4zKah5xk
         EGgw==
X-Gm-Message-State: AOJu0YwDtft0U8Vy9gUvfRMXR9m9ZE7XFFOjkQKWMy95xuxrJQi1qhBH
	WFCsEdh/l/GmgY4qqBvqzaMqw40skdd+GBR1lEwGbOP/NkloAP+KfWrh1e6nzgdmd4uasksYIRW
	e
X-Google-Smtp-Source: AGHT+IEV4jYZcI//7Qg/vxoP6fUE/Mf4sl9FrMOZomqfddFd0ykhSIQqtF5arTZbuIAuHpwAf1bGow==
X-Received: by 2002:a05:690c:74c6:b0:6ee:b7cf:4a8f with SMTP id 00721157ae682-6eebd2e3f20mr45170247b3.38.1732130032164;
        Wed, 20 Nov 2024 11:13:52 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee7137f39esm23674297b3.121.2024.11.20.11.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 11:13:51 -0800 (PST)
Date: Wed, 20 Nov 2024 14:13:50 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 3/6] hash.h: introduce `unsafe_hash_algo()`
Message-ID: <17f92dba34bee235177c8100daab49068fe37254.1732130001.git.me@ttaylorr.com>
References: <cover.1732130001.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1732130001.git.me@ttaylorr.com>

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
index b1a3463852c..fddcdbe9ba6 100644
--- a/object-file.c
+++ b/object-file.c
@@ -204,6 +204,22 @@ static void git_hash_unknown_final_oid(struct object_id *oid UNUSED,
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
@@ -241,6 +257,7 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		.unsafe_update_fn = git_hash_sha1_update_unsafe,
 		.unsafe_final_fn = git_hash_sha1_final_unsafe,
 		.unsafe_final_oid_fn = git_hash_sha1_final_oid_unsafe,
+		.unsafe = &sha1_unsafe_algo,
 		.empty_tree = &empty_tree_oid,
 		.empty_blob = &empty_blob_oid,
 		.null_oid = &null_oid_sha1,
@@ -307,6 +324,15 @@ int hash_algo_by_length(int len)
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
2.47.0.237.gc601277f4c4


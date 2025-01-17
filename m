Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A706C1DE8A2
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 22:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737151404; cv=none; b=PBaAHTNFtRO5RQ6aw6/CdHSEGoIQ5pbZkqiXAn5EnLFun/efsLFqfbRj6Y/0ryft4B5qgPZ/rkUEC3HNzQOSLRMe05IAVUkHSkCmVWV0xBq9yjmG6YjiR4sOgjkQ4KtEtLHSZNrk/QF9fxYhO33ozs3AzfUergfUkCTDJwuFYaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737151404; c=relaxed/simple;
	bh=UuKVjRxNWzII24LfmOG9qyDwdfx0WBYGreOP/x6qCMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIMMTevDPXufekKkfsEe1pdZaVoZN1cZnvhJBgrgK8ukSU2WUw3hhPjyk1AxxhzZ/M/LbbG15VpCBc2kBl6xOSWXG0Ek4F7izTHVZQ+v2vW2XiYhe5lCc0FHxsdvAva9ps12ULT9aHN1XqKlTTT9o5L8Zc2l5ZBiTIw9bjckGYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ojuqGphg; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ojuqGphg"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e3a26de697fso4320554276.3
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 14:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1737151401; x=1737756201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3nU3sFVreh/uBgnQRMHuOup+HRxvtN28BUpzFT9vj+I=;
        b=ojuqGphgvPRglTiEzt229i7PFlijqQoeQK5Xn89U0G8RA32Ovr9dnQWCEVwhm1NWn0
         h1JCjix1MJLFrEddZzZTQImp0vMhWxdAM7IfuzeviQ44EAhocr9Y9Mu8Nm4yuMHJoscu
         Wp44O1WJzThAM6FK9TTBBbF7gkmuBHE1i1yRgEkW7oHzixNtwejhDmfu00hwKHT2j6Bw
         Z5IBHuvmgFCGUCU6IIFaZZp13cOYVGEooCW8wcVl05TrnGrurFbRio27fquaWS7naoqZ
         E3/xYU9MBZ1BCWMEZvOBATSYU+2/6BKuiaFwj+YPZMjeKPQn8zhpqYLb2EhgGSNzvJHK
         eE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737151401; x=1737756201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nU3sFVreh/uBgnQRMHuOup+HRxvtN28BUpzFT9vj+I=;
        b=IP/jADIxIIAE3wiHauC47FQpcftuZ6ZfsUnmukvt4uMsTaAWB87I+NagM32bi4aQ72
         niJZvBm0k6tqHh1Y2daIdgrwIdoKie8QOHGAYxZiJPAtA9Bu57TXPKi6GOonBfO80slr
         Nej290uxNb8hTLnlimFQbTL6Bxr7ksAscKtD2FWagZCMk8XPc5HuZypEcctc5JnxQDHp
         lwBWWSPO3mvCkYmrRBzFTZ0I0pReVnjkr92A6TBk5+UD0/oD0mud1TyYahtDzaoeJqqC
         9k3iHEY6DM8CaDBBDa9xLJ6hca7I12iQW7gOvCAWHr/kxXEbtmsStyOYXE3vgTKfUw+a
         6Lpw==
X-Gm-Message-State: AOJu0YxDR3924whxaXqmaa7FPd4r07fC7BPGgtf+HLtdSUaVVUER/g1E
	COzTQC9pixZ1fGFbJT0T4hQrmluthWNAupXc8A4oZl1vmBfXRAYTkLLq7cmNwUFDACnZPRdRHaa
	ekFI=
X-Gm-Gg: ASbGncsHbBWODq02VXcbDfI2oYcVPWm+I4U6skyjwftqvzKQK1hnjot4LWn8Zg6Fud6
	NU5+Eab/EoG3++FNxUd+CfoRUbcuy6PHNM5Jyx2LZAn7HRyH5icoFnS1EODktqKg8a8/J2u4DMR
	guBtK+814lE6RdcwZcZ7j9cv0x5bKxBHPB5oaZ1EWru2icDR5mplnYWGr1WyaPxDIsdbwR9bMAJ
	bAQic5oKEmrLEME/kFmnY8mv8I3M0Gf82OwC42r0KO9xjvv30mwGb28/H+6SUqw4tOdjRyjkGvp
	S1RA/91zWxfoitDNB0iRbMKYX3PZLht1X8CxrHcuMQ==
X-Google-Smtp-Source: AGHT+IFX/N0J+bYx6+EOtQ/+IlnGKQN7qSRAZPEPkf28oR2oQkyR43UvpJLS6IzPwI4je1cH+g1H9A==
X-Received: by 2002:a05:6902:2788:b0:e28:ee2b:34fa with SMTP id 3f1490d57ef6-e57b0e28dadmr3583053276.0.1737151401393;
        Fri, 17 Jan 2025 14:03:21 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e57ab4767a5sm576778276.47.2025.01.17.14.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 14:03:21 -0800 (PST)
Date: Fri, 17 Jan 2025 17:03:19 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 4/8] hash.h: introduce `unsafe_hash_algo()`
Message-ID: <b6b2bb2714f8ba9b483b04a2b734a5cd36230eb7.1737151386.git.me@ttaylorr.com>
References: <cover.1732130001.git.me@ttaylorr.com>
 <cover.1737151386.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1737151386.git.me@ttaylorr.com>

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

    algop->init_fn(...);
    algop->update_fn(...);
    algop->final_fn(...);

This removes the existing shortcoming by no longer forcing the caller to
"remember" which variant of the hash functions it wants to call, only to
hold onto a 'struct git_hash_algo' pointer that is initialized once.

Similarly, while there currently is still a way to "mix" safe and unsafe
functions, this too will go away after subsequent commits remove all
direct calls to the unsafe_ variants.

Note that hash_algo_by_ptr() needs an adjustment to allow passing in the
unsafe variant of a hash function. All other query functions on the
hash_algos array will continue to return the safe variants of any
function.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 hash.h        | 13 ++++++++++++-
 object-file.c | 26 ++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/hash.h b/hash.h
index 756166ce5e8..a68a2b6a161 100644
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
 
@@ -320,9 +323,17 @@ int hash_algo_by_length(int len);
 /* Identical, except for a pointer to struct git_hash_algo. */
 static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
 {
-	return p - hash_algos;
+	size_t i;
+	for (i = 0; i < GIT_HASH_NALGOS; i++) {
+		const struct git_hash_algo *algop = &hash_algos[i];
+		if (p == algop || (algop->unsafe && p == algop->unsafe))
+			return i;
+	}
+	return GIT_HASH_UNKNOWN;
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
2.48.0.rc2.35.g0c4d006e6e8


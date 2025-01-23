Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2024A1581E1
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 17:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737653674; cv=none; b=L5h9WxepUGTRzOMG9qUm5vNWaViWlHhitMRD/XHbIOLPvNb8Jy+6XFSswqJKObTnDIx/q0ONVxK+6wNbZBTPbpiatmzMhYhx3EbddFHGIwoQGKTzi3HVpZPhO0i/p5sZJilKsKzivvggpZxFdJdCq/kNkBnKX+9pk8tEzF+8QaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737653674; c=relaxed/simple;
	bh=tKuokJvo/WLcpKuTv5D85uir6Kce7cwhYiN7194yR2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVMaJPxMPexJYudiWXlR9o06P2xNvQbNtRx7qz0TFl4/jbw3lfuOs9Vdj7+YVBby6BGTDZeflApiqdexbhdVKI+n5GcZU0tjlN656VJzvPFcmk8Rw87NsefJpIV+UktvvCeQmpXH7d71L1oUfVyK6ElAHqDzWMTo2ALG4J2YTB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=2wi79pxU; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="2wi79pxU"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e573136107bso2013470276.3
        for <git@vger.kernel.org>; Thu, 23 Jan 2025 09:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1737653672; x=1738258472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yoym53bWBwApkNdptCke/Beu/+I3YNdcEMeZRNHNY5Q=;
        b=2wi79pxUfBuvyEIsKFQbqTygP6Sp1TM8zjfGsOrYWFXDLPDEdl/DYkkgHx0CMLhBuh
         mGTrM1c2yXmK819m6VxLXmsUXntWyN+VGaYx9dH7NdVrfJqYg0Yea6AZuE3LLAzwqWTg
         rWu56FuJFRBGCBgKwpM40P+7wYlT1Ic+73BM0ygWUo0h2sn2P1WQHxcfLFgnnlOdnEtC
         b/cw8iGN1PL+oqpUV/xi/aWJYso5phGXrIMe7773OlJ76UP4THVX2z5EESbkiB+cntpb
         GbzYjt7UulcZq5cfpVU6n6FesZ/BVARV00vXV7UUTyjnkANAuR06GcSvYHd8P2A5iudj
         FiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737653672; x=1738258472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yoym53bWBwApkNdptCke/Beu/+I3YNdcEMeZRNHNY5Q=;
        b=o6Y3JG/b+/hjG1P1Ome1kPI/U5Dx/7WrE5Y5kkDFHf5DA/0ofdoKaucpreXd7rzyyU
         lPNsYW93iAL3B3deVqJnDLwwKlBsrRv2osSIVTbuPHJTX21elGQXiAmuS+A54rQaNc/A
         oGNFKripT2prPuumkaDt+5GnyQ0oP+xNKdszbbev6rqfKeGeoM/La6TeKzmxroTO4mT5
         ixKpSBq2vW1eNfVo8AH8SLgy5ocql/HAmhXsF/XfprjwnEkdaoBn22Lqj0F4ukoKzzmO
         ioQ5E6+Zrj5pRP8wsKltXMSy24JFCCS7JLts40GmGFOfjPBwCXq4nZzji7W99FRHgJyR
         Bi0g==
X-Gm-Message-State: AOJu0YwBf54fCzquC6gxG6+6D2/Vgd4/tZu+HJDq2a4+AajsdWKpUwPT
	lkng+ARQLs+CZ8r5onRoXqvxE7FTWBV7uhBa0hP9cIGS5WGXlSwjlGeTqVIFHq9yIB79/mB+SWa
	Ms3k=
X-Gm-Gg: ASbGnctU9/JkbBY21QpiVFR8rvmUqpSCmYS+Re9oHT0nOJcDR1Q8Ys17bS6MmWfwtNl
	MtW6zel15pK1gmEaUUoyiNpfoJxTzXqrLiZQxc2/Sa0r0hu2pLwVQftyJFHs7PLmlzibkj2J61D
	MDkeeT8tN7cOxor1BKDik075duk0B2sdhms3grurioc2TxflN/sqFidr47q19mRE8Ww01H3VwpZ
	Qt6h8Uergah0zIHCSKQVUkiiHv4HthsV5XCnJLfqrvPZMNkREw07Gsm3fsU/3RxkLKvQaOp8i3H
	to3Csn3OfTZRUnHiIQRckF9fQgdqNRLJhp5t7QPwQX0VInRN5rnz
X-Google-Smtp-Source: AGHT+IFnwGFCkFn2XUEDC56BhtTWMSGuTd0kKDsXkLTcaK2Zei/T8kxFaaI2HaZGPNtYWBMjdjrw0g==
X-Received: by 2002:a05:690c:4c13:b0:6ef:8e0b:8c63 with SMTP id 00721157ae682-6f6eb677dddmr205259517b3.14.1737653671595;
        Thu, 23 Jan 2025 09:34:31 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f75787710dsm487167b3.4.2025.01.23.09.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 09:34:30 -0800 (PST)
Date: Thu, 23 Jan 2025 12:34:29 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 4/8] hash.h: introduce `unsafe_hash_algo()`
Message-ID: <ae01f1f4274baa81d632f1075c236a6676a9476d.1737653640.git.me@ttaylorr.com>
References: <cover.1732130001.git.me@ttaylorr.com>
 <cover.1737653640.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1737653640.git.me@ttaylorr.com>

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
index 756166ce5e8..0bf63cedfa4 100644
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
+		if (p == algop)
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
2.48.0.rc2.35.gd215225db14


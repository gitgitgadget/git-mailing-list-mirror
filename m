Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621B81C578C
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 19:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732130043; cv=none; b=X+XhCTO5BNugQfwhtCWUr5YCRDJCOz/I9nGYHXFh0X1CYDa5Ybv3wYXPMT1ZBf7kp5mbCP6gLnia+Vogh745bHRenLa0kgNvOwcr/8w/L21fColznkCEBTEun46jjIoasnmHdO2Ts6/z3LR++6WCw7OCPKD25XE+BepoLxvTMtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732130043; c=relaxed/simple;
	bh=WDA0yRZ4FlU5a5TVe4Sr3gbbAhBLDPgxg9I4EDcQ2eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbAdmDVN7dftx2nNwzU+z+nW+vB84W308AN/rQbYQ8iIWt2czjdJiXSiEIHmuNEEe1BXRY+D2Z6YG3cv05XshtX6jHcBqtig4H64ophjvz0oc2o9K9kGgXGboz8yVW+IMcWDSuC/sNAANBSacdVCPNH0UaWeH02iGR86b9wo+wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=NMxnHn0o; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="NMxnHn0o"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6eebc318242so9647b3.3
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 11:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732130041; x=1732734841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s67AtFawONSh7Btfa6Xj/BnkGLf6gX3xPXdnVJFThdA=;
        b=NMxnHn0oeJr+JMnrv64xca6HNWt1Z4T768DBAx0Qas5OFwL4IXD9niu7/MYl35ND9R
         xuVMpXaK3jZxAbWOj4IZIH1UVA83uxtVUP7pnJh2awc7gMipPpGpQebLGT1+QC5oGHtD
         zOE7f9ObTeWOF0yRXl2NghV/E9LHpJdqn7fRcmsF2QWOtY/IFqQAu3LlJrEbZVF+3tzb
         vtAHqgERhO5Nm/ZVoIJNfMjsGnUuvugg9XMtfOqsx+k0BsdRVE/IvSZYtP9L3bJvuZqN
         Slt0ksQLkng//XgGEKbG8GOSh7NjcAMghMi8FHnvl9lE04RyT5ajQxkOcJk4W1ZhFTRL
         AlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732130041; x=1732734841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s67AtFawONSh7Btfa6Xj/BnkGLf6gX3xPXdnVJFThdA=;
        b=EIMFjKVuw5N29hen9sONhw3QCESTtsPH74CkmvDsKQ3aWdj7pqZYsTxnXk3boumzMr
         P+MCvZ1ELC4020ZH8xq/gg4DuUHITe1MFqls+ffV2rT38XnZQSOqvhqnhn19WGfTZhVL
         K+Gt05ckVcdScqdM7jFTsEgMVogHmUD1akTsV7u0V6rzJq7ai+kOkiJkhwx8WTZC93I2
         YxUeUz2xQAnHED3tePMg5tvAnyozsC2lQAdCAIuFHLtc+LmhJ2xtWXrCRelCLjWiU4+q
         LF9c0NPx/Z1UPldS2z+lgdhQg8nOWLI1+paTOfCg3EYAoPnq4mr0x3LR6YtKu3JZKXKK
         sNjg==
X-Gm-Message-State: AOJu0YzKo3ryFOMivNW2f1n/RO5CYedje95z1JkU6VWt7kSzZ5RXtXgR
	Oz/nk1KUg9jLczhIj36iUMtsNuC/LMwhdYHFU6GYf8wEX40aMTY22KU73DQcMp9+7qVw4ZIYUMC
	P
X-Google-Smtp-Source: AGHT+IF3K/Xv+rlc76gtCJC6zQk1qaIP1nfQ9r1w79mFdN8i7OkeBVYQUsDC7DJ9Uir16EFUeN9BNQ==
X-Received: by 2002:a05:690c:74c6:b0:6e7:e76e:5852 with SMTP id 00721157ae682-6eebd2ae557mr46862577b3.32.1732130041194;
        Wed, 20 Nov 2024 11:14:01 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee71278665sm23606997b3.22.2024.11.20.11.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 11:14:00 -0800 (PST)
Date: Wed, 20 Nov 2024 14:13:59 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 6/6] hash.h: drop unsafe_ function variants
Message-ID: <4081ad08549895a1b05c45fbc6f229683fec3963.1732130001.git.me@ttaylorr.com>
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

Now that all callers have been converted from:

    the_hash_algo->unsafe_init_fn();

to

    unsafe_hash_algo(the_hash_algo)->unsafe_init_fn();

and similar, we can remove the scaffolding for the unsafe_ function
variants and force callers to use the new unsafe_hash_algo() mechanic
instead.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 hash.h        | 15 ---------------
 object-file.c | 15 ---------------
 2 files changed, 30 deletions(-)

diff --git a/hash.h b/hash.h
index 23cf6876e50..6dcbf6ab835 100644
--- a/hash.h
+++ b/hash.h
@@ -282,21 +282,6 @@ struct git_hash_algo {
 	/* The hash finalization function for object IDs. */
 	git_hash_final_oid_fn final_oid_fn;
 
-	/* The non-cryptographic hash initialization function. */
-	git_hash_init_fn unsafe_init_fn;
-
-	/* The non-cryptographic hash context cloning function. */
-	git_hash_clone_fn unsafe_clone_fn;
-
-	/* The non-cryptographic hash update function. */
-	git_hash_update_fn unsafe_update_fn;
-
-	/* The non-cryptographic hash finalization function. */
-	git_hash_final_fn unsafe_final_fn;
-
-	/* The non-cryptographic hash finalization function. */
-	git_hash_final_oid_fn unsafe_final_oid_fn;
-
 	/* The OID of the empty tree. */
 	const struct object_id *empty_tree;
 
diff --git a/object-file.c b/object-file.c
index fddcdbe9ba6..1040a5408f2 100644
--- a/object-file.c
+++ b/object-file.c
@@ -232,11 +232,6 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		.update_fn = git_hash_unknown_update,
 		.final_fn = git_hash_unknown_final,
 		.final_oid_fn = git_hash_unknown_final_oid,
-		.unsafe_init_fn = git_hash_unknown_init,
-		.unsafe_clone_fn = git_hash_unknown_clone,
-		.unsafe_update_fn = git_hash_unknown_update,
-		.unsafe_final_fn = git_hash_unknown_final,
-		.unsafe_final_oid_fn = git_hash_unknown_final_oid,
 		.empty_tree = NULL,
 		.empty_blob = NULL,
 		.null_oid = NULL,
@@ -252,11 +247,6 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		.update_fn = git_hash_sha1_update,
 		.final_fn = git_hash_sha1_final,
 		.final_oid_fn = git_hash_sha1_final_oid,
-		.unsafe_init_fn = git_hash_sha1_init_unsafe,
-		.unsafe_clone_fn = git_hash_sha1_clone_unsafe,
-		.unsafe_update_fn = git_hash_sha1_update_unsafe,
-		.unsafe_final_fn = git_hash_sha1_final_unsafe,
-		.unsafe_final_oid_fn = git_hash_sha1_final_oid_unsafe,
 		.unsafe = &sha1_unsafe_algo,
 		.empty_tree = &empty_tree_oid,
 		.empty_blob = &empty_blob_oid,
@@ -273,11 +263,6 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		.update_fn = git_hash_sha256_update,
 		.final_fn = git_hash_sha256_final,
 		.final_oid_fn = git_hash_sha256_final_oid,
-		.unsafe_init_fn = git_hash_sha256_init,
-		.unsafe_clone_fn = git_hash_sha256_clone,
-		.unsafe_update_fn = git_hash_sha256_update,
-		.unsafe_final_fn = git_hash_sha256_final,
-		.unsafe_final_oid_fn = git_hash_sha256_final_oid,
 		.empty_tree = &empty_tree_oid_sha256,
 		.empty_blob = &empty_blob_oid_sha256,
 		.null_oid = &null_oid_sha256,
-- 
2.47.0.237.gc601277f4c4

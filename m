Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9991F13D882
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 17:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737653688; cv=none; b=ZG0p9BKV+Ce/ASmhJu20hQTd9BvynTHgvbzWpuKaoZ9Lp914joLgOxgeL3ch15A8UWwDfn/rDr4Z9qooFRODla8NlU6imxUhsQfrIgQMlzbo4CjCYxcQp6QKlnuuD4yrBB/dhJM/O9ikEOT2zArPnWlec7oa+KCatYY+ocfMp+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737653688; c=relaxed/simple;
	bh=ZxufP7yCO8MOsTX4t0D2bm0+KT8jpBLSNFAIQRpzwW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nK9Xy0HfUzzfSahQ3vd4xctsrk+YE4sa6DTGc8rQIPPkCj8hX4I54dswaknIIZydob1hEOKVMRJSVabUQJ4ZQjGFuVs9uZHFoAU6T/jAy2eEMYHE8xIV7PWRusmy7pK22be1aN4AXPOL3Gsfem09JLIhjpWXDdfV/XMqTuJ/Qkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=emkVgVWG; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="emkVgVWG"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e53ef7462b6so2001806276.3
        for <git@vger.kernel.org>; Thu, 23 Jan 2025 09:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1737653684; x=1738258484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QA4d8lONclLoGTt0Pu9UVbPowqoU8qd1DWCHz0he9Zc=;
        b=emkVgVWGDz2ukpMwtHIPyWO2u8JdOBsgvYZHT/8RgRAt3dSKJADwFJplywM+4hqpRx
         8ZECw2ztn+bno/C+MT2UGFg6UmVOD81Fb2Ut6nR5T+Tr6bQ3dwcRbvQkjZzBaGT35Hhb
         zGfYNqQIKUBLt+xhmTqrUAGBQw+JcaNg67w5WC047e6b6ppfdfYj7nq3LPkXpynTQ7sl
         AFljzz8xcLfiz1CsbMXZw+s4Tt2GDm4QTY5CarsgTAmsnBu6MfXIX4ZmC2Z5yFF1vQiq
         NpWU7MWKHcKBRbv6dK4AIzcyAl5Y1NnMFB2Bx4TwAt+F4ODHo8elP64k0hhdZKeUuoPb
         M1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737653684; x=1738258484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QA4d8lONclLoGTt0Pu9UVbPowqoU8qd1DWCHz0he9Zc=;
        b=moJ7K64ZlCge4EBXym4JkRPtBmjJ/C9yc3VaNnR3Lda8J5bTksn2galCJ6n1aRI/F7
         8lAAHrMhZCYeDNyq7tMRNo/tr10dWQwhB9C/zzfemYP74/EaSso7/CiZMlx6OW/dqNp6
         ywePF9xS3tLoUdkei3QVwhlhLQPrPzWXPY4n57TACJ9gkeP+1EYRp+pHIgTGaA38MViB
         fdma042CwYJ0wUFv8lVIUtVsvtxAd956xfXBFiADjYInty3R+o4xH4Fe3kMvVMiAo/ak
         nbZOdc7bPRH5+ajQtsUHFG1fy9Z4kZ0Fd2fvnIZk5wvTKaB10BjruXOkURfMV5vq0Q8d
         kQKA==
X-Gm-Message-State: AOJu0Yz6ualSh6FCTx84nExvXrC74m0S6zHoBM/cY2ZinzIfc6S17vTI
	ruSTnnKzp3zoPZzQXDXLLzvEakISFg4bjhqJBa0QABzkGxUioN7b1DTP1UCSzEcL5CIDa4djv4V
	rpCs=
X-Gm-Gg: ASbGncu+5wdlfLvVyFToZiatjZ2+idpJT5BpWfBUAGLaWCWzHoA55+koeid7tcxMuO0
	J+QMWTkwoXuV4I85x1cTVwllhmFKKGYJKDWXBW5b8pysbx9dVNBpAIxhxo4fWM+KdPzdIjE1YDT
	7uKD8gWNSznPbBN9I35OYN0und8OWC8/Nh055CRaxRODzm30UPucHvR7YKcgnSWNgbHEnKxqctw
	qoRDwcANj2jpmxKj5ebN2aYezZaDZX6h4vrjy1oNd4p/zxLIqC797AzlZ1A+8tSRZqwFDJNRuQm
	NH1ZCcTY7uIkqt8sUbO57Pd+rLphbg6+mRvTVyChfNwyz+/wChZoWmkpsR679F0=
X-Google-Smtp-Source: AGHT+IFOCx4Ug2PR8TPown5J9ppR9MKRRuzk0jV9O/HiMXzaKt8bKdF7vJs7uDCrIUN9v+lKX/l5QQ==
X-Received: by 2002:a05:690c:6603:b0:6ef:c5f6:2ac8 with SMTP id 00721157ae682-6f6eb904750mr219145267b3.27.1737653684031;
        Thu, 23 Jan 2025 09:34:44 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f757891e2esm483877b3.45.2025.01.23.09.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 09:34:43 -0800 (PST)
Date: Thu, 23 Jan 2025 12:34:42 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 8/8] hash.h: drop unsafe_ function variants
Message-ID: <0ba27182b5ed666cb9f49c674f2597eec7572b90.1737653640.git.me@ttaylorr.com>
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

Now that all callers have been converted from:

    the_hash_algo->unsafe_init_fn();

to

    unsafe_hash_algo(the_hash_algo)->init_fn();

and similar, we can remove the scaffolding for the unsafe_ function
variants and force callers to use the new unsafe_hash_algo() mechanic
instead.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 hash.h        | 15 ---------------
 object-file.c | 15 ---------------
 2 files changed, 30 deletions(-)

diff --git a/hash.h b/hash.h
index 0bf63cedfa4..ad2c919991c 100644
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
index 43efa4ca361..c4b42dd4be9 100644
--- a/object-file.c
+++ b/object-file.c
@@ -230,11 +230,6 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
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
@@ -250,11 +245,6 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
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
@@ -271,11 +261,6 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
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
2.48.0.rc2.35.gd215225db14

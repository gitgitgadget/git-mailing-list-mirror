Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2399F19F410
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 15:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549143; cv=none; b=Lfpltsoxh8/v2vShAMrxtqZ3BevV+0ujC2o/kkQcb49xU4+y5ueSn7uRF/d7d7EDJ0MczTwzFn1h2UcKvzZJOix72jZgStgW9cOXscFhLUkSFoFZdRQ1jIR2YcoIl+FG2RgiCWcteEbU9nsVcTFsN+nj4zVTHts00faEoM2VEbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549143; c=relaxed/simple;
	bh=+v5OILyR1nbXGMAhyA8e1HI6+7BmIO0GsD6M4zRnO8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D12NqW+PqDnuisikUAExCL4JztmhAVJHNR1XptcCIUKMlcenroTBogWc83QENR/JjWzvkZaOvno4F0tX1mCbYrd7M5P9dRJLiI3dw67M3s6MR0AVvjtqHQsnA2d+a/8+ChJQgsVge5MJadJ6LmiTCgcGEKR4JzlUZa6G9zrT0JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=H1mIAs9X; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="H1mIAs9X"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e1a7d43a226so1040503276.3
        for <git@vger.kernel.org>; Thu, 05 Sep 2024 08:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1725549141; x=1726153941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ntnVsOdFVlYlD36fmabeFc4pLf2muLBYQlVWcydQW14=;
        b=H1mIAs9Xfdndefxs7Rew42RTc9zL4Ac8HCj5k8OcGNrRBVX5Hc4w9xZr/7dOl19mX5
         IOuICRnK9Neq2KvjfMBRAHvtVhWw+FUkQ7Gp8p7E3bYM8n6hgZJriYCdvNIubwT1U5mb
         nhREbNroJroN86mhq34JnGZZJmbUIQIqQRhRWwYb8FSid+uhSisd25BjAOEldg9RdJQN
         mIOQu20DKtN7gr2uhGZ6mI6+NlhmHwEEVt4/WArcOXkQKHBVDf4IcAa1AUTxPhFFuW6o
         UJqNZOLVfkc73zH4twhqQzgGMMhHq8iKg8G0EI4inbNKBF89ISV/NbsTHGTQkQUZUy+k
         6Hdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725549141; x=1726153941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntnVsOdFVlYlD36fmabeFc4pLf2muLBYQlVWcydQW14=;
        b=Mc68hYJ0I6+TdKtWyVqqrddSNM1+1gY1t2kgiPoHpJJpTAnZUxDSmCJmUXr2/iwhOP
         fd3pxD6wFfmL/zWxnRO9csIpqNkjT+48TcKNi+HYmTIEncHd2xw0y7z2074THD0jxB/T
         7JIdns3wE1Uze9WD3taNytTpkV/MhHTi3Wm5Gem9Lb6WcdVJR6L4eIG9aOGxJqViPCOJ
         4gsfKKNwQXaHSYFdJwlW6fwepyN0q1VCGgNAV0PzcOxVKMj9yAv9qSnFoghYU0MdCYUY
         v2ecqnbs98z99uU+uFXLfrjKta4aK46ZkeB4AYte1rjGXk3cNLLyLCVubZrtSpthbLSP
         WHkw==
X-Gm-Message-State: AOJu0YwH0R0LfnQ7sIpY/kYJ+huBSK615sCnFbMYZC51MPK41J7mia/M
	xiCo1iZXi1hQE3M1GFdoGXZ4ZWEkik1VefvLX132nWwHtcJQUam7NAokgZZEy9qs/yLnD1+uYv7
	R3y4=
X-Google-Smtp-Source: AGHT+IGXI/yTd5T0EpC6AepJ94tyBiCYzfwTK2Z812HpT2YF0rmygz8mssFDGFFI8IUKh9IzYvO8Xg==
X-Received: by 2002:a05:6902:2188:b0:e0e:4abc:bbd3 with SMTP id 3f1490d57ef6-e1a7a04154amr20507893276.25.1725549140370;
        Thu, 05 Sep 2024 08:12:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1a8e7a14a5sm2448788276.20.2024.09.05.08.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 08:12:19 -0700 (PDT)
Date: Thu, 5 Sep 2024 11:12:18 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/4] csum-file.c: use fast SHA-1 implementation when
 available
Message-ID: <311fcc95960ed46d2ff01a61e554e0a2efbbe931.1725549065.git.me@ttaylorr.com>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1725549065.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1725549065.git.me@ttaylorr.com>

Update hashwrite() and friends to use the fast_-variants of hashing
functions, calling for e.g., "the_hash_algo->fast_update_fn()" instead
of "the_hash_algo->update_fn()".

These callers only use the_hash_algo to produce a checksum, which we
depend on for data integrity, but not for cryptographic purposes, so
these callers are safe to use the fast (and potentially non-collision
detecting) SHA-1 implementation.

To time this, I took a freshly packed copy of linux.git, and ran the
following with and without the OPENSSL_SHA1_FAST=1 build-knob. Both
versions were compiled with -O3:

    $ git for-each-ref --format='%(objectname)' refs/heads refs/tags >in
    $ valgrind --tool=callgrind ~/src/git/git-pack-objects \
        --revs --stdout --all-progress --use-bitmap-index <in >/dev/null

Without OPENSSL_SHA1_FAST=1 (that is, using the collision-detecting
SHA-1 implementation for both cryptographic and non-cryptographic
purposes), we spend a significant amount of our instruction count in
hashwrite():

    $ callgrind_annotate --inclusive=yes | grep hashwrite | head -n1
    159,998,868,413 (79.42%)  /home/ttaylorr/src/git/csum-file.c:hashwrite [/home/ttaylorr/src/git/git-pack-objects]

, and the resulting "clone" takes 19.219 seconds of wall clock time,
18.94 seconds of user time and 0.28 seconds of system time.

Compiling with OPENSSL_SHA1_FAST=1, we spend ~60% fewer instructions in
hashwrite():

    $ callgrind_annotate --inclusive=yes | grep hashwrite | head -n1
     59,164,001,176 (58.79%)  /home/ttaylorr/src/git/csum-file.c:hashwrite [/home/ttaylorr/src/git/git-pack-objects]

, and generate the resulting "clone" much faster, in only 11.597 seconds
of wall time, 11.37 seconds of user time, and 0.23 seconds of system
time, for a ~40% speed-up.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 csum-file.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index bf82ad8f9f5..cb8c39ecf3a 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -50,7 +50,7 @@ void hashflush(struct hashfile *f)
 
 	if (offset) {
 		if (!f->skip_hash)
-			the_hash_algo->update_fn(&f->ctx, f->buffer, offset);
+			the_hash_algo->fast_update_fn(&f->ctx, f->buffer, offset);
 		flush(f, f->buffer, offset);
 		f->offset = 0;
 	}
@@ -73,7 +73,7 @@ int finalize_hashfile(struct hashfile *f, unsigned char *result,
 	if (f->skip_hash)
 		hashclr(f->buffer, the_repository->hash_algo);
 	else
-		the_hash_algo->final_fn(f->buffer, &f->ctx);
+		the_hash_algo->fast_final_fn(f->buffer, &f->ctx);
 
 	if (result)
 		hashcpy(result, f->buffer, the_repository->hash_algo);
@@ -128,7 +128,7 @@ void hashwrite(struct hashfile *f, const void *buf, unsigned int count)
 			 * f->offset is necessarily zero.
 			 */
 			if (!f->skip_hash)
-				the_hash_algo->update_fn(&f->ctx, buf, nr);
+				the_hash_algo->fast_update_fn(&f->ctx, buf, nr);
 			flush(f, buf, nr);
 		} else {
 			/*
@@ -174,7 +174,7 @@ static struct hashfile *hashfd_internal(int fd, const char *name,
 	f->name = name;
 	f->do_crc = 0;
 	f->skip_hash = 0;
-	the_hash_algo->init_fn(&f->ctx);
+	the_hash_algo->fast_init_fn(&f->ctx);
 
 	f->buffer_len = buffer_len;
 	f->buffer = xmalloc(buffer_len);
@@ -208,7 +208,7 @@ void hashfile_checkpoint(struct hashfile *f, struct hashfile_checkpoint *checkpo
 {
 	hashflush(f);
 	checkpoint->offset = f->total;
-	the_hash_algo->clone_fn(&checkpoint->ctx, &f->ctx);
+	the_hash_algo->fast_clone_fn(&checkpoint->ctx, &f->ctx);
 }
 
 int hashfile_truncate(struct hashfile *f, struct hashfile_checkpoint *checkpoint)
@@ -219,7 +219,7 @@ int hashfile_truncate(struct hashfile *f, struct hashfile_checkpoint *checkpoint
 	    lseek(f->fd, offset, SEEK_SET) != offset)
 		return -1;
 	f->total = offset;
-	the_hash_algo->clone_fn(&f->ctx, &checkpoint->ctx);
+	the_hash_algo->fast_clone_fn(&f->ctx, &checkpoint->ctx);
 	f->offset = 0; /* hashflush() was called in checkpoint */
 	return 0;
 }
@@ -245,9 +245,9 @@ int hashfile_checksum_valid(const unsigned char *data, size_t total_len)
 	if (total_len < the_hash_algo->rawsz)
 		return 0; /* say "too short"? */
 
-	the_hash_algo->init_fn(&ctx);
-	the_hash_algo->update_fn(&ctx, data, data_len);
-	the_hash_algo->final_fn(got, &ctx);
+	the_hash_algo->fast_init_fn(&ctx);
+	the_hash_algo->fast_update_fn(&ctx, data, data_len);
+	the_hash_algo->fast_final_fn(got, &ctx);
 
 	return hasheq(got, data + data_len, the_repository->hash_algo);
 }
-- 
2.46.0.426.g82754d92509.dirty

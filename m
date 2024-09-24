Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614841AC424
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 17:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727199160; cv=none; b=f1p6JZiq+xAGU5ay6Fi8QQc2ZyNugdO4tgwFGJbjBj6N9AbUqL8ut0GSmMZKwBiYrcrDmhrkRo6EUeNGfA9IZML7i2NdT4wt8GN92UgBx45MQuUoB/Eah+uKjyHtuTw+RCql1jVsKt07289r2xQMYsHyb+zBRXTmAh0/c0sA5Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727199160; c=relaxed/simple;
	bh=NTLuwDjSEVo2enM6qrGpPVedmwmZAHc9WQo6iK9j2mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yxf3E1AJpb3Ax/Z5mf3XgecJHcyjrrTJdlfKbyyWKaq5kTVJVkNHdclx2HPRAjX/Yfz0cGV50WfUEakS3xlVnkjVIMVqvVNkMiZ39PwhoTm9jSlPhnLdF2jdjSUXG4yJgx8d3igHSQBGzyZ4vPVrgTYs0eSPhV5n2ee8xfh2Nbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=MVB9r6VL; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="MVB9r6VL"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e1f48e7c18so21152747b3.3
        for <git@vger.kernel.org>; Tue, 24 Sep 2024 10:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727199157; x=1727803957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c0lIMfZ9NfUkQbUEE/VkzFEp0wafK+H/olc9cy1kxFY=;
        b=MVB9r6VLOtgvC/sayM9Gi9G2q3/yQh8yujCYXqDevPg7DdIA7f6tHtMJCxrhUBdSYY
         SSsNKhRgD0sNqqqIjRBNQIc52gpps4muCyjlA14rND52rMgR671/zyn185iIIF1LUU7o
         yhh9KSPxuFFtmH5tfzMM8lIRbK2sw2SeCsUt2Jg6sifA7OIFJrAAmRvqd0HLc4A2kxHX
         jZrEkucn9pbGzhN5uew7fsNRLJddbqgrK3BcHSQWGaNIF0Ayq96vlU2eGKbf7uY3oKoM
         IHauvYAl+VaTiXlhD3JacbMlNgV1tjF9oIOzeC+/zjNcxsVHZHue2OO1kSdKEZ2VuYtG
         /wsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727199157; x=1727803957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0lIMfZ9NfUkQbUEE/VkzFEp0wafK+H/olc9cy1kxFY=;
        b=O4HW6kftZz1noOV4+9pV+tHn9nlu1gY5eDDEHi/jZ3fK8LOKMuGdaRTQycDAgFW9b1
         xPgwd9rmvy8W4kkqbInhquyr/BQcXNX7jUB7wfMVBzKF46JcHWfwSEhJ3rODM+FdLAXA
         wuIY8GpGZHrLYH1ZFqzdJbajVR47n8Hz85KxC/48KYXirUU21wFclFopwCS0mu260D7C
         M6Uf2zGfihlrziiPENbHXRLS5ZK0c1P8RpkZDFyaN+/YfZrXck1e3I3xdwJ63TxPEZE1
         1kOsNHZg5CVb0q2adR746FAAKNfYIYS3ETQgR1ObQyWaFQHDU6csTsoMNRPl9dnsAIZq
         SVWQ==
X-Gm-Message-State: AOJu0Yy3k+Pgn5HD9pRWT6rrBEfbOIlR00FJPaTS4EsVc0WyvJtKlsd+
	2Dv8GnB1V1wrPf3cPYBj4mxn4wD+ZzjZ1Xxij1UfrHnCRH6hGkkc37sARCzWJe0hKAVQEt29X8a
	Qqc4=
X-Google-Smtp-Source: AGHT+IGDuvAhgzuMc+kXitqrQUQTd7YYGD1xLPy8155O8D++1cmVh8TJiTF4JfJt0a0LGmERdLdbOg==
X-Received: by 2002:a05:690c:4a90:b0:6db:e2a3:4158 with SMTP id 00721157ae682-6e21db97daamr1007027b3.46.1727199156849;
        Tue, 24 Sep 2024 10:32:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e20d03d4e6sm3160707b3.31.2024.09.24.10.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 10:32:36 -0700 (PDT)
Date: Tue, 24 Sep 2024 13:32:35 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 8/8] csum-file.c: use unsafe SHA-1 implementation when
 available
Message-ID: <4b83dd05e9fe55e1ebd07f4b60831e1ddd404c0a.1727199118.git.me@ttaylorr.com>
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

Update hashwrite() and friends to use the unsafe_-variants of hashing
functions, calling for e.g., "the_hash_algo->unsafe_update_fn()" instead
of "the_hash_algo->update_fn()".

These callers only use the_hash_algo to produce a checksum, which we
depend on for data integrity, but not for cryptographic purposes, so
these callers are safe to use the unsafe (and potentially non-collision
detecting) SHA-1 implementation.

To time this, I took a freshly packed copy of linux.git, and ran the
following with and without the OPENSSL_SHA1_UNSAFE=1 build-knob. Both
versions were compiled with -O3:

    $ git for-each-ref --format='%(objectname)' refs/heads refs/tags >in
    $ valgrind --tool=callgrind ~/src/git/git-pack-objects \
        --revs --stdout --all-progress --use-bitmap-index <in >/dev/null

Without OPENSSL_SHA1_UNSAFE=1 (that is, using the collision-detecting
SHA-1 implementation for both cryptographic and non-cryptographic
purposes), we spend a significant amount of our instruction count in
hashwrite():

    $ callgrind_annotate --inclusive=yes | grep hashwrite | head -n1
    159,998,868,413 (79.42%)  /home/ttaylorr/src/git/csum-file.c:hashwrite [/home/ttaylorr/src/git/git-pack-objects]

, and the resulting "clone" takes 19.219 seconds of wall clock time,
18.94 seconds of user time and 0.28 seconds of system time.

Compiling with OPENSSL_SHA1_UNSAFE=1, we spend ~60% fewer instructions
in hashwrite():

    $ callgrind_annotate --inclusive=yes | grep hashwrite | head -n1
     59,164,001,176 (58.79%)  /home/ttaylorr/src/git/csum-file.c:hashwrite [/home/ttaylorr/src/git/git-pack-objects]

, and generate the resulting "clone" much unsafeer, in only 11.597 seconds
of wall time, 11.37 seconds of user time, and 0.23 seconds of system
time, for a ~40% speed-up.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 csum-file.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index bf82ad8f9f5..c203ebf11b3 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -50,7 +50,7 @@ void hashflush(struct hashfile *f)
 
 	if (offset) {
 		if (!f->skip_hash)
-			the_hash_algo->update_fn(&f->ctx, f->buffer, offset);
+			the_hash_algo->unsafe_update_fn(&f->ctx, f->buffer, offset);
 		flush(f, f->buffer, offset);
 		f->offset = 0;
 	}
@@ -73,7 +73,7 @@ int finalize_hashfile(struct hashfile *f, unsigned char *result,
 	if (f->skip_hash)
 		hashclr(f->buffer, the_repository->hash_algo);
 	else
-		the_hash_algo->final_fn(f->buffer, &f->ctx);
+		the_hash_algo->unsafe_final_fn(f->buffer, &f->ctx);
 
 	if (result)
 		hashcpy(result, f->buffer, the_repository->hash_algo);
@@ -128,7 +128,7 @@ void hashwrite(struct hashfile *f, const void *buf, unsigned int count)
 			 * f->offset is necessarily zero.
 			 */
 			if (!f->skip_hash)
-				the_hash_algo->update_fn(&f->ctx, buf, nr);
+				the_hash_algo->unsafe_update_fn(&f->ctx, buf, nr);
 			flush(f, buf, nr);
 		} else {
 			/*
@@ -174,7 +174,7 @@ static struct hashfile *hashfd_internal(int fd, const char *name,
 	f->name = name;
 	f->do_crc = 0;
 	f->skip_hash = 0;
-	the_hash_algo->init_fn(&f->ctx);
+	the_hash_algo->unsafe_init_fn(&f->ctx);
 
 	f->buffer_len = buffer_len;
 	f->buffer = xmalloc(buffer_len);
@@ -208,7 +208,7 @@ void hashfile_checkpoint(struct hashfile *f, struct hashfile_checkpoint *checkpo
 {
 	hashflush(f);
 	checkpoint->offset = f->total;
-	the_hash_algo->clone_fn(&checkpoint->ctx, &f->ctx);
+	the_hash_algo->unsafe_clone_fn(&checkpoint->ctx, &f->ctx);
 }
 
 int hashfile_truncate(struct hashfile *f, struct hashfile_checkpoint *checkpoint)
@@ -219,7 +219,7 @@ int hashfile_truncate(struct hashfile *f, struct hashfile_checkpoint *checkpoint
 	    lseek(f->fd, offset, SEEK_SET) != offset)
 		return -1;
 	f->total = offset;
-	the_hash_algo->clone_fn(&f->ctx, &checkpoint->ctx);
+	the_hash_algo->unsafe_clone_fn(&f->ctx, &checkpoint->ctx);
 	f->offset = 0; /* hashflush() was called in checkpoint */
 	return 0;
 }
@@ -245,9 +245,9 @@ int hashfile_checksum_valid(const unsigned char *data, size_t total_len)
 	if (total_len < the_hash_algo->rawsz)
 		return 0; /* say "too short"? */
 
-	the_hash_algo->init_fn(&ctx);
-	the_hash_algo->update_fn(&ctx, data, data_len);
-	the_hash_algo->final_fn(got, &ctx);
+	the_hash_algo->unsafe_init_fn(&ctx);
+	the_hash_algo->unsafe_update_fn(&ctx, data, data_len);
+	the_hash_algo->unsafe_final_fn(got, &ctx);
 
 	return hasheq(got, data + data_len, the_repository->hash_algo);
 }
-- 
2.46.2.636.g4b83dd05e9f

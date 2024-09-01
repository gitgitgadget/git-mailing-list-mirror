Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E799183CAF
	for <git@vger.kernel.org>; Sun,  1 Sep 2024 16:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725206617; cv=none; b=UO3oUlQ8wZT26uChtyPSn0AA/dUkfcVIcR3UdDkw5SAg/p16rj+x+Qfd4PX/U43TLfaNu7KUht6LXO67Wfolt86MuGKwAv4FRFxnBubx3z9eK6GH5VJLiMLMLeSkucSpT/rqSpcydfwvisJLNiK/74+J0KX4IL/pOSXoRcE/G9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725206617; c=relaxed/simple;
	bh=uxffkUl2BIiQ85XgcgvdR5a6LyYcEDUS0oln3AoW9rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLjvHqc7az3Ov/zkJXHCzxMnLQQHe5H6yvMsskvW8Qb4in+F6oaF7ZCA50FAsoCPRCw/tcsJ5A76i48aAG8RnC5C3cw5q/2MUUkFMIe9YqxdM068ognfdKQuweajFLwAMo+SThpMtpx5nEcx7SDRHUrmVyMK/iw3tsIelkvyq7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=eMyyY0Aq; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="eMyyY0Aq"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e1a9e4fa5aaso854095276.2
        for <git@vger.kernel.org>; Sun, 01 Sep 2024 09:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1725206614; x=1725811414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EcHdwGMtPU4DstWWCxwP4CpV3Zt4cbcBQ5eoR9PyQOI=;
        b=eMyyY0AqEVMIOu3gs2UI3OHlDVG6H2EnT8pOU4RWpBs0TfYkmhquKAaAq6J+bw/rC/
         s2502uQX1PbL8GdgMd7M1O8Qx7rl2DnUKE1DrR7SJJpV7Va6S6MM/BlwmVn94CvK+0lo
         z7W+SVxe626j/wcuWv0MZIGFnprWj1YyvbRoXViTAr1UopRVhDkaCLTvNfY4dcwifn92
         ky3jctLFvVQimmSnWxlJCqqevOpyjPf19nt31AEd3Uja6vvS4BPuRcfdg7vAyOjXDwPw
         3mEC03PNDjiH5ApHdXbWV3zd1+y29utWVTsHmn7FfZtvmu3xioLmWDgartr4rc6WLvy+
         kUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725206614; x=1725811414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcHdwGMtPU4DstWWCxwP4CpV3Zt4cbcBQ5eoR9PyQOI=;
        b=wvmSD8Qy6UDR1WX8tBu2M39iHTcI/Vs10pobPD1gdR93MGfeExXz6MZDtx2iQXiHUi
         y3mFR7a9JbUQ7y5i7jjJkVqhCoP6exKOTSaRuDFIl0n2vKOG4scHjIXBKu8Z0GZHXXru
         kJu/9GlXWwlpVI3EUydkf5A14BwOFTER1r2LGOsKtA27RbNcauRgXzgQnJClGsYakalJ
         ruUzsThp8MZgUAnGHBhRhWq4sopM06xPY88zmEC7TxU8yHNPcwhTkUj5QJEa7qT1gfOT
         ryaQzwES2om9CmnVPG2NerJSLnQ/6AR7W/Y7xASLUPLxsPt9Q9TRbH3rHEREieY3u4DS
         4w1w==
X-Gm-Message-State: AOJu0YyLEs+9A1ZB+BVIjYcIXEx+qsJJrC36M/0AidDKgbmf6lEO+jAN
	m/CxMyvjWhn4fFAq9omciZ0DxpWh58oH3ubmy1SHHf9xizMvBN/8YaWJORHHgGV3h8u404PO25y
	ofUI=
X-Google-Smtp-Source: AGHT+IH9tf0UZcEa1wbwIRlCiLh1ALGrjrJl7MkkRbVRLzGxGDRebBbEt+rTaLOQfntxGWxq4N416Q==
X-Received: by 2002:a05:690c:6d8b:b0:675:a51b:fafd with SMTP id 00721157ae682-6d40f535fffmr95784627b3.31.1725206614212;
        Sun, 01 Sep 2024 09:03:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d6c4eebe3fsm1993487b3.49.2024.09.01.09.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 09:03:33 -0700 (PDT)
Date: Sun, 1 Sep 2024 12:03:32 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] csum-file.c: use fast SHA-1 implementation when available
Message-ID: <e8f5cbd280cc07f68014bd4024d55a740374b349.1725206584.git.me@ttaylorr.com>
References: <cover.1725206584.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1725206584.git.me@ttaylorr.com>

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
2.46.0.425.ge8f5cbd280c

Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D860213B5B4
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727364178; cv=none; b=Q5wijtyIlMEgHZXleYq5YFaaLK6+NnMdhErxkgU52vE77XXNHHB9Maem5hp+3F8Fxy5snafcR5JiZtSD71imHKHqn+AEmnYF3U8QAAxZbaXqQ5qHzSQt/bEyk8csoPx1IvT+DCoFKYHcQCBZ6GO0g/iUKFwKrilHqa6l3yjNdEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727364178; c=relaxed/simple;
	bh=LbV+n+sqRpOxiz6etEHTBA1JtLrES3qyG0fGbqQ74Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvCItRfEs8hw/yp7NSpN0dZTnxZVXmKb2ca8KT9GIujGJ7CEDfVKo2+Pt1t4UcgphlkmR8aJ0WWU2csf+x2TJtiTsh4lhXRQAnLsyuyxzETZtUUykCfq+ArSJVNLexlVZ2arXQxLi8sMnDF+ZhrnP8P9Kfwi69agZo5ssriQnPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=qZGDFb1z; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="qZGDFb1z"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e129c01b04so9982697b3.1
        for <git@vger.kernel.org>; Thu, 26 Sep 2024 08:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727364175; x=1727968975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nHjGNvp/nuRbWxY+dkUxDKmQ7sY3N7norKsRQKZD2E8=;
        b=qZGDFb1zKPn0dMbYYRbNPsecO/vltg07ebWF6QsXWzxBU5EVd97NaA8MaVISLafOaV
         sZwGNDGdkSzWj4sUzKZponXH5ViRH4rKjCqC+5U6maWUDZ+tymwssgMjXrLjsg87tLWU
         rfhJeuDxJejcBdVQoz4Jpd//QvdVTYAXYR8LACe3lcFDuXDKFofMlwv5prsJaeC5Sk8K
         hI3QQG9Tm9YJ5NZV2+GWHF31t2lUHkra2jLEu2SiAeukhB93M0VRqxf9hIiLgqkIdu6V
         YOkSQQN+qYb5po7mKGZrkD8u8D+6MyacwjTLh8/uC/xCTaOj7nPOAFvKgOVoxi3GiUVr
         7W5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727364175; x=1727968975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHjGNvp/nuRbWxY+dkUxDKmQ7sY3N7norKsRQKZD2E8=;
        b=Sq1N9zNObFJVj1Qo4uuRquFJ9W+KE1mSdxmF5hLTymJufl9K0p99aLJQm6eaj8o+ri
         3cYSjY1zD+ljclC7MBIKkWSr3Ldz7G/BIFO9rxREsfuOb3vmKKfqqBksuSxhcr2v4780
         TCsZSyfArVBAa45elviMZib+Si+lEDgOSELbF6FauFxSC2e0n8x51U/pnU/p/5+LPJId
         UtTPq+xIU4MEl1fAi+XGBU5OSAqzK9x8cuVGlnN5jbBNKMPVBXe1vro2qoKVzm9x9jSU
         ZZe9QDCjeLx0qTxUp530TWo755QQCqU4jrEbN6Or6KVORYHcz24YW5QPyflngVRIk4SO
         WVew==
X-Gm-Message-State: AOJu0YyVxUwGhuRnFkn4hRrxyrX2ESdWwlLujfWunu9/yHoYQasROPXq
	+767V/WayKkLI5xedEswPimBPJIEO73dzN2CtnTlJ1gtfYSKuELIJx2VvT1A0SE2VhKET4oiKPd
	/tuk=
X-Google-Smtp-Source: AGHT+IGGssoOqbynoVNB22nXNmJduyFGpDINfrddsBGUbYSM4gWgiKw7HWpaTm5WHDm7l72gy+xS9w==
X-Received: by 2002:a05:690c:d89:b0:6dd:d2c5:b2c with SMTP id 00721157ae682-6e21d6de6b7mr66897037b3.4.1727364175534;
        Thu, 26 Sep 2024 08:22:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e245308eaesm182747b3.41.2024.09.26.08.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 08:22:55 -0700 (PDT)
Date: Thu, 26 Sep 2024 11:22:53 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 8/8] csum-file.c: use unsafe SHA-1 implementation when
 available
Message-ID: <62abddf73dacc8593dde41ef37bab71215fdefa3.1727364141.git.me@ttaylorr.com>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1727364141.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1727364141.git.me@ttaylorr.com>

Update hashwrite() and friends to use the unsafe_-variants of hashing
functions, calling for e.g., "the_hash_algo->unsafe_update_fn()" instead
of "the_hash_algo->update_fn()".

These callers only use the_hash_algo to produce a checksum, which we
depend on for data integrity, but not for cryptographic purposes, so
these callers are safe to use the unsafe (non-collision detecting) SHA-1
implementation.

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

, and generate the resulting "clone" much faster, in only 11.597 seconds
of wall time, 11.37 seconds of user time, and 0.23 seconds of system
time, for a ~40% speed-up.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 csum-file.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index bf82ad8f9f..c203ebf11b 100644
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
2.46.1.507.gffd0c9a15b2.dirty

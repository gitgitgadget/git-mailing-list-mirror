Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050F215CD41
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737653677; cv=none; b=iwx/Y4fsiB6sK9DlVb2DMSydLGjszDxM7f2DJu4KA2MJQO6rquXzwBmKY4spIVB0CiyGUpYmiKWw753Kz+5VR2Xv9/ODkkzWHn7NgfzkIm7XEjfX0g83mJBbT/0OXdWaDR4ZrDLcR6RgSfd3Z9hp1vXs+0+FaifvEDAKxPw4ldk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737653677; c=relaxed/simple;
	bh=Q6l+NBYTp6zJ75VFRnmoiRxGhf5iSth8xzw3xRCUxd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6mgzcb87vjsxJD67AW7kmRFZKIeh9TnHiFZ9hmrU+BtnVoi/qKzeOc6YQSCMorQkkDLgP7og8pAgrYvbg7gBlIiMGX1IvvwLt1TFZJ6IJ85aikQ4m7PaQ8BMyW28J6tMHv1m/wp8grsNxun1uE+5RmFYueGFB0IKGQEOmuUoyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=aiYx6m/y; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="aiYx6m/y"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e5447fae695so2150029276.2
        for <git@vger.kernel.org>; Thu, 23 Jan 2025 09:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1737653674; x=1738258474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gT7XGZHCsVln4HE+Q6fBXpLgxkC3FR/cb3zgeiUKGbA=;
        b=aiYx6m/yNaH7bOzzDKs+J8xL/CuHeKgumayPXNEb/73mwcWH/eWGMU0Wqw6IRmJF+M
         pgWLYru3UpE6dMPq2wjjBdbtos7qgMFd5zICFJsmYouUAkjCOms4RXQu1kUOFhG402FH
         GinUAGD/MFMmPriWO8aYCgN7abJ3LJtQL/MfokgQweSQVxKvWIs6fZExgOjemKoI5PLc
         cIJ/KwGRV2j6G2rVQ7FD7tuBa/4FJWCvddzIvbZaZJ7FvMMJzZvw58DkDIC5zcJGobg9
         4leV2uyq7rcGmG1CaJM3bE87exk4296Nh5qNQQY/6wOA09SOBBPFNLrk3cYePYwMh5V3
         +xFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737653674; x=1738258474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gT7XGZHCsVln4HE+Q6fBXpLgxkC3FR/cb3zgeiUKGbA=;
        b=Rcgj43BedjFJkSlJQuy8K0u2rTgC32zy38iCwIarhPk5Oj09/wFFcbWG95AlbiJMFO
         gWo5TNb2oYZ8022gIWtCl3sAEz/764rqyPrK7sUZrmbA5ktmZuoVkg2cdzG6CXrZLVVI
         21U7Rr/9toIfPaqPR71xeo7h1+/tvEKT+WgFv9AFUACrCS+G/mXHoFrc0LV2lZ9jlBO4
         4xbiDN+fovmOQ26OUIuEJH5hxajZAW4W/ilwbSb4qvq2ruffjTZuZUaG6Uq3fmxphsPx
         DAW1ncPWa8952t3RpEwwkn9c+W8wiZHT5R1Bmj9vSoRTHTCQbvVktti0yQck0iE34WUN
         L4RQ==
X-Gm-Message-State: AOJu0Yy4DiAbmMZR/8Et95IxyvRe69cEdTRPe6TrDSZw9jF4Vdt6aoEY
	u8lcOt4gdC6RbXQ4FhJM41FS6U4DjuiH84krUpv++4W2VQHy4d8bos9YZY/Z2m5FMTK7ZJnSsA9
	+8sQ=
X-Gm-Gg: ASbGncufBErt9JoOJM2pyYJPnpmfPZaFvh3KEnFha78m4h0SIY07mPeCokLMBhwtdnE
	oisnHFLuOsiqNPrKZBMRQFFd0z6eMSUxKrvkQL+Wap+ytIl7/392ZMpnFe+SdU8dO5qmkH1YrnU
	QlKUCv8O3Ch09TGVmcfxjpEpttJoW/eYU0fWqgEQVuCAeZnnBAgSL7lgdI+QzmwD1wj5nTcy4Gi
	PJK+W4zRSLWgFmR7OzLz9KNcClGy83QZcXOw1kRfz+5UNGbBslI8ngttnkoESlz2gT9jAk29mdF
	eBV3z3uRw12cZ7EMWabhnRQM6ypJ3hAnN/fcVQw6pYfJRZ9R8E46
X-Google-Smtp-Source: AGHT+IEDwQijrDq++X85oZP9e7uOLlMi/huBO7q1eq9Uqphj57NissZ/B/xCLZDfGBYtq84GeSEwaw==
X-Received: by 2002:a05:690c:9692:b0:6f2:8e62:d8b2 with SMTP id 00721157ae682-6f6eb922360mr201850107b3.29.1737653674669;
        Thu, 23 Jan 2025 09:34:34 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f757a33e41sm439397b3.115.2025.01.23.09.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 09:34:34 -0800 (PST)
Date: Thu, 23 Jan 2025 12:34:33 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 5/8] csum-file.c: use unsafe_hash_algo()
Message-ID: <64a850c77ae23b92698acf89761f0e7513b6d35e.1737653640.git.me@ttaylorr.com>
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

Instead of calling the unsafe_ hash function variants directly, make use
of the shared 'algop' pointer by initializing it to:

    f->algop = unsafe_hash_algo(the_hash_algo);

, thus making all calls use the unsafe variants directly.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 csum-file.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index 7a71121e340..ebffc80ef71 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -50,7 +50,7 @@ void hashflush(struct hashfile *f)
 
 	if (offset) {
 		if (!f->skip_hash)
-			f->algop->unsafe_update_fn(&f->ctx, f->buffer, offset);
+			f->algop->update_fn(&f->ctx, f->buffer, offset);
 		flush(f, f->buffer, offset);
 		f->offset = 0;
 	}
@@ -73,7 +73,7 @@ int finalize_hashfile(struct hashfile *f, unsigned char *result,
 	if (f->skip_hash)
 		hashclr(f->buffer, f->algop);
 	else
-		f->algop->unsafe_final_fn(f->buffer, &f->ctx);
+		f->algop->final_fn(f->buffer, &f->ctx);
 
 	if (result)
 		hashcpy(result, f->buffer, f->algop);
@@ -128,7 +128,7 @@ void hashwrite(struct hashfile *f, const void *buf, unsigned int count)
 			 * f->offset is necessarily zero.
 			 */
 			if (!f->skip_hash)
-				f->algop->unsafe_update_fn(&f->ctx, buf, nr);
+				f->algop->update_fn(&f->ctx, buf, nr);
 			flush(f, buf, nr);
 		} else {
 			/*
@@ -175,8 +175,8 @@ static struct hashfile *hashfd_internal(int fd, const char *name,
 	f->do_crc = 0;
 	f->skip_hash = 0;
 
-	f->algop = the_hash_algo;
-	f->algop->unsafe_init_fn(&f->ctx);
+	f->algop = unsafe_hash_algo(the_hash_algo);
+	f->algop->init_fn(&f->ctx);
 
 	f->buffer_len = buffer_len;
 	f->buffer = xmalloc(buffer_len);
@@ -210,7 +210,7 @@ void hashfile_checkpoint(struct hashfile *f, struct hashfile_checkpoint *checkpo
 {
 	hashflush(f);
 	checkpoint->offset = f->total;
-	f->algop->unsafe_clone_fn(&checkpoint->ctx, &f->ctx);
+	f->algop->clone_fn(&checkpoint->ctx, &f->ctx);
 }
 
 int hashfile_truncate(struct hashfile *f, struct hashfile_checkpoint *checkpoint)
@@ -221,7 +221,7 @@ int hashfile_truncate(struct hashfile *f, struct hashfile_checkpoint *checkpoint
 	    lseek(f->fd, offset, SEEK_SET) != offset)
 		return -1;
 	f->total = offset;
-	f->algop->unsafe_clone_fn(&f->ctx, &checkpoint->ctx);
+	f->algop->clone_fn(&f->ctx, &checkpoint->ctx);
 	f->offset = 0; /* hashflush() was called in checkpoint */
 	return 0;
 }
@@ -242,15 +242,15 @@ int hashfile_checksum_valid(const unsigned char *data, size_t total_len)
 {
 	unsigned char got[GIT_MAX_RAWSZ];
 	git_hash_ctx ctx;
-	const struct git_hash_algo *algop = the_hash_algo;
+	const struct git_hash_algo *algop = unsafe_hash_algo(the_hash_algo);
 	size_t data_len = total_len - algop->rawsz;
 
 	if (total_len < algop->rawsz)
 		return 0; /* say "too short"? */
 
-	algop->unsafe_init_fn(&ctx);
-	algop->unsafe_update_fn(&ctx, data, data_len);
-	algop->unsafe_final_fn(got, &ctx);
+	algop->init_fn(&ctx);
+	algop->update_fn(&ctx, data, data_len);
+	algop->final_fn(got, &ctx);
 
 	return hasheq(got, data + data_len, algop);
 }
-- 
2.48.0.rc2.35.gd215225db14


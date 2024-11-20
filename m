Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE421B3B2E
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 19:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732130029; cv=none; b=S971qnLBHRF3i/1tMZTVf7PXlk0/UAr/dOSqWNXazc8g+ma3EtrQWct9R98Sab7ipIIoyAu0f4XA7H0FfDh7DGtvjuhmjW6OPL5BPcL2b/PpvCamZBTw/KpSkCJsHGSBxpDTi015TNo4tsekpXI2ssZpSWf/0+CqcH8GvrUgGp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732130029; c=relaxed/simple;
	bh=RS2N+33KTVwCx14lPhrijwNT2iWbUnWrkZOr65gwj2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+N8DcNO7CLwXtmaDe6/zywN0kgrwvQ+GBzEdaxeYVb4ITuVGr0Hk5Oma7ip+rjw0WCHL9MnbrJ1M/teGfJLUDt9tC22v1j2XgjghgR58BB1tteVSfWQoYEbNJXY4a9AqKpm6edZbQ6rNIVK2eweioe+EYIkSBR3OU2KTbboTOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=d39fdaPJ; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="d39fdaPJ"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e387e50d98eso29736276.2
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 11:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732130026; x=1732734826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fzBOar12Datdh+HCps6EpyStY3L2HlOcSH7Kp+yoJ88=;
        b=d39fdaPJ4guYraGwY7F3b6/EddHRY3D/wDGzMDrvhC9sWGvmKSMzgotdh006aIpTeT
         UYgMr08qtfuq27wU0XdIURgSSDaFLr2uXOFFPs0XaSeBbCxA2LTLSv8zXfR986QdIxBW
         x4Op8Xg/KVIvlqNT1nXfTlS6M2UclyTE6dy7+KHuuv8MVOTjA2rONxLC/PaGOpUEQGI6
         E5SXJNLgkkLzufcp5EM1ykiDqrNH+DeiCaD/X9SYD+sWjXUTq27KNuHSPr5qcasOzHXY
         s6EJU2btR60OOMYtZU3CzHBi6rMsrunx5NxNnhqx6sEY5wlYL5GRZB9VKzb0fRGgJWM9
         C8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732130026; x=1732734826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzBOar12Datdh+HCps6EpyStY3L2HlOcSH7Kp+yoJ88=;
        b=wrjSLxEP8mxnkcMldenp0L/AtW7lPZG4IYrmg27RKwcBzmw/ySpPwkSJ57qkpTblI4
         VGexanDILmMsbx/Vjx+iYVEyd3jKJ7vkiLN9qbD5vcFSiIiIqIK7M9zGJlS/cT3i+uCK
         XIhHUaadr1s0rNFgtgkNHFddiY1Hy0NYYYFfBgC0ZvKUKnF0lFFGgtpn6kgpKRkuYvFa
         0nFHztZ5VB5NXIaHRFOCEOhXOK8MBNtJTEm5qsw5xc5yOvi94A2hyi8vsg4Svq/ysl8Y
         1GOQ9ilhj1gTaQW0/PXL/F8r60hTydyHsGBg7hSSQuGbx+76xnE3rH8b/MdtkTsHajKV
         vorQ==
X-Gm-Message-State: AOJu0YwlkH9XND74xy3DNsyT3ziMaA4NnsaohTZWTFJd1kSXIgm0Px6k
	iNSmF0i/h78zgO/nCUTaBKe5TmTDiACUBiYiqMM5pzYszJHYOhTIO8EVG2Wt/SLMeqMUxboAqYo
	h
X-Gm-Gg: ASbGncuLZOZPMXR9k3czwoyQIuRzhpmszdk9YdedhGKMsofLPW/gGKPvus3yW7KxRmH
	EYojr7jgeXXqaFEGXQwcKT3Dg8xZO17+aiiMCFcFsnzkN7LQMmRU46BIszR01qBKBIsDC42Gtkn
	g/GH9cnfueCz55aFEHhOvVcxArooq1A7HAULmKy21hVfRjLvy2kyZei1hPVw1cbd/1SIr99g1ll
	+gIu9H1fKBJlPyqE0UlEi/VzBWNMBv00WSHKv3/wQtJTS4P7bRl1/NEMpof175qtQB8v6ZMt4ud
	mD+G8jR/jddWJvMvHp/2Tg==
X-Google-Smtp-Source: AGHT+IGdfslpspmdKBIdqWKlh2nluPweVJBhojXjRIP3WDLYRDjB33TVWYgbDo7e8gum6Cje7w2Gzg==
X-Received: by 2002:a05:6902:1b82:b0:e38:a15d:409d with SMTP id 3f1490d57ef6-e38cb56c5f6mr4304843276.13.1732130026202;
        Wed, 20 Nov 2024 11:13:46 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e387e827436sm3343773276.60.2024.11.20.11.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 11:13:45 -0800 (PST)
Date: Wed, 20 Nov 2024 14:13:44 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 1/6] csum-file: store the hash algorithm as a struct field
Message-ID: <380133a11421fe4ce8428d11be479d78923bc5cc.1732130001.git.me@ttaylorr.com>
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

Throughout the hashfile API, we rely on a reference to 'the_hash_algo',
and call its _usnafe function variants directly.

Prepare for a future change where we may use a different 'git_hash_algo'
pointer (instead of just relying on 'the_hash_algo' throughout) by
making the 'git_hash_algo' pointer a member of the 'hashfile' structure
itself.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 csum-file.c | 20 +++++++++++---------
 csum-file.h |  1 +
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index c203ebf11b3..62f4965f094 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -50,7 +50,7 @@ void hashflush(struct hashfile *f)
 
 	if (offset) {
 		if (!f->skip_hash)
-			the_hash_algo->unsafe_update_fn(&f->ctx, f->buffer, offset);
+			f->algop->unsafe_update_fn(&f->ctx, f->buffer, offset);
 		flush(f, f->buffer, offset);
 		f->offset = 0;
 	}
@@ -71,14 +71,14 @@ int finalize_hashfile(struct hashfile *f, unsigned char *result,
 	hashflush(f);
 
 	if (f->skip_hash)
-		hashclr(f->buffer, the_repository->hash_algo);
+		hashclr(f->buffer, f->algop);
 	else
-		the_hash_algo->unsafe_final_fn(f->buffer, &f->ctx);
+		f->algop->unsafe_final_fn(f->buffer, &f->ctx);
 
 	if (result)
-		hashcpy(result, f->buffer, the_repository->hash_algo);
+		hashcpy(result, f->buffer, f->algop);
 	if (flags & CSUM_HASH_IN_STREAM)
-		flush(f, f->buffer, the_hash_algo->rawsz);
+		flush(f, f->buffer, f->algop->rawsz);
 	if (flags & CSUM_FSYNC)
 		fsync_component_or_die(component, f->fd, f->name);
 	if (flags & CSUM_CLOSE) {
@@ -128,7 +128,7 @@ void hashwrite(struct hashfile *f, const void *buf, unsigned int count)
 			 * f->offset is necessarily zero.
 			 */
 			if (!f->skip_hash)
-				the_hash_algo->unsafe_update_fn(&f->ctx, buf, nr);
+				f->algop->unsafe_update_fn(&f->ctx, buf, nr);
 			flush(f, buf, nr);
 		} else {
 			/*
@@ -174,7 +174,9 @@ static struct hashfile *hashfd_internal(int fd, const char *name,
 	f->name = name;
 	f->do_crc = 0;
 	f->skip_hash = 0;
-	the_hash_algo->unsafe_init_fn(&f->ctx);
+
+	f->algop = the_hash_algo;
+	f->algop->unsafe_init_fn(&f->ctx);
 
 	f->buffer_len = buffer_len;
 	f->buffer = xmalloc(buffer_len);
@@ -208,7 +210,7 @@ void hashfile_checkpoint(struct hashfile *f, struct hashfile_checkpoint *checkpo
 {
 	hashflush(f);
 	checkpoint->offset = f->total;
-	the_hash_algo->unsafe_clone_fn(&checkpoint->ctx, &f->ctx);
+	f->algop->unsafe_clone_fn(&checkpoint->ctx, &f->ctx);
 }
 
 int hashfile_truncate(struct hashfile *f, struct hashfile_checkpoint *checkpoint)
@@ -219,7 +221,7 @@ int hashfile_truncate(struct hashfile *f, struct hashfile_checkpoint *checkpoint
 	    lseek(f->fd, offset, SEEK_SET) != offset)
 		return -1;
 	f->total = offset;
-	the_hash_algo->unsafe_clone_fn(&f->ctx, &checkpoint->ctx);
+	f->algop->unsafe_clone_fn(&f->ctx, &checkpoint->ctx);
 	f->offset = 0; /* hashflush() was called in checkpoint */
 	return 0;
 }
diff --git a/csum-file.h b/csum-file.h
index 7c73da0a40a..2b45f4673a2 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -20,6 +20,7 @@ struct hashfile {
 	size_t buffer_len;
 	unsigned char *buffer;
 	unsigned char *check_buffer;
+	const struct git_hash_algo *algop;
 
 	/**
 	 * If non-zero, skip_hash indicates that we should
-- 
2.47.0.237.gc601277f4c4


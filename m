Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9851ACED2
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 22:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737151398; cv=none; b=FXRKAOUMNBZu2L/cuOhM4kcr6OHIoYy8kAcZNwK1TG6Pvdxb7uMy6ShQoNAbvdhoitfAp0Dus2qsc0XGpvbXDww6tl6QWwfehb0mOkptEXPU13K4fy2FOctA7QsQH2MagPvqbqWlL9kN+fIL5cc+3N13PYA5yXTEYg6nvFjpuoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737151398; c=relaxed/simple;
	bh=6c2efNIDHQ/emvsO1GdUvmmphqDHzyBDErb84N+2EUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rl9VpJbFC0AplOd/Mv0UH25EIXjHa9htqeoM1/czACJtg+UdY6cLM1YYSrAS5HbesnJfW9N2UTxnm+NP2dvHiDxc7Jdwa+jozC9J54vSImhhXrBAfaoS9/WJbB+ebpNkV2ofwsLeVsSwiXUxxTo5Qz3MDvwA1jURsIslqeKCzEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=pYmFnGYH; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="pYmFnGYH"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e399e904940so4102579276.2
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 14:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1737151395; x=1737756195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o3I104F98Ae3K86wspkO/urGXHLPbOx0f488xCA5RkY=;
        b=pYmFnGYHfeQ6/9mjO3jvQDyVo0M49YVKm4Aa1/bTTO9FCPeV9V4Sg1z/Fm/naQFQOz
         8/mm2kHckekYbVcPCc+l9J8nEFnGoUXklgJkF6oYZp2kd7jWeLilXL0QP4Ly4ZhKtmYo
         h7NIfbRzymxnr5cRswkgNFXNrqlNQ0q3Qe1gaDwJekYUedhawfY1de0nk4Ki95ZZJyCZ
         WKwN1mFdzRanHtTEVx/iwYKJugewccwAVGDMIsFU/H8IApy+F5v1vY8Ru3EaOTjEhN23
         ocVA8w1RuZlcyF6VtdQYXgkDB0OCgufuOhq2i2yIzBSboEceVgVjXqgh1nlv7VNYLis8
         DGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737151395; x=1737756195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3I104F98Ae3K86wspkO/urGXHLPbOx0f488xCA5RkY=;
        b=TbKGkUYY5jKChC1LMH6SkbWju0CEAonJaMFMTw62YP2/1o0BGPQ9B+IMnyTfz0Dznf
         74HXIjBresHhVpo9D1pQgZK8seiZ0ZFesCnDewL1pN8nqCgjv1hZ6aCJKTKYSyOHjuc5
         hQcAWlW9T9+Vel0gzl5J35I3R3DIgki/hYdrgEFX5t0KgWhJxCwmkjVn+YBi/A84yjtl
         Egyn5zQcUOJWYLE2AnF+KSXeAtmTweyUr4vmYWEXp7vN9UamJclLQdC/Vhcx8yFNt55a
         uN/GJfWtEs3SLd7r/fdqcpE20JYahQgcTALfIMtt3DiLWFo48E3AL8rtEayXjBKF2Sh7
         KOnA==
X-Gm-Message-State: AOJu0YzQZu2fzhU6VXHFtQGAHVicComcquzAB1f1/cjF+7mU9oIV+ntu
	VM5cPMW+3k9atPYQg2Toq6byiB9XguHsgwrO1kd9lxvNkADFu17AzN3e0cIgIlVGAExQn0idRL0
	9qlA=
X-Gm-Gg: ASbGncsYbdn9hmf5pXNbKZL7giYaC8Jvbb/MulpTdZJDk/iMvb8z3xrfGZc9ze+w/eP
	Ee0tC7s0t1BbBAcuQLqqB2KjIAyj5Cs1IXpQytmrgcQIx/u1aYJar0yOmLBaX33vO6e5Clu0N0E
	/gHggxXXOVOoX9h24xeD4VLN91Qt1imETiD9DAR+6OXB3+kYfnQNwO4dq7sz9C3Zdn8QZbvrlQx
	tLEiRDtPq3O5KtanwPlrOPFLPZ0XB93kE14kogi6mwD5JfiKklTr+UAUy2qBsLZFYf/6sS7+EFi
	K7ckL7vnqEqvhwOzUtJWi3MEcKIY
X-Google-Smtp-Source: AGHT+IFbe+u2VKhSfPGWsQfKkdC+DZjYm8uo76kFswP6+w8n8pTf4LWVUDvA9RpHQsnwPYQtb3T2mg==
X-Received: by 2002:a05:690c:4d87:b0:6ef:6c57:ddb6 with SMTP id 00721157ae682-6f6eb90d7aemr40967777b3.29.1737151395066;
        Fri, 17 Jan 2025 14:03:15 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f6e63ab380sm5924797b3.7.2025.01.17.14.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 14:03:14 -0800 (PST)
Date: Fri, 17 Jan 2025 17:03:13 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 2/8] csum-file: store the hash algorithm as a struct field
Message-ID: <2b79c76e4714145057a526876b9ad581c497af0f.1737151386.git.me@ttaylorr.com>
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

Throughout the hashfile API, we rely on a reference to 'the_hash_algo',
and call its _unsafe function variants directly.

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
index 5716016e12e..b28cd047e3f 100644
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
2.48.0.rc2.35.g0c4d006e6e8


Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B183B202F61
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 19:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736363680; cv=none; b=cOw8ksaendubvkRVGbb921NWexNG3aJwHQGSAa9SrKv0xRwRahW5mJhfuJO3e/kJtd/FHBdUZ6kIQnA5RnkVGPObqI+PxT7lKvsHu9xeSWxNAohKbtdoAuKpbxFlkLYoZ2JqQqU46u91il4USYC/tf1raprh4axkaUxYOzdRQXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736363680; c=relaxed/simple;
	bh=UK7RePgewRyvzvEnssRzE9utl09yZotL7Ouu9D4hgZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9QiPGrlVPPva3qFo6Ep9EhVrajhd1TTvTVC+QD2UaBulZv/ssFsqhOTe1MiXq3GQ72Vo4tT58tbBrv4lEQlu3saI6ZDGN5erh/tpgykha+/SaT6VTkoTYacT2gAeF5DxbDWFPg4KjXPfgpCg/2OODCTaOZdamBdQW2WvuWW6hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=IMnaievt; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="IMnaievt"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e39f43344c5so96558276.1
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 11:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1736363677; x=1736968477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tgwDwIjUXMZMpDhITbnkdObRyaeVei/v3zDkEhXmicI=;
        b=IMnaievtYaX/00vmaSbPsl/fNJElb7uR+WF8ZqN8O5cmk4YvwqZ9hMNSnhJWDF3UAm
         59klhpa0Q7z/ABK4UzTt8imbbALk14rGnYrQ1f2EyetqgctQyxbsgz+1FEWFeYCu/fkj
         F5lKjKvBwTKqjLyTtvuB1r49JqnXl1aGxWjhiUMriMqWcIeAS6ZWK5TUdkUHE7prDPZo
         7HsB18YycrnuJNK64InDX5+U8YzxLZeOPyKxoYR3qJRbff0gPZwXwu1PzmhVwby82r4a
         iOiMmC+GkILv24GFX6qgcJ6qh83GXNFFAV3p2N48/InZ81R4f6BuIFEMbvSmJl7uZ0xU
         XfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736363677; x=1736968477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgwDwIjUXMZMpDhITbnkdObRyaeVei/v3zDkEhXmicI=;
        b=CdX4xCOMVykY3knpkGdOiKUWMPqSof8t8i75d6IfZ8irG6CABvCWYkSQAFw5/D5k9i
         wvWKK8z++An4z2K2HuzRQbP2szIFHshYnlV8bEsKYP8huj9gntl/7Ur7GhPMdsVs/rPH
         uWHW8/u1Eyk0dro/1CL4ztYzqWhhzRzh6cPSxKw4f6WX7hGb4zUorMaScPxwOWbJL62G
         yLnAsfpq+YyDaGv067dxGl5PTHiQ7Mo22ONN3jDUkf1GDGmBt2a5a8mtJONUAxoZTpFo
         GpZrz1dMOKkf7XLWwMCskzre2/v8zC6v6j4W6XHjtSD8DF4bpw0Qx/nsuOn/+AWiLB8B
         WcPw==
X-Gm-Message-State: AOJu0YwSgzUOj6LPcB64F1DBUM7vVnNmrffDpJjgHkb4OZC7Cv0MAQ4d
	8SJFW5UwKfsvI+rso0VjoQ89FH3+yGc/Lu1GYn8XE8LFrssuV6n6RnLiHtJ5FewFxRmFy72ZwGR
	X0uA=
X-Gm-Gg: ASbGncu4pCnS22qZJX4hlG6zZLvzD0mik0YRTrT4xBFb0uWgrzNWbZxXyqo+82oxqWM
	1CE3AwP0ArbCon3Y908sqRYu0E2BrUU0nBr64xf6g62k8dOs2u5n+ETHX+GafM8aZJCL4yZJ6S5
	D3cxtFbRe9iXBOydafbJw1cY24LHdqbA3x9XgLrbjk8Mh55Kgno9lW/HpGbB3zNzGD/+otKBKMy
	D+kHUKpOf8a3QsIBN58/d7HYfjxfm/5lZ6tTdMTdlfWMCMkgfCLSEwpudExty+uQbpWIca+uQmN
	MNVnJTyIt2KLpZzfows6QChaSd86
X-Google-Smtp-Source: AGHT+IHANNEspklJhCEQNb+yH/4vkYa23djjx6/kO42M6s+y5oR9x7dDYY5dqtOa1KAgJRXvwbaQAA==
X-Received: by 2002:a05:690c:740a:b0:6ef:90a7:16ec with SMTP id 00721157ae682-6f5312d3be8mr36944667b3.28.1736363677479;
        Wed, 08 Jan 2025 11:14:37 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f3e77f10dasm92788737b3.89.2025.01.08.11.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 11:14:36 -0800 (PST)
Date: Wed, 8 Jan 2025 14:14:35 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 2/8] csum-file: store the hash algorithm as a struct field
Message-ID: <99cc44895b57cc75fc8f447000817b3595368e4c.1736363652.git.me@ttaylorr.com>
References: <cover.1732130001.git.me@ttaylorr.com>
 <cover.1736363652.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1736363652.git.me@ttaylorr.com>

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
2.48.0.rc2.33.gaab3d23ed4c


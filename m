Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A021DE8A2
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 22:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737151407; cv=none; b=d4Nha/dX5IP9To8ser4ko4qY5GjfeGNbrkatmPoeGg5H03yMzLoxdNdBAqeJuplX2e4RWX5oeNWP8x9eDHvnVSJ4XlWnNdX0f00OgsT8yPN0gezBYpEVw8FwwnAkWou3ewcbN83SwmosjIhvzUXi0GKgJoJAd6QowsAD3xTBEi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737151407; c=relaxed/simple;
	bh=1c8UGk8NIpUPvvZEDL/j+/Tl0Vnvf+F9EzYy5gaDyLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWf17AEL7KzZk9+VWBupgmMj9DpanHL4EU3jObEMI+yiScKT4Jpkqn9/eqH3WYANx0LkXKAkg528eQ75XMOb1QXDG/DRWsBEbvbciosELif5NvwO4AkQJJDfTqyGW+qUp9snHvXMf/8sktZ1Ap9RHl9jwhEzq6EoRctaB+XHl4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=1IowE5th; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="1IowE5th"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e3c9ec344efso4000227276.2
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 14:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1737151404; x=1737756204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T5RdfVzpkWSjVoMBALnctho7ROnLcrWsck32SjVs6L4=;
        b=1IowE5thtsSd/Myd+VqcTG+Wi1Oyo2yYL6ZomMyDe7jh3PDx5Evk0K2lUhbYPr8a1S
         2L9KjFyKigkA3MpsMAJ97ie61HKSX2v5iuYrDcR2LJ1mIYKTfJ6A+enY6IxaWHCVbr1c
         Z9nyQeJC/MAbeoPvR4Vp3q95BYqDW2yw5Viyln4qGyP/U/RIWLauj/b29QE0nnNUISZR
         JS+lalwwFtbe4CiTdFE+AyaOE6snnnamX+GWEOgfHQjRgrMpaAGiQAy83DhAB/JoRvTW
         ApZuGXrCbI7ipQtL4hDvIhm40kbl9A2tXtoDE0oyA+CwE4j2uJhLUmzQZPWnX7rwQAb9
         4YhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737151404; x=1737756204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5RdfVzpkWSjVoMBALnctho7ROnLcrWsck32SjVs6L4=;
        b=QH2QyLhDHjUgxUGOOFi8ODd/bO1oc5HkTM2uh2F6RnNUl+zVXRt4BpS97ONzL08S6/
         eTMAN6q4G47/uIidK2MAUDKwpI4Bt4eDj3yYcXALKK/NnE1hsMwimS1hzYXlOQSEYMAN
         MVQwhgZlICgmmkjSdzJQ5XUF9cxRJJFftW5Uq8kqlhTHN0R0Kb9Tsohbbaz6VSqHK3+l
         VA00j24Ws4zJK9N/Y1fV6S8poEA/HoangvFZVzf+xxq3RUWFeqlLoPbkXYrMLV/1WKtH
         PdeO2wZLbEm+eEnXy7hAM3BEaybyeo75K15o8Hn4vpKLjosfZV23m/3X7UuN7IiaH/v0
         hTBw==
X-Gm-Message-State: AOJu0YxFQ+pWZJTsiJu2pNN4gRrErjlcIM1gEp3GynZYrxxaiXQQlkfY
	jCnwO79LUAEZIS+pS/TYD+NdknHh71dDo0jW7ISq+it83Iqm22G2J1hBP3cwwKnVmmfPXv2CTZz
	TR/Q=
X-Gm-Gg: ASbGnctjilHsHxE40/1rg71OMV+oPYnpoWLeM+PXo0q+nq9uKzxpJo0n5ZKcctvcFmj
	RtUHpmT9qWNHr8Fumw0eBpk/D2JgtHRK5mXKZgu7ZBGEjFoQDGLvgGj4InjSWgO6+6WUWtb6nUJ
	Gew19IvPDIHtj0hHoKoJoC33Bxkxn7nsr8pwKeDIEtKb8eavG7iH4sQ7ZLmVPaEygU2v1x4zpi2
	oagyp6LHrt16whSCQnf5TpHNmUy4ef0ND9Vfw31U0nVTRftXOzrzS+AgTuuoonh6S/dvtKre0+E
	P1RZzddSZyQVWCewLgIBMxtajF77
X-Google-Smtp-Source: AGHT+IGCVnfMDQ9QrrfMwj9ZDO21QRAJuYXyqz20Oe+7BWs4/4Cwze0wqfVSxN6nymX0fFHVO2j3Kg==
X-Received: by 2002:a05:6902:2749:b0:e55:12e2:62c4 with SMTP id 3f1490d57ef6-e57b132efd2mr3453600276.35.1737151404638;
        Fri, 17 Jan 2025 14:03:24 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e57ab43aa46sm579916276.45.2025.01.17.14.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 14:03:24 -0800 (PST)
Date: Fri, 17 Jan 2025 17:03:23 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 5/8] csum-file.c: use unsafe_hash_algo()
Message-ID: <ca67de80971fc1b8b77241a647e246e1cd4e58cf.1737151386.git.me@ttaylorr.com>
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
2.48.0.rc2.35.g0c4d006e6e8


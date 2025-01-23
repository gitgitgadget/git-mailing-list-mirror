Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070F4166F32
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 17:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737653683; cv=none; b=S+iza9WTOvDGEWM1qW3UEpOvz1bnvKqeyNZsyy8/Jy9faltch+J5raXl4+nbs56d46ZIfeSBcyligNt2DrypZPUXSrfpirrYoeJBw4Wxu6k0mdGu/tkxnMmNpuLjuzkH8ivA87Cmv7c507Wdni2ZqepY7qPCwnkTMjUtMZWpqQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737653683; c=relaxed/simple;
	bh=XX9CayRwodWzzPoMzTsJqWyYVvYPKGyCntRvQaeBaJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfC0bkZU6y++55GAcAKOrNpWIshTHeBj/T8lCK8hy67h2Y8GamjBx9+l5P5nm3ZU1WShKecnlWjZxI0ydy2LaX7h0Xtbl/Ujwdsdcp38vQjTsJZomUiVT1CK7A62w7W/51pbCHnNJx/hWdA2JK/qH94eBCiEr60D+MYocOFPvPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=eOshSluP; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="eOshSluP"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e53a91756e5so2153906276.1
        for <git@vger.kernel.org>; Thu, 23 Jan 2025 09:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1737653681; x=1738258481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3XfbhZ4NJq/su2IZlAhXveMpldbkSQsCFX7OvTBk/uk=;
        b=eOshSluP5GfYViMr6FonUOV7Rym5o1oz4qsStt52C4PQg7h8TtjRf4fboXbkQF0iW+
         BNgCucYlWzA1kU8PIt41acl5Y+orGDFVlubefwD8ROBRs3atKHe+wQpnNXeNu0aBEvXG
         n5Jd1mP/SZmM9nK6PJ3RYPWRWmLjBJEkrXRVMy3YelKdzIM7pK2ZFzopi02tr1u12yBk
         NaYhA/fol5/TvnGS+zWECeF+gO4iryP+9XWDXRqo4Z1FgiOJYyOhxhfdh54R2eSC4LOt
         FgGvENtKcY5xIyF9n90EIL+svtihCr3xyoxQRiVsRL5naRnFSjlyFnalqOrQXMUbN46T
         9sww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737653681; x=1738258481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XfbhZ4NJq/su2IZlAhXveMpldbkSQsCFX7OvTBk/uk=;
        b=ZvX3ZcuhxaUvPYqhLxRZr53nGIECibA/nA/GpPAGVY+AXRNFfXtzDv1TdayA54xyfY
         RllWXKPsOkkXPp2Lf2Ii8vFTy3OHYVHmHtgmGpLZnDLONR5rey/w81OJy1pQuQuS3fPK
         HFC4MUqg00Uj2Kyu1SRwqGRCT/yuRI6XulJjocsSd89cQiT7rB/wY+dxN7GKurOtJSQF
         rw8NV0m982qjtjtoSgQD/st4J5WMf+88P/6mTc+67LCRlLiML9/ZS3w5eab7H8WaYrh0
         GqtN6hf+78TouXPCEqcPS6lnhL1smzM/5QVWu/kc3+ZBx8qIxPbCqq1jkZviSd3IQeSC
         Zw1w==
X-Gm-Message-State: AOJu0YzQenBGxJB2e396TWY8mh9wA8y3bc81qlSFNk+y3kMZafUB29CN
	aIB6NzhVCg6tzw+aWD9I9pyT1G29nKHSsxOdwtsC+ObefrBdVH1LgTJv0Apk55CaGgwUVFkDK1D
	hSQk=
X-Gm-Gg: ASbGncuWNpEItk7Rgkfrkvpzbj707bqyel0JZLqfJ4MuB+2MqLsnvFMclOyfdgv+UT/
	xlZTvyJhQoyD4GAfJp2LKd+rKCLHLXGMPNY5d4X0FoVzgK7kDjeiBKSrSuR5RXnyAneawxiF7PL
	4OUqG70gzg1yxh0FE4K0H1KZZa7TxpFk2VnRIhTxYLElebU6LFBwKXiWxw5TDzaL+P1/fb8DyEz
	FSCH5ONBJXIvbr8d6TYPzr+sYO7q98qhb04DUvC2GnMMlmmkLCh/Kayf5p2mQ+kTwFcFweQ3qTe
	+e0QJSh2IpwJ0j/N/agtTNIF15dwnOOkX3vh2vjDYFXwnm9CUQsa
X-Google-Smtp-Source: AGHT+IEZPzO8cQYdu3ZrqizZz1Xa8Bq5Woa735CCoG7j1vzFjtK07oLZgBdT4JoF9gMh4GBucjQuzg==
X-Received: by 2002:a05:690c:6812:b0:6f6:cba2:a881 with SMTP id 00721157ae682-6f6eb93f1e7mr215946327b3.33.1737653680867;
        Thu, 23 Jan 2025 09:34:40 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f757a0554csm455377b3.93.2025.01.23.09.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 09:34:40 -0800 (PST)
Date: Thu, 23 Jan 2025 12:34:39 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 7/8] csum-file: introduce hashfile_checkpoint_init()
Message-ID: <da97157c4a1fde62a62dbb258d54a91320712fd7.1737653640.git.me@ttaylorr.com>
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

In 106140a99f (builtin/fast-import: fix segfault with unsafe SHA1
backend, 2024-12-30) and 9218c0bfe1 (bulk-checkin: fix segfault with
unsafe SHA1 backend, 2024-12-30), we observed the effects of failing to
initialize a hashfile_checkpoint with the same hash function
implementation as is used by the hashfile it is used to checkpoint.

While both 106140a99f and 9218c0bfe1 work around the immediate crash,
changing the hash function implementation within the hashfile API to,
for example, the non-unsafe variant would re-introduce the crash. This
is a result of the tight coupling between initializing hashfiles and
hashfile_checkpoints.

Introduce and use a new function which ensures that both parts of a
hashfile and hashfile_checkpoint pair use the same hash function
implementation to avoid such crashes.

A few things worth noting:

  - In the change to builtin/fast-import.c::stream_blob(), we can see
    that by removing the explicit reference to
    'the_hash_algo->unsafe_init_fn()', we are hardened against the
    hashfile API changing away from the_hash_algo (or its unsafe
    variant) in the future.

  - The bulk-checkin code no longer needs to explicitly zero-initialize
    the hashfile_checkpoint, since it is now done as a result of calling
    'hashfile_checkpoint_init()'.

  - Also in the bulk-checkin code, we add an additional call to
    prepare_to_stream() outside of the main loop in order to initialize
    'state->f' so we know which hash function implementation to use when
    calling 'hashfile_checkpoint_init()'.

    This is OK, since subsequent 'prepare_to_stream()' calls are noops.
    However, we only need to call 'prepare_to_stream()' when we have the
    HASH_WRITE_OBJECT bit set in our flags. Without that bit, calling
    'prepare_to_stream()' does not assign 'state->f', so we have nothing
    to initialize.

  - Other uses of the 'checkpoint' in 'deflate_blob_to_pack()' are
    appropriately guarded.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/fast-import.c | 2 +-
 bulk-checkin.c        | 9 ++++++---
 csum-file.c           | 7 +++++++
 csum-file.h           | 1 +
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 0f86392761a..4a6c7ab52ac 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1106,7 +1106,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 		|| (pack_size + PACK_SIZE_THRESHOLD + len) < pack_size)
 		cycle_packfile();
 
-	the_hash_algo->unsafe_init_fn(&checkpoint.ctx);
+	hashfile_checkpoint_init(pack_file, &checkpoint);
 	hashfile_checkpoint(pack_file, &checkpoint);
 	offset = checkpoint.offset;
 
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 433070a3bda..892176d23d2 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -261,7 +261,7 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 	git_hash_ctx ctx;
 	unsigned char obuf[16384];
 	unsigned header_len;
-	struct hashfile_checkpoint checkpoint = {0};
+	struct hashfile_checkpoint checkpoint;
 	struct pack_idx_entry *idx = NULL;
 
 	seekback = lseek(fd, 0, SEEK_CUR);
@@ -272,12 +272,15 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 					  OBJ_BLOB, size);
 	the_hash_algo->init_fn(&ctx);
 	the_hash_algo->update_fn(&ctx, obuf, header_len);
-	the_hash_algo->unsafe_init_fn(&checkpoint.ctx);
 
 	/* Note: idx is non-NULL when we are writing */
-	if ((flags & HASH_WRITE_OBJECT) != 0)
+	if ((flags & HASH_WRITE_OBJECT) != 0) {
 		CALLOC_ARRAY(idx, 1);
 
+		prepare_to_stream(state, flags);
+		hashfile_checkpoint_init(state->f, &checkpoint);
+	}
+
 	already_hashed_to = 0;
 
 	while (1) {
diff --git a/csum-file.c b/csum-file.c
index ebffc80ef71..232121f415f 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -206,6 +206,13 @@ struct hashfile *hashfd_throughput(int fd, const char *name, struct progress *tp
 	return hashfd_internal(fd, name, tp, 8 * 1024);
 }
 
+void hashfile_checkpoint_init(struct hashfile *f,
+			      struct hashfile_checkpoint *checkpoint)
+{
+	memset(checkpoint, 0, sizeof(*checkpoint));
+	f->algop->init_fn(&checkpoint->ctx);
+}
+
 void hashfile_checkpoint(struct hashfile *f, struct hashfile_checkpoint *checkpoint)
 {
 	hashflush(f);
diff --git a/csum-file.h b/csum-file.h
index 2b45f4673a2..b7475f16c20 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -36,6 +36,7 @@ struct hashfile_checkpoint {
 	git_hash_ctx ctx;
 };
 
+void hashfile_checkpoint_init(struct hashfile *, struct hashfile_checkpoint *);
 void hashfile_checkpoint(struct hashfile *, struct hashfile_checkpoint *);
 int hashfile_truncate(struct hashfile *, struct hashfile_checkpoint *);
 
-- 
2.48.0.rc2.35.gd215225db14


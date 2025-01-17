Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5111AB537
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 21:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737149410; cv=none; b=KVWDi0E6ulzV1K8naVW7PvAaTM2RLaj8FQ4S9CsT+MlEOPQBrVgNNgAR5mSILGGu1r/xjAz/XoBkvpTHW68eJFkZnfu/vOp2VBYEAPdMT8J/WYng4O8cQTaOdAAxzcHEhQdCfS3m4eDIGqRt3s+L4hpeGxx1E2z6qpH12x9Meys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737149410; c=relaxed/simple;
	bh=29qN39SGZWKn8AmDrtGkPpj4U6ecSGcLzbbIoig0yzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmx8LeucMGe5nI/gaR/Y7l4xsFG4gwQNJm5gMNnszzvld4OXvM0FgTmSlTHAK3SzcIcrkkf+j3jvHZFhvHeJ8fKbPIjHuWE/nRkCe830V5Gc5yaowpM4YakTq7fZJvkW9Z5kJDf0liub9QfO1zlA1yeCF/jznYTzPCEX/S97Ry0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=KXJtUMWa; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="KXJtUMWa"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e53ef7462b6so4289060276.3
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 13:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1737149407; x=1737754207; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CHd78CCV9mg2Ut4GRohADaViqPB2zzcLKGUevnI87d8=;
        b=KXJtUMWaEtL4mGd7UdGHe07PCpd1C8zAhnVVdKXRw3QDayuEpKaxJmo3ON1uHFXLA8
         ikf7qCozaQ/U+AP3bc5PILn22DQacNq3QR/7l/VTGViD96mpIA9WxNRF3HIwMHplJr3W
         yGeCteZHtDhZBZys2AE95J6T0MybslKAqL9tpRJT5NzPggpfxQ00wAH+QlMDUmnofefA
         thAntisSA8VakRlEcWwIfgL9HBlcasR4gGD3ag19IMJS4FDn5EMErluL9IMP+VrOZxWK
         IlsWd8bAeX5bzwf0KfI2juhGHqVCG88T46eHr8JXqhi9H+P9Rri3r0B4+VYg9X2f5jRg
         EnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737149407; x=1737754207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHd78CCV9mg2Ut4GRohADaViqPB2zzcLKGUevnI87d8=;
        b=aIW9c9yVE0nLR3tmv+PqGXsyxlHI88EAPV2F/OpUGoS5NRzwIfKeL94zus8SaFhYH9
         fSnzsqQlwy8NzqivseqUfvy/6E+xSYKsk/I2yCBGnOAuzYCCWeArqO3z4ETgScTBhhng
         5k4pkOS6wz31PR2uYLIDRkpRAS9OYunEKV8Xgq9dD+fxYRGOu9h4JN4E76kQvyV2GY/2
         GcToWu1yTT0K6n3y9bDuKMhw0ME495n6ZnIAVBya+gfdWW47w9R2vhV7RPrdmOwv5rL9
         xiN03R/b4LLaVIqnBr7FBBaoXLqgXTqAYbTMnukOjBiP+nzGsc5woqHUqgtEaEDGmPck
         yj+Q==
X-Gm-Message-State: AOJu0Yz2k7zNgGGqXdE+ZO3Tyc9v8rJy70MuLwgFRgGhhqHUzUuT7WFv
	Czvp7PhUNZ7zzDvuHsaF+YuLiG9nA9PswrGtHKo5RzgPb5GjibVQ5Gm3ViyPpug=
X-Gm-Gg: ASbGncvtK/sbeLxzli4O7cY+WBxm1H0kDGjufrT2F3dfLdlSbSel/hBEGG0lC8TWvgT
	X9sPGKopijCTeQbI9Xaezq3FnkiDaAGGKNlNNBf/U0cJLQArWtqElameacvXUz19/v2fvPlbFyL
	33YnuRrPBTAi+VcvBjfQvjNZlgy8FozDPiphAyVL0CnvFXcIiVRazP99yuKoDsiVZ5fAnhO9eDI
	rE/pKPE9lltxAhA6XFBTvHl6QCUIpFVXm8uNvIymTTOkPy+79IZZFIM+84Woa0KEVaj8MEe00pq
	BvpnlK+iQqgzU1Ydzc6sxiN7OsJE
X-Google-Smtp-Source: AGHT+IETc5cUU1IXidVlACkOxLdF/f1mACBCB0rvD4T/YRU6zf3ExJLaDqK7+dPQFz9r+aV4XQkONA==
X-Received: by 2002:a05:690c:6711:b0:6ef:6bdf:36d8 with SMTP id 00721157ae682-6f6eb9327b0mr40582467b3.36.1737149407220;
        Fri, 17 Jan 2025 13:30:07 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f6f7a8f24esm635957b3.22.2025.01.17.13.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 13:30:06 -0800 (PST)
Date: Fri, 17 Jan 2025 16:30:05 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 7/8] csum-file: introduce hashfile_checkpoint_init()
Message-ID: <Z4rL3TbEeR8EiUOi@nand.local>
References: <cover.1732130001.git.me@ttaylorr.com>
 <cover.1736363652.git.me@ttaylorr.com>
 <94c07fd8a557c569fdc83015d5f3902094f21994.1736363652.git.me@ttaylorr.com>
 <20250110103756.GA1014709@coredump.intra.peff.net>
 <Z4GWIZkJOUa278VA@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z4GWIZkJOUa278VA@nand.local>

On Fri, Jan 10, 2025 at 04:50:25PM -0500, Taylor Blau wrote:
> On Fri, Jan 10, 2025 at 05:37:56AM -0500, Jeff King wrote:
> > So in the new constructor:
> >
> > > +void hashfile_checkpoint_init(struct hashfile *f,
> > > +			      struct hashfile_checkpoint *checkpoint)
> > > +{
> > > +	memset(checkpoint, 0, sizeof(*checkpoint));
> > > +	f->algop->init_fn(&checkpoint->ctx);
> > > +}
> >
> > ...should we actually record "f" itself? And then in the existing
> > functions:
> >
> > >  void hashfile_checkpoint(struct hashfile *f, struct hashfile_checkpoint *checkpoint)
> >
> > ...they'd no longer need to take the extra parameter.
> >
> > It creates a lifetime dependency of the checkpoint struct on the "f" it
> > is checkpointing, but I think that is naturally modeling the domain.
>
> Thanks, I really like these suggestions. I adjusted the series
> accordingly to do this cleanup in two patches (one for
> hashfile_checkpoint(), another for hashfile_truncate()) after the patch
> introducing hashfile_checkpoint_init().

Hmm. I'm not sure that I like this as much as I thought I did.

I agree with you that ultimately the hashfile_checkpoint is (or should
be) tied to the lifetime of the hashfile that it is checkpointing
underneath. But in practice things are a little funky.

Let's suppose I did something like the following:

--- 8< ---
diff --git a/csum-file.c b/csum-file.c
index ebffc80ef7..47b8317a1f 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -206,6 +206,15 @@ struct hashfile *hashfd_throughput(int fd, const char *name, struct progress *tp
 	return hashfd_internal(fd, name, tp, 8 * 1024);
 }

+void hashfile_checkpoint_init(struct hashfile *f,
+			      struct hashfile_checkpoint *checkpoint)
+{
+	memset(checkpoint, 0, sizeof(*checkpoint));
+
+	checkpoint->f = f;
+	checkpoint->f->algop->init_fn(&checkpoint->ctx);
+}
+
 void hashfile_checkpoint(struct hashfile *f, struct hashfile_checkpoint *checkpoint)
 {
 	hashflush(f);
diff --git a/csum-file.h b/csum-file.h
index 2b45f4673a..8016509c71 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -34,8 +34,10 @@ struct hashfile {
 struct hashfile_checkpoint {
 	off_t offset;
 	git_hash_ctx ctx;
+	struct hashfile *f;
 };

+void hashfile_checkpoint_init(struct hashfile *, struct hashfile_checkpoint *);
 void hashfile_checkpoint(struct hashfile *, struct hashfile_checkpoint *);
 int hashfile_truncate(struct hashfile *, struct hashfile_checkpoint *);
--- >8 ---

, where I'm eliding the trivial changes necessary to make this work at
the two callers. Let's look a little closer at the bulk-checkin caller.
If I do this on top:

--- 8< ---
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 433070a3bd..892176d23d 100644
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
--- >8 ---

then test 14 in t1050-large.sh fails because of a segfault in 'git add'.
If we compile with SANITIZE=address, we can see that there's a
use-after-free in hashflush(), which is called by hashfile_checkpoint().

That is a result of the max pack-size code. So we could try something
like:

--- 8< ---
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 7b8a6eb2df..9dc114d132 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -261,7 +261,7 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 	git_hash_ctx ctx;
 	unsigned char obuf[16384];
 	unsigned header_len;
-	struct hashfile_checkpoint checkpoint;
+	struct hashfile_checkpoint checkpoint = { 0 };
 	struct pack_idx_entry *idx = NULL;

 	seekback = lseek(fd, 0, SEEK_CUR);
@@ -274,17 +274,14 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 	the_hash_algo->update_fn(&ctx, obuf, header_len);

 	/* Note: idx is non-NULL when we are writing */
-	if ((flags & HASH_WRITE_OBJECT) != 0) {
+	if ((flags & HASH_WRITE_OBJECT) != 0)
 		CALLOC_ARRAY(idx, 1);
-
-		prepare_to_stream(state, flags);
-		hashfile_checkpoint_init(state->f, &checkpoint);
-	}
-
 	already_hashed_to = 0;

 	while (1) {
 		prepare_to_stream(state, flags);
+		if (checkpoint.f != state->f)
+			hashfile_checkpoint_init(state->f, &checkpoint);
 		if (idx) {
 			hashfile_checkpoint(&checkpoint);
 			idx->offset = state->offset;
--- >8 ---

which would do the trick, but it feels awfully hacky to have the "if
(checkpoint.f != state->f)" check in there, since that feels too
intimately tied to the implementation of the hashfile_checkpoint API for
my comfort.

It would be nice if we could make the checkpoint only declared within
the loop body itself, but we can't because we need to call
hashfile_truncate() outside of the loop.

Anyway, that's all to say that I think that while this is probably
doable in theory, in practice it's kind of a mess, at least currently.
I would rather see if there are other ways to clean up the
deflate_blob_to_pack() function first in a way that made this change
less awkward.

I think the most reasonable course here would be to pursue a minimal
change like the one presented here and then think about further clean up
as a separate step.

Thanks,
Taylor

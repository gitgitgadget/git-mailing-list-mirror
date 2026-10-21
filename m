Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792564397;
	b=NDr4oLIAF+x0Q7k3yobdyYYCn3Ym23M8he7hslmgO1uiW/Hn2e3Qt1ut6wmaDf5OdwIB
	 BTR9C6uJw48jSSo2lr7DOrcpl7xGAZCtkU+iHnnr0WULHJZQyT0VWm3J2DsZDZ6GBqsAh
	 u1Ujz5cr0DNX9KtD2BeVX3xYBdXaJjcHBb5xFqFmjYcJyKX6lc9SOXD2HcUIKocZDjfgH
	 KYWx2iepSKPYbSHFE+W18g5MyTZ5JzxGKWcTzzTFeChn7ULIlLpmV+vpz0gfD2GrwLB7q
	 qagbSxGqKAgrUq3z+lrrFHGLaHp4cWju2Hea9blayPrekPA4lcJJ3a4LgQP+6qNYkQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792564397;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Tgb4AU6j7Qurj1SUgtj+v7yLZdOWoKJCV79ND9yOo6g=;
	b=tcM/Beeiljyt19WtnXrVZfQMXRrav6k0137enjODsNsgwAZf1h4tYYKVIYk0tLkIh19D
	 MhnQOeszQkn53oAx3HmOBC6k/cvU3V+YdpJsE6VlM/sLRfUgMSVoErCAM2IitOGkCRoFB
	 t2qDfx5XzvAzMwFKMSqUBNy0lENHwtiZ+joun5d/S7jkwlOGuduF0cp0hVtP3aMw5LiW0
	 /F971kNVOiyg4FWPskA6FKxtecyb+/o1/FG82nrLx6Qx7YuCd71uwURgPPnTWlLsDQqlw
	 ZAOEtdejcLZtmqEBLojsXvYAg/PwRYgeNl7ztRWdhIC3oUyb8yd66GtQnEkwq8WJnLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=erNrPWkQ;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA18E606A324
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 06:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA18E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=erNrPWkQ
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso332310f8f.2
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 23:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792564395; x=1793169195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tgb4AU6j7Qurj1SUgtj+v7yLZdOWoKJCV79ND9yOo6g=;
        b=erNrPWkQmUyb7twXA7aOmVWRiyof08Kx5ygfI/g/yeyOYeY234b00srdNPTew5oywW
         3y4hMHIrK8PFRakgGFoH+0bpO6Z20+LBb5g15ppBEPkobLX/UENachNOXT5K5M5ZAiG+
         jvrFm8O/FPECbPGdtVkcUiqNbIhLoPqlYL4iGgnWj/kOuXoNFSOocXfUywscne1u5/uU
         RHXuHk6CYlmLQ1UyjryOb9U4EViqTv1gLNPnyaHBRbNF8KSELs3NUNOGEGzdmWG6yDP2
         Keet3aACdJBTP87aw6jNtkPwu8D0s6FYmVpvblxOSF5r/l3naJ8ce1iezxvGITmXTXdS
         Bz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792564395; x=1793169195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tgb4AU6j7Qurj1SUgtj+v7yLZdOWoKJCV79ND9yOo6g=;
        b=fZoAs/jGAnMxQGddqOJKbtI0IOt3Iiip56Ry7IPpYtEWiZWh6vJ7cukqfcIM+Hrymx
         R9/1t627ZtMICGUR+rpQaMHso0WT1HsQv4lvKfBaNv09/ceMtS6q3roaHi0H0VapNk7x
         egMYZxPH3spxtlDjrk1mpGWAgJ457/fsOAk7bTI0zomQmXE3yciqEJ4KWHqXkz/fyDjI
         EnOmlCAH/Ey1SC7k/lcB3d+Hc7aqdzKm5pbJLJjUs4lNgbGtSnYqokgI8gnpPdrZdrSn
         qSX1NOdNw1TqFcoKdk6104fyM3P+aI2J5nlkefodGc7qstYCgGnG5O3vDU1azcLjauXg
         m4TA==
X-Gm-Message-State: AFq9FYK+rGePbTn7Z44cjG/azNxvzi/NFo2ku1sOrPW1GV32vFEJ7wq+
	HGm/5YEPaDleRKJ2+OxH81DBQh4WLyIFTvRfoydJnoFCiJok94CsTnpTqpoUiQ==
X-Gm-Gg: AYBFou2ylahXsapPfdU/shF7+crVZhJWwVKy6/dF19yqHFAn3JKOfnEW7yA7Abim9Av
	7+mqiy2+9LNm9dCgeW0rgX/6cIFI8InmW3Fn5Yay0FBARchlR155aQzinfxDHUoqRZJnYnJynWq
	tW+pqrhT+M/HgThQfHuLjRzMZFN49R21DDW4MoUjuRpM/wxmSJdsA83J0gCsCZC5FgFVG9ENfU0
	ily5Y86Gtmzh14+VxLd9LAQsrhUzS6zsisySyo6LwnHBz3OWSTnYS45Ah9bXh/urFotzoiPgw1+
	4S3CBMAJqnUMU+y8xZTXWUkG42bavG+3BqMaZtxE9SK7Tpfc+n9KFc4lcFQ4gbzwud/Gm9xm2H3
	ngSNNlXF/FfPsKIQyuPb8zFaja4b+qs1ex5JOQjZwUD7CRf3VvU74e+Q+eDr4GlWfHC8K4EzkMl
	gmYDIRbszLzCP3Qi1ibWFX9IC1DE8SEALpagdudCSSeXjwch3ThYiB5/HmEms/NxxwImAqXDmtw
	WwwF5altxUpYjkAGqOWAhR+kpHJcXP269C/Pwi3ngyUGB0Cq8pfUh5JDnlaMphfpDbuR2hxws8j
	XZXGzfVpT+yXYppB2ZHX/sL5DAKcijie7+iUT6G+Ph9ua47+IrUr+Oa/f625stHgo0wWo+MIg1F
	RFncKvDmEFnOd6YAGX2mFTNLCdiFvmINdgLSqAWzn4HpvbNcxOMMHiNLi1y6PUmU51Q==
X-Received: by 2002:a05:600c:83c8:b0:4a1:71ab:63ba with SMTP id 5b1f17b1804b1-4a1fdd13f05mr17662435e9.29.1792564395079;
        Tue, 20 Oct 2026 23:33:15 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2581eedesm3130790f8f.14.2026.10.20.23.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 23:33:13 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 08/13] object-file: handle compatibility algorithm
Date: Wed, 21 Oct 2026 08:32:40 +0200
Message-ID: <20261021063245.2917625-9-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.215.g47fdf2208c
In-Reply-To: <20261021063245.2917625-1-christian.couder@gmail.com>
References: <20261021063245.2917625-1-christian.couder@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "brian m. carlson" <sandals@crustytoothpaste.net>

When we check in a large blob, we stream it directly to a pack and then
write an index.  However, in compatibility mode, we also need to make
sure to compute the object ID for the compatibility algorithm as well as
the main algorithm or we will incorrectly store the null OID in the
index we create.  Do so here to avoid corrupting the repository.

Add a test that adds a large file in a repository with a compatibility
algorithm.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 object-file.c                 | 18 ++++++++++++++++--
 t/t1016-compatObjectFormat.sh | 14 ++++++++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/object-file.c b/object-file.c
index c049bf13f7..b4c4a2ea0f 100644
--- a/object-file.c
+++ b/object-file.c
@@ -747,6 +747,7 @@ static int hash_stream(struct odb_stream *stream,
  */
 static void stream_to_pack(struct transaction_packfile *state,
 			   struct git_hash_ctx *ctx,
+			   struct git_hash_ctx *compat_ctx,
 			   struct odb_stream *stream)
 {
 	git_zstream s;
@@ -774,6 +775,9 @@ static void stream_to_pack(struct transaction_packfile *state,
 				is_finished = true;
 
 			git_hash_update(ctx, ibuf, rsize);
+			if (compat_ctx)
+				git_hash_update(compat_ctx,
+						ibuf, rsize);
 
 			s.next_in = ibuf;
 			s.avail_in = rsize;
@@ -882,16 +886,22 @@ static int odb_transaction_files_write_object_stream(struct odb_transaction *bas
 								 struct odb_transaction_files,
 								 base);
 	struct transaction_packfile *state = &transaction->packfile;
-	struct git_hash_ctx ctx;
+	struct git_hash_ctx ctx, compat_ctx;
+	struct object_id compat_oid;
 	unsigned char obuf[16384];
 	unsigned header_len;
 	struct hashfile_checkpoint checkpoint;
 	struct pack_idx_entry *idx;
+	const struct git_hash_algo *compat = transaction->base.source->odb->repo->compat_hash_algo;
 
 	header_len = format_object_header((char *)obuf, sizeof(obuf),
 					  stream->type, stream->size);
 	git_hash_init(&ctx, transaction->base.source->odb->repo->hash_algo);
 	git_hash_update(&ctx, obuf, header_len);
+	if (compat) {
+		git_hash_init(&compat_ctx, compat);
+		git_hash_update(&compat_ctx, obuf, header_len);
+	}
 
 	/*
 	 * If writing another object to the packfile could result in it
@@ -916,8 +926,10 @@ static int odb_transaction_files_write_object_stream(struct odb_transaction *bas
 	hashfile_checkpoint(state->f, &checkpoint);
 	idx->offset = state->offset;
 	crc32_begin(state->f);
-	stream_to_pack(state, &ctx, stream);
+	stream_to_pack(state, &ctx, compat ? &compat_ctx : NULL, stream);
 	git_hash_final_oid(result_oid, &ctx);
+	if (compat)
+		git_hash_final_oid(&compat_oid, &compat_ctx);
 
 	idx->crc32 = crc32_end(state->f);
 	if (already_written(transaction, result_oid)) {
@@ -926,6 +938,8 @@ static int odb_transaction_files_write_object_stream(struct odb_transaction *bas
 		free(idx);
 	} else {
 		oidcpy(&idx->oid, result_oid);
+		if (compat)
+			oidcpy(&idx->compat_oid, &compat_oid);
 		ALLOC_GROW(state->written,
 			   state->nr_written + 1,
 			   state->alloc_written);
diff --git a/t/t1016-compatObjectFormat.sh b/t/t1016-compatObjectFormat.sh
index 1560b6a2e2..af9532aa1f 100755
--- a/t/t1016-compatObjectFormat.sh
+++ b/t/t1016-compatObjectFormat.sh
@@ -228,6 +228,20 @@ do
 		test_copy_bytes 8 <v3.idx | test-tool hexdump >actual &&
 		test_cmp expect actual
 	'
+
+	test_expect_success 'add a large file streamed into a pack' '
+		test_when_finished "rm -rf large-repo" &&
+		create_compat_repo $hash large-repo &&
+		git -C large-repo config set core.bigFileThreshold 1k &&
+		test-tool genrandom large 5000 >large-repo/large &&
+		git -C large-repo add large &&
+		ls large-repo/.git/objects/pack/pack-*.pack &&
+		git -C large-repo hash-object large >expect &&
+		git -C large-repo rev-parse :large >actual &&
+		test_cmp expect actual &&
+		git -C large-repo cat-file blob :large >actual &&
+		test_cmp large-repo/large actual
+	'
 done
 cd "$base"
 
-- 
2.56.0.215.g47fdf2208c


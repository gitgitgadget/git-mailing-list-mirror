Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792740390;
	b=rqybpNTYh+vWu3x2GwF3GhfwKGV6to9nqgaZyPV/r34af8DWVBJJNYXkNJjN42E8IdhE
	 q6OP9pr3vBnePH2DR0YOBKsDZPUglSzED+QSRTk8/l84IhaWRTxC6VG/hqAfG1G7NQQMp
	 3izVfhgIWgSAa/F2rZ3c4tofz8ZzeLpg+FvKFz81ZeIf6DVgzv05m/RpnimFrsyWaXXRj
	 fS4Zl5Fg5sY3miHpTsx7LhIN6iNxUp69nCTZI+Yi2r+tQYBndPoYOZN/G5ObfTClW91L5
	 LM25NbojyYRWBsgtROmoFnASDkpkW5+mEsgjKa0gTGq7QSkEoWyArASLCDrGlrLUFiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792740390;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Tgb4AU6j7Qurj1SUgtj+v7yLZdOWoKJCV79ND9yOo6g=;
	b=WS4yTATPh+pcK2uRh7b7iGBB20Va+ZhtrqrBDrxRVJROhaw8vNmUUeA+xJVrFzfxkIGG
	 f/D4uAIZBmCP8HryIrZt0pgfwfYxCsEQuCwOXLOp0xunjGZwBJWFMxBMhMUpCPqr13PzY
	 /WfldVj/73OH3VB8kdzBaiGByiDKFcutZjDoLOXULfP3Nj45srBzyVSKdP6z+3iWnOWmq
	 wPmgQDB9iO3j5fN3BzHfKeMiJgrPbbMyKZe1RN6CuvzSiI9UeE0zMPUy5lA6f6EoOoOzo
	 Cl5et/NdQQyUcnVLkAxAhGOyxwvN7Fmc2dwl2zmd4lgD/WOhT3Lt9bZXi7EfME4RprQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oU8JNWIW;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A2E606A334
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 07:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58A2E606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oU8JNWIW
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48df4f540ebso286937f8f.3
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 00:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792740389; x=1793345189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tgb4AU6j7Qurj1SUgtj+v7yLZdOWoKJCV79ND9yOo6g=;
        b=oU8JNWIWXB5uOvDaMx7vYjzcGvbQOSzRBWiKdRgpElR/jBUva/4JCoA3CjnfAvahwr
         rPW0ilIbHvTnNfXJpl4kwUg5WSbEC8WdYhEeMvrmYzwT3h4Ck749/Bwe+it4ECCIZNiz
         gFzon/pZqwQVEJXrwq+p9gFMM7FlCbvflw8skx6ASeszvE6mgADYVerzcQgFSt4qya0w
         OZBxwjdVf6XmFAmtE4AKHpsPlDdIR8HDJ2ZkRp2QQQau8Hu1JAxzru2wzXinxTxRI+8e
         /zlU5ZAvonR3DrfO5n/SPbijr8F98YhBZ8Is8ibM4PTziN/RaDrOKlIOkAwGWIc8qWvy
         zPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792740389; x=1793345189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tgb4AU6j7Qurj1SUgtj+v7yLZdOWoKJCV79ND9yOo6g=;
        b=szX2TTAF9mZCiU82lUhWVmJetlDiKm/oYKidHUzM9i7SWdrlvfIRFp0xTS1b7+P8Pu
         hUECOKrLv3AYNmD+mbWqlKIPKle4IcqEtKXnnQuNMJ0uMIuQfp03IXSLYmcsdVbTcTY2
         WRpCTxtEEZRKGlBPdL4MWBXcpyRfB4N38sCBU9P4DPQvIDWX6B8CfpuZCEvn6ZFWEeAH
         O8z29fT4HlrpMcy1tN/kJJ3hifa80avNunUNPgBkCnfC5q1oGQFH6nNPhd9t9W2+EtP5
         zftoNUDecBH/64xWZzytsN8/3kZBhVp4ur4Zo81LLpoa66OJiRFFQZhFR2kMhF44MZ3n
         VvKQ==
X-Gm-Message-State: AFq9FYI0UrIlbcRUrvoGgcWxCQ78chTfzQUF5PUOB1RNGqDs3+X26noJ
	63K/Kg+WWr93sCm9e5eIOr/ogkZrhCD+3QzT37keqqW2FFsu5aqElpo6bweE9g==
X-Gm-Gg: AYBFou2HyrA0jLoIKxS4y8zirOsAq3n+8JxESlk00HSYYa1Cdolbhm7wBz78SFTbSiL
	svM3Y3WebNXbOsFqYwW8fgvq4gl8HsZrT7/lilQSwEq2eQp6ShfF/IiK2Tgz7gmIVF9ylKv2Tci
	IQ7ed+iIS5BVfqx9hSR1VpsSTbvg8BgSUiS08FCdyP2lFHKc2HYPIFLa8XftHLAzhE2t1vLfaYm
	0yxLUUKP1pMRxAREmN8CcA1rmwrF5N/nxW8Ahb0wLYF0DNgZ0IVC+J7byU62ZiqajEuv7xPwdbS
	Kpd6QFB/0f8gCKh5DRLjmbZfhdGSfthn7KOyifZVpRKcGs6+t2lfKxIhfKoE0yHYYDubY17AMQe
	vaavo0m5MO7QE+xdW9L76QuBSo82JeZ7uVF0uYCqE6zVYhZL8VAsClYEZjdJD8wljDZm+mxD7qY
	Iev3UfLFNLQmVqtKn7aG4xDLRRpjzb8aX9zxWZDdk+dkBfxGkxGZC/FHLlJyFwLfGdroFb+DAso
	wfbHBAx2Snd9xVi/4DvmTaAJASY+VoaJE+tFFJTzjT6QnLaN3a86DNCR5ab9njIBAngUjbVWJu0
	ETBabiJJRjcXvB4UabAEqmKvHWN7gir+oFcYxlUdLwrQz2WxteGaG11jOHYGpyUULhJb3ytIra0
	rDkKOHA8o6bELzaOEeH5HeOemEZeYY1/HbtCAehsSKOtrncqb1p3FjhBkK4xyJpdviw==
X-Received: by 2002:a05:6000:46cb:b0:48d:f4ea:49c9 with SMTP id ffacd0b85a97d-48e385af64amr1160144f8f.54.1792740388729;
        Fri, 23 Oct 2026 00:26:28 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38055da4sm3228024f8f.43.2026.10.23.00.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:26:27 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 08/13] object-file: handle compatibility algorithm
Date: Fri, 23 Oct 2026 09:25:53 +0200
Message-ID: <20261023072559.3204273-9-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.215.g47fdf2208c
In-Reply-To: <20261023072559.3204273-1-christian.couder@gmail.com>
References: <20261023072559.3204273-1-christian.couder@gmail.com>
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


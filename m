Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793794617;
	b=WgF1eJfRuWLmvskSovQsH64VzdNnifA1T25H7gsCKUSy1Rq1LV94QP5JYBnEUIYlNV2l
	 okBaBwQGiNBHlKmtwd0BvKqEC6ipu8+cmOAEWeb1MxW8NBXkrPgRjncSEjfTnLr5b8+4D
	 q81RFiR6/xaFJ4RNbr0s46vec8GzJJAbwJBy1z7uNipYy0X31c6GM2vxN6I7xgAL3A4WI
	 dnO+C8XVD/g823R9L5x3AW6FiJGCzyNTw4Jv/A+Ez6vQN11DnjYHUif7GC742DLMoCrHX
	 pJ1/reaM+qh7Sac/CGmT8ocq7asQBRuSdCDuXVTUUSmCZfShZiloPhIhCbZBQxD+PBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793794617;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=Tar0IxBSeiXDnYDEwstnO8GYKz+xVmAZTr/I638dBdU=;
	b=GdGE/s8kboxne8g5Um7ZNjIovvTAQaT25VjB6bDeQ/DM5lu1n6iCATBH36Pu/3NXCdAz
	 03Pbr5zIwOwM9SEeXii2B9oEnDZJDlgqvwrgLCSzx38l6uodVyiNlD+kk0jhUTAbw5xaZ
	 UHfic9LkyzuFVlDn1qe05ovuMOQC5oT/ihM2idFj9QGvqanxKCb13eVSz5ZXsUQSYyMFq
	 KApugm/GXVQVoIOrEX1rCCNDfsps/Uwgtf/5LOLL63QIkrMkrEgDaZG1nsu6MpW132X/C
	 e3za231z4qoLnfIhT0disz0wjMRN5Xf76qi65k87rJs5Cjr9WDZ2GiQT10cUt8VJlSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=wupCgWjr;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="X7BsPOp/";
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD75606A328
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 12:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DD75606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=wupCgWjr;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=X7BsPOp/
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 6E656EC011D
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 07:16:56 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 04 Nov 2026 07:16:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793794616;
	 x=1793881016; bh=Tar0IxBSeiXDnYDEwstnO8GYKz+xVmAZTr/I638dBdU=; b=
	wupCgWjrE0q17imop+Kl1nWWJIbZpt44qLFycPJZmZrT1NyAGSR8eUxwAand3iS9
	mZnVa42aIM14KBy17ask4lYYAgwDRaIyTx9LmeM+V3IVoD/XUK9MS/pyLyimU40Z
	DqqpKcmQaLCK1pcKWBlgmey8OW3fvEd0aL0/0i7f9YBGGou7fwQCL0VCQDETxR9C
	+BsFaRcNDsNnm/7S1jDFEyXra1TDViY/FqiQ+a9srS7Wn7jM8kD7nSfV7fbJSgE5
	dbX6rjryR5cKW0kvB1wrjZOSSpnxPkEH9Wb0atGipjKdIr7g6K2lsjmCEGDsp6mG
	cuu80HUfjBTsFhge7i+MEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793794616; x=
	1793881016; bh=Tar0IxBSeiXDnYDEwstnO8GYKz+xVmAZTr/I638dBdU=; b=X
	7BsPOp/d9ObPc5TqUpjK6RgO6wXjcKiA7DaZRsN/wpJBBV9pFxwdOu2WV8LcU92r
	YMadXelLUwgwsjvGto1VUTMLEwnVADAgnZwciCUBZa6eaREIzlUjFWFMN91L/CXT
	WRcIDzdG+XyYB5jLiXvaF3zw/32XH8+FLMMDFqHPNIkVYiZXpBNJBEXaQS0tegy7
	lU+Nu+7ARj3fQcCSKmfrS+C8aSI9OIrLX3QR3My8rAUyVXk8pKCnTwiYapriMmWc
	GKX3zcb3FKFsJNRg0ynBgBapGoFFDo3PVpQAnQTD6lbex4f0Ps+9dQdFIgwuPpfo
	w6nKbn1H3eOIOguWfngYg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793794616; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:Qeu2AF0ofJ0oG8h23yIZQNqEblCIHKmlwl7hMIaUJ6p4InA
	HZMDz1FvHvnXX76zjwrpo/qfELoMArl4ImaQmE2IcotFBYnsaOvsEQATvhEsMETF
	7DzmodGc3YcmKgiX8ktA65S5EKdSefMLilikj9Iwfo9Amnvg2cicujECRL/MwSUG
	NUm87ePvbnrhl1BX30BtjVHd2arKx3tctpS+awoiEHOlGK6vzVxnf+g6Y1DVMCNR
	oeMS+74EaNOdVhAU04p+PSE8mfckV6f09DdPmGcK3IK/N4JtNn+LQJgquRjPmbfP
	sDbg0u/8jbaq9tEp7Dx53Z9FFe/gh2Q4M4SsmHQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:hgugFxQIQ2OQfJ2/Fs9DenS1dv/cbzx2JCO09X2gHSE=:byDzWLneaBDGoST8bD40lrwudkiJxI02JsDa1We1nhQ=;
X-ME-Sender: <xms:OCLrajyWf9j9T8CT4UxcC2l69IsCIEZTeNAv5tV8-7Z176w8nxjg7A>
    <xme:OCLrahR_MC_n-8qthno_nA0zYmMS-331xITfwU7B11CYfTIjkdcejoL7gYNPbBgR3
    VoMuI-iXWiaysFbhHFqzx4gjB9zCr6m1Bk1PZOBKwV1BxVmvtsLOFc>
X-ME-Received: <xmr:OCLraq8Ji1xQWC4s6EfUZ1wyQScNdcKg0krKVCwq4_c1Au1aNB9tm9BggFkrchQvCg6-d1I>
X-ME-Proxy-Cause: dmFkZTGk8c1TlbMorBsjNCP4hL2v4+p+dHbI+DJ9+q1ZREK7BZSDIPbsCPhmU+cneDnfy9
    R+NeVQeYwvy24UNA750sfZfVgMNr7oPtAFAVuRzXs3gZWeu9Hv4q0TAqTBgA4kel1Zh5uz
    r5Jxltf4OuKB/OSutaXitQiOU161mSAFP+aKFgrA29ff9eF4YiETV3VepoU4TKrsvlu9WN
    3C40QQvjFpzcHFRynseG3Kx1daABXR4yfOq5JYVmiwhJJkkd/U+6uNz5PiigP/cE/V3h+g
    N9I/fNuPQ3IIQP6X09xV6cZwk2LaVoH4QAeowiG74D/xahFxKLPV9D1zPd7V1Yq+jDnaln
    NJO7KNA1A2yOzqgXVf/kXl+0V1F5q5AZkhyCULUJe0WUKabtpO0mxyd7FNo3TeQZqFIMCu
    xL+cleqXsJ9lsEGQvlRD1O+YDo/g4VyND8Keg/3f23IFMBqHS4GtN4F9PPKdNkJXh2vcWy
    2qK4Fi/hwV6+1fywDA0E6XGkYuBfrDnp+KQLKvObn2sunGMXZ+W90JDfXAPM8HIlCN1KmE
    43J7HSKWrxr+wzliXcUEiOYtLVcjxkjzDzILcXHd56cfahW/wY0IKD2g7GJboI2VPFSlMV
    ykaAjpsAJFP9b94FyferOU9+EBQUA8y5dyf8F+IPUcsYvlpJQA/7rLdK5hZg
X-ME-Proxy: <xmx:OCLraoqiFCl9Deeiq7PufuH8HkLaOAnp3574djiEHQx-pbjdVJmlYg>
    <xmx:OCLranmuz3RDoFUDuzGHieWHJ_sZ3e7JWrSFlGdLNO7aEbZjeA0bZQ>
    <xmx:OCLravLqUbYHaAHFr3-_Mq6wYaMXlqYSGB6PGPHAMk2hLhPfExRt8Q>
    <xmx:OCLraswno4gORnkxNd9ztVoRy9gkrAz1gpFf_q55aESlR1BihpMR1g>
    <xmx:OCLragSxIYzWriyE1NLXy9fKe_StG7ajTBXiNEl5dxrx9gA__e6I8Fn0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 07:16:55 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4403f95f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Nov 2026 12:16:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 04 Nov 2026 13:16:34 +0100
Subject: [PATCH 1/2] odb/source-loose: extract logic to retrieve
 subdirectory bitmap
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-pks-odb-loose-stale-cache-v1-1-a00d5cdb5e7d@pks.im>
References: <20261104-pks-odb-loose-stale-cache-v1-0-a00d5cdb5e7d@pks.im>
In-Reply-To: <20261104-pks-odb-loose-stale-cache-v1-0-a00d5cdb5e7d@pks.im>
To: git@vger.kernel.org
Cc: Patrick Ohly <patrick.ohly@intel.com>
X-Mailer: b4 0.15.2

The loose object cache tracks which sharding directories have already
been scanned via a bitmap. The logic to retrieve the bitmap and mask for
a given object ID is inlined into the function that populates the cache,
but we're about to add a second function that will need to perform the
same logic.

Extract the logic into a separate function to prepare for this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-loose.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/odb/source-loose.c b/odb/source-loose.c
index 50cb388c352..da8f9767257 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -26,29 +26,39 @@ static int append_loose_object(const struct object_id *oid,
 	return 0;
 }
 
-static struct oidtree *odb_source_loose_cache(struct odb_source_loose *loose,
-					      const struct object_id *oid)
+static uint32_t *subdir_seen_bitmap(struct odb_source_loose *loose,
+				    const struct object_id *oid,
+				    uint32_t *mask)
 {
 	int subdir_nr = oid->hash[0];
-	struct strbuf buf = STRBUF_INIT;
 	size_t word_bits = bitsizeof(loose->subdir_seen[0]);
 	size_t word_index = subdir_nr / word_bits;
-	size_t mask = (size_t)1u << (subdir_nr % word_bits);
-	uint32_t *bitmap;
 
 	if (subdir_nr < 0 ||
 	    (size_t) subdir_nr >= bitsizeof(loose->subdir_seen))
 		BUG("subdir_nr out of range");
 
-	bitmap = &loose->subdir_seen[word_index];
+	*mask = (size_t)1u << (subdir_nr % word_bits);
+
+	return &loose->subdir_seen[word_index];
+}
+
+static struct oidtree *odb_source_loose_cache(struct odb_source_loose *loose,
+					      const struct object_id *oid)
+{
+	struct strbuf buf = STRBUF_INIT;
+	uint32_t *bitmap, mask;
+
+	bitmap = subdir_seen_bitmap(loose, oid, &mask);
 	if (*bitmap & mask)
 		return loose->cache;
+
 	if (!loose->cache) {
 		ALLOC_ARRAY(loose->cache, 1);
 		oidtree_init(loose->cache);
 	}
 	strbuf_addstr(&buf, loose->base.path);
-	for_each_file_in_obj_subdir(subdir_nr, &buf,
+	for_each_file_in_obj_subdir(oid->hash[0], &buf,
 				    loose->base.odb->repo->hash_algo,
 				    append_loose_object,
 				    NULL, NULL,

-- 
2.56.0.500.g5d06dc02cd.dirty


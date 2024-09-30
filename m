Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A6017F394
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 08:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683734; cv=none; b=XRGb4XekfG915nbDOjlJ1L+uQtDcUogoPp6SJXOAJ0M5sJJDIw+7x490z8p52SIYmWzuuNC0v49Px3uZlM56ztLSDRwC1aSMmM5qZaucEBREmuah8uASwN3pqiz/wR/r+q5wjZANOdhhhJqwZXwBup/SPD77H5Ru+I5ofArK3p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683734; c=relaxed/simple;
	bh=X4s8GG+5APnyuNhaqVzp78CTShbUOjtCJyn+4EYTdXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxvQQDkktw/SnpykBceEr2xJJJEoj8NmPs8UcvJq4TCUGPvp/1x5mX6VFC18RH3b2a7qGf7pXu0tE3GkiEzvz/5wP/+r+9USoy8OAhl9XeBYoQFmPt/5Jt6NM5a/ru1o+GwqOhe6GkPBAu8AevxgR0YxNKtbkBIVkYeq2Ew66wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jZZBZP3e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dHr7v2bm; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jZZBZP3e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dHr7v2bm"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 33D8B1380272;
	Mon, 30 Sep 2024 04:08:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 30 Sep 2024 04:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727683732; x=1727770132; bh=K6aJarCbzd
	olnz2ZY12L1IO4r7KBh0lHiykl9VIKTxc=; b=jZZBZP3eDdfEVHVrYhuWOf7ZY0
	zgVnIspsSkztmH4s/vEAsPLlsIp+2Cfg6mQ5XirRTK6zP0NXMcmgYqsemR6kQlwP
	qEs/tkThVtdECu+byinaYAP2bvfO9Cr3wQu4oiBTRZe49ATLrSZfpIoBGZrt2KRT
	5LJpddosjk4hf2h3ypYjROGxLIMEb8EKExm2hf9zUL7ykcXsSsiDFHatpYleuSaL
	PT+u3hhzy//NM4HSv6/5bqF4h+BYPg4/t4aOUfA6eODvhCbHGJhj2ztcjou8xzB/
	uY9Y37GimwpQnJVN71fkt1Q+jWDt1nR/m3KmMgV8iie1bcmR2ZUDu4wBtCMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727683732; x=1727770132; bh=K6aJarCbzdolnz2ZY12L1IO4r7KB
	h0lHiykl9VIKTxc=; b=dHr7v2bmLlnD2ZvajjFjcfdhkmubvgAMUQkPSmG0hKHJ
	OmlM0x5dKXFoWHTb3UmPZwTmaylHu/41/lU98ETb2wR+f4KKq3GoLpAScL2af/IW
	43QyCfZhWYU1yhI4uk4EpvwzQHdf1YYT0kGNLUx/KdhTGDWlVw4a5NXcnWAGim6l
	vcEEewg97RNMKoPIouJLpzLZb2DZPaYVcNEvJ8lOuRjlObYJ+RsvzYwyVUwlBhyC
	x5xko0ad/fJZNSJTq9BNa7PvSbSKIyh1o10EASHZkF4O8HS0YVQjlF8cLoX0CSrN
	GeINRQCkxwn7ocfy/lhhLyEyxwdnikYi+T7T0esJ1w==
X-ME-Sender: <xms:lFz6ZqhV3Fks9nNYZu7IqF5xNgyQ8Afx2-toVWIYZRkXLdMu6nmsFQ>
    <xme:lFz6ZrCEmyY14TnDDBTPf3kuoiaYyM1K0Xx4tXGLgPfvB8cjpcO_gKXtbm9_0Tvia
    L97iDZrKHkDI5V0pg>
X-ME-Received: <xmr:lFz6ZiH3DROG-y5LW32A1EwBDKTdn2ELMMKTIBdwJeVg7zCxjGL1Ckn3UIS41qyP6EDWB-FRm-72P1t8i--LspzrCoUmg_c_rMlTaL1XUP5X5Ew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddugedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepvghthhhomhhsohhnsegv
    ugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:lFz6ZjRLSV7weZXh9Xj-G6PDUzOs-5_-I_3DPB2jXlF9z0xs6Mtzng>
    <xmx:lFz6ZnyB-aZ01Ml4olfPr3HUliUIcA0d_cZw-5Uei2Rm4Vv1l6Wv6w>
    <xmx:lFz6Zh4myKnTBX2VTlMXYSEm9LfmT6rqBkm9DKwZCmbJpd9EyjDA4g>
    <xmx:lFz6ZkzAvLa1kWEWOJzxVU8f_eaaqxq-S_uhREJ1A1mbwXPwK_bM_g>
    <xmx:lFz6ZpuMsR1SEJiFX6r6liJ_RuxblkF1PWiga26n1A7_6OnNww4G6VMa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 04:08:51 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fe2f4a8f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Sep 2024 08:08:05 +0000 (UTC)
Date: Mon, 30 Sep 2024 10:08:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 13/22] reftable/stack: handle allocation failures on reload
Message-ID: <0f3e3d1585777813f52caa82ae873c37620d96ad.1727680272.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727680272.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727680272.git.ps@pks.im>

Handle allocation failures in `reftable_stack_reload_once()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index bb4d230918..060b2c1b90 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -214,13 +214,13 @@ void reftable_stack_destroy(struct reftable_stack *st)
 }
 
 static struct reftable_reader **stack_copy_readers(struct reftable_stack *st,
-						   int cur_len)
+						   size_t cur_len)
 {
 	struct reftable_reader **cur = reftable_calloc(cur_len, sizeof(*cur));
-	int i = 0;
-	for (i = 0; i < cur_len; i++) {
+	if (!cur)
+		return NULL;
+	for (size_t i = 0; i < cur_len; i++)
 		cur[i] = st->readers[i];
-	}
 	return cur;
 }
 
@@ -229,18 +229,30 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 				      int reuse_open)
 {
 	size_t cur_len = !st->merged ? 0 : st->merged->readers_len;
-	struct reftable_reader **cur = stack_copy_readers(st, cur_len);
+	struct reftable_reader **cur;
 	struct reftable_reader **reused = NULL;
-	size_t reused_len = 0, reused_alloc = 0;
-	size_t names_len = names_length(names);
-	struct reftable_reader **new_readers =
-		reftable_calloc(names_len, sizeof(*new_readers));
+	struct reftable_reader **new_readers;
+	size_t reused_len = 0, reused_alloc = 0, names_len;
 	size_t new_readers_len = 0;
 	struct reftable_merged_table *new_merged = NULL;
 	struct strbuf table_path = STRBUF_INIT;
 	int err = 0;
 	size_t i;
 
+	cur = stack_copy_readers(st, cur_len);
+	if (!cur) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto done;
+	}
+
+	names_len = names_length(names);
+
+	new_readers = reftable_calloc(names_len, sizeof(*new_readers));
+	if (!new_readers) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto done;
+	}
+
 	while (*names) {
 		struct reftable_reader *rd = NULL;
 		const char *name = *names++;
@@ -261,6 +273,10 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 				 * do by bumping their refcount.
 				 */
 				REFTABLE_ALLOC_GROW(reused, reused_len + 1, reused_alloc);
+				if (!reused) {
+					err = REFTABLE_OUT_OF_MEMORY_ERROR;
+					goto done;
+				}
 				reused[reused_len++] = rd;
 				reftable_reader_incref(rd);
 				break;
-- 
2.46.2.852.g229c0bf0e5.dirty


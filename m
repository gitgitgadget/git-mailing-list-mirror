Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222181386C9
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 06:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727159562; cv=none; b=oLGB71EdnkC+YVn2PmaVMqwRGWrfKowyINlv4BYgpRcqyeCYuBwQfb1JOK0EpDAYLdVENmr4fKACrIvcYpNteND56lTYUXYeHQ0/SA1vRLFSWDw43EDPLDdUjVd5Q1RoKWuNr2S8A4V7knPn/iW6uNUkuri6fwQPGoIm/j2jOc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727159562; c=relaxed/simple;
	bh=2+Bq3FBnqX171CNqTpECpWVS1f+rbB8lKjzw4ZEBpd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHlxJDz1v/ykG1R7B3ROsN5pQVXS3JUj9E3RTZN2FRPFztJS4Yd++K+hFZltzk/6U/rsffP5hkL/kXb7QHRS3x37zGeKuT9/vCxqeYx5mHJ7xjY9PRNE7QThG0ILQliF7VN5/rKzqh82zIPmFPOejeHalMaah9BtF8mkV0u8iTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mLvJOAo7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hRukdqex; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mLvJOAo7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hRukdqex"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 21549114022A;
	Tue, 24 Sep 2024 02:32:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 24 Sep 2024 02:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727159560; x=1727245960; bh=LogQC2+zgq
	2QN3Z1XvrDXhPS4tNisnkunFZv9gfh958=; b=mLvJOAo7kKBMLG+7gnoQrCxGck
	FKc4zUA9ivpbPwBy90YjdvsZiLf1KhMPB/cyZC1oWPwDlRkVhehJol5AXETAJsBo
	VQLv3nchoz4m4Fci44IuuHZHgdrFMQY0ZPZY4m5EcwnqYGbNoveiyMB+HODO6aZ9
	0Z498ISH2z6iIjfX/+NNR1Avn9MCyx9yQHaRSD8Pb+qR215AsaLc/61QkMtZxwsA
	GTRa6sRq32SfDvfGV286Sm0Qexp1AQFNU+RTjG042Ui9NSi0+hu0Z1r35r7cjK7r
	z8MpVUkYxu2zCVj7wYRYXM1Dq65QbXH0UYXrX1oqlzYJ1PquF/VAf397DcjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727159560; x=1727245960; bh=LogQC2+zgq2QN3Z1XvrDXhPS4tNi
	snkunFZv9gfh958=; b=hRukdqexk6lxz8QaLI/65peMHUV6CnXUf01MHcFpuquE
	7lf8NF/ZUHNiTz1c+LMaqHwlYQOMZpoiaPr/NiuoJb66QwQO8HPdEdZRKB8f4Esa
	w1ysquj1af8Mq34RQBQaF6rVTHK8W7oOWnn8DluEcwy9iSiDjPs0ObchbpshZq6c
	URp9sFoExnFsKF5IEqrikraSmXoXj6kefjzdCEJUhOqGINr7jaxjq8MDyBhLM0QN
	FuNwkacdj5Pk6XecdTvaG0JGa/0R2TcI2iR34HurSf49krAgdrdvla5pZl5wUP5i
	j3XhhATmodsMCU++YXKtg5xrCqQAZcTK8KWCjmvl8A==
X-ME-Sender: <xms:B13yZmJeuraIrvna2Bz2YWQhdYLTxr2Pr7A_l6JVRLOPezLBQbxSig>
    <xme:B13yZuJXdIQozMcDSRhdA4eObzkuqGMBMkFDRqWfS_BReEvVC9Ov6ik3aSwbx8wbp
    LFXwiAPwfhofIZE2A>
X-ME-Received: <xmr:B13yZmvPNuQ_WcYjmMbUN84nk5XWAngO6u5HLK3y2wz5dWrJfbNDhjt-DM0Cqed3CN131Sb3Ce5f3V0fmZplj_mIoPqPbreOV1wld9oXae7gLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtuddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:CF3yZrbeN69o0Iuk1AWMyqphrTfcuU6MMYsgIMtWcPMqexNY19atUg>
    <xmx:CF3yZtYb7Sz0DLUgKygv6cwR8sPH72aB2gVOSsJ_AcPk-ojyi_0vmQ>
    <xmx:CF3yZnC6Jeais1jLjvGuAiO_01y3OGW4JOwTPHA_HfQ995TFH6ri3Q>
    <xmx:CF3yZjaTblWoBtKypnjIAG9AnQ8AButEk2Cd5mVgJMj1KFZ4zSRV7Q>
    <xmx:CF3yZhH-gIGg0-TaVBhqFNAczYnnvUwwL46eY3TxMmqvkyGmSpAL6lxJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 02:32:39 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 19c09627 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 06:32:06 +0000 (UTC)
Date: Tue, 24 Sep 2024 08:32:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 14/22] reftable/stack: handle allocation failures in
 `reftable_new_stack()`
Message-ID: <7377421a632bf7a3517036316eccfb11fae91611.1727158127.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727158127.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727158127.git.ps@pks.im>

Handle allocation failures in `reftable_new_stack()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 060b2c1b90d..1b77c9d0146 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -56,10 +56,16 @@ static int reftable_fd_flush(void *arg)
 int reftable_new_stack(struct reftable_stack **dest, const char *dir,
 		       const struct reftable_write_options *_opts)
 {
-	struct reftable_stack *p = reftable_calloc(1, sizeof(*p));
 	struct strbuf list_file_name = STRBUF_INIT;
-	struct reftable_write_options opts = {0};
-	int err = 0;
+	struct reftable_write_options opts = { 0 };
+	struct reftable_stack *p;
+	int err;
+
+	p = reftable_calloc(1, sizeof(*p));
+	if (!p) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto out;
+	}
 
 	if (_opts)
 		opts = *_opts;
@@ -74,15 +80,23 @@ int reftable_new_stack(struct reftable_stack **dest, const char *dir,
 
 	p->list_file = strbuf_detach(&list_file_name, NULL);
 	p->list_fd = -1;
-	p->reftable_dir = xstrdup(dir);
 	p->opts = opts;
+	p->reftable_dir = reftable_strdup(dir);
+	if (!p->reftable_dir) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto out;
+	}
 
 	err = reftable_stack_reload_maybe_reuse(p, 1);
-	if (err < 0) {
+	if (err < 0)
+		goto out;
+
+	*dest = p;
+	err = 0;
+
+out:
+	if (err < 0)
 		reftable_stack_destroy(p);
-	} else {
-		*dest = p;
-	}
 	return err;
 }
 
@@ -171,6 +185,10 @@ void reftable_stack_destroy(struct reftable_stack *st)
 {
 	char **names = NULL;
 	int err = 0;
+
+	if (!st)
+		return;
+
 	if (st->merged) {
 		reftable_merged_table_free(st->merged);
 		st->merged = NULL;
-- 
2.46.0.551.gc5ee8f2d1c.dirty


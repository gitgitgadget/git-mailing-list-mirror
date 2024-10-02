Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4132020124D
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 10:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866571; cv=none; b=sFU58OkHYoj0DqiKQk0lpi3hccISHv79iTIKsMivCrYfQOPu7J+iNaCXR2qM0Tp4Hqsadhkok6e+aPVSF+o8Ua/MlfBxnzJSj/yxgBwBHssUzlxSFuKTzNyhuMMVrG8Tx7+UahH/O5WTjtXQUaXa6bEKfx5uzB8iqOdxxaWv4do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866571; c=relaxed/simple;
	bh=rCPp3mmeI9gScA9HsXOPA2dfgstO2NnDkNHyDkLDeu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmNHfzgIhzsZbcMRRFI30J/unhjJjjqdHWnwvVENtYwv0tEFTjOm8DgMz7vaoSktxT2YY539t8+ciZ/usV2phBsXttmm2dpes9ByX7dxZXZucF/+U62vVYybJVQMvKwmlVAV68YEL4vjLiwLhkp6H+fkaUlAsHobUNWzeuk8Xf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DUG0iObt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=deXRL1/n; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DUG0iObt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="deXRL1/n"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6F3EE114023A;
	Wed,  2 Oct 2024 06:56:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 02 Oct 2024 06:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727866568; x=1727952968; bh=wm7DXu2+fV
	PTxnBAEUkleoF1q3gPUSwhWEs6ZpuxEHA=; b=DUG0iObtmdDOar4DKkjt/RUumX
	TeCw8rSGCa4V4+oXg+OOXeI4pwfjfwVojLETR+XeClJVLCTZMjemecspiqVC8iyr
	oeQy7GfC8DVLWAqC3BPSUNXzGxv5LhXCLGrOjqJ1HnYb3uiTMnGorVV/hHSA1Z+X
	5ijBhQ/XFv0O38mIjtGk1BC+/jjPIt9TxOPUT4BIIu4p3pnXQFg2mgRJTjLAvwaT
	I6oc9zqzKpJ/tHucMxaC1R1CSR98WULQ71vbaJTGGNFVOBADqJbRtBSx4r2k4c9r
	xofIeaUXd/OXr3gKWrWfpbgIhH7U2OCAnInsltmQTAz8PpEnvkD8aRJH/frg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727866568; x=1727952968; bh=wm7DXu2+fVPTxnBAEUkleoF1q3gP
	USwhWEs6ZpuxEHA=; b=deXRL1/nIF3M//e+mxkG2pPeKTwLqP3t1ll4LtTV5nTa
	sYM63oAytSNbp2Esdy/Eu2y1Giv74lQ6lqGWzuxYh/DDO1CJJrsLhmex37TXnEEK
	Y8oY4RF+ZyVb7Gj388+LtTCXL5TGI6ff78VuqEAcHfMR+9GVjRlYMxqPD0v1cX44
	9XoTGImnnXM7l4S2iLzpuDhPp50e4Qe7W2zBdIHirMDh5KduHpXKwkQx3Tg8CKxH
	yp3Uf8lA75cwseDei2DUPwBGnXflyWVFXs8Lb2lSg27tcz0qDUM512Ha1/z5UGDG
	u8Htfe9AtADEix0J+uhXKuZaW8l5zq4JTYoiFdA6Lg==
X-ME-Sender: <xms:yCb9ZjBiKO-NQj50OC2RGLoddi872LqNLhsDg0405uVcfXlnI7Fvfw>
    <xme:yCb9ZpgKn4iRS7RzTTJaG-Gfwd_0kiw9fUN2IqMskXzvNCyzfaxaCTny6ZjLJYMm1
    dvP_8IfrN2kNmj9zA>
X-ME-Received: <xmr:yCb9ZulqvJojJTwH0Zc1x5Sa3clwO7v5KRWvZ0QMBG0ClLDsrHZNw0cGcJV_TyBl4hYa2TL30U47vpbg7bBjsE2-ysJQW9Va0EXz8fQJOKcgJUSU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheplhdrshdrrh
    esfigvsgdruggv
X-ME-Proxy: <xmx:yCb9ZlxH9gumaN39EvuHVld9n49tJF4wOqGObBvb3kKoDUruNb80Vg>
    <xmx:yCb9ZoTODCm38CWKnp2ChELkujj9DnX7UDbAYb0006nXnZLC2YN6xg>
    <xmx:yCb9ZoYilVYY1x7MGozdPUM6AxIckoAcd-XHFhXhg03nFhkuTRfEKA>
    <xmx:yCb9ZpSoqVRJMGaIdurT9QCmNp7u9-8drPpXXbvUJmgj39hmh461gg>
    <xmx:yCb9ZuM16Od-sapFtJ-ltARI5yPgF840CFdmJ3Re6l9bsip7oB9zsnzH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 06:56:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0c24042a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 10:55:17 +0000 (UTC)
Date: Wed, 2 Oct 2024 12:56:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v5 14/25] reftable/stack: handle allocation failures in
 `reftable_new_stack()`
Message-ID: <40d4d81378dbeffa0a916aca7d747ee9a045e045.1727866394.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727866394.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727866394.git.ps@pks.im>

Handle allocation failures in `reftable_new_stack()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 060b2c1b90..1b77c9d014 100644
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
2.47.0.rc0.dirty


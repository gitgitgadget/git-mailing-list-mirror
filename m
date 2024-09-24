Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E2B13790B
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 06:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727159560; cv=none; b=GSwh3qXeTH+TmiqDRzhYhBiKPvvwnZMGrWVqCeR4+J5w2HNJdKi0mlMp+pdGsAJ9jcYJsOzcqZjasZArztTMrO9kqIqvg1YSNI59G6NR+0GYjAQqlHAiGZmS7MiSNfcK1u063z70gubUB2SIlhZPXRwrwGpVlkZ8DYZMfuWL2AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727159560; c=relaxed/simple;
	bh=OY9C61FkcHlQQXu4trXRzGI+RySs2Y/YDle9yxxW0YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pf4NRfh23/4ygXuGYHIDvdtSzgnmWS6I+bKYnoj0s/er8K766Q+2bfkxKpkyoEefpZrQZp3LG1mJ80zkfj5jODmpICQo3Lf0PWm9ugo2uOdrZg30a41146bgTVAMWQk9tb84mbd7VS7pPnQBHVk3mVoj9RHk7q6N3xn51Znewdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VQ6SsFMg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NPyWPiAv; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VQ6SsFMg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NPyWPiAv"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id E352D13802E1;
	Tue, 24 Sep 2024 02:32:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 24 Sep 2024 02:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727159557; x=1727245957; bh=TesJB1AjF+
	+s+deMbqGkdD1eXm5H0XTm8LbGM/c05+Y=; b=VQ6SsFMgoe2l364T1FeyIlxVo3
	UR1YOZT3a2a++tbeXU/YZXd0ZO76WhPkEEAaNDHEkj69lL5YCeAC9zRnPQ8rP5WX
	X3IV5NsfLZfwf6zFzKBM7bQmAjw6MAUMYFjZ/qjIdTSlk1C+NGXajv4zi1VBuWke
	hUajnR7+q+aWbtRWF0qYYOgdNawG1I/ilyXC0Dbk3FvwOljnSwpKXW6VKiLFjCAD
	zh/O9+FeiUnp2IImawvfuZFZMvRp972V9OSm7VfoizLSUcU1moEpdnXU0DIek6D7
	PiEzm2h1f6t9mHoBR4RALJZ24mJ547cRe0kLqhO7kSNdXD9E/j0mQal1tA7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727159557; x=1727245957; bh=TesJB1AjF++s+deMbqGkdD1eXm5H
	0XTm8LbGM/c05+Y=; b=NPyWPiAvzEiJEJXlSBsp+NpocaRXNyqxerIE+R+nKA6d
	8tnh2p1dc9Bp4oaENiCJtpSycSas5Utz4s1oNvAZYxkd8O78SaobcsCEpQvWfMsV
	WW4Wiy+yjNMVwB1wnix7FTP1MMEescaSZt2Fafv7N8S19eGAkWK8/kYCTQkesGqy
	FH+kDqqnGPK9Gtt/wKAnGAfcYIwOCBhxf55MMNJTkjZVHiZKE7vs7SSPqqKiopI2
	fxaGxm2qpMnYDi5JRK3NNnJEdQPEbpWRHsk0BLggxvtMsb4PgcTfvLuF2qilr6Gt
	Gtl/Fi/E/8DZrg8M7SHLEo20JWpTcEPax/z/tT5/vA==
X-ME-Sender: <xms:BV3yZg114E6XyCQCL0hUcz7pRQX1KHJF8NVgyuTiifb6fURpeYpX4w>
    <xme:BV3yZrGgrbSXHp1oOxOZtQoLXceQLrnzcozYaiK1J2rtVgTMdgPwrVIULPxw5096E
    EQzcXpu_83Vf4oQkA>
X-ME-Received: <xmr:BV3yZo7J2IQHbyYiDXdrx3r6pq_b5iuCsTjcyxDjNyu1xAP4OZbfRuqHFK5IbvuavCJq2MnIhYh43v-rlsuEWZ-sVQQr8mp6XYZ7MyzC64ZTug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtuddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvghthhho
    mhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:BV3yZp3RLo34bssTAi2gq7pKrDC55DLZfjDUyVhab9jQdpViTt1RPQ>
    <xmx:BV3yZjESQsyPNyP-7atL8UBvrmPh_uhIUyYTP60xV6tGEJozcqkE_A>
    <xmx:BV3yZi9hjBhjzs8DKtN9mitUOqxs9aqzDxKXAyq82QeaiX-jnOwjfA>
    <xmx:BV3yZoksB19n1RxozR8EfXGQ5szioLrtJTUG_EKfWI3HASN7f9u7zw>
    <xmx:BV3yZrAd6HzjagiMvOtWeEN-NMr9wSHOn-XISdXTeMvvf2Ge6IQDDOWB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 02:32:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 18fe468e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 06:32:03 +0000 (UTC)
Date: Tue, 24 Sep 2024 08:32:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 13/22] reftable/stack: handle allocation failures on reload
Message-ID: <ca3b57f151ed8a2b318112fe1ea00e5d0cc00f8e.1727158127.git.ps@pks.im>
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

Handle allocation failures in `reftable_stack_reload_once()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index bb4d2309189..060b2c1b90d 100644
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
2.46.0.551.gc5ee8f2d1c.dirty


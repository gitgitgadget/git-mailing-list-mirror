Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2F81E0086
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 11:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738929138; cv=none; b=c3dfN/rjeNQefz+7PPNEmNKz36+sYFgD+ay4PdRZC1ELbrxckDTJX/dwYGUcjo2/CxcKLAvyLJpR8PB2khtnMY4eGxuUcKcWEu9mnBCEIq9TAzpidQJnTucQhnRT5oGvybCOG/mYfsiS34jdVuZYfxUJvp9KwkLWazlf7+de70Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738929138; c=relaxed/simple;
	bh=kPKuX8zhwCLYorG3555jZ8E4+OmEvwNW9Za2IYdBUhM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I3ABMsWMjRYGEF3QYsll73pGa9DOK2V85uo+JGonuHyVYCJo5bXuVC0GHNFDBgDc/U4VMpjG8OGEs70A4wVI8QfhjVCr0pMmfldTIMzHyqWcdXT6smohI8EOoRjY92KM+Hf8+yyPERwU0ywWhT9G78Dn6fDbyOgv+EdteC/Fyuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O6MAEb27; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kpTejGof; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O6MAEb27";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kpTejGof"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 7E9BA13801A7;
	Fri,  7 Feb 2025 06:52:13 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 07 Feb 2025 06:52:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738929133;
	 x=1739015533; bh=mM1aJiXiGx/mftefjDbbDUQyfUe75piBTX7KwSqp554=; b=
	O6MAEb27ocA5GmXhREVXWD5MzDV3XicSMlFLQ5SC7ncNgnIPuWehtWNJzo252p39
	4XcSa6sn+DgV88T+JsASNqyGrouHr6gkkJIb5gTvG/HDyqxObQLajFVvgp5FyNLL
	bDDoZiVTiyLY9EKQaxhMNgiQLHnsrLYEizeQ3L9ZmTIOItc3zy2+HjYgAWqUaqUq
	vvT97g9b0rPm3RZnNQAbBSQTpznL+QxiOFn51Uy50q5kSxDqEruq1extC/qooFY6
	ok3OW8w5IFuMb8acFnVATYd/Iho+7xeBc+G4X+VwfUGxvmu0vm7D+P+QQosdZQsI
	sqkygkqdVa2mEpyKupoj9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738929133; x=
	1739015533; bh=mM1aJiXiGx/mftefjDbbDUQyfUe75piBTX7KwSqp554=; b=k
	pTejGofGgZATxNQ0fk7gjZtCZjKLFllLLfLGiEdlRqi3mbPhSH5ihn4D1Vf7De2/
	Gncbst3qMayURTI5fPjQhJX9NyToFpicxF0CkPPymhwM4hczfkkcAGTmcSKKILn+
	NmhxsUPgV7yXYU5CENaqUkJ+vmBipXWlvAPxE6OMQLcTOkXyM/Rz9vYXnOKCHx3z
	C3FTcu5DDJ3Qi+K01ihvHZAl6VRV6w9jbSCGLRjsaxebSSPvuXE5f8wIXaobRsSV
	NvZazQ28riT9p60rGIdDolZSKcHoMZRPF9oszvS9LT91H/ggpOPEgictuCqizw0I
	wV8HZZomrZvU7+WX5UB3Q==
X-ME-Sender: <xms:7fOlZycJEDVUdbYBI4lPNXufM44JUH95pMVcc3Iu5gkV4hrGqwyNkg>
    <xme:7fOlZ8ML94lNmQLyzlsVSxrO4_GFURxX6XaJEhHff1ob6Vpd7NGS30NwEKoABFGzB
    XAIYWk1s2z3Bja8Mw>
X-ME-Received: <xmr:7fOlZziM5Zss60RGlpJbjAjxLaTxXAT-ZECV0K1JNksSOVexurnJN7xZPgjecg0SFjauB63s2_wz5cSGK7D0I767qRUCkA7bal-E87cLQJvMxdmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvghthhhomhhsohhnsegvug
    ifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepjheitheskhgusghgrdhorhhg
X-ME-Proxy: <xmx:7fOlZ_9vOrUBCBQlSH-80CE_17wEfZ59JJ98exnOryv2VtO96uKfIg>
    <xmx:7fOlZ-uN2EdFfgyphFbMdjxg-92fplAlykh2jZpZWqruc6bcCBdmjg>
    <xmx:7fOlZ2ErQEb8_l0xCuPT3GXtUJe6uzxmorBpRCSVWbgWhpXwFWMqow>
    <xmx:7fOlZ9MvVR4belGNeBNoH61FK5M1Lyq1G1CIXxD0YjnjDtP6hhCgow>
    <xmx:7fOlZwURjmzo1SleFek0kUK9wGahLMBPuIkAie-XFnB0345DFKLUfeL2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 06:52:12 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 09611234 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 11:52:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Feb 2025 12:52:02 +0100
Subject: [PATCH v5 07/18] reftable: stop using `BUG()` in trivial cases
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-pks-reftable-drop-git-compat-util-v5-7-ba2adc79110f@pks.im>
References: <20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im>
In-Reply-To: <20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.2

Stop using `BUG()` in the remaining trivial cases that we still have in
the reftable library. Instead of aborting the program, we'll now bubble
up a `REFTABLE_API_ERROR` to indicate misuse of the calling conventions.

Note that in both `reftable_reader_{inc,dec}ref()` we simply stop
calling `BUG()` altogether. The only situation where the counter should
be zero is when the structure has already been free'd anyway, so we
would run into undefined behaviour regardless of whether we try to abort
the program or not.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/iter.c   | 3 +--
 reftable/reader.c | 4 ----
 reftable/writer.c | 5 ++---
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/reftable/iter.c b/reftable/iter.c
index 86e801ca9f..b2ffb09c16 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -146,8 +146,7 @@ static int indexed_table_ref_iter_next_block(struct indexed_table_ref_iter *it)
 static int indexed_table_ref_iter_seek(void *p UNUSED,
 				       struct reftable_record *want UNUSED)
 {
-	BUG("seeking indexed table is not supported");
-	return -1;
+	return REFTABLE_API_ERROR;
 }
 
 static int indexed_table_ref_iter_next(void *p, struct reftable_record *rec)
diff --git a/reftable/reader.c b/reftable/reader.c
index de6e6dd932..36a5633ede 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -677,8 +677,6 @@ int reftable_reader_new(struct reftable_reader **out,
 
 void reftable_reader_incref(struct reftable_reader *r)
 {
-	if (!r->refcount)
-		BUG("cannot increment ref counter of dead reader");
 	r->refcount++;
 }
 
@@ -686,8 +684,6 @@ void reftable_reader_decref(struct reftable_reader *r)
 {
 	if (!r)
 		return;
-	if (!r->refcount)
-		BUG("cannot decrement ref counter of dead reader");
 	if (--r->refcount)
 		return;
 	block_source_close(&r->source);
diff --git a/reftable/writer.c b/reftable/writer.c
index 91d6629486..155863ee5f 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -158,7 +158,7 @@ int reftable_writer_new(struct reftable_writer **out,
 		opts = *_opts;
 	options_set_defaults(&opts);
 	if (opts.block_size >= (1 << 24))
-		BUG("configured block size exceeds 16MB");
+		return REFTABLE_API_ERROR;
 
 	reftable_buf_init(&wp->block_writer_data.last_key);
 	reftable_buf_init(&wp->last_key);
@@ -289,8 +289,7 @@ static int writer_add_record(struct reftable_writer *w,
 	}
 
 	if (block_writer_type(w->block_writer) != reftable_record_type(rec))
-		BUG("record of type %d added to writer of type %d",
-		    reftable_record_type(rec), block_writer_type(w->block_writer));
+		return REFTABLE_API_ERROR;
 
 	/*
 	 * Try to add the record to the writer. If this succeeds then we're

-- 
2.48.1.538.gc4cfc42d60.dirty


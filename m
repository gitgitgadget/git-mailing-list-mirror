Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BAE22FACA
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 09:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870525; cv=none; b=PunnPePmhKsBuzN6NzCeRE1KhZqUSqJ6gOusBucbN93UC2C3noJBot3cn8AVk5g6mfjNOOPtv7/Fkm8EnNsKFDcs76fdkqKQ2fGHYWn7s+hbOWDBnOlqnKuuzhh9e1blxl3JOfNmJ9GxG17gsveidFaZwXpcoRkXw3Pg09eONb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870525; c=relaxed/simple;
	bh=39kH17629G/QkT8hpGnEFK2Oa0Nd5CxixiSP7iGZlPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JHjU66xY0e/JaFaKUg5vJvTnLfRc5Dq2+ae8vLBA6jVesTpCh/WP0B5uxqfh52fcfG9NAwmwTx6E2B+++tKTTQ7qzq2Q3MvOXiWO3Mb8uXT7YuIbYPjAx1nuithh4/n2oNkGnL4JYGWrJxy79zUqPmiIPF3zC1E7xLLw4nJ83+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U8nURtSM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=viEzSmxv; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U8nURtSM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="viEzSmxv"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 88CFE1140276;
	Tue, 18 Feb 2025 04:22:01 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 18 Feb 2025 04:22:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739870521;
	 x=1739956921; bh=9rF6+By99ppSZWbgAwpyFrsv/hhDoRs7Q6m6HNHFP/4=; b=
	U8nURtSMu+nepcBzv6uS9DyxoQPvnyECPNdFIWHdkZTk/rMLcBnQVmebjEMoj46T
	lp6gAuVhUnpLTLFV/sHRwfsZ25OSpAHEYjLQHTeaGi4jKo1EcAU5ApuHT7e3SJsI
	QvRFYu+89Ys4lxCAHPJS5m4OuFMpHDP4LNwzDeTjHWdUFpM2oQFNNSnhK9edsMWd
	/RbY87KH6ElVSOzm/zoXtXlZFfgjQ2AfvXqQm78E4HcDIaV+BnTlM5Roc2xh40Lx
	2w8bPncCx5L9BnHqlXaT2m2wqpCNFo9Ge2T/28VW/stYPDcivDwXQHC6U1P5C275
	ZYj8JxuHGZamqWZctwM+Gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739870521; x=
	1739956921; bh=9rF6+By99ppSZWbgAwpyFrsv/hhDoRs7Q6m6HNHFP/4=; b=v
	iEzSmxvoXIV+/24gORewPV//3cy5oQyTD0JpfJJVeF0anMtk9ERnJ5rEtUZAPNts
	2gQhxOuKbHgrf2ehgX60Q7pkJ3ezx9pgPGHxFw8+CDJEAdoFgT+iMRMopMx0Eizv
	1d9jwBxXkcSSzdJgmtt1seCpjaZEx9eKiNBWOWA8WAf9xgY+nC7/k5mOc8xXXSZZ
	SVw1U1QcYDFJ7DGFGCDuBCfCcai4xjULQNjUxKrQCFWwljfoAhLGPWgyG5OPddm9
	9S4RG8zRU6hd/DW+fPHw+Qhx0HEYEv1e6REirpIBDgl1ZWGPg0pdoPhMgJH6dEQV
	f7NHsq/uiKlsrr4OYVi5Q==
X-ME-Sender: <xms:OVG0Z_jZz-BzxscNDVF0Rl3iLA70fJ1M1N8FIGwSNRrWEqzuYQ7sTQ>
    <xme:OVG0Z8C66r5gCvbAKfFypIh3flZqbpn-vguX_azzHlLLdAy6DFTTXkkij0bvB8cfw
    0vKeug-n2xkrhrOGw>
X-ME-Received: <xmr:OVG0Z_FbGs5w7MlFHiXBywSD8zdtlzKASJUHk5ThDaWJYqliGyKZhfxXm2ynVj8xFonWPA5CCJLTWAbfliqIym79dhzCiWzF4ft-SIwQl2QYbMZS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtoh
    epvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohep
    jhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:OVG0Z8QX43S0WFtpgTH6spuhUZRPmok-wHsXOVngnhtt8Vp6Ev9HGA>
    <xmx:OVG0Z8z6_uiLp1-djkTmm8nsw9wKAojgncG6rH601txV862qg3QrAg>
    <xmx:OVG0Zy6t2uZzXKac9dReX10-Ih8seCKl75OtxPlOScv8IBBwA0wGpg>
    <xmx:OVG0ZxyiuL-UrzwLuhFazERYLrJyUMGXuRjr9-wNGc75ChSQ2NreUA>
    <xmx:OVG0ZzmtRyTpkqHfL8yDg_jKqukZdD6KfR7zc3xPFoKS-iLAbO_QP3tl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 04:22:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ed639d64 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Feb 2025 09:21:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 18 Feb 2025 10:20:43 +0100
Subject: [PATCH v6 07/18] reftable: stop using `BUG()` in trivial cases
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-pks-reftable-drop-git-compat-util-v6-7-8c1f39fb4c02@pks.im>
References: <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>
In-Reply-To: <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
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
index 86e801ca9fb..b2ffb09c16b 100644
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
index de6e6dd9322..36a5633eded 100644
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
index f3ab1035d61..239573ade24 100644
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
@@ -302,8 +302,7 @@ static int writer_add_record(struct reftable_writer *w,
 	}
 
 	if (block_writer_type(w->block_writer) != reftable_record_type(rec))
-		BUG("record of type %d added to writer of type %d",
-		    reftable_record_type(rec), block_writer_type(w->block_writer));
+		return REFTABLE_API_ERROR;
 
 	/*
 	 * Try to add the record to the writer. If this succeeds then we're

-- 
2.48.1.666.gff9fcf71b7.dirty


Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B99219E7E5
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 09:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775735; cv=none; b=Qol70k2KSmWpi5Krj5xHtkhfhJAQDui/GwLWZxDaEqknouZYRuvXrGau/UBhgutMmmVfEiA/MsOJY6TAgMTZQQGF0ISueqGnUx0f7FVXBWPRmFimyXjUnlS6ZvctD+D0JsEO/y682a4nIWr3RBlvk7zqxqSrx/+DEdUQJQ7sLUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775735; c=relaxed/simple;
	bh=GMJ2R7EhbZ26MLb5z+CojS8kmfNu9cVTUleCA0frbBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAbvRjNUXJi2Fxp2R0R8iZCp/NZP6U5hjO9o56KOJJoyjd+fsYpOUFy2SKL/oDarWGBk5bKa45+bY2qUqUZoAe2yOfAI6N7CPa0ti0gX/+euk53xkGvvnQYhDxzcZcz4Rzm9EiNGtEkzZ7GwgCiwCqWKW5ZPXkB215ZWKcm2Yp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sIZnsrZo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oi99y3rG; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sIZnsrZo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oi99y3rG"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 694001140CBF;
	Tue,  1 Oct 2024 05:42:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 01 Oct 2024 05:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727775733; x=1727862133; bh=aht2XUEGSS
	gPFBhLVI+VpgVavEh2Ds/RKUhJijGak4U=; b=sIZnsrZoGhv/d3jx7drIgqCOf5
	2xcgdUETQFeFb7Cnjj8Te5BEMLhicz94RdMPB7J2QjeegDOHfPbbUbJHIS7hjAlp
	CKQ6fkwrfgPqeUZ5trxlEEiHLltCuyEY/SjL30hGKthzbSQuDDVZxkf9YGwwO15+
	W752qY674dKnChUleZEbIq/F2I/uS1Bx7J1tDNaAqgZxVM3iw1DdNi+7zAniaIeh
	HP3HLrVZn9SPoiZD4hUeAkf2FanR/LNdWT5/XNgAG6Pengbhbj8iey6SBxjf1CXh
	R4M1KArRCAYpyULRaKrGtb5EvEdlTP4vgp+8ASK7PSM14W+mwcjqr/Ru36dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727775733; x=1727862133; bh=aht2XUEGSSgPFBhLVI+VpgVavEh2
	Ds/RKUhJijGak4U=; b=oi99y3rGkSIHt6PWpSYsGxSbd2c+oVXMEtRhmwVDraaV
	u+XX9dqwKpQ7whhqlRm6bHkFEdAahOzcLuWwxNqSUvW89OyTnHSkUK3t29cmz2l9
	R69ak4VkJGxcFaxpu2daP0/hXIUqPZxzWvyNwd1uynxDhfHoux9fsHxx54R/TkcJ
	BuuV3MhlWhsKrioi8gBZ2cKPOJPMu265HnpCjxZ7ZBeb8NmrnO6v0UB/n3Lqlr77
	E3qe/JoyeIowypiB5yOQZbU4VobwE49LIOIeqawplL2D0/7XATJd6jPaBKZTN67o
	VhXiP3R+m5y2laEOcRj4RhPuUQs9y6WCqFGse8Zm0A==
X-ME-Sender: <xms:9cP7Zv9gJL93AXekb0qgOxbVRL4H1skjBqSxG6t0IBuPHkAH9szVcg>
    <xme:9cP7ZruCrOZRRU-coDEvHjSyPYf5hXkhP1iXegjF6IUUe_LT4Bmh4ln1OEX8ljik7
    BPDEOP9E6qybPLUuQ>
X-ME-Received: <xmr:9cP7ZtADrNoEdipTS2s55d89URwTUsMZ3u-giPKHKisWIHLd94gDYnprui2m_QUVM1ELRuImRlzMbSw1IaDya7ptHe_Xumf3qXWUg2S_6NIiGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhdrshdrrh
    esfigvsgdruggv
X-ME-Proxy: <xmx:9cP7ZrfrTc-QVRQomZowWbkXlKg7htmlZOg1Dwzrn3XhCHHyCQHDaA>
    <xmx:9cP7ZkOL64BQzcrM7rGnFMG68yHBS5B0VY_2rJq4H-rslz-RJYzJRw>
    <xmx:9cP7ZtkZE4AFHTToKbZvQ_NxAoUZ1gus3Xo19gSRtx1UOTK92wts4Q>
    <xmx:9cP7ZuuIBCYHq0jyBaJTcHy45CF956DU0-gyDFjPnZgBnrqX3WuLgw>
    <xmx:9cP7ZhoqiMsb-T660yzehUNvq8ANiiZwzmel8QxA7_nrIpNqobDa-HlU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 05:42:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 42aab48a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Oct 2024 09:41:24 +0000 (UTC)
Date: Tue, 1 Oct 2024 11:42:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v4 09/25] reftable/writer: handle allocation failures in
 `reftable_new_writer()`
Message-ID: <0ed99e0bdf19fa1e396312b79acf47e9ba8e6ae5.1727774935.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727774935.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727774935.git.ps@pks.im>

Handle allocation failures in `reftable_new_writer()`. Adapt the
function to return an error code to return such failures. While at it,
rename it to match our code style as we have to touch up every callsite
anyway.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reftable-writer.h  | 12 +++++++-----
 reftable/stack.c            | 14 ++++++++++----
 reftable/writer.c           | 22 ++++++++++++++++------
 t/unit-tests/lib-reftable.c |  8 +++++---
 4 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
index 189b1f4144..43623dc7c3 100644
--- a/reftable/reftable-writer.h
+++ b/reftable/reftable-writer.h
@@ -90,11 +90,13 @@ struct reftable_stats {
 	int object_id_len;
 };
 
-/* reftable_new_writer creates a new writer */
-struct reftable_writer *
-reftable_new_writer(ssize_t (*writer_func)(void *, const void *, size_t),
-		    int (*flush_func)(void *),
-		    void *writer_arg, const struct reftable_write_options *opts);
+struct reftable_writer;
+
+/* Create a new writer. */
+int reftable_writer_new(struct reftable_writer **out,
+			ssize_t (*writer_func)(void *, const void *, size_t),
+			int (*flush_func)(void *),
+			void *writer_arg, const struct reftable_write_options *opts);
 
 /* Set the range of update indices for the records we will add. When writing a
    table into a stack, the min should be at least
diff --git a/reftable/stack.c b/reftable/stack.c
index 498fae846d..ea21ca6e5f 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -808,8 +808,11 @@ int reftable_addition_add(struct reftable_addition *add,
 	}
 	tab_fd = get_tempfile_fd(tab_file);
 
-	wr = reftable_new_writer(reftable_fd_write, reftable_fd_flush, &tab_fd,
-				 &add->stack->opts);
+	err = reftable_writer_new(&wr, reftable_fd_write, reftable_fd_flush,
+				  &tab_fd, &add->stack->opts);
+	if (err < 0)
+		goto done;
+
 	err = write_table(wr, arg);
 	if (err < 0)
 		goto done;
@@ -898,8 +901,11 @@ static int stack_compact_locked(struct reftable_stack *st,
 		goto done;
 	}
 
-	wr = reftable_new_writer(reftable_fd_write, reftable_fd_flush,
-				 &tab_fd, &st->opts);
+	err = reftable_writer_new(&wr, reftable_fd_write, reftable_fd_flush,
+				  &tab_fd, &st->opts);
+	if (err < 0)
+		goto done;
+
 	err = stack_write_compact(st, wr, first, last, config);
 	if (err < 0)
 		goto done;
diff --git a/reftable/writer.c b/reftable/writer.c
index ed61aaf59c..8ab2e916d3 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -117,13 +117,17 @@ static void writer_reinit_block_writer(struct reftable_writer *w, uint8_t typ)
 	w->block_writer->restart_interval = w->opts.restart_interval;
 }
 
-struct reftable_writer *
-reftable_new_writer(ssize_t (*writer_func)(void *, const void *, size_t),
-		    int (*flush_func)(void *),
-		    void *writer_arg, const struct reftable_write_options *_opts)
+int reftable_writer_new(struct reftable_writer **out,
+			ssize_t (*writer_func)(void *, const void *, size_t),
+			int (*flush_func)(void *),
+			void *writer_arg, const struct reftable_write_options *_opts)
 {
-	struct reftable_writer *wp = reftable_calloc(1, sizeof(*wp));
 	struct reftable_write_options opts = {0};
+	struct reftable_writer *wp;
+
+	wp = reftable_calloc(1, sizeof(*wp));
+	if (!wp)
+		return REFTABLE_OUT_OF_MEMORY_ERROR;
 
 	if (_opts)
 		opts = *_opts;
@@ -134,13 +138,19 @@ reftable_new_writer(ssize_t (*writer_func)(void *, const void *, size_t),
 	strbuf_init(&wp->block_writer_data.last_key, 0);
 	strbuf_init(&wp->last_key, 0);
 	REFTABLE_CALLOC_ARRAY(wp->block, opts.block_size);
+	if (!wp->block) {
+		reftable_free(wp);
+		return REFTABLE_OUT_OF_MEMORY_ERROR;
+	}
 	wp->write = writer_func;
 	wp->write_arg = writer_arg;
 	wp->opts = opts;
 	wp->flush = flush_func;
 	writer_reinit_block_writer(wp, BLOCK_TYPE_REF);
 
-	return wp;
+	*out = wp;
+
+	return 0;
 }
 
 void reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
diff --git a/t/unit-tests/lib-reftable.c b/t/unit-tests/lib-reftable.c
index ab1fa44a28..54c26c43e7 100644
--- a/t/unit-tests/lib-reftable.c
+++ b/t/unit-tests/lib-reftable.c
@@ -22,9 +22,11 @@ static int strbuf_writer_flush(void *arg UNUSED)
 struct reftable_writer *t_reftable_strbuf_writer(struct strbuf *buf,
 						 struct reftable_write_options *opts)
 {
-	return reftable_new_writer(&strbuf_writer_write,
-				   &strbuf_writer_flush,
-				   buf, opts);
+	struct reftable_writer *writer;
+	int ret = reftable_writer_new(&writer, &strbuf_writer_write, &strbuf_writer_flush,
+				      buf, opts);
+	check(!ret);
+	return writer;
 }
 
 void t_reftable_write_to_buf(struct strbuf *buf,
-- 
2.47.0.rc0.dirty


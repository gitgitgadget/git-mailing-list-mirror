Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523BE1586F2
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 12:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489737; cv=none; b=A1892JFP9usfctlfF1CDp/czge7aRGo9iYRKuMydtyXdRNHx4LbCkqjgSSOCgKa7OZ9Y4H3KTMdd/1UVPGf5fQyi8qvl2RmNoEe6agM0v2SfpG5CSPjGhkRli0u7kL8KTx2luiUpzdbLcy71i4cUoBDdKCDhw/eE15mSIavP8ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489737; c=relaxed/simple;
	bh=LojdcDu0aO6hQO7xTKSb9r2jZgQYWkfK98COZOazDxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnyXVxaM88RPQjQR3JGvxF1enUXB/8LEdmjdIkGgbvB9H44GNsDGf5HJqZFUzl/b87Msotu8cseNmtZBaeFX2OsY7n4AE8ag18hSOaDbHZ0w94q2bBZKyqrMv+/clSfd/dIf16vsR0fznKbkPR4qyIMSjnTTMr1yBPdTcgMCKEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CVnOKgFx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WW8DeF3E; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CVnOKgFx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WW8DeF3E"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A7F451140125;
	Mon, 16 Sep 2024 08:28:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 16 Sep 2024 08:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726489734; x=1726576134; bh=zuowZxWlJr
	a8DCqwR/8rjKO9FRdrzhTu4lSG7GTklI8=; b=CVnOKgFxLyJd7jkfdV/FaXLSV6
	xZHU1gLN2morgM9Vz6tbfVFc06fADFsGvySosN/m9bfYWUn4hPeKAugHLKqFaRnr
	XqGzd36aEO89NJTxNcMUu0MgjhlCRd+ksuNlslbBwRy8WYTt9VqnPdWFN7fYJuFa
	FwPAnO57xE01Q6Nt0qE6foZ/LFQ09NSCRCCsW3dxPYfm9Maq98nW5/Z56cJEWKly
	SGdlNisQZTJJsxQAW4nctdjXUQHQgLWiqFD2YsxuJikLMI5HMFK9ImMbU5ypdJ02
	laY8w6KtpybtIUpaBzt4J8YXO7Si7SHmNSUxdCb0q5hK4M5qlRLCuGnu+sUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726489734; x=1726576134; bh=zuowZxWlJra8DCqwR/8rjKO9FRdr
	zhTu4lSG7GTklI8=; b=WW8DeF3EFpjDBran6xPUBYkxomEK5xRMv/VtEGrv9J4d
	DyyMH2rH4evt8cy6nYHxXriv5fQd5f44TkkCX2PJHrFU9WV7hMJ13NNaSZJjc3wL
	nFv2bDh8HrffQ8gordjxlhAUJvFoB/afRz0ENkabZ6wUu+GBukf40BK9uIuLIKnz
	DT6OsflHjdB9YTr365Wbd3FEaG0KJZ9dxLMPAKxvwpS7Ldf0+ShpDJ+DlpvixcIX
	oavjhCMIodEwjGghWgpSD2VqmD7od6z/RYLMcecR/rQV0aRDog3Soke95V3Cchuw
	TIQh2u0Tajx/sxc9yjBt/JwUWibGYEZet7i5G6H6pg==
X-ME-Sender: <xms:hiToZuGy8DzoMSjXOZfLXr7Z6hW0coqxb7yWACO1LAfIbTiZygHJvw>
    <xme:hiToZvVrlIAJB_CnIZ2tFABhx-lU0UwOZK7P201lsirWNBwmTp5SIweW7plifsHt5
    dNSOqHH4lqyij4EAQ>
X-ME-Received: <xmr:hiToZoJtbAvhV05INeNNiVGzcosxkzxjdpuawTDZ8mmDVLRORuTNwtrrR9zOFY64KCNUq25VBGLHnRgnnv-aF-wSc2-IwE5foILlulfDG-jIO30i>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:hiToZoHYSDzQQtvjmUX2PXjW9IvMBR-4B9c2cGAV33kzLGuNUdsOQg>
    <xmx:hiToZkXZt85713uydg60EZR5r4izJOWm88tP8m-9xjmChBBhzH9WDA>
    <xmx:hiToZrMc_tOJCupL2ebPj21-u2dBUU71sUkHYUOdOMqpRsPYnt5uOw>
    <xmx:hiToZr2bnLKFFzeeoec29zrmwORtRrgYRZEwlrDglkyYl4q2_NP22Q>
    <xmx:hiToZhjqaNRMpKTshm5j9hAWtrW1Nki374se5328bR1E_BCg4HdON9NU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 08:28:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c9edfa03 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 12:28:36 +0000 (UTC)
Date: Mon, 16 Sep 2024 14:28:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 12/22] reftable/reader: handle allocation failures in
 `reader_init_iter()`
Message-ID: <94c85ffd5ec6a508f8c8c6d2ca30760a8a3614de.1726489647.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726489647.git.ps@pks.im>

Handle allocation failures in `reader_init_iter()`. This requires us to
also adapt `reftable_reader_init_*_iterator()` to bubble up the new
error codes. Adapt callers accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c                   |  4 +++-
 reftable/reader.c                   | 28 +++++++++++++++---------
 reftable/reader.h                   |  6 ++---
 reftable/reftable-reader.h          |  8 +++----
 t/unit-tests/t-reftable-readwrite.c | 34 +++++++++++++++++++----------
 5 files changed, 50 insertions(+), 30 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index 5a8ea8ae779..741f62ea638 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -244,7 +244,9 @@ int merged_table_init_iter(struct reftable_merged_table *mt,
 
 	for (size_t i = 0; i < mt->readers_len; i++) {
 		reftable_record_init(&subiters[i].rec, typ);
-		reader_init_iter(mt->readers[i], &subiters[i].iter, typ);
+		ret = reader_init_iter(mt->readers[i], &subiters[i].iter, typ);
+		if (ret < 0)
+			goto out;
 	}
 
 	REFTABLE_CALLOC_ARRAY(mi, 1);
diff --git a/reftable/reader.c b/reftable/reader.c
index 485ee085dac..f696e992dfc 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -554,32 +554,37 @@ static void iterator_from_table_iter(struct reftable_iterator *it,
 	it->ops = &table_iter_vtable;
 }
 
-void reader_init_iter(struct reftable_reader *r,
-		      struct reftable_iterator *it,
-		      uint8_t typ)
+int reader_init_iter(struct reftable_reader *r,
+		     struct reftable_iterator *it,
+		     uint8_t typ)
 {
 	struct reftable_reader_offsets *offs = reader_offsets_for(r, typ);
 
 	if (offs->is_present) {
 		struct table_iter *ti;
 		REFTABLE_ALLOC_ARRAY(ti, 1);
+		if (!ti)
+			return REFTABLE_OUT_OF_MEMORY_ERROR;
+
 		table_iter_init(ti, r);
 		iterator_from_table_iter(it, ti);
 	} else {
 		iterator_set_empty(it);
 	}
+
+	return 0;
 }
 
-void reftable_reader_init_ref_iterator(struct reftable_reader *r,
-				       struct reftable_iterator *it)
+int reftable_reader_init_ref_iterator(struct reftable_reader *r,
+				      struct reftable_iterator *it)
 {
-	reader_init_iter(r, it, BLOCK_TYPE_REF);
+	return reader_init_iter(r, it, BLOCK_TYPE_REF);
 }
 
-void reftable_reader_init_log_iterator(struct reftable_reader *r,
-				       struct reftable_iterator *it)
+int reftable_reader_init_log_iterator(struct reftable_reader *r,
+				      struct reftable_iterator *it)
 {
-	reader_init_iter(r, it, BLOCK_TYPE_LOG);
+	return reader_init_iter(r, it, BLOCK_TYPE_LOG);
 }
 
 int reftable_reader_new(struct reftable_reader **out,
@@ -689,7 +694,10 @@ static int reftable_reader_refs_for_indexed(struct reftable_reader *r,
 	struct indexed_table_ref_iter *itr = NULL;
 
 	/* Look through the reverse index. */
-	reader_init_iter(r, &oit, BLOCK_TYPE_OBJ);
+	err = reader_init_iter(r, &oit, BLOCK_TYPE_OBJ);
+	if (err < 0)
+		goto done;
+
 	err = iterator_seek(&oit, &want);
 	if (err != 0)
 		goto done;
diff --git a/reftable/reader.h b/reftable/reader.h
index 3710ee09b4c..02d10c5d37e 100644
--- a/reftable/reader.h
+++ b/reftable/reader.h
@@ -56,9 +56,9 @@ struct reftable_reader {
 
 const char *reader_name(struct reftable_reader *r);
 
-void reader_init_iter(struct reftable_reader *r,
-		      struct reftable_iterator *it,
-		      uint8_t typ);
+int reader_init_iter(struct reftable_reader *r,
+		     struct reftable_iterator *it,
+		     uint8_t typ);
 
 /* initialize a block reader to read from `r` */
 int reader_init_block_reader(struct reftable_reader *r, struct block_reader *br,
diff --git a/reftable/reftable-reader.h b/reftable/reftable-reader.h
index a600452b565..6a2d0b693f5 100644
--- a/reftable/reftable-reader.h
+++ b/reftable/reftable-reader.h
@@ -46,12 +46,12 @@ void reftable_reader_incref(struct reftable_reader *reader);
 void reftable_reader_decref(struct reftable_reader *reader);
 
 /* Initialize a reftable iterator for reading refs. */
-void reftable_reader_init_ref_iterator(struct reftable_reader *r,
-				       struct reftable_iterator *it);
+int reftable_reader_init_ref_iterator(struct reftable_reader *r,
+				      struct reftable_iterator *it);
 
 /* Initialize a reftable iterator for reading logs. */
-void reftable_reader_init_log_iterator(struct reftable_reader *r,
-				       struct reftable_iterator *it);
+int reftable_reader_init_log_iterator(struct reftable_reader *r,
+				      struct reftable_iterator *it);
 
 /* returns the hash ID used in this table. */
 uint32_t reftable_reader_hash_id(struct reftable_reader *r);
diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
index e1b235a5f13..acca927a2cf 100644
--- a/t/unit-tests/t-reftable-readwrite.c
+++ b/t/unit-tests/t-reftable-readwrite.c
@@ -206,7 +206,8 @@ static void t_log_write_read(void)
 	err = reftable_reader_new(&reader, &source, "file.log");
 	check(!err);
 
-	reftable_reader_init_ref_iterator(reader, &it);
+	err = reftable_reader_init_ref_iterator(reader, &it);
+	check(!err);
 
 	err = reftable_iterator_seek_ref(&it, names[N - 1]);
 	check(!err);
@@ -221,8 +222,8 @@ static void t_log_write_read(void)
 	reftable_iterator_destroy(&it);
 	reftable_ref_record_release(&ref);
 
-	reftable_reader_init_log_iterator(reader, &it);
-
+	err = reftable_reader_init_log_iterator(reader, &it);
+	check(!err);
 	err = reftable_iterator_seek_log(&it, "");
 	check(!err);
 
@@ -296,7 +297,8 @@ static void t_log_zlib_corruption(void)
 	err = reftable_reader_new(&reader, &source, "file.log");
 	check(!err);
 
-	reftable_reader_init_log_iterator(reader, &it);
+	err = reftable_reader_init_log_iterator(reader, &it);
+	check(!err);
 	err = reftable_iterator_seek_log(&it, "refname");
 	check_int(err, ==, REFTABLE_ZLIB_ERROR);
 
@@ -325,7 +327,8 @@ static void t_table_read_write_sequential(void)
 	err = reftable_reader_new(&reader, &source, "file.ref");
 	check(!err);
 
-	reftable_reader_init_ref_iterator(reader, &it);
+	err = reftable_reader_init_ref_iterator(reader, &it);
+	check(!err);
 	err = reftable_iterator_seek_ref(&it, "");
 	check(!err);
 
@@ -376,7 +379,8 @@ static void t_table_read_api(void)
 	err = reftable_reader_new(&reader, &source, "file.ref");
 	check(!err);
 
-	reftable_reader_init_ref_iterator(reader, &it);
+	err = reftable_reader_init_ref_iterator(reader, &it);
+	check(!err);
 	err = reftable_iterator_seek_ref(&it, names[0]);
 	check(!err);
 
@@ -419,7 +423,8 @@ static void t_table_read_write_seek(int index, int hash_id)
 	}
 
 	for (i = 1; i < N; i++) {
-		reftable_reader_init_ref_iterator(reader, &it);
+		err = reftable_reader_init_ref_iterator(reader, &it);
+		check(!err);
 		err = reftable_iterator_seek_ref(&it, names[i]);
 		check(!err);
 		err = reftable_iterator_next_ref(&it, &ref);
@@ -435,7 +440,8 @@ static void t_table_read_write_seek(int index, int hash_id)
 	strbuf_addstr(&pastLast, names[N - 1]);
 	strbuf_addstr(&pastLast, "/");
 
-	reftable_reader_init_ref_iterator(reader, &it);
+	err = reftable_reader_init_ref_iterator(reader, &it);
+	check(!err);
 	err = reftable_iterator_seek_ref(&it, pastLast.buf);
 	if (err == 0) {
 		struct reftable_ref_record ref = { 0 };
@@ -534,7 +540,8 @@ static void t_table_refs_for(int indexed)
 	if (!indexed)
 		reader->obj_offsets.is_present = 0;
 
-	reftable_reader_init_ref_iterator(reader, &it);
+	err = reftable_reader_init_ref_iterator(reader, &it);
+	check(!err);
 	err = reftable_iterator_seek_ref(&it, "");
 	check(!err);
 	reftable_iterator_destroy(&it);
@@ -593,7 +600,8 @@ static void t_write_empty_table(void)
 	err = reftable_reader_new(&rd, &source, "filename");
 	check(!err);
 
-	reftable_reader_init_ref_iterator(rd, &it);
+	err = reftable_reader_init_ref_iterator(rd, &it);
+	check(!err);
 	err = reftable_iterator_seek_ref(&it, "");
 	check(!err);
 
@@ -802,7 +810,8 @@ static void t_write_multiple_indices(void)
 	 * Seeking the log uses the log index now. In case there is any
 	 * confusion regarding indices we would notice here.
 	 */
-	reftable_reader_init_log_iterator(reader, &it);
+	err = reftable_reader_init_log_iterator(reader, &it);
+	check(!err);
 	err = reftable_iterator_seek_log(&it, "");
 	check(!err);
 
@@ -858,7 +867,8 @@ static void t_write_multi_level_index(void)
 	/*
 	 * Seeking the last ref should work as expected.
 	 */
-	reftable_reader_init_ref_iterator(reader, &it);
+	err = reftable_reader_init_ref_iterator(reader, &it);
+	check(!err);
 	err = reftable_iterator_seek_ref(&it, "refs/heads/199");
 	check(!err);
 
-- 
2.46.0.551.gc5ee8f2d1c.dirty


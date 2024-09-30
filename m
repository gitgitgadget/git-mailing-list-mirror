Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337A9175D25
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 08:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683746; cv=none; b=UOw5F8lmAcf42kLbOVf6A3cP2SjXhStybh06CLBDMQZ9+oqo77wLIj7+t3hccHTyf4SQOY9vxarqPne6ffH8zBLKGuloqkuZ3hOiBRkePBC3J6LOcjz5zJk6e2qcksdhzX1q6pgXZaz9DKy1FKX4L6i5xtpXjQfT7GlpuudS2gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683746; c=relaxed/simple;
	bh=huXf7fk6asWp4TN68q1TXgyyxDSwWGTppz1jr9T7jag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAJIp351HP3Ag+s30FEoQbrRrjd557KoJ2QQU0B3GBkO4m/vFT2urc9D/ApZz/m0QpPxVdClpO1pLkBsR5rUeqC/svWnbjvZgB/zGAVshkHFN+JtvtZLhlGe6cE7vmXY+OF7gUcOHeuP656nlAI69xpVrwKvGJCY+RuOXGY85I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R5JPQkqj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WHHfLW0P; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R5JPQkqj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WHHfLW0P"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4C4E71140216;
	Mon, 30 Sep 2024 04:09:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 30 Sep 2024 04:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727683744; x=1727770144; bh=Molk8Eff82
	9LR6e6O2wqhH1kBGxjYLkPKRcUJiTkVSU=; b=R5JPQkqjXPG3dfOSZ9XrqFofIg
	uINyD4WWF55MXopc4b+3a66o1AIF9PNRDw1s6BQ4OyOZlFVa6spa/MWVOEdKf4Z8
	3TPqm//QeuSHXC3Pw2Hrit89e8Yt6qEhC6eWQHIoFeCNfOGkpbXRM9AhK3RtEdEN
	s3BYiH/GvEvTDfv7rmDixc63jrEp18afdfafR4D3G/oXAenk/usXsSrXNW6B6Z54
	Zij5RZJLUGrCIEsfP9W4kWfpts9dNjwSme+Axy/9rcV1qo/b/b3T1OuKefppdfs8
	SjtclhTSIWVm2EJkiyJLNdbtgnfI0BWFW/4pMI3sJr1JvRu3CEqNEYMxDP9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727683744; x=1727770144; bh=Molk8Eff829LR6e6O2wqhH1kBGxj
	YLkPKRcUJiTkVSU=; b=WHHfLW0P5zVZoTko8+90oaECpfr+GjP5r0bYiiQxLAoN
	ppFxv8zMR6+n92agKsyKP5DlZpIXBEw6M5+FCbsDT/DrpKQoSgIRRXYIa3k/obKl
	fiTQ7z2fO91Yr3bkiNzAzA7ADvLtvStskjYa9ssBAWNO0fQDUcf/eTmagGRWw38p
	b7ycLWagb7+VOfxnspBR3AAlxdEWXgKEtYkO+JlRl6myy+uaEvVT8dbRcO464YEe
	wcTEi/4pA3R4iuQO7zyMXMV1v5z+zAJn1IKW6lcmFbfEPBJjOuVp9J8QYevddk5l
	Ugb/WqztpYbAE/zjQ40ZxHwVz0sJnMaRIEhEpartwg==
X-ME-Sender: <xms:oFz6ZnxHb_zGBgP27CJmhEfBltgIFCImdYlG1MHslf_0tEtE3alkww>
    <xme:oFz6ZvTz4CvvYTtNeUYP-o0TrqHiAlv3ZMa8CH30Nat6lw9vG4d-PYWcyqHt_PSyJ
    0jG03-Okiwbnw4QPQ>
X-ME-Received: <xmr:oFz6ZhVvRT7cudgyEvhOsLKsjbWhwuzwClPw2vjzt4dKtQAn35nYOWF0PDbtGHOntL_p4ji_igdEOS9BZYB5MeusGZ9U5vEFxIaG9xHUjumSuSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddugedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmsh
    honhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehlrdhsrd
    hrseifvggsrdguvg
X-ME-Proxy: <xmx:oFz6ZhiWnMdWQrXRTkg6Wjk7SyCp_1Uew543qdsa1hBcwkwaAVamsg>
    <xmx:oFz6ZpA86RZf6LFx11M9PiCqk8BwtJjfmvqVWWGTNOpQlXZOfEDzRg>
    <xmx:oFz6ZqLFXoPqBSk1o7Lc0LdbHFYeS3F9sV53RrPk5rM4Tr5uV94_hw>
    <xmx:oFz6ZoBD3zQWbJnLKSeZ265bDtVAuDO1ndquv47of_pnhKyx7YNgbg>
    <xmx:oFz6Zk_CJRLI4yaZF3qqtF46mWv7Du0FsYNgGVbSvQ9BQZNq6TTMKQDB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 04:09:03 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2d342ff4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Sep 2024 08:08:17 +0000 (UTC)
Date: Mon, 30 Sep 2024 10:09:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 17/22] reftable/iter: handle allocation failures when
 creating indexed table iter
Message-ID: <620658bffcc0570410fb2299c568f7c285a91336.1727680272.git.ps@pks.im>
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

Handle allocation failures in `new_indexed_table_ref_iter()`. While at
it, rename the function to match our coding style.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/iter.c   | 20 ++++++++++++++++----
 reftable/iter.h   |  2 +-
 reftable/reader.c |  7 ++++++-
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/reftable/iter.c b/reftable/iter.c
index 416a9f6996..d319538f80 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -181,14 +181,20 @@ static int indexed_table_ref_iter_next(void *p, struct reftable_record *rec)
 	}
 }
 
-int new_indexed_table_ref_iter(struct indexed_table_ref_iter **dest,
+int indexed_table_ref_iter_new(struct indexed_table_ref_iter **dest,
 			       struct reftable_reader *r, uint8_t *oid,
 			       int oid_len, uint64_t *offsets, int offset_len)
 {
 	struct indexed_table_ref_iter empty = INDEXED_TABLE_REF_ITER_INIT;
-	struct indexed_table_ref_iter *itr = reftable_calloc(1, sizeof(*itr));
+	struct indexed_table_ref_iter *itr;
 	int err = 0;
 
+	itr = reftable_calloc(1, sizeof(*itr));
+	if (!itr) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto out;
+	}
+
 	*itr = empty;
 	itr->r = r;
 	strbuf_add(&itr->oid, oid, oid_len);
@@ -197,10 +203,16 @@ int new_indexed_table_ref_iter(struct indexed_table_ref_iter **dest,
 	itr->offset_len = offset_len;
 
 	err = indexed_table_ref_iter_next_block(itr);
+	if (err < 0)
+		goto out;
+
+	*dest = itr;
+	err = 0;
+
+out:
 	if (err < 0) {
+		*dest = NULL;
 		reftable_free(itr);
-	} else {
-		*dest = itr;
 	}
 	return err;
 }
diff --git a/reftable/iter.h b/reftable/iter.h
index befc4597df..b3225bc7ad 100644
--- a/reftable/iter.h
+++ b/reftable/iter.h
@@ -82,7 +82,7 @@ void iterator_from_indexed_table_ref_iter(struct reftable_iterator *it,
 					  struct indexed_table_ref_iter *itr);
 
 /* Takes ownership of `offsets` */
-int new_indexed_table_ref_iter(struct indexed_table_ref_iter **dest,
+int indexed_table_ref_iter_new(struct indexed_table_ref_iter **dest,
 			       struct reftable_reader *r, uint8_t *oid,
 			       int oid_len, uint64_t *offsets, int offset_len);
 
diff --git a/reftable/reader.c b/reftable/reader.c
index f696e992df..0179e4e73d 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -715,7 +715,7 @@ static int reftable_reader_refs_for_indexed(struct reftable_reader *r,
 		goto done;
 	}
 
-	err = new_indexed_table_ref_iter(&itr, r, oid, hash_size(r->hash_id),
+	err = indexed_table_ref_iter_new(&itr, r, oid, hash_size(r->hash_id),
 					 got.u.obj.offsets,
 					 got.u.obj.offset_len);
 	if (err < 0)
@@ -740,6 +740,11 @@ static int reftable_reader_refs_for_unindexed(struct reftable_reader *r,
 	int err;
 
 	REFTABLE_ALLOC_ARRAY(ti, 1);
+	if (!ti) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto out;
+	}
+
 	table_iter_init(ti, r);
 	err = table_iter_seek_start(ti, BLOCK_TYPE_REF, 0);
 	if (err < 0)
-- 
2.46.2.852.g229c0bf0e5.dirty


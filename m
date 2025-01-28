Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E5F1DFE34
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 08:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738052903; cv=none; b=aFmw6e9+ah4JpRpFaAkzpaj9WMKdpVbARbi+lsOMLs0OF61n2P9CtDp8dMrSRywPqlxbI31Kh5UNxBMDYmFIKSZ2HCXL+urMopRvamQBXpFzHhjIHdbEEZPxTHz3+OI1lGi3JwUkHlIAiO/tWwhkTxUsRkRF3QxbemUAfOZLcN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738052903; c=relaxed/simple;
	bh=b2z7t5YN1/UPU3YkC+nM8O0ZVN300GUW8fHH4jmXH3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LQykLNh8ExbtUNBAg3e8zGPeDSaMGV5dcwgSqdot8JOvQL7gc15mVXKHPHJxpNH+JHbLrXkp041L4Ru3dYWo5E15+pxnZCD3hJc62K561XAWFM3kV1wR8/sxMTKm1Y4NXWliRfOECgRE88UMTgjnaAqJnKhmGoFqBPEY9d/YhSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cEJ7dpSF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gY1Vt9Df; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cEJ7dpSF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gY1Vt9Df"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 558FD254024A;
	Tue, 28 Jan 2025 03:28:20 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 28 Jan 2025 03:28:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738052900;
	 x=1738139300; bh=uSt5YIJcgTdGx3jc7hmqXzUCWEg9yZNfRszfOh31fSU=; b=
	cEJ7dpSFMDPXC7w6S9HX3TwVqtfvuHkLgfWWs1xjkexsDn6nBqxWb09a1Tk3qpTe
	QPSZfRKuggeCUxxDqkvnkN1upxIEayUkO1V0XNxbwLaLbOzBBwJ7aAm+IjXk/H7O
	ryCVc/VmzGG+58Wd2iXocR6f9dQX8yYM5zAFMIdmdqW5XyIszifsGuzfIVDbxQAE
	a0jBwdoaVOw0ceqh/oArU+Wp+I3EmJRA9iK2COeqKt33TMcxFViNTsdBy1Y5e1Xx
	2lRISrY1eqRa7LMgw2ZiEIYpvjnsIkUgqQBHUvqsK7fUOy7ORHQ9PPXvo5SVa7LC
	NvqM8xQ1QlYpPMr0h/N79Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738052900; x=
	1738139300; bh=uSt5YIJcgTdGx3jc7hmqXzUCWEg9yZNfRszfOh31fSU=; b=g
	Y1Vt9DfmltLo0eSLceL7HTuDjhWqQBCOv00S661t3yNpegu9VJvs0lXzIDpIIckZ
	Eyh47ZKERKEXDD5j3P9fSy/tTtTDFHo8fi5NbTxKmQeM+ZXSRrMH1UzsAs3fmWdM
	HontoZ332BP8qyx/6oVYZQc5TSyxNGGu9XXugSPcxvWMH3cE9438Ov8dfxcriQvI
	zARqzl4ZbL29qAQeGeT9jFKA8GZOO3+DWPJO9SBZMTkl9eeIBkhQX5r12VqZG2gr
	zvEOFcLHjcFGzFECEqyZUpwEEkQOjEMbquOKIfp8iN5nbLwvcr+uN+9SZCtZinP2
	+zHDk/sb+CLXZbZJtNJfA==
X-ME-Sender: <xms:JJWYZ0V6k3o8-dZxQCHlQhtt5SZVn6jtPiDtrMCscaFEnHsHhDgjjg>
    <xme:JJWYZ4kpN4YZ3XoiEEV-WBnM1rZ7iUpxhHH6eVeyeH0nqJCe62ewdcNiFOw8EFKIy
    7H_xrs22yhjmyXlDA>
X-ME-Received: <xmr:JJWYZ4YdesTmoCLI2mFeSsvu6v7cGTAd3nMvWtx0aSaVQT06fBKl5dAbeVKM2AOEexYsNmKWv_Yd0HKyR5ekDQMWPCaBCJvy4WRPDX0EmOM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhoh
    hmshhonhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:JJWYZzVi8A70IQ6_xzWsBhBbVP9qgzO4WeQ7eziluM-TQe18Wi23ww>
    <xmx:JJWYZ-kytQ_iGi7nGgxv3UftfGZNFtjXiHPh1TY3ev4p4ZSx9Y4fSg>
    <xmx:JJWYZ4eflvmPC5T1cD2BXcETInb20FgDqdxFcjHL3mpLRSNQ51VMiA>
    <xmx:JJWYZwHIhi2ckQ8lsUao8rYAejIebkcbdR9h9yFKguYIWef-N9glqQ>
    <xmx:JJWYZ_D1rnCKYotJy9cMvcckGIZI7fjr3Z-T47tSVoVjz5ngagievppc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 03:28:19 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7b490749 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Jan 2025 08:28:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 28 Jan 2025 09:28:07 +0100
Subject: [PATCH v2 06/20] reftable/record: don't `BUG()` in
 `reftable_record_cmp()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-pks-reftable-drop-git-compat-util-v2-6-c85c20336317@pks.im>
References: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
In-Reply-To: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The reftable library aborts with a bug in case `reftable_record_cmp()`
is invoked with two records of differing types. This would cause the
program to die without the caller being able to handle the error, which
is not something we want in the context of library code. And it ties us
to the Git codebase.

Refactor the code such that `reftable_record_cmp()` returns an error
code separate from the actual comparison result. This requires us to
also adapt some callers up the callchain in a similar fashion.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c                | 20 +++++++++++++++-----
 reftable/pq.c                    | 36 +++++++++++++++++++++++++++++-------
 reftable/pq.h                    |  2 +-
 reftable/record.c                | 10 ++++++----
 reftable/record.h                |  2 +-
 t/unit-tests/t-reftable-pq.c     | 16 ++++++++++++----
 t/unit-tests/t-reftable-record.c | 40 ++++++++++++++++++++++++++++------------
 7 files changed, 92 insertions(+), 34 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index 4156eec07f..563864068c 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -66,8 +66,11 @@ static int merged_iter_seek(struct merged_iter *mi, struct reftable_record *want
 	int err;
 
 	mi->advance_index = -1;
-	while (!merged_iter_pqueue_is_empty(mi->pq))
-		merged_iter_pqueue_remove(&mi->pq);
+	while (!merged_iter_pqueue_is_empty(mi->pq)) {
+		err = merged_iter_pqueue_remove(&mi->pq, NULL);
+		if (err < 0)
+			return err;
+	}
 
 	for (size_t i = 0; i < mi->subiters_len; i++) {
 		err = iterator_seek(&mi->subiters[i].iter, want);
@@ -120,7 +123,9 @@ static int merged_iter_next_entry(struct merged_iter *mi,
 	if (empty)
 		return 1;
 
-	entry = merged_iter_pqueue_remove(&mi->pq);
+	err = merged_iter_pqueue_remove(&mi->pq, &entry);
+	if (err < 0)
+		return err;
 
 	/*
 	  One can also use reftable as datacenter-local storage, where the ref
@@ -134,11 +139,16 @@ static int merged_iter_next_entry(struct merged_iter *mi,
 		struct pq_entry top = merged_iter_pqueue_top(mi->pq);
 		int cmp;
 
-		cmp = reftable_record_cmp(top.rec, entry.rec);
+		err = reftable_record_cmp(top.rec, entry.rec, &cmp);
+		if (err < 0)
+			return err;
 		if (cmp > 0)
 			break;
 
-		merged_iter_pqueue_remove(&mi->pq);
+		err = merged_iter_pqueue_remove(&mi->pq, NULL);
+		if (err < 0)
+			return err;
+
 		err = merged_iter_advance_subiter(mi, top.index);
 		if (err < 0)
 			return err;
diff --git a/reftable/pq.c b/reftable/pq.c
index 5591e875e1..ef8035cfd9 100644
--- a/reftable/pq.c
+++ b/reftable/pq.c
@@ -15,13 +15,18 @@ license that can be found in the LICENSE file or at
 
 int pq_less(struct pq_entry *a, struct pq_entry *b)
 {
-	int cmp = reftable_record_cmp(a->rec, b->rec);
+	int cmp, err;
+
+	err = reftable_record_cmp(a->rec, b->rec, &cmp);
+	if (err < 0)
+		return err;
+
 	if (cmp == 0)
 		return a->index > b->index;
 	return cmp < 0;
 }
 
-struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq)
+int merged_iter_pqueue_remove(struct merged_iter_pqueue *pq, struct pq_entry *out)
 {
 	size_t i = 0;
 	struct pq_entry e = pq->heap[0];
@@ -32,17 +37,34 @@ struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq)
 		size_t min = i;
 		size_t j = 2 * i + 1;
 		size_t k = 2 * i + 2;
-		if (j < pq->len && pq_less(&pq->heap[j], &pq->heap[i]))
-			min = j;
-		if (k < pq->len && pq_less(&pq->heap[k], &pq->heap[min]))
-			min = k;
+		int cmp;
+
+		if (j < pq->len) {
+			cmp = pq_less(&pq->heap[j], &pq->heap[i]);
+			if (cmp < 0)
+				return -1;
+			else if (cmp)
+				min = j;
+		}
+
+		if (k < pq->len) {
+			cmp = pq_less(&pq->heap[k], &pq->heap[min]);
+			if (cmp < 0)
+				return -1;
+			else if (cmp)
+				min = k;
+		}
+
 		if (min == i)
 			break;
 		SWAP(pq->heap[i], pq->heap[min]);
 		i = min;
 	}
 
-	return e;
+	if (out)
+		*out = e;
+
+	return 0;
 }
 
 int merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct pq_entry *e)
diff --git a/reftable/pq.h b/reftable/pq.h
index 83c062eeca..ff39016445 100644
--- a/reftable/pq.h
+++ b/reftable/pq.h
@@ -22,7 +22,7 @@ struct merged_iter_pqueue {
 	size_t cap;
 };
 
-struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq);
+int merged_iter_pqueue_remove(struct merged_iter_pqueue *pq, struct pq_entry *out);
 int merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct pq_entry *e);
 void merged_iter_pqueue_release(struct merged_iter_pqueue *pq);
 int pq_less(struct pq_entry *a, struct pq_entry *b);
diff --git a/reftable/record.c b/reftable/record.c
index 31985bb977..da550494a2 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -1190,12 +1190,14 @@ int reftable_record_is_deletion(struct reftable_record *rec)
 		reftable_record_data(rec));
 }
 
-int reftable_record_cmp(struct reftable_record *a, struct reftable_record *b)
+int reftable_record_cmp(struct reftable_record *a, struct reftable_record *b,
+			int *cmp)
 {
 	if (a->type != b->type)
-		BUG("cannot compare reftable records of different type");
-	return reftable_record_vtable(a)->cmp(
-		reftable_record_data(a), reftable_record_data(b));
+		return -1;
+	*cmp = reftable_record_vtable(a)->cmp(reftable_record_data(a),
+					      reftable_record_data(b));
+	return 0;
 }
 
 int reftable_record_equal(struct reftable_record *a, struct reftable_record *b, uint32_t hash_size)
diff --git a/reftable/record.h b/reftable/record.h
index e1846c294b..867810a932 100644
--- a/reftable/record.h
+++ b/reftable/record.h
@@ -134,7 +134,7 @@ struct reftable_record {
 int reftable_record_init(struct reftable_record *rec, uint8_t typ);
 
 /* see struct record_vtable */
-int reftable_record_cmp(struct reftable_record *a, struct reftable_record *b);
+int reftable_record_cmp(struct reftable_record *a, struct reftable_record *b, int *cmp);
 int reftable_record_equal(struct reftable_record *a, struct reftable_record *b, uint32_t hash_size);
 int reftable_record_key(struct reftable_record *rec, struct reftable_buf *dest);
 int reftable_record_copy_from(struct reftable_record *rec,
diff --git a/t/unit-tests/t-reftable-pq.c b/t/unit-tests/t-reftable-pq.c
index d8a4c283a1..c128fe8616 100644
--- a/t/unit-tests/t-reftable-pq.c
+++ b/t/unit-tests/t-reftable-pq.c
@@ -21,7 +21,9 @@ static void merged_iter_pqueue_check(const struct merged_iter_pqueue *pq)
 
 static int pq_entry_equal(struct pq_entry *a, struct pq_entry *b)
 {
-	return !reftable_record_cmp(a->rec, b->rec) && (a->index == b->index);
+	int cmp;
+	check(!reftable_record_cmp(a->rec, b->rec, &cmp));
+	return !cmp && (a->index == b->index);
 }
 
 static void t_pq_record(void)
@@ -49,7 +51,9 @@ static void t_pq_record(void)
 
 	while (!merged_iter_pqueue_is_empty(pq)) {
 		struct pq_entry top = merged_iter_pqueue_top(pq);
-		struct pq_entry e = merged_iter_pqueue_remove(&pq);
+		struct pq_entry e;
+
+		check(!merged_iter_pqueue_remove(&pq, &e));
 		merged_iter_pqueue_check(&pq);
 
 		check(pq_entry_equal(&top, &e));
@@ -90,7 +94,9 @@ static void t_pq_index(void)
 
 	for (i = N - 1; i > 0; i--) {
 		struct pq_entry top = merged_iter_pqueue_top(pq);
-		struct pq_entry e = merged_iter_pqueue_remove(&pq);
+		struct pq_entry e;
+
+		check(!merged_iter_pqueue_remove(&pq, &e));
 		merged_iter_pqueue_check(&pq);
 
 		check(pq_entry_equal(&top, &e));
@@ -129,7 +135,9 @@ static void t_merged_iter_pqueue_top(void)
 
 	for (i = N - 1; i > 0; i--) {
 		struct pq_entry top = merged_iter_pqueue_top(pq);
-		struct pq_entry e = merged_iter_pqueue_remove(&pq);
+		struct pq_entry e;
+
+		check(!merged_iter_pqueue_remove(&pq, &e));
 
 		merged_iter_pqueue_check(&pq);
 		check(pq_entry_equal(&top, &e));
diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index 6540bd20e3..5954966373 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -100,16 +100,20 @@ static void t_reftable_ref_record_comparison(void)
 			.u.ref.value.symref = (char *) "refs/heads/master",
 		},
 	};
+	int cmp;
 
 	check(!reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[0], &in[1]));
+	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
+	check(!cmp);
 
 	check(!reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1));
-	check_int(reftable_record_cmp(&in[1], &in[2]), >, 0);
+	check(!reftable_record_cmp(&in[1], &in[2], &cmp));
+	check_int(cmp, >, 0);
 
 	in[1].u.ref.value_type = in[0].u.ref.value_type;
 	check(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[0], &in[1]));
+	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
+	check(!cmp);
 }
 
 static void t_reftable_ref_record_compare_name(void)
@@ -209,17 +213,20 @@ static void t_reftable_log_record_comparison(void)
 			.u.log.update_index = 22,
 		},
 	};
+	int cmp;
 
 	check(!reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
 	check(!reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1));
-	check_int(reftable_record_cmp(&in[1], &in[2]), >, 0);
+	check(!reftable_record_cmp(&in[1], &in[2], &cmp));
+	check_int(cmp, >, 0);
 	/* comparison should be reversed for equal keys, because
 	 * comparison is now performed on the basis of update indices */
-	check_int(reftable_record_cmp(&in[0], &in[1]), <, 0);
+	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
+	check_int(cmp, <, 0);
 
 	in[1].u.log.update_index = in[0].u.log.update_index;
 	check(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[0], &in[1]));
+	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
 }
 
 static void t_reftable_log_record_compare_key(void)
@@ -396,16 +403,20 @@ static void t_reftable_obj_record_comparison(void)
 			.u.obj.hash_prefix_len = 5,
 		},
 	};
+	int cmp;
 
 	check(!reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[0], &in[1]));
+	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
+	check(!cmp);
 
 	check(!reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1));
-	check_int(reftable_record_cmp(&in[1], &in[2]), >, 0);
+	check(!reftable_record_cmp(&in[1], &in[2], &cmp));
+	check_int(cmp, >, 0);
 
 	in[1].u.obj.offset_len = in[0].u.obj.offset_len;
 	check(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[0], &in[1]));
+	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
+	check(!cmp);
 }
 
 static void t_reftable_obj_record_roundtrip(void)
@@ -486,19 +497,24 @@ static void t_reftable_index_record_comparison(void)
 			.u.idx.last_key = REFTABLE_BUF_INIT,
 		},
 	};
+	int cmp;
+
 	check(!reftable_buf_addstr(&in[0].u.idx.last_key, "refs/heads/master"));
 	check(!reftable_buf_addstr(&in[1].u.idx.last_key, "refs/heads/master"));
 	check(!reftable_buf_addstr(&in[2].u.idx.last_key, "refs/heads/branch"));
 
 	check(!reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[0], &in[1]));
+	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
+	check(!cmp);
 
 	check(!reftable_record_equal(&in[1], &in[2], REFTABLE_HASH_SIZE_SHA1));
-	check_int(reftable_record_cmp(&in[1], &in[2]), >, 0);
+	check(!reftable_record_cmp(&in[1], &in[2], &cmp));
+	check_int(cmp, >, 0);
 
 	in[1].u.idx.offset = in[0].u.idx.offset;
 	check(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1));
-	check(!reftable_record_cmp(&in[0], &in[1]));
+	check(!reftable_record_cmp(&in[0], &in[1], &cmp));
+	check(!cmp);
 
 	for (size_t i = 0; i < ARRAY_SIZE(in); i++)
 		reftable_record_release(&in[i]);

-- 
2.48.1.362.g079036d154.dirty


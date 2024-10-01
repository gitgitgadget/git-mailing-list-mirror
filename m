Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB6B19FA65
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 09:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775730; cv=none; b=dRLEDk1Y2cjdA8HAWNHKzPeJucu8s+iBdlDOP7sWSmjHbB/UJsRe1DgO36vh/aHs7TFVTJ6KJDu3KoPgqG6XjVaUHPjeQdjdmDrFSN+vktMDbGAJtCWWheLT5pNXcikM2k8g6H02gXZqGhMxYkmPOCcMsQv74Tgxu7XvQfs4/xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775730; c=relaxed/simple;
	bh=ot6B0w+28e/TupIx92ZkFojzo9W9HHxyu8OY/qL+g6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdEdg2NMfBFkJDEIbiI4c9411o2y2RFf9D6BO234dv8UcIbF40kiQeWg36wg+LL38a0qVghE8yO0AHjKUu6/mV8OM8fLP/Ab1LUt+W+ZsKx7yb4Ooqte1t3s3lwG2RLzYvdoTxXelX+432K6SFqCKPSqJJ76kwIZTMuntAZfomA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rAK8s/nk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WCkyIM0r; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rAK8s/nk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WCkyIM0r"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id D604C1381156;
	Tue,  1 Oct 2024 05:42:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 01 Oct 2024 05:42:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727775727; x=1727862127; bh=KxA1xL6cHw
	NNyBOTShE8qLiR46Dx8bSgoiF1YRu9mb4=; b=rAK8s/nk1z+7wETCb493dzRsGK
	AVGSOcK0466+AdVT5BqThVLK49fs+7/SiMZy6XhSVv+0wyHvZedH42c9RbeUJtse
	Pg5koRe+Ek9CqjghBGqk/dYtQiNtrA5Mz1Minl8keOQVW/VcK5Qr45bn5hURScwL
	K+cgKwhrvAzO9uJrGIydYhRyufgL66EMPBx1M2Mgd7ofqXMh25YniiGHIyFKcq2/
	bD9Il1JXI55pqNgIIP0Bppq5wif/Ragc+ev1Se0dEbVJmq24s+QrE4FYgJmV7DIC
	U5W9BKla3Rhbn5riyHDzceZErJVZVnEkV6Ylb/bw+wnvemnN4XOf8M3JK+DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727775727; x=1727862127; bh=KxA1xL6cHwNNyBOTShE8qLiR46Dx
	8bSgoiF1YRu9mb4=; b=WCkyIM0reJdQiMaHCtEFJyaYiFH/1mCTV9QXIGyU6aKk
	n3XXZouSCuwXDSXR/kFuzOg6cYdQruaQyvW4okDA+agEd3mbSeQBuPeyK3Pt1t8Q
	v+hB7ffD/gDQi9jNuzEdYAmzEu72RgJEWhfg8YRp7Y3aTZgoynGxwkLQuE+e5To2
	SRWT6McTucpxjIJpNOo3WmyWQ19HBRFatneqYOIHIY4dUPmhu6qeI+aGBtj2F1+l
	Xr0QtfTsqw6rz03MR7rhNmKDl+hkimplt7z4bIBES9Lo6AjNYzfCwKqk4OtHAkoz
	qsJnSJOH2O1WNi91vjUyxaaZdAz+VyTTbq4+qcKKLg==
X-ME-Sender: <xms:78P7ZqJDnfQAr8NXwJGh5-GVAN5BgfZCmXi4uY8NWLkH3WK-l_Qx8Q>
    <xme:78P7ZiJ0B48c_dgjeeLTA4XXjGRonTHDvKBEkK2Mm54hGchLWyYcpUnraGz561TOo
    xYpztRNJmcrgCLZrw>
X-ME-Received: <xmr:78P7ZqtWOxt9KsluGZsxHKvxxcXO7WAI8OiA3GStSLFWdwo46FctCJV3csO56UiF4gKd4GPdLDzU_EOM2HToJ86Zq3SnrUuhP2e91pJXAkl7EA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveffudeuuddugfehuedutedtjeefgffhtefguddtieeh
    ieetkefffedvteduhfeknecuffhomhgrihhnpehuphgurghtvgdrnhgvfidpuhhpuggrth
    gvrdhnrghmvgdpuhhpuggrthgvrdgvmhgrihhlpdhuphgurghtvgdrthiinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhs
    ohhnrdgtohhmpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggv
X-ME-Proxy: <xmx:78P7Zvb0qFxL-B4FL-AdktYH3VQjfXAt0cyNKEu6vKROWYRO7saaBQ>
    <xmx:78P7ZhYVEaM7JbQzcJ-60new7sUIbqse8h_wzAaNWyxx6FntgjHBVw>
    <xmx:78P7ZrBaZswQZ_V5AYSi7QDcr9WHKa5BN9qKy6hx-F4YFr4Do0bYxQ>
    <xmx:78P7ZnZO7KnWKHmFW0Nwnrt4OHj7bBfGL2XXWuQf9IO00O-jxKYomA>
    <xmx:78P7ZgX2MKKNatRZ5Ng-YXfGsH7h6QMknTNLZNS3a7WIYQ_rY40U2kmt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 05:42:06 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6929ed14 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Oct 2024 09:41:19 +0000 (UTC)
Date: Tue, 1 Oct 2024 11:42:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v4 07/25] reftable/record: handle allocation failures when
 decoding records
Message-ID: <ca64971e7b892524e553d20e6726c95dd1865787.1727774935.git.ps@pks.im>
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

Handle allocation failures when decoding records. While at it, fix some
error codes to be `REFTABLE_FORMAT_ERROR`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/record.c | 80 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 63 insertions(+), 17 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index 60fd33c9c9..787e134c9a 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -359,7 +359,7 @@ static int reftable_ref_record_decode(void *rec, struct strbuf key,
 	uint64_t update_index = 0;
 	const char *refname = NULL;
 	size_t refname_cap = 0;
-	int n;
+	int n, err;
 
 	assert(hash_size > 0);
 
@@ -375,6 +375,10 @@ static int reftable_ref_record_decode(void *rec, struct strbuf key,
 	SWAP(r->refname_cap, refname_cap);
 
 	REFTABLE_ALLOC_GROW(r->refname, key.len + 1, r->refname_cap);
+	if (!r->refname) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto done;
+	}
 	memcpy(r->refname, key.buf, key.len);
 	r->refname[key.len] = 0;
 
@@ -383,7 +387,8 @@ static int reftable_ref_record_decode(void *rec, struct strbuf key,
 	switch (val_type) {
 	case REFTABLE_REF_VAL1:
 		if (in.len < hash_size) {
-			return -1;
+			err = REFTABLE_FORMAT_ERROR;
+			goto done;
 		}
 
 		memcpy(r->value.val1, in.buf, hash_size);
@@ -392,7 +397,8 @@ static int reftable_ref_record_decode(void *rec, struct strbuf key,
 
 	case REFTABLE_REF_VAL2:
 		if (in.len < 2 * hash_size) {
-			return -1;
+			err = REFTABLE_FORMAT_ERROR;
+			goto done;
 		}
 
 		memcpy(r->value.val2.value, in.buf, hash_size);
@@ -405,7 +411,8 @@ static int reftable_ref_record_decode(void *rec, struct strbuf key,
 	case REFTABLE_REF_SYMREF: {
 		int n = decode_string(scratch, in);
 		if (n < 0) {
-			return -1;
+			err = REFTABLE_FORMAT_ERROR;
+			goto done;
 		}
 		string_view_consume(&in, n);
 		r->value.symref = strbuf_detach(scratch, NULL);
@@ -419,6 +426,9 @@ static int reftable_ref_record_decode(void *rec, struct strbuf key,
 	}
 
 	return start.len - in.len;
+
+done:
+	return err;
 }
 
 static int reftable_ref_record_is_deletion_void(const void *p)
@@ -552,6 +562,8 @@ static int reftable_obj_record_decode(void *rec, struct strbuf key,
 	reftable_obj_record_release(r);
 
 	REFTABLE_ALLOC_ARRAY(r->hash_prefix, key.len);
+	if (!r->hash_prefix)
+		return REFTABLE_OUT_OF_MEMORY_ERROR;
 	memcpy(r->hash_prefix, key.buf, key.len);
 	r->hash_prefix_len = key.len;
 
@@ -570,6 +582,8 @@ static int reftable_obj_record_decode(void *rec, struct strbuf key,
 		return start.len - in.len;
 
 	REFTABLE_ALLOC_ARRAY(r->offsets, count);
+	if (!r->offsets)
+		return REFTABLE_OUT_OF_MEMORY_ERROR;
 	r->offset_len = count;
 
 	n = get_var_int(&r->offsets[0], &in);
@@ -801,12 +815,17 @@ static int reftable_log_record_decode(void *rec, struct strbuf key,
 	struct reftable_log_record *r = rec;
 	uint64_t max = 0;
 	uint64_t ts = 0;
-	int n;
+	int err, n;
 
 	if (key.len <= 9 || key.buf[key.len - 9] != 0)
 		return REFTABLE_FORMAT_ERROR;
 
 	REFTABLE_ALLOC_GROW(r->refname, key.len - 8, r->refname_cap);
+	if (!r->refname) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto done;
+	}
+
 	memcpy(r->refname, key.buf, key.len - 8);
 	ts = get_be64(key.buf + key.len - 8);
 
@@ -829,8 +848,10 @@ static int reftable_log_record_decode(void *rec, struct strbuf key,
 	if (val_type == REFTABLE_LOG_DELETION)
 		return 0;
 
-	if (in.len < 2 * hash_size)
-		return REFTABLE_FORMAT_ERROR;
+	if (in.len < 2 * hash_size) {
+		err = REFTABLE_FORMAT_ERROR;
+		goto done;
+	}
 
 	memcpy(r->value.update.old_hash, in.buf, hash_size);
 	memcpy(r->value.update.new_hash, in.buf + hash_size, hash_size);
@@ -838,8 +859,10 @@ static int reftable_log_record_decode(void *rec, struct strbuf key,
 	string_view_consume(&in, 2 * hash_size);
 
 	n = decode_string(scratch, in);
-	if (n < 0)
+	if (n < 0) {
+		err = REFTABLE_FORMAT_ERROR;
 		goto done;
+	}
 	string_view_consume(&in, n);
 
 	/*
@@ -850,52 +873,75 @@ static int reftable_log_record_decode(void *rec, struct strbuf key,
 	 */
 	if (!r->value.update.name ||
 	    strcmp(r->value.update.name, scratch->buf)) {
-		r->value.update.name =
-			reftable_realloc(r->value.update.name, scratch->len + 1);
+		char *name = reftable_realloc(r->value.update.name, scratch->len + 1);
+		if (!name) {
+			err = REFTABLE_OUT_OF_MEMORY_ERROR;
+			goto done;
+		}
+
+		r->value.update.name = name;
 		memcpy(r->value.update.name, scratch->buf, scratch->len);
 		r->value.update.name[scratch->len] = 0;
 	}
 
 	n = decode_string(scratch, in);
-	if (n < 0)
+	if (n < 0) {
+		err = REFTABLE_FORMAT_ERROR;
 		goto done;
+	}
 	string_view_consume(&in, n);
 
 	/* Same as above, but for the reflog email. */
 	if (!r->value.update.email ||
 	    strcmp(r->value.update.email, scratch->buf)) {
-		r->value.update.email =
-			reftable_realloc(r->value.update.email, scratch->len + 1);
+		char *email = reftable_realloc(r->value.update.email, scratch->len + 1);
+		if (!email) {
+			err = REFTABLE_OUT_OF_MEMORY_ERROR;
+			goto done;
+		}
+
+		r->value.update.email = email;
 		memcpy(r->value.update.email, scratch->buf, scratch->len);
 		r->value.update.email[scratch->len] = 0;
 	}
 
 	ts = 0;
 	n = get_var_int(&ts, &in);
-	if (n < 0)
+	if (n < 0) {
+		err = REFTABLE_FORMAT_ERROR;
 		goto done;
+	}
 	string_view_consume(&in, n);
 	r->value.update.time = ts;
-	if (in.len < 2)
+	if (in.len < 2) {
+		err = REFTABLE_FORMAT_ERROR;
 		goto done;
+	}
 
 	r->value.update.tz_offset = get_be16(in.buf);
 	string_view_consume(&in, 2);
 
 	n = decode_string(scratch, in);
-	if (n < 0)
+	if (n < 0) {
+		err = REFTABLE_FORMAT_ERROR;
 		goto done;
+	}
 	string_view_consume(&in, n);
 
 	REFTABLE_ALLOC_GROW(r->value.update.message, scratch->len + 1,
 			    r->value.update.message_cap);
+	if (!r->value.update.message) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto done;
+	}
+
 	memcpy(r->value.update.message, scratch->buf, scratch->len);
 	r->value.update.message[scratch->len] = 0;
 
 	return start.len - in.len;
 
 done:
-	return REFTABLE_FORMAT_ERROR;
+	return err;
 }
 
 static int null_streq(const char *a, const char *b)
-- 
2.47.0.rc0.dirty


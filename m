Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8304126C12
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 06:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727159539; cv=none; b=cRdebO0eQ/2NXFa/SwkFoF3LKeQ0fTEqcjmZOrQUCtdE/oQa2x0Yo2V5c4OoBHUjsmmCXa7CIkwm1lWA/d7AEA9raYSKzNnCufCgJhiYkDrN2/gADVb9wJsJ9zJsNSIdITdQKccmlr6RNHb24sC3mB0NFqcGfesBF83FmJAIg+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727159539; c=relaxed/simple;
	bh=BKq4p+uIAv9ZuYOSnNE/KpcSjc6cn80W99iWojHflnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEv8Ab4iP95oYULqzdTkNU26tGvdlSGZO53wlNsqGTEBlKxyS5GCVKKF+5DkA/jLt9sBfT2pYssRq74Lo0Kw7pWbotcsSH1iXxKuBkmrtGQ9mF7PWQ6yxZsqBHax8qn2kZ2BsQ7t1zlavg3wJWygKVEkP198K6xDqo7cSl+lVRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sIudM9nj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p0H6jtQt; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sIudM9nj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p0H6jtQt"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id EE72013802E6;
	Tue, 24 Sep 2024 02:32:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 24 Sep 2024 02:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727159536; x=1727245936; bh=xxOqBrbNa2
	F/37Wz124W2Nw0AOdQOQ/0N4nMv9H09+g=; b=sIudM9njmeBVP6Z62BYuFuh1h3
	I9TdxC/8MnAFxjSRQrVTshHkXhhXKOA85Kqy7hpJyJjqB8uw3A81RfOeGmwoadlR
	FZ4TU9S5ZJlgNZ8Ip6qSTb913AdhuQy2kZ1TRy4ptAqRG5Zh76FFr4KoxV0CkHCm
	+oWyvYO7gtxjzRAyQFyXenAWTI8C+gXMv/JDaRr4xW7L/Fk0DN1CXdLaXJlG6TN6
	51YrMqeZJe7H1Yur9ebfMweAg09koThpoQ2Alnym6cQnY+qJgO6kTGbC81Yy7oqD
	cv2vIhd9HjneWtd/CdzSCIGAoAoKPEPf472dO00deTXv0xNN9u2STOhr0cSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727159536; x=1727245936; bh=xxOqBrbNa2F/37Wz124W2Nw0AOdQ
	OQ/0N4nMv9H09+g=; b=p0H6jtQtxiNrQ2xKYH9dh07MOrdHyyR46jhouHBNJ2BH
	EQRLPwbBKi/4UAe6Z/ZDh4dgc417GbTTr5gHDkPZ1hEc/sl7BiXXoE8e0amR6jwT
	cq6LfsoGFpjORbU7ZWqLPr+vPdrYQqM3xEmnFtb3/j+qEmN8E1F/o+yx1ol57R8a
	NFd6+DOL1uhq4bbf2WJWpaYLsEmpwP9Okf/FLMbXeLUyR+840NK9dwYKYRadE869
	DAnnuCZ8NVSWVv7clhG4c/J0mM6SyclLkfwcXM+gm0HHxvCsz393gHG4C6bU4HlX
	xxNgYxKwnavB3+dqg+KTT1MufhDAJlgG/yRssD1stw==
X-ME-Sender: <xms:8FzyZpfr0myGm7I0Krf4mdGzTNiwI3Q8fanTGwi5uhcNkY5wFjonOQ>
    <xme:8FzyZnMVoj6GcGTzb3DIITCZTlIRADSvJiBxqDmXvciWP6uf9fTst3La3P5JDQF5W
    RDgkL_e-D1i6gNWYw>
X-ME-Received: <xmr:8FzyZijMrMFSvgOcxXm2jed_pTvHamN0lFOdWwkbNF2SAWNGEq87jp45vtgv9nXvuzTqY7sCYwTINfschFJBbCu6wCZtunMkQXnlaqxiRUEraw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtuddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveffudeuuddugfehuedutedtjeefgffhtefguddtieeh
    ieetkefffedvteduhfeknecuffhomhgrihhnpehuphgurghtvgdrnhgvfidpuhhpuggrth
    gvrdhnrghmvgdpuhhpuggrthgvrdgvmhgrihhlpdhuphgurghtvgdrthiinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvthhhohhmshhonhesvg
    gufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:8FzyZi9Jwt9DGQrAheea8pewaW8QG75WqbPxHetTRBq0OWi6YccrYg>
    <xmx:8FzyZlsnEUnQd5ueDWRRysZb0UD27gVyYsxunjSXpr0UaZhEgEF2KA>
    <xmx:8FzyZhEgdDi9HW953vvOAzEoGPstIfhCLYDGmXyDwh7sOqSDjGB4yw>
    <xmx:8FzyZsN-ih5-BHG2oF7eDcyCJ1M32C45gBkajrqL_ZkRn1DSaGxHOA>
    <xmx:8FzyZtIWAH4rCNaW2IHJG_KIehJDCyBaZVWnezgfjQlqYk8Rtf7lxcln>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 02:32:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ad76995d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 06:31:42 +0000 (UTC)
Date: Tue, 24 Sep 2024 08:32:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 07/22] reftable/record: handle allocation failures when
 decoding records
Message-ID: <870bb003c0abd117dce2ae0fcf8c3010c8d1b334.1727158127.git.ps@pks.im>
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

Handle allocation failures when decoding records. While at it, fix some
error codes to be `REFTABLE_FORMAT_ERROR`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/record.c | 80 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 63 insertions(+), 17 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index 60fd33c9c94..787e134c9a0 100644
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
2.46.0.551.gc5ee8f2d1c.dirty


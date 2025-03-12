Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1988C23F39D
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 12:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741781545; cv=none; b=TYDy7kNJYrArq2CJObqcx1vl4PC9RCoYMqR2Uta/SSFqFbRw3mFzHnZxXc9j2s6jicZIrHXUH2QW06Z8mj5MCyEj6YTow0TGK0qjxsdXHAaZaT9E5s7OY3gIoBFKi3dy5PQxYz/baiE4qZiRB+gxlZ+kcludFfSTZwUJ0znhmRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741781545; c=relaxed/simple;
	bh=eCqJmXbmnfHlqtGyzxAU4mH0rtHKpAbQZBB8F0dK7xA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aPJWpevwAvDrmPQXoMceZYJDrPkb+znSPvD+7xhRQB6886JNT16dwccOXwLAV0PCx0DOGZff6luxaHsBpyCGnw5S+9fi96ByPFmwP4VR1OIjxobVzn2NMuArTwrVsEqmnlF0K+hsc9HsqJI8hAz4lJLMn1KofMVXluVb45IpDes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWTJwUAE; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWTJwUAE"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2235189adaeso15759875ad.0
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 05:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741781543; x=1742386343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pojrb7k0iUaf6SLCizu6NSGr3KjLGA0sCocaSPwq2A8=;
        b=PWTJwUAEzbyHkf/EAsPYyZRhBFj2bKVZf7LXXw4uUnSrB1zZKXK651N68djFH89Qot
         iFrCvI8ZoU0elvuZCskXEamfn+Or1kllar/+TZLb8sGDo7eztTmaOsCtbTl4KyvWGCLP
         GpI5bkb3qEmBjgDxwgUZOe9RKotHVJpwq/g9ObW+fmTHdLMMAj+i24u5740gLIbvH/AW
         0nCeKp2Lxyf7k6cI64VAMDijhkwnGqq3X/iyvuGvVILtQYMAVHI51mW+lKlZbLs30Qa9
         URlUB4gNKhAkSxLTO5kVub3tJDJUPSMCYRSd8JZ+KJfqh754eEochwIJ0jHD0Sg4sRip
         SlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741781543; x=1742386343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pojrb7k0iUaf6SLCizu6NSGr3KjLGA0sCocaSPwq2A8=;
        b=k8NJDHZ4B2NegHSMnAamu+hUFSF8GC0kCpl4aN28kPhW+TZQiqkNqd1WuFE6Uegd/x
         06hcTrOmEhgkWhUOTayHhdL6xjc9N3Xdfah2g/9/6xSTL9eNCal+Zluyf9N/BIMY3px+
         efuOVN367+/hVw3KV0rBVPx8fDPp4ZpBA9L3FRRfmt+wa0qRptUF+slmAOPUlbjrt0aD
         Zd2PgEAS1uIQX3V8t0JPA9Jyv/ybb7wkynGgr5lt2TBNyCcsATTx17cWW37HyBgrXDO4
         RM+UALK83TMmmSkniucZEfI0O+qA9Dw73q7trMO9EPih7y7vnvzFJ+7FYBw5IEWYUbKD
         lRKA==
X-Gm-Message-State: AOJu0YwuOLruspp1bjVbbD2Gof0jJu+TYGBOgyi1RDi21UW0u0XQZHY7
	Ko17eBSs3D4nQBBadHRNYf4mYlphApcYxGQLwnilEpzsQSEmycav/Is5xw==
X-Gm-Gg: ASbGncu+hkjR/LcU4KvBqjWhIEbFLNNJ5axMZseTPpj+TLXSaYD8Agf46yaV653HhbM
	p2k9rFYHUrGI1p2rNAVx3NtHpx8YQ7R2Aw7Lk1t9gkUyUBo0yKuktN57b7xGktVQnyAqA55kIYG
	JRYmoK6m22SNAaH34NesiIm6gT/IOYrP9iMMUJko7Zvkv2ygDL1U0uhBjmL0DMsRPacU1UUc+L0
	GV9RhoHH87YGpey+0mZm+4cA9C+0jid3GysQa61B3FLd7289zxL+eGouxrQPgyzq82bR5am8J/P
	7Vla+3nBUu6vHdAAv9QrXCP7qi5KmCmvdiCHDV32
X-Google-Smtp-Source: AGHT+IEjhFacKFhpWBv4JtoIjWiIIOfDR9RcnvvrakLpcFrUworTWVSVM0tqMy5KVZfoQDS29ANptQ==
X-Received: by 2002:a17:903:1cf:b0:221:8568:c00f with SMTP id d9443c01a7336-22593b87f54mr109510535ad.0.1741781542939;
        Wed, 12 Mar 2025 05:12:22 -0700 (PDT)
Received: from meet.. ([103.86.19.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e974fsm114469035ad.78.2025.03.12.05.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:12:22 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [PATCH v3 1/2] reftable: propagate specific error codes in block_writer_add()
Date: Wed, 12 Mar 2025 17:41:47 +0530
Message-Id: <20250312121148.1879604-2-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250312121148.1879604-1-meetsoni3017@gmail.com>
References: <20250308133349.1591331-1-meetsoni3017@gmail.com>
 <20250312121148.1879604-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, functions block_writer_add() and related functions returned
-1 when the record did not fit, forcing the caller to assume that any
failure meant the entry was too big. Replace these generic -1 returns
with defined error codes.

This prepares the codebase for finer-grained error handling so that
callers can distinguish between a block-full condition and other errors.

Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 reftable/block.c  | 13 ++++++------
 reftable/block.h  |  2 +-
 reftable/record.c | 53 +++++++++++++++++++++--------------------------
 3 files changed, 32 insertions(+), 36 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index b14a8f1259..0b8ebc3aa5 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -49,7 +49,7 @@ static int block_writer_register_restart(struct block_writer *w, int n,
 	if (is_restart)
 		rlen++;
 	if (2 + 3 * rlen + n > w->block_size - w->next)
-		return -1;
+		return REFTABLE_ENTRY_TOO_BIG_ERROR;
 	if (is_restart) {
 		REFTABLE_ALLOC_GROW_OR_NULL(w->restarts, w->restart_len + 1,
 					    w->restart_cap);
@@ -97,9 +97,10 @@ uint8_t block_writer_type(struct block_writer *bw)
 	return bw->block[bw->header_off];
 }
 
-/* Adds the reftable_record to the block. Returns -1 if it does not fit, 0 on
-   success. Returns REFTABLE_API_ERROR if attempting to write a record with
-   empty key. */
+/*
+ * Adds the reftable_record to the block. Returns 0 on success and
+ * appropriate error codes on failure.
+ */
 int block_writer_add(struct block_writer *w, struct reftable_record *rec)
 {
 	struct reftable_buf empty = REFTABLE_BUF_INIT;
@@ -126,14 +127,14 @@ int block_writer_add(struct block_writer *w, struct reftable_record *rec)
 	n = reftable_encode_key(&is_restart, out, last, w->scratch,
 				reftable_record_val_type(rec));
 	if (n < 0) {
-		err = -1;
+		err = n;
 		goto done;
 	}
 	string_view_consume(&out, n);
 
 	n = reftable_record_encode(rec, out, w->hash_size);
 	if (n < 0) {
-		err = -1;
+		err = n;
 		goto done;
 	}
 	string_view_consume(&out, n);
diff --git a/reftable/block.h b/reftable/block.h
index bef2b8a4c5..64732eba7d 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -53,7 +53,7 @@ int block_writer_init(struct block_writer *bw, uint8_t typ, uint8_t *block,
 /* returns the block type (eg. 'r' for ref records. */
 uint8_t block_writer_type(struct block_writer *bw);
 
-/* appends the record, or -1 if it doesn't fit. */
+/* Attempts to append the record. Returns 0 on success or error code on failure. */
 int block_writer_add(struct block_writer *w, struct reftable_record *rec);
 
 /* appends the key restarts, and compress the block if necessary. */
diff --git a/reftable/record.c b/reftable/record.c
index 8919df8a4d..d9fba8ff38 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -61,7 +61,7 @@ int put_var_int(struct string_view *dest, uint64_t value)
 	while (value >>= 7)
 		varint[--pos] = 0x80 | (--value & 0x7f);
 	if (dest->len < sizeof(varint) - pos)
-		return -1;
+		return REFTABLE_ENTRY_TOO_BIG_ERROR;
 	memcpy(dest->buf, varint + pos, sizeof(varint) - pos);
 	return sizeof(varint) - pos;
 }
@@ -129,10 +129,10 @@ static int encode_string(const char *str, struct string_view s)
 	size_t l = strlen(str);
 	int n = put_var_int(&s, l);
 	if (n < 0)
-		return -1;
+		return n;
 	string_view_consume(&s, n);
 	if (s.len < l)
-		return -1;
+		return REFTABLE_ENTRY_TOO_BIG_ERROR;
 	memcpy(s.buf, str, l);
 	string_view_consume(&s, l);
 
@@ -148,18 +148,18 @@ int reftable_encode_key(int *restart, struct string_view dest,
 	uint64_t suffix_len = key.len - prefix_len;
 	int n = put_var_int(&dest, prefix_len);
 	if (n < 0)
-		return -1;
+		return n;
 	string_view_consume(&dest, n);
 
 	*restart = (prefix_len == 0);
 
 	n = put_var_int(&dest, suffix_len << 3 | (uint64_t)extra);
 	if (n < 0)
-		return -1;
+		return n;
 	string_view_consume(&dest, n);
 
 	if (dest.len < suffix_len)
-		return -1;
+		return REFTABLE_ENTRY_TOO_BIG_ERROR;
 	memcpy(dest.buf, key.buf + prefix_len, suffix_len);
 	string_view_consume(&dest, suffix_len);
 
@@ -324,30 +324,27 @@ static int reftable_ref_record_encode(const void *rec, struct string_view s,
 	struct string_view start = s;
 	int n = put_var_int(&s, r->update_index);
 	if (n < 0)
-		return -1;
+		return n;
 	string_view_consume(&s, n);
 
 	switch (r->value_type) {
 	case REFTABLE_REF_SYMREF:
 		n = encode_string(r->value.symref, s);
-		if (n < 0) {
-			return -1;
-		}
+		if (n < 0)
+			return n;
 		string_view_consume(&s, n);
 		break;
 	case REFTABLE_REF_VAL2:
-		if (s.len < 2 * hash_size) {
-			return -1;
-		}
+		if (s.len < 2 * hash_size)
+			return REFTABLE_ENTRY_TOO_BIG_ERROR;
 		memcpy(s.buf, r->value.val2.value, hash_size);
 		string_view_consume(&s, hash_size);
 		memcpy(s.buf, r->value.val2.target_value, hash_size);
 		string_view_consume(&s, hash_size);
 		break;
 	case REFTABLE_REF_VAL1:
-		if (s.len < hash_size) {
-			return -1;
-		}
+		if (s.len < hash_size)
+			return REFTABLE_ENTRY_TOO_BIG_ERROR;
 		memcpy(s.buf, r->value.val1, hash_size);
 		string_view_consume(&s, hash_size);
 		break;
@@ -531,24 +528,22 @@ static int reftable_obj_record_encode(const void *rec, struct string_view s,
 	uint64_t last = 0;
 	if (r->offset_len == 0 || r->offset_len >= 8) {
 		n = put_var_int(&s, r->offset_len);
-		if (n < 0) {
-			return -1;
-		}
+		if (n < 0)
+			return n;
 		string_view_consume(&s, n);
 	}
 	if (r->offset_len == 0)
 		return start.len - s.len;
 	n = put_var_int(&s, r->offsets[0]);
 	if (n < 0)
-		return -1;
+		return n;
 	string_view_consume(&s, n);
 
 	last = r->offsets[0];
 	for (i = 1; i < r->offset_len; i++) {
 		int n = put_var_int(&s, r->offsets[i] - last);
-		if (n < 0) {
-			return -1;
-		}
+		if (n < 0)
+			return n;
 		string_view_consume(&s, n);
 		last = r->offsets[i];
 	}
@@ -783,7 +778,7 @@ static int reftable_log_record_encode(const void *rec, struct string_view s,
 		return 0;
 
 	if (s.len < 2 * hash_size)
-		return -1;
+		return REFTABLE_ENTRY_TOO_BIG_ERROR;
 
 	memcpy(s.buf, r->value.update.old_hash, hash_size);
 	memcpy(s.buf + hash_size, r->value.update.new_hash, hash_size);
@@ -791,22 +786,22 @@ static int reftable_log_record_encode(const void *rec, struct string_view s,
 
 	n = encode_string(r->value.update.name ? r->value.update.name : "", s);
 	if (n < 0)
-		return -1;
+		return n;
 	string_view_consume(&s, n);
 
 	n = encode_string(r->value.update.email ? r->value.update.email : "",
 			  s);
 	if (n < 0)
-		return -1;
+		return n;
 	string_view_consume(&s, n);
 
 	n = put_var_int(&s, r->value.update.time);
 	if (n < 0)
-		return -1;
+		return n;
 	string_view_consume(&s, n);
 
 	if (s.len < 2)
-		return -1;
+		return REFTABLE_ENTRY_TOO_BIG_ERROR;
 
 	put_be16(s.buf, r->value.update.tz_offset);
 	string_view_consume(&s, 2);
@@ -814,7 +809,7 @@ static int reftable_log_record_encode(const void *rec, struct string_view s,
 	n = encode_string(
 		r->value.update.message ? r->value.update.message : "", s);
 	if (n < 0)
-		return -1;
+		return n;
 	string_view_consume(&s, n);
 
 	return start.len - s.len;
-- 
2.34.1


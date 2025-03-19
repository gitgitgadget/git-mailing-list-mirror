Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DB61C9B62
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 15:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398190; cv=none; b=UPt+6w+/z2pVb+nuKVrEnv0+OD9gFgq5ZQPq4kJXDzQiemN4vt3Vg6RH8TBwSt/M4BJUzXCPaJgtJXR967lALufUFd5z9reennDan8ka4KfgAtuvC41vZs/ZNl0yZ5Bu2eK+UgfTrmehQYaSFUszkKS8wA9MUrLzlBX+/uUbGqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398190; c=relaxed/simple;
	bh=eCqJmXbmnfHlqtGyzxAU4mH0rtHKpAbQZBB8F0dK7xA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RJjRa+yVEetpa+QMaAO6zrIvSVLJCAGOotKkOl/eaCpidNBFqCh0jerD3FekgwCgZ6y2AgY3avW2A0ABqAgaU0QjOlAv6Dxv2yyRBjO7q9dg0PC8Y9S3R6EntP/AIDdPBpmjWvp8GtEVuBD+1FgIX3XnuC9NlopgELyFeiVCMzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsblhUDS; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsblhUDS"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-225fbdfc17dso72576045ad.3
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 08:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742398186; x=1743002986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pojrb7k0iUaf6SLCizu6NSGr3KjLGA0sCocaSPwq2A8=;
        b=TsblhUDSiuWypNxpJfjKyaO7oHSMFIkhMamEGtLAXEi23z0J56usQL5P5cJwkaBO4d
         pvbc01EUf3YHmRXrIX6j8/G6hVEgrOqTOB2Ywl0CtF3Q9AIVsJBZ97GJtx1xOoPIPMmH
         4hs3ltrvGoD8aewKVLV7E8xezc5snQihJJ17kVWiHk2X7otJsSuvQ1fIxJKzuh1Rlz11
         3i+u1iHsRCy24HWJyYOz/FvjmK5iz+oKv4tPcnKOq+ciXOjvx2X+/n20/mgN5avOBlJ8
         VLdBdzkfbeFY7QzYs+hB0OrH/hCaI7GmK5mY731ls03+zOngFiWVkO+knnlKNn58O33i
         PACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742398186; x=1743002986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pojrb7k0iUaf6SLCizu6NSGr3KjLGA0sCocaSPwq2A8=;
        b=RezHFclM+TzN3x5Ccc6JRzQKOFbPr6IbHVtR/3dGPUK0tJB+3bbhHj3SOtIzulUpQx
         sU+dpO7DOZDG/tUH6obpzDGKzC2gwE3uggV+KmgYh55RAe0nGy6Nw66s55ugx/jCkf+K
         F/n7kdzniJTIh85HI/y7Z2BR8OrDFtm+GBgcX7eaOGZa0ng5zW/gtKsyqDJe0q3CzDqs
         R6RiUhEqYT3Go4lpOx/PQ3/rt1t2uOEv/4XHc72uOe3X0mt4Aru+46V8Ff5LcYcaMx24
         WSzcKHsbmPGVcUoXUAhkCF+6Igrv1yPvQp7JBH3EUTdYbRUBRIA0cLVfs3GKFBBiUtTM
         Y5Dg==
X-Gm-Message-State: AOJu0YxbvTkKzPirjgXlIhuWS9n7OCPMSDiL6h/ARqriLXx7SCe3jSHB
	pKiqIAePhzJDeUhHGTArtjuz8GENKXBxOYnO2Feq907cc2b/9S1YHZ3wOg==
X-Gm-Gg: ASbGncs0439XNDbY6/8Dfio6NU1yCI42LQE+nIRUDueKzTE+8Sh5UsmdvpqAAxkNSb3
	7vPEeKcSwSXv3naZs7NW5jLGM5+MQrJfupgpgQyR2zS383LjdxcqcKC02Bb6gfETFWJbqeEkHff
	4RMDexp3dy3w7SMsszFdsWM0Ye+RdGzjPjEjTkWQ8hqCZNdieUa86GXn8vkRtwEuDJ0n0ZZX3+B
	YpzAwJhaK3qnM1vMxJrIHdpYjjyNdxtv2bnICazmtdeCuJwaviuEqoekGNSeSjO1JjWIqc/99+s
	p+VPmN2WEZtDzHwT/TWJAXnNkCWXHdIYtFhpnvjl
X-Google-Smtp-Source: AGHT+IFuuMwwgDTeMR6uPVlgK71oNapLKnrdk3fiIzlwYiNNTdHQbfESzWEfKwicJMTDazQ75U4HsQ==
X-Received: by 2002:a17:902:e80c:b0:224:2201:84da with SMTP id d9443c01a7336-2264981b269mr40120955ad.6.1742398186127;
        Wed, 19 Mar 2025 08:29:46 -0700 (PDT)
Received: from meet.. ([103.86.19.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a6865sm115889305ad.75.2025.03.19.08.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 08:29:45 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC PATCH v5 1/3] reftable: propagate specific error codes in block_writer_add()
Date: Wed, 19 Mar 2025 20:59:25 +0530
Message-Id: <20250319152927.1263033-2-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250319152927.1263033-1-meetsoni3017@gmail.com>
References: <20250319075943.28904-1-meetsoni3017@gmail.com>
 <20250319152927.1263033-1-meetsoni3017@gmail.com>
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


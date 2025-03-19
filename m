Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F942801
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 08:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742371246; cv=none; b=MH7nfdfXE8QBo/dI8RrAqsRGgnJKOTUm7/VZqAEutStSjHnzCCh6CqS3tNI4x4OGXmf+0UgmjhHIXA0SHoekU03XNEnxZ4cS1JY1aE5CiVAF6DXLtWsdhFhRoXvn5BodAcVbpLjX9yepRPkmgM2Z82w2BUUdFviLhWyRCwfuHbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742371246; c=relaxed/simple;
	bh=eCqJmXbmnfHlqtGyzxAU4mH0rtHKpAbQZBB8F0dK7xA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tHyFLumxv3MgVZCRIDdH1ld0mane8Zci0ziWHb9ER184kAjTz2FpIpeVyZp8N+Uki0EZvnnu856AHVcpLtBEA05/xkh9NMxnf2156lcw6XxWTsTl6VFwqlfcXP9vKOpsYeeZvrDhvK+dcSouaIB42Oa60OxIG1/VjZQvlU3rRb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgfzF1rY; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgfzF1rY"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ff784dc055so7058266a91.1
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 01:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742371243; x=1742976043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pojrb7k0iUaf6SLCizu6NSGr3KjLGA0sCocaSPwq2A8=;
        b=CgfzF1rYS4GyQ8brSwy2qe8UPWRROATGz3jP567nILN0wWXege/qsTUWxQRo/c6o4c
         +HKxv5KLHR4TMBvPE3Zqaw7zoprDROdd4sxvY6knEO6Jzgc27PTaW/j3mTesgKwHCByR
         vZs2wcCeASm38UfqVyuwc1ZWEUI2byDbYnk4xDa1URTYXkrbCIJy59FafsIwnYJJZYl1
         ivDCT/oHFIClzHOawCxj2X/2LqyeEQknSJFDJ1TcEF+2Mxl2BhJ10mtTMfeEOA45oG8x
         ws5sTGDRGe13ipwgVyVzOTiDLq+O3qAc8tPX+jbPfUpeg6+XTSgzDeDbT6v9TN5ImZXq
         GvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742371243; x=1742976043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pojrb7k0iUaf6SLCizu6NSGr3KjLGA0sCocaSPwq2A8=;
        b=K5sPA5N7WYMqsRlbrkc2vGvG+69iXmvp9reRcbMt17eGDp5IGrAgSS4+0cBVN63FfJ
         E+FQB5sfNgRYdiWT2mbEDAKSTVRgWXgdzfAV2zajSOEdw492uQbXcQIgir9J66XsUi71
         X8UKC6YKJ2kfr6P1OZkOr7yn8rcdoppVMID82poGAwBqLikt68WZb8ercWbuYeZq4vAn
         Fb2X4IvvgaqtA0WU1s8XPJC7ia8wwUjcSCGOB4NPBnaKcmnNQgcaH2buGhs7OdFMLI6h
         7QAWHcZtJJCJ5+4WtsJ8JM4iOWEfqw+9K6CliQcMnATe2uS4kvOyya24ytvHh6UEZJ89
         8BEg==
X-Gm-Message-State: AOJu0Yw0oHWx4OMtjZMwz4Oi6DdRfzUF4zFMRWGwb2zmQnF9F2LFo8BM
	9Fa27R8cW1/K4R/M3idfUqI5+uP80I60YC5trGuxs+2b4lCDLlJ5VMCplA==
X-Gm-Gg: ASbGncthByf915nvJBBoY4IkiDgPvcQr3UNWN2SL95T3Ja3nd4nTZVacbCKiC1kRH9v
	4xQV0hAev6KAga7kgAxP26ccUDuStN4RYND3UBZzrBNLZuyVBKXan0JGNunvsQOhkRceQ+zPpd0
	A5ToByhYlNrxDydnuBwi1EGk1vYb25cMSYRKwDxfdbAY1TvjQtYRJL+AtjGSc4AYzXg60Yr9C5D
	e/FNtTwYv3ReSMIx0jbXVRKZYUiZiK7JLvfASlDCmfnUbfqZypgyzKQjJ/sw+G3ED9kTUiV+UEC
	zfQkNMdoG2Kx5bHhlSjQ0aBGDSHARAJAuzZ1hIQU
X-Google-Smtp-Source: AGHT+IGbIPnrdmYQbjENvgDmPeywYFNLEN19eZxsVJH3F3ViZ0SsSiDyNqJQrZisQfUx3k+1qLwfCg==
X-Received: by 2002:a17:90b:2e86:b0:2ee:edae:780 with SMTP id 98e67ed59e1d1-301bdf941bcmr2972015a91.15.1742371243164;
        Wed, 19 Mar 2025 01:00:43 -0700 (PDT)
Received: from meet.. ([103.86.19.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22629cfbcb2sm32866715ad.176.2025.03.19.01.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 01:00:42 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [PATCH v4 1/3] reftable: propagate specific error codes in block_writer_add()
Date: Wed, 19 Mar 2025 13:29:41 +0530
Message-Id: <20250319075943.28904-2-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250319075943.28904-1-meetsoni3017@gmail.com>
References: <20250312121148.1879604-1-meetsoni3017@gmail.com>
 <20250319075943.28904-1-meetsoni3017@gmail.com>
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


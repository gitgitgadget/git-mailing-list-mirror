Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD4D201022
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 12:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741263214; cv=none; b=u9U82pZaB3ZU7sgUpzIiWbT7pXaTVL4N/1O+BVqoDJwygSZPiZD+MVxr4RPpFUm5or8s4y9VTnCAgLGR+njZGQzKxr9XLcc/Y/3vAdUM2LKCvHsCJCSttFPZS6Vwsl+/CM/sgV420wDfdhmwwDiW1hgHemZ1zJJFuKgiOgu0VF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741263214; c=relaxed/simple;
	bh=8AZxnLccdSLfv5jfU/zQL9yAN7YMfU/yFQQfCFz06Bs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rcp1VkspsM2eayaKlYFnU2jodDhoNZkwPRP20p/kY/JpIFBUIaIjQ3Tfm24bcXPv/FFaOWguoh+Aq/UvS96M4QD+tJ8D9D3+h5EBs+EUXHjajJKgEGoIZfVFPsa0UB/0Eqzyp/HSSsGtfvnmk4FpWvozAm/6fFBwSzVQJ9pwdzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+Qe45OS; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+Qe45OS"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22356471820so7629725ad.0
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 04:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741263211; x=1741868011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jIeYJCaPq8VT6WU4ZAGP/RLPlw8awNKyla94/DeoP4Q=;
        b=Q+Qe45OSHHs0ONpGmOYQc9PtfvH/NeAn3atk4PNNJ5x4CeiRen2Nf+kZ2/Z9ASG0Mo
         O9NCmtNtr1b7mJ7hY6bPUxxF5BVUf20gwk+SVOEQuNLRtabTlFa9wJmv01h069/ahmNP
         dxn9agzx0aKBNxO6IVlcTgEzmNH8AxMa0gR/2ZRlf19vP9UcE6yFS+IE/nLC1Eei+Bqk
         6x1zM99iYhZ+ZuladsjdvfWDah5naROvyvtCzx48gslIlQNLFGehvDfWjzigRtCIdtCz
         5WOJMtLqtR3Zx6VqALnPHBZ0hWHQhHOM/XkZitEccPyGlGQdkeawKv13nzckMxQSQCBm
         cdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741263211; x=1741868011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jIeYJCaPq8VT6WU4ZAGP/RLPlw8awNKyla94/DeoP4Q=;
        b=ljRdNz3kM8GqmRHNjGucGo24piupSWpCbajXHoNJJBgXQFoh/WBb98yU/4MLq3CZhk
         m0FaHgqdvzUGMrpkJchM+4olSFcBkVWNro/vB+gqgs/Zh1FJA4CNpMIuxL8TSAcpxgdi
         YCn/RdY6Wjb6bnTLHMPQBJ07P3fY85/Ra5HdSnW512ej7nEtLUbhcd69U5tk80YUTK2j
         g6gVO2oZ7P0+OmxbnH/zJhUfMIZiZ3ZusdQxQitCtopst/HgMi3O0vmiM7lpD01pNHEa
         m84GaN97EIN00LWm15v4NDdXZiLn51me3GXfsCe362B3Tcy2tzpLzOVZKs5BFD2j51qO
         12+g==
X-Gm-Message-State: AOJu0Yyuwg8GOpL8luscA+p/kkMeQgrMh2bBpRu0pWYXqmUF1fMs4xkR
	fE9rSzE+JEt0HzA/K9GG8EPYkRotoL4zMjDCNyEhbQvsFauKMkcGeUb2XQ==
X-Gm-Gg: ASbGncu1MNXRU2cSVcWJtT7Owt3L3msIiy9xIdCIIsoK2cTFmm4UnLjr3ztAhTG7hCg
	OzbBJQ9AGrr4irggBDlEIIQW72pws1GclJVrGaNOumSGyhXG7U/8exJThoLdu7biN7Eagy88Bbu
	gixfg58NRaxWO04y3XDnhYslOq3Gc1G2gejfMqQkYLoqZwPBXUL13sawjColXZmOU/qOTBeCs3+
	Nwq5VOnqK0JHEzKb/yVgQsyxspqcxpCdlcAxGXjAvR8T+8TDmqwa/HwTqsWzxbUvilP7FvVGEHJ
	yV9unBKSF7R8GH/7PHsD4c/5usXaAbauEj32dscL
X-Google-Smtp-Source: AGHT+IGvoD+R9My2LU769dxO5O0jej7cKHN7w3i0qYTiovKjKbCcK3dI+hYxeuSoGs24Z8r3UOA9gg==
X-Received: by 2002:a17:903:2351:b0:223:653e:eb09 with SMTP id d9443c01a7336-223f1c6adc2mr102507145ad.7.1741263210701;
        Thu, 06 Mar 2025 04:13:30 -0800 (PST)
Received: from meet.. ([103.86.19.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e8617sm10658405ad.61.2025.03.06.04.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 04:13:30 -0800 (PST)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: Meet Soni <meetsoni3017@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Han-Wen Nienhuys <hanwen@google.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [GSoC PATCH] reftable: return proper error code from block_writer_add()
Date: Thu,  6 Mar 2025 17:43:24 +0530
Message-Id: <20250306121324.1315290-1-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, block_writer_add() used to return generic -1, which forced
an assumption about the error type.

Replace generic -1 returns in block_writer_add() and related functions
with defined error codes.

Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
This patch attempts to avoid making an assumption regarding error codes
returned by block_writer_add().
 reftable/block.c  |  9 +++++----
 reftable/record.c | 16 +++++++++++-----
 reftable/writer.c |  8 +-------
 3 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index b14a8f1259..50fbac801a 100644
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
@@ -115,8 +115,9 @@ int block_writer_add(struct block_writer *w, struct reftable_record *rec)
 	int err;
 
 	err = reftable_record_key(rec, &w->scratch);
-	if (err < 0)
+	if (err < 0) {
 		goto done;
+	}
 
 	if (!w->scratch.len) {
 		err = REFTABLE_API_ERROR;
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
diff --git a/reftable/record.c b/reftable/record.c
index 8919df8a4d..5523804a0c 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -148,18 +148,18 @@ int reftable_encode_key(int *restart, struct string_view dest,
 	uint64_t suffix_len = key.len - prefix_len;
 	int n = put_var_int(&dest, prefix_len);
 	if (n < 0)
-		return -1;
+		return REFTABLE_ENTRY_TOO_BIG_ERROR;
 	string_view_consume(&dest, n);
 
 	*restart = (prefix_len == 0);
 
 	n = put_var_int(&dest, suffix_len << 3 | (uint64_t)extra);
 	if (n < 0)
-		return -1;
+		return REFTABLE_ENTRY_TOO_BIG_ERROR;
 	string_view_consume(&dest, n);
 
 	if (dest.len < suffix_len)
-		return -1;
+		return REFTABLE_ENTRY_TOO_BIG_ERROR;
 	memcpy(dest.buf, key.buf + prefix_len, suffix_len);
 	string_view_consume(&dest, suffix_len);
 
@@ -1144,14 +1144,20 @@ static struct reftable_record_vtable reftable_index_record_vtable = {
 
 int reftable_record_key(struct reftable_record *rec, struct reftable_buf *dest)
 {
-	return reftable_record_vtable(rec)->key(reftable_record_data(rec), dest);
+	int key_len = reftable_record_vtable(rec)->key(reftable_record_data(rec), dest);
+	if (key_len < 0)
+		return REFTABLE_ENTRY_TOO_BIG_ERROR;
+	return key_len;
 }
 
 int reftable_record_encode(struct reftable_record *rec, struct string_view dest,
 			   uint32_t hash_size)
 {
-	return reftable_record_vtable(rec)->encode(reftable_record_data(rec),
+	int encode_len = reftable_record_vtable(rec)->encode(reftable_record_data(rec),
 						   dest, hash_size);
+	if (encode_len < 0)
+		return REFTABLE_ENTRY_TOO_BIG_ERROR;
+	return encode_len;
 }
 
 int reftable_record_copy_from(struct reftable_record *rec,
diff --git a/reftable/writer.c b/reftable/writer.c
index f3ab1035d6..600ba5441b 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -327,16 +327,10 @@ static int writer_add_record(struct reftable_writer *w,
 		goto done;
 
 	/*
-	 * Try to add the record to the writer again. If this still fails then
-	 * the record does not fit into the block size.
-	 *
-	 * TODO: it would be great to have `block_writer_add()` return proper
-	 *       error codes so that we don't have to second-guess the failure
-	 *       mode here.
+	 * Try to add the record to the writer again.
 	 */
 	err = block_writer_add(w->block_writer, rec);
 	if (err) {
-		err = REFTABLE_ENTRY_TOO_BIG_ERROR;
 		goto done;
 	}
 

base-commit: e969bc875963a10890d61ba84eab3a460bd9e535
-- 
2.34.1


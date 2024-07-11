Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5203A260
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 04:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720670981; cv=none; b=GRFUiI69Y7rOJJCuMLoIYYSi1KfPv9q7tIkRYaJUtv3LwEQs5NL7QJSNQSZ2UJkQyxr18POVj9n7QWQnl2v01gKQGEJCizsmUeb0GXUVCq7kFtEbMfQ58+X+dPuruvxn5Zsr6/u/aO6b+B4XH5i8bEW05+/zRi8ozboswcsWTjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720670981; c=relaxed/simple;
	bh=p9vdsqA8INI6j87KT4tGY3L12nlA/SjVsWGqp3tXw/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFTDhMNQAFXCJVDrO8RAb+83J9/dmkPsG7it+kPDOcoanY2Mm4Q+rcl/qWHcSkq3Prb5wo5m4374XQTpOC5WFUXTjORQhmFamHeD4/3d3zpnpTC25Zmb2uueblhPhbDBwgePjqf6Nth+7+5v8Zmaj9wSEYhWKho1fMhGl71YDm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdNFyV5i; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdNFyV5i"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f4c7b022f8so3008995ad.1
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 21:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720670979; x=1721275779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLo1K34oz7262vJ6ATT0KSQPg/ZkTE1BtTDCT19l9vg=;
        b=cdNFyV5i097eQmE/UoYrrTSqj4kH2xWrKyaQJAkTOH95Uc2VKWsw54C/s+2QJMBUES
         uj7O2/xx7hKOTeDcslY8vPn1X4gaNWf7oCKqqrvod/z1S519CGxZ3dvC1a4i2voAh7LB
         DHRXqQ8ZHt/XzSQf9PTyYJb1dCI/DijUMRMbhl5WQxwK5+IY657lNuLEcmYcpmhIhk4n
         eW9l3Hg2wqiz/d2ZCRMP95qtTPujTc9Hj0qTVHvVafiwpJnv7OifMR2LO6932krun6WX
         u+oHnW8EvFRiy1jZ7UsulNs4/ag2K6trCcKxXrgOICnU40Wjw5lkBjB7+kb/ZQAV2vJc
         tsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720670979; x=1721275779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLo1K34oz7262vJ6ATT0KSQPg/ZkTE1BtTDCT19l9vg=;
        b=C+EyjHfJ0vG0bSQNsR0mrbD4Uk+q8K1IthXDPTW0VnnivwbBKQwPqBM2lII7ywlnsp
         5wzI9sacJJZKgbR9+rNLDF2AeNjD4TGw36NS6BTQLr5gozX+J/NTJOYAyXCk2UwrjW0a
         BK2B9GVVjpBtEKKDVJW3vFXzLo6elQZR+OCSGKbvz+VTZYmEG7YVom8cW7WZ2toG0Mxi
         zyArT4BdXxtaBepPYLR2sxLi3D8Hn+Po5MTU/tNsBygc2k6CE6mGSoMNMP9yqAEJr5gV
         4t4r7EFzqlnjAuo8HTQhldyJHKxUGs4pb7X0BnRYh4SzdBsqYGA/i0JnFvzRei4TNM99
         juXA==
X-Gm-Message-State: AOJu0YwSuQxIePdklPwdi1rLrMSUPtIkpjijdUlRrXS7K7q5pRflvW6f
	8WFkyxDEdgsow1r/lKaDCl9HMbagCj203bXM7fgCDBpCarnp2Bze7MWxcnfI
X-Google-Smtp-Source: AGHT+IG8OgkbSmIyqV5W2Z8FrtSyPHkpXb2gBnLbc6iqRHdmJzIYyec4Hekdjx8ze70hySIKi/bZZg==
X-Received: by 2002:a17:902:f541:b0:1fb:8864:e20 with SMTP id d9443c01a7336-1fbb6d03e33mr60313995ad.23.1720670978599;
        Wed, 10 Jul 2024 21:09:38 -0700 (PDT)
Received: from Ubuntu.. ([106.206.206.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fbb6abf738sm40808595ad.198.2024.07.10.21.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 21:09:38 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	chriscool@tuxfamily.org
Subject: [PATCH v3 2/7] t: harmonize t-reftable-merged.c with coding guidelines
Date: Thu, 11 Jul 2024 09:28:31 +0530
Message-ID: <20240711040854.4602-3-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240711040854.4602-1-chandrapratap3519@gmail.com>
References: <20240709053847.4453-1-chandrapratap3519@gmail.com>
 <20240711040854.4602-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Harmonize the newly ported test unit-tests/t-reftable-merged.c
with the following guidelines:
- Single line control flow statements like 'for' and 'if'
  must omit curly braces.
- Structs must be 0-initialized with '= { 0 }' instead of '= { NULL }'.
- Array indices must be of type 'size_t', not 'int'.
- It is fine to use C99 initial declaration in 'for' loop.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-merged.c | 52 ++++++++++++--------------------
 1 file changed, 20 insertions(+), 32 deletions(-)

diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index 78a864a54f..a984116619 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -40,12 +40,10 @@ static void write_test_table(struct strbuf *buf,
 	struct reftable_writer *w = NULL;
 	for (i = 0; i < n; i++) {
 		uint64_t ui = refs[i].update_index;
-		if (ui > max) {
+		if (ui > max)
 			max = ui;
-		}
-		if (ui < min) {
+		if (ui < min)
 			min = ui;
-		}
 	}
 
 	w = reftable_new_writer(&strbuf_add_void, &noop_flush, buf, &opts);
@@ -68,7 +66,6 @@ static void write_test_log_table(struct strbuf *buf,
 				 struct reftable_log_record logs[], int n,
 				 uint64_t update_index)
 {
-	int i = 0;
 	int err;
 
 	struct reftable_write_options opts = {
@@ -79,7 +76,7 @@ static void write_test_log_table(struct strbuf *buf,
 	w = reftable_new_writer(&strbuf_add_void, &noop_flush, buf, &opts);
 	reftable_writer_set_limits(w, update_index, update_index);
 
-	for (i = 0; i < n; i++) {
+	for (int i = 0; i < n; i++) {
 		int err = reftable_writer_add_log(w, &logs[i]);
 		check(!err);
 	}
@@ -121,8 +118,7 @@ merged_table_from_records(struct reftable_ref_record **refs,
 
 static void readers_destroy(struct reftable_reader **readers, size_t n)
 {
-	int i = 0;
-	for (; i < n; i++)
+	for (size_t i = 0; i < n; i++)
 		reftable_reader_free(readers[i]);
 	reftable_free(readers);
 }
@@ -148,9 +144,8 @@ static void t_merged_single_record(void)
 	struct reftable_reader **readers = NULL;
 	struct reftable_merged_table *mt =
 		merged_table_from_records(refs, &bs, &readers, sizes, bufs, 2);
-	int i;
-	struct reftable_ref_record ref = { NULL };
-	struct reftable_iterator it = { NULL };
+	struct reftable_ref_record ref = { 0 };
+	struct reftable_iterator it = { 0 };
 	int err;
 
 	merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
@@ -164,9 +159,8 @@ static void t_merged_single_record(void)
 	reftable_iterator_destroy(&it);
 	readers_destroy(readers, 2);
 	reftable_merged_table_free(mt);
-	for (i = 0; i < ARRAY_SIZE(bufs); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(bufs); i++)
 		strbuf_release(&bufs[i]);
-	}
 	reftable_free(bs);
 }
 
@@ -226,12 +220,12 @@ static void t_merged_refs(void)
 	struct reftable_reader **readers = NULL;
 	struct reftable_merged_table *mt =
 		merged_table_from_records(refs, &bs, &readers, sizes, bufs, 3);
-	struct reftable_iterator it = { NULL };
+	struct reftable_iterator it = { 0 };
 	int err;
 	struct reftable_ref_record *out = NULL;
 	size_t len = 0;
 	size_t cap = 0;
-	int i = 0;
+	size_t i;
 
 	merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
 	err = reftable_iterator_seek_ref(&it, "a");
@@ -240,7 +234,7 @@ static void t_merged_refs(void)
 	check_int(reftable_merged_table_min_update_index(mt), ==, 1);
 
 	while (len < 100) { /* cap loops/recursion. */
-		struct reftable_ref_record ref = { NULL };
+		struct reftable_ref_record ref = { 0 };
 		int err = reftable_iterator_next_ref(&it, &ref);
 		if (err > 0)
 			break;
@@ -251,18 +245,15 @@ static void t_merged_refs(void)
 	reftable_iterator_destroy(&it);
 
 	check_int(ARRAY_SIZE(want), ==, len);
-	for (i = 0; i < len; i++) {
+	for (i = 0; i < len; i++)
 		check(reftable_ref_record_equal(want[i], &out[i],
 						 GIT_SHA1_RAWSZ));
-	}
-	for (i = 0; i < len; i++) {
+	for (i = 0; i < len; i++)
 		reftable_ref_record_release(&out[i]);
-	}
 	reftable_free(out);
 
-	for (i = 0; i < 3; i++) {
+	for (i = 0; i < 3; i++)
 		strbuf_release(&bufs[i]);
-	}
 	readers_destroy(readers, 3);
 	reftable_merged_table_free(mt);
 	reftable_free(bs);
@@ -358,12 +349,12 @@ static void t_merged_logs(void)
 	struct reftable_reader **readers = NULL;
 	struct reftable_merged_table *mt = merged_table_from_log_records(
 		logs, &bs, &readers, sizes, bufs, 3);
-	struct reftable_iterator it = { NULL };
+	struct reftable_iterator it = { 0 };
 	int err;
 	struct reftable_log_record *out = NULL;
 	size_t len = 0;
 	size_t cap = 0;
-	int i = 0;
+	size_t i = 0;
 
 	merged_table_init_iter(mt, &it, BLOCK_TYPE_LOG);
 	err = reftable_iterator_seek_log(&it, "a");
@@ -372,7 +363,7 @@ static void t_merged_logs(void)
 	check_int(reftable_merged_table_min_update_index(mt), ==, 1);
 
 	while (len < 100) { /* cap loops/recursion. */
-		struct reftable_log_record log = { NULL };
+		struct reftable_log_record log = { 0 };
 		int err = reftable_iterator_next_log(&it, &log);
 		if (err > 0)
 			break;
@@ -383,10 +374,9 @@ static void t_merged_logs(void)
 	reftable_iterator_destroy(&it);
 
 	check_int(ARRAY_SIZE(want), ==, len);
-	for (i = 0; i < len; i++) {
+	for (i = 0; i < len; i++)
 		check(reftable_log_record_equal(want[i], &out[i],
 						 GIT_SHA1_RAWSZ));
-	}
 
 	merged_table_init_iter(mt, &it, BLOCK_TYPE_LOG);
 	err = reftable_iterator_seek_log_at(&it, "a", 2);
@@ -397,14 +387,12 @@ static void t_merged_logs(void)
 	check(reftable_log_record_equal(&out[0], &r3[0], GIT_SHA1_RAWSZ));
 	reftable_iterator_destroy(&it);
 
-	for (i = 0; i < len; i++) {
+	for (i = 0; i < len; i++)
 		reftable_log_record_release(&out[i]);
-	}
 	reftable_free(out);
 
-	for (i = 0; i < 3; i++) {
+	for (i = 0; i < 3; i++)
 		strbuf_release(&bufs[i]);
-	}
 	readers_destroy(readers, 3);
 	reftable_merged_table_free(mt);
 	reftable_free(bs);
@@ -422,7 +410,7 @@ static void t_default_write_opts(void)
 		.update_index = 1,
 	};
 	int err;
-	struct reftable_block_source source = { NULL };
+	struct reftable_block_source source = { 0 };
 	struct reftable_table *tab = reftable_calloc(1, sizeof(*tab));
 	uint32_t hash_id;
 	struct reftable_reader *rd = NULL;
-- 
2.45.GIT


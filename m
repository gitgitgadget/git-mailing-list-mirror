Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A8813D516
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 05:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720503568; cv=none; b=Par8uWpDy06K8uG94Ju/I33hc7iAaon0dMHj6VteDqhyGlgmrIv12EQzEoeCD+UtmgEmRUzqndJBuoRha8bYkKhgK33E19AnHus014y9oy7iYrNgIY1yE5wY9lNcaokWnhlNe0JXAreQljlTFbq+TEs4TN0o6mc0RiY/T3HvAnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720503568; c=relaxed/simple;
	bh=SBC4j23TKqNQEOoJltnSzX7uGoPUaqtKhjdAukHsbug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUiebnSMA35YTQRuGnlXY6PzD38/LjtMgvyX5dMb685/EIFzmgw/uPFawh8R8u5TSAqWTc0UZpVjHuqNYFwikIEsB/pYdIi/6gecFDo5IVDkxDJHBudPR1F9mOSib5xvL+7w4BlebkyE7GUtMT/vcBYGLR2Vb0prDVj01aTds28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uj3XqhQd; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uj3XqhQd"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-706a1711ee5so2751992b3a.0
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 22:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720503566; x=1721108366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVve2uX7NQmpNx21gMmznjyJyKMUr40krED/uuYLUqA=;
        b=Uj3XqhQdaNBvPCAS9gu1vOz5vIvaC8eP2EbNN54NBqdoz6mEpVg5gVGrrp2R5v919P
         2MN4CCgMSzkOEF7cKJg4gfJjewt/m/m20464ynNgzKGxCwGDRTAeAwVY+SDUaQ9dPh9u
         w9DFzgnGl9Jbuw06i/aMgF/3iIPINE8Br1YeJe5hu/aZOmAiTfnQdJZdc0i4MR2dmbZH
         QTCqrs1zyEraaJOcix/A577bnTZWC1lh4yjAePyn/7UFxu6Vwfq4d2MrshCep+FlDKC0
         to76sqakqjW7PvUu639ipd2+g3iaoJgYEEM/MChHbb12pOp0lG43OMI8bohJvPWYf0EL
         vGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720503566; x=1721108366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVve2uX7NQmpNx21gMmznjyJyKMUr40krED/uuYLUqA=;
        b=QvMOe97PxzWb9FV8zR5DfWa6OMIbveEGY6N0ZVnF5DVvlFSvFIpSUKL01Z1FYlZORo
         1HmcBQi9r0YEzB64ne8so+oT/9f3ZSt6pDYjwpzVKELnRGBPt+1cw8fltCU6Sf59fcko
         ixkT+39tdN+8qaRy6niQVH7ICQ7qaiemh6O6wE9mJniBmQDoi7yYgXhcFlTmS5gOO8XG
         lDXYC0bGEg4yCdy52/nJlVMCM8q19xfk7SVWIEmxX4Bd9m6X67KbFi1NjCHxQrMVx+Hn
         ayXCqJYXa9Jauy/+azooA4csllb1qgLef9jR+P552Yl5i5ozwW8lnd/MwAWxPRGwF6lq
         e34w==
X-Gm-Message-State: AOJu0YyNeBsfq003B1sj6GN43SIW0NY2D8B0QtwAqKK8fxvHE3b16w2k
	visAR3H4kbQ7shVrAwN2WJSKINo5AfnWi/AXwE7kibP4jhNeD3GHPui2Cg==
X-Google-Smtp-Source: AGHT+IGuBn4V/HaV+eKQ47jJQwy7IWYb1JtgJz1HNG7W1Gz3KNBzc2L5BWF0UC5UWMISVyZuKsANiw==
X-Received: by 2002:a05:6a00:1249:b0:70a:9672:c3a2 with SMTP id d2e1a72fcca58-70b43632384mr1722608b3a.24.1720503565738;
        Mon, 08 Jul 2024 22:39:25 -0700 (PDT)
Received: from Ubuntu.. ([117.96.144.60])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-77d61922ee6sm718448a12.46.2024.07.08.22.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 22:39:25 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: chriscool@tuxfamily.org,
	karthik.188@gmail.com
Subject: [PATCH v2 3/7] t-reftable-merged: improve the test t_merged_single_record()
Date: Tue,  9 Jul 2024 10:58:42 +0530
Message-ID: <20240709053847.4453-4-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240709053847.4453-1-chandrapratap3519@gmail.com>
References: <20240703171131.3929-1-chandrapratap3519@gmail.com>
 <20240709053847.4453-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In t-reftable-merged.c, the test t_merged_single_record() ensures
that a ref ('a') which occurs in only one of the records ('r2')
can be retrieved. Improve this test by adding another record 'r3'
to ensure that ref 'a' only occurs in 'r2' and that merged tables
don't simply read the last record.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-merged.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index a984116619..85ebb96aaa 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -136,14 +136,19 @@ static void t_merged_single_record(void)
 		.update_index = 2,
 		.value_type = REFTABLE_REF_DELETION,
 	} };
+	struct reftable_ref_record r3[] = { {
+		.refname = (char *) "c",
+		.update_index = 3,
+		.value_type = REFTABLE_REF_DELETION,
+	} };
 
-	struct reftable_ref_record *refs[] = { r1, r2 };
-	int sizes[] = { 1, 1 };
-	struct strbuf bufs[2] = { STRBUF_INIT, STRBUF_INIT };
+	struct reftable_ref_record *refs[] = { r1, r2, r3 };
+	int sizes[] = { 1, 1, 1 };
+	struct strbuf bufs[3] = { STRBUF_INIT, STRBUF_INIT, STRBUF_INIT };
 	struct reftable_block_source *bs = NULL;
 	struct reftable_reader **readers = NULL;
 	struct reftable_merged_table *mt =
-		merged_table_from_records(refs, &bs, &readers, sizes, bufs, 2);
+		merged_table_from_records(refs, &bs, &readers, sizes, bufs, 3);
 	struct reftable_ref_record ref = { 0 };
 	struct reftable_iterator it = { 0 };
 	int err;
@@ -157,7 +162,7 @@ static void t_merged_single_record(void)
 	check_int(ref.update_index, ==, 2);
 	reftable_ref_record_release(&ref);
 	reftable_iterator_destroy(&it);
-	readers_destroy(readers, 2);
+	readers_destroy(readers, 3);
 	reftable_merged_table_free(mt);
 	for (size_t i = 0; i < ARRAY_SIZE(bufs); i++)
 		strbuf_release(&bufs[i]);
-- 
2.45.2.404.g9eaef5822c


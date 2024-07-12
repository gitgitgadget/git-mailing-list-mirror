Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7231B95B
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 05:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720763485; cv=none; b=m3cDJHQFIJ43Ebi38FAXNqs6gCb7F47M0/g7ggfrF244HK+r10gjBh4wW1KsfxAh9ssNtuSdCJoxhY7WnrG/GtXu5uGSGV50mNuX33/NKHNHheglFc5Ed1lxu0Wg5bnIsayHmkO559TWUvVTHYbKSebo02by5eFEZZ4Jfs00KrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720763485; c=relaxed/simple;
	bh=f2Sbh2heCKQcNJ8mb2dmVaRoUS33YqrWMcVpX1q1SMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ijtqi75V8l8c89LvXBzamQTNWIRneTdj0iZtYi8ViGlFqWkqJzeZu7h8xGzs0T6iBaHi8UuZc/+ofS2e6WZWHizaGdeVcvHP1o27SSb0rnVnouva7/zsSDBmpQjgmN2J/adPszJ4ErEpSJNEr6qLY5h4+U3SbkIhJVMimmWl5IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzsO1/8a; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzsO1/8a"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-24c9f6338a4so790310fac.1
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 22:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720763483; x=1721368283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgJJBde9ffSE7VKVjTMj0Hursv5/fM5fL/5VoEKfEgE=;
        b=CzsO1/8aGtINRQzyUpqP9BI4d03Ei5/klTXq3PgSjHO8qZxLPKTfXNKo5TAExmS9ZN
         fhJy8DySx2vZvV5ugXufh7xYiZ7+ukEzHB3NHVtgVkhLUGMJGH/HV0Xl6p5e43X+7GYt
         8as2keqX89vf5C2iH60ru2Ad66YIzf7Ae3yWsop0e0MGt5+mVsr7ga+y5ssl1RCePMZz
         RJiEo9WVDMcw0i+FlxLVDtvQDmHKxcUruw/qLlJOZiBtevRCYLN2mIr6X92760DuIIvE
         o7prvaApLtSitzPtCq2DCs66cLcyQtYDRFJJj+tDuc5hsxRoBJlxQffrrirNI5zAuVnC
         VqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720763483; x=1721368283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgJJBde9ffSE7VKVjTMj0Hursv5/fM5fL/5VoEKfEgE=;
        b=NTA4gvmikPLez54Hk2gRllg4VXFt4AFfX/zdRCMiN4AN8Yzx8iBNxx+lxyUCS0aTOu
         hQoTZ/apvj2+xQFKDfCQBGe3dLpqWoDy0Yu3mTcCWmVjlgrh99gPpFuZe0H9+c0+/PzG
         azP6ZPDD3ja/UcQvWjmni36UQG43ph4Rs2eD7EUAfmLH+dqWmIOAietRjJDq/f33NO6G
         RNc2XWvyQSN7WK+KWI4WMQ2yoygGqEZznizGz3avnPGNuU4SOWRA1H1tuQ0uUYFtdPeq
         6RyToTu3/ksKA7SmEeCRKx8danxU4hkUVVkP8oHDwK8JAmdZ6/ssfjxdWlj2FPd64NRp
         dohw==
X-Gm-Message-State: AOJu0Yz+xE+eA/lhi+n7IvE49sP7TO3wgtCXYYF+tqxLgCDhEpNydPXJ
	/4ucMFM3vbKauPDNeDnsCOc9gM7AnGLwECkXMgELHe8mjLqstNYZbHewZw==
X-Google-Smtp-Source: AGHT+IF+Kf5PDPIsDKf6cVomwJ5pVTMKVQmF/uuP5E0anWYcDEb6shdkJQyoWcirzfgZqcNtM5qCLg==
X-Received: by 2002:a05:6870:9112:b0:25e:e94:1e91 with SMTP id 586e51a60fabf-25eaec40487mr8012096fac.58.1720763482534;
        Thu, 11 Jul 2024 22:51:22 -0700 (PDT)
Received: from Ubuntu.. ([117.96.148.106])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70b4397f475sm6604651b3a.150.2024.07.11.22.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 22:51:22 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	chriscool@tuxfamily.org
Subject: [PATCH v4 3/7] t-reftable-merged: improve the test t_merged_single_record()
Date: Fri, 12 Jul 2024 11:08:59 +0530
Message-ID: <20240712055041.6476-4-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240712055041.6476-1-chandrapratap3519@gmail.com>
References: <20240711040854.4602-1-chandrapratap3519@gmail.com>
 <20240712055041.6476-1-chandrapratap3519@gmail.com>
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
index 9791f53418..f4c14c5d47 100644
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
-	size_t sizes[] = { ARRAY_SIZE(r1), ARRAY_SIZE(r2) };
-	struct strbuf bufs[2] = { STRBUF_INIT, STRBUF_INIT };
+	struct reftable_ref_record *refs[] = { r1, r2, r3 };
+	size_t sizes[] = { ARRAY_SIZE(r1), ARRAY_SIZE(r2), ARRAY_SIZE(r3) };
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
2.45.GIT


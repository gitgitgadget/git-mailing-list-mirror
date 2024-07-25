Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45940198832
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 09:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721900386; cv=none; b=bSsVOx0T6aAzY0fYmJRIDYNbsIg9ewvzbxBQ2Xq270Zq24bCfPpvPWMT5PZ6s++hdetA1JQEhIUTLKavISkktaul9L2eNsjkBsp8jxL2CZXacLUvJ/42bOpIOkSXzQHpoiQYdpO/LmcTrdsuwBjwMhltms4BVbZnh5mo4EwmLj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721900386; c=relaxed/simple;
	bh=ykDHJvOTCiZrkMlDm6D0QFWaClkYj6yKEwzLATURDQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eijljKxe78vgbYOO6gJ0VcadcrYZKldV6PZ/uBlFMxjfnt/1s//Xof6MSlK+yy4I/avXnRLgzAl4uWBrlQmnTdNI1BiE/ilxFppfLoHv+dPBj++UAYjf9n80328487a4XeISbAY2xW5A6BBu7PGM0yFUziSwTm4VQCGbJnt5Nus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCKy7fRw; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCKy7fRw"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc65329979so5741595ad.0
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 02:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721900384; x=1722505184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfg9mp0L4g3LaRMRZFYSMGJhe53+0XvEwoSveAwgzKg=;
        b=HCKy7fRwRbGBvAwpRMX6Qb1j0xmk0sDxImk/VSDXELfX267ZA7+LumePVz5mp5zHTE
         E9OwHha1OmWnwYtwZQ1FPCSLMdHKUe7iweAn1ogRp8sxB48aI8VVhh9Qo0eWBgVk0kHh
         iYrS10MUodGvV/s2K2aCj36Z2nFRWTJqAo/B931QUlx7gvwslzSilztlh1aBoClOC4JZ
         7JzsyyEr4yK4unPZJ0JJYy473ptyCwxdYPw7fhPSFAgwv9PviyP3JZ6kX8MMaUYp4h5q
         60swdyW2UVZTq/XtIDYy54Y43VedFmUXY1rgb81xFtTR6EQB/qRtZl+Ze422sWtyTMr8
         ivmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721900384; x=1722505184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfg9mp0L4g3LaRMRZFYSMGJhe53+0XvEwoSveAwgzKg=;
        b=YniGIMKLnDv1SmaP0kggJZbhr8j71GYMt+ihuY1Rnr4O2+TvRUcyZE+dEASJPo07sp
         1QYLjM7yG74NZaTZ7xFF6RHkygdYfJS4V+XRggVFBHWMCfI2TIRR+EuutLxIF1DJZwFH
         CIewTps6rEXr7QonhVGgtQvjnU2GEdK7KR+XsPAm0hYQI9MWIu0zIavLUMa84S73zvrV
         rKBQ+zkb3xgN0dg7YJ7j0oFh2zWGaEjuZ+iBcasV4IyJnO76OLcfaGb4vEcdF8xpZiNU
         /QDqeIdgAG9VT4Cunt9uVE4smoJ6ajG4E5UuFA0aIl6FCfpx0lYnmY6vzM+R3SNpUwl/
         8Hng==
X-Gm-Message-State: AOJu0Yw99waviymW3gWWC7QcxbEWxjll314SFKCZo+lTyBcYh4shgEdm
	UZuMlaedc1+AzysoZz7xBVPGDFA6wb6gKZjng1KGs9SahQtG4OBSKjV2iA==
X-Google-Smtp-Source: AGHT+IHSq65UyvETJMNi+wM0y4QmAbm2BkqPY1mf8icCuGtOIg7TDBmDX68FyjgpsUUsZM7Z3QxmxA==
X-Received: by 2002:a17:902:db05:b0:1fb:6151:f62f with SMTP id d9443c01a7336-1fed9283ec1mr15312805ad.28.1721900384142;
        Thu, 25 Jul 2024 02:39:44 -0700 (PDT)
Received: from Ubuntu.. ([117.96.151.20])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fed7cf1db4sm9950895ad.87.2024.07.25.02.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 02:39:43 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 6/7] t-reftable-pq: add test for index based comparison
Date: Thu, 25 Jul 2024 14:55:58 +0530
Message-ID: <20240725093855.4201-7-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240725093855.4201-1-chandrapratap3519@gmail.com>
References: <20240723143032.4261-1-chandrapratap3519@gmail.com>
 <20240725093855.4201-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When comparing two entries, the priority queue as defined by
reftable/pq.{c, h} first compares the entries on the basis of
their ref-record's keys. If the keys turn out to be equal, the
comparison is then made on the basis of their update indices
(which are never equal).

In the current testing setup, only the case for comparison on
the basis of ref-record's keys is exercised. Add a test for
index-based comparison as well. Rename the existing test to
reflect its nature of only testing record-based comparison.

While at it, replace 'strbuf_detach' with 'xstrfmt' to assign
refnames in the existing test. This makes the test conciser.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-pq.c | 49 +++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/t/unit-tests/t-reftable-pq.c b/t/unit-tests/t-reftable-pq.c
index 9230dd9b9e..67f3e4546c 100644
--- a/t/unit-tests/t-reftable-pq.c
+++ b/t/unit-tests/t-reftable-pq.c
@@ -18,7 +18,7 @@ static void merged_iter_pqueue_check(const struct merged_iter_pqueue *pq)
 	}
 }
 
-static void t_pq(void)
+static void t_pq_record(void)
 {
 	struct merged_iter_pqueue pq = { 0 };
 	struct reftable_record recs[54];
@@ -26,11 +26,8 @@ static void t_pq(void)
 	char *last = NULL;
 
 	for (i = 0; i < N; i++) {
-		struct strbuf refname = STRBUF_INIT;
-		strbuf_addf(&refname, "%02"PRIuMAX, (uintmax_t)i);
-
 		reftable_record_init(&recs[i], BLOCK_TYPE_REF);
-		recs[i].u.ref.refname = strbuf_detach(&refname, NULL);
+		recs[i].u.ref.refname = xstrfmt("%02"PRIuMAX, (uintmax_t)i);
 	}
 
 	i = 1;
@@ -59,9 +56,49 @@ static void t_pq(void)
 	merged_iter_pqueue_release(&pq);
 }
 
+static void t_pq_index(void)
+{
+	struct merged_iter_pqueue pq = { 0 };
+	struct reftable_record recs[13];
+	char *last = NULL;
+	size_t N = ARRAY_SIZE(recs), i;
+
+	for (i = 0; i < N; i++) {
+		reftable_record_init(&recs[i], BLOCK_TYPE_REF);
+		recs[i].u.ref.refname = (char *) "refs/heads/master";
+	}
+
+	i = 1;
+	do {
+		struct pq_entry e = {
+			.rec = &recs[i],
+			.index = i,
+		};
+
+		merged_iter_pqueue_add(&pq, &e);
+		merged_iter_pqueue_check(&pq);
+		i = (i * 7) % N;
+	}
+	while (i != 1);
+
+	for (i = N - 1; i > 0; i--) {
+		struct pq_entry e = merged_iter_pqueue_remove(&pq);
+		merged_iter_pqueue_check(&pq);
+
+		check(reftable_record_type(e.rec) == BLOCK_TYPE_REF);
+		check_int(e.index, ==, i);
+		if (last)
+			check_str(last, e.rec->u.ref.refname);
+		last = e.rec->u.ref.refname;
+	}
+
+	merged_iter_pqueue_release(&pq);
+}
+
 int cmd_main(int argc, const char *argv[])
 {
-	TEST(t_pq(), "pq works");
+	TEST(t_pq_record(), "pq works with record-based comparison");
+	TEST(t_pq_index(), "pq works with index-based comparison");
 
 	return test_done();
 }
-- 
2.45.GIT


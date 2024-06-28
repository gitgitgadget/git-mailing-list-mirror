Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311A37F7CA
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 06:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719556646; cv=none; b=XI3pStyYvWe0T4nemnIYx0cAgRgRyPYij4oMuktUBsTsC7Tyuv0NjULZ3A18UIfFvFYOMFHV8ij7mrQYYAMvv7RSuGS+FB/ZaqEh1juRtOdOgfr6Yzy62NZERpxTj9LXHnGFQec6tG7+7YlhKqR8/nij4MD8B59bR8d4xy8ixCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719556646; c=relaxed/simple;
	bh=J6fRcqA9KNuIkIUbPTwYxCsvDGvdQNDbL1BjmF+9fKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpTCqVqCiwqscpbrxCYSNxHDYSGcStYaNT0BtuJ6ITKSk7o9+B0ObeS9DyDJnS3KiTtgatNouhz26qj+zWLC/4H4/2RGdZMvXcCCFLgDRu0zMOpVfiAS0jUCZyJ8JtOJL1S1rckA+f3r9HcRzZQdQBu/ZWR3lJd/mMnC34sEnog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIEaUqi0; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIEaUqi0"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-706524adf91so230479b3a.2
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 23:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719556644; x=1720161444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mR1gYwxf1gvJkrmxV64urSShT49X2F6oNEtOnMdN/bs=;
        b=IIEaUqi0TTdzlwjqLsI4MAZw/yMY60WqLokmo4sawOSS12UKDR0vaJzcDNXpFlrsTv
         azXNwZt5P6LqNxpBjPylUtKPnVD2rIgTXB6S980fG9Tmxa+1+/V7ZcAf5ir4+VxVWFHW
         lnN6gYhE0oftUILGg/2obbeVufYEUtBtawfZx6CcMZ20cOF7Aao+Fjzzd1gf88GBANaY
         4o4WcYP9O3/ASw3NB0j95JJKAhYFFnF7IJRezp92FUpT305WAuNgTvC6uBPbogpjrNN+
         KKwuzbm6cyNzJ+IP6FiLjr6+EIBNGwwryZzusrnYKQ5ugPXUQYMWCjej6ECV229yEmlt
         Hddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719556644; x=1720161444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mR1gYwxf1gvJkrmxV64urSShT49X2F6oNEtOnMdN/bs=;
        b=JqZsdbUrvdnXVCXMwW5GbhblC01qqYyYfI2wnLq9CwHAzIS/iPmsuMlICW0ZOGxKmU
         ZxXQK768ebX2CAv9rWHzq3Obiom9WX83RLoYxz4psCnnsbYhgXh6XX2O9KM/K+ibfPEx
         iPbTXubiKHvLjEfvqN5gspJGEtiFmuWk/4ErdeYh9bZwBQY4QbZR4awenEnLbnEiAUZY
         R6jGAcdyrpSDn3nr+3sQVN3ZHJCbOW6Jiz8COpsIpdT9EeAB20HFeF7GRjsMUUWTgd3P
         EDCl7mXCXrCryHEBaPKnx8dkcxyb2MZo+RdYa2fFJCCOHZel7M7djg2wlHWo0Allbre0
         +8Aw==
X-Gm-Message-State: AOJu0Yx0gTKTs+3jzD4w+S14ztuPXfDsZSdgfFj6Z8OfI48ULo0IoJU/
	N93YSTBkr67RKuOQy7jGCpu7LSsD8pr8xReKYSNOsfXRltZj0br+c+jEAQ5HJMg=
X-Google-Smtp-Source: AGHT+IG4eeMNHQfdtLl/8AZuMcIUnIQOFBgUHhA72CkZPDAk3A1ap3P7ECAHSjJEtgRo+rY2UKBXOA==
X-Received: by 2002:a05:6a00:6816:b0:704:2d99:9ee0 with SMTP id d2e1a72fcca58-70671084e1bmr15516903b3a.33.1719556643778;
        Thu, 27 Jun 2024 23:37:23 -0700 (PDT)
Received: from Ubuntu.. ([117.99.235.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70804a93ce7sm786003b3a.207.2024.06.27.23.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 23:37:23 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 06/11] t-reftable-record: add ref tests for reftable_record_is_deletion()
Date: Fri, 28 Jun 2024 11:49:36 +0530
Message-ID: <20240628063625.4092-7-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240628063625.4092-1-chandrapratap3519@gmail.com>
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
 <20240628063625.4092-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reftable_record_is_deletion() is a function defined in
reftable/record.{c, h} that determines whether a record is of
type deletion or not. In the current testing setup, this function
is left untested for all the four record types (ref, log, obj, index).

Add tests for this function in the case of ref records.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-record.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index bdd54ad265..99dad75fb1 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -102,6 +102,7 @@ static void test_reftable_ref_record_roundtrip(void)
 	for (int i = REFTABLE_REF_DELETION; i < REFTABLE_NR_REF_VALUETYPES; i++) {
 		struct reftable_record in = {
 			.type = BLOCK_TYPE_REF,
+			.u.ref.value_type = i,
 		};
 		struct reftable_record out = { .type = BLOCK_TYPE_REF };
 		struct strbuf key = STRBUF_INIT;
@@ -132,6 +133,7 @@ static void test_reftable_ref_record_roundtrip(void)
 		test_copy(&in);
 
 		check_int(reftable_record_val_type(&in), ==, i);
+		check_int(reftable_record_is_deletion(&in), ==, i == REFTABLE_REF_DELETION);
 
 		reftable_record_key(&in, &key);
 		n = reftable_record_encode(&in, dest, GIT_SHA1_RAWSZ);
-- 
2.45.2.404.g9eaef5822c


Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C492185B4B
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 12:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414774; cv=none; b=mIqSp2gUofeQErp/dF5ft16kKkOyL6uuzm4bRVZwx6dXGIkpFYd7tb1qKpK/NK1L8qYMNRGaVtj/46z8HiuI56M3rKlAjF6sHH6SWVxOoXsatrDkI2xVRCRh1oRFkIBtrAhrttfiqvVKcSuLVIg9+zFf64xBpax8ulYLRuTJu+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414774; c=relaxed/simple;
	bh=gijZoazSrjhF/93fxlKTF0kLD8nWlu8aDkk/zpWM+yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VMvFy9enos92ves+sm3TN+wPgYMjAx8e0K9V6cX7w2oqUlHdrFB+apCoTvT9u7B5Jvr8dWjj6g1eMN6NgfkRw03Ta5dCiSQ4uYbe+sVK7kUEpT/oB8gPxIZNd1oepq+y4CNO2OnCLd2yhQNzacokXU4Sdsic478AZuakEx0ER0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ab6rGrAF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ab6rGrAF"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20230059241so16229905ad.3
        for <git@vger.kernel.org>; Fri, 23 Aug 2024 05:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724414772; x=1725019572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcJ4PP+dj25YPlzSWz8ixlzqHVDtPP+skWg998AyGf4=;
        b=ab6rGrAF5ZeiXycTzUxELoQPLRuk7mbfQxVAE7uhCngSHt+oVnY1+HCL7HajSsY5De
         pQSblFjPxQE8zRO9zgXe2dyhA5Gszt4L4LEIgz2B8Nlj7tJVH0v5wtJN4QirpEUbny6K
         qAbhU5zQeJEroHIdnDa+zs52o9cSQzuAAEAwbG+W3/yLXQRM80rcxAZxhjvKywdgqD1y
         +RF3G3DWsmZXHxJPve+LUawLSMfnF2WvimogbbNBmOoeyESI1BweIfEKarKLPxdyS4wZ
         t5wWhjsBdoaqdPiTyWI6VoMKg7PKO8KiHFwzbQQ+lhgTsQPSKUdKIozJWzajVrY/21xn
         hlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724414772; x=1725019572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcJ4PP+dj25YPlzSWz8ixlzqHVDtPP+skWg998AyGf4=;
        b=drDfgGK8HsNoHmN5D9ba1IpVLc8Kk6NBeL4gtwtYHcYxATEJVfZ9vzqFSsgj78cYas
         mvjlV0TKLyMXnAh/qMhzX76SEdm8NGP0BnpjlRwRo7e0RtXKTJ5bq1g8zj4hH14mDUYW
         1DYCY4rPjPDFbJwS/5Id9E1Hxd+mFE65HpjmIny0O25wlalEXDN3BaJ0n25SheZf6N1f
         Ytx+rqO7HVofSmb3IkkKD8CeG1tAWwf/wo2S3lpEaN+PCWp5o9VH/EWIRTTEiMXtQ4tt
         wdRHPQnTAv/4468zgum0IvhHqp1HJk06MK+v3DgZJyzSgQuZOtX1L561xp4ckBLyVlyV
         r+6A==
X-Gm-Message-State: AOJu0YxyosHPYN7PB2JWri5lagMBdEDi+Pev+Avc/fMwUWY0Nnij7tNA
	CVnSmTm/zIpCgD7m4w2+Ygfy8Apryj19U4J6zts/Wnyl0qxFC1CcZBL6Ug==
X-Google-Smtp-Source: AGHT+IEn1s5llVi4cwMZKwwDwWJskWt/x479sijQh1rh8etXdlTg/IFUEGZD2WTybkkkS7NhZSKxdA==
X-Received: by 2002:a17:903:22cb:b0:203:a02c:992b with SMTP id d9443c01a7336-203a02c9b3emr19365695ad.3.1724414771933;
        Fri, 23 Aug 2024 05:06:11 -0700 (PDT)
Received: from Ubuntu.. ([27.59.94.77])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-203855ddb10sm27171925ad.177.2024.08.23.05.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 05:06:11 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 6/6] t-reftable-stack: add test for stack iterators
Date: Fri, 23 Aug 2024 17:18:51 +0530
Message-ID: <20240823120514.11070-7-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240823120514.11070-1-chandrapratap3519@gmail.com>
References: <20240806142020.4615-1-chandrapratap3519@gmail.com>
 <20240823120514.11070-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reftable_stack_init_ref_iterator and reftable_stack_init_log_iterator
as defined by reftable/stack.{c,h} initialize a stack iterator to
iterate over the ref and log records in a reftable stack respectively.
Since these functions are not exercised by any of the existing tests,
add a test for them.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-stack.c | 80 +++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index 51339a9939..5b1ecacd70 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -550,6 +550,85 @@ static void t_reftable_stack_add(void)
 	clear_dir(dir);
 }
 
+static void t_reftable_stack_iterator(void)
+{
+	struct reftable_write_options opts = { 0 };
+	struct reftable_stack *st = NULL;
+	char *dir = get_tmp_dir(__LINE__);
+	struct reftable_ref_record refs[10] = { 0 };
+	struct reftable_log_record logs[10] = { 0 };
+	struct reftable_iterator it = { 0 };
+	size_t N = ARRAY_SIZE(refs), i;
+	int err;
+
+	err = reftable_new_stack(&st, dir, &opts);
+	check(!err);
+
+	for (i = 0; i < N; i++) {
+		refs[i].refname = xstrfmt("branch%02"PRIuMAX, (uintmax_t)i);
+		refs[i].update_index = i + 1;
+		refs[i].value_type = REFTABLE_REF_VAL1;
+		set_test_hash(refs[i].value.val1, i);
+
+		logs[i].refname = xstrfmt("branch%02"PRIuMAX, (uintmax_t)i);
+		logs[i].update_index = i + 1;
+		logs[i].value_type = REFTABLE_LOG_UPDATE;
+		logs[i].value.update.email = xstrdup("johndoe@invalid");
+		logs[i].value.update.message = xstrdup("commit\n");
+		set_test_hash(logs[i].value.update.new_hash, i);
+	}
+
+	for (i = 0; i < N; i++) {
+		err = reftable_stack_add(st, &write_test_ref, &refs[i]);
+		check(!err);
+	}
+
+	for (i = 0; i < N; i++) {
+		struct write_log_arg arg = {
+			.log = &logs[i],
+			.update_index = reftable_stack_next_update_index(st),
+		};
+		err = reftable_stack_add(st, &write_test_log, &arg);
+		check(!err);
+	}
+
+	reftable_stack_init_ref_iterator(st, &it);
+	reftable_iterator_seek_ref(&it, refs[0].refname);
+	for (i = 0; ; i++) {
+		struct reftable_ref_record ref = { 0 };
+		err = reftable_iterator_next_ref(&it, &ref);
+		if (err > 0)
+			break;
+		check(!err);
+		check(reftable_ref_record_equal(&ref, &refs[i], GIT_SHA1_RAWSZ));
+		reftable_ref_record_release(&ref);
+	}
+	check_int(i, ==, N);
+
+	reftable_iterator_destroy(&it);
+
+	reftable_stack_init_log_iterator(st, &it);
+	reftable_iterator_seek_log(&it, logs[0].refname);
+	for (i = 0; ; i++) {
+		struct reftable_log_record log = { 0 };
+		err = reftable_iterator_next_log(&it, &log);
+		if (err > 0)
+			break;
+		check(!err);
+		check(reftable_log_record_equal(&log, &logs[i], GIT_SHA1_RAWSZ));
+		reftable_log_record_release(&log);
+	}
+	check_int(i, ==, N);
+
+	reftable_stack_destroy(st);
+	reftable_iterator_destroy(&it);
+	for (i = 0; i < N; i++) {
+		reftable_ref_record_release(&refs[i]);
+		reftable_log_record_release(&logs[i]);
+	}
+	clear_dir(dir);
+}
+
 static void t_reftable_stack_log_normalize(void)
 {
 	int err = 0;
@@ -1125,6 +1204,7 @@ int cmd_main(int argc, const char *argv[])
 	TEST(t_reftable_stack_compaction_concurrent_clean(), "compaction with unclean stack shutdown");
 	TEST(t_reftable_stack_compaction_with_locked_tables(), "compaction with locked tables");
 	TEST(t_reftable_stack_hash_id(), "read stack with wrong hash ID");
+	TEST(t_reftable_stack_iterator(), "log and ref iterator for reftable stack");
 	TEST(t_reftable_stack_lock_failure(), "stack addition with lockfile failure");
 	TEST(t_reftable_stack_log_normalize(), "log messages should be normalized");
 	TEST(t_reftable_stack_tombstone(), "'tombstone' refs in stack");
-- 
2.45.GIT


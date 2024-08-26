Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC312198E78
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693840; cv=none; b=ZFzj8rVp+inOvMx+Klf/5Nua+QvY1MYdCMT0Ri+nXn/yotNX/zt+q7/I7/TIdUDAXiiFuhKu8a4QPcETOSIUh0W49oXVKhbe4OD9NyFXE09f/vXWgukaBGcFlrH7dylIaEk33jx7+q0h5VBfJERg3iHW+RTNMmqiDS+Cmlfz6gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693840; c=relaxed/simple;
	bh=+A81j1hXTU3M5zWvaAx8OX09ByLcsinJL5ksIhevRUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbdp5qenVtzUGy59VmufGsTcNIjPIalzCmDgDHPabLWwkbrVM8NDlMD73Yt1nDhJHcJIR/F7+EXOz01HTfj3pXbxGmSSooYyHXCro2jNSAqUfeZRlhCTBluwgcQBlmBHzA120EdM1l8Z+5L9I4o1E6lQcqM3yLeon9C8/fBKn6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkS3uB2W; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkS3uB2W"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71446fefddfso2373552b3a.0
        for <git@vger.kernel.org>; Mon, 26 Aug 2024 10:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724693838; x=1725298638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPFBB2CsyDpZri3yDeIYmswVsiCiviDjXrSdcq8r22M=;
        b=SkS3uB2W1EX5TSNQZC1WJX1eEkVnJclEKPkdL6+b7I09HEWFzJE9Rnxz0qePZ+OVD8
         JX2F/StM/XnXPJWomQm1TI7Iu/6GPbCaCmipBhnQmmyYaReBu/77CEmsBKui/f44tcE6
         ZWS1HTn5e7W79HOP15mfKqDrRt9/cowzHpZyG5mYVOd47ry41yahlJElAiDhRuvrTruS
         AEHoajl78jd3ok+Cz/ENkuo26fRdrYB25DQAZbEQJpvzZVxX7hOIM0YdvlZIrmfdeHm3
         bmfAkSafH6xoQVNX0vAK4IURyjhjPZ9O8MwSPYOiymf74wXmJBKn7PkLd8TIZn/M9W4T
         Osag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724693838; x=1725298638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPFBB2CsyDpZri3yDeIYmswVsiCiviDjXrSdcq8r22M=;
        b=tgHHwMjE9I+8L0DtsmrBk9hFEeS/C1Ldm96EbHneyPYSAN8H8r1gYBjANEG23t0IQM
         a9WT/NnezayfqHklj+Zv6Iy4cHr17w4Gz5NtxomYsLgrd6v/v9ny8SRGb7kXclbUKmOY
         TPAXAA7jI7IKclEdR93+DKbe2XiYqdItn3K9d4wMiGEHw4XUuB1oj9qEkRd9mS3uvq16
         DcUoKmGUGs90UwQcpbpnHPRhVTxJBC/mkjrWkjfKpRtA4TojTBCk6WlAwBwCT1T4AH0K
         ZoniPuVomnm5LeO0VgfqVkSfhSRnQA6xVe+I5zzry/XXGRHYTaWl63AZlBp2hIbFXsqV
         hPFQ==
X-Gm-Message-State: AOJu0YyA6WvExL8Kf6w8sEgkqKPrBSl5G8seE79GPE7al6TXVKID6JCA
	wIZdH84Fjv7JOTzHhBpJqn0eBVmLmfz4vqbXUmO8waKBB/HvFmaubqK94kzS
X-Google-Smtp-Source: AGHT+IGSviC3fpjP22QiqCTT5t3b895mUh0S6WffXeF0CrHmLR62LiJVojqwvD5htyKxQ9gUckfrag==
X-Received: by 2002:a05:6a21:386:b0:1c0:f315:ec7e with SMTP id adf61e73a8af0-1cc89dbac4fmr11270333637.28.1724693837448;
        Mon, 26 Aug 2024 10:37:17 -0700 (PDT)
Received: from Ubuntu.. ([106.216.108.198])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7cd9acdd9casm7997999a12.53.2024.08.26.10.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 10:37:17 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 6/6] t-reftable-stack: add test for stack iterators
Date: Mon, 26 Aug 2024 22:59:46 +0530
Message-ID: <20240826173627.4525-7-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240826173627.4525-1-chandrapratap3519@gmail.com>
References: <20240823120514.11070-1-chandrapratap3519@gmail.com>
 <20240826173627.4525-1-chandrapratap3519@gmail.com>
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
index e8c137529e..112d954afd 100644
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
+		err = reftable_stack_add(st, write_test_ref, &refs[i]);
+		check(!err);
+	}
+
+	for (i = 0; i < N; i++) {
+		struct write_log_arg arg = {
+			.log = &logs[i],
+			.update_index = reftable_stack_next_update_index(st),
+		};
+		err = reftable_stack_add(st, write_test_log, &arg);
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


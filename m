Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9002C170826
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 05:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737524171; cv=none; b=b+p+/Rd4axGsTtdXoxtcRR139+eKjbQIqV1ue7zBfvJFkYY8NbpiA+v3UdNeFEdclZT/VhiSS71G/ukf180zrJvTzUJYmdFDs9/AIBZxwimpP5GEsj8TxywA++96c7lLOmJS0Hz2SuqU6BFmr8l6NBoBybsPQ+FxEeXXbOVfHh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737524171; c=relaxed/simple;
	bh=zn+jsCfxo1JBK34Hji45uwsLF+WzAwQtQiARZAzzUJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YBbqntqM6UlgwXhKFMsf2B5bWGK0JWqWQM9tvKpCo8OGBCxQcDVXEWGPgCzxnZFrrD/lraD4pGGKBGktz1pCaWeE1F+eyze65QLI7GYlB23lhgqxZFlAKAKaDmo8jQNaRQaWmzYuCOwQEKhDWq4kmnY0hv60bBtbjDbsHyWTYwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWukDbly; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWukDbly"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2162c0f6a39so9064005ad.0
        for <git@vger.kernel.org>; Tue, 21 Jan 2025 21:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737524169; x=1738128969; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YnvgPaFKbJZIpZWQHBD/HDrx1fTvfA+buSmX6eF9l5Y=;
        b=NWukDblyUxXoeob7ByUqUyRIknrEkL4qJIvoAKbrr6f3+V4jokstgsVFfIjUpa39NX
         0/LmciRs+2ARsxlVJaSJSf8xsBAsGxgnUzY9Q12gnO6XvYEWERQdVA+nsC4cDSZZlHfY
         o6k5s+hhP+w/nJexiLGnGIu6fJeAGvOtFE+eJLsqjBBUn/scYGuVVcaY3X/TY01w3nAi
         GkUVjXec0X2kx5kAy1pU0zp9KZThdIqovAKskhMXTq4Ws7q76HqJk4p2Cm02ZK4r/kj7
         hAgRJQyQAwvaqIZgpbrcgKYc7Kni5lsNuO5dohNifiNFDhUMuetclc5JIPsbHGSJVi60
         uvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737524169; x=1738128969;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YnvgPaFKbJZIpZWQHBD/HDrx1fTvfA+buSmX6eF9l5Y=;
        b=HHiVrtJgMz3D9C/STWh2G7TcVUyVC4oYdf/HZ8IreEsiQPqsZxXpZRlZCjI9HWyMqQ
         QXu15PBKwCxVCqusRu4soP71Pa1FTERuYkMqHasm+2MJiSosFMp0JSF3gXoX+vRw7Ybg
         U6lgeacUMIeRPYawziXoWWRKzuUj6rPdSgG75mYlJUybuQ5/QW8arH0AciwACr3SpqqS
         McamaY02FjSpRIQvG+hgEomgDggA9kAhtdtnGCa5E/wzE7M2ufMhqn0ZizgZ0iOkQfut
         kHVLwzBGIeNHRg7rff5aarQiJep6jFKkVChE0oUDQHv/mobKyPqdy1KFgNPgMJSpcDE9
         8sWA==
X-Gm-Message-State: AOJu0Yz3gEfCqUylj5/Nm0I09CoDLG++zy4C6vYUd10n3zFvpIinxkjp
	M4JD3FyXvemEYVPAUZtEHBZ9oeNL0H1i/3kw4RxUiawi8G0EL6uTeO9A+Lbl
X-Gm-Gg: ASbGncv+sxFZvTjzrpUJyPHAhYgrK3A8DMKZmlg8PMTXrxBD7t5bbV8jvYViEnWaFKN
	wV2Ogt0L0XUZFcbRy/qkmD9bX6IPgEfgSG2/4VvMK5N/8ErAd/lWeKNRLKLyOy9/U2TcVpmVkCt
	Oivi+G25ui9xq3PotHuJHx6dFL04YDLwj8RGwCTwDoQje/hO0fWd1R9kIVPSQ5RlXe8X7Y37IzL
	gsGFd07z/K56eulaAhpkZjBTVkT/wWLC9BJFvznLYvRucgM00rT0hsNb4l8MbstsO50gfyt
X-Google-Smtp-Source: AGHT+IHv5aW8PeOMbRsgPsikUslK19W+dRTMdQNdNQ6PfYVpocd1StB1xCuMxa1JUByxgInr1WyJvw==
X-Received: by 2002:a05:6a00:66cb:b0:727:39a4:30cc with SMTP id d2e1a72fcca58-72d8c46e973mr38657133b3a.1.1737524168603;
        Tue, 21 Jan 2025 21:36:08 -0800 (PST)
Received: from [127.0.0.2] ([103.39.127.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72db4e718efsm9369207b3a.152.2025.01.21.21.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 21:36:07 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 22 Jan 2025 06:35:49 +0100
Subject: [PATCH v3 3/3] reftable: prevent 'update_index' changes after
 adding records
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-461-corrupted-reftable-followup-v3-3-ae5f88bf04fa@gmail.com>
References: <20250122-461-corrupted-reftable-followup-v3-0-ae5f88bf04fa@gmail.com>
In-Reply-To: <20250122-461-corrupted-reftable-followup-v3-0-ae5f88bf04fa@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11286;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=zn+jsCfxo1JBK34Hji45uwsLF+WzAwQtQiARZAzzUJw=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGeQg75o1zZ6eWstgI+SceD0yp2geR5pQXZES
 Zt9/jhqcXSjNokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnkIO+AAoJED7VnySO
 Rox/PYUL/RGs89lm4lxjsbE7JuyUtA54noGlERFcvlKuAGrGnxdIGuj0jGsz5jmsh3eUpiIszY8
 mjqir8EffopGbG1iYVWseAqi+giZOyzXeAw7Fc9ECMV7tDcp6FBkKNs8zJnEwrcYwQ2s1+lnofc
 Hq0bDrKCtI36bNCGaR6YnycBHhPK+hP/JuzDIUu/hKJaI1Wr1HUxdk9GVkGn4f4/5b0cxFxEsxx
 l8mp4uLZj4s2L+p+OktHxosJjrsXWmKdiSmyUoexDCeBJeyEOgjl6HctBeZZTv4QlvM45suC97d
 O2ws9yT3sJlBHEkU8DWPjXL9hms3tyAs9GXRzkoveb2p7i5nvocGpQO1ANiTfXxAQrQkq5itwSo
 1r7HyayDzTwrWgZg36PAKq4934sqYVOqzlAa4QTrjz0hLnhRlge9yLv2bxOOx2paqBr3Vm7Xmm2
 6Q5YphKhkupwHRIyKdpVYWHfnoCZHNmrcUF7O0vD22pxpKBUw+9ITziqe/pat3VbStHmlXOkpD5
 vw=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The function `reftable_writer_set_limits()` allows updating the
'min_update_index' and 'max_update_index' of a reftable writer. These
values are written to both the writer's header and footer.

Since the header is written during the first block write, any subsequent
changes to the update index would create a mismatch between the header
and footer values. The footer would contain the newer values while the
header retained the original ones.

To protect against this bug, prevent callers from updating these values
after any record is written. To do this, modify the function to return
an error whenever the limits are modified after any record adds. Check
for record adds within `reftable_writer_set_limits()` by checking the
`last_key` and `next` variable. The former is updated after each record
added, but is reset at certain points. The latter is set after writing
the first block.

Modify all callers of the function to anticipate a return type and
handle it accordingly. Add a unit test to also ensure the function
returns the error as expected.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/reftable-backend.c         | 20 +++++++++++----
 reftable/reftable-error.h       |  1 +
 reftable/reftable-writer.h      | 24 ++++++++++--------
 reftable/stack.c                |  6 +++--
 reftable/writer.c               | 15 +++++++++++-
 t/unit-tests/t-reftable-stack.c | 54 ++++++++++++++++++++++++++++++++++++++---
 6 files changed, 99 insertions(+), 21 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 6814c87bc618229ac8a70b904be3f850371ad876..9cfb0cb26721a9425c3b4a374f7b41e192037315 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1443,7 +1443,9 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 	 * multiple entries. Each entry will contain a different update_index,
 	 * so set the limits accordingly.
 	 */
-	reftable_writer_set_limits(writer, ts, ts + arg->max_index);
+	ret = reftable_writer_set_limits(writer, ts, ts + arg->max_index);
+	if (ret < 0)
+		goto done;
 
 	for (i = 0; i < arg->updates_nr; i++) {
 		struct reftable_transaction_update *tx_update = &arg->updates[i];
@@ -1766,7 +1768,9 @@ static int write_copy_table(struct reftable_writer *writer, void *cb_data)
 	deletion_ts = creation_ts = reftable_stack_next_update_index(arg->be->stack);
 	if (arg->delete_old)
 		creation_ts++;
-	reftable_writer_set_limits(writer, deletion_ts, creation_ts);
+	ret = reftable_writer_set_limits(writer, deletion_ts, creation_ts);
+	if (ret < 0)
+		goto done;
 
 	/*
 	 * Add the new reference. If this is a rename then we also delete the
@@ -2298,7 +2302,9 @@ static int write_reflog_existence_table(struct reftable_writer *writer,
 	if (ret <= 0)
 		goto done;
 
-	reftable_writer_set_limits(writer, ts, ts);
+	ret = reftable_writer_set_limits(writer, ts, ts);
+	if (ret < 0)
+		goto done;
 
 	/*
 	 * The existence entry has both old and new object ID set to the
@@ -2357,7 +2363,9 @@ static int write_reflog_delete_table(struct reftable_writer *writer, void *cb_da
 	uint64_t ts = reftable_stack_next_update_index(arg->stack);
 	int ret;
 
-	reftable_writer_set_limits(writer, ts, ts);
+	ret = reftable_writer_set_limits(writer, ts, ts);
+	if (ret < 0)
+		goto out;
 
 	ret = reftable_stack_init_log_iterator(arg->stack, &it);
 	if (ret < 0)
@@ -2434,7 +2442,9 @@ static int write_reflog_expiry_table(struct reftable_writer *writer, void *cb_da
 		if (arg->records[i].value_type == REFTABLE_LOG_UPDATE)
 			live_records++;
 
-	reftable_writer_set_limits(writer, ts, ts);
+	ret = reftable_writer_set_limits(writer, ts, ts);
+	if (ret < 0)
+		return ret;
 
 	if (!is_null_oid(&arg->update_oid)) {
 		struct reftable_ref_record ref = {0};
diff --git a/reftable/reftable-error.h b/reftable/reftable-error.h
index f4048265629fe456207b88620658193f770a84f0..a7e33d964d0cfe5546f588d26c0fcb66ab326828 100644
--- a/reftable/reftable-error.h
+++ b/reftable/reftable-error.h
@@ -30,6 +30,7 @@ enum reftable_error {
 
 	/* Misuse of the API:
 	 *  - on writing a record with NULL refname.
+	 *  - on writing a record before setting the writer limits.
 	 *  - on writing a reftable_ref_record outside the table limits
 	 *  - on writing a ref or log record before the stack's
 	 * next_update_inde*x
diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
index 5f9afa620bb00de66c311765fb0ae8c6f56401ae..1ea014d389cc47f173279e3234a82f3fcbc807a0 100644
--- a/reftable/reftable-writer.h
+++ b/reftable/reftable-writer.h
@@ -124,17 +124,21 @@ int reftable_writer_new(struct reftable_writer **out,
 			int (*flush_func)(void *),
 			void *writer_arg, const struct reftable_write_options *opts);
 
-/* Set the range of update indices for the records we will add. When writing a
-   table into a stack, the min should be at least
-   reftable_stack_next_update_index(), or REFTABLE_API_ERROR is returned.
-
-   For transactional updates to a stack, typically min==max, and the
-   update_index can be obtained by inspeciting the stack. When converting an
-   existing ref database into a single reftable, this would be a range of
-   update-index timestamps.
+/*
+ * Set the range of update indices for the records we will add. When writing a
+ * table into a stack, the min should be at least
+ * reftable_stack_next_update_index(), or REFTABLE_API_ERROR is returned.
+ *
+ * For transactional updates to a stack, typically min==max, and the
+ * update_index can be obtained by inspeciting the stack. When converting an
+ * existing ref database into a single reftable, this would be a range of
+ * update-index timestamps.
+ *
+ * The function should be called before adding any records to the writer. If not
+ * it will fail with REFTABLE_API_ERROR.
  */
-void reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
-				uint64_t max);
+int reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
+			       uint64_t max);
 
 /*
   Add a reftable_ref_record. The record should have names that come after
diff --git a/reftable/stack.c b/reftable/stack.c
index 531660a49f0948c33041831ee0d740feacb22b2f..9649dbbb04c51e106ee752f14481bbad381cb348 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1058,8 +1058,10 @@ static int stack_write_compact(struct reftable_stack *st,
 
 	for (size_t i = first; i <= last; i++)
 		st->stats.bytes += st->readers[i]->size;
-	reftable_writer_set_limits(wr, st->readers[first]->min_update_index,
-				   st->readers[last]->max_update_index);
+	err = reftable_writer_set_limits(wr, st->readers[first]->min_update_index,
+					 st->readers[last]->max_update_index);
+	if (err < 0)
+		goto done;
 
 	err = reftable_merged_table_new(&mt, st->readers + first, subtabs_len,
 					st->opts.hash_id);
diff --git a/reftable/writer.c b/reftable/writer.c
index 740c98038eaf883258bef4988f78977ac7e4a75a..76e24018172fc1d80a6535698757979e53b0e213 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -179,11 +179,24 @@ int reftable_writer_new(struct reftable_writer **out,
 	return 0;
 }
 
-void reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
+int reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
 				uint64_t max)
 {
+	/*
+	  * Set the min/max update index limits for the reftable writer.
+	  * This must be called before adding any records, since:
+	  * - The 'next' field gets set after writing the first block.
+	  * - The 'last_key' field updates with each new record (but resets
+	  *   after sections).
+	  * Returns REFTABLE_API_ERROR if called after writing has begun.
+	 */
+	if (w->next || w->last_key.len)
+		return REFTABLE_API_ERROR;
+
 	w->min_update_index = min;
 	w->max_update_index = max;
+
+	return 0;
 }
 
 static void writer_release(struct reftable_writer *w)
diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index aeec195b2b1014445d71c5db39a9795017fd8ff2..c3f0059c346edbe1ad543c9832959c6fc0aa9180 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -103,7 +103,8 @@ static void t_read_file(void)
 static int write_test_ref(struct reftable_writer *wr, void *arg)
 {
 	struct reftable_ref_record *ref = arg;
-	reftable_writer_set_limits(wr, ref->update_index, ref->update_index);
+	check(!reftable_writer_set_limits(wr, ref->update_index,
+					  ref->update_index));
 	return reftable_writer_add_ref(wr, ref);
 }
 
@@ -143,7 +144,8 @@ static int write_test_log(struct reftable_writer *wr, void *arg)
 {
 	struct write_log_arg *wla = arg;
 
-	reftable_writer_set_limits(wr, wla->update_index, wla->update_index);
+	check(!reftable_writer_set_limits(wr, wla->update_index,
+					  wla->update_index));
 	return reftable_writer_add_log(wr, wla->log);
 }
 
@@ -961,7 +963,7 @@ static void t_reflog_expire(void)
 
 static int write_nothing(struct reftable_writer *wr, void *arg UNUSED)
 {
-	reftable_writer_set_limits(wr, 1, 1);
+	check(!reftable_writer_set_limits(wr, 1, 1));
 	return 0;
 }
 
@@ -1369,11 +1371,57 @@ static void t_reftable_stack_reload_with_missing_table(void)
 	clear_dir(dir);
 }
 
+static int write_limits_after_ref(struct reftable_writer *wr, void *arg)
+{
+	struct reftable_ref_record *ref = arg;
+	check(!reftable_writer_set_limits(wr, ref->update_index, ref->update_index));
+	check(!reftable_writer_add_ref(wr, ref));
+	return reftable_writer_set_limits(wr, ref->update_index, ref->update_index);
+}
+
+static void t_reftable_invalid_limit_updates(void)
+{
+	struct reftable_ref_record ref = {
+		.refname = (char *) "HEAD",
+		.update_index = 1,
+		.value_type = REFTABLE_REF_SYMREF,
+		.value.symref = (char *) "master",
+	};
+	struct reftable_write_options opts = {
+		.default_permissions = 0660,
+	};
+	struct reftable_addition *add = NULL;
+	char *dir = get_tmp_dir(__LINE__);
+	struct reftable_stack *st = NULL;
+	int err;
+
+	err = reftable_new_stack(&st, dir, &opts);
+	check(!err);
+
+	reftable_addition_destroy(add);
+
+	err = reftable_stack_new_addition(&add, st, 0);
+	check(!err);
+
+	/*
+	 * write_limits_after_ref also updates the update indexes after adding
+	 * the record. This should cause an err to be returned, since the limits
+	 * must be set at the start.
+	 */
+	err = reftable_addition_add(add, write_limits_after_ref, &ref);
+	check_int(err, ==, REFTABLE_API_ERROR);
+
+	reftable_addition_destroy(add);
+	reftable_stack_destroy(st);
+	clear_dir(dir);
+}
+
 int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 {
 	TEST(t_empty_add(), "empty addition to stack");
 	TEST(t_read_file(), "read_lines works");
 	TEST(t_reflog_expire(), "expire reflog entries");
+	TEST(t_reftable_invalid_limit_updates(), "prevent limit updates after adding records");
 	TEST(t_reftable_stack_add(), "add multiple refs and logs to stack");
 	TEST(t_reftable_stack_add_one(), "add a single ref record to stack");
 	TEST(t_reftable_stack_add_performs_auto_compaction(), "addition to stack triggers auto-compaction");

-- 
2.47.0


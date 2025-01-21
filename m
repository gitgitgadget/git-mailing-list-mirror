Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B641898F2
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 03:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737430480; cv=none; b=ExHBde6aIsNfCYu0gqE6jv+dNtN7W6wl3JOTiVpy3F2TTTKcPgFy3kiYh+hEmo2jTWMruZd+cy2pCR6Sy7Lt8fqub6eoqEzE0DOEjQrTMS7rT9WCfllrNLsL7m2/Ix5sY/q/T4RHvvyYsJj+VmhQqaae6jP4qHS5PrYrNhGdLqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737430480; c=relaxed/simple;
	bh=+aUTFMYJLu1uE0yGYI4HHgbodBtZZ6r8uur++YEvlOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u0xg2SEjwVSxpIG4cZ1Q3AFyF8W/P3QRdrwwFr5SFjJ0O9IFX4572FOtgcQBHJIZAbBn9ULn6/m8ZG/jmTzzw7+y76kFGPEhXj2cA6KApAiBEiqdkefMflBXwwK3kShoK0xUD0Pv8Rs1TpcMzrA+tWxEOAKqzn+oiyZsIqxf/Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0lrLD/F; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0lrLD/F"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2f441904a42so9217074a91.1
        for <git@vger.kernel.org>; Mon, 20 Jan 2025 19:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737430478; x=1738035278; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ILKVtBL9DDSE1l5OF/FoMWrXXPu9bj9zG2lhWFmEEM8=;
        b=J0lrLD/FtnjRaXXQxbM4KUpUYHdbgg3+srdSGEULtQV3LhfCsRySkMdMuPg091WUHk
         IIase3OcNNYkeFFtRQGwubikx3NHMgylFKrWU6db3bmN5tk4cd/+1xEY8UnTxwqbl+Yl
         kQSbSyKxCcsh9PiSiLAUXBNBMrqntf/qwRLzFJC86L6zYN5IDwJhNY+PWTotv5dtMdBc
         tT7hb//LFxuvjQDcWpev3vigbMTcQj52sOE9rWI0wnELQEpEW+ZMYwpnU4xWi2nRcvh3
         /+nAGA/RyiNm6RiKQ8+Du4COi1+i9nn/8KZm9/dNVK7oRuQA/zrgGWQ7QHk0tD/bU6tT
         8cCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737430478; x=1738035278;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILKVtBL9DDSE1l5OF/FoMWrXXPu9bj9zG2lhWFmEEM8=;
        b=uhx589g87acrLe0BmEPyaD403xflEMKoVIIVJc5VlIZgE0MESNx3fthavQx4Rb5Y6M
         ql2Ya8Ai/wRgKbq3fb5dUjjeSXCkD1e2pKAcJXg1uQ8Om8YLKbuS0OdxTkraofC2DvpW
         3weev9NxuFq/8SUNq6zC/cdTS1p5dq8k7I0G9DQL+qYd6R1r3op2v3DxaQYQRHUVIWlH
         m7nLWELf/F6WzOPI4MPePDFR/cjpkQErTH4PpU+yqAvwUdst6Sx+JTlM2NxyWqiBQdB5
         mG7EeiXDq4e/k+MJDICeaK8nQxcvjzw81QQ6PmL1wnpy5ReMdHsYDGTD9u9ZDtIpcxOZ
         goRw==
X-Gm-Message-State: AOJu0Yw47UuXQV80WF2LNdEDmBdOa1y8zIbyZoCSxcQX3ula3+TgHY71
	h0qcq89nROmbEKsPsMg2Q5QJf54qzOpGfG8pEgqBDzXcnqMa2Zf/
X-Gm-Gg: ASbGnctCkL9MFkf5av06P1D6SUOQEkwjY8Ow9kSWI7gE2KQtA/q8ESl6o46CzL5WFz6
	OSesiOfsMNhO/7Olgza4Uj92qGFrpYVdNjUt+uT8Y+w/GXPu3ZLUjud3XZOKoKShGEQftfkpMe6
	1Bdu4pDqEt3Vgz1WSmO6573VkDE9jkApWUQWEUTJo+SUExMeQsZBRHK1677plCX4KES8nlkplOc
	Ay9JBWIYlr7fiDke8/MN+BcFR8VNNqVTM2AWVy0Mx8adkO/h6a7bRQXZ/Ue64Mvt0V29GiI
X-Google-Smtp-Source: AGHT+IEADY/zPxXEgDDFGXpo6Nw2f8kspI9JkV7iiCi1sBujxGrqukf0jPjrI3K81pPmIXj5D62Hbw==
X-Received: by 2002:a17:90b:2d48:b0:2ee:c9dd:b7ea with SMTP id 98e67ed59e1d1-2f782d4f2dcmr24496294a91.24.1737430477979;
        Mon, 20 Jan 2025 19:34:37 -0800 (PST)
Received: from [127.0.0.2] ([103.39.127.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7db6ab125sm126291a91.26.2025.01.20.19.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 19:34:37 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 21 Jan 2025 04:34:12 +0100
Subject: [PATCH v2 3/3] reftable: prevent 'update_index' changes after
 adding records
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250121-461-corrupted-reftable-followup-v2-3-37e26c7a79b4@gmail.com>
References: <20250121-461-corrupted-reftable-followup-v2-0-37e26c7a79b4@gmail.com>
In-Reply-To: <20250121-461-corrupted-reftable-followup-v2-0-37e26c7a79b4@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8868; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=+aUTFMYJLu1uE0yGYI4HHgbodBtZZ6r8uur++YEvlOs=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGePFcSIk/oLqqPtYgs2FAGxk0WHI7DYuKyJ6
 rf+Aa43x9OCxIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnjxXEAAoJED7VnySO
 Rox/pN4L/0kOlbeB/ewnv0pce6DuOS7Ktf2ssirh0dbw9pH9a1Oaajg10gxRppq+1ATJh/7vGrV
 y+yQGW7rWVvtbzkyAm4eys2X/6c3dY0ua9YhxlOQ98iYysRuSXnEH6YsbqYffpNg2pBoeShp0I0
 7+uZeRMUjb3kUhw3BMgywTEQzSsHRmDrPEDj2IluOCSiRaQlhM6c3O2jEZBa2eMeBoQqtvwR74o
 5BnIRha+DjFQJAF0iO4Y0Yk1KxGyfgKQp2oIo5eXOf8vk01koFQNF2Xrb5jyGGU2UZkH8B7hRLd
 Aklex8CDs2H2ZihaY9BL33I0iQ61DLNwR+/Vn94IeELOBmUjiymH3f7DrfLxGNzIbf1943yxZaV
 KMkXNh/ZtdeRFlED9ILSRIRRLXOB8PJyUN6N1E6NBAVN1/2EOk2dFm+6m5QpRJeDV+o6t5/kDoD
 q89SI3wL309u5eo5jh649lnGJzJsbFND+UGThKEvQGUPZNaoJxhrTFBcqzPCmjBaYi2ICfKHpa7
 v0=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The function `reftable_writer_set_limits()` allows updating the
'min_update_index' and 'max_update_index' of a reftable writer. These
values are written to both the writer's header and footer.

Since the header is written during the first block write, any subsequent
changes to the update index would create a mismatch between the header
and footer values. The footer would contain the newer values while the
header retained the original ones.

To fix this bug, prevent callers from updating these values after any
record is written. To do this, modify the function to return an error
whenever the limits are modified after any record adds. Check for record
adds within `reftable_writer_set_limits()` by checking the `last_key`
variable, which is set whenever a new record is added.

Modify all callers of the function to anticipate a return type and
handle it accordingly.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/reftable-backend.c         | 20 +++++++++++++++-----
 reftable/reftable-error.h       |  1 +
 reftable/reftable-writer.h      | 24 ++++++++++++++----------
 reftable/stack.c                |  6 ++++--
 reftable/writer.c               | 13 +++++++++++--
 t/unit-tests/t-reftable-stack.c |  8 +++++---
 6 files changed, 50 insertions(+), 22 deletions(-)

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
index 740c98038eaf883258bef4988f78977ac7e4a75a..03acbdbcce75fd51820c5fb016bd94f0f7f4914a 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -179,11 +179,20 @@ int reftable_writer_new(struct reftable_writer **out,
 	return 0;
 }
 
-void reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
-				uint64_t max)
+int reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
+			       uint64_t max)
 {
+	/*
+	 * The limits should be set before any records are added to the writer.
+	 * Check if any records were added by checking if `last_key` was set.
+	 */
+	if (w->last_key.len)
+		return REFTABLE_API_ERROR;
+
 	w->min_update_index = min;
 	w->max_update_index = max;
+
+	return 0;
 }
 
 static void writer_release(struct reftable_writer *w)
diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index aeec195b2b1014445d71c5db39a9795017fd8ff2..b23edf18a7d75b0c2292490ad06d4dfaaa571e79 100644
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
 

-- 
2.47.0


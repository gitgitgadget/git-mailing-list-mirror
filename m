Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3A53A5435
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 21:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787176398; cv=none; b=FLl5rwLiGVmniwQ4avjKUMi128JNnvkCEDXOfl1HIzQE3FpveHzZWcd9FemjpV3OYcQjRvAeP8agG+qq6uFRavFGs2oukMTqPCS+Akxs8HHfkTMncd7vWdCvRpPz6tD8j8NTl22K0nSzIHstH0cmJgLXA0+K4kIFw+MvS6vHfLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787176398; c=relaxed/simple;
	bh=IinC8ouaQuR+qhaZ6Wbhz7d2mqZNDjYlA0pH0RF82SY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9uHScBVgPuJ4wMIgc8H/hWa9e6EHBBhzmro066KZDyYSxnv7cc/o4/T+tHUzUTBsmkzg/hybpKvNG0MOBeVa8Nl3ttz9bz9WXc/SpmU3bMZYiyNa0ZomTZgGN/0fRcCVFzxoRTz7+vRlpahLdzvegqapxR4kUGevgPUXWtc42I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sx84Mcoy; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sx84Mcoy"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7ec1e9d3359so1114296a34.0
        for <git@vger.kernel.org>; Wed, 19 Aug 2026 14:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787176395; x=1787781195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iW7gA7UoqCijrWhANGGMkugIt/mH+uhIQhCWgsfpkJ0=;
        b=sx84McoydcIF331rAZquQizz7IYFzN9o7iroNViquPRvYq3dPipr5p0tiq7+WRB3DA
         0yxdkBEuadvR5dgy4An8G36yjaPNpcMP48wufwMo8ggvyu6Iw5TL9merr+PIZDZI7HMG
         TNXDmKqVmc+XvcgnW0suPDyovX9OGu4W5FYN+ztXHkZqN/41l2F8pdUycpWZyMUJFsuo
         UzJXuxLS+Ngs+OSJp7lXaMvWySYRpKeEB4Agyz2dRH7jNBO0AVvyPUPXxM/JsWeMwaSu
         9y/+7JbWrKPPVW1bmY0nWA/AXiXomkMYYRtG1neEJ1w0c2PFxlI8ASIwuH6WdY/cB4P5
         7leA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787176395; x=1787781195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iW7gA7UoqCijrWhANGGMkugIt/mH+uhIQhCWgsfpkJ0=;
        b=Z1KYK1TxH5Isdz0zMj32tSNNEKL3ueaVWvAyr6W9slB5P9FVGLP2mwTiqsMLlHu9eJ
         c+LJG+RXZL+4Z38JJeXs19EwrXin4WuRIzlIothJjrIr/9h/eeb72ARAxVlRljGVh6rR
         xfYwoyZfzx0A7y83lgvIGtMf8z2UcrHukw7aIjFQOloU6H33DZBgwU1sRzg8wagChf5M
         OBuyJSyUE2ViqOhoLh4OA51wmYuWjoc1EEp483N4wWU2n/R2089TMbUIv+iD09JXoOs9
         YoCL8/cdueHUFcr1G7r7vONNHqgoM9cl964ysGfgQht3VyinW2ZaEjVl2bmfPVUMACA0
         sKuw==
X-Gm-Message-State: AOJu0YzEfrBsaMl3RHkDQi+bmcZu6RRFhoEvMGPrKzd/fX5LBqR4UoL/
	rqUkMbEsS6lHY3C6NfVKWD/5t8Yciqo6AzmXFah39zMYOaTPWWn0elepTFBWSw==
X-Gm-Gg: AR+sD12AQmWi1TZmZzX62tKRzZPmGDT6DjXwkMeHsNUWRTaUZ2YaV0hlABerB76xcta
	0hy8n0e4zIeEsviokfABQzC28j/UjMY8zBxqAFMwXcKM4jPNpRwEsffg0EBNdPnROXTVUz8doMs
	xxrCuFc2ZEK6RZl6Rxotl69e40HHJIi53bUq8gjXFqcsvyw3td91TOdZFdI0NTDvnJLVsaHsj/7
	3vD1mzFJXIa/xknfkzYRshJ73fmBtouZ05eN3jLM3S8chunhyajSYg5TIyccn5JoC9CP6oY5BXp
	4Jq75X21Neesq/GLLqO/5eNI+qB1zUjUjY0WcdAtnRK+aM0ic0Vs8TtkC7C00hK6wMfM/GxpXF6
	mIau5s9uawEkJ0t18WKwFBMSXZ6aKnWXC7FwgElYFhNzlZKRr4T/e85Y0Te3PlWowYOHo0aOQzd
	HxxGCM50/YbFdF3ef2TsrzM28mdOqAGJ8dmVkr27FfAznMaafIBTHR4akZ5ohoJBrruDUL
X-Received: by 2002:a05:6830:6d49:b0:7d7:58b0:7685 with SMTP id 46e09a7af769-7f43fab4166mr8663858a34.13.1787176395605;
        Wed, 19 Aug 2026 14:53:15 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f43fe7029dsm2718026a34.2.2026.08.19.14.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 14:53:15 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 2/9] odb/transaction: add transaction finalize interface
Date: Wed, 19 Aug 2026 16:53:04 -0500
Message-ID: <20260819215311.3880274-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260819215311.3880274-1-jltobler@gmail.com>
References: <20260811175415.2044235-1-jltobler@gmail.com>
 <20260819215311.3880274-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When committing an ODB transaction via `odb_transaction_commit()`, the
staged objects are made visible and the underlying transaction is freed
at the same time. Coupling these two steps does not leave room for any
post-commit transaction operations to be introduced though. Such a
capability is useful if an ODB transaction backend needs to hold on to
lockfiles after transaction commit until references are updated, as is
the case with the existing "files" backend in git-receive-pack(1).

Stop freeing the transaction in `odb_transaction_commit()` and introduce
`odb_transaction_finalize()` to explicitly clean up the transaction
accordingly. Note that the finalize interface also provides an optional
callback for any backend-specific deferred cleanup. In a subsequent
commit, the "files" transaction backend will use this to remove ".keep"
files generated for packfiles received via git-receive-pack(1) after
references have been updated. In preparation for this, the
`odb_transaction_finalize()` call site in git-receive-pack(1) is made
after the reference updates are finished.

All other callers commit a transaction and immediately finalize it with
no work in between and cannot meaningfully recover should either fail,
so introduce an `odb_transaction_commit_and_finalize_or_die()` helper
that performs both and dies on error. Call sites are updated
accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/add.c            |  4 ++--
 builtin/receive-pack.c   |  1 +
 builtin/unpack-objects.c |  2 +-
 builtin/update-index.c   |  4 ++--
 cache-tree.c             |  2 +-
 object-file.c            |  2 +-
 odb/transaction.c        | 14 ++++++++++++++
 odb/transaction.h        | 23 +++++++++++++++++++++++
 read-cache.c             |  2 +-
 9 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 60ffbede2b..ad418a5952 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -393,7 +393,7 @@ int cmd_add(int argc,
 	char *seen = NULL;
 	char *ps_matched = NULL;
 	struct lock_file lock_file = LOCK_INIT;
-	struct odb_transaction *transaction;
+	struct odb_transaction *transaction = NULL;
 
 	repo_config(repo, add_config, NULL);
 
@@ -600,7 +600,7 @@ int cmd_add(int argc,
 
 	if (chmod_arg && pathspec.nr)
 		exit_status |= chmod_pathspec(repo, &pathspec, chmod_arg[0], show_only);
-	odb_transaction_commit(transaction);
+	odb_transaction_commit_and_finalize_or_die(transaction);
 
 finish:
 	if (write_locked_index(repo->index, &lock_file,
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index d74b787148..ed1edcbe93 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2720,6 +2720,7 @@ int cmd_receive_pack(int argc,
 		use_keepalive = KEEPALIVE_ALWAYS;
 		execute_commands(commands, unpack_status, &si, transaction,
 				 &push_options);
+		odb_transaction_finalize(transaction);
 		delete_tempfile(&pack_lockfile);
 		sigchain_push(SIGPIPE, SIG_IGN);
 		if (report_status_v2)
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 4263edfbec..d6a2d616d9 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -603,7 +603,7 @@ static void unpack_all(void)
 		unpack_one(i);
 		display_progress(progress, i + 1);
 	}
-	odb_transaction_commit(transaction);
+	odb_transaction_commit_and_finalize_or_die(transaction);
 	stop_progress(&progress);
 
 	if (delta_list)
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 241abd4332..b25d4ecb10 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1156,7 +1156,7 @@ int cmd_update_index(int argc,
 			 * a transaction.
 			 */
 			if (transaction && verbose) {
-				odb_transaction_commit(transaction);
+				odb_transaction_commit_and_finalize_or_die(transaction);
 				transaction = NULL;
 			}
 
@@ -1224,7 +1224,7 @@ int cmd_update_index(int argc,
 	/*
 	 * By now we have added all of the new objects
 	 */
-	odb_transaction_commit(transaction);
+	odb_transaction_commit_and_finalize_or_die(transaction);
 
 	if (split_index > 0) {
 		if (repo_config_get_split_index(the_repository) == 0)
diff --git a/cache-tree.c b/cache-tree.c
index d92f513286..a220372a42 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -538,7 +538,7 @@ int cache_tree_update(struct index_state *istate, int flags)
 	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
 		       "", 0, &skip, flags);
 	if (!inflight)
-		odb_transaction_commit(transaction);
+		odb_transaction_commit_and_finalize_or_die(transaction);
 	trace2_region_leave("cache_tree", "update", istate->repo);
 	trace_performance_leave("cache_tree_update");
 	if (i < 0)
diff --git a/object-file.c b/object-file.c
index ec35c318bc..4d03c167d5 100644
--- a/object-file.c
+++ b/object-file.c
@@ -965,7 +965,7 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 								  xsize_t(st->st_size),
 								  oid);
 			if (!inflight)
-				odb_transaction_commit(transaction);
+				odb_transaction_commit_and_finalize_or_die(transaction);
 		} else {
 			ret = hash_blob_stream(&stream,
 					       the_repository->hash_algo, oid,
diff --git a/odb/transaction.c b/odb/transaction.c
index dab7da6a9a..9e9a982778 100644
--- a/odb/transaction.c
+++ b/odb/transaction.c
@@ -33,6 +33,20 @@ int odb_transaction_commit(struct odb_transaction *transaction)
 
 	ret = transaction->commit(transaction);
 	transaction->source->odb->transaction = NULL;
+
+	return ret;
+}
+
+int odb_transaction_finalize(struct odb_transaction *transaction)
+{
+	int ret = 0;
+
+	if (!transaction)
+		return 0;
+
+	if (transaction->finalize)
+		ret = transaction->finalize(transaction);
+
 	free(transaction);
 
 	return ret;
diff --git a/odb/transaction.h b/odb/transaction.h
index 4cb2eafcbf..6ed39b3d0e 100644
--- a/odb/transaction.h
+++ b/odb/transaction.h
@@ -22,6 +22,13 @@ struct odb_transaction {
 	 */
 	int (*commit)(struct odb_transaction *transaction);
 
+	/*
+	 * Optional ODB source specific callback invoked when the transaction
+	 * needs to perform any deferred cleanup after objects have been
+	 * committed. Returns 0 on success, a negative error code otherwise.
+	 */
+	int (*finalize)(struct odb_transaction *transaction);
+
 	/*
 	 * This callback is expected to write the given object stream into
 	 * the ODB transaction. Note that for now, only blobs support streaming.
@@ -75,6 +82,22 @@ static inline void odb_transaction_begin_or_die(struct object_database *odb,
  */
 int odb_transaction_commit(struct odb_transaction *transaction);
 
+/*
+ * Finalizes an ODB transaction, performing any deferred cleanup and freeing it.
+ * Must be called for every successfully started transaction. Note that, if the
+ * specified transaction is NULL, the function is a no-op. Returns 0 on success,
+ * a negative error code otherwise.
+ */
+int odb_transaction_finalize(struct odb_transaction *transaction);
+
+static inline void odb_transaction_commit_and_finalize_or_die(struct odb_transaction *transaction)
+{
+	if (odb_transaction_commit(transaction))
+		die(_("failed to commit ODB transaction"));
+	if (odb_transaction_finalize(transaction))
+		die(_("failed to finalize ODB transaction"));
+}
+
 /*
  * Writes the object in the provided stream into the transaction. The resulting
  * object ID is written into the out pointer. Returns 0 on success, a negative
diff --git a/read-cache.c b/read-cache.c
index 6c449f393d..0cd0ef85ec 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -4049,7 +4049,7 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
 		odb_transaction_begin_or_die(repo->objects, &transaction, 0);
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
 	if (!inflight)
-		odb_transaction_commit(transaction);
+		odb_transaction_commit_and_finalize_or_die(transaction);
 
 	release_revisions(&rev);
 	return !!data.add_errors;
-- 
2.55.0.424.g13c7afec21


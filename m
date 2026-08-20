Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A59369997
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 23:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787269789; cv=none; b=JZQUApCAv0KZ8Jxh9yLFy86fUXEDo2Pc1uX8q5YXKS10aIfZ0A0/XXxtCoaiztHetg66Kj7oMaKUIz6fssBZMDvuG7WuLZXtZLnL1JBN7JYiwBCMaWbP+lLuwySphuvc9fuEx1wIpOrTgI8GFzVJB/tTtCZbVdpD50qgIfn9MYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787269789; c=relaxed/simple;
	bh=3Tz8ikiW+PMMwdfNjaRgEn6VNIoyjFjDxxo0rLFGn/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTLpo00Yg1axytktJAWI8w4O/As6OIfrabktlLz+fmAxwBXa0mCM8JfS1wmud+VtXOtnWuIeBbpMN6z2wud7wAOsaPeZWpYY4ScRzbUBkIHL7Op+c4UDF+l+bPK7UrZpI9JhyaA48qWHxm7d+uBp+z6Lwf2iRHaP1AsYGgi6+CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJnd95C7; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJnd95C7"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e9ef94c0e2so299799a34.3
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 16:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787269787; x=1787874587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZtCJGQjJ3ekWGtaAFXbFe9+nEXRZ+9Pfys0mnTsgYwQ=;
        b=CJnd95C7Uq4MSJ769ehaGnWP+jT+M/JmRIuft7jnBixf1zLCNOSKsrXKK7xguxxoVs
         iK1O5x8RV/oxOlHEyPrvomGB/3KMa6kO1YEhOpu5wqbPDIB1XIPEbokOrV/9dvEQbw3W
         hhr4z3onfLc3sNBN71v4dD6/mkI1MIrxEGYS0WQyB7FfSKoBEk/EcMATC6sLwMLPuf4J
         VbCZDT8sr5XfoGfTu3StLvkLd3NNiUH3siBsiBFPuZUGXD3GOAcaaqMVpXi6ijFY5BjM
         4BGE4eI2PdSyri/TflmDv2ja2qe/3SJpf5x2TWhN/WTlA9gysBE4clpZ2cnJuFOZ8Lb2
         8MtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787269787; x=1787874587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZtCJGQjJ3ekWGtaAFXbFe9+nEXRZ+9Pfys0mnTsgYwQ=;
        b=Z+9fU0rZ3PBYLUS+uvDUoa42C0/G0FwWy6UPjh06M0aKNtiAS36ZYW+izksrTnFOIT
         phJpngfeGH69srwUe68JoZjG3jlad/5JYvKLxoI3lqcYzfYh4mV7GE4mrSNQP4QTO39C
         6ajZna1Z07jLg8mspqU7nNgLP5I5YfwrmPgKNQ+Nwjt8qNBtOpakNR0zYniF9HGZ4RCV
         nU5f2y/8HjRYQcP9uKdXVTuJJVjM2xPQ+Ej8D5NX8lZ7ewHpsFSm8jE9GEvgYieg112E
         Y7e8rP5lP4lwzcNV/2qQrJmRrX5aDBoEz3my9lvsYNpvvK+V2VARnNokYc0AtZYXrdnk
         RB8g==
X-Gm-Message-State: AOJu0YwBPv3FmPUsX33TUJ/CS9PwD35yd+to5lsJaGjtFjMPzV/etour
	2/PBHeaKT5Fc2RD70fflxEEcge7/NS1rFWdDqg9ev1zwyucu0AFVa1jZHjvrwg==
X-Gm-Gg: AR+sD10U31OwOjtGKqsusN6vl/suO4uLBFLRErm2hsY/LGItqswI0UThBfbzxC4HPVv
	7pCS/XJf4WVADD1Syd+RNUSK4+XJakYWHXNriXSzz1TCW8Me29Lg9Ckpypi/HdNt46KAAJgzPDK
	5aUAnIGK4PXUGdQ08SRWbi1oBtJ6sjlC955su2ruexaFBCysVsVmP8sbjksoDJQa6kCpp4GJj6C
	JQxW3a3ILestJFehGJW1/kNvK2Iw2LgrL5Wa/K/Q1/WT4gyqX+E/b0XgfQwpl0/rj71AtZY54Cn
	EDSHj579HVPe7ILt1pyu4JpD8sXZfAJtUlmetqdvQSFtw9kTGxbb2juM1nvcDWHGtU8HvASVzS7
	Q70C2miicZsDFPcfZiYaVuBj/348WdveVUy6/EiwylYIX+8BQQioyHOgiP0zqDFlr/deJT2rim6
	h+4yH3NF5eqq0GLt/KOZ9ziIPms4j9D7SKe/CBg/+GXp9U7JxSKfHB0kLytHtcpNSh910as2Pf2
	NiKTqE=
X-Received: by 2002:a4a:d0a2:0:b0:6ae:c68b:3a7 with SMTP id 006d021491bc7-6b159289bcfmr2185282eaf.16.1787269786987;
        Thu, 20 Aug 2026 16:49:46 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4632a6c360asm2961133fac.5.2026.08.20.16.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 16:49:46 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v5 2/9] odb/transaction: add transaction finalize interface
Date: Thu, 20 Aug 2026 18:49:33 -0500
Message-ID: <20260820234940.894624-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260820234940.894624-1-jltobler@gmail.com>
References: <20260819215311.3880274-1-jltobler@gmail.com>
 <20260820234940.894624-1-jltobler@gmail.com>
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

All other callers commit a transaction and immediately finalize it
without any work happening in between those two operations.
Consequently, they cannot meaningfully recover in case either of them
would fail, and spelling out these two separate steps with proper error
handling would be quite repetitive and pointless. Introduce a helper
`odb_transaction_commit_and_finalize_or_die()` for those call sites and
update them accordingly.

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


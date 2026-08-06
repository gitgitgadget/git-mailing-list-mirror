Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A83422E35
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 21:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786052351; cv=none; b=krbyEvXdMsO0islZ4CFf4HKNlt/8YEu5NhHBqKN8HmMKASMJmsGYNf1PNyZ+ZSay8oOUbzkAk0REYGkhQovRGi/bWYnsdqGzLIf8nWa/dETpHlhsdPx4Rz8QytKDL5iALyM0bUK3Bj1iBB9PkNW1sE1Mhsqtu4cP/jGDVsHMoU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786052351; c=relaxed/simple;
	bh=y/GhPKMAk9VcVH7XTqpkDt2Fdg2fvZ+gHV4qVV909DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r3M57rrRCCL1dvxPabkG2dep8Z2fxtIxtBeVb8c1YhNkemk9Tf8moLeqd0k8Z/69n0stc2AEiZlbaMHtp/tPNDnTRKjdy7Z3bYQoVA9r7+y1sXwrRjRx6xgKDiBzswYOJ9lA6DawjjEJiRHStpVc2oHXZZaOEsZUjKRRxrURMqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLdVtUex; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLdVtUex"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6acc88b9c5fso1377262eaf.2
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 14:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786052345; x=1786657145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TyQV6Gf/HU6RgIF3EA9p2YkMZ5eW6+qpPHDMzx/a6ZM=;
        b=nLdVtUexHpOj1wwDKcjSPA9XBKN9T9dapBRGleApk3v1G6UbWRXSGFhIZHu8yl7Q0J
         rwuQa1g8Ct6a1zCER9gOtR+TURQQhd/mBWkb7tXktVUtm0zk93O92zGkDAOB+7SWLsXt
         tD+gaVycqRwPLjB3dGQ3kOs8NjPqR/jF8xwoGfVAkKMEyD6SCAkr1Ku/LGlxKocX6gLe
         9sY5gr1wklAuxEQGhMN0io2WUD4tfdnTnfghf0wQ5dlmN2PAV4pRp5o71JIA6oaViUSa
         Y1fojTOgq16hZnwfBXr0DcyvCliTsXrJsuIHvsCwuZ4KheUsCC75ND6HRn9k2w5IVMqi
         SwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786052345; x=1786657145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TyQV6Gf/HU6RgIF3EA9p2YkMZ5eW6+qpPHDMzx/a6ZM=;
        b=jzdoTcG4QvVPLqLxIUHu7DCk+hYy5YtPiHhBFmaamBDVpcd2DHV0ofg73e5+xhbx2G
         srMDHd95hSdxtowz2j2kdXB/AGB3kjSeoWt3s8/cPZSeGRc4UazfbqC0UTKijPAatP7E
         uV7nWddZQe305RPKaW3Pox1GZ9Ya4xHbPWl5LOeHcY3LHbUC4gTW0WYOaQPjXSp8dd1O
         NTvReAmx+BjnZRL4Ac0PlDOCGkcz7oM6ELDWgCRtJ/kRN6Hptt/YQC7y9kzceOlBgbv9
         6id4YfeQ6pQOYYG0aLZDlbXijVQ/slbwhNSli8LrUELCldz8PHwhqO02fLFpk3mLGslV
         0ddw==
X-Gm-Message-State: AOJu0Yx6gJV7zlCWeeX/dv7CBpA21a3T3OQvotqiILeJft+/thv7LBNP
	XG1YQ8J1TVGNE+KHs4SwWcSbT5ItUGuLkWeJMSZZonUCOlnCcON6SHR75vC0Zg==
X-Gm-Gg: AR+sD10eOeDZAs2hojJ8aM32RnC7KJimQRGZhFsqCj7K75Va9mYeB1jiEAByrxZD4nz
	/1tle9nPN5d4tIP7T1RgCsWhSRG1ODUujyAU4ywn5QBuWq5hWYWVdRm4NBrBdcYECdemP049LUH
	LIo6EQJVdeAOG1z2BilsgZ93NGGsdK6eSgZ/Z+ngGZavbsvRf8IkLV7G27wO84tJwkAQDT782Lj
	KPQl3DzzkIt/AKZf9ara6exYjg7zY8vbMZCw+wN1T16XB15NiB2Rt2XDmBP2IG97KgmJ6KiAknz
	8/FLoGnBXKqaZbMyio+Cdjph6JOqS1QXXo50dFjwK9iyPKmu603fcN2ux/yShfT70M++FGrOEB4
	N2TAMglxw4cbIUWaQOeRPFUmp9UIKGomq+g9uT3+J8pcdFjQu/kwwwnwE/pSmCCPthXqLkCueFl
	bpW95g4yAF0U33rWw+UIg6E6O0efTJwGA0+GUo1gcxi9iKyWsJ8y7oCPYaeD5DTNPPsKU0
X-Received: by 2002:a05:6820:6acf:b0:6a1:98fe:3da2 with SMTP id 006d021491bc7-6ae96c84830mr8674779eaf.11.1786052345020;
        Thu, 06 Aug 2026 14:39:05 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b02be475b6sm587078eaf.11.2026.08.06.14.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 14:39:04 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 1/6] odb/transaction: add transaction release interface
Date: Thu,  6 Aug 2026 16:38:54 -0500
Message-ID: <20260806213859.816157-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260806213859.816157-1-jltobler@gmail.com>
References: <20260806213859.816157-1-jltobler@gmail.com>
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
`odb_transaction_release()` to explicitly clean up the transaction
accordingly. Note that the release interface also provides an optional
callback for any backend-specific deferred cleanup. In a subsequent
commit, the "files" transaction backend will use this to remove ".keep"
files generated for packfiles received via git-receive-pack(1) after
references have been updated.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/add.c            |  3 ++-
 builtin/receive-pack.c   |  1 +
 builtin/unpack-objects.c |  1 +
 builtin/update-index.c   |  2 ++
 cache-tree.c             |  4 +++-
 object-file.c            |  4 +++-
 odb/transaction.c        | 12 +++++++++++-
 odb/transaction.h        | 14 ++++++++++++++
 read-cache.c             |  4 +++-
 9 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 60ffbede2b..037491a51e 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -393,7 +393,7 @@ int cmd_add(int argc,
 	char *seen = NULL;
 	char *ps_matched = NULL;
 	struct lock_file lock_file = LOCK_INIT;
-	struct odb_transaction *transaction;
+	struct odb_transaction *transaction = NULL;
 
 	repo_config(repo, add_config, NULL);
 
@@ -610,5 +610,6 @@ int cmd_add(int argc,
 	free(ps_matched);
 	dir_clear(&dir);
 	clear_pathspec(&pathspec);
+	odb_transaction_release(transaction);
 	return exit_status;
 }
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 86933d8d7e..420de9aa7f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2714,6 +2714,7 @@ int cmd_receive_pack(int argc,
 		use_keepalive = KEEPALIVE_ALWAYS;
 		execute_commands(commands, unpack_status, &si, transaction,
 				 &push_options);
+		odb_transaction_release(transaction);
 		delete_tempfile(&pack_lockfile);
 		sigchain_push(SIGPIPE, SIG_IGN);
 		if (report_status_v2)
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 4263edfbec..13d4b7f1ad 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -604,6 +604,7 @@ static void unpack_all(void)
 		display_progress(progress, i + 1);
 	}
 	odb_transaction_commit(transaction);
+	odb_transaction_release(transaction);
 	stop_progress(&progress);
 
 	if (delta_list)
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 241abd4332..1484835ef0 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1157,6 +1157,7 @@ int cmd_update_index(int argc,
 			 */
 			if (transaction && verbose) {
 				odb_transaction_commit(transaction);
+				odb_transaction_release(transaction);
 				transaction = NULL;
 			}
 
@@ -1225,6 +1226,7 @@ int cmd_update_index(int argc,
 	 * By now we have added all of the new objects
 	 */
 	odb_transaction_commit(transaction);
+	odb_transaction_release(transaction);
 
 	if (split_index > 0) {
 		if (repo_config_get_split_index(the_repository) == 0)
diff --git a/cache-tree.c b/cache-tree.c
index d92f513286..5a2fa7f22d 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -537,8 +537,10 @@ int cache_tree_update(struct index_state *istate, int flags)
 		odb_transaction_begin_or_die(the_repository->objects, &transaction, 0);
 	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
 		       "", 0, &skip, flags);
-	if (!inflight)
+	if (!inflight) {
 		odb_transaction_commit(transaction);
+		odb_transaction_release(transaction);
+	}
 	trace2_region_leave("cache_tree", "update", istate->repo);
 	trace_performance_leave("cache_tree_update");
 	if (i < 0)
diff --git a/object-file.c b/object-file.c
index ec35c318bc..30b4717d3e 100644
--- a/object-file.c
+++ b/object-file.c
@@ -964,8 +964,10 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 								  &stream,
 								  xsize_t(st->st_size),
 								  oid);
-			if (!inflight)
+			if (!inflight) {
 				odb_transaction_commit(transaction);
+				odb_transaction_release(transaction);
+			}
 		} else {
 			ret = hash_blob_stream(&stream,
 					       the_repository->hash_algo, oid,
diff --git a/odb/transaction.c b/odb/transaction.c
index dab7da6a9a..ce1e24f3ed 100644
--- a/odb/transaction.c
+++ b/odb/transaction.c
@@ -33,11 +33,21 @@ int odb_transaction_commit(struct odb_transaction *transaction)
 
 	ret = transaction->commit(transaction);
 	transaction->source->odb->transaction = NULL;
-	free(transaction);
 
 	return ret;
 }
 
+void odb_transaction_release(struct odb_transaction *transaction)
+{
+	if (!transaction)
+		return;
+
+	if (transaction->release)
+		transaction->release(transaction);
+
+	free(transaction);
+}
+
 int odb_transaction_write_object_stream(struct odb_transaction *transaction,
 					struct odb_write_stream *stream,
 					size_t len, struct object_id *oid)
diff --git a/odb/transaction.h b/odb/transaction.h
index 4cb2eafcbf..ec0b27c449 100644
--- a/odb/transaction.h
+++ b/odb/transaction.h
@@ -22,6 +22,13 @@ struct odb_transaction {
 	 */
 	int (*commit)(struct odb_transaction *transaction);
 
+	/*
+	 * Optional ODB source specific callback invoked when the transaction
+	 * needs to perform any deferred cleanup after objects have been
+	 * committed.
+	 */
+	void (*release)(struct odb_transaction *transaction);
+
 	/*
 	 * This callback is expected to write the given object stream into
 	 * the ODB transaction. Note that for now, only blobs support streaming.
@@ -75,6 +82,13 @@ static inline void odb_transaction_begin_or_die(struct object_database *odb,
  */
 int odb_transaction_commit(struct odb_transaction *transaction);
 
+/*
+ * Releases an ODB transaction, performing any deferred cleanup and freeing it.
+ * Must be called for every successfully started transaction. Note that, if the
+ * specified transaction is NULL, the function is a no-op.
+ */
+void odb_transaction_release(struct odb_transaction *transaction);
+
 /*
  * Writes the object in the provided stream into the transaction. The resulting
  * object ID is written into the out pointer. Returns 0 on success, a negative
diff --git a/read-cache.c b/read-cache.c
index 6c449f393d..42623f6e10 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -4048,8 +4048,10 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
 	if (!inflight)
 		odb_transaction_begin_or_die(repo->objects, &transaction, 0);
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
-	if (!inflight)
+	if (!inflight) {
 		odb_transaction_commit(transaction);
+		odb_transaction_release(transaction);
+	}
 
 	release_revisions(&rev);
 	return !!data.add_errors;
-- 
2.55.0.424.g13c7afec21


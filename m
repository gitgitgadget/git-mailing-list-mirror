Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FEA2D6E75
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 23:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769643932; cv=none; b=NrCUhTfMZ/+ay/WSmL1MfqfQ2lH9seCS18m8t/hFvDHfJN4LdIGBkVs8Vm60n+DeKrgPt5PVedifK+Cm3NP5F3SeJPwS/oB2FYKCA8zukN0yyQNYBXtWe/+xrhcmCYAWjQ8NqevHB1IvCkdGN1UPpGBnHvljMA0ldcA3bgI9Ogo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769643932; c=relaxed/simple;
	bh=lzjDozmyoGLNFTMoPr7TmZu+v0Q+FYcpcrL1b0yTqFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAouF6Sbq0X1e9HtQ3IssiAijNlrWUeKPDLDDbmK7hAewzco1NavuhlZ0z2ooT2E82NOn4uLtgJgR2VxGeF+Rx3Dxlz5X3ZvqlBVWKWJyHr/fUei8d+lRt1X5wTe4bb2DgNhLs0gd6xU05OeItjPDeuhAQEAcH7GECfAMGs7lrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ickUJsK+; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ickUJsK+"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7cfca52ac2dso236720a34.0
        for <git@vger.kernel.org>; Wed, 28 Jan 2026 15:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769643930; x=1770248730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nu0qMQv9mlavulRe3yb10PY3C8JjzHWB0gO+Z4y9URo=;
        b=ickUJsK+/uxcUmlJI4HGYcL0yn3xubnh57IMPnpnVx8rPWG4ZaX/g4E4adTPR2v4Ln
         EZaSvfLwEblmJ4St5dfyfjuxUM0a4NxczsnXrRv102lAQpzZ9pqFlbWitvRLc7LFGUPZ
         JcQZWM8Qlo2hnAB4NQweHnxYg2eelIZgueKoKXrhfu6aIlK0tzrqOl/L7ASRrILB73at
         WC5bbl0zGlMGag0ggLTVfwwEM8sKoGfMWTC4ZkAQUJgca/VOJ0wNR3GqM0gnKkym3W56
         529R5QjyXJuZRvYxiIOVwZvf0YZBx9Px2DPblrzCfoUvdOMecx09d2yKoYEuWOufZksn
         XDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769643930; x=1770248730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nu0qMQv9mlavulRe3yb10PY3C8JjzHWB0gO+Z4y9URo=;
        b=vXgcr9wNlp4Xcyys8OmHQKNC6VfL4Ukag5R6jn2sF7w+FSC7VFKpRS1EPQyK+qGg0F
         BvlSJjNUFV7UN0VA+U1hYzpl3RBdUSbXuq/M1TrDGZqv085w2BRwhP25XPJR6tlcR7Hr
         QU1jmM7Hnr+wWN9Jq4Nf1OM1IfPDLzS1M7DJ8YyQGIeHE0vzzwSa+JnD/dVpncD4v5OQ
         JFpJbO1vnMY69Y8RuMHvxwuTCAqLvHfXmCu8+Uw3tlpepu/1djuhPt2KucDB9MJsHqSb
         3W/Ec5Px3D/1Mzf4cq/I5j7elU/aimFshPtv81iNLBa6+12jGyP1AaGSp95kp1GY98AC
         mI3g==
X-Gm-Message-State: AOJu0YymZwSM6C0FkxTmXzMrZ8PBNQ7PfMDBrO4mzC/CtZN+OqyZUOxp
	0CZaReHZSfewXjx68XQ1xHUPfJ6t2CrpHL5CqYkvnBUrD+LPZGf6J8udduGGrg==
X-Gm-Gg: AZuq6aKFrJM6XXvmq4HZhz+XPAJZEEKsLxu8m4HnSC8Dj3D6mwLAf9zFCyAEndJAIs/
	MdgkpcjoauISiae/nZsedQ0Eu3XcmxRQWD9wDrLP3ms+NMyzGa8XcqR5CpVwnHe4ioJm+LTHCih
	S5Y92L+9neg+e7oKrHZ8S7cSguDUU16S3ZDkDTWFkQ0FrfsC/5qvKzFYuaCcudsvhXBYfe7fyXy
	97BHDJgtk/nSrty83iZwk0H8+pZ73XWM8Xypq/blW4NHTVtgXC3nC4CBVtai3EiS+10yttmALpS
	wBJV4ErZ3THZuYzswV65lPRBRpK+IqQz7MxoIzObEvx8gjfdms2jQ0lfauXGY6AFrt991yIyHmL
	sTVFAYqLmfy2EG/VVyE93b6Rp65WIOxLe3jYaUKqELz+lxyh3fNwBCx09gVAAy+PNEQHYQH6TOE
	u5YJIRGzif7qg2WeR+1QHCfAnJuyDQ8Q==
X-Received: by 2002:a05:6830:439f:b0:7cf:d1b7:c5c6 with SMTP id 46e09a7af769-7d184fd284bmr5016979a34.7.1769643929689;
        Wed, 28 Jan 2026 15:45:29 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d18c67065esm2648676a34.6.2026.01.28.15.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 15:45:29 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 3/4] odb: prepare `struct odb_transaction` to support more sources
Date: Wed, 28 Jan 2026 17:45:18 -0600
Message-ID: <20260128234519.2721179-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.373.g68cb7f9e92
In-Reply-To: <20260128234519.2721179-1-jltobler@gmail.com>
References: <20260128234519.2721179-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each ODB transaction should be specific to the ODB source it pertains
to. Update `struct odb_transaction` to store a commit callback specific
to its object source type. For now `struct odb_transaction_loose` is the
only transaction type and what is always returned when starting a
transaction.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 80 ++++++++++++++++++++++++++++-----------------------
 object-file.h |  6 ----
 odb.c         |  5 +++-
 odb.h         | 17 +++++++++++
 4 files changed, 65 insertions(+), 43 deletions(-)

diff --git a/object-file.c b/object-file.c
index 790be25f08..e4739fc0cc 100644
--- a/object-file.c
+++ b/object-file.c
@@ -710,15 +710,17 @@ struct transaction_packfile {
 	uint32_t nr_written;
 };
 
-struct odb_transaction {
-	struct odb_source *source;
+struct odb_transaction_loose {
+	struct odb_transaction base;
 
 	struct tmp_objdir *objdir;
 	struct transaction_packfile packfile;
 };
 
-static void prepare_loose_object_transaction(struct odb_transaction *transaction)
+static void prepare_loose_object_transaction(struct odb_transaction *base)
 {
+	struct odb_transaction_loose *transaction = (struct odb_transaction_loose *)base;
+
 	/*
 	 * We lazily create the temporary object directory
 	 * the first time an object might be added, since
@@ -728,14 +730,16 @@ static void prepare_loose_object_transaction(struct odb_transaction *transaction
 	if (!transaction || transaction->objdir)
 		return;
 
-	transaction->objdir = tmp_objdir_create(transaction->source->odb->repo, "bulk-fsync");
+	transaction->objdir = tmp_objdir_create(base->source->odb->repo, "bulk-fsync");
 	if (transaction->objdir)
 		tmp_objdir_replace_primary_odb(transaction->objdir, 0);
 }
 
-static void fsync_loose_object_transaction(struct odb_transaction *transaction,
+static void fsync_loose_object_transaction(struct odb_transaction *base,
 					   int fd, const char *filename)
 {
+	struct odb_transaction_loose *transaction = (struct odb_transaction_loose *)base;
+
 	/*
 	 * If we have an active ODB transaction, we issue a call that
 	 * cleans the filesystem page cache but avoids a hardware flush
@@ -754,7 +758,7 @@ static void fsync_loose_object_transaction(struct odb_transaction *transaction,
 /*
  * Cleanup after batch-mode fsync_object_files.
  */
-static void flush_loose_object_transaction(struct odb_transaction *transaction)
+static void flush_loose_object_transaction(struct odb_transaction_loose *transaction)
 {
 	struct strbuf temp_path = STRBUF_INIT;
 	struct tempfile *temp;
@@ -772,7 +776,7 @@ static void flush_loose_object_transaction(struct odb_transaction *transaction)
 	 * the final name is visible.
 	 */
 	strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX",
-		    repo_get_object_directory(transaction->source->odb->repo));
+		    repo_get_object_directory(transaction->base.source->odb->repo));
 	temp = xmks_tempfile(temp_path.buf);
 	fsync_or_die(get_tempfile_fd(temp), get_tempfile_path(temp));
 	delete_tempfile(&temp);
@@ -1340,11 +1344,11 @@ static int index_core(struct index_state *istate,
 	return ret;
 }
 
-static int already_written(struct odb_transaction *transaction,
+static int already_written(struct odb_transaction_loose *transaction,
 			   struct object_id *oid)
 {
 	/* The object may already exist in the repository */
-	if (odb_has_object(transaction->source->odb, oid,
+	if (odb_has_object(transaction->base.source->odb, oid,
 			   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 		return 1;
 
@@ -1358,14 +1362,14 @@ static int already_written(struct odb_transaction *transaction,
 }
 
 /* Lazily create backing packfile for the state */
-static void prepare_packfile_transaction(struct odb_transaction *transaction,
+static void prepare_packfile_transaction(struct odb_transaction_loose *transaction,
 					 unsigned flags)
 {
 	struct transaction_packfile *state = &transaction->packfile;
 	if (!(flags & INDEX_WRITE_OBJECT) || state->f)
 		return;
 
-	state->f = create_tmp_packfile(transaction->source->odb->repo,
+	state->f = create_tmp_packfile(transaction->base.source->odb->repo,
 				       &state->pack_tmp_name);
 	reset_pack_idx_option(&state->pack_idx_opts);
 
@@ -1466,10 +1470,10 @@ static int stream_blob_to_pack(struct transaction_packfile *state,
 	return 0;
 }
 
-static void flush_packfile_transaction(struct odb_transaction *transaction)
+static void flush_packfile_transaction(struct odb_transaction_loose *transaction)
 {
 	struct transaction_packfile *state = &transaction->packfile;
-	struct repository *repo = transaction->source->odb->repo;
+	struct repository *repo = transaction->base.source->odb->repo;
 	unsigned char hash[GIT_MAX_RAWSZ];
 	struct strbuf packname = STRBUF_INIT;
 	char *idx_tmp_name = NULL;
@@ -1494,7 +1498,7 @@ static void flush_packfile_transaction(struct odb_transaction *transaction)
 	}
 
 	strbuf_addf(&packname, "%s/pack/pack-%s.",
-		    repo_get_object_directory(transaction->source->odb->repo),
+		    repo_get_object_directory(transaction->base.source->odb->repo),
 		    hash_to_hex_algop(hash, repo->hash_algo));
 
 	stage_tmp_packfiles(repo, &packname, state->pack_tmp_name,
@@ -1534,7 +1538,7 @@ static void flush_packfile_transaction(struct odb_transaction *transaction)
  * binary blobs, they generally do not want to get any conversion, and
  * callers should avoid this code path when filters are requested.
  */
-static int index_blob_packfile_transaction(struct odb_transaction *transaction,
+static int index_blob_packfile_transaction(struct odb_transaction_loose *transaction,
 					   struct object_id *result_oid, int fd,
 					   size_t size, const char *path,
 					   unsigned flags)
@@ -1553,7 +1557,7 @@ static int index_blob_packfile_transaction(struct odb_transaction *transaction,
 
 	header_len = format_object_header((char *)obuf, sizeof(obuf),
 					  OBJ_BLOB, size);
-	transaction->source->odb->repo->hash_algo->init_fn(&ctx);
+	transaction->base.source->odb->repo->hash_algo->init_fn(&ctx);
 	git_hash_update(&ctx, obuf, header_len);
 
 	/* Note: idx is non-NULL when we are writing */
@@ -1629,10 +1633,11 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 		ret = index_core(istate, oid, fd, xsize_t(st->st_size),
 				 type, path, flags);
 	} else {
+		struct object_database *odb = the_repository->objects;
 		struct odb_transaction *transaction;
 
-		transaction = odb_transaction_begin(the_repository->objects);
-		ret = index_blob_packfile_transaction(the_repository->objects->transaction,
+		transaction = odb_transaction_begin(odb);
+		ret = index_blob_packfile_transaction((struct odb_transaction_loose *)odb->transaction,
 						      oid, fd,
 						      xsize_t(st->st_size),
 						      path, flags);
@@ -1985,35 +1990,38 @@ int read_loose_object(struct repository *repo,
 	return ret;
 }
 
-struct odb_transaction *odb_transaction_loose_begin(struct odb_source *source)
+static void odb_transaction_loose_commit(struct odb_transaction *base)
 {
-	struct object_database *odb = source->odb;
-
-	if (odb->transaction)
-		return NULL;
-
-	CALLOC_ARRAY(odb->transaction, 1);
-	odb->transaction->source = source;
-
-	return odb->transaction;
-}
-
-void odb_transaction_loose_commit(struct odb_transaction *transaction)
-{
-	if (!transaction)
-		return;
+	struct odb_transaction_loose *transaction = (struct odb_transaction_loose *)base;
 
 	/*
 	 * Ensure the transaction ending matches the pending transaction.
 	 */
-	ASSERT(transaction == transaction->source->odb->transaction);
+	ASSERT(base == base->source->odb->transaction);
 
 	flush_loose_object_transaction(transaction);
 	flush_packfile_transaction(transaction);
-	transaction->source->odb->transaction = NULL;
+	base->source->odb->transaction = NULL;
 	free(transaction);
 }
 
+struct odb_transaction *odb_transaction_loose_begin(struct odb_source *source)
+{
+	struct odb_transaction_loose *transaction;
+	struct object_database *odb = source->odb;
+
+	if (odb->transaction)
+		return NULL;
+
+	transaction = xcalloc(1, sizeof(*transaction));
+	transaction->base.source = source;
+	transaction->base.commit = odb_transaction_loose_commit;
+
+	odb->transaction = &transaction->base;
+
+	return &transaction->base;
+}
+
 struct odb_source_loose *odb_source_loose_new(struct odb_source *source)
 {
 	struct odb_source_loose *loose;
diff --git a/object-file.h b/object-file.h
index 03f0474656..1bd355b7f4 100644
--- a/object-file.h
+++ b/object-file.h
@@ -208,10 +208,4 @@ struct odb_transaction;
  */
 struct odb_transaction *odb_transaction_loose_begin(struct odb_source *source);
 
-/*
- * Tell the object database to make any objects from the
- * current transaction visible.
- */
-void odb_transaction_loose_commit(struct odb_transaction *transaction);
-
 #endif /* OBJECT_FILE_H */
diff --git a/odb.c b/odb.c
index 90dcbca821..5b112f2464 100644
--- a/odb.c
+++ b/odb.c
@@ -1158,5 +1158,8 @@ struct odb_transaction *odb_transaction_begin(struct object_database *odb)
 
 void odb_transaction_commit(struct odb_transaction *transaction)
 {
-	odb_transaction_loose_commit(transaction);
+	if (!transaction)
+		return;
+
+	transaction->commit(transaction);
 }
diff --git a/odb.h b/odb.h
index bab07755f4..83d3a37805 100644
--- a/odb.h
+++ b/odb.h
@@ -77,7 +77,24 @@ struct odb_source {
 struct packed_git;
 struct packfile_store;
 struct cached_object_entry;
+
+/*
+ * A transaction may be started for an object database prior to writing new
+ * objects via odb_transaction_begin(). These objects are not committed until
+ * odb_transaction_commit() is invoked. Only a single transaction may be pending
+ * at a time.
+ *
+ * Each ODB source is expected to implement its own transaction handling.
+ */
 struct odb_transaction;
+typedef void (*odb_transaction_commit_fn)(struct odb_transaction *transaction);
+struct odb_transaction {
+	/* The ODB source the transaction is opened against. */
+	struct odb_source *source;
+
+	/* The ODB source specific callback invoked to commit a transaction. */
+	odb_transaction_commit_fn commit;
+};
 
 /*
  * The object database encapsulates access to objects in a repository. It
-- 
2.52.0.373.g68cb7f9e92


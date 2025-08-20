Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B188D2DAFBA
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 22:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755730551; cv=none; b=pKbszjdj+u04XhVJ3jdrkVfrgz95Wwb2LnwG0bRKWOWCiYjV9EdaZfeU6jOyXfohTSdsM77UJSRAzLGlli699oANo14/ap88dqeuU5gckoY6fxVOB7iYiRoyBGbKpf05oM4hoTQ+9FJRVgM11p1u/e4ypY2mEyHdW0dmMl38Lqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755730551; c=relaxed/simple;
	bh=SXDFg+d9mV3PPAhXg7uWGzkvq+4+JB97QLCUnhsCVVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzQU9bDbF4uJygj+bPuLagyg+VdsKnFlLyPilui30NNVHEcERVmuLE0iOlvkZqohFGp7yENRLX7eAkQhIdwQNl5enJD6Vwo1WQVDR+uGycq06kY52D6E5pggMgzSZLpk12yHYjVMet7y98M6DncOj8Ou/YnjD+ZwPpMGvQDMU0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6s5pC0j; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6s5pC0j"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-30cce52ba30so349755fac.0
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 15:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755730548; x=1756335348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZvTnCkb1nBPDMOiExKYQfY10d9dtIShwmfSVtLT+Pk=;
        b=c6s5pC0jkDe0Hp/EeRVfWR1AeiKPcp1HxFLaYyk1HDCMObR0Thxx5q+NGk3AgiBD9x
         a2zLp97bW74Wr4bYihzrq47QUAZlI+LZqBecRKE1+IYXFvNhPCwg3WmqA5YELcss8uuX
         dPsL3RqN5CLIAAz3WigKbjfhGxUt94G7uoeDINyCKZlFjLZVAe+wo2ACwOBWUYs8jQ2E
         pwa9l+KTwN6BdfFnGUqzCQ3aNuf2Jo5Z/YRbujE/kh9uQNW0i8CuUXoSaelCnJx9vP91
         4Y4ZHLxr2ZxMRca34E10m3DBpSMmgcG/4OBY+ypz7wyhyySr6BBg7zkZ9pk6qgIpmBRQ
         NEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755730548; x=1756335348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZvTnCkb1nBPDMOiExKYQfY10d9dtIShwmfSVtLT+Pk=;
        b=d/BUleR4ja94y5qDJ/rqM/OiB6IltjF0LaNBqMuL7w8p1KDrB8aM+GTU2EggS0wh4+
         gCKMoaHkOp0HSPMRXTi20pXKQk8GpgsmB8EykkXfD15/7mGdthljlhjU0+qearal5h47
         5P1XpnJoyfzdyCLINl/eGLQ3pHb4XX8oh1wZ8Nzy9PF01CWlcC0rHeUzFUfb34HLKw+r
         xc+JNI/L3/j0UloTdz9ulvOmxtEv0mDs7/xsjDDzACBtDSRyoOpYrEr720LE/rCVQa+e
         Derkvy8ZYgdOpy8jDhnDGvwbFELRbBpg5arnK8mLYU33m2yIvSvqoWFHKMquc1fvTw/N
         4kkg==
X-Gm-Message-State: AOJu0Yy6RfaRLQrTesrQWJzYDoVnFYNM1XYrqeSKEw6RW0GcSGx3Xwak
	iUNnmD0yQG7in8yB3oScnj9wj8Z8SnAx5CzHnZe9sVmc77lvHVwntlENHvqN6LP8
X-Gm-Gg: ASbGncuwPP2SAKOda6RWWzygRLM+RKP+yraaN29Wg7EwBftXiUylgwv8U9BkPaG2I1z
	oIv8WVra5c7SvFEOO2q9fraLTCiMJHlqW75o8/7BY8GGurNLmEHzNytC8KnCv+ZKe3NEYiwCGIn
	0ne/KNqOa4xTBH1LzX6nESuroXWwZabGXWkwFoEAMnLh8BTKyoCvEL21jDAF+CKBwYk9qxoiOml
	as+Q8zO6y8R2TderAPZYiXwVtPzdXYUgrgmfPt0xbQ+z0tNiIel0Hsaz0urpNptzMUvCADpPRp6
	yuSZZqeKbu45so7LlNVpljy1Qeevxeg0MJytJoq2AoJIFEZj7NVVExTlxxyTG+uRyC5B2woKJBc
	HMMHdlyuzrlAZz+/qF9KcI7brBUh12HE=
X-Google-Smtp-Source: AGHT+IEGgenPRl6Ii44SA+5WCx/bmqlt8K+D/cCAGG9dHOpBitrt9thsl0Hbuw+dLjHaboJ5dT+d9w==
X-Received: by 2002:a05:6871:7813:b0:306:9f8e:6699 with SMTP id 586e51a60fabf-314c6566acbmr199500fac.30.1755730548125;
        Wed, 20 Aug 2025 15:55:48 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3111d32f9e8sm1175860fac.21.2025.08.20.15.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 15:55:47 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 2/3] bulk-checkin: remove global transaction state
Date: Wed, 20 Aug 2025 17:55:30 -0500
Message-ID: <20250820225531.1212935-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250820225531.1212935-1-jltobler@gmail.com>
References: <20250820225531.1212935-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Object database transactions in the bulk-checkin subsystem rely on
global state to track transaction status. Stop relying on global state
and instead store the transaction in the `struct object_database`.
Functions that operate on transactions are updated to now wire
transaction state.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/add.c            |  5 ++-
 builtin/unpack-objects.c |  5 ++-
 builtin/update-index.c   |  7 ++--
 bulk-checkin.c           | 82 ++++++++++++++++++++++++++--------------
 bulk-checkin.h           | 18 +++++----
 cache-tree.c             |  5 ++-
 object-file.c            | 11 +++---
 odb.h                    |  8 ++++
 read-cache.c             |  5 ++-
 9 files changed, 94 insertions(+), 52 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 0235854f809..740c7c45817 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -389,6 +389,7 @@ int cmd_add(int argc,
 	char *seen = NULL;
 	char *ps_matched = NULL;
 	struct lock_file lock_file = LOCK_INIT;
+	struct odb_transaction *transaction;
 
 	repo_config(repo, add_config, NULL);
 
@@ -574,7 +575,7 @@ int cmd_add(int argc,
 		string_list_clear(&only_match_skip_worktree, 0);
 	}
 
-	begin_odb_transaction();
+	transaction = begin_odb_transaction(repo->objects);
 
 	ps_matched = xcalloc(pathspec.nr, 1);
 	if (add_renormalize)
@@ -593,7 +594,7 @@ int cmd_add(int argc,
 
 	if (chmod_arg && pathspec.nr)
 		exit_status |= chmod_pathspec(repo, &pathspec, chmod_arg[0], show_only);
-	end_odb_transaction();
+	end_odb_transaction(transaction);
 
 finish:
 	if (write_locked_index(repo->index, &lock_file,
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 7ae7c82b6c0..28124b324d2 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -584,6 +584,7 @@ static void unpack_all(void)
 {
 	int i;
 	unsigned char *hdr = fill(sizeof(struct pack_header));
+	struct odb_transaction *transaction;
 
 	if (get_be32(hdr) != PACK_SIGNATURE)
 		die("bad pack file");
@@ -599,12 +600,12 @@ static void unpack_all(void)
 		progress = start_progress(the_repository,
 					  _("Unpacking objects"), nr_objects);
 	CALLOC_ARRAY(obj_list, nr_objects);
-	begin_odb_transaction();
+	transaction = begin_odb_transaction(the_repository->objects);
 	for (i = 0; i < nr_objects; i++) {
 		unpack_one(i);
 		display_progress(progress, i + 1);
 	}
-	end_odb_transaction();
+	end_odb_transaction(transaction);
 	stop_progress(&progress);
 
 	if (delta_list)
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 2380f3ccd68..2ba2d29c959 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -77,7 +77,7 @@ static void report(const char *fmt, ...)
 	 * objects invisible while a transaction is active, so flush the
 	 * transaction here before reporting a change made by update-index.
 	 */
-	flush_odb_transaction();
+	flush_odb_transaction(the_repository->objects->transaction);
 	va_start(vp, fmt);
 	vprintf(fmt, vp);
 	putchar('\n');
@@ -940,6 +940,7 @@ int cmd_update_index(int argc,
 	strbuf_getline_fn getline_fn;
 	int parseopt_state = PARSE_OPT_UNKNOWN;
 	struct repository *r = the_repository;
+	struct odb_transaction *transaction;
 	struct option options[] = {
 		OPT_BIT('q', NULL, &refresh_args.flags,
 			N_("continue refresh even when index needs update"),
@@ -1130,7 +1131,7 @@ int cmd_update_index(int argc,
 	 * Allow the object layer to optimize adding multiple objects in
 	 * a batch.
 	 */
-	begin_odb_transaction();
+	transaction = begin_odb_transaction(the_repository->objects);
 	while (ctx.argc) {
 		if (parseopt_state != PARSE_OPT_DONE)
 			parseopt_state = parse_options_step(&ctx, options,
@@ -1213,7 +1214,7 @@ int cmd_update_index(int argc,
 	/*
 	 * By now we have added all of the new objects
 	 */
-	end_odb_transaction();
+	end_odb_transaction(transaction);
 
 	if (split_index > 0) {
 		if (repo_config_get_split_index(the_repository) == 0)
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 82a73da79e8..53a20a2d92f 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -30,11 +30,13 @@ struct bulk_checkin_packfile {
 	uint32_t nr_written;
 };
 
-static struct odb_transaction {
+struct odb_transaction {
+	struct object_database *odb;
+
 	int nesting;
 	struct tmp_objdir *objdir;
 	struct bulk_checkin_packfile packfile;
-} transaction;
+};
 
 static void finish_tmp_packfile(struct strbuf *basename,
 				const char *pack_tmp_name,
@@ -98,12 +100,12 @@ static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state)
 /*
  * Cleanup after batch-mode fsync_object_files.
  */
-static void flush_batch_fsync(void)
+static void flush_batch_fsync(struct odb_transaction *transaction)
 {
 	struct strbuf temp_path = STRBUF_INIT;
 	struct tempfile *temp;
 
-	if (!transaction.objdir)
+	if (!transaction->objdir)
 		return;
 
 	/*
@@ -125,8 +127,8 @@ static void flush_batch_fsync(void)
 	 * Make the object files visible in the primary ODB after their data is
 	 * fully durable.
 	 */
-	tmp_objdir_migrate(transaction.objdir);
-	transaction.objdir = NULL;
+	tmp_objdir_migrate(transaction->objdir);
+	transaction->objdir = NULL;
 }
 
 static int already_written(struct bulk_checkin_packfile *state, struct object_id *oid)
@@ -325,7 +327,7 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 	return 0;
 }
 
-void prepare_loose_object_bulk_checkin(void)
+void prepare_loose_object_bulk_checkin(struct odb_transaction *transaction)
 {
 	/*
 	 * We lazily create the temporary object directory
@@ -333,15 +335,16 @@ void prepare_loose_object_bulk_checkin(void)
 	 * callers may not know whether any objects will be
 	 * added at the time they call begin_odb_transaction.
 	 */
-	if (!transaction.nesting || transaction.objdir)
+	if (!transaction || transaction->objdir)
 		return;
 
-	transaction.objdir = tmp_objdir_create(the_repository, "bulk-fsync");
-	if (transaction.objdir)
-		tmp_objdir_replace_primary_odb(transaction.objdir, 0);
+	transaction->objdir = tmp_objdir_create(the_repository, "bulk-fsync");
+	if (transaction->objdir)
+		tmp_objdir_replace_primary_odb(transaction->objdir, 0);
 }
 
-void fsync_loose_object_bulk_checkin(int fd, const char *filename)
+void fsync_loose_object_bulk_checkin(struct odb_transaction *transaction,
+				     int fd, const char *filename)
 {
 	/*
 	 * If we have an active ODB transaction, we issue a call that
@@ -350,7 +353,7 @@ void fsync_loose_object_bulk_checkin(int fd, const char *filename)
 	 * before renaming the objects to their final names as part of
 	 * flush_batch_fsync.
 	 */
-	if (!transaction.objdir ||
+	if (!transaction || !transaction->objdir ||
 	    git_fsync(fd, FSYNC_WRITEOUT_ONLY) < 0) {
 		if (errno == ENOSYS)
 			warning(_("core.fsyncMethod = batch is unsupported on this platform"));
@@ -358,36 +361,57 @@ void fsync_loose_object_bulk_checkin(int fd, const char *filename)
 	}
 }
 
-int index_blob_bulk_checkin(struct object_id *oid,
-			    int fd, size_t size,
+int index_blob_bulk_checkin(struct odb_transaction *transaction,
+			    struct object_id *oid, int fd, size_t size,
 			    const char *path, unsigned flags)
 {
-	int status = deflate_blob_to_pack(&transaction.packfile, oid, fd, size,
-					  path, flags);
-	if (!transaction.nesting)
-		flush_bulk_checkin_packfile(&transaction.packfile);
+	int status;
+
+	if (transaction) {
+		status = deflate_blob_to_pack(&transaction->packfile, oid, fd,
+					      size, path, flags);
+	} else {
+		struct bulk_checkin_packfile state = { 0 };
+
+		status = deflate_blob_to_pack(&state, oid, fd, size, path, flags);
+		flush_bulk_checkin_packfile(&state);
+	}
+
 	return status;
 }
 
-void begin_odb_transaction(void)
+struct odb_transaction *begin_odb_transaction(struct object_database *odb)
 {
-	transaction.nesting += 1;
+	if (!odb->transaction) {
+		CALLOC_ARRAY(odb->transaction, 1);
+		odb->transaction->odb = odb;
+	}
+
+	odb->transaction->nesting += 1;
+
+	return odb->transaction;
 }
 
-void flush_odb_transaction(void)
+void flush_odb_transaction(struct odb_transaction *transaction)
 {
-	flush_batch_fsync();
-	flush_bulk_checkin_packfile(&transaction.packfile);
+	if (!transaction)
+		return;
+
+	flush_batch_fsync(transaction);
+	flush_bulk_checkin_packfile(&transaction->packfile);
 }
 
-void end_odb_transaction(void)
+void end_odb_transaction(struct odb_transaction *transaction)
 {
-	transaction.nesting -= 1;
-	if (transaction.nesting < 0)
+	if (!transaction || transaction->nesting == 0)
 		BUG("Unbalanced ODB transaction nesting");
 
-	if (transaction.nesting)
+	transaction->nesting -= 1;
+
+	if (transaction->nesting)
 		return;
 
-	flush_odb_transaction();
+	flush_odb_transaction(transaction);
+	transaction->odb->transaction = NULL;
+	free(transaction);
 }
diff --git a/bulk-checkin.h b/bulk-checkin.h
index 7246ea58dcf..16254ce6a70 100644
--- a/bulk-checkin.h
+++ b/bulk-checkin.h
@@ -5,9 +5,13 @@
 #define BULK_CHECKIN_H
 
 #include "object.h"
+#include "odb.h"
 
-void prepare_loose_object_bulk_checkin(void);
-void fsync_loose_object_bulk_checkin(int fd, const char *filename);
+struct odb_transaction;
+
+void prepare_loose_object_bulk_checkin(struct odb_transaction *transaction);
+void fsync_loose_object_bulk_checkin(struct odb_transaction *transaction,
+				     int fd, const char *filename);
 
 /*
  * This creates one packfile per large blob unless bulk-checkin
@@ -24,8 +28,8 @@ void fsync_loose_object_bulk_checkin(int fd, const char *filename);
  * binary blobs, they generally do not want to get any conversion, and
  * callers should avoid this code path when filters are requested.
  */
-int index_blob_bulk_checkin(struct object_id *oid,
-			    int fd, size_t size,
+int index_blob_bulk_checkin(struct odb_transaction *transaction,
+			    struct object_id *oid, int fd, size_t size,
 			    const char *path, unsigned flags);
 
 /*
@@ -35,20 +39,20 @@ int index_blob_bulk_checkin(struct object_id *oid,
  * and objects are only visible after the outermost transaction
  * is complete or the transaction is flushed.
  */
-void begin_odb_transaction(void);
+struct odb_transaction *begin_odb_transaction(struct object_database *odb);
 
 /*
  * Make any objects that are currently part of a pending object
  * database transaction visible. It is valid to call this function
  * even if no transaction is active.
  */
-void flush_odb_transaction(void);
+void flush_odb_transaction(struct odb_transaction *transaction);
 
 /*
  * Tell the object database to make any objects from the
  * current transaction visible if this is the final nested
  * transaction.
  */
-void end_odb_transaction(void);
+void end_odb_transaction(struct odb_transaction *transaction);
 
 #endif
diff --git a/cache-tree.c b/cache-tree.c
index 66ef2becbe0..d225554eedd 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -474,6 +474,7 @@ static int update_one(struct cache_tree *it,
 
 int cache_tree_update(struct index_state *istate, int flags)
 {
+	struct odb_transaction *transaction;
 	int skip, i;
 
 	i = verify_cache(istate, flags);
@@ -489,10 +490,10 @@ int cache_tree_update(struct index_state *istate, int flags)
 
 	trace_performance_enter();
 	trace2_region_enter("cache_tree", "update", the_repository);
-	begin_odb_transaction();
+	transaction = begin_odb_transaction(the_repository->objects);
 	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
 		       "", 0, &skip, flags);
-	end_odb_transaction();
+	end_odb_transaction(transaction);
 	trace2_region_leave("cache_tree", "update", the_repository);
 	trace_performance_leave("cache_tree_update");
 	if (i < 0)
diff --git a/object-file.c b/object-file.c
index 2bc36ab3ee8..1740aa2b2e3 100644
--- a/object-file.c
+++ b/object-file.c
@@ -674,7 +674,7 @@ static void close_loose_object(struct odb_source *source,
 		goto out;
 
 	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
-		fsync_loose_object_bulk_checkin(fd, filename);
+		fsync_loose_object_bulk_checkin(source->odb->transaction, fd, filename);
 	else if (fsync_object_files > 0)
 		fsync_or_die(fd, filename);
 	else
@@ -852,7 +852,7 @@ static int write_loose_object(struct odb_source *source,
 	static struct strbuf filename = STRBUF_INIT;
 
 	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
-		prepare_loose_object_bulk_checkin();
+		prepare_loose_object_bulk_checkin(source->odb->transaction);
 
 	odb_loose_path(source, &filename, oid);
 
@@ -941,7 +941,7 @@ int stream_loose_object(struct odb_source *source,
 	int hdrlen;
 
 	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
-		prepare_loose_object_bulk_checkin();
+		prepare_loose_object_bulk_checkin(source->odb->transaction);
 
 	/* Since oid is not determined, save tmp file to odb path. */
 	strbuf_addf(&filename, "%s/", source->path);
@@ -1263,8 +1263,9 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 		ret = index_core(istate, oid, fd, xsize_t(st->st_size),
 				 type, path, flags);
 	else
-		ret = index_blob_bulk_checkin(oid, fd, xsize_t(st->st_size), path,
-					     flags);
+		ret = index_blob_bulk_checkin(the_repository->objects->transaction,
+					      oid, fd, xsize_t(st->st_size),
+					      path, flags);
 	close(fd);
 	return ret;
 }
diff --git a/odb.h b/odb.h
index 3dfc66d75a3..a89b2143909 100644
--- a/odb.h
+++ b/odb.h
@@ -84,6 +84,7 @@ struct odb_source {
 
 struct packed_git;
 struct cached_object_entry;
+struct odb_transaction;
 
 /*
  * The object database encapsulates access to objects in a repository. It
@@ -94,6 +95,13 @@ struct object_database {
 	/* Repository that owns this database. */
 	struct repository *repo;
 
+	/*
+	 * State of current current object database transaction. Only one
+	 * transaction may be pending at a time. Is NULL when no transaction is
+	 * configured.
+	 */
+	struct odb_transaction *transaction;
+
 	/*
 	 * Set of all object directories; the main directory is first (and
 	 * cannot be NULL after initialization). Subsequent directories are
diff --git a/read-cache.c b/read-cache.c
index 06ad74db228..229b8ef11c9 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3947,6 +3947,7 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
 		       const struct pathspec *pathspec, char *ps_matched,
 		       int include_sparse, int flags)
 {
+	struct odb_transaction *transaction;
 	struct update_callback_data data;
 	struct rev_info rev;
 
@@ -3972,9 +3973,9 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
 	 * This function is invoked from commands other than 'add', which
 	 * may not have their own transaction active.
 	 */
-	begin_odb_transaction();
+	transaction = begin_odb_transaction(repo->objects);
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
-	end_odb_transaction();
+	end_odb_transaction(transaction);
 
 	release_revisions(&rev);
 	return !!data.add_errors;
-- 
2.51.0


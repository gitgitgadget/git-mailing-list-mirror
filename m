Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8702BEFE8
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 19:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786736334; cv=none; b=fEWDWQCeXoF2Zbgi6AEPPlxscwrcldDMyqcci9lpBIsI44HaJ9qx1+2b6Tb+Lz7DSCqHOeBVA28+YQiEb8O2kI2XjlJYd9xpnRNfspjOD8GHImAT3+fYmAKL3jG8gDxuHFd+UU2iwPTPmXdm8G2Hp6qSSGWvA2aBorELKS96jeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786736334; c=relaxed/simple;
	bh=Jrw8DUd6V2VNV/fJWe4AfNbZ9UQ69x6eWvv+C6XrFHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pq3zZw/V77bLW++ES/u667hm7hFJ10QDKkd87cHQ6b1lC0ns2y5Kfc6vl4eeuJ/SSYAzpewRRrwia0SO+avO8XnXKrjt0V6VRHaFFaB+prpdb2aPtlEFdShTtEQLZGtq3SI7j1cBB61qXfG1E/tpKmJ6Z0+lLwNwqWnipIoC4Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNVF2JNL; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNVF2JNL"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso1964524a91.2
        for <git@vger.kernel.org>; Fri, 14 Aug 2026 12:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786736331; x=1787341131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nOPQJbju/0Ex0mFO0KwiQGk/CW2dBVeznRYJqtgxVuM=;
        b=PNVF2JNLSpyEWJE8JknPExXGOFBopP1X2AjljUVr/ZNVoHk1F8SSNUUPC2uQo+gS+u
         YgIcrFul+chBFRboSQFASBUmIe5Cm0GKdGir3KgJ6nI15RIIUgs0AhSX4V26snnG2Zsm
         hdjeNvH9y3ka/TZdgqkJ2VDVJ02dTwBk5eiIAH2OH6WPnmaSr2ypdBqyPHUiI/wbbqB0
         e7NeIZi4XzAht5yTG9GndGI7VBRFs4HxOV9iWojEt1kKKYd1UXmBGEJSPvGsaH8sJzYC
         LBIuHSTpF+3N7ZTisX4NPIKBpE9VbjPhn8shxW/heF3zkaaifcVCSFf8CwaFLVfbYTU1
         K9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786736331; x=1787341131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nOPQJbju/0Ex0mFO0KwiQGk/CW2dBVeznRYJqtgxVuM=;
        b=MBi6jS+d0dEyuVswnURrHWdeqt9o09ZVV0aNwqaYHAPvesePeEVDDxTpz5s1PnPgJ3
         vntA0pgXqd8H8qDPZ4pmCy7L4tR9Nl0VDUPGBqlGqrWq7P5ayytncLBrfDTLLIssmbH0
         VuxlLgr1LKmpu2mx2QHo4FuZJktgEoHspgBB1EtP6ZBd4kYYtBVGHDtY2/ShaZsfZmzY
         2tVIIVQETa5nPlzuCCOF346vYGszQIN7ns5JReUyRkv7c2BUpbB7Zs02UCtruwuzbFga
         eok7ylTvXVBR8d/ceAslNMmzz6gvU9aGiMsB1g8gLTtnCQi2cRi3NrjoASteE3o6rrpA
         XMsQ==
X-Gm-Message-State: AOJu0YzLxABJlTaBKB3SSCgfOHSiHEMW3PZBaWrBBlWApcCKfVV/0siO
	yPfbLcVxavanm1mfhkwHlbs/wZ7cgPYbusJgmcZI8UZB/N/sjNmxMzKpzM+5Qw==
X-Gm-Gg: AR+sD11nb3fjC3QhUH1c68eg5+49pRq2GNBGbqYaxK2RzZQ3mgDyBS/70Ol4H063Zr2
	GZl4eBr0/SDBkJ1pFVZqgvU/7bgiWKsQ5dOp2NrYT/PS7cjzVKgb8EmfbdTm+20UfKt+6WLOqWG
	J7EFTFjAkWcPiHAPJFg2Kwo1geCbBGOi3vaBvDgD2sZytRehqUg6zh2t+zariSdc6sR8WayGVq8
	DLKXM5CCnvNFwki50P66hvFRQHEqlHYPucWTHQqy+s0tk2OTDPDeE+yZqUEeiUGBCOYi0CUuyF8
	XnyaRZJcTPPid/uXfNNq1an8/vn2wfb0pgoLC4WdTxEeS0qgiYIq8ptUg6sLQV6E6fTWg3CfHrV
	QoGDREmrwIzCQosbdCKEwavvJ1Yj2do677Nt58EygC2kxEMQQhA/ECY+lsE/ieTPVeXHHZkEVqB
	hx984dsiBjzXDGJbUsoKdeNFLcnxFeqZuEOKPqLdLn4kB+g5h407FPcwTKRn3vjl71dqW/2Ce5+
	zL/oy1UElrg
X-Received: by 2002:a17:90b:1c0a:b0:38a:c3f:3b87 with SMTP id 98e67ed59e1d1-3933b8721acmr7497987a91.12.1786736331149;
        Fri, 14 Aug 2026 12:38:51 -0700 (PDT)
Received: from Velociraptor ([172.88.119.157])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1413887ee65sm11235096c88.10.2026.08.14.12.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 12:38:50 -0700 (PDT)
From: Colin Hinton <colinlewishinton@gmail.com>
To: git@vger.kernel.org
Cc: Colin Hinton <colinlewishinton@gmail.com>
Subject: [PATCH] chdir-notify.h: Removed unused param 'name'
Date: Fri, 14 Aug 2026 12:38:49 -0700
Message-ID: <20260814193849.1538-1-colinlewishinton@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

the `name` parameter in `chdir_notify_entry` is only set to NULL.
Dropped to simplify logic in `chdir_notify_unregister`

Signed-off-by: Colin Hinton <colinlewishinton@gmail.com>
---
 chdir-notify.c          | 12 ++++--------
 chdir-notify.h          |  8 +++-----
 odb/source-files.c      |  7 +++----
 odb/source-loose.c      |  7 +++----
 odb/source-packed.c     |  7 +++----
 refs/files-backend.c    |  7 +++----
 refs/packed-backend.c   |  7 +++----
 refs/reftable-backend.c |  7 +++----
 setup.c                 |  5 ++---
 tmp-objdir.c            |  7 +++----
 10 files changed, 30 insertions(+), 44 deletions(-)

diff --git a/chdir-notify.c b/chdir-notify.c
index 1237a45e2e..55773c24c9 100644
--- a/chdir-notify.c
+++ b/chdir-notify.c
@@ -7,25 +7,22 @@
 #include "trace.h"
 
 struct chdir_notify_entry {
-	const char *name;
 	chdir_notify_callback cb;
 	void *data;
 	struct list_head list;
 };
 static LIST_HEAD(chdir_notify_entries);
 
-void chdir_notify_register(const char *name,
-			   chdir_notify_callback cb,
+void chdir_notify_register(chdir_notify_callback cb,
 			   void *data)
 {
 	struct chdir_notify_entry *e = xmalloc(sizeof(*e));
-	e->name = name;
 	e->cb = cb;
 	e->data = data;
 	list_add_tail(&e->list, &chdir_notify_entries);
 }
 
-void chdir_notify_unregister(const char *name, chdir_notify_callback cb,
+void chdir_notify_unregister(chdir_notify_callback cb,
 			     void *data)
 {
 	struct list_head *pos, *p;
@@ -34,8 +31,7 @@ void chdir_notify_unregister(const char *name, chdir_notify_callback cb,
 		struct chdir_notify_entry *e =
 			list_entry(pos, struct chdir_notify_entry, list);
 
-		if (e->cb != cb || e->data != data || !e->name != !name ||
-		    (e->name && strcmp(e->name, name)))
+		if (e->cb != cb || e->data != data)
 			continue;
 
 		list_del(pos);
@@ -64,7 +60,7 @@ int chdir_notify(const char *new_cwd)
 	list_for_each(pos, &chdir_notify_entries) {
 		struct chdir_notify_entry *e =
 			list_entry(pos, struct chdir_notify_entry, list);
-		e->cb(e->name, old_cwd.buf, new_cwd, e->data);
+		e->cb(old_cwd.buf, new_cwd, e->data);
 	}
 
 	strbuf_release(&old_cwd);
diff --git a/chdir-notify.h b/chdir-notify.h
index 36b4114472..e4ae38e12d 100644
--- a/chdir-notify.h
+++ b/chdir-notify.h
@@ -33,13 +33,11 @@
  * $GIT_TRACE_SETUP. It may be NULL, but if non-NULL should point to
  * storage which lasts as long as the registration is active.
  */
-typedef void (*chdir_notify_callback)(const char *name,
-				      const char *old_cwd,
+typedef void (*chdir_notify_callback)(const char *old_cwd,
 				      const char *new_cwd,
 				      void *data);
-void chdir_notify_register(const char *name, chdir_notify_callback cb, void *data);
-void chdir_notify_unregister(const char *name, chdir_notify_callback cb,
-			     void *data);
+void chdir_notify_register(chdir_notify_callback cb, void *data);
+void chdir_notify_unregister(chdir_notify_callback cb, void *data);
 
 /*
  *
diff --git a/odb/source-files.c b/odb/source-files.c
index 5a68af7d84..c12e2795ba 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -22,8 +22,7 @@
 #include "tree.h"
 #include "write-or-die.h"
 
-static void odb_source_files_reparent(const char *name UNUSED,
-				      const char *old_cwd,
+static void odb_source_files_reparent(const char *old_cwd,
 				      const char *new_cwd,
 				      void *cb_data)
 {
@@ -37,7 +36,7 @@ static void odb_source_files_reparent(const char *name UNUSED,
 static void odb_source_files_free(struct odb_source *source)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
-	chdir_notify_unregister(NULL, odb_source_files_reparent, files);
+	chdir_notify_unregister(odb_source_files_reparent, files);
 	odb_source_free(&files->loose->base);
 	odb_source_free(&files->packed->base);
 	odb_source_release(&files->base);
@@ -763,7 +762,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	 * paths in the primary ODB source in some user-facing functionality.
 	 */
 	if (!is_absolute_path(path))
-		chdir_notify_register(NULL, odb_source_files_reparent, files);
+		chdir_notify_register(odb_source_files_reparent, files);
 
 	return files;
 }
diff --git a/odb/source-loose.c b/odb/source-loose.c
index ef0e919277..6a594a6458 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -1006,8 +1006,7 @@ static void odb_source_loose_close(struct odb_source *source UNUSED)
 	/* Nothing to do. */
 }
 
-static void odb_source_loose_reparent(const char *name UNUSED,
-				      const char *old_cwd,
+static void odb_source_loose_reparent(const char *old_cwd,
 				      const char *new_cwd,
 				      void *cb_data)
 {
@@ -1023,7 +1022,7 @@ static void odb_source_loose_free(struct odb_source *source)
 	struct odb_source_loose *loose = odb_source_loose_downcast(source);
 	odb_source_loose_clear_cache(loose);
 	loose_object_map_clear(&loose->map);
-	chdir_notify_unregister(NULL, odb_source_loose_reparent, loose);
+	chdir_notify_unregister(odb_source_loose_reparent, loose);
 	odb_source_release(&loose->base);
 	free(loose);
 }
@@ -1053,7 +1052,7 @@ struct odb_source_loose *odb_source_loose_new(struct object_database *odb,
 	loose->base.write_alternate = odb_source_loose_write_alternate;
 
 	if (!is_absolute_path(loose->base.path))
-		chdir_notify_register(NULL, odb_source_loose_reparent, loose);
+		chdir_notify_register(odb_source_loose_reparent, loose);
 
 	return loose;
 }
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 0890704e76..8d028971cd 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -786,8 +786,7 @@ static void odb_source_packed_prepare(struct odb_source *source,
 	packed->initialized = true;
 }
 
-static void odb_source_packed_reparent(const char *name UNUSED,
-				       const char *old_cwd,
+static void odb_source_packed_reparent(const char *old_cwd,
 				       const char *new_cwd,
 				       void *cb_data)
 {
@@ -816,7 +815,7 @@ static void odb_source_packed_free(struct odb_source *source)
 {
 	struct odb_source_packed *packed = odb_source_packed_downcast(source);
 
-	chdir_notify_unregister(NULL, odb_source_packed_reparent, packed);
+	chdir_notify_unregister(odb_source_packed_reparent, packed);
 
 	for (struct packfile_list_entry *e = packed->packs.head; e; e = e->next)
 		free(e->pack);
@@ -853,7 +852,7 @@ struct odb_source_packed *odb_source_packed_new(struct object_database *odb,
 	packed->base.write_alternate = odb_source_packed_write_alternate;
 
 	if (!is_absolute_path(path))
-		chdir_notify_register(NULL, odb_source_packed_reparent, packed);
+		chdir_notify_register(odb_source_packed_reparent, packed);
 
 	return packed;
 }
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1cc20aa486..71628550f2 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -111,8 +111,7 @@ static void clear_loose_ref_cache(struct files_ref_store *refs)
 	}
 }
 
-static void files_ref_store_reparent(const char *name UNUSED,
-				     const char *old_cwd,
+static void files_ref_store_reparent(const char *old_cwd,
 				     const char *new_cwd,
 				     void *payload)
 {
@@ -182,7 +181,7 @@ static struct ref_store *files_ref_store_init(struct repository *repo,
 		packed_ref_store_init(repo, NULL, refs->gitcommondir, opts);
 	refs->store_flags = opts->access_flags;
 
-	chdir_notify_register(NULL, files_ref_store_reparent, refs);
+	chdir_notify_register(files_ref_store_reparent, refs);
 
 	strbuf_release(&refdir);
 
@@ -234,7 +233,7 @@ static void files_ref_store_release(struct ref_store *ref_store)
 	free(refs->gitcommondir);
 	ref_store_release(refs->packed_ref_store);
 	free(refs->packed_ref_store);
-	chdir_notify_unregister(NULL, files_ref_store_reparent, refs);
+	chdir_notify_unregister(files_ref_store_reparent, refs);
 }
 
 static void files_reflog_path(struct files_ref_store *refs,
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index b9b04b7010..a73fc6aca7 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -217,8 +217,7 @@ static size_t snapshot_hexsz(const struct snapshot *snapshot)
 	return snapshot->refs->base.repo->hash_algo->hexsz;
 }
 
-static void packed_ref_store_reparent(const char *name UNUSED,
-				      const char *old_cwd,
+static void packed_ref_store_reparent(const char *old_cwd,
 				      const char *new_cwd,
 				      void *payload)
 {
@@ -248,7 +247,7 @@ struct ref_store *packed_ref_store_init(struct repository *repo,
 
 	strbuf_addf(&sb, "%s/packed-refs", gitdir);
 	refs->path = strbuf_detach(&sb, NULL);
-	chdir_notify_register(NULL, packed_ref_store_reparent, refs);
+	chdir_notify_register(packed_ref_store_reparent, refs);
 	return ref_store;
 }
 
@@ -293,7 +292,7 @@ static void packed_ref_store_release(struct ref_store *ref_store)
 	clear_snapshot(refs);
 	rollback_lock_file(&refs->lock);
 	delete_tempfile(&refs->tempfile);
-	chdir_notify_unregister(NULL, packed_ref_store_reparent, refs);
+	chdir_notify_unregister(packed_ref_store_reparent, refs);
 	free(refs->path);
 }
 
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 028f0211af..08a75fb328 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -391,8 +391,7 @@ static const struct reftable_be_write_options *reftable_be_write_options(struct
 	return opts;
 }
 
-static void reftable_be_reparent(const char *name UNUSED,
-				 const char *old_cwd,
+static void reftable_be_reparent(const char *old_cwd,
 				 const char *new_cwd,
 				 void *payload)
 {
@@ -465,7 +464,7 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 			goto done;
 	}
 
-	chdir_notify_register(NULL, reftable_be_reparent, refs);
+	chdir_notify_register(reftable_be_reparent, refs);
 
 done:
 	assert(refs->err != REFTABLE_API_ERROR);
@@ -492,7 +491,7 @@ static void reftable_be_release(struct ref_store *ref_store)
 		free(be);
 	}
 	strmap_clear(&refs->worktree_backends, 0);
-	chdir_notify_unregister(NULL, reftable_be_reparent, refs);
+	chdir_notify_unregister(reftable_be_reparent, refs);
 }
 
 static int reftable_be_create_on_disk(struct ref_store *ref_store,
diff --git a/setup.c b/setup.c
index 95909e9603..671f88201d 100644
--- a/setup.c
+++ b/setup.c
@@ -1057,8 +1057,7 @@ static void apply_gitdir_and_environment(struct repository *repo, const char *pa
 	strvec_clear(&to_free);
 }
 
-static void update_relative_gitdir(const char *name UNUSED,
-				   const char *old_cwd,
+static void update_relative_gitdir(const char *old_cwd,
 				   const char *new_cwd,
 				   void *data)
 {
@@ -1086,7 +1085,7 @@ static void apply_and_export_relative_gitdir(struct repository *repo, const char
 	xsetenv(GIT_DIR_ENVIRONMENT, path, 1);
 
 	if (!is_absolute_path(path))
-		chdir_notify_register(NULL, update_relative_gitdir, repo);
+		chdir_notify_register(update_relative_gitdir, repo);
 
 	strbuf_release(&realpath);
 }
diff --git a/tmp-objdir.c b/tmp-objdir.c
index d199d39e7c..520df2df8c 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -37,8 +37,7 @@ static void tmp_objdir_free(struct tmp_objdir *t)
 	free(t);
 }
 
-static void tmp_objdir_reparent(const char *name UNUSED,
-				const char *old_cwd,
+static void tmp_objdir_reparent(const char *old_cwd,
 				const char *new_cwd,
 				void *cb_data)
 {
@@ -67,7 +66,7 @@ int tmp_objdir_destroy(struct tmp_objdir *t)
 
 	err = remove_dir_recursively(&t->path, 0);
 
-	chdir_notify_unregister(NULL, tmp_objdir_reparent, t);
+	chdir_notify_unregister(tmp_objdir_reparent, t);
 	tmp_objdir_free(t);
 
 	return err;
@@ -155,7 +154,7 @@ struct tmp_objdir *tmp_objdir_create(struct repository *r,
 		    repo_get_object_directory(r), prefix);
 
 	if (!is_absolute_path(t->path.buf))
-		chdir_notify_register(NULL, tmp_objdir_reparent, t);
+		chdir_notify_register(tmp_objdir_reparent, t);
 
 	if (!mkdtemp(t->path.buf)) {
 		/* free, not destroy, as we never touched the filesystem */
-- 
2.55.0.windows.3


Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3264E53E1F
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 14:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705674434; cv=none; b=Z0BIF6OpPTkbKUVby2dwkyGAUR/wgjXnapYn5cM2RE6/gyWSckICKzQdi85oYIyNix2qx7r8UXBEF82fhOeoDEHrvIMbxNr+bzXuQhqdca8N6Er/awk4oXm8gWQDm9TFSRk9JSPEAAO4ytGK5BFoN9B25J30nAOaWiQPzU7rd5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705674434; c=relaxed/simple;
	bh=Tr+QMsllTzSTYzPcobC7Tfj3dw7qC5s+es/6REkOWpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VAvnDUHZslFuXZvx15yzj1GuVutonfaTrBLH2dfNB0+XEE8SV3L0Mfvfwgr7hbU/p69D09XYDeqi2PZ05+sOavHv661bd1JZUlgkaEZuQNPQLvhpxGfTHuAA58bZaaRKA/9+KiFcy7pf2JtNyY3GCLE7rQn8MlDu3ppbQY2c2UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYALlSP5; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYALlSP5"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a2821884a09so59882166b.2
        for <git@vger.kernel.org>; Fri, 19 Jan 2024 06:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705674431; x=1706279231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRZmxORpUKZjk2A8x6xi95lQbptlhJ3YliK6oOZmo/0=;
        b=JYALlSP5D1jUe4vnQjFlxTYbbay04vrpEEMjS7fzbb27cyY50NuT8ILf5Pob4O5Bze
         bg4ASuwLUkwEQGuPtp/OF6D9TgF+HJwt+nN9Im3I0SP+snh9TGwojBbTbI8XL18GPx89
         D4MKOyEwhC//EAh5xgYDz7JaoX9fuG6jvH0/BuJjXPpFwRdvPNVmccFnSpRVQHz2uBqF
         WocAJzo11n838yZRX0Hnxr4Detq4EWH7Og28CO6E3zz7ahIlkwFPcLTTJy9bYEBzzxf3
         +/ImE1v3dhc8bOnBx7fC0MjonhRI3Ul+y9xdMOjJc91iFUrcveJjsUSMCCUwJLcHgcpv
         dsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705674431; x=1706279231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRZmxORpUKZjk2A8x6xi95lQbptlhJ3YliK6oOZmo/0=;
        b=jrreRji/uXJc92b6KxQZY6BoRn/HKednD5/QdT9qFyU3L16d6AbH2rAp8plnDV26PN
         1KxoA+XTyZX1owYfTry1uQMM1QowrO0cR3l7rjkLRBMifu37GyDnfOC1WapvKpAzl/1k
         m1vKkvmLGStz9NozcOsdTg5LesS84VgYamdIc04Gyen2YCA+hAQs4YauKfMZogI+g0NT
         lVfwUCMCUAPOSq4ruqkidC/gJe4/pwRTbXl3Di4I9ZOnyH/fiMjGdSuFgVhue9INSvQu
         V1iiREKvAzyW3AW54LU7Znw9o8aZ0QFA0PjUwngphjqEkFRm1ZZ0RcIXvz2kiRQf2hAp
         DYCQ==
X-Gm-Message-State: AOJu0YzyW6/obiIxu1AF+U6OXKab93bCmNhMQ6ZX6yl1fZDWhCrdeSK4
	NAIJLRyg28Vx2YZQNjuynYRQWbhDq+9ifyeYq6/BLeHMbQmZhUu9cjcPqq6s
X-Google-Smtp-Source: AGHT+IGH470S5DXTec2qeBUc9UsnWaC6do0Ac9KGE4X1rWOfHWMe/2+k2VLJb0L1o7DaMjohyadvmQ==
X-Received: by 2002:a17:906:f918:b0:a2d:79b6:bbec with SMTP id lc24-20020a170906f91800b00a2d79b6bbecmr1751077ejb.40.1705674431097;
        Fri, 19 Jan 2024 06:27:11 -0800 (PST)
Received: from localhost.localdomain (h-213.61.124.196.host.de.colt.net. [213.61.124.196])
        by smtp.gmail.com with ESMTPSA id t13-20020a17090616cd00b00a2ea45637desm3843494ejd.112.2024.01.19.06.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 06:27:10 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 4/5] refs: introduce `refs_for_each_all_refs()`
Date: Fri, 19 Jan 2024 15:27:04 +0100
Message-ID: <20240119142705.139374-5-karthik.188@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119142705.139374-1-karthik.188@gmail.com>
References: <20240119142705.139374-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new ref iteration flag `DO_FOR_EACH_INCLUDE_ALL_REFS`, which
will be used to iterate over all refs. In the files backend this is
limited to regular refs, pseudorefs and HEAD. For other backends like
the reftable this is the universal set of all refs stored in the
backend.

Refs which fall outside the `refs/` and aren't either pseudorefs or HEAD
are more of a grey area. This is because we don't block the users from
creating such refs but they are not officially supported. In the files
backend, we cannot isolate such files from other files.

Introduce `refs_for_each_all_refs()` which calls `do_for_each_ref()`
with this newly introduced flag.

In `refs/files-backend.c`, introduce a new function
`add_pseudoref_like_entries()` to add pseudorefs and HEAD to the
`ref_dir`. We then finally call `add_pseudoref_like_entries()` whenever
the `DO_FOR_EACH_INCLUDE_ALL_REFS` flag is set. Any new ref backend will
also have to implement similar changes on its end.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c               |  7 +++++
 refs.h               |  6 +++++
 refs/files-backend.c | 64 ++++++++++++++++++++++++++++++++++++++++----
 refs/refs-internal.h |  7 +++++
 4 files changed, 79 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index b84e173762..e527c6199d 100644
--- a/refs.c
+++ b/refs.c
@@ -1722,6 +1722,13 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
 	return refs_for_each_rawref(get_main_ref_store(the_repository), fn, cb_data);
 }
 
+int refs_for_each_all_refs(struct ref_store *refs, each_ref_fn fn,
+			   void *cb_data)
+{
+	return do_for_each_ref(refs, "", NULL, fn, 0,
+			       DO_FOR_EACH_INCLUDE_ALL_REFS, cb_data);
+}
+
 static int qsort_strcmp(const void *va, const void *vb)
 {
 	const char *a = *(const char **)va;
diff --git a/refs.h b/refs.h
index f1bbad83fb..fef70b6599 100644
--- a/refs.h
+++ b/refs.h
@@ -393,6 +393,12 @@ int for_each_namespaced_ref(const char **exclude_patterns,
 int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data);
 int for_each_rawref(each_ref_fn fn, void *cb_data);
 
+/*
+ * Iterates over all ref types, regular, pseudorefs and HEAD.
+ */
+int refs_for_each_all_refs(struct ref_store *refs, each_ref_fn fn,
+			   void *cb_data);
+
 /*
  * Normalizes partial refs to their fully qualified form.
  * Will prepend <prefix> to the <pattern> if it doesn't start with 'refs/'.
diff --git a/refs/files-backend.c b/refs/files-backend.c
index a4884f557d..95a73b11bb 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -315,9 +315,58 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 	add_per_worktree_entries_to_dir(dir, dirname);
 }
 
-static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs)
+/*
+ * Add pseudorefs and HEAD to the ref dir by parsing the directory
+ * for any files which follow the pseudoref syntax.
+ */
+static void add_pseudoref_like_entries(struct ref_store *ref_store,
+					 struct ref_dir *dir,
+					 const char *dirname)
+{
+	struct files_ref_store *refs =
+		files_downcast(ref_store, REF_STORE_READ, "fill_ref_dir");
+	struct strbuf path = STRBUF_INIT, refname = STRBUF_INIT;
+	struct dirent *de;
+	size_t dirnamelen;
+	DIR *d;
+
+	files_ref_path(refs, &path, dirname);
+
+	d = opendir(path.buf);
+	if (!d) {
+		strbuf_release(&path);
+		return;
+	}
+
+	strbuf_addstr(&refname, dirname);
+	dirnamelen = refname.len;
+
+	while ((de = readdir(d)) != NULL) {
+		unsigned char dtype;
+
+		if (de->d_name[0] == '.')
+			continue;
+		if (ends_with(de->d_name, ".lock"))
+			continue;
+		strbuf_addstr(&refname, de->d_name);
+
+		dtype = get_dtype(de, &path, 1);
+		if (dtype == DT_REG && is_pseudoref_syntax(de->d_name))
+			loose_fill_ref_dir_regular_file(refs, refname.buf, dir);
+
+		strbuf_setlen(&refname, dirnamelen);
+	}
+	strbuf_release(&refname);
+	strbuf_release(&path);
+	closedir(d);
+}
+
+static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs,
+					     unsigned int flags)
 {
 	if (!refs->loose) {
+		struct ref_dir *dir;
+
 		/*
 		 * Mark the top-level directory complete because we
 		 * are about to read the only subdirectory that can
@@ -328,12 +377,17 @@ static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs)
 		/* We're going to fill the top level ourselves: */
 		refs->loose->root->flag &= ~REF_INCOMPLETE;
 
+		dir = get_ref_dir(refs->loose->root);
+
+		if (flags & DO_FOR_EACH_INCLUDE_ALL_REFS)
+			add_pseudoref_like_entries(dir->cache->ref_store, dir,
+						     refs->loose->root->name);
+
 		/*
 		 * Add an incomplete entry for "refs/" (to be filled
 		 * lazily):
 		 */
-		add_entry_to_dir(get_ref_dir(refs->loose->root),
-				 create_dir_entry(refs->loose, "refs/", 5));
+		add_entry_to_dir(dir, create_dir_entry(refs->loose, "refs/", 5));
 	}
 	return refs->loose;
 }
@@ -861,7 +915,7 @@ static struct ref_iterator *files_ref_iterator_begin(
 	 * disk, and re-reads it if not.
 	 */
 
-	loose_iter = cache_ref_iterator_begin(get_loose_ref_cache(refs),
+	loose_iter = cache_ref_iterator_begin(get_loose_ref_cache(refs, flags),
 					      prefix, ref_store->repo, 1);
 
 	/*
@@ -1222,7 +1276,7 @@ static int files_pack_refs(struct ref_store *ref_store,
 
 	packed_refs_lock(refs->packed_ref_store, LOCK_DIE_ON_ERROR, &err);
 
-	iter = cache_ref_iterator_begin(get_loose_ref_cache(refs), NULL,
+	iter = cache_ref_iterator_begin(get_loose_ref_cache(refs, 0), NULL,
 					the_repository, 0);
 	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
 		/*
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 4af83bf9a5..981a91c4c6 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -260,6 +260,13 @@ enum do_for_each_ref_flags {
 	 * INCLUDE_BROKEN, since they are otherwise not included at all.
 	 */
 	DO_FOR_EACH_OMIT_DANGLING_SYMREFS = (1 << 2),
+
+	/*
+	 * Include all refs in the $GIT_DIR in contrast to generally only listing
+	 * references having the "refs/" prefix. In the files-backend this is
+	 * limited to regular refs, pseudorefs and HEAD.
+	 */
+	DO_FOR_EACH_INCLUDE_ALL_REFS = (1 << 3),
 };
 
 /*
-- 
2.43.GIT


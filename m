Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22AC5CDDA
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 10:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708682482; cv=none; b=tfrJ4YYS6LaUrUZMhY5Ak01cxReIsxeRvcHmbzW8JpQH9EXz4aMlNKtZbM4fJV5CkV4/D9JxjfZCM30UfFdi+7l74i/Lm8bIEnPK3aW2okS+IZFLB0jKa5iteWRNxyFdVHQ3BMUMAR1qS5kL7aG3nxxcTEUL7iLkAbLOk2wmY1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708682482; c=relaxed/simple;
	bh=QrjSM/EHC7/0U7gN9AKeC+7N+Kw1P3wZ8JJ9RmDQbl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aoQFhxjtRmi7svWzccSr8F1o/JoCYyK43Vtf71M77qaYJqv/M12K1R+Ne9ijcK6XgVpz9Fe0WaTmeYDDBt0IHWAqo21j3btJi+0zYw41mk6bfC8D9mqeeYgzbiNX7Lq7326l8zuN93P9gb1OGWe9yFwk2vwQ3grHkCaVZrFO9yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WX+3Ns6m; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WX+3Ns6m"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so29553066b.0
        for <git@vger.kernel.org>; Fri, 23 Feb 2024 02:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708682478; x=1709287278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CpkUdAkZAVvGrHgM5DDWapCPHaKSfiO7aVfbUq4TX4I=;
        b=WX+3Ns6mOcpbWSHpbn2JqR86sXWpHW7M+v6CEHVDx/lwMhomvrh0eBo7zFQEcBEN1O
         1RTLrdznlqFNKJSkIayNN/1x9EHqDg3WptjC877Xr14qkKwV/F/LE8VyVUwyDQWVToW7
         2Cva5H2c7zFK6zE4NrvkgsRvfPdEvJACn+z/NV9hJ9kVB/x9ihrY4vurMF6No9G+zM3S
         voJjGERk7eIa70nX4v7aLkenas2ONn8i8O1LIL6HhP4UZ90r89RLTYeDXBbUQI3MS82P
         k5IFa7faihQksLexqLv6Q7qgN8JsbXY8+gIz56tSq/GSEiex/u4Vh/wGVzbOI4cw6vaN
         e/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708682478; x=1709287278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CpkUdAkZAVvGrHgM5DDWapCPHaKSfiO7aVfbUq4TX4I=;
        b=Ze0biG6I68Jhq84TJj3XP6dlmfdVYE+u46R7AJMWnp61gnK8O2QD/wTCNbnjdZPfva
         dO05UX4j8ioUer7DCtLUWFmiurkaAQpMTVakKB7lnIfa0PV4VarlG3f7gR1JStxl9C3G
         yb1GoMkqz4n+mgD72IsidrOvwXMM9+k8ySVQOgz+Y1ghwfe4bnzpyFJjRHUamdWkvpvR
         cbPHacb0VrsGb8LTfkHMzMiqmZU5utcAigmILeUREn/pr34v4XMRwPRc8pg3xGOUvp55
         7Ii8wOIkiW+YeSCKaQiVOAZaY03211X190EPAYNSlOtjtSHKBNe48UT8U345wHFlQtdH
         EowQ==
X-Gm-Message-State: AOJu0YyzDRP4C6bcUjzltMRd4EHYmHOZbcUf8iE6cpWziEl8fLMiMX7l
	cLy480E9qSEFA0BfLtw5fpuD2I1qlFGDPtnq3FAEnjROkfN8X2TJ74xqXVNLdVE=
X-Google-Smtp-Source: AGHT+IFHc85YBXiNn4D8rdtozAfwacyNkK/8Q8TRqi7+kDxtvxqzkQ5zrQigSIX0gkckphcFW/XxTg==
X-Received: by 2002:a17:906:711:b0:a3e:8f38:8d76 with SMTP id y17-20020a170906071100b00a3e8f388d76mr820403ejb.59.1708682478508;
        Fri, 23 Feb 2024 02:01:18 -0800 (PST)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:660d:e728:4b64:50ff])
        by smtp.gmail.com with ESMTPSA id ha1-20020a170906a88100b00a381ca0e589sm6734917ejb.22.2024.02.23.02.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 02:01:18 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	phillip.wood123@gmail.com,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 3/5] refs: introduce `refs_for_each_include_root_refs()`
Date: Fri, 23 Feb 2024 11:01:10 +0100
Message-ID: <20240223100112.44127-4-karthik.188@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223100112.44127-1-karthik.188@gmail.com>
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240223100112.44127-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new ref iteration flag `DO_FOR_EACH_INCLUDE_ROOT_REFS`,
which will be used to iterate over regular refs plus pseudorefs and
HEAD.

Refs which fall outside the `refs/` and aren't either pseudorefs or HEAD
are more of a grey area. This is because we don't block the users from
creating such refs but they are not officially supported.

Introduce `refs_for_each_include_root_refs()` which calls
`do_for_each_ref()` with this newly introduced flag.

In `refs/files-backend.c`, introduce a new function
`add_pseudoref_and_head_entries()` to add pseudorefs and HEAD to the
`ref_dir`. We then finally call `add_pseudoref_and_head_entries()`
whenever the `DO_FOR_EACH_INCLUDE_ROOT_REFS` flag is set. Any new ref
backend will also have to implement similar changes on its end.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c               |  7 +++++
 refs.h               |  6 ++++
 refs/files-backend.c | 65 ++++++++++++++++++++++++++++++++++++++++----
 refs/refs-internal.h |  6 ++++
 4 files changed, 79 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 3546d90831..7d58fe1e09 100644
--- a/refs.c
+++ b/refs.c
@@ -1765,6 +1765,13 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
 	return refs_for_each_rawref(get_main_ref_store(the_repository), fn, cb_data);
 }
 
+int refs_for_each_include_root_refs(struct ref_store *refs, each_ref_fn fn,
+				    void *cb_data)
+{
+	return do_for_each_ref(refs, "", NULL, fn, 0,
+			       DO_FOR_EACH_INCLUDE_ROOT_REFS, cb_data);
+}
+
 static int qsort_strcmp(const void *va, const void *vb)
 {
 	const char *a = *(const char **)va;
diff --git a/refs.h b/refs.h
index f66cdd731c..5cfaee6229 100644
--- a/refs.h
+++ b/refs.h
@@ -398,6 +398,12 @@ int for_each_namespaced_ref(const char **exclude_patterns,
 int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data);
 int for_each_rawref(each_ref_fn fn, void *cb_data);
 
+/*
+ * Iterates over all refs including root refs, i.e. pseudorefs and HEAD.
+ */
+int refs_for_each_include_root_refs(struct ref_store *refs, each_ref_fn fn,
+				    void *cb_data);
+
 /*
  * Normalizes partial refs to their fully qualified form.
  * Will prepend <prefix> to the <pattern> if it doesn't start with 'refs/'.
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 65128821a8..9c1c42fe52 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -315,9 +315,59 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 	add_per_worktree_entries_to_dir(dir, dirname);
 }
 
-static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs)
+/*
+ * Add pseudorefs to the ref dir by parsing the directory for any files
+ * which follow the pseudoref syntax.
+ */
+static void add_pseudoref_and_head_entries(struct ref_store *ref_store,
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
+		if (dtype == DT_REG && (is_pseudoref(ref_store, de->d_name) ||
+								is_headref(ref_store, de->d_name)))
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
@@ -328,12 +378,17 @@ static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs)
 		/* We're going to fill the top level ourselves: */
 		refs->loose->root->flag &= ~REF_INCOMPLETE;
 
+		dir = get_ref_dir(refs->loose->root);
+
+		if (flags & DO_FOR_EACH_INCLUDE_ROOT_REFS)
+			add_pseudoref_and_head_entries(dir->cache->ref_store, dir,
+						       refs->loose->root->name);
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
@@ -861,7 +916,7 @@ static struct ref_iterator *files_ref_iterator_begin(
 	 * disk, and re-reads it if not.
 	 */
 
-	loose_iter = cache_ref_iterator_begin(get_loose_ref_cache(refs),
+	loose_iter = cache_ref_iterator_begin(get_loose_ref_cache(refs, flags),
 					      prefix, ref_store->repo, 1);
 
 	/*
@@ -1222,7 +1277,7 @@ static int files_pack_refs(struct ref_store *ref_store,
 
 	packed_refs_lock(refs->packed_ref_store, LOCK_DIE_ON_ERROR, &err);
 
-	iter = cache_ref_iterator_begin(get_loose_ref_cache(refs), NULL,
+	iter = cache_ref_iterator_begin(get_loose_ref_cache(refs, 0), NULL,
 					the_repository, 0);
 	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
 		/*
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 83e0f0bba3..73a8fa18ad 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -260,6 +260,12 @@ enum do_for_each_ref_flags {
 	 * INCLUDE_BROKEN, since they are otherwise not included at all.
 	 */
 	DO_FOR_EACH_OMIT_DANGLING_SYMREFS = (1 << 2),
+
+	/*
+	 * Include root refs i.e. HEAD and pseudorefs along with the regular
+	 * refs.
+	 */
+	DO_FOR_EACH_INCLUDE_ROOT_REFS = (1 << 3),
 };
 
 /*
-- 
2.43.GIT


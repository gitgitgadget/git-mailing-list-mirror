Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64E57C082
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706110058; cv=none; b=D8GqOaj8Wd/Jm8L6uZEHVy5+SpESUswTCxbWhJQsL23B3a2DpV6t/fo2fpwgUfnyou5lBHfR4zsxnbIJYVFLjV03yP32YV2RgR3WJCeF+i8vap1eB0SUqmmYhCqKGKf9mtSHwekwoKhY2awl0H2ILGzDiBfOduhP4ThNg953f64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706110058; c=relaxed/simple;
	bh=kMHjm0vW4KrKL9zS5Vbb9FdcuC2jut1CePPUxv6nzy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lE/gAHZdhPBbxIg73R+PA33DmUy99B9BwtZwfuIA0nTxTFjII2QipZ8vwDZc2KfzgGRWmCbl4Aejk3vVTpZ41OULnTwqQt3H08xUwqJqToO6xVaJzC6cxDcki0yrJM5iwX/Y3fmfLDMpyn8sQXGMx2Ue2C6m+QNGiF51ryJ8Uiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+qkF1o4; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+qkF1o4"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a27733ae1dfso585020266b.3
        for <git@vger.kernel.org>; Wed, 24 Jan 2024 07:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706110055; x=1706714855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/gXFwX3SQKYntZyT+ywDtXxDQAYIr4+FKRoWw76F5A=;
        b=K+qkF1o4G0Hx5JTcUrkmPtghkA8/NVaJ14hwpqpGfFw+CR2dcOm0Bv9EKBSdZcaV8Z
         6ldI1JaicemqmEj5HqOB/TzomHFYxaw0ymGlHVVvOUD71okBc9msa4FIWu/DpRft+UMH
         6IG0yjqAFnZDN09E113ZQvISnVERDpdPrnU0IpKe3l/5/JxNUYDQvP/Huw0nAhGj9l9e
         LULMIpRIo3tDC+5ZTxoX41DFqdNdR3cpgpYazZrw7OTS3W4CYMJ6JbcWDIvh3MeJhJ/j
         aVvt+pA2+zBoYDdEcu2/Oqy5f2GMEdCm4h+JruxyyQaB14MFPZxvBcgWcAXTtPdWPxLZ
         ZYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706110055; x=1706714855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/gXFwX3SQKYntZyT+ywDtXxDQAYIr4+FKRoWw76F5A=;
        b=l/Cny7eZIi5RteyJa4jT5v1rKo+kUX49+Qk7kzBFXUywDYhVoln/QtP31LDUmjNNwJ
         vIwIB+xsmigKuD8/2ND4JI/jNUaKBg7x6wF+VPOHPljUmAilwwZk84JEQTk8Q/zUDbMk
         uU7me8wVNQRn///kVElvRaf0Il+G5nBTDlsEt5qaVltd0/EUcRvDO+/r3YZvLER+UVEg
         Ym9J/pGPrPvCQaXXgaUlzTAIXCwNG7AVOqI57vEYk3X3oZ28Hyh/CRQ1UjxKC1Ndj3A2
         EatUAZdnp+kheAbBsuxRb8/4MCzr3FQz9NMBfn058GEB7cPsJdEBRvqG2dbUJxgrUs6x
         q1SA==
X-Gm-Message-State: AOJu0YxOCzTo7cTKHn3QS5OaGxwloryuhkgmcuFyQmPfxc32Kf5Xn0nN
	N0Mmx495m4v0sjAoR3OXkz17L0qSQkhsTSJmLnMr7HuaHcewtl9DAfQgZXvL
X-Google-Smtp-Source: AGHT+IFMZp8VZ/gnarkYSY5Yw/vGa5WBIVTe7k+w03GSU7z9QVU6+FANPlw5qBdMITJj7CclGVTiJg==
X-Received: by 2002:a17:906:8920:b0:a30:deb6:1bb7 with SMTP id fr32-20020a170906892000b00a30deb61bb7mr473558ejc.132.1706110054276;
        Wed, 24 Jan 2024 07:27:34 -0800 (PST)
Received: from localhost.localdomain (h-213.61.124.196.host.de.colt.net. [213.61.124.196])
        by smtp.gmail.com with ESMTPSA id vh12-20020a170907d38c00b00a2eb648cdc5sm8765225ejc.156.2024.01.24.07.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 07:27:33 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	phillip.wood123@gmail.com,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 3/4] refs: introduce `refs_for_each_all_refs()`
Date: Wed, 24 Jan 2024 16:27:25 +0100
Message-ID: <20240124152726.124873-4-karthik.188@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124152726.124873-1-karthik.188@gmail.com>
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240124152726.124873-1-karthik.188@gmail.com>
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
backend, we can isolate such files from other files.

Introduce `refs_for_each_all_refs()` which calls `do_for_each_ref()`
with this newly introduced flag.

In `refs/files-backend.c`, introduce a new function
`add_pseudoref_and_head_entries()` to add pseudorefs and HEAD to the
`ref_dir`. We then finally call `add_pseudoref_and_head_entries()`
whenever the `DO_FOR_EACH_INCLUDE_ALL_REFS` flag is set. Any new ref
backend will also have to implement similar changes on its end.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c               |  7 +++++
 refs.h               |  6 ++++
 refs/files-backend.c | 65 ++++++++++++++++++++++++++++++++++++++++----
 refs/refs-internal.h |  7 +++++
 4 files changed, 80 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 4b6bfc66fb..b5e63f133a 100644
--- a/refs.c
+++ b/refs.c
@@ -1755,6 +1755,13 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
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
index 46b8085d63..77ecb820f9 100644
--- a/refs.h
+++ b/refs.h
@@ -396,6 +396,12 @@ int for_each_namespaced_ref(const char **exclude_patterns,
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
index 22495a4807..104f2e1ac7 100644
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
+		if (flags & DO_FOR_EACH_INCLUDE_ALL_REFS)
+			add_pseudoref_and_head_entries(dir->cache->ref_store, dir,
+										   refs->loose->root->name);
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
index 8e9f04cc67..1cf7506435 100644
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


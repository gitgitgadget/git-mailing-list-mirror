Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A68145FE0
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 09:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771493915; cv=none; b=SjCF0gs3orIvTQeQJ0EIxAmjARsyl8oZsdQ3XHTnBdxHVZVwkt8w9dYieiX/VTBY8vwWxzaNQ8TnUVeiXhJjLZFyw4b8+IsjjFWWeX2IZmMyXREx6f5rv8ZjQe1IbkynVPcwCtOZ7wEcKHLvj4D55XtRcpfEuKpaq6MlJ2DLgvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771493915; c=relaxed/simple;
	bh=M67zPheR8dZaOjXh6PEsZXlRzFnzSId82pC4l3EanS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qz07lFFcJT5cD4cetf2YyMseFMVwqOStcy31OeB/xI/9EWWTqXjDdfigRc991LRjOJjQ5/D98X02fakC7iCHEElDKVJMvQTluDkinJiY1HdgJ8cNfPekUi/pkihc96uwYYuUPqZYMS8bVM8Oq/4a9/f4vWSf8zjjZ6JH5/ZCI18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jy80XG2b; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jy80XG2b"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4837584120eso5075195e9.1
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 01:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771493912; x=1772098712; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ca362tnvTX1ESNdTIaYqP8sI665WpHUnl/F0hvi0Ffk=;
        b=jy80XG2bgD57wRoHlnWjagoMSz3ecvuxhTuyZ+cb+PtDQqdDKC9J1Dh7iTSkz9jnp8
         vq4b88DzXOHYowIq5JGGUuCD/M0QWezOxliBGL6rzkwAUEuRXt+cmSOCRPRZa1iFAkNJ
         65L5U07u2Ol0rNm/Ckdqr2O9mJnaPvHwRvhiLfyDG6n3mvSyFFkMF1B6H0DCn/KMhpUB
         0zjWVVFl1biWzIz92CDhax1KSSbA3iO/m/CgKF7qfF7nF14c3B+Ob/Qif5EL1JuBoUAy
         yOEkSCjZOtJh6BgVNFWg0lM4/sDSyy51bWo8SAxfIAtJPFTuG+CX5DS9NfdshbPanu05
         cTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771493912; x=1772098712;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ca362tnvTX1ESNdTIaYqP8sI665WpHUnl/F0hvi0Ffk=;
        b=j4Ydh2GZnyxZWA0qLFH6lXP8MBHP4lIlUFTeTLtsSneW6lhym+G2GiAKTnXGvYT+Ao
         seI2aLvI4uzcPiPCZiFwcuj82LDJaSEHL096Z3VTOlmYiaDLUNYKz9BceHcWXJBrq2KP
         xtE7k63RK/cXtVid8cSrtIWBOyUNVG3hDLK+jnS0Vwky8EXW0yOqKhwyec5I0F12NXnK
         PFgoGNau0jo9dWtRyh24FP+0Tp+dpOhO7AIjC+CdGXmSWX8RB8GOub+M5KqAQHdJbnmJ
         AWHmQUAlKCbTI7M0MdGmWh+K2juOBfzuiWT5Ffr6kpKeNcKxHOLrOLxAPwVMgoLeLEUS
         jeLg==
X-Gm-Message-State: AOJu0YzYzZPyDUIfgSrdZ/CXfW7FCjblDTd4AUOBCGn46SuvTXWuMANB
	J758Ar580/d30xp8J6rdY5lJkB9ev5t4q3eGHvpyywxE4hIP7wZOuqek
X-Gm-Gg: AZuq6aIyWn66twegWUm66KuEaKXmgfI4KDzwtVo0bgsi92ojLe3WNl7tBy+FmhMyX+W
	Ih5d3G14ANvViH7xPaoNqURMKmvGll6wk5g8i6rIZGFIreFU1I0RvrxzE5WpFmW7wqstb6zrxAX
	CYX95JtwXdU33DxpBEWcwQg5j8pydMlijORyaMAeOnnYkXHoq/WWTaFL3zYueYE86Zukq+MlShs
	/CZ7YDOD+J/t7aPKAkCLu07L3jTfvPamu33asrDjIStFo8HE78kmV113WKMo2eFhoAxICzoM3mh
	eJSrrJvgDI2ukPk+MVBqNPjllcwhIvFyNzP4ZO+gW6k3EwIPdDAhQjj0SewpVTDI7Fj5ZelJQGy
	Guza99lo9oMOTxLhOzQy4kpDdwjt9ztvsjT2duen2lNxSeYtfaKXE4+adKw6Ic06OYNFY+jQIaf
	SGTo1oHC03TM3XrRBa4EPIQ2sWBxz7cjHRrW81Nu+E
X-Received: by 2002:a05:600c:1c08:b0:47a:8cce:2940 with SMTP id 5b1f17b1804b1-48379b991c6mr295236245e9.14.1771493911703;
        Thu, 19 Feb 2026 01:38:31 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1ea7:2b8f:9148:411a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5ebd34sm694274985e9.7.2026.02.19.01.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 01:38:31 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 19 Feb 2026 10:38:23 +0100
Subject: [PATCH v7 4/6] refs: receive and use the reference storage payload
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260219-kn-alternate-ref-dir-v7-4-16f27860dbdf@gmail.com>
References: <20260219-kn-alternate-ref-dir-v7-0-16f27860dbdf@gmail.com>
In-Reply-To: <20260219-kn-alternate-ref-dir-v7-0-16f27860dbdf@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im, 
 toon@iotcl.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9636; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=M67zPheR8dZaOjXh6PEsZXlRzFnzSId82pC4l3EanS4=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGmW2hILwwlaVlPSn048TOVp9mnqaGfAaCSWk
 wAgUjdwDK068okBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpltoSAAoJED7VnySO
 Rox/uJYL/i3N4rQ/6o398WbTcW7J0x4o1cfxmLqCi+v72Btwi5mOXwcP2DlsxbgIJLyLxPnm764
 zhsMtuonpXxOnPslF55Onq4fGW/Dc5RtMrpBo0eXXFPS5nsrC10pOUhlJMw3NvskZtlL1GRv1YE
 hAGNb28EV3GVcT9OOqY8+Ui88nZcMPb+DDihat7EJmkc0dQeW9IMmMlSq/4ofa2CL4bZDnGLH4X
 IKXCgUmGan6a5lg/1F9n7qxdECRbntj4uYo7oh6Mj6sXWVkH1GQczkAEYRejS4RxEjaBPKRWNR6
 2MKCXIvFsUlrKbazcpNoTx70D+UFJ88Jv6+cRsv+Q6wxlYgK76bKfLmCwZLvKMzqzEhQYm7Z1AM
 x9GqCUOKQih5KGRzIU2HEyBnd/6WT5O8hY+7tmQ+9kpdrR7ZnoEKtvAahAi53WkzIbM1dE0DoHJ
 ZBUGbcLUXjVgH7kiYaJw3pAM0xdFBdLeshMrcUt7ovoww7eQlcd+31WfDi+WZA0QdcLU/PR+zD7
 ak=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

An upcoming commit will add support for providing an URI via the
'extensions.refStorage' config. The URI will contain the reference
backend and a corresponding payload. The payload can be then used for
providing an alternate locations for the reference backend.

To prepare for this, modify the existing backends to accept such an
argument when initializing via the 'init()' function. Both the files
and reftable backends will parse the information to be filesystem paths
to store references. Given that no callers pass any payload yet this is
essentially a no-op change for now.

To enable this, provide a 'refs_compute_filesystem_location()' function
which will parse the current 'gitdir' and the 'payload' to provide the
final reference directory and common reference directory (if working in
a linked worktree).

The documentation and tests will be added alongside the extension of the
config variable.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  | 40 +++++++++++++++++++++++++++++++++++++++-
 refs/files-backend.c    | 17 ++++++++++++-----
 refs/packed-backend.c   |  5 +++++
 refs/packed-backend.h   |  1 +
 refs/refs-internal.h    | 14 ++++++++++++++
 refs/reftable-backend.c | 24 ++++++++++++++----------
 6 files changed, 85 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index c83af63dc5..ba2573eb7a 100644
--- a/refs.c
+++ b/refs.c
@@ -5,6 +5,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
+#include "abspath.h"
 #include "advice.h"
 #include "config.h"
 #include "environment.h"
@@ -2290,7 +2291,7 @@ static struct ref_store *ref_store_init(struct repository *repo,
 	if (!be)
 		BUG("reference backend is unknown");
 
-	refs = be->init(repo, gitdir, flags);
+	refs = be->init(repo, NULL, gitdir, flags);
 	return refs;
 }
 
@@ -3468,3 +3469,40 @@ const char *ref_transaction_error_msg(enum ref_transaction_error err)
 		return "unknown failure";
 	}
 }
+
+void refs_compute_filesystem_location(const char *gitdir, const char *payload,
+				      bool *is_worktree, struct strbuf *refdir,
+				      struct strbuf *ref_common_dir)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	*is_worktree = get_common_dir_noenv(ref_common_dir, gitdir);
+
+	if (!payload) {
+		/*
+		 * We can use the 'gitdir' as the 'refdir' without appending the
+		 * worktree path, as the 'gitdir' here is already the worktree
+		 * path and is different from 'commondir' denoted by 'ref_common_dir'.
+		 */
+		strbuf_addstr(refdir, gitdir);
+		return;
+	}
+
+	if (!is_absolute_path(payload)) {
+		strbuf_addf(&sb, "%s/%s", ref_common_dir->buf, payload);
+		strbuf_realpath(ref_common_dir, sb.buf, 1);
+	} else {
+		strbuf_realpath(ref_common_dir, payload, 1);
+	}
+
+	strbuf_addbuf(refdir, ref_common_dir);
+
+	if (*is_worktree) {
+		const char *wt_id = strrchr(gitdir, '/');
+		if (!wt_id)
+			BUG("worktree path does not contain slash");
+		strbuf_addf(refdir, "/worktrees/%s", wt_id + 1);
+	}
+
+	strbuf_release(&sb);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index d3f6423261..9cde3ba724 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -106,19 +106,24 @@ static void clear_loose_ref_cache(struct files_ref_store *refs)
  * set of caches.
  */
 static struct ref_store *files_ref_store_init(struct repository *repo,
+					      const char *payload,
 					      const char *gitdir,
 					      unsigned int flags)
 {
 	struct files_ref_store *refs = xcalloc(1, sizeof(*refs));
 	struct ref_store *ref_store = (struct ref_store *)refs;
-	struct strbuf sb = STRBUF_INIT;
+	struct strbuf ref_common_dir = STRBUF_INIT;
+	struct strbuf refdir = STRBUF_INIT;
+	bool is_worktree;
+
+	refs_compute_filesystem_location(gitdir, payload, &is_worktree, &refdir,
+					 &ref_common_dir);
 
-	base_ref_store_init(ref_store, repo, gitdir, &refs_be_files);
+	base_ref_store_init(ref_store, repo, refdir.buf, &refs_be_files);
 	refs->store_flags = flags;
-	get_common_dir_noenv(&sb, gitdir);
-	refs->gitcommondir = strbuf_detach(&sb, NULL);
+	refs->gitcommondir = strbuf_detach(&ref_common_dir, NULL);
 	refs->packed_ref_store =
-		packed_ref_store_init(repo, refs->gitcommondir, flags);
+		packed_ref_store_init(repo, NULL, refs->gitcommondir, flags);
 	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
 	repo_config_get_bool(repo, "core.prefersymlinkrefs", &refs->prefer_symlink_refs);
 
@@ -126,6 +131,8 @@ static struct ref_store *files_ref_store_init(struct repository *repo,
 	chdir_notify_reparent("files-backend $GIT_COMMONDIR",
 			      &refs->gitcommondir);
 
+	strbuf_release(&refdir);
+
 	return ref_store;
 }
 
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 4ea0c12299..e7bb9f10f9 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -211,7 +211,12 @@ static size_t snapshot_hexsz(const struct snapshot *snapshot)
 	return snapshot->refs->base.repo->hash_algo->hexsz;
 }
 
+/*
+ * Since packed-refs is only stored in the common dir, don't parse the
+ * payload and rely on the files-backend to set 'gitdir' correctly.
+ */
 struct ref_store *packed_ref_store_init(struct repository *repo,
+					const char *payload UNUSED,
 					const char *gitdir,
 					unsigned int store_flags)
 {
diff --git a/refs/packed-backend.h b/refs/packed-backend.h
index 9481d5e7c2..2c2377a356 100644
--- a/refs/packed-backend.h
+++ b/refs/packed-backend.h
@@ -14,6 +14,7 @@ struct ref_transaction;
  */
 
 struct ref_store *packed_ref_store_init(struct repository *repo,
+					const char *payload,
 					const char *gitdir,
 					unsigned int store_flags);
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index c7d2a6e50b..9a635f4e6c 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -389,6 +389,7 @@ struct ref_store;
  * the ref_store and to record the ref_store for later lookup.
  */
 typedef struct ref_store *ref_store_init_fn(struct repository *repo,
+					    const char *payload,
 					    const char *gitdir,
 					    unsigned int flags);
 /*
@@ -666,4 +667,17 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
 					  unsigned int initial_transaction,
 					  struct strbuf *err);
 
+/*
+ * Given a gitdir and the reference storage payload provided, retrieve the
+ * 'refdir' and 'ref_common_dir'. The former is where references should be
+ * stored for the current worktree, the latter is the common reference
+ * directory if working with a linked worktree. If working with the main
+ * worktree, both values will be the same.
+ *
+ * This is used by backends that store store files in the repository directly.
+ */
+void refs_compute_filesystem_location(const char *gitdir, const char *payload,
+				      bool *is_worktree, struct strbuf *refdir,
+				      struct strbuf *ref_common_dir);
+
 #endif /* REFS_REFS_INTERNAL_H */
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 6ce7f9bb8e..0e220d6bb5 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -372,18 +372,24 @@ static int reftable_be_fsync(int fd)
 }
 
 static struct ref_store *reftable_be_init(struct repository *repo,
+					  const char *payload,
 					  const char *gitdir,
 					  unsigned int store_flags)
 {
 	struct reftable_ref_store *refs = xcalloc(1, sizeof(*refs));
+	struct strbuf ref_common_dir = STRBUF_INIT;
+	struct strbuf refdir = STRBUF_INIT;
 	struct strbuf path = STRBUF_INIT;
-	int is_worktree;
+	bool is_worktree;
 	mode_t mask;
 
 	mask = umask(0);
 	umask(mask);
 
-	base_ref_store_init(&refs->base, repo, gitdir, &refs_be_reftable);
+	refs_compute_filesystem_location(gitdir, payload, &is_worktree, &refdir,
+					 &ref_common_dir);
+
+	base_ref_store_init(&refs->base, repo, refdir.buf, &refs_be_reftable);
 	strmap_init(&refs->worktree_backends);
 	refs->store_flags = store_flags;
 	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
@@ -419,14 +425,11 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 	/*
 	 * Set up the main reftable stack that is hosted in GIT_COMMON_DIR.
 	 * This stack contains both the shared and the main worktree refs.
-	 *
-	 * Note that we don't try to resolve the path in case we have a
-	 * worktree because `get_common_dir_noenv()` already does it for us.
 	 */
-	is_worktree = get_common_dir_noenv(&path, gitdir);
+	strbuf_addbuf(&path, &ref_common_dir);
 	if (!is_worktree) {
 		strbuf_reset(&path);
-		strbuf_realpath(&path, gitdir, 0);
+		strbuf_realpath(&path, ref_common_dir.buf, 0);
 	}
 	strbuf_addstr(&path, "/reftable");
 	refs->err = reftable_backend_init(&refs->main_backend, path.buf,
@@ -443,10 +446,9 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 	 * do it efficiently.
 	 */
 	if (is_worktree) {
-		strbuf_reset(&path);
-		strbuf_addf(&path, "%s/reftable", gitdir);
+		strbuf_addstr(&refdir, "/reftable");
 
-		refs->err = reftable_backend_init(&refs->worktree_backend, path.buf,
+		refs->err = reftable_backend_init(&refs->worktree_backend, refdir.buf,
 						  &refs->write_options);
 		if (refs->err)
 			goto done;
@@ -456,6 +458,8 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 
 done:
 	assert(refs->err != REFTABLE_API_ERROR);
+	strbuf_release(&ref_common_dir);
+	strbuf_release(&refdir);
 	strbuf_release(&path);
 	return &refs->base;
 }

-- 
2.53.GIT


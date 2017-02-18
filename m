Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A125201B0
	for <e@80x24.org>; Sat, 18 Feb 2017 13:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753410AbdBRNe6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 08:34:58 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34279 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753231AbdBRNe5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 08:34:57 -0500
Received: by mail-pg0-f68.google.com with SMTP id v184so7383874pgv.1
        for <git@vger.kernel.org>; Sat, 18 Feb 2017 05:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9HS4gfbnbQm/IcJpBK9JsctKyYJfG7g1z3X87wi+qD8=;
        b=uDhsjYAQ77jm0y+nErhxyiXFTEXWLTusZ6c+etgnPQtZG/Z+CwVxQAdFSq6p7kscX+
         qs+54ok123CMy/DsuZ37UxpnzXE8ceko0VrBuO3pVmDfLhr0AxIodU1huNNjlzyPW6mC
         cpoGz4j8EL4iGZpn6Olz7Mukv27fYGrqO2wFXYxykoAjuwQTN+TMuLnHNwOaoto/hMXc
         iuP9mxm7jkZwGfGTgVTBI6xbzDgdM+dq4A/S5D5Z0PJ+/Cu6mIwBk58ueWTOaR/9jvuQ
         yknlHrIQG6naFVKc0usOp1YEisdMneE6KGju4bY9n5JEwOCHzfeLeN1gU0rfH/NMcZHQ
         ZW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9HS4gfbnbQm/IcJpBK9JsctKyYJfG7g1z3X87wi+qD8=;
        b=jl2Fip06UzACDlIemL5SGWPjto04zkR3khq5xKocWDfL9cj7iF9iaVsTZi4GtD9F3H
         4qv0HigflXh3Bk0XCbbtVbja4tJH7VKgZE0tkMYl0oz0eQLRIiO4CDY2tZ8iYuCgYOAG
         ODmJPtFrSLL7aUGv/c6CkIwyOMemF5HuvYRNxnbkOiN/TnFJzivrsr3dVxZYU4XlcOnA
         L7WI42IDjdv5F2uw2UEZ59LwtSywbYhUbmSObQa+rYdBtiyTSfJ7lk291EjMuqnFqehk
         +LCOj14IYdXbebDEk8BEQx5UBzRhcNIhsK7T9KMgb5iKVAwhxz5SpCsRObmuN6Grk9p9
         LruQ==
X-Gm-Message-State: AMke39ne8NU2N7iyO0D3GYNHYHE3EhoJGSASkSiDtPVOUeeJ79xCgqTMyz83iS3GHkr97g==
X-Received: by 10.84.231.201 with SMTP id g9mr18432532pln.13.1487424896569;
        Sat, 18 Feb 2017 05:34:56 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id e13sm25625682pgf.48.2017.02.18.05.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Feb 2017 05:34:55 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Feb 2017 20:34:49 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 13/15] refs: move submodule code out of files-backend.c
Date:   Sat, 18 Feb 2017 20:33:01 +0700
Message-Id: <20170218133303.3682-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170218133303.3682-1-pclouds@gmail.com>
References: <20170217140436.17336-1-pclouds@gmail.com>
 <20170218133303.3682-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

files-backend is now initialized with a $GIT_DIR. Converting a submodule
path to where real submodule gitdir is located is done in get_ref_store().

The new code in init_submodule_ref_store() is basically a copy of
strbuf_git_path_submodule().

This gives a slight performance improvement for submodules since we
don't convert submodule path to gitdir at every backend call like
before. We pay that once at ref-store creation.

More cleanup in files_downcast() follows shortly. It's separate to keep
noises from this patch.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c               | 18 +++++++++++++-----
 refs/files-backend.c | 24 +++++++-----------------
 refs/refs-internal.h |  6 +++---
 3 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/refs.c b/refs.c
index 1b60e6180..8035c3ea7 100644
--- a/refs.c
+++ b/refs.c
@@ -9,6 +9,7 @@
 #include "refs/refs-internal.h"
 #include "object.h"
 #include "tag.h"
+#include "submodule.h"
 
 /*
  * List of all available backends
@@ -1424,9 +1425,9 @@ static void register_submodule_ref_store(struct ref_store *refs,
 
 /*
  * Create, record, and return a ref_store instance for the specified
- * submodule (or the main repository if submodule is NULL).
+ * gitdir (or the main repository if gitdir is NULL).
  */
-static struct ref_store *ref_store_init(const char *submodule)
+static struct ref_store *ref_store_init(const char *gitdir)
 {
 	const char *be_name = "files";
 	struct ref_storage_be *be = find_ref_storage_backend(be_name);
@@ -1435,7 +1436,7 @@ static struct ref_store *ref_store_init(const char *submodule)
 	if (!be)
 		die("BUG: reference backend %s is unknown", be_name);
 
-	refs = be->init(submodule);
+	refs = be->init(gitdir);
 	return refs;
 }
 
@@ -1460,6 +1461,7 @@ struct ref_store *get_ref_store(const char *submodule)
 {
 	struct strbuf submodule_sb = STRBUF_INIT;
 	struct ref_store *refs;
+	int ret;
 
 	if (!submodule || !*submodule) {
 		return get_main_ref_store();
@@ -1470,8 +1472,14 @@ struct ref_store *get_ref_store(const char *submodule)
 		return refs;
 
 	strbuf_addstr(&submodule_sb, submodule);
-	if (is_nonbare_repository_dir(&submodule_sb))
-		refs = ref_store_init(submodule);
+	ret = is_nonbare_repository_dir(&submodule_sb);
+	strbuf_release(&submodule_sb);
+	if (!ret)
+		return refs;
+
+	ret = submodule_to_gitdir(&submodule_sb, submodule);
+	if (!ret)
+		refs = ref_store_init(submodule_sb.buf);
 	strbuf_release(&submodule_sb);
 
 	if (refs)
diff --git a/refs/files-backend.c b/refs/files-backend.c
index dbcaf9bda..529c80af1 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -917,13 +917,6 @@ struct packed_ref_cache {
 struct files_ref_store {
 	struct ref_store base;
 
-	/*
-	 * The name of the submodule represented by this object, or
-	 * NULL if it represents the main repository's reference
-	 * store:
-	 */
-	const char *submodule;
-
 	struct strbuf gitdir;
 	struct strbuf gitcommondir;
 
@@ -945,11 +938,8 @@ static void files_path(struct files_ref_store *refs, struct strbuf *sb,
 	va_start(vap, fmt);
 	strbuf_vaddf(&tmp, fmt, vap);
 	va_end(vap);
-	if (refs->submodule) {
-		strbuf_git_path_submodule(sb, refs->submodule,
-					  "%s", tmp.buf);
-	} else if (!strcmp(tmp.buf, "packed-refs") ||
-		   !strcmp(tmp.buf, "logs")) { /* non refname path */
+	if (!strcmp(tmp.buf, "packed-refs") || !strcmp(tmp.buf, "logs")) {
+		/* non refname path */
 		strbuf_addf(sb, "%s/%s", refs->gitcommondir.buf, tmp.buf);
 	} else if (skip_prefix(tmp.buf, "logs/", &ref)) { /* reflog */
 		if (is_per_worktree_ref(ref))
@@ -1018,7 +1008,7 @@ static void clear_loose_ref_cache(struct files_ref_store *refs)
  * Create a new submodule ref cache and add it to the internal
  * set of caches.
  */
-static struct ref_store *files_ref_store_create(const char *submodule)
+static struct ref_store *files_ref_store_create(const char *gitdir)
 {
 	struct files_ref_store *refs = xcalloc(1, sizeof(*refs));
 	struct ref_store *ref_store = (struct ref_store *)refs;
@@ -1028,8 +1018,9 @@ static struct ref_store *files_ref_store_create(const char *submodule)
 	strbuf_init(&refs->gitdir, 0);
 	strbuf_init(&refs->gitcommondir, 0);
 
-	if (submodule) {
-		refs->submodule = xstrdup(submodule);
+	if (gitdir) {
+		strbuf_addstr(&refs->gitdir, gitdir);
+		get_common_dir_noenv(&refs->gitcommondir, gitdir);
 	} else {
 		strbuf_addstr(&refs->gitdir, get_git_dir());
 		strbuf_addstr(&refs->gitcommondir, get_git_common_dir());
@@ -1045,8 +1036,7 @@ static struct ref_store *files_ref_store_create(const char *submodule)
 static void files_assert_main_repository(struct files_ref_store *refs,
 					 const char *caller)
 {
-	if (refs->submodule)
-		die("BUG: %s called for a submodule", caller);
+	/* This function is to be deleted in the next patch */
 }
 
 /*
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 8c5febf54..3ef020acf 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -482,12 +482,12 @@ struct ref_store;
 /* refs backends */
 
 /*
- * Initialize the ref_store for the specified submodule, or for the
- * main repository if submodule == NULL. These functions should call
+ * Initialize the ref_store for the specified gitdir, or for the
+ * current repository if gitdir == NULL. These functions should call
  * base_ref_store_init() to initialize the shared part of the
  * ref_store and to record the ref_store for later lookup.
  */
-typedef struct ref_store *ref_store_init_fn(const char *submodule);
+typedef struct ref_store *ref_store_init_fn(const char *gitdir);
 
 typedef int ref_init_db_fn(struct ref_store *refs, struct strbuf *err);
 
-- 
2.11.0.157.gd943d85


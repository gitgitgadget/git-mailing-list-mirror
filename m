Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 246ED201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 14:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932729AbdBVOHn (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 09:07:43 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35619 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932728AbdBVOHk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 09:07:40 -0500
Received: by mail-pg0-f68.google.com with SMTP id 1so545516pgz.2
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 06:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lYg7uFB5KTeOpmfAuVJBPI3GKxh3KvDMwRGo12otrXI=;
        b=KIDKhAePq5CDJgmFhaepHE1AfASIQoYsv+QFcyzojklFXhAUMaF27FFloI3r8zHoNA
         HtcvGTYDb5IOKZNltmAwXc1lEphimfgB+VeB+UkvVu/6OJVMauXHeY/4t4w6rSBjBJgz
         cqDt7vRtOnQQdzPLNaLBtXtYNAoRipDviFb5YTHsj/apcg31fjIWU3GZa06h1PK9BrJv
         XNVihzs/Jl3LmXl1iH/erv7g8EyIQVn+pip09lkuFYOwSawMmQ3TAsFz9qnc6AKEQhzM
         MQx4BwcJpSEZb0pVAQZZv2j4ehr3bCpWcutynBo7MrNUYWvl+7lKoi9XiutPtPJnowRS
         xicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lYg7uFB5KTeOpmfAuVJBPI3GKxh3KvDMwRGo12otrXI=;
        b=qb9/YitJea0tSoR2B9CeWH0uuV4qQbjzNC4jlRoGIqItoSClRbMJxr2BIgQmZoP2f8
         XY3eVF0zKPX3Cfh05rxZ3ujduCA1W6YL7FMqtZ52jWp5+N6qGLn2uHh8z1yXM94DODvp
         gawRlQaE/MG/qfr7vFkTlDwHkkYHRdgETch1X7JfVHUUqcmYcWpGUxyuJyeUqdOfBjei
         dDSMpEzuh3M6ziobZukYiV82Mj/Q62eU3RzoYpQga7hxTV4aX/krr+KLVRjRLmZsKnFE
         JXQQECaK7QgQAy+dWHBaCM1fUnOo/kHNfdK9b4LbBR+/3bcsEHncJBE+vlrL5aYQDnne
         ZhVw==
X-Gm-Message-State: AMke39l63PoEmfonxLlA9tu5vG0rEc0RuYMMqlqVXYz2LNLhng58sMwAcdYzAvDdW9pS7g==
X-Received: by 10.98.7.21 with SMTP id b21mr8219608pfd.66.1487772449544;
        Wed, 22 Feb 2017 06:07:29 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id w18sm4041802pfa.127.2017.02.22.06.07.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Feb 2017 06:07:28 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 22 Feb 2017 21:07:17 +0700
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
Subject: [PATCH v5 15/24] refs: move submodule code out of files-backend.c
Date:   Wed, 22 Feb 2017 21:04:41 +0700
Message-Id: <20170222140450.30886-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170222140450.30886-1-pclouds@gmail.com>
References: <20170218133303.3682-1-pclouds@gmail.com>
 <20170222140450.30886-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

files-backend is now initialized with a $GIT_DIR. Converting a submodule
path to where real submodule gitdir is located is done in get_ref_store().

This gives a slight performance improvement for submodules since we
don't convert submodule path to gitdir at every backend call like
before. We pay that once at ref-store creation.

More cleanup in files_downcast() and files_assert_main_repository()
follows shortly. It's separate to keep noises from this patch.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c               | 20 ++++++++++++++------
 refs/files-backend.c | 24 ++----------------------
 refs/refs-internal.h |  9 ++++-----
 3 files changed, 20 insertions(+), 33 deletions(-)

diff --git a/refs.c b/refs.c
index 562834fc0..67acae60c 100644
--- a/refs.c
+++ b/refs.c
@@ -9,6 +9,7 @@
 #include "refs/refs-internal.h"
 #include "object.h"
 #include "tag.h"
+#include "submodule.h"
 
 /*
  * List of all available backends
@@ -1413,9 +1414,9 @@ static struct ref_store *lookup_submodule_ref_store(const char *submodule)
 
 /*
  * Create, record, and return a ref_store instance for the specified
- * submodule (or the main repository if submodule is NULL).
+ * gitdir.
  */
-static struct ref_store *ref_store_init(const char *submodule)
+static struct ref_store *ref_store_init(const char *gitdir)
 {
 	const char *be_name = "files";
 	struct ref_storage_be *be = find_ref_storage_backend(be_name);
@@ -1424,7 +1425,7 @@ static struct ref_store *ref_store_init(const char *submodule)
 	if (!be)
 		die("BUG: reference backend %s is unknown", be_name);
 
-	refs = be->init(submodule);
+	refs = be->init(gitdir);
 	return refs;
 }
 
@@ -1435,7 +1436,7 @@ struct ref_store *get_main_ref_store(void)
 	if (main_ref_store)
 		return main_ref_store;
 
-	refs = ref_store_init(NULL);
+	refs = ref_store_init(get_git_dir());
 	if (refs) {
 		if (main_ref_store)
 			die("BUG: main_ref_store initialized twice");
@@ -1466,6 +1467,7 @@ struct ref_store *get_ref_store(const char *submodule)
 {
 	struct strbuf submodule_sb = STRBUF_INIT;
 	struct ref_store *refs;
+	int ret;
 
 	if (!submodule || !*submodule) {
 		return get_main_ref_store();
@@ -1476,8 +1478,14 @@ struct ref_store *get_ref_store(const char *submodule)
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
index d80c27837..37443369b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -917,12 +917,6 @@ struct packed_ref_cache {
 struct files_ref_store {
 	struct ref_store base;
 
-	/*
-	 * The name of the submodule represented by this object, or
-	 * NULL if it represents the main repository's reference
-	 * store:
-	 */
-	const char *submodule;
 	char *gitdir;
 	char *gitcommondir;
 	char *packed_refs_path;
@@ -982,22 +976,14 @@ static void clear_loose_ref_cache(struct files_ref_store *refs)
  * Create a new submodule ref cache and add it to the internal
  * set of caches.
  */
-static struct ref_store *files_ref_store_create(const char *submodule)
+static struct ref_store *files_ref_store_create(const char *gitdir)
 {
 	struct files_ref_store *refs = xcalloc(1, sizeof(*refs));
 	struct ref_store *ref_store = (struct ref_store *)refs;
 	struct strbuf sb = STRBUF_INIT;
-	const char *gitdir = get_git_dir();
 
 	base_ref_store_init(ref_store, &refs_be_files);
 
-	if (submodule) {
-		refs->submodule = xstrdup(submodule);
-		refs->packed_refs_path = git_pathdup_submodule(
-			refs->submodule, "packed-refs");
-		return ref_store;
-	}
-
 	refs->gitdir = xstrdup(gitdir);
 	get_common_dir_noenv(&sb, gitdir);
 	refs->gitcommondir = strbuf_detach(&sb, NULL);
@@ -1014,8 +1000,7 @@ static struct ref_store *files_ref_store_create(const char *submodule)
 static void files_assert_main_repository(struct files_ref_store *refs,
 					 const char *caller)
 {
-	if (refs->submodule)
-		die("BUG: %s called for a submodule", caller);
+	/* This function is to be deleted in the next patch */
 }
 
 /*
@@ -1206,11 +1191,6 @@ static void files_refname_path(struct files_ref_store *refs,
 			       struct strbuf *sb,
 			       const char *refname)
 {
-	if (refs->submodule) {
-		strbuf_git_path_submodule(sb, refs->submodule, "%s", refname);
-		return;
-	}
-
 	switch (ref_type(refname)) {
 	case REF_TYPE_PER_WORKTREE:
 	case REF_TYPE_PSEUDOREF:
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index f732473e1..dfa181792 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -482,12 +482,11 @@ struct ref_store;
 /* refs backends */
 
 /*
- * Initialize the ref_store for the specified submodule, or for the
- * main repository if submodule == NULL. These functions should call
- * base_ref_store_init() to initialize the shared part of the
- * ref_store and to record the ref_store for later lookup.
+ * Initialize the ref_store for the specified gitdir. These functions
+ * should call base_ref_store_init() to initialize the shared part of
+ * the ref_store and to record the ref_store for later lookup.
  */
-typedef struct ref_store *ref_store_init_fn(const char *submodule);
+typedef struct ref_store *ref_store_init_fn(const char *gitdir);
 
 typedef int ref_init_db_fn(struct ref_store *refs, struct strbuf *err);
 
-- 
2.11.0.157.gd943d85


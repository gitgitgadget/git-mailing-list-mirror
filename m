Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ACE120136
	for <e@80x24.org>; Thu, 16 Feb 2017 11:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755045AbdBPLuU (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 06:50:20 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34712 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754704AbdBPLuM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 06:50:12 -0500
Received: by mail-pf0-f193.google.com with SMTP id o64so1490885pfb.1
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 03:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0viVQnAFh53eaj/TkxXGzyvQuD2ic9Z+faXb2mElFKU=;
        b=Jom9upGQEE5dT8DGTY77tXV3aWYF/fdhK/XQTeeHeb9WFQC4wb0PSoMpF6eP/ttTQ6
         z+itTPs7BxEqcSJH3+eL3zM3zfisS8yXFHr/kC2O+npKzHt/1cYPooUB9doreFloj96p
         40aoFC4xcSeQanBu5KfQdiaWe8SYv1+qlm6QzgqQHFhCVWXQYvvYUT97aWLp5om/vzi4
         ZF1UXszMbKZF7QcoDmix5XEE6LopHJWQUMU3mGrYESUY8fC9Ls20tWsj0MvUIyRtGhgm
         XqNNxbx7wfb857MnLdqNqa96Ags5TzUB0EsH7FpFyTotdJW3UY9S8EqRhB/Ll0Nbst3D
         5tIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0viVQnAFh53eaj/TkxXGzyvQuD2ic9Z+faXb2mElFKU=;
        b=n5P0hPHidtxgtGOe8GtjJgFPo8eaRdOhCHropZsEsTcbezbczzzmnOsokQ7ZuJjrxu
         62/11puNqSoPWDwt9BQ0uZS/oRkDezPAqgGKEQW16KwNKreLm5C0mqwGQ3LDBXPDOsLK
         PvCyO9UDJoD5xyRsiiBBiFCiBpSnmfd+xk2olFLwTitT4d+HRsyNcy8T9wkgm4eAU/tU
         RGItm8+AYl4XVYfd6SVWqOQqUAbZUpIultS6DzS+XlSGUKR8nB1PEfdIhFDLrHrRUHLz
         ZOmyMPyYZFnNi2K2J3rAk4+mfMg/HTdB7VIsl0a+wJTQceFQJt86lAH1v0vl7fa5MRWt
         FQlQ==
X-Gm-Message-State: AMke39n99afcWJhpTJDRwbykuBaWcfr0bJyWoU0wRXNpeLdr10Q5Ox4iiaj+TyrjKR6kag==
X-Received: by 10.99.109.140 with SMTP id i134mr85967pgc.11.1487245811638;
        Thu, 16 Feb 2017 03:50:11 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id n70sm13345282pfg.34.2017.02.16.03.50.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 03:50:10 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 16 Feb 2017 18:50:06 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 14/16] refs: move submodule code out of files-backend.c
Date:   Thu, 16 Feb 2017 18:48:16 +0700
Message-Id: <20170216114818.6080-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170216114818.6080-1-pclouds@gmail.com>
References: <20170213152011.12050-1-pclouds@gmail.com>
 <20170216114818.6080-1-pclouds@gmail.com>
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
 refs/files-backend.c | 26 ++++++++------------------
 refs/refs-internal.h |  6 +++---
 3 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/refs.c b/refs.c
index 25f657a6f..58ac9a2a8 100644
--- a/refs.c
+++ b/refs.c
@@ -9,6 +9,7 @@
 #include "refs/refs-internal.h"
 #include "object.h"
 #include "tag.h"
+#include "submodule.h"
 
 /*
  * List of all available backends
@@ -1419,9 +1420,9 @@ static void register_submodule_ref_store(struct ref_store *refs,
 
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
@@ -1430,7 +1431,7 @@ static struct ref_store *ref_store_init(const char *submodule)
 	if (!be)
 		die("BUG: reference backend %s is unknown", be_name);
 
-	refs = be->init(submodule);
+	refs = be->init(gitdir);
 	return refs;
 }
 
@@ -1455,6 +1456,7 @@ struct ref_store *get_ref_store(const char *submodule)
 {
 	struct strbuf submodule_sb = STRBUF_INIT;
 	struct ref_store *refs;
+	int ret;
 
 	if (!submodule || !*submodule) {
 		return get_main_ref_store();
@@ -1465,8 +1467,14 @@ struct ref_store *get_ref_store(const char *submodule)
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
index 74e31d041..e8946e638 100644
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
 
@@ -945,12 +938,9 @@ static void files_path(struct files_ref_store *refs, struct strbuf *sb,
 	va_start(vap, fmt);
 	strbuf_vaddf(&tmp, fmt, vap);
 	va_end(vap);
-	if (refs->submodule)
-		strbuf_git_path_submodule(sb, refs->submodule,
-					  "%s", tmp.buf);
-	else if (is_per_worktree_ref(tmp.buf) ||
-		 (skip_prefix(tmp.buf, "logs/", &ref) &&
-		  is_per_worktree_ref(ref)))
+	if (is_per_worktree_ref(tmp.buf) ||
+	    (skip_prefix(tmp.buf, "logs/", &ref) &&
+	     is_per_worktree_ref(ref)))
 		strbuf_addf(sb, "%s/%s", refs->gitdir.buf, tmp.buf);
 	else
 		strbuf_addf(sb, "%s/%s", refs->gitcommondir.buf, tmp.buf);
@@ -1005,7 +995,7 @@ static void clear_loose_ref_cache(struct files_ref_store *refs)
  * Create a new submodule ref cache and add it to the internal
  * set of caches.
  */
-static struct ref_store *files_ref_store_create(const char *submodule)
+static struct ref_store *files_ref_store_create(const char *gitdir)
 {
 	struct files_ref_store *refs = xcalloc(1, sizeof(*refs));
 	struct ref_store *ref_store = (struct ref_store *)refs;
@@ -1015,8 +1005,9 @@ static struct ref_store *files_ref_store_create(const char *submodule)
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
@@ -1032,8 +1023,7 @@ static struct ref_store *files_ref_store_create(const char *submodule)
 static void files_assert_main_repository(struct files_ref_store *refs,
 					 const char *caller)
 {
-	if (refs->submodule)
-		die("BUG: %s called for a submodule", caller);
+	/* This function is to be deleted in the next patch */
 }
 
 /*
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 69d02b6ba..d7112770d 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -476,12 +476,12 @@ struct ref_store;
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


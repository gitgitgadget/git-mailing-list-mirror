Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 308B92095D
	for <e@80x24.org>; Sat, 18 Mar 2017 02:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751405AbdCRCHS (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 22:07:18 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36558 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751392AbdCRCHP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 22:07:15 -0400
Received: by mail-pf0-f194.google.com with SMTP id r137so6498639pfr.3
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 19:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=45BjH+6OP4Wew9hg4qANeOrLXoV7h4N71KJPrPQAKWQ=;
        b=P7QI1QTOJ0QseA1E2usWqUNo1QSmCmZ53qK1MMLb4qD+r7PsHoLooagsO/INHueV9N
         N6G8SEuqGTdE3BU1JZ9b1za6U55cQAPsHWUm9b8jmUE3/MiXXpAS3VE63B9n68zqikBe
         2YJMQr2bikgdeI+dCb5vUcb7LuNX8aBta6NhnuH3BpS6F/SlyQsg1R3BHd1qqAQPiCqy
         bN5oyGMTTHOLrtKxPyIICDLmcXqdLsahQjLRcr9hzYAWzawACa4uScYbvuwudV9yKRQ5
         31NVSOljGvtm2/rTrGWrJ1N/UkB+D4dLryKhG2nZ1zk/Y7IVx9ATDQnq4UVFmSxZoWpc
         RDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=45BjH+6OP4Wew9hg4qANeOrLXoV7h4N71KJPrPQAKWQ=;
        b=lAAqWpqA6VDuOAzTIsAQoDqRP/TGt6uanBrgowkId4qn2F95xhcHfBkPDE+sN+sCoB
         UGOHEFWMsGuVX9nG3AATe6m/onjOF37wygADH0dnUuZn6UTXDvScWe+hekhRgnCgzgub
         tGutgtGGgou9grFVl+WxoF3M6FYqZlu3gr8pRWz8KMYxsY9Rb9idw7WIJ5klxlhw3UW0
         H5r5X4Hm1nrNHHJ6rgthMG3yFgluogYJhGidqlDIKE3flAAw7wpkwUvlMjA3ImUQp8BE
         Tb2vMR+oS2DTOwEJw1NMqOHnLttwhIm4sPfUoCsdHnY/ozGbNb2RU2+q6XPCiaKMkJQg
         vKDA==
X-Gm-Message-State: AFeK/H2WqOFx+Qh/qOnc5xOPSFXmwGTZsTPvqs34IdEY+FBR824GLYmOSTLjrKbyvtz3sQ==
X-Received: by 10.99.178.9 with SMTP id x9mr18920022pge.48.1489802748899;
        Fri, 17 Mar 2017 19:05:48 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id y9sm19120365pfi.39.2017.03.17.19.05.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Mar 2017 19:05:48 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Mar 2017 09:05:42 +0700
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
Subject: [PATCH v6 17/27] refs: move submodule code out of files-backend.c
Date:   Sat, 18 Mar 2017 09:03:27 +0700
Message-Id: <20170318020337.22767-18-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170318020337.22767-1-pclouds@gmail.com>
References: <20170222140450.30886-1-pclouds@gmail.com>
 <20170318020337.22767-1-pclouds@gmail.com>
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
 refs.c               | 19 ++++++++++++++-----
 refs/files-backend.c | 24 ++----------------------
 refs/refs-internal.h |  9 ++++-----
 3 files changed, 20 insertions(+), 32 deletions(-)

diff --git a/refs.c b/refs.c
index 404d3b62b5..fe724869b8 100644
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
 	main_ref_store = refs;
 	return refs;
 }
@@ -1477,8 +1478,16 @@ struct ref_store *get_ref_store(const char *submodule)
 	if (!ret)
 		return NULL;
 
-	refs = ref_store_init(submodule);
+	ret = submodule_to_gitdir(&submodule_sb, submodule);
+	if (ret) {
+		strbuf_release(&submodule_sb);
+		return NULL;
+	}
+
+	refs = ref_store_init(submodule_sb.buf);
 	register_submodule_ref_store(refs, submodule);
+
+	strbuf_release(&submodule_sb);
 	return refs;
 }
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 351934d36e..db335e4ca6 100644
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
index f732473e1d..dfa1817929 100644
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


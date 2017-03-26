Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F384D20966
	for <e@80x24.org>; Sun, 26 Mar 2017 02:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751369AbdCZCpC (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 22:45:02 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36014 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751364AbdCZCpB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 22:45:01 -0400
Received: by mail-pf0-f193.google.com with SMTP id r137so4066355pfr.3
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 19:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QsUkLj7yG48mP3PoNaIdEWTJpVJTLHZ8KbRfx/TdKrs=;
        b=hkH0YnsNBHGqKdlVoDfJqBi4czQnPwCYPr5CS/bn1EEEWP9zufae3PKoxsNceRm+g3
         smfODZ/+BHU71mgsUhU/EFvPWr/yeDpYwRAnc4tnfOWdlvMPACy/mq5EnIx2pDH0v2xI
         4xdP3/hk1N5fd71lRsYfk0F2yaCBmy+fG6qNKbYL37BVCW6MgFL/DD+WgCPljRus3oC7
         erHiHkPD9qvKODQHRCGqsHJeU6t75M2JmDZqbd6TnegZEsCAKRwbVPMVilTIzKnuhqkX
         yoFg3Y8U/OKz2lTc/6akAev+1ccfNtAuafrKS19ltS5a8vInF9SbNCSkujRNyji1DEYY
         SH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QsUkLj7yG48mP3PoNaIdEWTJpVJTLHZ8KbRfx/TdKrs=;
        b=E3CtRlswOCeppxN8x0XPzNbcXE5dsNcB6BpPEGK+UOavtoxxK3AFLUMudiJjGQaMOp
         M/F0PLfgH4Z0nFmWTVyWCgKqbdsULSVgYGgIVCy0L8LvtS5GjNMKYIuLMGWjsuKHw2Gj
         oLlAZ1LFbgCnowYaq25Osokec2X4mtrK3I4ycbOkAwlTrZS8gM+UMIMWdcoQimIQZoeo
         pERA+Q/pwZ2w9YZMulWSsxYGHwBqv7+fLdEyhxuYLiaimIiT8vYPh1Y3l+CULlOsB6WH
         z7HnD50L1crXi+VClGjhlGCc27R8fY3+UA4rZRV7+hOQBsFle5QYjpY7QnPbhJAQfgEI
         ttlw==
X-Gm-Message-State: AFeK/H3f8OXComBOdWO777HKAVyfcMkFW7j/qKL4hG8UJqaHznn/Wng+LDBV2Nh06PLoMA==
X-Received: by 10.84.217.158 with SMTP id p30mr614217pli.47.1490496285214;
        Sat, 25 Mar 2017 19:44:45 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id i3sm12832700pfk.47.2017.03.25.19.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Mar 2017 19:44:44 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 26 Mar 2017 09:44:38 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v7 18/28] refs: move submodule code out of files-backend.c
Date:   Sun, 26 Mar 2017 09:42:31 +0700
Message-Id: <20170326024241.31984-19-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170326024241.31984-1-pclouds@gmail.com>
References: <20170318020337.22767-1-pclouds@gmail.com>
 <20170326024241.31984-1-pclouds@gmail.com>
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
index 1f4c1a2347..d72b48a430 100644
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
 
@@ -1433,7 +1434,7 @@ struct ref_store *get_main_ref_store(void)
 	if (main_ref_store)
 		return main_ref_store;
 
-	main_ref_store = ref_store_init(NULL);
+	main_ref_store = ref_store_init(get_git_dir());
 	return main_ref_store;
 }
 
@@ -1474,8 +1475,16 @@ struct ref_store *get_ref_store(const char *submodule)
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
index b62f374f9c..490f05a6f4 100644
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
+	/* This function is to be fixed up in the next patch */
 }
 
 /*
@@ -1206,11 +1191,6 @@ static void files_ref_path(struct files_ref_store *refs,
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


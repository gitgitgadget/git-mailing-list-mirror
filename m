Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0FC020136
	for <e@80x24.org>; Thu, 16 Feb 2017 11:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755068AbdBPLug (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 06:50:36 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33119 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755060AbdBPLud (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 06:50:33 -0500
Received: by mail-pf0-f196.google.com with SMTP id e4so1485599pfg.0
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 03:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vSHiE9kJKU5aBnrQSyI8Mxkz3ixZ9OC1D7R4D54TY7Q=;
        b=OK61aQ3yebuIzO4x6msR2Mh4yZbf2JLE9KrQe80nnV91vDXpxWVENhI1H1FMdLdAtW
         Hyfvcc1zmGV/6Aa7jDnSaQ115Q/ZwrdUQcaT4buny3LxD+R+VjOR85PcNmnB3Q1fVJyk
         3Wx10C7hgcuiRXEpLNTVVczGN/Kt2HpDXHrxwmV+dRNF6zGXBUxpeR+rPqvMA/8mLMTv
         vpOMOV2i9/DgFIcUpMTs9xCOrNQjT/bGlcQSZh40SpF+S5Wq400bVVXSfMFm5kw86OUh
         vvwuySg/OfCY9PkCFvEaZcHhzf3LbsTkANoZ7POkWje0JQ/5aJ3LgMBJq/gF/0AsqMAq
         yu1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vSHiE9kJKU5aBnrQSyI8Mxkz3ixZ9OC1D7R4D54TY7Q=;
        b=njC6qdTe5y31Zc54tYsJip5p85Or7E4Xu67SZIeSrk4SG3s8AFPyq3jpmMf9vrUf6z
         xu3uj3eZ/WIHHsm34f7nF5WCmKYZla/WDMPROG1MdP1B1DKntAn2Qz8qwbYiegy7yj1g
         w+mD0lcOYncyvd4u3GrLsjU86seLEqsKLdyBlGpPSkyd24/jSGiaGC0MmC8zvhU5+H6y
         tc+XHT1WrGqCw32fcehes/YSARKRsuMXFpJuwku6Unvir96xvQbUIB6qzjzV36r+TCFE
         UUP2/jJZaYPRlxsRjxIawezaY0nYClsNtNDUMfFGfrR6HbDaxdj9NrLvEwHK90/JiSbY
         fpUA==
X-Gm-Message-State: AMke39noGoPQ0kuH96ZE9nMu9/aLE18STQ6JlF7IqaZM1ZFXNuj1JneGWmr8jmbWfLkXzA==
X-Received: by 10.84.211.106 with SMTP id b97mr2698119pli.16.1487245823057;
        Thu, 16 Feb 2017 03:50:23 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id y184sm13312292pfg.86.2017.02.16.03.50.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 03:50:22 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 16 Feb 2017 18:50:17 +0700
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
Subject: [PATCH v2 16/16] refs: rename get_ref_store() to get_submodule_ref_store() and make it public
Date:   Thu, 16 Feb 2017 18:48:18 +0700
Message-Id: <20170216114818.6080-17-pclouds@gmail.com>
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

This function is intended to replace *_submodule() refs API. It provides
a ref store for a specific submodule, which can be operated on by a new
set of refs API.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c               | 12 ++++++++----
 refs.h               | 11 +++++++++++
 refs/files-backend.c |  2 +-
 refs/refs-internal.h | 12 ------------
 4 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/refs.c b/refs.c
index 58ac9a2a8..e7206a420 100644
--- a/refs.c
+++ b/refs.c
@@ -1160,7 +1160,7 @@ int head_ref(each_ref_fn fn, void *cb_data)
 static int do_for_each_ref(const char *submodule, const char *prefix,
 			   each_ref_fn fn, int trim, int flags, void *cb_data)
 {
-	struct ref_store *refs = get_ref_store(submodule);
+	struct ref_store *refs = get_submodule_ref_store(submodule);
 	struct ref_iterator *iter;
 
 	if (!refs)
@@ -1333,10 +1333,10 @@ int resolve_gitlink_ref(const char *submodule, const char *refname,
 		/* We need to strip off one or more trailing slashes */
 		char *stripped = xmemdupz(submodule, len);
 
-		refs = get_ref_store(stripped);
+		refs = get_submodule_ref_store(stripped);
 		free(stripped);
 	} else {
-		refs = get_ref_store(submodule);
+		refs = get_submodule_ref_store(submodule);
 	}
 
 	if (!refs)
@@ -1452,13 +1452,17 @@ struct ref_store *get_main_ref_store(void)
 	return refs;
 }
 
-struct ref_store *get_ref_store(const char *submodule)
+struct ref_store *get_submodule_ref_store(const char *submodule)
 {
 	struct strbuf submodule_sb = STRBUF_INIT;
 	struct ref_store *refs;
 	int ret;
 
 	if (!submodule || !*submodule) {
+		/*
+		 * FIXME: This case is ideally not allowed. But that
+		 * can't happen until we clean up all the callers.
+		 */
 		return get_main_ref_store();
 	}
 
diff --git a/refs.h b/refs.h
index f803528fc..1287ba59c 100644
--- a/refs.h
+++ b/refs.h
@@ -554,5 +554,16 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 int ref_storage_backend_exists(const char *name);
 
 struct ref_store *get_main_ref_store(void);
+/*
+ * Return the ref_store instance for the specified submodule. For the
+ * main repository, use submodule==NULL; such a call cannot fail. For
+ * a submodule, the submodule must exist and be a nonbare repository,
+ * otherwise return NULL. If the requested reference store has not yet
+ * been initialized, initialize it first.
+ *
+ * For backwards compatibility, submodule=="" is treated the same as
+ * submodule==NULL.
+ */
+struct ref_store *get_submodule_ref_store(const char *submodule);
 
 #endif /* REFS_H */
diff --git a/refs/files-backend.c b/refs/files-backend.c
index d9fc29d8d..685ea5c14 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3115,7 +3115,7 @@ int set_worktree_head_symref(const char *gitdir, const char *target)
 	 * backends. This function needs to die.
 	 */
 	struct files_ref_store *refs =
-		files_downcast(get_ref_store(NULL), "set_head_symref");
+		files_downcast(get_main_ref_store(), "set_head_symref");
 	static struct lock_file head_lock;
 	struct ref_lock *lock;
 	struct strbuf head_path = STRBUF_INIT;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index d7112770d..cb6882779 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -634,18 +634,6 @@ struct ref_store {
 void base_ref_store_init(struct ref_store *refs,
 			 const struct ref_storage_be *be);
 
-/*
- * Return the ref_store instance for the specified submodule. For the
- * main repository, use submodule==NULL; such a call cannot fail. For
- * a submodule, the submodule must exist and be a nonbare repository,
- * otherwise return NULL. If the requested reference store has not yet
- * been initialized, initialize it first.
- *
- * For backwards compatibility, submodule=="" is treated the same as
- * submodule==NULL.
- */
-struct ref_store *get_ref_store(const char *submodule);
-
 const char *resolve_ref_recursively(struct ref_store *refs,
 				    const char *refname,
 				    int resolve_flags,
-- 
2.11.0.157.gd943d85


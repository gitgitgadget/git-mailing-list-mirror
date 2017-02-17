Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9802B20136
	for <e@80x24.org>; Fri, 17 Feb 2017 14:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934073AbdBQOGs (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 09:06:48 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33844 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934041AbdBQOGr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 09:06:47 -0500
Received: by mail-pg0-f68.google.com with SMTP id v184so5050398pgv.1
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 06:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qS8P3yaigjqrdgICf6cXA/KNowpUsDOeIatQZRpSRa8=;
        b=AEBoCwG1nvxg5qCvSFTP0Z9mY/Vt7NgzmQ9T0MQP+1dzMPnzRdx6/WyU9SS92+XFa+
         p4p9Tt7binWbjlyoa/x987SbSX3fHuX2F8pAymR4X/Knc189R5ZE7+iy4dgstCnX3nY6
         4hg76pSnjl130zhNTa994Rl2Vgyd6YeX5OnrFf9k4DYuAyZ33GHSOMiNxH5XSRtv2awo
         YqCZqiz1TcQkzeUsZ8FiG6LW5P42SYznVOI3+FMgKORGjEIhvsTYrpvWdV2AqhtCShu9
         Jxn2exhBqQ5WiOsnzp9QdonUzYJEzN4ZZScI3JEyhNcwiDqCp3//Pv8n+0PSL80ghmwr
         ZvAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qS8P3yaigjqrdgICf6cXA/KNowpUsDOeIatQZRpSRa8=;
        b=W/sjAwhFpbKoIXMApmS9Xtu/j0NzgMannWGprpJpQivNKl5hURkmbAGe7HOcrA5H8O
         0sZeU4Xb6klsniUpt75dcyv28tvVwKxWrMMLfmmOuZkMp13+/86Mm2zGQg4Fn2e9x3lD
         5Lwa/yeY7gyjyBDWvswyc89M5b8E34lU0lQLorB1pY2BZjOVUvbZJJoqAC2vsqnFTdSt
         lJZ8Ps/H/M3EVXLVpYccwBrhImkJzhCHxkpjmoS4HxVNuu0qR1pcTURrf69RXEQpusFi
         yXcmbfvmn6EYUNLcsDimYYn1A+huk79vUhmVNEEpUg2Ysv385yYtSkwDEP8eDOleM3bw
         XqFg==
X-Gm-Message-State: AMke39mizyFUjrwR0mk6DGq556cswL/Bt4xwgn2xDzSDtZtx5DiZnGA/trLpAHPYxIogyQ==
X-Received: by 10.99.96.209 with SMTP id u200mr4011907pgb.75.1487340406938;
        Fri, 17 Feb 2017 06:06:46 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id s64sm20072459pfe.27.2017.02.17.06.06.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 06:06:46 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 17 Feb 2017 21:06:41 +0700
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
Subject: [PATCH v3 16/16] refs: rename get_ref_store() to get_submodule_ref_store() and make it public
Date:   Fri, 17 Feb 2017 21:04:36 +0700
Message-Id: <20170217140436.17336-17-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170217140436.17336-1-pclouds@gmail.com>
References: <20170216114818.6080-1-pclouds@gmail.com>
 <20170217140436.17336-1-pclouds@gmail.com>
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
index d35032fcd..82be3f90f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3117,7 +3117,7 @@ int set_worktree_head_symref(const char *gitdir, const char *target)
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


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 416C2201B0
	for <e@80x24.org>; Sat, 18 Feb 2017 13:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753231AbdBRNfN (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 08:35:13 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35799 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753280AbdBRNfM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 08:35:12 -0500
Received: by mail-pf0-f195.google.com with SMTP id 68so6201182pfx.2
        for <git@vger.kernel.org>; Sat, 18 Feb 2017 05:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+QnsnckDGbhleX3EVJq1IRnh5Gpy/1XJXWLIU8MJaek=;
        b=ixJ99nnKZt9kh/7/9jN3DsEqE5ESB1VAkrXjzIj/QWrV9ThwqaXl2yHPEyxJCSNnO6
         FlrYwGyOyJwk8tvku46j0Z944nsyfyz3ARBPC+3yNYARrUv3/puGkoHalSCpq7+6qzNU
         W7DJP1Rg0iQ7dwZPk+0AnpBANUj4X9iXw9I1xe/Xs/7XyypKC+kJmvs2M0odBcck+/A7
         Lx9r5D7m8iJE8WW+wnYmEZ6KAIPth47EB7Xleu2yT54K4A85+JQGt3O3k73F2VH7zWl9
         tFukoys7Aeda64NZJyNBtLqcWxBOV1+f3zb89fULU4Sqk2avq+v7nlBVVALonzgYB9JP
         zCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+QnsnckDGbhleX3EVJq1IRnh5Gpy/1XJXWLIU8MJaek=;
        b=phr+y1bZ94MMwyjlt2o4/mAV4oJnqn7YONs+nT5D6vVsGiecThztGWD3jDCYEHT06r
         u5JYbBy1S+FJcokprd0XUY4y12NPI6YOL/GjHQO5eNX4cI0AhWIQsYm29A1hcEaXJTTX
         7mUye/OYt8/n3bthRvROAdFFCUccM1MDSfsh92K/pj0mTohUkzMM0yBG+3I17jv3n4j3
         sHbEw9lE5uE33jcAZfqAenYMjGqcge8LbAb14FJp5BWJdOPTQKl0LopKZ+Ln3jFjhig+
         sq/6U5Z8IPI0/CipRfSkk2IKdh9Geb98Zv4Iu65otcfdz8ihW1bIkzYBKnZC6K2muaJg
         CJWw==
X-Gm-Message-State: AMke39nvTZCfYxh7s75TbjKC31ghyGK0YtSLHWDoIBZvXywYx2+ktypT6FQFMve8qqyqfQ==
X-Received: by 10.84.211.7 with SMTP id b7mr18181313pli.82.1487424911642;
        Sat, 18 Feb 2017 05:35:11 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id z70sm25553976pff.26.2017.02.18.05.35.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Feb 2017 05:35:10 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Feb 2017 20:35:04 +0700
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
Subject: [PATCH v4 15/15] refs: rename get_ref_store() to get_submodule_ref_store() and make it public
Date:   Sat, 18 Feb 2017 20:33:03 +0700
Message-Id: <20170218133303.3682-16-pclouds@gmail.com>
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
index 8035c3ea7..bc2247b59 100644
--- a/refs.c
+++ b/refs.c
@@ -1165,7 +1165,7 @@ int head_ref(each_ref_fn fn, void *cb_data)
 static int do_for_each_ref(const char *submodule, const char *prefix,
 			   each_ref_fn fn, int trim, int flags, void *cb_data)
 {
-	struct ref_store *refs = get_ref_store(submodule);
+	struct ref_store *refs = get_submodule_ref_store(submodule);
 	struct ref_iterator *iter;
 
 	if (!refs)
@@ -1338,10 +1338,10 @@ int resolve_gitlink_ref(const char *submodule, const char *refname,
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
@@ -1457,13 +1457,17 @@ struct ref_store *get_main_ref_store(void)
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
index a35b687d7..5bd065f12 100644
--- a/refs.h
+++ b/refs.h
@@ -556,5 +556,16 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
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
index b8ccf4e47..603601f1b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3125,7 +3125,7 @@ int set_worktree_head_symref(const char *gitdir, const char *target)
 	 * backends. This function needs to die.
 	 */
 	struct files_ref_store *refs =
-		files_downcast(get_ref_store(NULL), "set_head_symref");
+		files_downcast(get_main_ref_store(), "set_head_symref");
 	static struct lock_file head_lock;
 	struct ref_lock *lock;
 	struct strbuf head_path = STRBUF_INIT;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 3ef020acf..ed6527ce1 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -640,18 +640,6 @@ struct ref_store {
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


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFBEE20248
	for <e@80x24.org>; Sat, 30 Mar 2019 11:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbfC3LW7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 07:22:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34352 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730471AbfC3LW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 07:22:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id v12so2445356pgq.1
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 04:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h4UsmkkHNE/w67i9pZNTRUVeoBYpvfa1184swHxAb98=;
        b=o/ttobVKJjpQ6XugtGbnlu7iT8FPXqv1bxD6+D3XAlCRKkO0YkoFsfALRnUdImWdSs
         yf7akBlS4hzh5V8w5eKg1dnxON9COPqfSXRzvZx5HwjjYKW6ql8XjGOA+icKyoC2LC0M
         GKqMhOAD9OTwTeqRNIntiokrz2pscjc8SU8uB7AKqETYpUNqxUl3yLDxtsWWVt2iRZ3B
         WLHosj2z3e09La9n97CPaD4i2nmj6jZMR/Ci9NO8ZwYP5rVBjKrWPSM80q/p6XWJaT9g
         Zmwjff+fgPS2dPN3Xw7C6S1XmwbwNit8Y5rgViCgEmKgxNJ1UVX0AYW0rVrUGbQ2FOup
         rWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h4UsmkkHNE/w67i9pZNTRUVeoBYpvfa1184swHxAb98=;
        b=dFGzG2wRoOUoA4/gk2QTOZh4kBpH9S8CH7+Q2AWL8tUAVD2Gs8/ebzJ+VP1RWBJvb0
         vIPoHasyyZ+O4nG4GMmdR7fP8iWDFPGjU5jnL3qnWfll9Kets5CglkHCWHLmJdANV/nl
         AdAiSJdQ0qY9WfqN4qIKbhO0YVYznpCyvSyKs9yMEWXvbiQv6FxgLT5HiLJdDLXaL23h
         keWsM6Yd/Gl2FDwaXW2c43872v3ESp163sRiIUXZJmFcT4m1Nuh+00a86eYM7ZYh1rwo
         zOWU9B+eCzZLfeOew+wKiV7BatioK0J3iZbjepVYv7ZIMeRiKlKm9h6fjmiuB4oKbCrH
         RwYw==
X-Gm-Message-State: APjAAAVVfNS/7e8b4REmW7T201nZPWhdBtPlCpowSP33ZAJ045XB8YV4
        5Dj/g6CpUEqnb/rcbvucxz8PXkxy
X-Google-Smtp-Source: APXvYqwz5t/nUarYQ+S/uyoPp6QF3gTX+PKmxqwa774DoUqp2+RkjIV3x0gHW3u4wRJu7rwE0F8L1Q==
X-Received: by 2002:a65:5a81:: with SMTP id c1mr49650651pgt.391.1553944978475;
        Sat, 30 Mar 2019 04:22:58 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id z189sm6480400pfb.146.2019.03.30.04.22.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 04:22:57 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 30 Mar 2019 18:22:53 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 30/31] sha1-name.c: remove the_repo from other get_oid_*
Date:   Sat, 30 Mar 2019 18:19:26 +0700
Message-Id: <20190330111927.18645-31-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190330111927.18645-1-pclouds@gmail.com>
References: <20190330111927.18645-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 cache.h     | 18 ++++++++++++------
 sha1-name.c | 35 ++++++++++++++++++++---------------
 2 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/cache.h b/cache.h
index 3718b3db8a..871a167bf8 100644
--- a/cache.h
+++ b/cache.h
@@ -1381,12 +1381,11 @@ enum get_oid_result {
 };
 
 int repo_get_oid(struct repository *r, const char *str, struct object_id *oid);
-#define get_oid(str, oid) repo_get_oid(the_repository, str, oid)
-extern int get_oid_commit(const char *str, struct object_id *oid);
-extern int get_oid_committish(const char *str, struct object_id *oid);
-extern int get_oid_tree(const char *str, struct object_id *oid);
-extern int get_oid_treeish(const char *str, struct object_id *oid);
-extern int get_oid_blob(const char *str, struct object_id *oid);
+int repo_get_oid_commit(struct repository *r, const char *str, struct object_id *oid);
+int repo_get_oid_committish(struct repository *r, const char *str, struct object_id *oid);
+int repo_get_oid_tree(struct repository *r, const char *str, struct object_id *oid);
+int repo_get_oid_treeish(struct repository *r, const char *str, struct object_id *oid);
+int repo_get_oid_blob(struct repository *r, const char *str, struct object_id *oid);
 void maybe_die_on_misspelt_object_name(struct repository *repo,
 				       const char *name,
 				       const char *prefix);
@@ -1394,6 +1393,13 @@ extern enum get_oid_result get_oid_with_context(struct repository *repo, const c
 				unsigned flags, struct object_id *oid,
 				struct object_context *oc);
 
+#define get_oid(str, oid)		repo_get_oid(the_repository, str, oid)
+#define get_oid_commit(str, oid)	repo_get_oid_commit(the_repository, str, oid)
+#define get_oid_committish(str, oid)	repo_get_oid_committish(the_repository, str, oid)
+#define get_oid_tree(str, oid)		repo_get_oid_tree(the_repository, str, oid)
+#define get_oid_treeish(str, oid)	repo_get_oid_treeish(the_repository, str, oid)
+#define get_oid_blob(str, oid)		repo_get_oid_blob(the_repository, str, oid)
+
 typedef int each_abbrev_fn(const struct object_id *oid, void *);
 int repo_for_each_abbrev(struct repository *r, const char *prefix, each_abbrev_fn, void *);
 #define for_each_abbrev(prefix, fn, data) repo_for_each_abbrev(the_repository, prefix, fn, data)
diff --git a/sha1-name.c b/sha1-name.c
index b94d381bef..d49496397d 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1590,43 +1590,48 @@ int repo_get_oid(struct repository *r, const char *name, struct object_id *oid)
  * commit-ish. It is merely to give a hint to the disambiguation
  * machinery.
  */
-int get_oid_committish(const char *name, struct object_id *oid)
+int repo_get_oid_committish(struct repository *r,
+			    const char *name,
+			    struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(the_repository,
-				    name, GET_OID_COMMITTISH,
+	return get_oid_with_context(r, name, GET_OID_COMMITTISH,
 				    oid, &unused);
 }
 
-int get_oid_treeish(const char *name, struct object_id *oid)
+int repo_get_oid_treeish(struct repository *r,
+			 const char *name,
+			 struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(the_repository,
-				    name, GET_OID_TREEISH,
+	return get_oid_with_context(r, name, GET_OID_TREEISH,
 				    oid, &unused);
 }
 
-int get_oid_commit(const char *name, struct object_id *oid)
+int repo_get_oid_commit(struct repository *r,
+			const char *name,
+			struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(the_repository,
-				    name, GET_OID_COMMIT,
+	return get_oid_with_context(r, name, GET_OID_COMMIT,
 				    oid, &unused);
 }
 
-int get_oid_tree(const char *name, struct object_id *oid)
+int repo_get_oid_tree(struct repository *r,
+		      const char *name,
+		      struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(the_repository,
-				    name, GET_OID_TREE,
+	return get_oid_with_context(r, name, GET_OID_TREE,
 				    oid, &unused);
 }
 
-int get_oid_blob(const char *name, struct object_id *oid)
+int repo_get_oid_blob(struct repository *r,
+		      const char *name,
+		      struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(the_repository,
-				    name, GET_OID_BLOB,
+	return get_oid_with_context(r, name, GET_OID_BLOB,
 				    oid, &unused);
 }
 
-- 
2.21.0.479.g47ac719cd3


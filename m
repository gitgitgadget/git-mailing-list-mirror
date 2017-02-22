Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C3D3201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 14:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932732AbdBVOHs (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 09:07:48 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33828 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932728AbdBVOHq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 09:07:46 -0500
Received: by mail-pg0-f67.google.com with SMTP id s67so557808pgb.1
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 06:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=prVfqR3W46V6beNiyBn+bWGWikFo6nOxgV0aJO1i+Ow=;
        b=i10n0nPHZ1MeL24j2QqfgOuteJaimibQvCNiH6vd6mjEobyjOFl1Ka6r4QOacAdOxs
         6o5zzEbsRGkNPsSfLdAxoEhc/kUlDhb6btMkjHVhoeA46+XTxfg+auoHLn7e07KN2h5K
         6TidMi2LEddKl30QLlMA1ag9h/HXrVajnWazfj+LXwQJ1IijM4YJm5aSGgBTaXRp3rte
         VC5Gakb4t2jksz3FJyqOjO3WxTAYTzqFnxk33bBRejBPt0SOLl/3a+NO77cdAI57oT98
         ZeaCJ8kfmMZzV9SEoJRuyAA3jjFZxUbs0KfmdEqKgaPqllN2B/u0F6ZWoCiIxXIu1rwx
         2ZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=prVfqR3W46V6beNiyBn+bWGWikFo6nOxgV0aJO1i+Ow=;
        b=dOQQX1PPywt72AvXynK4dsi/4ZMs5vJ4qRi42/4f1hu0NngodFBtf7e+1WA/UG2wGE
         rJu3aIxqMu6l11zpMs7TMRMaIvQwIY3P007mdjM3lg6zHna2zMmmO5XqGb2hL638TOzm
         2s2mZWna/dLiPfy7YqMat39LNLrhTNP8iGCBX0/hYB/q2tUPX/9tl0lojxIDFUsAGwEO
         Ur/cNwzrVMO5VfONUS6gxJtJjZzPrjy8sJu9hGNU8aJFAvDCP2UHplM1ZBbRpgeSoFjL
         tXxRIQONowxJg5U0XNGni7VZih4LVFwb92kn397BR2SrIVLSRbyJtleuFGHNZOdO/UV1
         LvNQ==
X-Gm-Message-State: AMke39kLdyEyL8tEvo3J7EJUaCOM69Y3JpFF+4q8TgVzdqbS8NB51por19v6ig8JQya09g==
X-Received: by 10.84.241.201 with SMTP id t9mr22496780plm.18.1487772465203;
        Wed, 22 Feb 2017 06:07:45 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id n79sm4114524pfj.31.2017.02.22.06.07.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Feb 2017 06:07:44 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 22 Feb 2017 21:07:37 +0700
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
Subject: [PATCH v5 17/24] refs: rename get_ref_store() to get_submodule_ref_store() and make it public
Date:   Wed, 22 Feb 2017 21:04:43 +0700
Message-Id: <20170222140450.30886-18-pclouds@gmail.com>
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

This function is intended to replace *_submodule() refs API. It provides
a ref store for a specific submodule, which can be operated on by a new
set of refs API.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c               | 12 ++++++++----
 refs.h               | 11 +++++++++++
 refs/refs-internal.h | 12 ------------
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index 2dc97891a..7843d3085 100644
--- a/refs.c
+++ b/refs.c
@@ -1171,7 +1171,7 @@ int head_ref(each_ref_fn fn, void *cb_data)
 static int do_for_each_ref(const char *submodule, const char *prefix,
 			   each_ref_fn fn, int trim, int flags, void *cb_data)
 {
-	struct ref_store *refs = get_ref_store(submodule);
+	struct ref_store *refs = get_submodule_ref_store(submodule);
 	struct ref_iterator *iter;
 
 	if (!refs)
@@ -1344,10 +1344,10 @@ int resolve_gitlink_ref(const char *submodule, const char *refname,
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
@@ -1468,13 +1468,17 @@ static void register_submodule_ref_store(struct ref_store *refs,
 		    submodule);
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
index 29013cb7e..2efba6ba9 100644
--- a/refs.h
+++ b/refs.h
@@ -561,5 +561,16 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
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
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 0cca280b5..f20dde39e 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -646,18 +646,6 @@ struct ref_store {
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


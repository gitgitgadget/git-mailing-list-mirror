Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1464920966
	for <e@80x24.org>; Sun, 26 Mar 2017 02:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751382AbdCZCpP (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 22:45:15 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33179 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751364AbdCZCpO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 22:45:14 -0400
Received: by mail-pf0-f195.google.com with SMTP id p189so4077439pfp.0
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 19:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qxLVfpsMZlSgVhWw4UhBOWYkcoYI97RZ0Qi/3unpgxc=;
        b=hMflnHLBtEAqh5g54S0qBi6CANHBmlKZVZhTm4WdIXA+Pb5HucmOGe1ikNtNJqBKCE
         pJOSlqL+FtkYxcGNRsH4mbzf+I7HGTfI+a3E5nVGS0JLQt9l+7Xe4Iav9GPw6eblgEIq
         SM4/polg2daB4gmL2MAmlreERLjcDb/v868zCfACaJ3K33DIoNa4EZXigHckKzIw9BI3
         w2+0uNYjCAi+v5k72kCnBLA9BHye+cwOfJvt6oN33O7bNLN5c9xIfcKTPztpnsnHb+wV
         BnfpOV3N6LG2aZ321XhF5Bpu+xdiKEILgrq5okaiZB4uFE+wU3egsdPiNHgRTEAehIYR
         Y+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qxLVfpsMZlSgVhWw4UhBOWYkcoYI97RZ0Qi/3unpgxc=;
        b=R5HEKaXaRsG86xSR7PUBjDQgdJyP4AZR4vECSFH2vEngFfFOWHhRWxlYbTuzCjebWP
         Rp4SNI6+W4J9LCeT4r884PghnVgPkwtWsgb/5cUvOgj9UXKjiCof6dgCearUSFQElpy+
         GBJklwWCS9p21IwoTT4sUEQDXpo7F5JBzRarQ7PA5wZ11MnHOznhX3N1EH+Ho3ZYz/ID
         y/o7/JK9YPFcRpP/urvADOcQfoemYnDA9VrR29FK1nzXy18fBWPm7oSHLaInGQ3bTb1K
         GuoISzbvWFm+BEcON0ANRWUW9uDC1si5wZyBr5m5Ksv2dhimM5vW7h5VjIgUgCQtORkT
         JjzA==
X-Gm-Message-State: AFeK/H3dW/T8XdpG+2EVNFMipdvW6Yj7wlbvzA8i5FxImtfZ0/JozCKKisBw/9ckpyiH6w==
X-Received: by 10.98.205.7 with SMTP id o7mr18026944pfg.171.1490496297843;
        Sat, 25 Mar 2017 19:44:57 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id r13sm12822943pfg.55.2017.03.25.19.44.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Mar 2017 19:44:57 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 26 Mar 2017 09:44:52 +0700
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
Subject: [PATCH v7 20/28] refs: rename get_ref_store() to get_submodule_ref_store() and make it public
Date:   Sun, 26 Mar 2017 09:42:33 +0700
Message-Id: <20170326024241.31984-21-pclouds@gmail.com>
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
index 241b4227b2..100a925bcc 100644
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
@@ -1460,13 +1460,17 @@ static void register_submodule_ref_store(struct ref_store *refs,
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
index a6cd12267f..e6d8f67895 100644
--- a/refs.h
+++ b/refs.h
@@ -562,5 +562,16 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
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
index 0cca280b5c..f20dde39ee 100644
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


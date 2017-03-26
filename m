Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A73A520966
	for <e@80x24.org>; Sun, 26 Mar 2017 02:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751338AbdCZCo2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 22:44:28 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34426 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751242AbdCZCo1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 22:44:27 -0400
Received: by mail-pf0-f193.google.com with SMTP id o126so4075665pfb.1
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 19:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PK4344s8i8G9kABJFQAU6ZqUzGT/eP+nfevErubh2+4=;
        b=R4WgRi+Q9hOcgfssc3aSCTyza3qre0oJJF13fsCGej37EYK8oruK9vzfBQ2NX82M78
         ejCY2JemyIatFXmXeWnHE5GfU2gQnVfbFo+krAC0H4OnwEesMaNjSmfezdYmcvkhZc8/
         8cJnwp+Gz8cidE8QfSukDv/087Lh8qm+4I5wwyFZyE5v5DxQPgBTlQe03A+jT8Yc3LeE
         JZ91MR1bXX+5itVdKEor7WTxNrlZ6abCnVbsGAfqZMagpIEVVDMepTbQdeigf996ZZvN
         9eGJz8KN7kTWiOmsji4BeVtCIRyB4NbPiBwRoopkEvpvT/ub2j5h3NOVN7ILZRZ1km7E
         8CfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PK4344s8i8G9kABJFQAU6ZqUzGT/eP+nfevErubh2+4=;
        b=fqybQJLgDfQEHzhkYK60+pAzElIEKZvhY/3NUjVy+FpsJGV2IOQyT8n4vdRy8pbcRc
         3tc/etO//+aRNUnPWzlIp2dlaoM1G7Y8j9Wp8te5cEJGIseHorlsokHSlxxDSFsgmwZM
         SRMMnaGfPM71+Rk8Rlvd2O27/u+rz2j/oVcG8YOtwSE355QXBnKzqfvx8MyXHi1pef9B
         qKxP7RUelPXFPBzhgQqpUDygQ4F0WM2sKi1fH7KvPx3CSZqLQCc29lPL3ZEd03Buw16M
         CjhTIJUi+tsrQdL86N6P3ixzN+dnz7s4ZuWT1569HPWsf2z70U8KtxegeYKbMw56CO9A
         TB6A==
X-Gm-Message-State: AFeK/H39XB3i7vuyYy7WIqJAhuHEXdQNyaY+lljlI3e/E3UVeaDW9RoXtB9YGwr8WabewQ==
X-Received: by 10.84.224.66 with SMTP id a2mr11273073plt.32.1490496265887;
        Sat, 25 Mar 2017 19:44:25 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id p24sm12836893pfd.26.2017.03.25.19.44.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Mar 2017 19:44:25 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 26 Mar 2017 09:44:20 +0700
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
Subject: [PATCH v7 15/28] refs.c: kill register_ref_store(), add register_submodule_ref_store()
Date:   Sun, 26 Mar 2017 09:42:28 +0700
Message-Id: <20170326024241.31984-16-pclouds@gmail.com>
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

This is the last function in this code (besides public API) that takes
submodule argument and handles both main/submodule cases. Break it down,
move main store registration in get_main_ref_store() and keep the rest
in register_submodule_ref_store().

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 45 ++++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/refs.c b/refs.c
index 66dc84787d..87f64271ac 100644
--- a/refs.c
+++ b/refs.c
@@ -1412,29 +1412,6 @@ static struct ref_store *lookup_submodule_ref_store(const char *submodule)
 }
 
 /*
- * Register the specified ref_store to be the one that should be used
- * for submodule (or the main repository if submodule is NULL). It is
- * a fatal error to call this function twice for the same submodule.
- */
-static void register_ref_store(struct ref_store *refs, const char *submodule)
-{
-	if (!submodule) {
-		if (main_ref_store)
-			die("BUG: main_ref_store initialized twice");
-
-		main_ref_store = refs;
-	} else {
-		if (!submodule_ref_stores.tablesize)
-			hashmap_init(&submodule_ref_stores, submodule_hash_cmp, 0);
-
-		if (hashmap_put(&submodule_ref_stores,
-				alloc_submodule_hash_entry(submodule, refs)))
-			die("BUG: ref_store for submodule '%s' initialized twice",
-			    submodule);
-	}
-}
-
-/*
  * Create, record, and return a ref_store instance for the specified
  * submodule (or the main repository if submodule is NULL).
  */
@@ -1448,7 +1425,6 @@ static struct ref_store *ref_store_init(const char *submodule)
 		die("BUG: reference backend %s is unknown", be_name);
 
 	refs = be->init(submodule);
-	register_ref_store(refs, submodule);
 	return refs;
 }
 
@@ -1457,7 +1433,25 @@ static struct ref_store *get_main_ref_store(void)
 	if (main_ref_store)
 		return main_ref_store;
 
-	return ref_store_init(NULL);
+	main_ref_store = ref_store_init(NULL);
+	return main_ref_store;
+}
+
+/*
+ * Register the specified ref_store to be the one that should be used
+ * for submodule. It is a fatal error to call this function twice for
+ * the same submodule.
+ */
+static void register_submodule_ref_store(struct ref_store *refs,
+					 const char *submodule)
+{
+	if (!submodule_ref_stores.tablesize)
+		hashmap_init(&submodule_ref_stores, submodule_hash_cmp, 0);
+
+	if (hashmap_put(&submodule_ref_stores,
+			alloc_submodule_hash_entry(submodule, refs)))
+		die("BUG: ref_store for submodule '%s' initialized twice",
+		    submodule);
 }
 
 struct ref_store *get_ref_store(const char *submodule)
@@ -1481,6 +1475,7 @@ struct ref_store *get_ref_store(const char *submodule)
 		return NULL;
 
 	refs = ref_store_init(submodule);
+	register_submodule_ref_store(refs, submodule);
 	return refs;
 }
 
-- 
2.11.0.157.gd943d85


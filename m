Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CC1C201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 14:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932700AbdBVOHE (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 09:07:04 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33644 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932608AbdBVOHC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 09:07:02 -0500
Received: by mail-pg0-f65.google.com with SMTP id 5so557816pgj.0
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 06:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CwAMHqxK5SMdPIWfJOfieHHP4NrC/Kr7/H15SGLYHlc=;
        b=bmtOAUnZjWb/K8pfR9NpCKKPEfIcgEcyzJGYHfqMF9tuUPVZ7IPKtRGTwM86Pt9qCS
         AgWmg6mjrRbDMr7lm7qtKDpxoWqPHSM1ewl+YMKQsQEFnNWH+I/lfKnbsWbHovGLjMTF
         /UTfzgVSB9c/HsnaNkh+6igSHwk0uF1Qn3hEqbdN0q6ii18oS9TjKJVj7C+7kcmN2vG8
         9mGsHi79Ttmz4sNdtjxAXSpJH3fBRmhFvSwFL9cwKjAESBzuXKDJAm/YSZW3aDQh5qxM
         AQmDG6p8Z4ghYikpvQT8NZyQk/+Fiki0TfWlw7ph7D4OK6fyWmL9TL+/Pet+n+c9/7+V
         20Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CwAMHqxK5SMdPIWfJOfieHHP4NrC/Kr7/H15SGLYHlc=;
        b=NApJ0PhtnAWhX0vu8nTeCmXtv7xCgRsb8XuNPwz4Ygrx8pHZEKhjVo+w8+mP8lgWZx
         CWdvuuoIULfDOR4l0cPj1u2FGuf/SZ7WZcuUUf9YZaZzulPEWTSQw2uVtuQO7fjUYOoB
         Rw+/5xNMob3KFsSCnB8+SteePZP4NYUxa8E0MCxK8qcQMzcZNDbwX330QcWEAa0n98uE
         R1SaE1h/68BIwnVqXR9XboalrB029QuUTtY/qoiHNL54Is0tx8Af2JbPmKckcAxEMNX3
         3Ipg61C0T64VtRW/KkqtqUrmPfzE8c1/kT8jWqtJWwL/PepixJ3ubFa4eI2rtiNRKKZJ
         Jn8w==
X-Gm-Message-State: AMke39nh983J/rRpdx3rF01XCKmW3lWlH6GTeUkEC1sFQQ7NA4nEWXu/QcUkAUsvL6zjWA==
X-Received: by 10.84.136.34 with SMTP id 31mr47794982plk.52.1487772422056;
        Wed, 22 Feb 2017 06:07:02 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id m6sm4111049pfm.22.2017.02.22.06.06.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Feb 2017 06:07:01 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 22 Feb 2017 21:06:55 +0700
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
Subject: [PATCH v5 12/24] refs.c: kill register_ref_store(), add register_submodule_ref_store()
Date:   Wed, 22 Feb 2017 21:04:38 +0700
Message-Id: <20170222140450.30886-13-pclouds@gmail.com>
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

This is the last function in this code (besides public API) that takes
submodule argument and handles both main/submodule cases. Break it down,
move main store registration in get_main_ref_store() and keep the rest
in register_submodule_ref_store().

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 50 ++++++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/refs.c b/refs.c
index c284cb4f4..6adc38e42 100644
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
 
@@ -1460,9 +1436,32 @@ static struct ref_store *get_main_ref_store(void)
 		return main_ref_store;
 
 	refs = ref_store_init(NULL);
+	if (refs) {
+		if (main_ref_store)
+			die("BUG: main_ref_store initialized twice");
+
+		main_ref_store = refs;
+	}
 	return refs;
 }
 
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
+}
+
 struct ref_store *get_ref_store(const char *submodule)
 {
 	struct strbuf submodule_sb = STRBUF_INIT;
@@ -1480,6 +1479,9 @@ struct ref_store *get_ref_store(const char *submodule)
 	if (is_nonbare_repository_dir(&submodule_sb))
 		refs = ref_store_init(submodule);
 	strbuf_release(&submodule_sb);
+
+	if (refs)
+		register_submodule_ref_store(refs, submodule);
 	return refs;
 }
 
-- 
2.11.0.157.gd943d85


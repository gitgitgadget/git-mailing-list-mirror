Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C32E2201B0
	for <e@80x24.org>; Sat, 18 Feb 2017 13:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753374AbdBRNef (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 08:34:35 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33538 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753231AbdBRNee (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 08:34:34 -0500
Received: by mail-pf0-f195.google.com with SMTP id e4so6190800pfg.0
        for <git@vger.kernel.org>; Sat, 18 Feb 2017 05:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kukVp9wGJBLfj3uptA4eFYJQAF/mxuEUzEZk4RvO0Ac=;
        b=rkmkeGqvPhgNuhnGltNoGiEoginAOvlAi5bMCPnf8QYb4SYL4wtcJ0ALWv6HZ8nug5
         M7l+Ij/IguDPQHkLyFHfnFREHtYwJNyymalM95Hu3XWrUhtQxfaOmh/1j4cur3hJApHO
         qPJRxAFf1Z0swh7ew1Qg7w9bxUaqTQ3Y0IxyLlm3T/ySfgb1gZ0LHzY0oU+RyvKE4En3
         I/cPXGmf7Vxz1NKlSmYwqYindvO9u7RuKJq3/EGaG8uWlflFRGTG2U3f71LLNDI0/9mh
         zUpRU6mSf7zfy2pDrpIHUllRBx0ilrm7si4JDKSEzfeqANCHEaZNPPCYvve1OzzpQrDc
         7ogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kukVp9wGJBLfj3uptA4eFYJQAF/mxuEUzEZk4RvO0Ac=;
        b=hAAgjy4D0n+0+CL0mbi6AKvz+COzq46T9JDUZKkXFpAPpbNr3hK4T567qjKTUfF3Mb
         SxLClKtQo9UDuvL9XSd0cYEBFXbJgBPLr/Rk6ksRtQOHU34HVs251u9QYCplnommUZco
         Rhkyi0E5Cz3HhGGDbztvhZ14tRt0MD8NngkPTnoHi362i2AQUHfkfzPIddB8v5iXiHdn
         ruO8BLY9uEj32UXzDWBnat1pc0INmT5hkGDiuVImqQiRmUeQJOVFPdPjtdqzJAtJ+Hbv
         EiFlhL7J2z4f/+IsEeIP27mrcwyDtDLmc2hdbyJFxw/wWg5I2rhAeaggfuBgQ3+WzE23
         u6EQ==
X-Gm-Message-State: AMke39nqSXa9mxSpKlywqsumwtdAfb7rLWxY18tFTB1GF3NZmYqRnCxZjj4itL5tyUZmAw==
X-Received: by 10.84.229.77 with SMTP id d13mr16819847pln.177.1487424873614;
        Sat, 18 Feb 2017 05:34:33 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id b8sm10788389pgn.6.2017.02.18.05.34.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Feb 2017 05:34:32 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Feb 2017 20:34:26 +0700
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
Subject: [PATCH v4 10/15] refs.c: kill register_ref_store(), add register_submodule_ref_store()
Date:   Sat, 18 Feb 2017 20:32:58 +0700
Message-Id: <20170218133303.3682-11-pclouds@gmail.com>
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

This is the last function in this code (besides public API) that takes
submodule argument and handles both main/submodule cases. Break it down,
move main store registration in get_main_ref_store() and keep the rest
in register_submodule_ref_store().

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/refs.c b/refs.c
index 549eeccb4..8b640bd05 100644
--- a/refs.c
+++ b/refs.c
@@ -1407,25 +1407,19 @@ static struct ref_store *lookup_submodule_ref_store(const char *submodule)
 
 /*
  * Register the specified ref_store to be the one that should be used
- * for submodule (or the main repository if submodule is NULL). It is
- * a fatal error to call this function twice for the same submodule.
+ * for submodule. It is a fatal error to call this function twice for
+ * the same submodule.
  */
-static void register_ref_store(struct ref_store *refs, const char *submodule)
+static void register_submodule_ref_store(struct ref_store *refs,
+					 const char *submodule)
 {
-	if (!submodule) {
-		if (main_ref_store)
-			die("BUG: main_ref_store initialized twice");
-
-		main_ref_store = refs;
-	} else {
-		if (!submodule_ref_stores.tablesize)
-			hashmap_init(&submodule_ref_stores, submodule_hash_cmp, 0);
+	if (!submodule_ref_stores.tablesize)
+		hashmap_init(&submodule_ref_stores, submodule_hash_cmp, 0);
 
-		if (hashmap_put(&submodule_ref_stores,
-				alloc_submodule_hash_entry(submodule, refs)))
-			die("BUG: ref_store for submodule '%s' initialized twice",
-			    submodule);
-	}
+	if (hashmap_put(&submodule_ref_stores,
+			alloc_submodule_hash_entry(submodule, refs)))
+		die("BUG: ref_store for submodule '%s' initialized twice",
+		    submodule);
 }
 
 /*
@@ -1442,7 +1436,6 @@ static struct ref_store *ref_store_init(const char *submodule)
 		die("BUG: reference backend %s is unknown", be_name);
 
 	refs = be->init(submodule);
-	register_ref_store(refs, submodule);
 	return refs;
 }
 
@@ -1454,6 +1447,12 @@ static struct ref_store *get_main_ref_store(void)
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
 
@@ -1474,6 +1473,9 @@ struct ref_store *get_ref_store(const char *submodule)
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


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DA2120136
	for <e@80x24.org>; Thu, 16 Feb 2017 11:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754996AbdBPLt6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 06:49:58 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35825 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754989AbdBPLtz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 06:49:55 -0500
Received: by mail-pf0-f196.google.com with SMTP id 68so1485754pfx.2
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 03:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=11s2EiWfxXw+pndnfpYTWapwcvghkyaM5rB9yWt1ZGc=;
        b=kWgZ38XDKyJvEKWt0axzql4Dd6ft57gooVCgUioFfUdCXjfJs7c7vXced09xHzgDS+
         8xYIv2UAMANHgf3tMhghgFdBR+k3pZBgVJC5QDMfZKS777Kll5RDTclcVt5TPSb/pqWm
         um8ygXHUF660ZG6jI0lQHCpnhZXDZ5HX3TE1effGOsRjAGarCNey/nDjxOyjMnm+DbGd
         waaFb379KmWJHuEfJ06FT+Er6cDDYYIduD28c2jdbdW0jfSukWf3fTZiEDMHi1d9WxAG
         4c1a53RN+d1z7fKKuC31hyhsD7ra5riIx6sI2AlkAqF8aPTaPYKUDeN8kWRAk5VsRS5q
         mPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=11s2EiWfxXw+pndnfpYTWapwcvghkyaM5rB9yWt1ZGc=;
        b=lXb/Kx+v+Swrm5dUOWjY2KKCdcpaoJiLtV7hqql3YDzlrKKOJdswL1qQKNl3pGkPLF
         hJ4xCrowOCDkgRuRW/ZtWNQs1KYwkP2pkkhmo7o24jPB7vrIGPDgYBLkx/eV63Kgs6NH
         IicwJ8XscliDqHzeVlrZwORNyn3btJUw8rvw5OXq+Ftqyh32yh9GU9PsUN9DkBegnaLX
         A/oqa6WqBIP4lwb3E0le08ZBwsCJwpBpNOEXAmo/0idhxUBFm+FpUOqDCelZaZUu9/Gz
         iI++M0NCp6oaErDj775qnqgHXHZpVbaQZxsQKudokFR7pmhIuA9DF2adVtSZDn1sbiIt
         W+WA==
X-Gm-Message-State: AMke39mxH9piBeT9RHSPQe9Xcba6Lbz/CoC65ezn7JPxBnnAORSQhTc79mof0NRiyg6Crg==
X-Received: by 10.84.233.193 with SMTP id m1mr2648737pln.118.1487245794883;
        Thu, 16 Feb 2017 03:49:54 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id a2sm13294537pfc.72.2017.02.16.03.49.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 03:49:54 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 16 Feb 2017 18:49:49 +0700
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
Subject: [PATCH v2 11/16] refs.c: kill register_ref_store(), add register_submodule_ref_store()
Date:   Thu, 16 Feb 2017 18:48:13 +0700
Message-Id: <20170216114818.6080-12-pclouds@gmail.com>
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

This is the last function in this code (besides public API) that takes
submodule argument and handles both main/submodule cases. Break it down,
move main store registration in get_main_ref_store() and keep the rest
in register_submodule_ref_store().

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/refs.c b/refs.c
index 76a0e7b5a..55a80a83d 100644
--- a/refs.c
+++ b/refs.c
@@ -1402,25 +1402,19 @@ static struct ref_store *lookup_submodule_ref_store(const char *submodule)
 
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
@@ -1437,7 +1431,6 @@ static struct ref_store *ref_store_init(const char *submodule)
 		die("BUG: reference backend %s is unknown", be_name);
 
 	refs = be->init(submodule);
-	register_ref_store(refs, submodule);
 	return refs;
 }
 
@@ -1449,6 +1442,12 @@ static struct ref_store *get_main_ref_store(void)
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
 
@@ -1469,6 +1468,9 @@ struct ref_store *get_ref_store(const char *submodule)
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


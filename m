Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D67FE20136
	for <e@80x24.org>; Fri, 17 Feb 2017 14:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934164AbdBQOGK (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 09:06:10 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33741 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934043AbdBQOGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 09:06:09 -0500
Received: by mail-pf0-f194.google.com with SMTP id e4so4181824pfg.0
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 06:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=11s2EiWfxXw+pndnfpYTWapwcvghkyaM5rB9yWt1ZGc=;
        b=inndEkqkVfNtEFoKqAYI3msOn5J4sAye+uaFa5G0HSnJ/7fAocTcLapnWVJ/pyF7kR
         h/kVJLCRyTW9l9VoCUUV5lw9uc4zHK4qR5qUAt+PTyWAexcn3qfqhU/JZTdSFFEE132J
         54hBoqP1NBZRFRzNqivfDsiiIXz11u8Io+8YvaUUc5Iv9ljCD23ffqrmrX93pAutXKLx
         oZ/9iiTB+7NtJP5/P4zyHnpfaceBpvKlO4jAHrvVSdbLnPaISrG9fjgXbdFwYouQrQKk
         h08QzGunCgl5u57p2+bNRRhKDm79vwq/6WlOZqAK7HU5iXhZDlNkTexZPi6jRud8L01Z
         4Gug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=11s2EiWfxXw+pndnfpYTWapwcvghkyaM5rB9yWt1ZGc=;
        b=JpAnvROLteEhR9ENpNtqqGLHAYtcQLMk5k7F8evjVQchIYfimFiy3BTl8VEECXiBr6
         0Uw+mUGThVOK5Pb16nfKmuwPuWNVS/9oiimslAK9NlYjDTE6X9LK6yX6rqBEtQQqNM5S
         We7Dy919cEK2SQZh/0Nm5wlT8MBhc505eFz3o7mRt2Ud7rUtwWVdwu0P9/0PkyLKBwQF
         HWrf1cz20ynSsfxdstppsPNSR0KF8VhVOn6JFOEoHsmhqYviHszODOle1I93InEMob5Y
         25TzCPT6+NY15x32gdUUIXMBYyTWRxJw/qz7tiEr4KUQi14zHnULpNrEnPdHILGekAzm
         Xctw==
X-Gm-Message-State: AMke39lod/vo1+Qf/vJRn+qQKKIZpgmCqzpRw+0ZBj4RNK3S2Bviz1jzku8bwOdQlBQcAA==
X-Received: by 10.98.134.2 with SMTP id x2mr9609785pfd.158.1487340368735;
        Fri, 17 Feb 2017 06:06:08 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id l25sm20032680pfb.24.2017.02.17.06.06.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 06:06:07 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 17 Feb 2017 21:06:03 +0700
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
Subject: [PATCH v3 11/16] refs.c: kill register_ref_store(), add register_submodule_ref_store()
Date:   Fri, 17 Feb 2017 21:04:31 +0700
Message-Id: <20170217140436.17336-12-pclouds@gmail.com>
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


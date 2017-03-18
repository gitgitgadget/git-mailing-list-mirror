Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9F4F2095D
	for <e@80x24.org>; Sat, 18 Mar 2017 02:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751239AbdCRCFj (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 22:05:39 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36343 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751160AbdCRCFd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 22:05:33 -0400
Received: by mail-pg0-f68.google.com with SMTP id 81so4005093pgh.3
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 19:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E6OFnfwCk4dPsnVQcVvvsmldqUesoUT6TJF3aegfNcE=;
        b=ugXQKBv/gMVyesqGvORhP7yYECrJMs22IhcLXA/S4kcasvhg8yxqejCXSMvmtGJIZc
         Y0PzVJhBrbTUqf3swu4GxsZCa2My4HFCcr9cSpSwpjYxkHQWV25AhYE5N6lMjT4Ak2pN
         XrYS97UEzdk1geFheCqRIQgOW2V8xsgIjSaIICUGcBLne940mOBZN4eG6KtJpOR+aqAU
         GB9tFE2qDpI8lrXMu0qyFDr8un4WyJDsOFgamiuBk42P8AwwVS8qFYwuZRlOsRPfw1SX
         ypDDkaou7WOJtq9qwkca3zCukXjyO05bA+FVySnYDZ0CGnv1sq4BrFByG3NRXGQLoFDD
         HGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E6OFnfwCk4dPsnVQcVvvsmldqUesoUT6TJF3aegfNcE=;
        b=TvMwm/nGwPmeVlIrcp7g2D9jxSQcZwAKmXv20FYZxJnektuZw+xN2027sb+7AzIiRS
         7+4QCz7NohMhdJI75IfarIev9m9p12fYlY/OvA0/fn0vxRWMU7wJplCI7taYpahBsWc+
         B3tADkoqUFOPztydqSz8ieLAGaRq8M4Itacb7LeiXgygoDTLfAUn8SychxZpyuC29X8q
         rvKBpdcp1EewNxm/h6FxjhjyMEoI1/qtHnofzZo++2qQRKcqk0TJIE0Eef7dN4dq3+Af
         ALHGbQFCmX2gGIHmB1iXM+U0Vqyt31fgLpnwcb6wOQe0cm8UMYYf0Sy1d9qnJysain1E
         Dsvw==
X-Gm-Message-State: AFeK/H1qHhGPPV09Pm+1AmRGBtn7qDBR1BcXwVsDoD46yvy391MPRqtlJhINB5WFdXDp+g==
X-Received: by 10.99.241.21 with SMTP id f21mr19032719pgi.16.1489802730771;
        Fri, 17 Mar 2017 19:05:30 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id t70sm18901658pfe.64.2017.03.17.19.05.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Mar 2017 19:05:30 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Mar 2017 09:05:24 +0700
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
Subject: [PATCH v6 14/27] refs.c: kill register_ref_store(), add register_submodule_ref_store()
Date:   Sat, 18 Mar 2017 09:03:24 +0700
Message-Id: <20170318020337.22767-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170318020337.22767-1-pclouds@gmail.com>
References: <20170222140450.30886-1-pclouds@gmail.com>
 <20170318020337.22767-1-pclouds@gmail.com>
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
 refs.c | 43 +++++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/refs.c b/refs.c
index f458423301..11c460c5e9 100644
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
 
@@ -1460,9 +1436,27 @@ static struct ref_store *get_main_ref_store(void)
 		return main_ref_store;
 
 	refs = ref_store_init(NULL);
+	main_ref_store = refs;
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
@@ -1484,6 +1478,7 @@ struct ref_store *get_ref_store(const char *submodule)
 		return NULL;
 
 	refs = ref_store_init(submodule);
+	register_submodule_ref_store(refs, submodule);
 	return refs;
 }
 
-- 
2.11.0.157.gd943d85


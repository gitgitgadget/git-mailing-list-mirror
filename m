Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 019E32095D
	for <e@80x24.org>; Sat, 18 Mar 2017 02:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751367AbdCRCFo (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 22:05:44 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35638 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751132AbdCRCFc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 22:05:32 -0400
Received: by mail-pf0-f195.google.com with SMTP id x63so10204956pfx.2
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 19:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Q0GE6p83v62v3BDf8pGS7L33nULBZHOIMS5yuiirs0=;
        b=WJNEtGt1AgyCamIiAkicqeeKrNLSBNvPgFCvH71ijZMhiASzFdeToXAXhW3rzURDgp
         oPbURvGnS2x8pH8btx3F7zjojUWazIsH+tUtplj249bOMIE1ZhhODaNSw3LXtZNUpE0D
         Ag4L6hK/C+NxpqsqEaNymkEWg7Y3FMxP5KLOwOSLSb/YEhNN1xcWiy6VMP0rm8brRb6d
         gQOY3Hiz46NSWeS99FQtqguctLdpN8IKGt2nzvGxZ/gSjRnMJ2B0PZCl5khNSwXHn2cv
         Xb24Z0eqSSi7r0dts+CsVtupPZ6VQHbpvlmHx/ooK3MD4KYSRnaGWtDX8URPxD61Ghfp
         pM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Q0GE6p83v62v3BDf8pGS7L33nULBZHOIMS5yuiirs0=;
        b=hLyWizAreWiGKcqovFCPg6zZwEyCorYTaBXHQf1bjP3DJtFUQG++0L1EPxyX5bw7JB
         3t8Lxa8xN9IZ6C5BpPOR5ykNQ5cRc0hVmixaO0T/GjCJoMu2MySkB7N/IJK2uh+W/0SM
         dpdKuh3jNAQEqb4PukH2ouucbpfdQiURi6Z9Lkcz5hNeGl7VjU5hVYPwsDU5AmT1uZZn
         ZJMAd/B7BDfOhVpbHWtUjvFSxhyzOOHBX0jOCa/QwD9GXGTiMBKKydzd2HrSnp27eYKV
         mpklZ96tTtpyq9yLafTjCN8Poy1+kmJ5qBWBv5xcezTW4oRu4sDWKq3LHCW4V0Zsq3QQ
         kiMQ==
X-Gm-Message-State: AFeK/H1QQNqYF92d6gqBhDWA2yyqDwwgc1ze88ZAT/87+cYDfmrH7oEhtwXcizxU4B9WGA==
X-Received: by 10.98.142.1 with SMTP id k1mr19617024pfe.98.1489802716938;
        Fri, 17 Mar 2017 19:05:16 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id w28sm1475352pge.25.2017.03.17.19.05.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Mar 2017 19:05:16 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Mar 2017 09:05:10 +0700
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
Subject: [PATCH v6 12/27] refs: rename lookup_ref_store() to lookup_submodule_ref_store()
Date:   Sat, 18 Mar 2017 09:03:22 +0700
Message-Id: <20170318020337.22767-13-pclouds@gmail.com>
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

With get_main_ref_store() being used inside get_ref_store(),
lookup_ref_store() is only used for submodule code path. Rename to
reflect that and delete dead code.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 2637353b72..818d9f0ce9 100644
--- a/refs.c
+++ b/refs.c
@@ -1395,17 +1395,13 @@ static struct ref_store *main_ref_store;
 static struct hashmap submodule_ref_stores;
 
 /*
- * Return the ref_store instance for the specified submodule (or the
- * main repository if submodule is NULL). If that ref_store hasn't
- * been initialized yet, return NULL.
+ * Return the ref_store instance for the specified submodule. If that
+ * ref_store hasn't been initialized yet, return NULL.
  */
-static struct ref_store *lookup_ref_store(const char *submodule)
+static struct ref_store *lookup_submodule_ref_store(const char *submodule)
 {
 	struct submodule_hash_entry *entry;
 
-	if (!submodule)
-		return main_ref_store;
-
 	if (!submodule_ref_stores.tablesize)
 		/* It's initialized on demand in register_ref_store(). */
 		return NULL;
@@ -1474,7 +1470,7 @@ struct ref_store *get_ref_store(const char *submodule)
 	if (!submodule || !*submodule) {
 		return get_main_ref_store();
 	} else {
-		refs = lookup_ref_store(submodule);
+		refs = lookup_submodule_ref_store(submodule);
 
 		if (!refs) {
 			struct strbuf submodule_sb = STRBUF_INIT;
@@ -1485,7 +1481,6 @@ struct ref_store *get_ref_store(const char *submodule)
 			strbuf_release(&submodule_sb);
 		}
 	}
-
 	return refs;
 }
 
-- 
2.11.0.157.gd943d85


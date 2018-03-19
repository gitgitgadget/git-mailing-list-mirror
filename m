Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F10E1FAE7
	for <e@80x24.org>; Mon, 19 Mar 2018 13:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755536AbeCSNcX (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:32:23 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55320 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933089AbeCSNcR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 09:32:17 -0400
Received: by mail-wm0-f66.google.com with SMTP id t7so2353628wmh.5
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 06:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jT79X7ResRZDCTLxQ1F7cPBkNKpVCZLDQt7GuzgYa2w=;
        b=MVFBH9OAmS6baYH1oF2ZucmfkZWoIATU56Js6MbGkQaiZQNb9qPAjSdu9TMRg22Vz8
         5iVPf9Zn883NoKkoO1nENJypFyN9asIOMAktagjhf9k14yo5IExns122A62i2sYpp2/F
         Br/ieSuZ+xE6796xpZlq0NY3N+0S4kHfD871N10IPU+HbCQnVryhjlrpJoXwBUoRtNhl
         K+6vTJCTHDuNo0vnFh8BvaFpAPXYZ8wyuImPHiEpVgoOMAPcW+WDchj4xxA8cjp8CNoP
         nY4Td/4wev3qYAFUsDettYjMWG3BmTIhRWuiORmnbkZ15HQX9+jBAQo+f4POb5EhaW76
         OH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jT79X7ResRZDCTLxQ1F7cPBkNKpVCZLDQt7GuzgYa2w=;
        b=HJTvdMDbQyXkReW5lkc9jvXFsuTeTgEpdWyaNqnKKeBNw93mbc2pyXGZ3B/xyBxHOH
         K8Oxw+F+S9DE+rvRtlF8q4mYgCnhIF1l2ZJvlGDypGtgJp6snAtVai1ZegojsoIdtqb9
         aii9i7eJtMX6e1Kc8mqBgV82y+6y38n1BR9swdWJmRm95xqtja7KxZ2UG4bfXOAXv4ET
         toaFcFewyt/Gs0rgz6xlGcmNGzHi2t3S3M8fEjeu/v5THMbGu12MmUpVjrPXPiVD9hhd
         vl2EKZIyStEp7XwBKo/xTrN3Lzr3xO2ej9ixO37xMzkkAwgZ3Flcu08WW1X4tVFx7OHT
         c7wg==
X-Gm-Message-State: AElRT7Gl9tIhQeXiS5Nf7feo8yWF1vc+C7DRpFCGA4Uix+xrQhsjw5gI
        5SBOEpIdhrD5/CQ7I5AHOHi6wRA5
X-Google-Smtp-Source: AG47ELsfrde5ayhFyW1pgjt2mq4gJghS9p3JiRUSn/XZr/D+yCTMt0i7yXc/2ETD3QtVV39mnGcuXg==
X-Received: by 10.28.185.208 with SMTP id j199mr9245593wmf.9.1521466334875;
        Mon, 19 Mar 2018 06:32:14 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id p29sm539434wmf.3.2018.03.19.06.32.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 06:32:14 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2 05/36] external-odb: implement external_odb_get_direct
Date:   Mon, 19 Mar 2018 14:31:16 +0100
Message-Id: <20180319133147.15413-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc0.37.g8f476fabe9
In-Reply-To: <20180319133147.15413-1-chriscool@tuxfamily.org>
References: <20180319133147.15413-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is implemented only in the promisor remote mode
for now by calling fetch_object().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 external-odb.c | 15 +++++++++++++++
 external-odb.h |  1 +
 odb-helper.c   | 13 +++++++++++++
 odb-helper.h   |  3 ++-
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/external-odb.c b/external-odb.c
index d26e63d8b1..5d0afb9762 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -76,3 +76,18 @@ int external_odb_has_object(const unsigned char *sha1)
 			return 1;
 	return 0;
 }
+
+int external_odb_get_direct(const unsigned char *sha1)
+{
+	struct odb_helper *o;
+
+	external_odb_init();
+
+	for (o = helpers; o; o = o->next) {
+		if (odb_helper_get_direct(o, sha1) < 0)
+			continue;
+		return 0;
+	}
+
+	return -1;
+}
diff --git a/external-odb.h b/external-odb.h
index 9a3c2f01b3..fd6708163e 100644
--- a/external-odb.h
+++ b/external-odb.h
@@ -4,5 +4,6 @@
 extern int has_external_odb(void);
 extern const char *external_odb_root(void);
 extern int external_odb_has_object(const unsigned char *sha1);
+extern int external_odb_get_direct(const unsigned char *sha1);
 
 #endif /* EXTERNAL_ODB_H */
diff --git a/odb-helper.c b/odb-helper.c
index 67196e6317..c6127ce81f 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -4,6 +4,7 @@
 #include "odb-helper.h"
 #include "run-command.h"
 #include "sha1-lookup.h"
+#include "fetch-object.h"
 
 struct odb_helper *odb_helper_new(const char *name, int namelen)
 {
@@ -52,3 +53,15 @@ int odb_helper_has_object(struct odb_helper *o, const unsigned char *sha1)
 	return !!odb_helper_lookup(o, sha1);
 }
 
+int odb_helper_get_direct(struct odb_helper *o,
+			  const unsigned char *sha1)
+{
+	int res = 0;
+	uint64_t start = getnanotime();
+
+	fetch_object(o->dealer, sha1);
+
+	trace_performance_since(start, "odb_helper_get_direct");
+
+	return res;
+}
diff --git a/odb-helper.h b/odb-helper.h
index e3c9c1cfe4..57b14fe814 100644
--- a/odb-helper.h
+++ b/odb-helper.h
@@ -20,5 +20,6 @@ struct odb_helper {
 extern struct odb_helper *odb_helper_new(const char *name, int namelen);
 extern int odb_helper_has_object(struct odb_helper *o,
 				 const unsigned char *sha1);
-
+extern int odb_helper_get_direct(struct odb_helper *o,
+				 const unsigned char *sha1);
 #endif /* ODB_HELPER_H */
-- 
2.17.0.rc0.37.g8f476fabe9


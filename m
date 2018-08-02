Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACF60208E9
	for <e@80x24.org>; Thu,  2 Aug 2018 06:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbeHBIFF (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 04:05:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41737 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbeHBIFF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 04:05:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id j5-v6so859800wrr.8
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 23:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gsg4Zw9AYILSYK+jJhK5Z78q1mpQLd14VNFwaRjEVRQ=;
        b=ptQ1HB+RZg/uJsiz721Pmai5PGHZfZVfUsv7jlE0aeHpraC4ZDHjejo9If+xUrdzgl
         c8oUMPQNQXVfFO8SF0Ek/8ET/i2LPQ7z9QhCdTos8tKjs3cjqUvdhdqrfg4g2msNeXpI
         SnO5tD1ii/+04McaXUMqvQe3+PKsPpTvIwWLUloYHBTlD8Xs5QjAaKjovL5LjXzEUXN6
         ZR3tnX2Z2rypiwd56TG3+hYnnvovljtarteEOcYBX93Xrr5TQtDXNNHmnimuzb5OfzpP
         wW/aggoaJ4bOwIFr/2jOr30ypK+Xz9Ym+np11ngau6OarJs02zt+573euMaliiAEzljG
         hqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gsg4Zw9AYILSYK+jJhK5Z78q1mpQLd14VNFwaRjEVRQ=;
        b=Gmu+k56Jn94ExVztFcFENQQHAsF+Du++++PDSLFbpCI9UILFtZVkAvWPfGNTj8kmZO
         KvSmiq++Z6BSzpbaq7GYyUfVeydPlTm8ZJBu33OHktu1kGjGLpPQ++RqbqanytnBnScj
         63nmH6L3SY8UKz8EowkR1LmyrnjI573UL4KcyBDwHwucmwGWb3DRtBF3CM2qZTsG259K
         9ePyEQqHCpT99K0kjth5TL2RQ3/FIybLmMd6VOZ48cmgpptnWpZjQX91gxAlbA0kF/V/
         Irf6eXiE4/WpdK6Lta85Nb8/BfjnEC/mzG9jTrKHksS+44hj3jeop8ncsfyViBQ+Wgu6
         EtQw==
X-Gm-Message-State: AOUpUlE3NkJFjwMEcm2XWPmvPl9klPgAv7RHuwQQtghAsdW612G7HVtl
        rQ3R6QCaVyHElxAUSNHtlTEEQGa/
X-Google-Smtp-Source: AAOMgpduNkEmJHAf+zuVUr03+tSpeug3nNAXwH6biwbwRZdmhoQJo4GwRfgOHEQnb1rhVnf3brcI7A==
X-Received: by 2002:adf:fc45:: with SMTP id e5-v6mr895997wrs.157.1533190532302;
        Wed, 01 Aug 2018 23:15:32 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:109f:b149:1092:6e1:496b:fd26])
        by smtp.gmail.com with ESMTPSA id m200-v6sm1093018wma.32.2018.08.01.23.15.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 23:15:31 -0700 (PDT)
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
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 1/9] fetch-object: make functions return an error code
Date:   Thu,  2 Aug 2018 08:14:57 +0200
Message-Id: <20180802061505.2983-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.330.g17eb9fed90
In-Reply-To: <20180802061505.2983-1-chriscool@tuxfamily.org>
References: <20180802061505.2983-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

The callers of the fetch_object() and fetch_objects() might
be interested in knowing if these functions succeeded or not.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 fetch-object.c | 15 +++++++++------
 fetch-object.h |  6 +++---
 sha1-file.c    |  4 ++--
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/fetch-object.c b/fetch-object.c
index 48fe63dd6c..3c52009266 100644
--- a/fetch-object.c
+++ b/fetch-object.c
@@ -5,11 +5,12 @@
 #include "transport.h"
 #include "fetch-object.h"
 
-static void fetch_refs(const char *remote_name, struct ref *ref)
+static int fetch_refs(const char *remote_name, struct ref *ref)
 {
 	struct remote *remote;
 	struct transport *transport;
 	int original_fetch_if_missing = fetch_if_missing;
+	int res;
 
 	fetch_if_missing = 0;
 	remote = remote_get(remote_name);
@@ -19,18 +20,20 @@ static void fetch_refs(const char *remote_name, struct ref *ref)
 
 	transport_set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
 	transport_set_option(transport, TRANS_OPT_NO_DEPENDENTS, "1");
-	transport_fetch_refs(transport, ref, NULL);
+	res = transport_fetch_refs(transport, ref, NULL);
 	fetch_if_missing = original_fetch_if_missing;
+
+	return res;
 }
 
-void fetch_object(const char *remote_name, const unsigned char *sha1)
+int fetch_object(const char *remote_name, const unsigned char *sha1)
 {
 	struct ref *ref = alloc_ref(sha1_to_hex(sha1));
 	hashcpy(ref->old_oid.hash, sha1);
-	fetch_refs(remote_name, ref);
+	return fetch_refs(remote_name, ref);
 }
 
-void fetch_objects(const char *remote_name, const struct oid_array *to_fetch)
+int fetch_objects(const char *remote_name, const struct oid_array *to_fetch)
 {
 	struct ref *ref = NULL;
 	int i;
@@ -41,5 +44,5 @@ void fetch_objects(const char *remote_name, const struct oid_array *to_fetch)
 		new_ref->next = ref;
 		ref = new_ref;
 	}
-	fetch_refs(remote_name, ref);
+	return fetch_refs(remote_name, ref);
 }
diff --git a/fetch-object.h b/fetch-object.h
index 4b269d07ed..12e1f9ee70 100644
--- a/fetch-object.h
+++ b/fetch-object.h
@@ -3,9 +3,9 @@
 
 #include "sha1-array.h"
 
-extern void fetch_object(const char *remote_name, const unsigned char *sha1);
+extern int fetch_object(const char *remote_name, const unsigned char *sha1);
 
-extern void fetch_objects(const char *remote_name,
-			  const struct oid_array *to_fetch);
+extern int fetch_objects(const char *remote_name,
+			 const struct oid_array *to_fetch);
 
 #endif
diff --git a/sha1-file.c b/sha1-file.c
index de4839e634..c099f5584d 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1312,8 +1312,8 @@ int oid_object_info_extended(struct repository *r, const struct object_id *oid,
 		if (fetch_if_missing && repository_format_partial_clone &&
 		    !already_retried && r == the_repository) {
 			/*
-			 * TODO Investigate having fetch_object() return
-			 * TODO error/success and stopping the music here.
+			 * TODO Investigate checking fetch_object() return
+			 * TODO value and stopping on error here.
 			 * TODO Pass a repository struct through fetch_object,
 			 * such that arbitrary repositories work.
 			 */
-- 
2.18.0.330.g17eb9fed90


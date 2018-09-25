Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CCA01F457
	for <e@80x24.org>; Tue, 25 Sep 2018 11:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbeIYSBP (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 14:01:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32850 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbeIYSBO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 14:01:14 -0400
Received: by mail-wr1-f65.google.com with SMTP id f10-v6so2019453wrs.0
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 04:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l8Za3NKR6YbHuyVKGcB9opNA75jNvx1ISXPuaGiDZUI=;
        b=IuEfQv0Ee7SAc++CIA4W1l83zbzfp8X8SO0GlGj87old60gkSzCpeZGME+RYxZfPC4
         9dVA0/zf9kPB2dA9m11biBnlXU/1JQ5Ac97/toFxEy8MQILqFYALPcWv5Yuo3C78fsam
         H9HJl1tmlzNSkK86qEX6yzJa11FofHEB/AIncfLlp7qk10pujqEpV4mq6SEPaBma2S0C
         COGuqDT63dFrmF8UlDZAsHARRGNpnVHKmpDRTuojIdieorFw0b98yZ1Td58XqcQxN6NL
         5rAlGk7sIWXsSX7Er3JSXDxZuPtbE7lrJx5Igq7Sk1Ano6UXEXGu0VFIHAFG0PGQQWvy
         RidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l8Za3NKR6YbHuyVKGcB9opNA75jNvx1ISXPuaGiDZUI=;
        b=pR7XIcSJJwq0GIHe3xyOCjqndCCs1mGVmrKSI46AAhVrSaUTdq3lCfW+i2qXdNGnaR
         799mA0GsARl6dZ3e25hknyJ+3/v6ApCv7kigcePR1hy2ygmjoAsTn/e2Sl9wC7nENbAA
         rXJO1comfS85zlZQRERCdSXufo77HulvG58rRvl7O4kdnZhstzrH996q9Vg3pWThTSUb
         4HDJL/wuAKQtb0IGXKJDRvywVBvzKA6/wXNfBgmNn3cF7FPErUS2iF/yQSVkieDxpk6g
         wSy2LGjJoDxcZOAp2Yy7iwwEsDeODvY8bmhocxtzd9om8dhu/3uE20zJvFyO18unT6sT
         rvgg==
X-Gm-Message-State: ABuFfogMxDn3ImzzW4TfPdwD62c4wST53/iui/PLtTD9xT32AtuYBQ1Z
        95iXx1NbRNdTxRCfhxNjc1jFbSyV
X-Google-Smtp-Source: ACcGV63w/CRCue7ucxYiJkZjjZCuu1bVFuQ2uB8dksJz6s7vqudRN59YJ4IBXkSgsgnF99twCSuZTg==
X-Received: by 2002:adf:df09:: with SMTP id y9-v6mr633088wrl.26.1537876442444;
        Tue, 25 Sep 2018 04:54:02 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id z14-v6sm1998628wrr.91.2018.09.25.04.54.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 04:54:01 -0700 (PDT)
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
Subject: [PATCH v5 1/8] fetch-object: make functions return an error code
Date:   Tue, 25 Sep 2018 13:53:34 +0200
Message-Id: <20180925115341.19248-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.19.0.278.gca5b891cac
In-Reply-To: <20180925115341.19248-1-chriscool@tuxfamily.org>
References: <20180925115341.19248-1-chriscool@tuxfamily.org>
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
 fetch-object.c | 13 ++++++++-----
 fetch-object.h |  4 ++--
 sha1-file.c    |  4 ++--
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/fetch-object.c b/fetch-object.c
index 4266548800..eac4d448ef 100644
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
@@ -19,12 +20,14 @@ static void fetch_refs(const char *remote_name, struct ref *ref)
 
 	transport_set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
 	transport_set_option(transport, TRANS_OPT_NO_DEPENDENTS, "1");
-	transport_fetch_refs(transport, ref);
+	res = transport_fetch_refs(transport, ref);
 	fetch_if_missing = original_fetch_if_missing;
+
+	return res;
 }
 
-void fetch_objects(const char *remote_name, const struct object_id *oids,
-		   int oid_nr)
+int fetch_objects(const char *remote_name, const struct object_id *oids,
+		  int oid_nr)
 {
 	struct ref *ref = NULL;
 	int i;
@@ -36,5 +39,5 @@ void fetch_objects(const char *remote_name, const struct object_id *oids,
 		new_ref->next = ref;
 		ref = new_ref;
 	}
-	fetch_refs(remote_name, ref);
+	return fetch_refs(remote_name, ref);
 }
diff --git a/fetch-object.h b/fetch-object.h
index d2f996d4e8..8cc8c14b9d 100644
--- a/fetch-object.h
+++ b/fetch-object.h
@@ -1,7 +1,7 @@
 #ifndef FETCH_OBJECT_H
 #define FETCH_OBJECT_H
 
-void fetch_objects(const char *remote_name, const struct object_id *oids,
-		   int oid_nr);
+int fetch_objects(const char *remote_name, const struct object_id *oids,
+		  int oid_nr);
 
 #endif
diff --git a/sha1-file.c b/sha1-file.c
index a4367b8f04..5c44873d37 100644
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
2.19.0.278.gca5b891cac


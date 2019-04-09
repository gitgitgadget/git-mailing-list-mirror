Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 574C42032D
	for <e@80x24.org>; Tue,  9 Apr 2019 16:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfDIQLr (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 12:11:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55439 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfDIQLq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 12:11:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id o25so4223552wmf.5
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 09:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lEqc80MujqU7+JHs/Mji93LdoiHFAZ2tq0Zg1HbubbI=;
        b=gkK6X6xGMj0zvw7weqepR+hLzOxTzwyhv+ORaftdjJFkgH4i98vFF1S5INbGWEQyN3
         BmtSJpmt/fbfcOIux523IDAXeypULGE+FmRcXEI9LlalpzYv+ZEGYCs2M/WnY6C/eM3j
         wPiIT8HeZ8qnv71Po5JRs4zcji19VCZstOXH8mLtUac5ZZGi1iq/NQlRoYWk3jyo/cAP
         MV/8A1cluxJ/xFY+XQXfUEe30OTzWBH9yScQgqpv+C3uM3A0Ua57c94mPyy5zcGOaWeR
         F7doejyAtsvT5fSXvEiuU7rHYxmJ2R66stlZbsyq1vJSmdXYxpglEzZY1qF4rxghgomp
         q2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lEqc80MujqU7+JHs/Mji93LdoiHFAZ2tq0Zg1HbubbI=;
        b=MXRfbn0+30t7binEGC8ZEEy6qmp/GKyYPuonm93Dss4def4I2g3gpxEfDgFMSUExAX
         pZDi6JSWc7eCp372TDhhLCn6AoE8HN3Sk21gT63tH+tzXCIdAMLyL2yDw9CrxDXH+qVp
         RuipFH+x1TgUM5Xc8lBYYZ5X7JIfvrvTGwDn8Mz6ZVWW+6okLNEfw7mhAhGFfOEo1JwF
         xcYMdOAQheLfNU6C2lJVev5k1IMrvR5s7+oM/CZzTN8cWT5hMP33YSfMKlClw86IJ2vs
         TxD0zezYzKjb0znlla+51d8UBdGd0JdHEluL+ttVDkcDGSlhk7GQaVkBLy0eRrrW7UNH
         NgBQ==
X-Gm-Message-State: APjAAAW0ezbjkU2E+XBN7E50joXI56yMofz4OkB61lXfbYY/+0Y3QpTH
        ioO8dczCr7+KZ6ks9/Yvr0/KmGkL
X-Google-Smtp-Source: APXvYqwyZazLjARVmpPAbohUezUPtqZDdrbwKPoKRRPUySFyCjgkuTsiFMz/FymFrTkGhxnmo+zrwQ==
X-Received: by 2002:a1c:f115:: with SMTP id p21mr21966969wmh.93.1554826303619;
        Tue, 09 Apr 2019 09:11:43 -0700 (PDT)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id i2sm4356012wmg.47.2019.04.09.09.11.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 09:11:42 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 02/16] fetch-object: make functions return an error code
Date:   Tue,  9 Apr 2019 18:11:02 +0200
Message-Id: <20190409161116.30256-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.750.g68c8ebb2ac
In-Reply-To: <20190409161116.30256-1-chriscool@tuxfamily.org>
References: <20190409161116.30256-1-chriscool@tuxfamily.org>
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
index d6444caa5a..7bcc7cadb0 100644
--- a/fetch-object.h
+++ b/fetch-object.h
@@ -3,7 +3,7 @@
 
 struct object_id;
 
-void fetch_objects(const char *remote_name, const struct object_id *oids,
-		   int oid_nr);
+int fetch_objects(const char *remote_name, const struct object_id *oids,
+		  int oid_nr);
 
 #endif
diff --git a/sha1-file.c b/sha1-file.c
index ad02649124..83358737f3 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1373,8 +1373,8 @@ int oid_object_info_extended(struct repository *r, const struct object_id *oid,
 		    !already_retried && r == the_repository &&
 		    !(flags & OBJECT_INFO_FOR_PREFETCH)) {
 			/*
-			 * TODO Investigate having fetch_object() return
-			 * TODO error/success and stopping the music here.
+			 * TODO Investigate checking fetch_object() return
+			 * TODO value and stopping on error here.
 			 * TODO Pass a repository struct through fetch_object,
 			 * such that arbitrary repositories work.
 			 */
-- 
2.21.0.750.g68c8ebb2ac


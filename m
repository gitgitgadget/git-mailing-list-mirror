Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9EE01F4BB
	for <e@80x24.org>; Tue, 25 Jun 2019 13:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbfFYNlL (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 09:41:11 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37158 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729846AbfFYNlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 09:41:09 -0400
Received: by mail-ed1-f65.google.com with SMTP id w13so27250282eds.4
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 06:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hKffiI0+5tfnysJsQyQSk/CillMAkAJj8w4TB7sLADQ=;
        b=tjk546hVBf3QSc5Yc8HR05oBeCkuAzohDgFhooZc4dHhIefD2frG/eMjeQMjxlp+wB
         ZsPjXRZBE2535hw2IpdF8l98eXC6k8u2vdAK049/TayZEo3qHKDBydYMcDu/pLK78lzR
         fLJ/ayGEvpWPbK8Sv/l1rVLNXB38Z+uSfoGPq2qSUh2ZkIfEMqrjRLbp/xvd2ZisZiPi
         YkKyqkelAcX2yH6thfd8mMrcBYxCH8fW+qnhXzJ6dXwIVu4FuYkqBCqUKc36m+WG2g2o
         f/AY3zRYCfewQaWIfTk2OX5cex4bL+JBAebvCNa3xZg7ChYPBYe0w/JuSNKCK0SSIiU9
         v0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hKffiI0+5tfnysJsQyQSk/CillMAkAJj8w4TB7sLADQ=;
        b=pAt8mfw7k55nU4799wwEyFc0Secft4aHwxdtmfXDjnpbmKiHamYMY5QsL3bi/Zrd/r
         YEXXn3bstvby6kiEFSvGzVBbsn4HzVtptKTdIgx6Lp3yx03IIK47gb53QVArNAwrsZEl
         TeaB979S1Fn5mcaSSAs5TRmSp/AnjxGSQ0mTStjYLxVbA4Bedwbdc7BSUfAYTsl78JW5
         pYThmBjGj0EFpKaiZR/V8FgHi/XkLnh8wdoFYJpCGMm4LPIn91wcmh7GMRcH31kTlwhy
         q/1CcvEpGKBVFogYcjydn4G1e0OVkNJRidB+/74ji4L1aYKBpJAQzXl+zaPOAXj/Hu06
         4xPw==
X-Gm-Message-State: APjAAAXFfoAMWIy05opPGxMdv6wqjZbCEbGXpcauUVDioMjYwTT4XiiU
        4h+AUVYDmubK2H9iK2PVrFBTJaMxaio=
X-Google-Smtp-Source: APXvYqyxZr/cfvGghIg5gDOm4KiAcOy511p5W0v1y0d/RfOO5J0AQpVbbnz4FwanT+0AW540bsww7Q==
X-Received: by 2002:a50:ad45:: with SMTP id z5mr148602841edc.21.1561470067829;
        Tue, 25 Jun 2019 06:41:07 -0700 (PDT)
Received: from ubuntu-N150ZU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id v11sm2448445ejx.24.2019.06.25.06.41.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 06:41:07 -0700 (PDT)
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
        Derrick Stolee <stolee@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 02/15] fetch-object: make functions return an error code
Date:   Tue, 25 Jun 2019 15:40:26 +0200
Message-Id: <20190625134039.21707-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.229.ga13d9ffdf7.dirty
In-Reply-To: <20190625134039.21707-1-chriscool@tuxfamily.org>
References: <20190625134039.21707-1-chriscool@tuxfamily.org>
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
index 888b6024d5..819d32cdb8 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1381,8 +1381,8 @@ int oid_object_info_extended(struct repository *r, const struct object_id *oid,
 		    !already_retried && r == the_repository &&
 		    !(flags & OBJECT_INFO_SKIP_FETCH_OBJECT)) {
 			/*
-			 * TODO Investigate having fetch_object() return
-			 * TODO error/success and stopping the music here.
+			 * TODO Investigate checking fetch_object() return
+			 * TODO value and stopping on error here.
 			 * TODO Pass a repository struct through fetch_object,
 			 * such that arbitrary repositories work.
 			 */
-- 
2.22.0.229.ga13d9ffdf7.dirty


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 246451F90A
	for <e@80x24.org>; Fri, 13 Jul 2018 17:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731397AbeGMSF7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 14:05:59 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36320 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731305AbeGMSF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 14:05:59 -0400
Received: by mail-wm0-f66.google.com with SMTP id s14-v6so10188326wmc.1
        for <git@vger.kernel.org>; Fri, 13 Jul 2018 10:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YexLwFrRDb80DYIww50pgZTau9Y5zmK3oS2VRwwYhbo=;
        b=diphR8pkU0zVAoxZ4ElMvFSB+C7nkj5hSYejXOiCkqNdM2JFDJFsX7MfGo0fpBwght
         nH5WYUSw/fTlWeB8k5sarXTz4QNAippeojpvXRELTIGmel/R+AjhqBpXHwgWhJBf16eA
         xBxttpbL6EA9xZ2qCNDfhoNdwAaC2KsckmDAFcvPbXQ4F0bqGESTIkXb3GgEfB0m3toi
         LB+yj+tF3gyBD+GBmICj4z0hfDLRjjIxMw4aazmU8BWRWNw+9aQhup0q7Uu+Yo0KJH07
         NliXWPxz95pOnabPaM1jUqvjoc+B6L/nwMEpdKEBlQg+2oFg6NoDITXga5VInkBVT533
         WPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YexLwFrRDb80DYIww50pgZTau9Y5zmK3oS2VRwwYhbo=;
        b=fVO6z18nWqrg09CTEP++kQyw6/W7ApjgmdFAWnZd3FLucL6FhC3ogSFq2Av7RyfNqc
         50WHlpRTsrudtOs4Xgc75vClnIdMolQCxcF35XDSJd52PjEfr8+ILH/UPOwMh+v5fPEm
         yXrDmRuLuoZha08ihhhv9nzGszcwW2A0ZQX/yxPHVHHJ7NzQdPsIaf9q94KyxlP+D165
         iS1jI7/Rn+k1jspYUy4mhH3sC52n0dLMMy9bCMdrxvhf625Vi/NpK2WUyBvv6bxOMcwW
         MLNDiLa4XWm+bXQ6zzIv8zcnMOTmm2obhdXGOQrevA7DdjclhG16Ma0A7ooq0qwRqKVJ
         0BbQ==
X-Gm-Message-State: AOUpUlHk2AvrTTKmjy6vOeLpHFDagv2a4n8eJ/BLbbLpad0B1tqPhrWi
        6vv96XVY3+srnwbIUYgNFmDq/rfP
X-Google-Smtp-Source: AAOMgpeRU34OZr656XL51MZpAaB10HdAIfihnofsGhDNix3dl3m9dEsK5GH7Nl89TXY39aLx7Jy9UQ==
X-Received: by 2002:a1c:d0ce:: with SMTP id h197-v6mr4288985wmg.97.1531504218912;
        Fri, 13 Jul 2018 10:50:18 -0700 (PDT)
Received: from localhost.localdomain (188.10.112.78.rev.sfr.net. [78.112.10.188])
        by smtp.gmail.com with ESMTPSA id v15-v6sm6556862wmc.16.2018.07.13.10.50.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 10:50:18 -0700 (PDT)
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
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 1/9] fetch-object: make functions return an error code
Date:   Fri, 13 Jul 2018 19:49:51 +0200
Message-Id: <20180713174959.16748-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.138.g7076a5fae1
In-Reply-To: <20180713174959.16748-1-chriscool@tuxfamily.org>
References: <20180713174959.16748-1-chriscool@tuxfamily.org>
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
index 853624f811..ccc4ea7f1a 100644
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
-	transport_fetch_refs(transport, ref);
+	res = transport_fetch_refs(transport, ref);
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
2.18.0.171.ge260395bfe


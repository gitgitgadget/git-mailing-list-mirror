Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BD791F516
	for <e@80x24.org>; Sat, 23 Jun 2018 12:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751966AbeFWMTx (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Jun 2018 08:19:53 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:33427 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751896AbeFWMTE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jun 2018 08:19:04 -0400
Received: by mail-wr0-f172.google.com with SMTP id k16-v6so9151662wro.0
        for <git@vger.kernel.org>; Sat, 23 Jun 2018 05:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=losfye5nIbJSg188DylgZfBlt+cTFsp7b+sgctRYF2g=;
        b=DLnWBNA+KcCESZxeitO+9yBDQMmdBxk6bShXgEFQOA4Bt9f8gGavyMECE5r+5rjN9R
         4LYIY9m841Lgpzi6hGqu/WVd/cMtmDCOrD4/+TKEQnlC5R4p9vr/TQZ/NCcFkyNLPmD4
         H1jPaRid+dzfXuEO9HfkoS3R6Cri1FIA3tsseMIVE/pY3FGoC3qoPQQYDLrfHYQ//p1g
         j/LQga2e3RLer0/S1cS1Fh+JiOOxu+rYy0xLru1ZfBDBit8cyDi1OY5RlyFAnCReTM5/
         EcPoJ8hINey4jP1Qj89kaX/898LE0Erv3jHZkkSvj+BIwmqClBxet531frCHVLY/W1It
         sknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=losfye5nIbJSg188DylgZfBlt+cTFsp7b+sgctRYF2g=;
        b=OMVbgV/36pF4Ahysd5kZIqqHXqcDY6W1IQCPfxc7GZj4PytuSkH9aKWog4DvpfdJOm
         Be0DRdvYg0zB7DkTrLpXSReIA1uU8aieMVshxmT5VnNSHjUHTnmPdqpEPPSN2V7rwpmo
         KsxP2OlO0DZdOeyEUSBixWSUJKki9yBjmf0mq0AQM+zl5nIED1XThGVRvUmEZNv72HW1
         Cpz2rym17z9OalUM6aOTyEq3x7u6eZaENUald/HlTL5cUm89RwSPCmdMpT8tDfxO406h
         DZqS29IUAHi3xXK61UbQssGg8lrt2w5Vz48/FlHNzg7xmqBTqjuCsN5IJXgy+QUqytWs
         7bLg==
X-Gm-Message-State: APt69E1LFaEyKUjxP6KelEePzmoPVIDe5mPKpVMojn/TcmgVc3MK/5JG
        AXTImf296BIjFa+T9fmVmFRBQxJX
X-Google-Smtp-Source: ADUXVKIT970d2WFjMBW3WfEO80SetKk4ahtsomauDO7KLsh0LG4VQ1wuUd82Zsqse5yybHU5gpGWQg==
X-Received: by 2002:adf:a4cf:: with SMTP id h15-v6mr4798080wrb.130.1529756342545;
        Sat, 23 Jun 2018 05:19:02 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id q14-v6sm5527731wmd.20.2018.06.23.05.19.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jun 2018 05:19:01 -0700 (PDT)
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
Subject: [PATCH v1 01/11] fetch-object: make functions return an error code
Date:   Sat, 23 Jun 2018 14:18:38 +0200
Message-Id: <20180623121846.19750-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.762.g886f54ea46
In-Reply-To: <20180623121846.19750-1-chriscool@tuxfamily.org>
References: <20180623121846.19750-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The callers of the fetch_object() and fetch_objects() might
be interested in knowing if these functions succeeded or not.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
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
index 695e5c6276..374a56d0e1 100644
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
2.17.0.762.g886f54ea46


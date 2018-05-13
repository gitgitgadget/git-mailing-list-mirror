Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F8C21F42D
	for <e@80x24.org>; Sun, 13 May 2018 10:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751219AbeEMKc6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 06:32:58 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34008 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbeEMKc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 06:32:56 -0400
Received: by mail-wm0-f68.google.com with SMTP id a137-v6so8095434wme.1
        for <git@vger.kernel.org>; Sun, 13 May 2018 03:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U8DfB1KPqFOaGq0nvENgWpi8g7rpY7waZsvHJhm/MAA=;
        b=PbZJCbOYBceI8wKTWmuBtLi+xUGwYPUv/a022+M3pWOsX9E3FBtIfChqVneHCHQKNi
         U2SrMgBSzxgmWeqM8vuHu+wbMiWCREZ+wUMa3Z9QGXqLzCAuckUcTMk+9SUsNy+3TaD4
         FUIIYbIKSDJJXHXAJY+bRsSUlBnelU9Ox2qXn/1pKoMyr4+1i33dquqMNoJF/MTbUpcK
         r5KEHEQFeG3e8UWgorPAbUU1EixHTsYYiwvsmN/gx9LD0kRpRFn4F0HZp8EFCwE1BuPD
         QXJYtBfKT1MO/O1+jhP3eSaWH4BTACNYKZ/TRiCTQ8FkXnuM2jCKHnvW809S74fmnNxH
         U63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U8DfB1KPqFOaGq0nvENgWpi8g7rpY7waZsvHJhm/MAA=;
        b=YqIwhuZN2vIsFomaCD11suXQLCM5OHemA2rhXcUNXJGeYkagjoN5bs3eXVWo3w7KWN
         Ipuhqsm/U5+MsnEAlPeptmKTa9wn9e7RAPMXiSIpZWtSP+wUd2Z9WJoWij7+CIKPbgnp
         jwbxgvGmQRmVCt93tRBHMOm+zqlnLXAWQiTLr9l84M5HWiPYHV3pCITBLmX8hj55m2Jh
         BqzzbepmFfmG18W5UX/g3dOtbMMamXunkK47iEiHkThxxtHziac8lVE/vd6ll0pWGqQ3
         0M6g7apIT1W1zM/St/JVXsEajjo+P2ba0XcXF6/hTtAs0bWVZsv3T89bXXtQHhkxcbqx
         dwtQ==
X-Gm-Message-State: ALKqPwfUFJU93PdkXsFuARoR1v5H1PygtoxE402Kxh2CN3HjWHOBoCWs
        AYP/Lx7hdLCyJ9IhOYPGfiIUYZ1i
X-Google-Smtp-Source: AB8JxZqBVCGwBUCt81Q8Nu0KzHmzv9yJxdyVNCI0XiZtIQepzXppZ0UFjNB+SVrPNBJuoST3/w0Tow==
X-Received: by 2002:a1c:7e87:: with SMTP id z129-v6mr2887966wmc.131.1526207574830;
        Sun, 13 May 2018 03:32:54 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id t203-v6sm6886375wmt.33.2018.05.13.03.32.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 May 2018 03:32:54 -0700 (PDT)
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
Subject: [PATCH v1 1/8] fetch-object: make functions return an error code
Date:   Sun, 13 May 2018 12:32:25 +0200
Message-Id: <20180513103232.17514-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.590.gbd05bfcafd
In-Reply-To: <20180513103232.17514-1-chriscool@tuxfamily.org>
References: <20180513103232.17514-1-chriscool@tuxfamily.org>
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
index 46072602ff..7d3c1ebd91 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1290,8 +1290,8 @@ int oid_object_info_extended(const struct object_id *oid, struct object_info *oi
 		if (fetch_if_missing && repository_format_partial_clone &&
 		    !already_retried) {
 			/*
-			 * TODO Investigate haveing fetch_object() return
-			 * TODO error/success and stopping the music here.
+			 * TODO Investigate checking fetch_object() return
+			 * TODO value and stopping on error here.
 			 */
 			fetch_object(repository_format_partial_clone, real->hash);
 			already_retried = 1;
-- 
2.17.0.590.gbd05bfcafd


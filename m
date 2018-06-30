Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CCBB1F62E
	for <e@80x24.org>; Sat, 30 Jun 2018 08:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933694AbeF3IgJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 04:36:09 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:50964 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752612AbeF3IgD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 04:36:03 -0400
Received: by mail-wm0-f45.google.com with SMTP id v25-v6so3339240wmc.0
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 01:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wF/GhViYjouAhD/i+tKCNWFjEy1kaB80X/BJUrdkjYk=;
        b=NU+1pa4ZCO9nXqOgPooZkglnB6Ov+8xSHf7chqRxBpWoVOg3prF6x2Nsqa0J5hrgyJ
         XRLeQBOD/Q9kXSBlnQss6t2N2MTsdK7kcrpW52APTOsXyn2Y0JyWUoJfZ2NFIs7MWWZs
         NsbDhWLiWy4babPQVlEZgSRFnKQ214dQ6uTGhxmVVp/8B1wWDnqMK8N1MVVt5PUuzvHQ
         +i7mW0Lw2Ra9JaPIoHFixGSYvH6kD8U7adwoz2SR/pablb+qkDWaIBkir9J8xT5c1AeB
         j1SUYaDi9ngz+2pQ6rsP61OvrZ2wLPiIA6nsICs1/D3UNlFYDLCn4v0NdDK26Sm8NDPt
         bHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wF/GhViYjouAhD/i+tKCNWFjEy1kaB80X/BJUrdkjYk=;
        b=bY96izREaqigekGFlr8CtAJ2CpOmP/b4veLYp21UFQDm60tUGUOTXhVuNjUR/7S5LF
         Y8mMCRWN/fVkihqSFHquf2/BoEnMr+LZWzrOs7Aysw+q22PrdoNxUyHe4dXZ7G2oE74i
         lfAFlafh9r1b7Hh1Q86inN26Bak7R44v7PqL78kf/oGVUmredUE+fOe7ChO4HD7MEr7Y
         fHivtTyU4ioDz5c3twFs3Htn0gvR8c3T5HEhtMmXHbAd4E/JTnSedCsPWdDnWKbyFZEF
         HC2myBX87Vaoi+rYm54RdvETI8yYe8DC1+HrdFXiuu2nV+MIn3BqTZ3C911OmXfBn6aT
         NU+w==
X-Gm-Message-State: APt69E3IF4/Rx1eBRlf97vXtiOMTYKYyu0Eccx8RmJMGrua+dC78IcIg
        IWFSNELpL3RFFv+ZX3TXmxJoi6h8
X-Google-Smtp-Source: AAOMgpfBraBiPomR0CDiRDnzoO1TSba11t7wrvZsFNECbfZ9w6X2Dc6X3PKf/pk77Xg/lvJ93783/w==
X-Received: by 2002:a1c:ab02:: with SMTP id u2-v6mr3826144wme.10.1530347762302;
        Sat, 30 Jun 2018 01:36:02 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id u70-v6sm5338356wmd.3.2018.06.30.01.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 01:36:01 -0700 (PDT)
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
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/9] fetch-object: make functions return an error code
Date:   Sat, 30 Jun 2018 10:35:34 +0200
Message-Id: <20180630083542.20347-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.138.g8117677157
In-Reply-To: <20180630083542.20347-1-chriscool@tuxfamily.org>
References: <20180630083542.20347-1-chriscool@tuxfamily.org>
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
2.18.0.138.gac082779dc


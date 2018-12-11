Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A48620A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 05:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbeLKF2J (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 00:28:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39808 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbeLKF2I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 00:28:08 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so12699035wra.6
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 21:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p0606LX2RuPgOOmputeOybY4watwMruHpIJyKrxEvJI=;
        b=VezFQ6Grn4z6oVDaoWJlBiS7nd33ubXAw9lFs7CAITZDS3svih3QLx6ATKzMak4QU+
         MUcTwdHRc71uRwLp6/xhMvzyM3L2ovKB6Prdl/D6yKJ5HSM2c3pdZhTlWwaQB4IfZ47x
         +aznshzQl4reY9QnfL/xhybUXjC2DEKRI83czDD++G1zsakfiGFV07q2ywyskeppZAn7
         LlePZt6KWvUIBF3cnt6/fFTjz8Wla5Bv0HyZXac2TRTf77ukZB2YKHXov8DQ0xO3/SM1
         jzAbNKdS3QrJhm1QqQ05VtvxCHHYDPnVeFMWJ/aHapB4PFtBjjNMj0t3BarlAyMecOw5
         HB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p0606LX2RuPgOOmputeOybY4watwMruHpIJyKrxEvJI=;
        b=HFEB7p1Wj2Ssdoyj4KHs7auIh9YAQ4DLF6VxlMLdbreT4cSBjCMwU6QB0bC8tDH4Yj
         6yblhoCXbvlUR3pBcUwh4xJARkGzkVjOD0zGxg0SC8mIobf+HIrijvKoRmcgTpUudIxX
         u5eAjiHzqmTOJyCT2jbHafnZ+TSPpIbPHs2xPb88LsCTKPUTtoSbJg5mplbtFSjBHM/6
         Diy2mQtgqVSLic7WjrjWRl7SUyuf2DLVqGf+T6RYSfzGMqOg1HN1jVjRWW3ZZ1ZmmvC8
         6l36+5XwL6gLzwvFp/1mJDWWQS6iQeYlWvS/sIXmLnNLyaTYcSDOhbH+q4jU/IAEuHv3
         GH7g==
X-Gm-Message-State: AA+aEWY2V9Wwn1XDhelgngSPnAqTgMxNkvLx6QYInY+Et+Nl3b52Gee6
        XzKrFNLkaMkZ4TNL0gMh1UXh59Wq
X-Google-Smtp-Source: AFSGD/VmjMAt+swvX6AQcAVdNY1soz66R1kwAWRqkDQuUUgxb36/mE4UqgGVNFf5qw6oOoE5WA603g==
X-Received: by 2002:adf:82e4:: with SMTP id 91mr12682512wrc.131.1544506085863;
        Mon, 10 Dec 2018 21:28:05 -0800 (PST)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l197sm3708185wma.44.2018.12.10.21.28.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 21:28:05 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v1 1/8] fetch-object: make functions return an error code
Date:   Tue, 11 Dec 2018 06:27:39 +0100
Message-Id: <20181211052746.16218-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.20.0.rc2.14.g1379de12fa.dirty
In-Reply-To: <20181211052746.16218-1-chriscool@tuxfamily.org>
References: <20181211052746.16218-1-chriscool@tuxfamily.org>
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
index 5bd11c85bc..cf88eeb147 100644
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
2.20.0.rc2.14.g1379de12fa.dirty


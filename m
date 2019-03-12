Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6FD320379
	for <e@80x24.org>; Tue, 12 Mar 2019 13:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfCLNaQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 09:30:16 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34971 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfCLNaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 09:30:16 -0400
Received: by mail-ed1-f67.google.com with SMTP id g19so2311164edp.2
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 06:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ehKvBAHxrFYqsUiHITsavJlab95T8SUH+U73Eze0XRs=;
        b=RlM8ber1fRw9hrgezbY0WiPenFIeTM3utxs9WkD9IpYH2QiWFnvl/BQsdOjpDFNXJB
         vxIk4b9ozUBwhy8d4w+Q7xw3KiE9iuImomm0Oz0ghDY7I/wisSl71P3l5ePU5SJZtfAW
         uw2GquNBrmzDvxK1+HZEcstxXdKdr/wQRVeo3a/etAAx3qpwbQTeodBjvC9nMWBgKusN
         cWafOVqYzvl83EM6D8XsXIptYRf1wvD/6xNf0ztkxIlm3qVoz1xWwIrqQAyNeTKiJksR
         PGNqoXRO3VhJnszUCDcNIvnKz3ILIlik/EdEMGjfTkdo5llgfiQ2UkD0P5O9vJp1JXI6
         b8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ehKvBAHxrFYqsUiHITsavJlab95T8SUH+U73Eze0XRs=;
        b=cFLDv1SYNHfBI1dX+Lnr+dFwt5LL2X9n56kJzb4AkItgiArdIOL8kqfu5Irku98R/2
         JkMS6JE+rPTeI2qiR21EobGyers3Xh+AVWKBoAAoRKhL+i4erNJMDlhfLVBvdnOeVRuB
         EOYykMaMBCgMk1XBFvxIbUY8X8FHeKxChcTKpR7qJaAidlajDAavpop+zbx3UoK1JaNu
         Z0sezajJdIr540NJ/GK0hNXdsSSOjXVx/lxhQPvxwDzWTqjucqoByT3P67bcpyaBLvMd
         Y57IphHihMlDqxjkwolTfRBRb2KW9Bc/n2kix6Ra562ynJd2GCuvjvVNlkHari/+dDg/
         yvnQ==
X-Gm-Message-State: APjAAAVCwi4PXLYC0wDoCM3bJjFvByCOQF1XkJFB7me3gUPExYs1jkSC
        IlumP0D+CDPIW8kKtZOU1TRdowJL
X-Google-Smtp-Source: APXvYqzRdhLw1YWvAu5kMDfL/qUDyijLQbm3Qu6XUEz2BftW+flosQ8o+Ag4SWeF8iIwkccuQ/dsKw==
X-Received: by 2002:a17:906:28c4:: with SMTP id p4mr26061387ejd.63.1552397414289;
        Tue, 12 Mar 2019 06:30:14 -0700 (PDT)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id h8sm5875213edk.21.2019.03.12.06.30.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 06:30:13 -0700 (PDT)
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
Subject: [PATCH v3 01/11] fetch-object: make functions return an error code
Date:   Tue, 12 Mar 2019 14:29:49 +0100
Message-Id: <20190312132959.11764-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.166.gb5e4dbcfd3
In-Reply-To: <20190312132959.11764-1-chriscool@tuxfamily.org>
References: <20190312132959.11764-1-chriscool@tuxfamily.org>
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
index 494606f771..01cc0590f4 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1372,8 +1372,8 @@ int oid_object_info_extended(struct repository *r, const struct object_id *oid,
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
2.21.0.166.gb5e4dbcfd3


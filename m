Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F33020374
	for <e@80x24.org>; Mon,  1 Apr 2019 16:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbfDAQlL (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 12:41:11 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39339 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbfDAQlL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 12:41:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so95843wmk.4
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 09:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g9F06A1ISgB4uAKOxyw6RV1cQApHEBPv50zgn8Xdy5U=;
        b=Ucg5bBJaC7AON+n5q9Ba6GaAFnaNMqAdn2vtAmMqhNItGAEHCiktDhT5+KL99InLz1
         X2E3sdktBLkgMhBNLiRdyAjGk30l3glV/N5Iya0rQ1GM/T3VKFw7ytWBLSTb9l1Z9OBR
         6drj52f1Jp46L7mYdpIxt9b17Vl9gOi7+KQp7IKdnDPtDsCp3h/D9VRFaqTgtJyc+mrW
         ZgpRdkd5BVm7cy+mfEtIDcukWYy6RC0BRcInX+Jww/jMPDFr+k3Ai6QUt3Q/xzmWZUjd
         yButR9ox5F2bMoSVD1PwXszp+lsiGqxXtzRxVBheQ2EyOA1WxDN5YfAvgWdFqHBCC9Kl
         pKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g9F06A1ISgB4uAKOxyw6RV1cQApHEBPv50zgn8Xdy5U=;
        b=EIAYW2B6sN5AWSWEzhdWTYG3UekHd7BlXVkwwdoTt6B8GSj8TS/XO/KU30ORfvTsQM
         c+WzmHeDbHvuVIEoUh1S5nWyRCL4SNvNcYcSahwoWUwTZLCOn3H3BtgZtHDT67982NdJ
         qCkIDfPEPa9W96IUSS2QMT6rLSMdzvwqLQfL98uCkzIEqEjU4BBz4+kDCRO7VNJLJNPU
         PwDFLdqBSPDXw8mcFq+brfmr47tC9d0HDkEdODuqFyoadfWBEEcdZR1noX1tsP24QL7z
         5yufrr5IA5BQx+vTLO+v1tadWZjUWyC0/3jbRCJqYHo5za/VIBsGJ3uZ/zbVgJSW3uEe
         5VwA==
X-Gm-Message-State: APjAAAVeASGgX4euJhO0CgdGsl/2tdupTWPQRCdDS2uope25JsLwsfPI
        w1yVmYfauqfUyZkRIQxOHu4PCcyB
X-Google-Smtp-Source: APXvYqwZ9P4ITx5IqoP7pp7PXvindFWhVs4x3BazRSlJsXmNu5SxXTecV7sDyKHbQ4WhDcR+s6hl2w==
X-Received: by 2002:a1c:41d6:: with SMTP id o205mr384593wma.2.1554136868857;
        Mon, 01 Apr 2019 09:41:08 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:101d:3e80:8542:d1d4:667f:a0da])
        by smtp.gmail.com with ESMTPSA id s10sm11749070wmh.0.2019.04.01.09.41.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 09:41:08 -0700 (PDT)
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
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 01/11] fetch-object: make functions return an error code
Date:   Mon,  1 Apr 2019 18:40:35 +0200
Message-Id: <20190401164045.17328-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.203.gd44fa53258
In-Reply-To: <20190401164045.17328-1-chriscool@tuxfamily.org>
References: <20190401164045.17328-1-chriscool@tuxfamily.org>
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
2.21.0.203.gd44fa53258


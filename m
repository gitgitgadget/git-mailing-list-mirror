Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CBF321421
	for <e@80x24.org>; Tue, 22 Jan 2019 14:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbfAVOmg (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 09:42:36 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36745 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728700AbfAVOme (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 09:42:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id u4so27650787wrp.3
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 06:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SXCghJv6pCiiUyaIi4S+Oj+odpx/0WOKaHLktNNpkUI=;
        b=rKp1mCGTfn0g03nCZ+jujMlKfUyGoa/tTIG6t5CvLllh1oQX/pO92vlVOdOKTy3M8y
         2an17guySqVi2KEBEIW+/SkuLT4ctB2wmpMgMNGMRmKuOStcm5k8hjnUvMRnDcV/BXH0
         OMap10tWaxE/8pekAmMk2FyfOE2VExKugmf/YWBCufaoSG6UfF/kz6TEms6SiTiaB5zb
         WvZaIuHUsDdIqU61/hySCQIlaTElCvZw9IucIYP7rWsxn0JC8KphgY3BFcTOyUdDClnx
         0ihl8BYLQMxLbOnexMQvnEgG09Akuuw/ZGX/VuD8PLOZCmzBioTsJys/RlM2F2mcgBJu
         +ysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SXCghJv6pCiiUyaIi4S+Oj+odpx/0WOKaHLktNNpkUI=;
        b=EZcxj3TCE9qHBKpvP70bkAsnXs+jnAmuX2BFdtSCS7DFtxlICjULd2wszq/+ocImVn
         nFEd4/1j0Bf1H3i7Q++epnQg1sTHKZrr6d9XI5dhRay2DMvJADJdS3heiLixhPaNQM/I
         yl3OtCkZYvcDKcOYoYBDyJ7ZdQW/2iF2CLPDhNJz+wCxlfO8Nigt8vh15yqmnFz9aEv9
         DKy4Hs9PMlXoAkKYanx+eBIUS6QW5jenp6ybACPgrhTtG9fi6Zh6uC7TuIBVLp3a8gtS
         jfLeSCXXfYOEutQYsEPtRV5j67V9RnoIdtXvC8H6tl2RgogSxR48yznHXl21Jf8iWrHV
         VCyA==
X-Gm-Message-State: AJcUukfW+ZXDE3V2nRJh+y3wzhXtTCY0/NHDK/5TQavss9SHveXEklK+
        ETxqCS2lnXeZxE2K7Tai2YbmOonW
X-Google-Smtp-Source: ALg8bN4UFSOKLWEhCEil64pBCoFZU+Ej2rb3R9JyXMufRUEE4lmis8v5tl4wTVjdEThXkqruej0+hw==
X-Received: by 2002:a5d:44d1:: with SMTP id z17mr32223045wrr.271.1548168152061;
        Tue, 22 Jan 2019 06:42:32 -0800 (PST)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id k26sm31266168wmi.28.2019.01.22.06.42.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 06:42:31 -0800 (PST)
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
Subject: [PATCH v2 03/13] fetch-object: make functions return an error code
Date:   Tue, 22 Jan 2019 15:42:02 +0100
Message-Id: <20190122144212.15119-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.20.1.322.gd6b9ae60d4
In-Reply-To: <20190122144212.15119-1-chriscool@tuxfamily.org>
References: <20190122144212.15119-1-chriscool@tuxfamily.org>
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
index 386b96e1d7..972f26e931 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1304,8 +1304,8 @@ int oid_object_info_extended(struct repository *r, const struct object_id *oid,
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
2.20.1.322.gd6b9ae60d4


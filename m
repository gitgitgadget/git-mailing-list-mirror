Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02F4A1F42D
	for <e@80x24.org>; Sun, 13 May 2018 10:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751830AbeEMKdc (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 06:33:32 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34976 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbeEMKdA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 06:33:00 -0400
Received: by mail-wm0-f67.google.com with SMTP id o78-v6so10156640wmg.0
        for <git@vger.kernel.org>; Sun, 13 May 2018 03:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zBDfJWUGoa2kVBK1naL3oZUhfEC+GwPlZO2KmIr15NA=;
        b=S/pn11WGCWWoWBUVdzyAbabWlG6pWfSCdWwC9r9tcaBnwJWv30+vi5i4n45I6Sg8KS
         SWemamIwrxHpuEHImEjvjNEjWoTFPS87qSFdWu+HrKFGjLv+lWYMz1Ag0X6d7L6kI0m8
         pZ7PSFSZzIv7sPO6AB00HYubsI2Jmk1aqq1lsXiuGCYsOebMqeyGjj15S26OCW0jUcSM
         59J3c7k1yzURPCjX48rA+EqeYCo7uEBj67YppOUoMQkBB2UwCnEgTMLUGwYm7CZR8GdO
         fXFYj58yXBHJhSH/GAS/pEHIwtuMuWOyI7qrLTtAdSZcI9/SgZtbKrdARSV35/QemH7x
         LV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zBDfJWUGoa2kVBK1naL3oZUhfEC+GwPlZO2KmIr15NA=;
        b=N5cRm19VVSpH7MKreV2V/Pj9sy/JbS8ll2AUVmAkWpYK7IWyASY9Jt27SYYFo/NE17
         ow07mDJ8qIutZ3t/1wST4JDOijYwC5GobBWmun4afVIguD+0d73a062xLpQEY6Ii+wAJ
         XFDT55jqX4o/s5LalSdkku1asAewHNXlNRD8iwYs09i0H346rSQxaYA0Ygq8Ubmbyc0S
         Eugh3mH2yqUtGmXKy1JIJLNi3OsPf1fBtUnxXfiYULklNCm7OxKv3vVe/fIcsLSiUYZC
         KBQ6YtrB0JPAva6y+jWyxzECfvIaDayksK+cQdr70vztcKl1PBtYYc8O9T7nz2VuKf0Q
         ffcQ==
X-Gm-Message-State: ALKqPwelQlAKb3kIHzF5XgMUzUKXbuyyq2fLRRNS4FY49fP/6WvNJ6zv
        I8rcT6UKeOjl+vc862aHsuFXlYTj
X-Google-Smtp-Source: AB8JxZoZxg8xkMJ2T7SnyF0FmbCk5/QbCV4e0kYtabC62UEZhrRrb6GCeVX2LHJRrKso/hB2GXOjtQ==
X-Received: by 2002:a1c:a104:: with SMTP id k4-v6mr2706674wme.106.1526207579337;
        Sun, 13 May 2018 03:32:59 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id t203-v6sm6886375wmt.33.2018.05.13.03.32.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 May 2018 03:32:58 -0700 (PDT)
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
Subject: [PATCH v1 4/8] odb-remote: implement odb_remote_get_many_direct()
Date:   Sun, 13 May 2018 12:32:28 +0200
Message-Id: <20180513103232.17514-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.590.gbd05bfcafd
In-Reply-To: <20180513103232.17514-1-chriscool@tuxfamily.org>
References: <20180513103232.17514-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function will be used to get many objects from a promisor
remote.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 odb-helper.c | 15 +++++++++++++++
 odb-helper.h |  3 +++
 odb-remote.c | 17 +++++++++++++++++
 odb-remote.h |  1 +
 4 files changed, 36 insertions(+)

diff --git a/odb-helper.c b/odb-helper.c
index 2851fe2657..5fe37e6fe5 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -28,3 +28,18 @@ int odb_helper_get_direct(struct odb_helper *o,
 
 	return res;
 }
+
+int odb_helper_get_many_direct(struct odb_helper *o,
+			       const struct oid_array *to_get)
+{
+	int res;
+	uint64_t start;
+
+	start = getnanotime();
+
+	res = fetch_objects(o->dealer, to_get);
+
+	trace_performance_since(start, "odb_helper_get_many_direct");
+
+	return res;
+}
diff --git a/odb-helper.h b/odb-helper.h
index d21b625a7e..d63210d516 100644
--- a/odb-helper.h
+++ b/odb-helper.h
@@ -11,4 +11,7 @@ struct odb_helper {
 extern struct odb_helper *odb_helper_new(const char *name, int namelen);
 extern int odb_helper_get_direct(struct odb_helper *o,
 				 const unsigned char *sha1);
+extern int odb_helper_get_many_direct(struct odb_helper *o,
+				      const struct oid_array *to_get);
+
 #endif /* ODB_HELPER_H */
diff --git a/odb-remote.c b/odb-remote.c
index dbab40c0f8..9a1561430c 100644
--- a/odb-remote.c
+++ b/odb-remote.c
@@ -87,3 +87,20 @@ int odb_remote_get_direct(const unsigned char *sha1)
 
 	return -1;
 }
+
+int odb_remote_get_many_direct(const struct oid_array *to_get)
+{
+	struct odb_helper *o;
+
+	trace_printf("trace: odb_remote_get_many_direct: nr: %d", to_get->nr);
+
+	odb_remote_init();
+
+	for (o = helpers; o; o = o->next) {
+		if (odb_helper_get_many_direct(o, to_get) < 0)
+			continue;
+		return 0;
+	}
+
+	return -1;
+}
diff --git a/odb-remote.h b/odb-remote.h
index 27a480fcfe..e6cedde722 100644
--- a/odb-remote.h
+++ b/odb-remote.h
@@ -4,5 +4,6 @@
 extern struct odb_helper *find_odb_helper(const char *dealer);
 extern int has_odb_remote(void);
 extern int odb_remote_get_direct(const unsigned char *sha1);
+extern int odb_remote_get_many_direct(const struct oid_array *to_get);
 
 #endif /* ODB_REMOTE_H */
-- 
2.17.0.590.gbd05bfcafd


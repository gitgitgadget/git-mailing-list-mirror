Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ADB41F453
	for <e@80x24.org>; Tue, 25 Sep 2018 11:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbeIYSBS (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 14:01:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45351 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbeIYSBS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 14:01:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id m16so6558477wrx.12
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 04:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BFA9rS8p4c61LWvQAensQ0gE4ApKPIjwa/4qy1dhlns=;
        b=BJD8A/hlcOSu0hTjaAV8RPNvqJyY0pRyg9gBr9eZVnpdP9lHibqY1lQcXgoN0QWNkc
         fxtX2oe3TlYsBWFxMecdw5evsG6CJfW/sJjQKvMOxbBaed7zvm3E/Tq4TYsE0k+l9Fd+
         UiBE3uQKJRNh+5LGYZnCbCQJ8DYld8vhgTgCcueuRrN9UQefjD1YLml3qRsmHfUGwuYi
         bwR42tJhq0toBV4E7kMjdi0tCJTYIW4yJkhP0vGiVudh+yHK145lyhBVj4VgRDWtYEgU
         mvffYZDE4E3lqD+G+YbzLAyx2fYO8BAMfhliBxHtfvY+ONLoD3t4C3iT/Oh1UBHgB3RE
         IBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BFA9rS8p4c61LWvQAensQ0gE4ApKPIjwa/4qy1dhlns=;
        b=TtTfbEKFyEwGt+gfWawFuBERX2V51jdL58Ar/qgRdzW17fSapHHx19RgNJJTUiKUhn
         Qhry4N+w2ucyV9T5cMWwNf42NF7AVgkQHzm6OY2PF5Z5232SdSGFHJPcIzhC7E79XU71
         GzNP0HKu/wxPLR6xTw18clxZvNzgZQBJMU1xzZy8MKhh/E9OdqIDLumM8pU/Rsc9lRmd
         0k4jFHaDygRjE0vw5tGziLwLMqtZVT659MKLjAjNu8mAtucbGVObN3WVugchn2nLkf7G
         UNnWKJOdMJ2NRmU8fyTF2l2Z2ZwheZ2ok1NZLwgvGzxbcbmKVhJi+5oazIqwQHzJVFKU
         kgYg==
X-Gm-Message-State: ABuFfogu/VNPUNdCHhneYBt7LRmv4DHnTEhCI6Qm3u7Tyi5v/8E9Qtv0
        beHzUkX9WSX0UoM4U/nQBSKrWEy4
X-Google-Smtp-Source: ACcGV60gaK+9Iql9O+eSQzvfx5Z1xVZsLA1e7s/vkpdQc44Y46FeustbhkuxkK5KG89h1wPVoKgytQ==
X-Received: by 2002:adf:ecc4:: with SMTP id s4-v6mr728765wro.142.1537876445227;
        Tue, 25 Sep 2018 04:54:05 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id z14-v6sm1998628wrr.91.2018.09.25.04.54.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 04:54:04 -0700 (PDT)
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
        Beat Bolli <dev+git@drbeat.li>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 3/8] remote-odb: implement remote_odb_get_direct()
Date:   Tue, 25 Sep 2018 13:53:36 +0200
Message-Id: <20180925115341.19248-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.19.0.278.gca5b891cac
In-Reply-To: <20180925115341.19248-1-chriscool@tuxfamily.org>
References: <20180925115341.19248-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

This is implemented only in the promisor remote mode
for now by calling fetch_objects().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 odb-helper.c | 15 +++++++++++++++
 odb-helper.h |  3 +++
 remote-odb.c | 17 +++++++++++++++++
 remote-odb.h |  1 +
 4 files changed, 36 insertions(+)

diff --git a/odb-helper.c b/odb-helper.c
index b4d403ffa9..6458fe2e32 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -4,6 +4,7 @@
 #include "odb-helper.h"
 #include "run-command.h"
 #include "sha1-lookup.h"
+#include "fetch-object.h"
 
 struct odb_helper *odb_helper_new(const char *name, int namelen)
 {
@@ -14,3 +15,17 @@ struct odb_helper *odb_helper_new(const char *name, int namelen)
 
 	return o;
 }
+
+int odb_helper_get_direct(struct odb_helper *o,
+			  const struct object_id *oids,
+			  int oid_nr)
+{
+	int res;
+	uint64_t start = getnanotime();
+
+	res = fetch_objects(o->remote, oids, oid_nr);
+
+	trace_performance_since(start, "odb_helper_get_direct");
+
+	return res;
+}
diff --git a/odb-helper.h b/odb-helper.h
index 4b792a3896..950f9f9cd1 100644
--- a/odb-helper.h
+++ b/odb-helper.h
@@ -15,5 +15,8 @@ struct odb_helper {
 };
 
 extern struct odb_helper *odb_helper_new(const char *name, int namelen);
+extern int odb_helper_get_direct(struct odb_helper *o,
+				 const struct object_id *oids,
+				 int oid_nr);
 
 #endif /* ODB_HELPER_H */
diff --git a/remote-odb.c b/remote-odb.c
index 03be54ba2e..53900203ae 100644
--- a/remote-odb.c
+++ b/remote-odb.c
@@ -89,3 +89,20 @@ int has_remote_odb(void)
 {
 	return !!find_odb_helper(NULL);
 }
+
+int remote_odb_get_direct(const struct object_id *oids, int oid_nr)
+{
+	struct odb_helper *o;
+
+	trace_printf("trace: remote_odb_get_direct: nr: %d", oid_nr);
+
+	remote_odb_init();
+
+	for (o = helpers; o; o = o->next) {
+		if (odb_helper_get_direct(o, oids, oid_nr) < 0)
+			continue;
+		return 0;
+	}
+
+	return -1;
+}
diff --git a/remote-odb.h b/remote-odb.h
index 4c7b13695f..221305d1b6 100644
--- a/remote-odb.h
+++ b/remote-odb.h
@@ -3,5 +3,6 @@
 
 extern struct odb_helper *find_odb_helper(const char *remote);
 extern int has_remote_odb(void);
+extern int remote_odb_get_direct(const struct object_id *oids, int oid_nr);
 
 #endif /* REMOTE_ODB_H */
-- 
2.19.0.278.gca5b891cac


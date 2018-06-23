Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6DDA1F62E
	for <e@80x24.org>; Sat, 23 Jun 2018 12:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752144AbeFWMTL (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Jun 2018 08:19:11 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38756 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752017AbeFWMTI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jun 2018 08:19:08 -0400
Received: by mail-wr0-f196.google.com with SMTP id e18-v6so9140585wrs.5
        for <git@vger.kernel.org>; Sat, 23 Jun 2018 05:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kraeBmxvbmV8ENyrM4PmTB3yh5VlvqbhF08+/QyMfAw=;
        b=ZeTHumd+7D7fmFHIQnxsWJXyzhSB+hEjanJH5kiGRq9gUFI09naevoqPdbDq1/lMle
         RLczPrI1sdKDK6VE7eo1vB96upPBdBA4sLnMUqr0hCNCf/6hOoAnnGpBG5FVDH54IhU2
         OcV7tJIMmtcTmZxIYsmt3THwe0qYS9kpagcFes7gtwNFpf2MB3O1YbQqW8Zk6KPmVzkm
         wEbYa9s6gTw72lYE7JLQeM62HSfAW2c/BehBu7SjC2hDEcNvk+5KBuTNz1NOQoUdx9yL
         D0Awj9ymmtFUuZCZ02V8MOnlrHJ5S1OFCxhxZDZLPaVO8KtSdq0Km7x2zI989syrwEKq
         ZJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kraeBmxvbmV8ENyrM4PmTB3yh5VlvqbhF08+/QyMfAw=;
        b=SLssJUJQfp85AlywkmC0yMxXaL951trZ81YPGiMTLt5EVHZPaFmZol5uLcUzWVVbgG
         juQqNENeK0z+kfAInhlxlBnQfB/sgbGEUxCfTOMfGmtKKRVzH54oIX4Q/Jinh7uBcEFW
         WPaObtQYQLS87gXMk/TUKKhDeVvXxNnSno06Oypb64q5ZXNseZI/eImd9jHMVJ1RYTCB
         Ri3e8Y9wgTs2Zfvh5F6d4sdQ4MDvxAHNv+vyIZDFMkyMbTVMyMZzRJJqp4y8qsqndNQe
         h+NUdU6ykVnWknsYc781Clz/B+hN8AqdPinXn/llyVXRiMTl6fNWdiDmfhm6pb2IzReW
         s+/Q==
X-Gm-Message-State: APt69E2M4QEsjfkw40meEZwM1P2twwSfr9PWX+V7i9QywH0q/5axcMOI
        jMQOrHL46dCbDHxsDPNtej090TgC
X-Google-Smtp-Source: AAOMgpeNTiK1Y9RrTNPO3XPeY4juAAoNDWdnYtT6whpL0Z9nqVEfEj7Wp1tysitonXymv4ri3oXhpg==
X-Received: by 2002:adf:e48e:: with SMTP id i14-v6mr4987786wrm.8.1529756346679;
        Sat, 23 Jun 2018 05:19:06 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id q14-v6sm5527731wmd.20.2018.06.23.05.19.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jun 2018 05:19:06 -0700 (PDT)
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
Subject: [PATCH v1 04/11] remote-odb: implement remote_odb_get_many_direct()
Date:   Sat, 23 Jun 2018 14:18:41 +0200
Message-Id: <20180623121846.19750-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.762.g886f54ea46
In-Reply-To: <20180623121846.19750-1-chriscool@tuxfamily.org>
References: <20180623121846.19750-1-chriscool@tuxfamily.org>
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
 remote-odb.c | 17 +++++++++++++++++
 remote-odb.h |  1 +
 4 files changed, 36 insertions(+)

diff --git a/odb-helper.c b/odb-helper.c
index 99b5a345e8..246ebf8f7a 100644
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
+	res = fetch_objects(o->remote, to_get);
+
+	trace_performance_since(start, "odb_helper_get_many_direct");
+
+	return res;
+}
diff --git a/odb-helper.h b/odb-helper.h
index 4c52e81ce8..154ce4c7e4 100644
--- a/odb-helper.h
+++ b/odb-helper.h
@@ -17,4 +17,7 @@ struct odb_helper {
 extern struct odb_helper *odb_helper_new(const char *name, int namelen);
 extern int odb_helper_get_direct(struct odb_helper *o,
 				 const unsigned char *sha1);
+extern int odb_helper_get_many_direct(struct odb_helper *o,
+				      const struct oid_array *to_get);
+
 #endif /* ODB_HELPER_H */
diff --git a/remote-odb.c b/remote-odb.c
index a34537c05c..cc7059b23a 100644
--- a/remote-odb.c
+++ b/remote-odb.c
@@ -87,3 +87,20 @@ int remote_odb_get_direct(const unsigned char *sha1)
 
 	return -1;
 }
+
+int remote_odb_get_many_direct(const struct oid_array *to_get)
+{
+	struct odb_helper *o;
+
+	trace_printf("trace: remote_odb_get_many_direct: nr: %d", to_get->nr);
+
+	remote_odb_init();
+
+	for (o = helpers; o; o = o->next) {
+		if (odb_helper_get_many_direct(o, to_get) < 0)
+			continue;
+		return 0;
+	}
+
+	return -1;
+}
diff --git a/remote-odb.h b/remote-odb.h
index c5384c922d..e10a8bf855 100644
--- a/remote-odb.h
+++ b/remote-odb.h
@@ -4,5 +4,6 @@
 extern struct odb_helper *find_odb_helper(const char *remote);
 extern int has_remote_odb(void);
 extern int remote_odb_get_direct(const unsigned char *sha1);
+extern int remote_odb_get_many_direct(const struct oid_array *to_get);
 
 #endif /* REMOTE_ODB_H */
-- 
2.17.0.762.g886f54ea46


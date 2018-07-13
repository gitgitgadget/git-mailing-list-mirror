Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 255AE1F914
	for <e@80x24.org>; Fri, 13 Jul 2018 17:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731555AbeGMSGF (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 14:06:05 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35199 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731305AbeGMSGF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 14:06:05 -0400
Received: by mail-wm0-f68.google.com with SMTP id a9-v6so3320026wmb.0
        for <git@vger.kernel.org>; Fri, 13 Jul 2018 10:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4orbNWRqzAZrysXorj9zRUkq1OM7ddB9AgmIAexW3Cg=;
        b=bgZnSs1w3GgIvR7fP7yq88QHBP8vY1hVEww7Wht01LoM6IEAp/JqMaHQLYCWcwBZOV
         R3syT4CgZPqf22ewxTQv9g1OvY7EwKZYVhOGGkpkVRL0we38eU52mJLZJiEqhNb7DgUm
         KPVwEggwnEC3AuXIll7qb8po1R44HMoDc0c+XKICKvWbC8uOv7+AXCaWs+bkKwEsDUIp
         m7IBdb0wYEEBOQl3t/RVG2c9sLQD3klK8RrWVwFrvuExw+GQxw0Y/ewFkkALDuG3sXrm
         SSvU1BDOtBVNKexaU/LZjM3ISkyVF0hnvrL8gjvqC//Xd+cXYiMv3hM1Ce0Wg4JLMiH1
         d89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4orbNWRqzAZrysXorj9zRUkq1OM7ddB9AgmIAexW3Cg=;
        b=Fg3bmcjVwgDRH0lBNQgmr3RdFKdIIYltY+U6VLenL+POWZZTZvd/ibCQ/3T5uUewF7
         mEgdAKCKBwTbUgyOHo0a1egediCpSc46yZttP10jnnPDdJD8noXEZ/mI/qhNMoZehBKZ
         Dr1Dq3B7mW+OeFeQQSl44w1ULUuGbBKK/gTdBjlTBmQuLx5kn2pqLJomMDUOJz0UFUB+
         /cGmMr6DBaOv5OOUzgEtC8FfxTuu1h15bVkMzji1iu8yl1wpRj/mkPLII4EAA0CKPy42
         I+Gk7U7hC0/3jDHRr2Zckyl2RCF165oaUmL/WyFcXk/9Alg5qkK/BrlV6FyRtUa95Lz7
         FU2A==
X-Gm-Message-State: AOUpUlEkMGDYWmfE7TLQ5CeRm7WGRAqs2e8zWtQBcwBRwahkoO8hMG9G
        jtkB2dompd8tlIvfZqXWf+Gg5TAN
X-Google-Smtp-Source: AAOMgpcHiAOK8tw84suqNA/HoqMapakKY4pP9lrR6lUmN4nBiZgzaDUF0+7J6KRAmG3+2kWs5+24Xg==
X-Received: by 2002:a1c:1509:: with SMTP id 9-v6mr4222240wmv.142.1531504225343;
        Fri, 13 Jul 2018 10:50:25 -0700 (PDT)
Received: from localhost.localdomain (188.10.112.78.rev.sfr.net. [78.112.10.188])
        by smtp.gmail.com with ESMTPSA id v15-v6sm6556862wmc.16.2018.07.13.10.50.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 10:50:24 -0700 (PDT)
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
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 5/9] remote-odb: add remote_odb_reinit()
Date:   Fri, 13 Jul 2018 19:49:55 +0200
Message-Id: <20180713174959.16748-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.138.g7076a5fae1
In-Reply-To: <20180713174959.16748-1-chriscool@tuxfamily.org>
References: <20180713174959.16748-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

We will need to reinitialize the remote odb configuration
as we will make some changes to it in a later commit when
we will detect that a remote is also a remote odb.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 remote-odb.c | 14 ++++++++++++--
 remote-odb.h |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/remote-odb.c b/remote-odb.c
index 09dfc2e16f..53a72b4ba5 100644
--- a/remote-odb.c
+++ b/remote-odb.c
@@ -64,17 +64,27 @@ static int remote_odb_config(const char *var, const char *value, void *data)
 	return 0;
 }
 
-static void remote_odb_init(void)
+static void remote_odb_do_init(int force)
 {
 	static int initialized;
 
-	if (initialized)
+	if (!force && initialized)
 		return;
 	initialized = 1;
 
 	git_config(remote_odb_config, NULL);
 }
 
+static inline void remote_odb_init(void)
+{
+	remote_odb_do_init(0);
+}
+
+inline void remote_odb_reinit(void)
+{
+	remote_odb_do_init(1);
+}
+
 struct odb_helper *find_odb_helper(const char *remote)
 {
 	remote_odb_init();
diff --git a/remote-odb.h b/remote-odb.h
index e10a8bf855..79803782af 100644
--- a/remote-odb.h
+++ b/remote-odb.h
@@ -1,6 +1,7 @@
 #ifndef REMOTE_ODB_H
 #define REMOTE_ODB_H
 
+extern void remote_odb_reinit(void);
 extern struct odb_helper *find_odb_helper(const char *remote);
 extern int has_remote_odb(void);
 extern int remote_odb_get_direct(const unsigned char *sha1);
-- 
2.18.0.171.ge260395bfe


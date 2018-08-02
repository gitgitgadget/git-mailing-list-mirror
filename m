Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E162F208E9
	for <e@80x24.org>; Thu,  2 Aug 2018 06:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbeHBIFU (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 04:05:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40455 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbeHBIFU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 04:05:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id h15-v6so862833wrs.7
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 23:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bB4RvKyr5X0FebDNPQRVzBcpAuT+w925ys5gGgOGR24=;
        b=VzkKZnkMOXlG9VAFtngJDO0GQ1gqDfP78KYUxhBbj1dyHYlhvcNP/9PBjHQgbRK2NC
         JK2XBlNbQuE5IasFV6otYQXfYWvXKzQjwl08RgM9CCnjUknLZmC2ChjRisL+bG9Brf0F
         rYSFNzPrnKrhzOR6UXgz7WG2a8P+frsFE9kxKjyZEwyTEen2zSE3x/nwhsLqbQsS9kI9
         o3bwAHrMqu45VfXdrsALjT/smGBfedadKzsxs5CvSVM9DbdQgHiuu11sQeNo4glDInLj
         R90QV6mWJtkpLz3nRestVYl/ZftZHOB+oggIneLCMA8ILU8dv3OJZ0NKiy1vryAmS2PO
         HjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bB4RvKyr5X0FebDNPQRVzBcpAuT+w925ys5gGgOGR24=;
        b=aDnlxwPp+Blkwxc/RFkm7lm39bKXu7RVU2M4Qu4fcpBed/YrLf8kAoJIZDNq6J8+nq
         O4EGhhqp8NpagQsg8xOBrz5XbZ+imuL7dwNPGXxZRdvvAlUQ0o7AOILg7bzM4ngX4MV9
         yEQcsEp4nyhSoHgICFZJAvjBOXqZWekBJFChoDemlLb86VzEeLfLdwauRMoqKy+OWgVg
         dWCP7QBHxLmjvWBZiuWP6gnzMTX6y8cxGaho958Z2zhjDonaDeueYP24LEUGDymxQUlY
         E/Z6Nb9qgMR/uas/O1F+RUz+y5L81lpfdcIa+uTTZZ1qx1SjUpu8tpMzCEracAQYD9ff
         bL6A==
X-Gm-Message-State: AOUpUlHZSAxleAGXDYfV0f9VABIbd2+6wjlIOc9t3WgniySe31K2roDP
        ElKgVky7xlpbGSgZCjy98b/rTzfH
X-Google-Smtp-Source: AAOMgpd993ATXmeA45CLcJSb7I9wXpk2E02f7HmRd82fECejXVbQb+ql88/b40pm5OPXLJMAzAmsIQ==
X-Received: by 2002:a5d:480d:: with SMTP id l13-v6mr973583wrq.234.1533190547140;
        Wed, 01 Aug 2018 23:15:47 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:109f:b149:1092:6e1:496b:fd26])
        by smtp.gmail.com with ESMTPSA id m200-v6sm1093018wma.32.2018.08.01.23.15.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 23:15:46 -0700 (PDT)
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
Subject: [PATCH v4 5/9] remote-odb: add remote_odb_reinit()
Date:   Thu,  2 Aug 2018 08:15:01 +0200
Message-Id: <20180802061505.2983-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.330.g17eb9fed90
In-Reply-To: <20180802061505.2983-1-chriscool@tuxfamily.org>
References: <20180802061505.2983-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 09dfc2e16f..f063ba0fda 100644
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
+void remote_odb_reinit(void)
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
2.18.0.330.g17eb9fed90


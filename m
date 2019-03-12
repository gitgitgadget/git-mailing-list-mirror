Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96B2D20374
	for <e@80x24.org>; Tue, 12 Mar 2019 13:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbfCLNaW (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 09:30:22 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43097 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfCLNaU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 09:30:20 -0400
Received: by mail-ed1-f66.google.com with SMTP id m35so2265030ede.10
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 06:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L0Cen3rMdL3+841sDs2ZwexsAwpHx7Iy/yGgBR/7zno=;
        b=ACo+qUwFNlBh/Ng7E1vD7e8A24Hk9aBlGDx1zF5X1fO4Hmj3YEhEQO702cQzqpsapm
         7ofplC0OgtoSzP10Q1wfdbyBqkUVzHIhQVRAGjenBT7bM+UDkcv1CrcFt9RwEVf5jATZ
         FW+DD635giAh/GsB1AWyVOqc3xG5vqsOi6shENUeGG3ByxQbyMbrQXCOTKdLHfZxGYpM
         jIq2CKyWbFZLv1Hkw5SmZgtZn7BJoM/EUrGlpgvo4zrbjn+K9E6acgBZN0NJZ552Ha5u
         AE1HcWQLM0i+fPXUb1p4Wheu8xdoUZuF3jHepdtfOfXT9lXKUQHYSy3Ba/Tqmqc3mru8
         qnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L0Cen3rMdL3+841sDs2ZwexsAwpHx7Iy/yGgBR/7zno=;
        b=Ei11xbh1GxYQS8z9YytmpMYzJ5DjlZc0wmFgyaEEEKEg/aJDh9b0TxDADmuLbckMsW
         fFVr4Y7yjjNUbFiRv66bVd387eyIYj6in0y354RYkKPdi3atxqyK4yT4Vrsit27xAh0h
         00W2+k9yEolCrrFWEm9sg3wb1Yi4a2M/nLaGqUJAqxnxlghvIQ7qZQ7JnCzbVdoXdXRY
         x5/vTYln6QZv97wF0i2Rv93X1t3YnZFYF9jxBGBnjpyQVa1ajV7IJx6jmbbMfB1qiF4+
         pQ5wZ+nsa4EB6OrfeGgv21UImDq7wH6k90KmPzhOm1uRex9zbO8QKEznV5KAHftlrSxZ
         D6/w==
X-Gm-Message-State: APjAAAV2DUnUj6caQjX6z7qc0hq0B0ukKoNB1PSj9iqqN/K26WorIkPM
        tW9OsRCjx+ugJ4T8jejmULep5f8Q
X-Google-Smtp-Source: APXvYqxsQ0UBtblAJvYeNpUC6v9II2hmbEqACzzbW4hFid+wgjHELkpFZ5XfbmwmtXY4ismO4iSWlA==
X-Received: by 2002:a17:906:7711:: with SMTP id q17mr25828653ejm.174.1552397417828;
        Tue, 12 Mar 2019 06:30:17 -0700 (PDT)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id h8sm5875213edk.21.2019.03.12.06.30.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 06:30:16 -0700 (PDT)
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
Subject: [PATCH v3 04/11] promisor-remote: add promisor_remote_reinit()
Date:   Tue, 12 Mar 2019 14:29:52 +0100
Message-Id: <20190312132959.11764-5-chriscool@tuxfamily.org>
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

We will need to reinitialize the promisor remote configuration
as we will make some changes to it in a later commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 14 ++++++++++++--
 promisor-remote.h |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index f86f9d0b84..ea74f6d8a8 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -74,17 +74,27 @@ static int promisor_remote_config(const char *var, const char *value, void *data
 	return 0;
 }
 
-static void promisor_remote_init(void)
+static void promisor_remote_do_init(int force)
 {
 	static int initialized;
 
-	if (initialized)
+	if (!force && initialized)
 		return;
 	initialized = 1;
 
 	git_config(promisor_remote_config, NULL);
 }
 
+static inline void promisor_remote_init(void)
+{
+	promisor_remote_do_init(0);
+}
+
+void promisor_remote_reinit(void)
+{
+	promisor_remote_do_init(1);
+}
+
 struct promisor_remote *promisor_remote_find(const char *remote_name)
 {
 	promisor_remote_init();
diff --git a/promisor-remote.h b/promisor-remote.h
index f9f5825417..f96722bc66 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -10,6 +10,7 @@ struct promisor_remote {
 	struct promisor_remote *next;
 };
 
+extern void promisor_remote_reinit(void);
 extern struct promisor_remote *promisor_remote_new(const char *remote_name);
 extern struct promisor_remote *promisor_remote_find(const char *remote_name);
 extern int has_promisor_remote(void);
-- 
2.21.0.166.gb5e4dbcfd3


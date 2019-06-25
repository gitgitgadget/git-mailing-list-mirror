Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E72B1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 13:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbfFYNlP (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 09:41:15 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36140 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729846AbfFYNlN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 09:41:13 -0400
Received: by mail-ed1-f66.google.com with SMTP id k21so27254720edq.3
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 06:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r+faeZ4bLagCledobRR4n/1KI7yqRn5WZuiC2MgIos4=;
        b=XN4sZSA70mCfAqzH2vHW9evsYRUDW3lfZAUigXixcaGY9zaB1Ktq+K/o3bx+dXStlm
         ZZ1zbQHW/fVHRzSNVB0c+wrwwC15xeVATL8Q5yvunld0Mdf6bYEEYeGKIG8/KBjgu7pd
         3Zrxn/ThCNedzSzlCsOygAp8G6JY1Qa6RtEQQMOj+k/gQYgh43pmsa9UryNfk/zRhAXV
         dMUbLUEGWdHy7TuUwWiK1VqgSM167FxyvgLsEC2Gol2u6tSGgFX+EQNjI6g9uNN2b+V5
         MXfTjMKQsq4lOUXmo6VR6diXYB0glNX/nAF2yw36XW6yivHHcUGLBDxnwIGV3cucttAs
         ZMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r+faeZ4bLagCledobRR4n/1KI7yqRn5WZuiC2MgIos4=;
        b=p8dcME/cqyxEoJefdmGM/EvpRCB8it/uYXNU4fof848soG1a3F0JYa/wpH3C43C/CH
         6yjyeUn7U+rngvNyFnqO2UsFselbF2dcvd+v7MFoLcpcerG1NPzUGRWpmSQr330pUp/L
         0sGpzxj6URKFPBv9A2NetPzNXnooB/dhhlpIGDwH6NvjOwQ86O0fyQw89Ehew7vh1Iu4
         dozoHYgn9+HQtzaAD6j0oJv6yYc2cKsdOorVigOu7PI5NjMHJIJFrKGC69FibjeEQpaZ
         YHZ8VKnvaRWPOEhaBoEQkVrVuD3R6RfVG0OGV1IwCuR5qlQwZ4m3jJ2IZYjA1JsYd8UJ
         Ijbw==
X-Gm-Message-State: APjAAAV63wir6nRLD+K+phuu84B4+DMlmVFUz20vynLqNOmiUYps5rUI
        xOaZwa55c6QhXOAnqByuT5oa6I1Xp7k=
X-Google-Smtp-Source: APXvYqxomcIAedpLgbG2w+uONNA8RzO2zO7Tkgw8HaZAqtZlSQPFZaeErWNcPJaPTM5Q/G7ZD2tW5A==
X-Received: by 2002:a17:906:9147:: with SMTP id y7mr55265368ejw.66.1561470071255;
        Tue, 25 Jun 2019 06:41:11 -0700 (PDT)
Received: from ubuntu-N150ZU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id v11sm2448445ejx.24.2019.06.25.06.41.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 06:41:10 -0700 (PDT)
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
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Derrick Stolee <stolee@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 05/15] promisor-remote: add promisor_remote_reinit()
Date:   Tue, 25 Jun 2019 15:40:29 +0200
Message-Id: <20190625134039.21707-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.229.ga13d9ffdf7.dirty
In-Reply-To: <20190625134039.21707-1-chriscool@tuxfamily.org>
References: <20190625134039.21707-1-chriscool@tuxfamily.org>
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
 promisor-remote.c | 22 ++++++++++++++++++++--
 promisor-remote.h |  1 +
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index b79a84ce3a..763d98aedd 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -67,10 +67,10 @@ static int promisor_remote_config(const char *var, const char *value, void *data
 	return 0;
 }
 
+static int initialized;
+
 static void promisor_remote_init(void)
 {
-	static int initialized;
-
 	if (initialized)
 		return;
 	initialized = 1;
@@ -78,6 +78,24 @@ static void promisor_remote_init(void)
 	git_config(promisor_remote_config, NULL);
 }
 
+static void promisor_remote_clear(void)
+{
+	while (promisors) {
+		struct promisor_remote *r = promisors;
+		promisors = promisors->next;
+		free(r);
+	}
+
+	promisors_tail = &promisors;
+}
+
+void promisor_remote_reinit(void)
+{
+	initialized = 0;
+	promisor_remote_clear();
+	promisor_remote_init();
+}
+
 struct promisor_remote *promisor_remote_find(const char *remote_name)
 {
 	promisor_remote_init();
diff --git a/promisor-remote.h b/promisor-remote.h
index ed4ecead36..dddd4048e0 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -12,6 +12,7 @@ struct promisor_remote {
 	const char name[FLEX_ARRAY];
 };
 
+extern void promisor_remote_reinit(void);
 extern struct promisor_remote *promisor_remote_find(const char *remote_name);
 extern int has_promisor_remote(void);
 extern int promisor_remote_get_direct(struct repository *repo,
-- 
2.22.0.229.ga13d9ffdf7.dirty


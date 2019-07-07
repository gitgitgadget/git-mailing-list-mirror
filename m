Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FF351F461
	for <e@80x24.org>; Sun,  7 Jul 2019 08:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfGGIah (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jul 2019 04:30:37 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55103 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfGGIah (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jul 2019 04:30:37 -0400
Received: by mail-wm1-f67.google.com with SMTP id p74so9839194wme.4
        for <git@vger.kernel.org>; Sun, 07 Jul 2019 01:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RetiA+W1eTThTCCBpHHqECn+7yMa7LOUJdodRMbCBtc=;
        b=U3JtNutTquWIHy7fWkqfmrPbKdfMlaHchOaBjUiKjVrxy2QO5uanOfdRXBhx+/upeV
         QYYEgvb/Ab96WJB6WnyNao6k/GqtVLvPbpFjyS3Jz8t7+qU54NjwTA88eFbGE5uU5Uzz
         D1qZ+oKN9sRjv/TVLyu9DOq/Um5zT7nRWilTvd7LQ7RJZs8zEcZ0nLODcfDgkHZE1yr6
         l9dfarRlwy/VF7THc+kARigcYBRsFMLkh4q37UDesM7gEowBoPi3uAJ5AtfuEkr/SOEe
         AWRhh/pj6+ta2Cuv/8x+A/Ih8XGIvO0rTgzYMbSF3/sd1AolmdnjnxDk8pYfIqLO0wIT
         POMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RetiA+W1eTThTCCBpHHqECn+7yMa7LOUJdodRMbCBtc=;
        b=LTR9+/xRzM0lt3BuWYeUb1rpcUxJPzsygciE3N9GDiv9vZRnTB5T4uNpW99+YCJ8Zi
         BH2xsU8jNPngtqpLUgKKs2wPwRsdrnPW1L/1jbsF7++6eg+djpyNVWNKzopDjfO2g6GD
         UZBjz2LFitOvFf/TAXTUxWeWR7SPWsmVDyBLMD7bx9sZH3q51TNYbBdeErLRF30noRoK
         jWGJv8x7pkFSO7kH37WLgHZ3nPcsI8FABkMrV++aCVYuhgVxzNIcZ0AFSfwVh/XAPyCD
         y4zyyIvxzPnifxLIsBQ7aVvPp/KUbOxzdFErkyvgmNZ23cpws2N89AVgUC1sZaKED6E8
         zM+Q==
X-Gm-Message-State: APjAAAUSwD1Cv89Tyg3pznoQbdd9G/l+gD9WCUaY110WUxfCWR8YZ8tn
        OB7KMsspF0L7UzoCLLFvZ5ZdWw+vwDc=
X-Google-Smtp-Source: APXvYqxBbMwTnlie8LuGkRzA5nZwQlTW4/lRuYmGyTuxDcU0bC7tEmKrGf6KfBNDs+4oOzQ1PAvq6w==
X-Received: by 2002:a05:600c:2182:: with SMTP id e2mr11236699wme.104.1562488234473;
        Sun, 07 Jul 2019 01:30:34 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:10c1:a195:f489:5ba4:f140:8c9a])
        by smtp.gmail.com with ESMTPSA id u186sm9606319wmu.26.2019.07.07.01.30.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 07 Jul 2019 01:30:33 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC PATCH 4/5] test-oidmap: add 'get_all' subcommand
Date:   Sun,  7 Jul 2019 10:30:01 +0200
Message-Id: <20190707083002.7037-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.514.g3228928bce.dirty
In-Reply-To: <20190707083002.7037-1-chriscool@tuxfamily.org>
References: <20190707083002.7037-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's make it possible to test oidmap_get_next() by adding a 'get_all'
subcommand that calls oidmap_get() once first and then oidmap_get_next()
several times until there is no more entry with the same oid key.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/helper/test-oidmap.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/helper/test-oidmap.c b/t/helper/test-oidmap.c
index c19b41aa4f..5c4897ce59 100644
--- a/t/helper/test-oidmap.c
+++ b/t/helper/test-oidmap.c
@@ -95,6 +95,23 @@ int cmd__oidmap(int argc, const char **argv)
 			/* print result */
 			puts(entry ? entry->name : "NULL");
 
+		} else if (!strcmp("get_all", cmd) && p1) {
+
+			if (get_oid(p1, &oid)) {
+				printf("Unknown oid: %s\n", p1);
+				continue;
+			}
+
+			/* lookup entry in oidmap */
+			entry = oidmap_get(&map, &oid);
+
+			/* print result */
+			puts(entry ? entry->name : "NULL");
+
+			if (entry)
+				while ((entry = oidmap_get_next(&map, entry)))
+					puts(entry ? entry->name : "NULL");
+
 		} else if (!strcmp("remove", cmd) && p1) {
 
 			if (get_oid(p1, &oid)) {
-- 
2.22.0.514.g3228928bce.dirty


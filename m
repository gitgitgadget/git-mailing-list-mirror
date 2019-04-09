Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B96EA20379
	for <e@80x24.org>; Tue,  9 Apr 2019 16:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfDIQMB (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 12:12:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35601 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfDIQL7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 12:11:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id w1so21694731wrp.2
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 09:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WGKD4t9/zQ0RVOKMppZZy5F8GoXk2Na8IU5uUJMWMnw=;
        b=QO8duTw2r4W7+GFJKu6ZrXZd1hTvO7pB1XXA/Y+efKDpRRuJIuU4qjmw8q5wyY+Tb7
         70oMeDaNkDj8Q5oyLRy8zDv4Fxv7Uvcin/hhVxWRrWGtXIn9zhu20nlBqTscPiMMRPzC
         ALQOR06WSemjx+gEbcBh0tlRLFKs2AAiTwuglUuXXP8VSJt0cRQKzzrdjxMkD89SZYE2
         gg4y+XkaN1Uxfu0TklAXk8pd9l5gckNwShKiVi4cUABMzy8dtAfqHqnfr5AgiUmlsYI2
         Ek4ld9HN+fbdfjYq6U+UrObMlWj6GY45UAaf9XhEiszJskCLSvdHCnx/LVwtnw88Df+z
         y/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WGKD4t9/zQ0RVOKMppZZy5F8GoXk2Na8IU5uUJMWMnw=;
        b=CbpGNMbAzmW9r9ecn4F82qfJbDP8i06WM2zpYiFC4DFP4Wq3D0PW3G2a+80HNNKASS
         Vzco5ndjhp6OLQ8t/ahLY9peuoIZJd5cy980rDl7wkPSgypAp9sqg05XIKuFfW2Zi4/e
         T8M/dRS1J4vbBmtntG0d4kBqGnJGAEoXtM4II0xNT/KOx0D00DRUQV9tkRpPzmoWB5I1
         I40Z1hn33zJ5/0W8IQ7+BwnnzNZSFe5hv9uRgbq/3hK1zekBiq9y7MYO886uAsbGY6dZ
         BVsgIXXqVJOZ8Oonjhr4u9bu1LOjv6FuurzWqjR1ErpVuWa9Ix4JOG5OEWFccuXlFxQk
         KUVg==
X-Gm-Message-State: APjAAAUlhWzgm0rlGa6htCHceF32Rpi+SXf071wANbId0YhaGuSHDEAD
        qPnOTf3zbiPjoS/RAiWkjDaEOIVS
X-Google-Smtp-Source: APXvYqyfsiE0quxq8oXxtFUgCMGdPJiC5CzHsB72Bd6h6wHj8nWupvstCorwbWXlUNssuflftjPixw==
X-Received: by 2002:adf:fc0b:: with SMTP id i11mr5572635wrr.145.1554826316994;
        Tue, 09 Apr 2019 09:11:56 -0700 (PDT)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id i2sm4356012wmg.47.2019.04.09.09.11.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 09:11:55 -0700 (PDT)
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
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 10/16] builtin/fetch: remove unique promisor remote limitation
Date:   Tue,  9 Apr 2019 18:11:10 +0200
Message-Id: <20190409161116.30256-11-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.750.g68c8ebb2ac
In-Reply-To: <20190409161116.30256-1-chriscool@tuxfamily.org>
References: <20190409161116.30256-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As the infrastructure for more than one promisor remote
has been introduced in previous patches, we can remove
code that forbids the registration of more than one
promisor remote.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/fetch.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 13d8133130..5657d054ec 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1465,26 +1465,16 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 		return;
 
 	/*
-	 * If this is the FIRST partial-fetch request, we enable partial
-	 * on this repo and remember the given filter-spec as the default
-	 * for subsequent fetches to this remote.
+	 * If this is a partial-fetch request, we enable partial on
+	 * this repo if not already enabled and remember the given
+	 * filter-spec as the default for subsequent fetches to this
+	 * remote.
 	 */
-	if (!has_promisor_remote() && filter_options.choice) {
+	if (filter_options.choice) {
 		partial_clone_register(remote->name, &filter_options);
 		return;
 	}
 
-	/*
-	 * We are currently limited to only ONE promisor remote and only
-	 * allow partial-fetches from the promisor remote.
-	 */
-	if (!promisor_remote_find(remote->name)) {
-		if (filter_options.choice)
-			die(_("--filter can only be used with the remote "
-			      "configured in extensions.partialClone"));
-		return;
-	}
-
 	/*
 	 * Do a partial-fetch from the promisor remote using either the
 	 * explicitly given filter-spec or inherit the filter-spec from
-- 
2.21.0.750.g68c8ebb2ac


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F32241F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 18:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751663AbdB0Szn (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 13:55:43 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36719 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751637AbdB0Szm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 13:55:42 -0500
Received: by mail-wm0-f68.google.com with SMTP id r18so14853050wmd.3
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 10:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TZf1LI6W6S6NIVVUxW9/FgpkQYoSrw/kTUI992Uyjxo=;
        b=XiZ+DRt1slk5qSOa8DNH4HpqSAdp9fKlQn6jYdL4WEVRM7Vgxuy+EIEw2nBVzmhG2Q
         slzBEtTbMG5uWqXcQkc3IlUoQHhIIjdkR4MV2sTbuTTjLra0Iyam3Eouiry8b1ppfNqU
         tf2AAF10ZZ9saXk6JuAAwOApFmXo57ldaKwu78xIYsSnYc7EOZ5ZfTECiYfl2VuCVVSj
         RzhmVKqjKToe3h+tpo1sbd6UImCvmHxg6D++P3SxUmV7UNKSVkbiPhIdbEabseh0SWXd
         bZmf4MIcHlv9WwsYpTc97rA2oCpBNfKPSDvz6vGhOz6A1USSwvvUkmiP/vIYjDS0lr8Z
         A1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TZf1LI6W6S6NIVVUxW9/FgpkQYoSrw/kTUI992Uyjxo=;
        b=t7DcWtzyoTKN6vOfLGwJ0ojXHYdpzrlKnMKBGIXQAEKoTxHEr4YZHcMQzywGB3IV7E
         RUWYQiC1Pc+A34fy3jth8W28ZW6W0J+GguK5vvRZiKFnhrB0J7h9h/8whNCsTRY+Xx9Z
         Yd53BRwufyq/Tpp5HASG2rfh8pqBvbOo/Nh9rqFjkMFXb4js7uScfWIPvKeQWkdvF7mM
         o8Tsychxx/KgHYeHrEAoZyKEqfoFdNwZcfW/R6KK0xYW2nn8slDATqPWt/dEfd6JRVys
         1HXkw+3YpZkJACrnnHSQAlazqe/mrRYQIP1VhEVZg3uQd2oiMWR1Q/E3RbcdMatlNtUo
         qLJA==
X-Gm-Message-State: AMke39l5XOignkBELUFphURaiVBR8iskehSre13dL586fEFZ4Pqdu5UYuPJHXins/eVKWw==
X-Received: by 10.28.153.139 with SMTP id b133mr13831474wme.93.1488218454934;
        Mon, 27 Feb 2017 10:00:54 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id e73sm15226798wmi.32.2017.02.27.10.00.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 10:00:54 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 13/22] Documentation/config: add splitIndex.maxPercentChange
Date:   Mon, 27 Feb 2017 19:00:10 +0100
Message-Id: <20170227180019.18666-14-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.22.g0672473d40
In-Reply-To: <20170227180019.18666-1-chriscool@tuxfamily.org>
References: <20170227180019.18666-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 61a863adeb..8e745bda52 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2831,6 +2831,19 @@ showbranch.default::
 	The default set of branches for linkgit:git-show-branch[1].
 	See linkgit:git-show-branch[1].
 
+splitIndex.maxPercentChange::
+	When the split index feature is used, this specifies the
+	percent of entries the split index can contain compared to the
+	total number of entries in both the split index and the shared
+	index before a new shared index is written.
+	The value should be between 0 and 100. If the value is 0 then
+	a new shared index is always written, if it is 100 a new
+	shared index is never written.
+	By default the value is 20, so a new shared index is written
+	if the number of entries in the split index would be greater
+	than 20 percent of the total number of entries.
+	See linkgit:git-update-index[1].
+
 status.relativePaths::
 	By default, linkgit:git-status[1] shows paths relative to the
 	current directory. Setting this variable to `false` shows paths
-- 
2.12.0.22.g0672473d40


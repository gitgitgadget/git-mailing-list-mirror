Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 929A31F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 19:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751704AbdB0TI4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 14:08:56 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34864 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751510AbdB0TIy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 14:08:54 -0500
Received: by mail-wm0-f68.google.com with SMTP id u63so14864891wmu.2
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 11:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3cKlTU6qwEbGfjmbgyrfPDc938Xs9WUjOUbhzzSH8oE=;
        b=ewDJaS9H3uyxd2NJ2nVIHS/KxDFCdJbRPjYDH2kO6fK03bQOcFj/klv0KF+1k8zPE6
         Riyc8JaS29vyQlUC3l4epinwvnYbHJEueU7tvRoCqb1yuEN0OURR2T99plNGj03WvrN8
         TlxHecU999LLKE5HPm0mTCDvQUs9a/bvPBiwbNttT+JMuDJLMgTRQQH5JUXJ3BP+6e7L
         RGroDq8nwQNo6+X6QelYE9WNgrW2v2pGY5bNcbTsyVLrP9xRlse3aNso3/rjgh2nJeNg
         9TAvITbVKxEsuLdk3/Cy04P96q6PWkT7ArRfbHR/3GeM0/V2vf26O8Rsm9x4KxtquqlN
         KlfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3cKlTU6qwEbGfjmbgyrfPDc938Xs9WUjOUbhzzSH8oE=;
        b=kezgMA6raNcqu6pQcQNJxObE2dGDZ/FrKplNQjzuwLzmWXUk3vRIDLLbYbKdY5D6Jw
         lzsLYWIX0gH8+dAhXuyoM09OA6LQBHi+Gb4is7qjXkbr5OC23taVdqoD14i98muyVEcM
         Jec1sJWiDUEWAUlojr4ZGWhiO4cW2ywPWzeKj+/aoUVJJaJfNeMh559crt+etmbNYFYv
         bdXnBCBN7yTLoMgEMPlsneAcAlpMldtVV/q811blgH5EtYtLCDgSpQE9l7iASLbF9ePV
         TSfHcn5oML8tM7FfPEdJETxf55DsKRdAFxzfzB7eQtR1J9ioYsuAfzeomFF5q5OrobNv
         vErg==
X-Gm-Message-State: AMke39kye2w/a4qRd6aVoWI8y24jTDmhd4p8lEWJWjoE8JmXOxETcreLMuXQ9K5UJVPhdQ==
X-Received: by 10.28.184.198 with SMTP id i189mr13618166wmf.26.1488218466302;
        Mon, 27 Feb 2017 10:01:06 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id e73sm15226798wmi.32.2017.02.27.10.01.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 10:01:04 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 21/22] Documentation/config: add splitIndex.sharedIndexExpire
Date:   Mon, 27 Feb 2017 19:00:18 +0100
Message-Id: <20170227180019.18666-22-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.22.g0672473d40
In-Reply-To: <20170227180019.18666-1-chriscool@tuxfamily.org>
References: <20170227180019.18666-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8e745bda52..0e9982c5e3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2844,6 +2844,18 @@ splitIndex.maxPercentChange::
 	than 20 percent of the total number of entries.
 	See linkgit:git-update-index[1].
 
+splitIndex.sharedIndexExpire::
+	When the split index feature is used, shared index files that
+	were not modified since the time this variable specifies will
+	be removed when a new shared index file is created. The value
+	"now" expires all entries immediately, and "never" suppresses
+	expiration altogether.
+	The default value is "2.weeks.ago".
+	Note that a shared index file is considered modified (for the
+	purpose of expiration) each time a new split-index file is
+	created based on it.
+	See linkgit:git-update-index[1].
+
 status.relativePaths::
 	By default, linkgit:git-status[1] shows paths relative to the
 	current directory. Setting this variable to `false` shows paths
-- 
2.12.0.22.g0672473d40


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71D8920229
	for <e@80x24.org>; Sun, 23 Oct 2016 09:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756371AbcJWJ1a (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 05:27:30 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32901 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756330AbcJWJ1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 05:27:24 -0400
Received: by mail-wm0-f67.google.com with SMTP id d128so5249080wmf.0
        for <git@vger.kernel.org>; Sun, 23 Oct 2016 02:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oH/FloFupgLzxibsd+cG6tzwj60O68JaBDpBGOTfpoo=;
        b=ge2Y8HzXA4J4cvY+jJBWZekTEXoXGNorYi5MjWN298zBcKksJehwANdNKhmfGV5lF+
         1XoEPPdjqJXXbLxI3fR7SadonnIcLNrFVvs5vMy72m3Im+1x9F/tCdk0mR7X0En36STe
         bXyZ8lA1GHkZFaiR0dInJXUUEi/0NicT7sZ9g98zR8BzlnR6ombvj/RWoZRh4W8dd6Nc
         PG4A071UJzTvilhTtIvUBw9IjDFF8wHMd1+0XsvZ8F4PsZ3YYnfZ6RLbSu6r4u0MwVN4
         nlyBp06yWwikbq0NuYWvVHAuOiXz0eQFpG0Yo5SDom0as5WJtGIXWviBRnnMQso6CAix
         LNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oH/FloFupgLzxibsd+cG6tzwj60O68JaBDpBGOTfpoo=;
        b=eg26PpM4GiujYLgpTrUcUVn/t4w2QuhDXMMVs7Kd87LkiS8xobO5Yqohxfl0uuCaG/
         zvqX4pXeAMdtoegD5kBFwXLBhaH87mxL1GPLOAGU3tJl4DNH9NtcTc15nPlZpPTkvgUz
         wghBiL+dUw+J3fxAHz3l1thdhdZMADW6OYCDJtYH3E3A2yVlmBpoKOXdOJthNh8FTsme
         rT2TFTzGbiuHG0/OOGbdOUhbnu4gS4z1EkXe4xvVOeb4vPDZFLTdXGK3l7RNjXvyTt2P
         1/DgMxb79goOvXHd4qMtrYwW/+uzv7CbIbaBwX8L631lK0soo0uIS13HEgLGmggbGsm/
         v6KA==
X-Gm-Message-State: AA6/9Rk8+1qULgwaty5AwXlclOCHKropC66t2rBJLuxfr8hLkW8RGX25TC3dtZGHicn9Aw==
X-Received: by 10.28.128.143 with SMTP id b137mr10811606wmd.95.1477214843480;
        Sun, 23 Oct 2016 02:27:23 -0700 (PDT)
Received: from localhost.localdomain (183.187.113.78.rev.sfr.net. [78.113.187.183])
        by smtp.gmail.com with ESMTPSA id x138sm8257569wme.14.2016.10.23.02.27.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Oct 2016 02:27:22 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v1 12/19] Documentation/config: add splitIndex.maxPercentChange
Date:   Sun, 23 Oct 2016 11:26:41 +0200
Message-Id: <20161023092648.12086-13-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.1.462.g7e1e03a
In-Reply-To: <20161023092648.12086-1-chriscool@tuxfamily.org>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 96521a4..380eeb8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2763,6 +2763,19 @@ showbranch.default::
 	The default set of branches for linkgit:git-show-branch[1].
 	See linkgit:git-show-branch[1].
 
+splitIndex.maxPercentChange::
+	When the split index feature is used, this specifies the
+	percent of entries the split index can contain compared to the
+	whole number of entries in both the split index and the shared
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
2.10.1.462.g7e1e03a


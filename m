Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DB971F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 18:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751563AbdB0SCO (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 13:02:14 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33610 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751435AbdB0SCD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 13:02:03 -0500
Received: by mail-wm0-f67.google.com with SMTP id v77so14621021wmv.0
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 10:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+RJz4nTU4HOYGGdyL0Yne9twlgmM8a2UwfqFRBRY6y0=;
        b=mVkjerF2dXAdOjQIo52qYbDHMMZWsgV3Xk9j8M3uSvoVkQUhKo39tkzLRIyYGhbSPF
         rrP8O2LKtaCh/bIxvVi5nJovH5gNuzc6KwPCqPL/9+ZKbK91lRW4zwwuMwyz3uzRmqC3
         DcvS9cQWVKf5ZX4c01LchpmrvXMziF/MgNgs4Ce9r6axZOvbl3IfRZDW7nOtr7Mw7jv8
         +lUE/TZwxIc/jT4pOBvemRLkDlR71OAUEGEZoYgWIjEll23qqg6wC7rIKKUgkHcEzL4S
         31s8iVI/fE/U1PB+RM8AL2WKa4bMPqsixshV6kidt+aQid16kxZLjcqy2QVojce5L+Y4
         B74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+RJz4nTU4HOYGGdyL0Yne9twlgmM8a2UwfqFRBRY6y0=;
        b=qzyrtrud6JrdolPF4H+3wb+MKKfBwXz1yiC+r42v2VDZ6WJEgT5j02k44yAng28AiP
         e7Mp0p44caBz4cxpM3jyXyo6rWgYpbEmxq0A8/6pOW8b+JK6CAyZa5Tp73CVmYN7fgoX
         1cEoxhgQ/hZJsuXFt4f+d0hcnXpzlRw2zdvN9WdvQujUXeU+352KJvhWIipPzBRYdCTi
         6mUszY5qDu9DV2dtjg8NFglb3mVOfmYWHGrBY9U6HQIIkO3BjAF40HKD5yG1I4ERN5bi
         8szMsxPNmj51miJbUj/Ug/M3Q5fqV786GWJsu1CxU0bhO27UFc8uuje27ujOqjE+jpky
         47ow==
X-Gm-Message-State: AMke39n8AYVV0GV6ZEg2267cLY0d9ZgMn951Ybhwr4S0jU91sI3nMoIMEczcvuIXYxRAVQ==
X-Received: by 10.28.16.70 with SMTP id 67mr15560888wmq.142.1488218449428;
        Mon, 27 Feb 2017 10:00:49 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id e73sm15226798wmi.32.2017.02.27.10.00.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 10:00:48 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 09/22] Documentation/git-update-index: talk about core.splitIndex config var
Date:   Mon, 27 Feb 2017 19:00:06 +0100
Message-Id: <20170227180019.18666-10-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.22.g0672473d40
In-Reply-To: <20170227180019.18666-1-chriscool@tuxfamily.org>
References: <20170227180019.18666-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-update-index.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 7386c93162..e091b2a409 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -171,6 +171,12 @@ may not support it yet.
 	given again, all changes in $GIT_DIR/index are pushed back to
 	the shared index file. This mode is designed for very large
 	indexes that take a significant amount of time to read or write.
++
+These options take effect whatever the value of the `core.splitIndex`
+configuration variable (see linkgit:git-config[1]). But a warning is
+emitted when the change goes against the configured value, as the
+configured value will take effect next time the index is read and this
+will remove the intended effect of the option.
 
 --untracked-cache::
 --no-untracked-cache::
-- 
2.12.0.22.g0672473d40


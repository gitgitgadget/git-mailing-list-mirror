Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDA8C433EF
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 00:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383663AbiFRAVL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 20:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383585AbiFRAVH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 20:21:07 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660FC59322
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 17:21:06 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id a10so3002933wmj.5
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 17:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s/FNUD3Nfv1aJ56di/sqnJE/jJBUPQEIKWoIKlAJYVg=;
        b=ql24hsoCkWDrtZY2zSNAdHjH2rVyUNEkNv8NuA4GCltvnSGA67zL0K3deYhRq2A++K
         xSCYqK53XEk8JZJVpMB4t1VjmuDMLzzK4p0XJnDbMViSFGTPoQku3tc5mcJanLFdibXz
         7z9f3sjxcGH9MS5T4oGzzlVKDK4hNg9CWxmAgDnHxBATmcv3jOgiAUbmyOt3n8vBUzu9
         PcqCVtN6Lb4U62/Q3MWIzFn+n6N84KBAYdnUhpVoqHaUnk6UAMD6fAL6Ek1PlTXJJ+hn
         x+tu2MlVcozIBqq97wzpJ6vnL+fG6earaOUeuTJX7ypJFsh4ArpqJHKr20qlx2AXMza2
         6tKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=s/FNUD3Nfv1aJ56di/sqnJE/jJBUPQEIKWoIKlAJYVg=;
        b=3R/aGGneK/5Go6n5ocTv3yRfVA4a6Ss/y11wxWK35ScBELKB0gzby0q7w/Jr6EEi5/
         TnvamI1geS2yWtMAsmYt3djl5qCfb8NlYKRHLBCifpWzAQw/e0lC6DzhR60prfkBVQP9
         4yY0MpS59C2eLjmqqfuYp2Npn4zRJp2IvrxbcWtoU/v4y7s8fKqijNMeX0MDi75h7T0n
         V0UG48RUZ2KI5JHFCl4+kbFTKlyzbbLkhfijuIGJMivYSMa82uOCf26eZeN8hAWdjlWM
         UHqjf53Cb/z4WVaDmpIphk/NoaRNwCMZ1jUjAQsu4RFOgnri2NBpLhUwMTt+NBPAIfNw
         NhRw==
X-Gm-Message-State: AJIora/ABvTJEvP0olUgJWKvEXBN+vfUbDMitkKV1/llOx14wMlnd/iP
        8alC4TXOi0FePi9Fb3ucSkOyW3Sy8iaykQ==
X-Google-Smtp-Source: AGRyM1uUGxvNxNxvGTJsxnOR/KnAZfaVZhDlyGIcVpXQYf20a+04GzKLLg4vMPoz3ELZ/INzjngslg==
X-Received: by 2002:a05:600c:190b:b0:39c:7704:74a4 with SMTP id j11-20020a05600c190b00b0039c770474a4mr12397372wmq.92.1655511664358;
        Fri, 17 Jun 2022 17:21:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d8-20020adfc088000000b00213ba0cab3asm5996560wrf.44.2022.06.17.17.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 17:21:03 -0700 (PDT)
Message-Id: <8e0a79fa1ad0e1a86617e7f73f5534f5db9818e3.1655511660.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>
References: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
        <pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 18 Jun 2022 00:20:45 +0000
Subject: [PATCH v7 02/17] merge-tree: move logic for existing merge into new
 function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In preparation for adding a non-trivial merge capability to merge-tree,
move the existing merge logic for trivial merges into a new function.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge-tree.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 06f9eee9f78..914ec960b7e 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -366,15 +366,12 @@ static void *get_tree_descriptor(struct repository *r,
 	return buf;
 }
 
-int cmd_merge_tree(int argc, const char **argv, const char *prefix)
+static int trivial_merge(int argc, const char **argv)
 {
 	struct repository *r = the_repository;
 	struct tree_desc t[3];
 	void *buf1, *buf2, *buf3;
 
-	if (argc != 4)
-		usage(merge_tree_usage);
-
 	buf1 = get_tree_descriptor(r, t+0, argv[1]);
 	buf2 = get_tree_descriptor(r, t+1, argv[2]);
 	buf3 = get_tree_descriptor(r, t+2, argv[3]);
@@ -386,3 +383,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 	show_result();
 	return 0;
 }
+
+int cmd_merge_tree(int argc, const char **argv, const char *prefix)
+{
+	if (argc != 4)
+		usage(merge_tree_usage);
+	return trivial_merge(argc, argv);
+}
-- 
gitgitgadget


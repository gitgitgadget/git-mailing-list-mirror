Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ECCC433F5
	for <git@archiver.kernel.org>; Sun,  2 Jan 2022 17:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiABRQC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Jan 2022 12:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiABRP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jan 2022 12:15:56 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE0DC061784
        for <git@vger.kernel.org>; Sun,  2 Jan 2022 09:15:55 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id s1so65843685wrg.1
        for <git@vger.kernel.org>; Sun, 02 Jan 2022 09:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=JIocY6VcxAOywLFzw0OnVpMN7lpFCNvRMkP6pq4asjc=;
        b=jeSzlmwDJtHO9JDEm0sRr+et/VbUpBMvN9Mus30y2Pks1Pl3grnnp+wqyHjU4kI23s
         ZHHiMrIOwflF4WjiZ5HJ22EVE5NKPSRMIoymwFy2Y/yvd8ecq8cIPobsCtEEzELq+q0m
         LAqC6fA6JEwCeUlDA6NL0kPNocHYDqQp8bw9FnFsKNC6WAcbP29A9q9W5MA4jLH+B2l1
         TzerMpT4jkxaMaWoOz+wtOe77rx/4nKJ4yrcfU49V/jpKCyiHQHkZnkfBLHp8r5aPUFh
         wfDAdnBPcEl2zZ1GLy2DqLk7YA+1WT7V1UB6k+Sm9wZ5zd9mq50K58Cy48xbQfYVt4xs
         BaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=JIocY6VcxAOywLFzw0OnVpMN7lpFCNvRMkP6pq4asjc=;
        b=Ii7yO7muWH4VSPrbIBGoWXsuDZeomLFsj4VJArnjzMcq19xrXdq5dNrpPEZoq4oFS1
         +M5o3yuKVFyH+xddCLISvFgVI0rVc/sCbWjKKysVfQ1ZmLF4sOh/cisVwQ2PSfY2JT3c
         9A7/6Iz2/sG0EBwIYDvvmBM3cDMs/gnnsYMW7YRb47BJqnHfWQgDRsUq8VNkOTdWiKzs
         +RwkEN5MCVHd9KDYPRucSppgpOXOBuS61MBsOFypK5rMVWntMPWSUwzAw7jNBfkplarK
         i9pWv9jnTIWKzxepxe7b7Z+vqU+0QJmLeB0/D+xRZOPEGlKtDsiLIMKUSGgTQtX6N2yJ
         9xag==
X-Gm-Message-State: AOAM532htNh5O7UN5MZWiAST5X0QLA1kt3nfXCwKikONNOnjKADlLf32
        qam5Fia14HUe7tePVHN7KYnT0OkmyQw=
X-Google-Smtp-Source: ABdhPJzaH+18yJHjApBWnUiCSdJwJImfWbmy/T8U4Fq1IFCdfvUw2BY4Et7/R5SDZ2UpzHcbqst2jQ==
X-Received: by 2002:adf:dd8b:: with SMTP id x11mr25556796wrl.626.1641143754293;
        Sun, 02 Jan 2022 09:15:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n12sm35503774wrf.29.2022.01.02.09.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 09:15:53 -0800 (PST)
Message-Id: <052dc06beeb653873c762ae308d01dc57ce7e1bc.1641143746.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v4.git.1641143745.gitgitgadget@gmail.com>
References: <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com>
        <pull.1088.v4.git.1641143745.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sun, 02 Jan 2022 17:15:41 +0000
Subject: [PATCH v4 07/11] i18n: factorize "no directory given for --foo"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 git.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git.c b/git.c
index 7edafd8ecff..edda922ce6d 100644
--- a/git.c
+++ b/git.c
@@ -185,7 +185,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--git-dir")) {
 			if (*argc < 2) {
-				fprintf(stderr, _("no directory given for --git-dir\n" ));
+				fprintf(stderr, _("no directory given for '%s' option\n" ), "--git-dir");
 				usage(git_usage_string);
 			}
 			setenv(GIT_DIR_ENVIRONMENT, (*argv)[1], 1);
@@ -213,7 +213,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--work-tree")) {
 			if (*argc < 2) {
-				fprintf(stderr, _("no directory given for --work-tree\n" ));
+				fprintf(stderr, _("no directory given for '%s' option\n" ), "--work-tree");
 				usage(git_usage_string);
 			}
 			setenv(GIT_WORK_TREE_ENVIRONMENT, (*argv)[1], 1);
@@ -297,7 +297,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "-C")) {
 			if (*argc < 2) {
-				fprintf(stderr, _("no directory given for -C\n" ));
+				fprintf(stderr, _("no directory given for '%s' option\n" ), "-C");
 				usage(git_usage_string);
 			}
 			if ((*argv)[1][0]) {
-- 
gitgitgadget


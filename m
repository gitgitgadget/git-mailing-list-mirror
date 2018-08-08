Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 859EB1F405
	for <e@80x24.org>; Wed,  8 Aug 2018 18:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbeHHVU2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 17:20:28 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50850 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729679AbeHHVU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 17:20:28 -0400
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so3828008wmc.0
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 11:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VzqUei0Z7ZVIhIO+ORpYApb9++fZM2BUC2oYy8eU9v0=;
        b=W5pP4mSW09+9+ULWZZgc4mMXjm8SMalCFkJhLTeuoGVjuWLzTiVvaaOuzKWnuPHYnt
         A1/vjIcvFZe6pHBAPVgPnD+7HAPFKNd5vcUaDeGa6QlFQcpPFkH1KljJ2dJ6vQOdlwGr
         XGNE6wiswZ/dciQ9yTBFCwCMh0Kv8k/eMQ0f2Nf6ZyCpZvLMr9hhFf6RGNxGoZkzyJRY
         2NUl/sBiHVKD/FuzaD/22RKg3VWUxJyBAEofDswZTE+cMYBqsljcetlhYNOcoa3oTwKl
         fxLhvVjax++PJfSsDyatCdV+2LN1AMaHNEgp2pSYTaGu1xLLw7IJrs8G52PM9PNeQ46A
         uJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VzqUei0Z7ZVIhIO+ORpYApb9++fZM2BUC2oYy8eU9v0=;
        b=NCCgI9eS0DDnJmUldRB+V35bsbfxWYAIkWQ1OB5dwgUAgTMNOwxK6h4W9D1dyouxQm
         LKEZd5iKuO0Yij/2/l7Jss/4Qxb1Dve+HcjFnpB+jxeDBQ5mQc7W09nYEwY3uoF5oUjT
         MeAWsvpnL9SHvbgD8h8nbOq7dTH1uzWytOb6+m/RQR8WqMa2wPf6FTwd1x526eadeWm6
         taX0hJC/7mtEtan5NDfm9jSA4wi7fZWLvCg08Tq7KOxpVBmRrz73k7iYn0qKoN7zw/Ey
         NLo8pBgkhn5RCpoTBqyGjeZPieQkJU7VK78mjCVvsxCrWgS6jwo8yBb5MLArXYu0Vn01
         M0+Q==
X-Gm-Message-State: AOUpUlFDWD406Prie5EWqGAga9/O/RuvcOpIUrIF8mBEYSIFYyTMdwXE
        3FEcqXn2MKdsDhRuCpaQc0TiTsk0
X-Google-Smtp-Source: AA+uWPxa76IFun8/kq2+qa6yb0koJCs730kZkAEsd2YK1lMqHg6fZH/gPLvdBPamxEyMmfKjZmFVjA==
X-Received: by 2002:a1c:ae94:: with SMTP id x142-v6mr2805254wme.125.1533754766404;
        Wed, 08 Aug 2018 11:59:26 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([86.127.74.86])
        by smtp.gmail.com with ESMTPSA id p5-v6sm4238879wre.32.2018.08.08.11.59.25
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 11:59:25 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v7 11/26] stash: change `git stash show` usage text and documentation
Date:   Wed,  8 Aug 2018 21:58:50 +0300
Message-Id: <5e477e5a62c3e2cc7066487bf6e0a68c922457a5.1533753605.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.573.g56500d98f
In-Reply-To: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is already stated in documentation that it will accept any
option known to `git diff`, but not in the usage text and some
parts of the documentation.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 Documentation/git-stash.txt | 4 ++--
 builtin/stash--helper.c     | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 7ef8c4791..e31ea7d30 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git stash' list [<options>]
-'git stash' show [<stash>]
+'git stash' show [<options>] [<stash>]
 'git stash' drop [-q|--quiet] [<stash>]
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
@@ -106,7 +106,7 @@ stash@{1}: On master: 9cc0589... Add git-stash
 The command takes options applicable to the 'git log'
 command to control what is shown and how. See linkgit:git-log[1].
 
-show [<stash>]::
+show [<options>] [<stash>]::
 
 	Show the changes recorded in the stash entry as a diff between the
 	stashed contents and the commit back when the stash entry was first
diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index e764cd33e..0c1efca6b 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -13,7 +13,7 @@
 
 static const char * const git_stash_helper_usage[] = {
 	N_("git stash--helper list [<options>]"),
-	N_("git stash--helper show [<stash>]"),
+	N_("git stash--helper show [<options>] [<stash>]"),
 	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
 	N_("git stash--helper ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
 	N_("git stash--helper branch <branchname> [<stash>]"),
@@ -27,7 +27,7 @@ static const char * const git_stash_helper_list_usage[] = {
 };
 
 static const char * const git_stash_helper_show_usage[] = {
-	N_("git stash--helper show [<stash>]"),
+	N_("git stash--helper show [<options>] [<stash>]"),
 	NULL
 };
 
-- 
2.18.0.573.g56500d98f


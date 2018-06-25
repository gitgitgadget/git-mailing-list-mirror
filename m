Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE88D1F516
	for <e@80x24.org>; Mon, 25 Jun 2018 16:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755159AbeFYQqy (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 12:46:54 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37071 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754496AbeFYQqv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 12:46:51 -0400
Received: by mail-wm0-f67.google.com with SMTP id r125-v6so10759161wmg.2
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 09:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rsje8G+VfnEXQIh83nqCpeZgnHwSGsoQtEjUlH+y7Bc=;
        b=fhdpSsaizy16Be8YgaWqJklTsxBe4g9ShSNcadmYtq/ofsvE+ncmCjIXeHQiiGhTIQ
         WhTcA55krpoN9S7Fa9XWVowE8lDkfscm1es/+wLDG920Sfsfi8KuAs7ssxOLgj43R4tG
         Or1poXUqqOZnwHzbvWO9R+amWVnYhtKxkimKZItKpP8QPRUMHYhDv/DQ4bRAPm7SFhpu
         o707WLCN+LwfbFPAoFctf2/CBdfBl/5iQ0hoYgu+SXMyZdWhIbJk/M+qREjEQTZSRCoN
         70Ltv1IShaTb/6EAdM9oBvqeyT4uxzcX7DhbBWF1+gEZZZ2/kTI6CwnBc1YZ+T36Du5w
         i2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rsje8G+VfnEXQIh83nqCpeZgnHwSGsoQtEjUlH+y7Bc=;
        b=qsHeINyS1U0COet5f4lVirh5wIiN7mY7aYPY9wRWwYDmvYbBPdAJnPqBvGP5UcIsZX
         sxkHIYiGw5mHQr5Zw6BdDkPjbDT1AwqfFGil6c1+in6StDV1J2LEZcP6jZ9aHPzFCcOP
         ZL1onTXiYN9a7TxrqOsWqjgkcwqC/gYm0Oph+4uglkf/uL644CcZx7TcG7RXaatQftoi
         yfbDQvaifLTWfXHaAxUkcGWZoX+qPvN1WijrQvcKO+fWwnqwExyyYQFBdRYR03TNCb6I
         6cGe8cM6MGTU3E9no62QRM8/9Gaeuiwr2pKnB4muWHf6O2MBGg9g2bbOOA6FQf4Jbjgm
         byTw==
X-Gm-Message-State: APt69E1jMqaJlCJld8IWPQylX6R8rxggWqMNZMFiPHfli8o25Ej6wscg
        UV8JT1wfd7IBelPDQZ9EHQsxS06L
X-Google-Smtp-Source: ADUXVKJvShDwsfkvumKUWgE8ZN5HKH6FajXmrObIjS81x1itEyQ2U0UkwrR0aOr8jfPwurnVM3+xXA==
X-Received: by 2002:a1c:3504:: with SMTP id c4-v6mr1516154wma.59.1529945209393;
        Mon, 25 Jun 2018 09:46:49 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com (5-13-160-71.residential.rdsnet.ro. [5.13.160.71])
        by smtp.gmail.com with ESMTPSA id v10-v6sm26419997wrn.97.2018.06.25.09.46.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 09:46:48 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, joel@teichroeb.net, gitster@pobox.com
Subject: [PATCH v6 3/6] stash: change `git stash show` usage text and documentation
Date:   Mon, 25 Jun 2018 19:46:36 +0300
Message-Id: <8d428b70338821bddd5c3210cf49cc84753685f0.1529943789.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.13.g506fc12fb
In-Reply-To: <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
References: <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
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
index a7eba3fba..4f49fd04b 100644
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
2.18.0.rc2.13.g506fc12fb


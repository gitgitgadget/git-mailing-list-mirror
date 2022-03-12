Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF994C433EF
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 03:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiCLDMi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 22:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiCLDMc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 22:12:32 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6CE2923F7
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 19:11:26 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id u1so15554960wrg.11
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 19:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=g26RlMPpyFcmK3jXAO/KptnUTUYMnuE3CrJpnlUgMb8=;
        b=Q6o3E6fADtKucUXnaKZ+7wJPiX8J/RGHKWdMqaNRsh6v/ymSqdR5SEbsFo5yJ8mV7b
         cl8xa0WUe3HTE8h7eE9MaBMSTlYzrVw1Cb6NZDm7foYorX0Z2mOkF7k0mNY7usgVfHzi
         H3tI1jHNwAIqWRWoCJ/PV1GR/lbUfSVOcOmC8jKbMAW1/9KB5byvgJKZjsPN3JaqpeJe
         dUOooVkm9rrI18BqgH9JvQ1mQG/2rDmtg4BDBUr1ssoJUBXN1VwMU6WEA5YEB0CQuQWF
         VMy5Jallac+YhmudGrxipEGzjihxB7imyKjLRFFpIzejw03gGAbQalWlzi4caWh+aguC
         8TQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=g26RlMPpyFcmK3jXAO/KptnUTUYMnuE3CrJpnlUgMb8=;
        b=j4TTOskJGksvzfBKn2KD+ML+MFFX1lYdB8yYwLo55NOBtYnKoV6Qa2e5lujXth15rr
         FdiEhIotKEfnbhUXXic5dLm/8bKZXGwgQ6VNuAYcDCwj+MznhvVmDpyGIXY+7rEYYocx
         UPYW7htijkrKqy0jcqUYIXKNvEdruzP7C80H5YHAxiPkG0z0mpJtMjhqlmZrZ8aGKHSr
         Zc2XC0vqcRJIxAemzDUCt1M9qa8YKGgdum1o1sZBFB8m0b0McPHNYDMNvRNA+g1ipqzW
         aRRmX7rAphMvKEse3AQb9nYDB7jA7BjvO6gPKkM7eHAE9jNbBTmdzlB51x6gRMeQjp1B
         16GA==
X-Gm-Message-State: AOAM533a613AJQ56iz2jZNEP8cYQH96UYHVvqCyMQPi7V7rWo4aGaA1t
        9CZ3HgRBI6QM8htvP8SwZzx965AyPe8=
X-Google-Smtp-Source: ABdhPJzhY5DeM0ZqVGsRvYVV1VpcaEc8w9U06Qhc8ZTwL2t8msVea3o/YMOkMdMzK2gVUmXpfqwUCw==
X-Received: by 2002:adf:f68d:0:b0:203:7b96:a7ff with SMTP id v13-20020adff68d000000b002037b96a7ffmr9915675wrp.101.1647054685350;
        Fri, 11 Mar 2022 19:11:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i8-20020a1c5408000000b00389bf11ba0csm11911813wmb.38.2022.03.11.19.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 19:11:25 -0800 (PST)
Message-Id: <8eab21996c7984a31cb954dd787ee54ce77dfa69.1647054681.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
        <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Mar 2022 03:11:15 +0000
Subject: [PATCH v2 3/9] git-sparse-checkout.txt: wording updates for the cone
 mode default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Now that cone mode is the default, we'd like to focus on the arguments
to set/add being directories rather than patterns, and it probably makes
sense to provide an earlier heads up that files from leading directories
get included as well.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-sparse-checkout.txt | 31 +++++++++++++--------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 4ef03120797..42a984306bb 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -44,9 +44,9 @@ COMMANDS
 	Enable the necessary sparse-checkout config settings
 	(`core.sparseCheckout`, `core.sparseCheckoutCone`, and
 	`index.sparse`) if they are not already set to the desired values,
-	and write a set of patterns to the sparse-checkout file from the
-	list of arguments following the 'set' subcommand. Update the
-	working directory to match the new patterns.
+	populate the sparse-checkout file from the list of arguments
+	following the 'set' subcommand, and update the working directory to
+	match.
 +
 To ensure that adjusting the sparse-checkout settings within a worktree
 does not alter the sparse-checkout settings in other worktrees, the 'set'
@@ -60,15 +60,15 @@ When the `--stdin` option is provided, the directories or patterns are
 read from standard in as a newline-delimited list instead of from the
 arguments.
 +
-When `--cone` is passed or `core.sparseCheckoutCone` is not false, the
-input list is considered a list of directories.  This allows for
-better performance with a limited set of patterns (see 'CONE PATTERN
-SET' below).  The input format matches the output of `git ls-tree
---name-only`.  This includes interpreting pathnames that begin with a
-double quote (") as C-style quoted strings.  Note that the set command
-will write patterns to the sparse-checkout file to include all files
-contained in those directories (recursively) as well as files that are
-siblings of ancestor directories.
+By default, the input list is considered a list of directories, matching
+the output of `git ls-tree -d --name-only`.  This includes interpreting
+pathnames that begin with a double quote (") as C-style quoted strings.
+Note that all files under the specified directories (at any depth) will
+be included in the sparse checkout, as well as files that are siblings
+of either the given directory or any of its ancestors (see 'CONE PATTERN
+SET' below for more details).  In the past, this was not the default,
+and `--cone` needed to be specified or `core.sparseCheckoutCone` needed
+to be enabled.
 +
 When `--no-cone` is passed or `core.sparseCheckoutCone` is false,
 the input list is considered a list of patterns.  This mode is harder
@@ -208,10 +208,9 @@ the following patterns:
 This says "include everything in root, but nothing two levels below root."
 
 When in cone mode, the `git sparse-checkout set` subcommand takes a list of
-directories instead of a list of sparse-checkout patterns. In this mode,
-the command `git sparse-checkout set A/B/C` sets the directory `A/B/C` as
-a recursive pattern, the directories `A` and `A/B` are added as parent
-patterns. The resulting sparse-checkout file is now
+directories. In this mode, the command `git sparse-checkout set A/B/C` sets
+the directory `A/B/C` as a recursive pattern, the directories `A` and `A/B`
+are added as parent patterns. The resulting sparse-checkout file is now
 
 ----------------
 /*
-- 
gitgitgadget


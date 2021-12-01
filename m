Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CECBC433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 00:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345580AbhLAAIg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 19:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345557AbhLAAId (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 19:08:33 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CE8C061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 16:05:12 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id d9so27246022wrw.4
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 16:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zhBArD7PqyLyxVK2f2ws846ey9m8rsBoKAlGG4gZDsE=;
        b=ZuwuzaOmD+q1nludA+DpCf+m5tF0aepY5UssnDi+oqlAK/bXa5ehj/PRpk+Kybl1K3
         GZf1qjq5jSYBFwn6F+mgh4EEQlAmJdOb/mT+61VUaxek8PratusKPh/qQinD0shYOq8k
         pUNbfo0eCwR0PS2zbPo/34GemLB1kfyW63QplfHB11NySpn8WBpN7YrEnTm6zygRTvk9
         nU1pCpvQTlf869bDQKza5G1sjALOXPTmFE4fNHeN4dp9Ii8v1B5ugPohXMbJpjlzUWe3
         IdnZ9c5lHjxzlgIE5cDkR2mrkRqH8KcjNp+oimllzK6xoCvqSriDhTIWhAxy0ioPcBmd
         Z+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zhBArD7PqyLyxVK2f2ws846ey9m8rsBoKAlGG4gZDsE=;
        b=REjUm7J2yEO9LI2N220+6QLIMRs96pzOP/uOP94s6I2Qnt7FwoIxWFAgdjhPEUVI9l
         U26G7fNG2wqpHYXF0Y9qUmGdPvJIMSys6ZcTwuHalyyCXgjRCUgv3NNOowfhAYMSCnzD
         sTEINVWf8OABxf4lAjJyzBxgG1bfWbUUI6kavHJh7zCW9uD9lqOpiXRof86ybZpWbG1V
         X4tNxDXizMJkItHJQLpkEJgEGFINDzDQyWTB7rQkZU667uhRs0seUzH3+Nc/pdKtfxin
         64isOMa1Re9yZXKsqeiFyJVweOmAEjEMXi1bso35bUAg6pO1b/i8y/NY6KDOA56GqhXW
         GO8g==
X-Gm-Message-State: AOAM5322vyRrAqAgVXa8CHxTbWDYC470gmoUWRv5hfwTxsNuv+WwbigO
        zrmSJMXuKKlYY7kK99AOhkGW2HiT+4w=
X-Google-Smtp-Source: ABdhPJx2rDqwFPbsID5E3CxHpdfdTLtPCobYPLirfLwmkLZ58gV454u74uHH3r0o0oPjmO/vIDZ9Ag==
X-Received: by 2002:a05:6000:1a45:: with SMTP id t5mr2670755wry.306.1638317110900;
        Tue, 30 Nov 2021 16:05:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n7sm17358489wro.68.2021.11.30.16.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 16:05:10 -0800 (PST)
Message-Id: <409ae2bbd85c20a88347a4e1b8afdddcb7c82e5d.1638317108.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1036.v5.git.git.1638317108.gitgitgadget@gmail.com>
References: <pull.1036.v4.git.git.1637028785.gitgitgadget@gmail.com>
        <pull.1036.v5.git.git.1638317108.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Dec 2021 00:05:07 +0000
Subject: [PATCH v5 2/2] update documentation for new zdiff3 conflictStyle
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/config/merge.txt     |  9 ++++++++-
 Documentation/git-checkout.txt     |  3 +--
 Documentation/git-merge-file.txt   |  3 +++
 Documentation/git-merge.txt        | 32 +++++++++++++++++++++++++-----
 Documentation/git-rebase.txt       |  6 +++---
 Documentation/git-restore.txt      |  3 +--
 Documentation/git-switch.txt       |  3 +--
 Documentation/technical/rerere.txt | 10 +++++-----
 builtin/checkout.c                 |  2 +-
 9 files changed, 50 insertions(+), 21 deletions(-)

diff --git a/Documentation/config/merge.txt b/Documentation/config/merge.txt
index e27cc639447..99e83dd36e5 100644
--- a/Documentation/config/merge.txt
+++ b/Documentation/config/merge.txt
@@ -4,7 +4,14 @@ merge.conflictStyle::
 	shows a `<<<<<<<` conflict marker, changes made by one side,
 	a `=======` marker, changes made by the other side, and then
 	a `>>>>>>>` marker.  An alternate style, "diff3", adds a `|||||||`
-	marker and the original text before the `=======` marker.
+	marker and the original text before the `=======` marker.  The
+	"merge" style tends to produce smaller conflict regions than diff3,
+	both because of the exclusion of the original text, and because
+	when a subset of lines match on the two sides they are just pulled
+	out of the conflict region.  Another alternate style, "zdiff3", is
+	similar to diff3 but removes matching lines on the two sides from
+	the conflict region when those matching lines appear near either
+	the beginning or end of a conflict region.
 
 merge.defaultToUpstream::
 	If merge is called without any commit argument, merge the upstream
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index b1a6fe44997..85c3d3513f7 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -265,8 +265,7 @@ When switching branches with `--merge`, staged changes may be lost.
 	The same as `--merge` option above, but changes the way the
 	conflicting hunks are presented, overriding the
 	`merge.conflictStyle` configuration variable.  Possible values are
-	"merge" (default) and "diff3" (in addition to what is shown by
-	"merge" style, shows the original contents).
+	"merge" (default), "diff3", and "zdiff3".
 
 -p::
 --patch::
diff --git a/Documentation/git-merge-file.txt b/Documentation/git-merge-file.txt
index f8560326132..7e9093fab60 100644
--- a/Documentation/git-merge-file.txt
+++ b/Documentation/git-merge-file.txt
@@ -70,6 +70,9 @@ OPTIONS
 --diff3::
 	Show conflicts in "diff3" style.
 
+--zdiff3::
+	Show conflicts in "zdiff3" style.
+
 --ours::
 --theirs::
 --union::
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index e4f3352eb58..e8cecf5a51d 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -240,7 +240,8 @@ from the RCS suite to present such a conflicted hunk, like this:
 
 ------------
 Here are lines that are either unchanged from the common
-ancestor, or cleanly resolved because only one side changed.
+ancestor, or cleanly resolved because only one side changed,
+or cleanly resolved because both sides changed the same way.
 <<<<<<< yours:sample.txt
 Conflict resolution is hard;
 let's go shopping.
@@ -261,16 +262,37 @@ side wants to say it is hard and you'd prefer to go shopping, while the
 other side wants to claim it is easy.
 
 An alternative style can be used by setting the "merge.conflictStyle"
-configuration variable to "diff3".  In "diff3" style, the above conflict
-may look like this:
+configuration variable to either "diff3" or "zdiff3".  In "diff3"
+style, the above conflict may look like this:
 
 ------------
 Here are lines that are either unchanged from the common
-ancestor, or cleanly resolved because only one side changed.
+ancestor, or cleanly resolved because only one side changed,
 <<<<<<< yours:sample.txt
+or cleanly resolved because both sides changed the same way.
 Conflict resolution is hard;
 let's go shopping.
-|||||||
+||||||| base:sample.txt
+or cleanly resolved because both sides changed identically.
+Conflict resolution is hard.
+=======
+or cleanly resolved because both sides changed the same way.
+Git makes conflict resolution easy.
+>>>>>>> theirs:sample.txt
+And here is another line that is cleanly resolved or unmodified.
+------------
+
+while in "zdiff3" style, it may look like this:
+
+------------
+Here are lines that are either unchanged from the common
+ancestor, or cleanly resolved because only one side changed,
+or cleanly resolved because both sides changed the same way.
+<<<<<<< yours:sample.txt
+Conflict resolution is hard;
+let's go shopping.
+||||||| base:sample.txt
+or cleanly resolved because both sides changed identically.
 Conflict resolution is hard.
 =======
 Git makes conflict resolution easy.
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 506345cb0ed..dd9830dc5f8 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -741,9 +741,9 @@ information about the rebased commits and their parents (and instead
 generates new fake commits based off limited information in the
 generated patches), those commits cannot be identified; instead it has
 to fall back to a commit summary.  Also, when merge.conflictStyle is
-set to diff3, the apply backend will use "constructed merge base" to
-label the content from the merge base, and thus provide no information
-about the merge base commit whatsoever.
+set to diff3 or zdiff3, the apply backend will use "constructed merge
+base" to label the content from the merge base, and thus provide no
+information about the merge base commit whatsoever.
 
 The merge backend works with the full commits on both sides of history
 and thus has no such limitations.
diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
index 55bde91ef9e..5964810caa4 100644
--- a/Documentation/git-restore.txt
+++ b/Documentation/git-restore.txt
@@ -92,8 +92,7 @@ in linkgit:git-checkout[1] for details.
 	The same as `--merge` option above, but changes the way the
 	conflicting hunks are presented, overriding the
 	`merge.conflictStyle` configuration variable.  Possible values
-	are "merge" (default) and "diff3" (in addition to what is
-	shown by "merge" style, shows the original contents).
+	are "merge" (default), "diff3", and "zdiff3".
 
 --ignore-unmerged::
 	When restoring files on the working tree from the index, do
diff --git a/Documentation/git-switch.txt b/Documentation/git-switch.txt
index 5c438cd5058..5c90f76fbe3 100644
--- a/Documentation/git-switch.txt
+++ b/Documentation/git-switch.txt
@@ -137,8 +137,7 @@ should result in deletion of the path).
 	The same as `--merge` option above, but changes the way the
 	conflicting hunks are presented, overriding the
 	`merge.conflictStyle` configuration variable.  Possible values are
-	"merge" (default) and "diff3" (in addition to what is shown by
-	"merge" style, shows the original contents).
+	"merge" (default), "diff3", and "zdiff3".
 
 -q::
 --quiet::
diff --git a/Documentation/technical/rerere.txt b/Documentation/technical/rerere.txt
index af5f9fc24f9..35d45414339 100644
--- a/Documentation/technical/rerere.txt
+++ b/Documentation/technical/rerere.txt
@@ -14,9 +14,9 @@ conflicts before writing them to the rerere database.
 
 Different conflict styles and branch names are normalized by stripping
 the labels from the conflict markers, and removing the common ancestor
-version from the `diff3` conflict style. Branches that are merged
-in different order are normalized by sorting the conflict hunks.  More
-on each of those steps in the following sections.
+version from the `diff3` or `zdiff3` conflict styles.  Branches that
+are merged in different order are normalized by sorting the conflict
+hunks.  More on each of those steps in the following sections.
 
 Once these two normalization operations are applied, a conflict ID is
 calculated based on the normalized conflict, which is later used by
@@ -42,8 +42,8 @@ get a conflict like the following:
     >>>>>>> AC
 
 Doing the analogous with AC2 (forking a branch ABAC2 off of branch AB
-and then merging branch AC2 into it), using the diff3 conflict style,
-we get a conflict like the following:
+and then merging branch AC2 into it), using the diff3 or zdiff3
+conflict style, we get a conflict like the following:
 
     <<<<<<< HEAD
     B
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8c69dcdf72a..a0b0fac6a68 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1519,7 +1519,7 @@ static struct option *add_common_options(struct checkout_opts *opts,
 		OPT_BOOL(0, "progress", &opts->show_progress, N_("force progress reporting")),
 		OPT_BOOL('m', "merge", &opts->merge, N_("perform a 3-way merge with the new branch")),
 		OPT_STRING(0, "conflict", &opts->conflict_style, N_("style"),
-			   N_("conflict style (merge or diff3)")),
+			   N_("conflict style (merge, diff3, or zdiff3)")),
 		OPT_END()
 	};
 	struct option *newopts = parse_options_concat(prevopts, options);
-- 
gitgitgadget

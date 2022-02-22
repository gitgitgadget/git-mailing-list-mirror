Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E82C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 00:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237708AbiBVASq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 19:18:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237665AbiBVASh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 19:18:37 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0899525594
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 16:18:12 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id l123-20020a1c2581000000b0037b9d960079so497359wml.0
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 16:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eQ/qUTGai2vDme1LZpWMbQWOUscHfjFGO0YTBL+m8Jw=;
        b=jS8CB2ayZNHGNUxzh4Tt2dLJYple8VoLbgabkVbc0wk1DcH4t9LKVVcK9EufD3d+BP
         HcLwcXx/5ClVBL/LRdPmeHMFciScIvNB0kOGjCJ4X5100TSw53DxgkBe/eOzkU1XzcY/
         +WQL/CqxMoHyA/UNg9epT2f71uRf8xsvhBnS2FPRZNFQFf7bkPJvbjrM1Eov8ef2fcQ4
         0HVX4/vliu2ksbxVE+aV0FSFqItq3kXigsMXGUsrxUZrA3hFlHIu4vROc56mLRZW343s
         0rest/9JCMeCKO3HQ5OIu4SkuYRLhBJ8t2Y47SMBK+Zd7ZfiEBiFySDFIjjsfeFg8PZD
         jPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eQ/qUTGai2vDme1LZpWMbQWOUscHfjFGO0YTBL+m8Jw=;
        b=uHujDrHFk1zFHFHvp7FMT4FZHLtHAegjMryBE/uFCO8reikGDhNUdiQTWLtwQ3NH7s
         m4NqU1QQJIc+3DthhuJ4TLPTp00IAGQ+yU65a9lbD0uFHblDJ4QkJUgNPpatBVnZtula
         kfcEllbmIwgmyQiih2owdPMTQ2rUacceNWXK4qQdpYC6H409FXXM5yWXScdzZHnZJdkx
         nn7OyzY7MranCGrm6+qkbzW4lBYnmHaJ4oc6m1vGQxhPy9/a38VSEGG3Bi9FhyPdpo6j
         XliVjbgqh+n/10DxkJCQ7JCqJb0m5LE4vS/89XUU9zS4aLykRTsXt9er1ifsSXVgPAjI
         PCGw==
X-Gm-Message-State: AOAM533/i83zNTMkuDLZXu37bMyYerYbr1djY5y8PRjVn1UQh9uwhey/
        UCn46SXb9n9Lth9G1OYAVAMkMTUqMKs=
X-Google-Smtp-Source: ABdhPJwDVl4eC+pImsqAhmYLW4keR91tSYjBWWzaEe0+dkt8DILcmtYZyw1rbPuhwuqn5ulesZWarQ==
X-Received: by 2002:a7b:c3d3:0:b0:37b:ea2b:55a4 with SMTP id t19-20020a7bc3d3000000b0037bea2b55a4mr1107363wmj.85.1645489090489;
        Mon, 21 Feb 2022 16:18:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g12sm913291wmq.28.2022.02.21.16.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 16:18:10 -0800 (PST)
Message-Id: <1e07383552aba5c430a2bced6b77efd1711b6cfe.1645489080.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
        <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Feb 2022 00:18:00 +0000
Subject: [PATCH v2 11/11] worktree: use 'worktree' over 'working tree'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, gitster@pobox.com, newren@gmail.com,
        jn.avila@free.fr, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

It is helpful to distinguish between a 'working tree' and a 'worktree'.
A worktree contains a working tree plus additional metadata. This
metadata includes per-worktree refs and worktree-specific config.

This is the last of multiple changes to git-worktree.txt, starting at
the LIST OUTPUT FORMAT section.

The EXAMPLES section has an instance of "working tree" that must stay as
it is, because it is not talking about a worktree, but an example of why
a user might want to create a worktree.

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-worktree.txt | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index cca45f19a37..1243332d722 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -383,11 +383,11 @@ $ git worktree list
 /path/to/other-linked-worktree  1234abc  (detached HEAD)
 ------------
 
-The command also shows annotations for each working tree, according to its state.
+The command also shows annotations for each worktree, according to its state.
 These annotations are:
 
- * `locked`, if the working tree is locked.
- * `prunable`, if the working tree can be pruned via `git worktree prune`.
+ * `locked`, if the worktree is locked.
+ * `prunable`, if the worktree can be pruned via `git worktree prune`.
 
 ------------
 $ git worktree list
@@ -405,14 +405,14 @@ $ git worktree list --verbose
 /path/to/linked-worktree              abcd1234 [master]
 /path/to/locked-worktree-no-reason    abcd5678 (detached HEAD) locked
 /path/to/locked-worktree-with-reason  1234abcd (brancha)
-	locked: working tree path is mounted on a portable device
+	locked: worktree path is mounted on a portable device
 /path/to/prunable-worktree            5678abc1 (detached HEAD)
 	prunable: gitdir file points to non-existent location
 ------------
 
 Note that the annotation is moved to the next line if the additional
 information is available, otherwise it stays on the same line as the
-working tree itself.
+worktree itself.
 
 Porcelain Format
 ~~~~~~~~~~~~~~~~
@@ -421,7 +421,7 @@ label and value separated by a single space.  Boolean attributes (like `bare`
 and `detached`) are listed as a label only, and are present only
 if the value is true.  Some attributes (like `locked`) can be listed as a label
 only or with a value depending upon whether a reason is available.  The first
-attribute of a working tree is always `worktree`, an empty line indicates the
+attribute of a worktree is always `worktree`, an empty line indicates the
 end of the record.  For example:
 
 ------------
@@ -473,7 +473,7 @@ demands that you fix something immediately. You might typically use
 linkgit:git-stash[1] to store your changes away temporarily, however, your
 working tree is in such a state of disarray (with new, moved, and removed
 files, and other bits and pieces strewn around) that you don't want to risk
-disturbing any of it. Instead, you create a temporary linked working tree to
+disturbing any of it. Instead, you create a temporary linked worktree to
 make the emergency fix, remove it when done, and then resume your earlier
 refactoring session.
 
-- 
gitgitgadget

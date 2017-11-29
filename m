Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0855420A40
	for <e@80x24.org>; Wed, 29 Nov 2017 20:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752538AbdK2UDZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 15:03:25 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35066 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752493AbdK2UDX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 15:03:23 -0500
Received: by mail-wr0-f193.google.com with SMTP id g53so4552649wra.2
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 12:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZaCFqASh/XXuNy5aBtVmByeoWGouxfEqnxot3BFKowk=;
        b=pmpHGhBnehZdkuVmvkEebHhRt65e4QnujYoaVUzoZ5uBEF3dd5iokFkWp1lxSAA1Th
         Rwr6eHiqrr7srlNeeWbRVipMrHqhPh94kVNh5QikTOWBfX9Q448F2LQrxUuIHoFox1Xy
         cYwCJnuW/5pU/1RKLzhpuglDorx+yZ+uJ8IVm//Ctq0Z7mRLCnIY6bki9hw84Q5D7C1t
         xqq1lJRzW/CG5uShVB/yAiHGzpWVR4ooa7OuOXj1W88BtEMt3jKjySPuKSTAQOK/uZuB
         g6/dFfBSUa3NED5ijKAvYg93EVfT3TH3YY0XQStH0RtlLpm7lronu/ur8FpZQfo2N3iX
         YV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZaCFqASh/XXuNy5aBtVmByeoWGouxfEqnxot3BFKowk=;
        b=HCLUnWsbGmhvRLkVhNiQH8QRak5p8cMJojDEYymoEZ5pWxD5ZS7rNkMoW9N8AaDGjy
         RufkB0xQioeYJ7kcTgTWTp22lErIv2OG9Jjn22ttCSCPygNBd1O+qOTDGI+35/NG3Qx9
         viR1PJW8X2dNOiAguhAdoUh/aSxufGwetek5Id1iAUvIOZTT4xNjIEr3EHv67A9kxl1u
         L/vxqSh3e2U+Yd6bIlwqfEHn3lASVvyU6QEI8WnmW+cGK9MFawopg+wQ2gCKRmeh8Cfi
         Zsx8rpo9VqwDA9055GOeeIkJRsnLEat2jppD2AKnqLUBt7UMYrx9oRWhbOuE6+EZRlcn
         9qtg==
X-Gm-Message-State: AJaThX6iZDi2T5axwn3S6HeTJvQy3Fw6dqu1rb0PNysZIHPyGIJqyNNw
        GLY554kVfHsFucC+V9c6PWibzkEy
X-Google-Smtp-Source: AGs4zMZjY7YC7wTBhtnVV4jqBPxzw7Vx6cD/LYGvaPBmZuYpjU4hL6eTeES4r/bMZujMXyQv+WOiEA==
X-Received: by 10.223.143.50 with SMTP id p47mr41154wrb.104.1511985801856;
        Wed, 29 Nov 2017 12:03:21 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id g84sm1877614wmf.26.2017.11.29.12.03.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Nov 2017 12:03:21 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Paul Smith <paul@mad-scientist.net>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v6 2/6] worktree: add can be created from any commit-ish
Date:   Wed, 29 Nov 2017 20:04:47 +0000
Message-Id: <20171129200451.16856-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.0.426.gb06021eeb
In-Reply-To: <20171129200451.16856-1-t.gummerer@gmail.com>
References: <20171126194356.16187-1-t.gummerer@gmail.com>
 <20171129200451.16856-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently 'git worktree add' is documented to take an optional <branch>
argument, which is checked out in the new worktree.  However it is more
generally possible to use a commit-ish as the optional argument, and
check that out into the new worktree.

Document that this is a possibility, as new users of git worktree add
might find it helpful.

Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-worktree.txt | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index b472acc356..121895209d 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -9,7 +9,7 @@ git-worktree - Manage multiple working trees
 SYNOPSIS
 --------
 [verse]
-'git worktree add' [-f] [--detach] [--checkout] [--lock] [-b <new-branch>] <path> [<branch>]
+'git worktree add' [-f] [--detach] [--checkout] [--lock] [-b <new-branch>] <path> [<commit-ish>]
 'git worktree list' [--porcelain]
 'git worktree lock' [--reason <string>] <worktree>
 'git worktree prune' [-n] [-v] [--expire <expire>]
@@ -45,14 +45,14 @@ specifying `--reason` to explain why the working tree is locked.
 
 COMMANDS
 --------
-add <path> [<branch>]::
+add <path> [<commit-ish>]::
 
-Create `<path>` and checkout `<branch>` into it. The new working directory
+Create `<path>` and checkout `<commit-ish>` into it. The new working directory
 is linked to the current repository, sharing everything except working
 directory specific files such as HEAD, index, etc. `-` may also be
-specified as `<branch>`; it is synonymous with `@{-1}`.
+specified as `<commit-ish>`; it is synonymous with `@{-1}`.
 +
-If `<branch>` is omitted and neither `-b` nor `-B` nor `--detach` used,
+If `<commit-ish>` is omitted and neither `-b` nor `-B` nor `--detach` used,
 then, as a convenience, a new branch based at HEAD is created automatically,
 as if `-b $(basename <path>)` was specified.
 
@@ -84,25 +84,25 @@ OPTIONS
 
 -f::
 --force::
-	By default, `add` refuses to create a new working tree when `<branch>`
+	By default, `add` refuses to create a new working tree when `<commit-ish>` is a branch name and
 	is already checked out by another working tree. This option overrides
 	that safeguard.
 
 -b <new-branch>::
 -B <new-branch>::
 	With `add`, create a new branch named `<new-branch>` starting at
-	`<branch>`, and check out `<new-branch>` into the new working tree.
-	If `<branch>` is omitted, it defaults to HEAD.
+	`<commit-ish>`, and check out `<new-branch>` into the new working tree.
+	If `<commit-ish>` is omitted, it defaults to HEAD.
 	By default, `-b` refuses to create a new branch if it already
 	exists. `-B` overrides this safeguard, resetting `<new-branch>` to
-	`<branch>`.
+	`<commit-ish>`.
 
 --detach::
 	With `add`, detach HEAD in the new working tree. See "DETACHED HEAD"
 	in linkgit:git-checkout[1].
 
 --[no-]checkout::
-	By default, `add` checks out `<branch>`, however, `--no-checkout` can
+	By default, `add` checks out `<commit-ish>`, however, `--no-checkout` can
 	be used to suppress checkout in order to make customizations,
 	such as configuring sparse-checkout. See "Sparse checkout"
 	in linkgit:git-read-tree[1].
-- 
2.15.0.426.gb06021eeb


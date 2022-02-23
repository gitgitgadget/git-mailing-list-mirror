Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF77C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 06:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237338AbiBWGrs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 01:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbiBWGrq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 01:47:46 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627843A18A
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 22:47:19 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a23so50090332eju.3
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 22:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z9LZiaRTiLeDSEyFf7drPnINqLyeXNE13PELS4GGc1A=;
        b=ohqD2LMFoqFEWV40aBpVttWt6WKOtWvWXqB0vgvL5PwOoffyf+LOh7Y8N43Sx/JhX0
         wgTLiMiQyk263EoO+ciBxyFdWQ3lSEYzadUwZmBRPF5NEC6Dsn8LAJxnGWMrtK0uIywh
         SunpL0kX4hNI+xjDmLx5HousI8hSu2zNhozy+N4lDqH+3EngbHiaqcZICgJ06QaQ/MLq
         +zh6o4TZlKJ/QrCyo4uyOSPria8K7DFUxoeQER2U2jTkqpnlBW2S1gI4YMP50V9qbmeS
         QuvWZF6PeJfCe9i53k+5/Lns7gciDLNe3hNZwenzeWhRQaOzmNDreqsm46+AyodfOJ4o
         DC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z9LZiaRTiLeDSEyFf7drPnINqLyeXNE13PELS4GGc1A=;
        b=M7DgR6XY4RuVfNA7R5LkJhWdSjufvASp1H/A+/OQiJUFoFQFHgp2U4j8DhPrsUUF3w
         5Cf5A+pTPEXO0kF3xUuPpH7QNMtwMMzYs3WR+0k53i2/+zi71l8MXr+sLVYqhMHs3Qjm
         rpGy/675s2mfT/WmslLAZz09JxzvZ2auPbkmnKP1+204JP36stkzofBjnQfRAfYslv1A
         CyfXsoyqQuU5clwCKuE6BP/1f1GRZ34o5hnhZlumfkTNhK+5TudpuU0jiKRiLpH/heef
         teIeicd3njVpBmu5JQGUUrlx0ax2twmv+kFLXBtaWzpiPyE3WOyvbXGx7I+28nLRI+L2
         pUtQ==
X-Gm-Message-State: AOAM5310Vdw9Rz/NoOYEmKT1PcgoWJn6TOG+in+7WQBGVkqtJydVXcuq
        Iq+Zo/WtSD8/dKOIcWlbxHOrqRGoiYpPs41xrq8=
X-Google-Smtp-Source: ABdhPJzsXCCcHTZtVYa+IgTPyrZbO+lkXsBu2Z7rOX4xqY7zHnpVDLMMOxC2Wv8pOHW2LM8q5lDCqtnb0HsgIFHrtG8=
X-Received: by 2002:a17:906:7714:b0:6ba:8a6a:b464 with SMTP id
 q20-20020a170906771400b006ba8a6ab464mr22046276ejm.613.1645598837696; Tue, 22
 Feb 2022 22:47:17 -0800 (PST)
MIME-Version: 1.0
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
 <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com> <2801ae232ae5cd0aa431e90eb37bbaf765d64fa5.1645489080.git.gitgitgadget@gmail.com>
In-Reply-To: <2801ae232ae5cd0aa431e90eb37bbaf765d64fa5.1645489080.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 22 Feb 2022 22:47:06 -0800
Message-ID: <CABPp-BG1OimDPSS4eXGgib2W7Vd-yTg=QutNUxn4CQF0pgdHnw@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] worktree: use 'worktree' over 'working tree'
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 21, 2022 at 4:18 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <derrickstolee@github.com>
>
> It is helpful to distinguish between a 'working tree' and a 'worktree'.
> A worktree contains a working tree plus additional metadata. This
> metadata includes per-worktree refs and worktree-specific config.
>
> This is the first of multiple changes to git-worktree.txt, restricted to
> the DESCRIPTION section.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  Documentation/git-worktree.txt | 50 ++++++++++++++++++----------------
>  1 file changed, 27 insertions(+), 23 deletions(-)
>
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index b8d53c48303..27437615436 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -25,45 +25,49 @@ Manage multiple working trees attached to the same repository.
>
>  A git repository can support multiple working trees, allowing you to check
>  out more than one branch at a time.  With `git worktree add` a new working
> -tree is associated with the repository.  This new working tree is called a
> -"linked working tree" as opposed to the "main working tree" prepared by
> -linkgit:git-init[1] or linkgit:git-clone[1].
> -A repository has one main working tree (if it's not a
> -bare repository) and zero or more linked working trees. When you are done
> -with a linked working tree, remove it with `git worktree remove`.
> +tree is associated with the repository, along with additional metadata
> +that differentiates that working tree from others in the same repository.
> +The working tree, along with this metada, is called a "worktree".

Looks like the "metada" typo still persisted.

> +This new worktree is called a "linked worktree" as opposed to the "main
> +worktree" prepared by linkgit:git-init[1] or linkgit:git-clone[1].
> +A repository has one main worktree (if it's not a bare repository) and
> +zero or more linked worktrees. When you are done with a linked worktree,
> +remove it with `git worktree remove`.
>
>  In its simplest form, `git worktree add <path>` automatically creates a
>  new branch whose name is the final component of `<path>`, which is
>  convenient if you plan to work on a new topic. For instance, `git
>  worktree add ../hotfix` creates new branch `hotfix` and checks it out at
> -path `../hotfix`. To instead work on an existing branch in a new working
> -tree, use `git worktree add <path> <branch>`. On the other hand, if you
> -just plan to make some experimental changes or do testing without
> -disturbing existing development, it is often convenient to create a
> -'throwaway' working tree not associated with any branch. For instance,
> -`git worktree add -d <path>` creates a new working tree with a detached
> -`HEAD` at the same commit as the current branch.
> +path `../hotfix`. To instead work on an existing branch in a new worktree,
> +use `git worktree add <path> <branch>`. On the other hand, if you just
> +plan to make some experimental changes or do testing without disturbing
> +existing development, it is often convenient to create a 'throwaway'
> +worktree not associated with any branch. For instance,
> +`git worktree add -d <path>` creates a new worktree with a detached `HEAD`
> +at the same commit as the current branch.
>
>  If a working tree is deleted without using `git worktree remove`, then
>  its associated administrative files, which reside in the repository
>  (see "DETAILS" below), will eventually be removed automatically (see
>  `gc.worktreePruneExpire` in linkgit:git-config[1]), or you can run
> -`git worktree prune` in the main or any linked working tree to
> -clean up any stale administrative files.
> +`git worktree prune` in the main or any linked worktree to clean up any
> +stale administrative files.
>
> -If a linked working tree is stored on a portable device or network share
> -which is not always mounted, you can prevent its administrative files from
> -being pruned by issuing the `git worktree lock` command, optionally
> -specifying `--reason` to explain why the working tree is locked.
> +If the working tree for a a linked worktree is stored on a portable device

If you re-roll, don't forget to correct the "a a" too.  :-)

> +or network share which is not always mounted, you can prevent its
> +administrative files from being pruned by issuing the `git worktree lock`
> +command, optionally specifying `--reason` to explain why the worktree is
> +locked.
>
>  COMMANDS
>  --------
>  add <path> [<commit-ish>]::
>
> -Create `<path>` and checkout `<commit-ish>` into it. The new working directory
> -is linked to the current repository, sharing everything except working
> -directory specific files such as `HEAD`, `index`, etc. As a convenience,
> -`<commit-ish>` may be a bare "`-`", which is synonymous with `@{-1}`.
> +Create a worktree at `<path>` and checkout `<commit-ish>` into it. The new worktree
> +is linked to the current repository, sharing everything except per-worktree
> +files such as `HEAD`, `index`, etc. As a convenience, `<commit-ish>` may
> +be a bare "`-`", which is synonymous with `@{-1}`.
>  +
>  If `<commit-ish>` is a branch name (call it `<branch>`) and is not found,
>  and neither `-b` nor `-B` nor `--detach` are used, but there does
> --
> gitgitgadget

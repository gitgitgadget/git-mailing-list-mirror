Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49A6C433F5
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 20:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240243AbiAJUjH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 15:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbiAJUjG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 15:39:06 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A59AC06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 12:39:06 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id z22so13473027edd.12
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 12:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KOcSFfyCLCJmD0O6378xdWXyknspiJAnoZ/H6KWkwHA=;
        b=Wf2IXdRHrvy1DQdGUvb7HJY43Q/Bnez3/uYQMk6IfTH4MqoYXGSSA8KkyTNUbNOlzp
         NuLIxFW/h+WZf60AdZ0r8jsv4ciXBJtwvYZWwuRWH1cLGpRlDDBLRbBqXONFf7m7fLTo
         dQOj7WyM27L7Q5lRUvupT4KvLOOUy5En2BTYTAWC5L0ur8Idc6WoWzutot4xEdUPQYMI
         uKKZeL6sXxm5dFm1Czf+nRmfb46XoGwyyVMogceKYd+ZKV3VErAPHnxboPYszO+m5pZG
         fEJ6/NP+k+exr/DR5JtG13vAXYOmBjGKfJltMex4e3/mDdS0WAeJvNEysfWoqbh0w4da
         0sHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KOcSFfyCLCJmD0O6378xdWXyknspiJAnoZ/H6KWkwHA=;
        b=lac+h8zVTbEutNhwUQUZp5B4p8d9OQFWCycFIyTRfXDoLKCBg9pD61xYD1Gf+14TuC
         OkKi9dQbV3piLJslW04M1T7UDtuZSsAAQb0Y0rc5cNXDWg55y6OiXO2lqFeW4UoAvyx7
         xRQs7ia7WUipY+afSDnQeYvTdBwVviiZ0KKEmWeSNS/f8lCYhqSVRBSihtJCzGj0MmRz
         gcUxbwhZbmtLABS10n0fHSGApIqqvdiRctYOyTRGo7/tYREW9LEx4ZlccXmCnxdQCJfs
         SwjrN7TTAuwFFWsmNB390dcOyHrK+GkzytJOHceH/IPK+JKgnaF1IUv3/18u14N0pyzl
         yvtQ==
X-Gm-Message-State: AOAM533K7geTjh8ezqBWnkPFjx0EHwp56VZy6IOFEH6jB13suYWXB4J2
        +yuToOswU2ER2vHwfvoGMYnmtmFsIlbLd0RCGMVcSz8f//M=
X-Google-Smtp-Source: ABdhPJwp+QMxcuHGb0ugRGC7st3pvxBcd5umYFS/wwLMSyyfc8W3AVo5wIudZmkydruf9vFd0iveMEY+Nofi9kE/0jA=
X-Received: by 2002:a50:da48:: with SMTP id a8mr1349137edk.146.1641847144907;
 Mon, 10 Jan 2022 12:39:04 -0800 (PST)
MIME-Version: 1.0
References: <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com> <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com>
In-Reply-To: <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 10 Jan 2022 12:38:53 -0800
Message-ID: <CABPp-BG=wr81CPtW1M12xFN_0dyS8mAZjM6o=77LA20Zge8Xng@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] sparse checkout: custom bash completion updates
To:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        johannes.schindelin@gmail.com,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 10, 2022 at 10:59 AM Lessley Dennington via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This series is based on en/sparse-checkout-set. It updates custom tab
> completion for the sparse-checkout command. Specifically, it corrects the
> following issues with the current method:
>
>  1. git sparse-checkout <TAB> results in an incomplete list of subcommands
>     (it is missing reapply and add).
>  2. git sparse-checkout --<TAB> does not complete the help option.
>  3. Options for subcommands are not tab-completable.
>  4. git sparse-checkout set <TAB> and git sparse-checkout add <TAB> show
>     both file names and directory names.
>
> The first commit in this series is a set of failing tests that highlight
> each of the above issues. The next commit updates the _git_sparse_checkout
> method in git-completion.bash to enable each of these tests to pass. The
> final commit modifies the original implementation (which recursively printed
> prospective directories for completion) to only print directories at the
> current level for improved performance.
>
>
> Changes since V2
> ================
>
>  * Change use of $prev to $subcommand in _git_sparse_checkout() method in
>    git-completion.bash.
>  * State explicitly that directory completion applies in both cone and
>    non-cone mode in 'sparse-checkout: custom tab completion' commit
>  * Add new patch with __gitcomp_directories method to improve performance by
>    only outputting directories at the current level.
>
>
> Changes since V1
> ================
>
>  * Rebase onto en/sparse-checkout-set.
>  * Add subcommand options (including --no-cone) for set and reapply.
>  * Extend 'sparse-checkout completes subcommand options' test to validate
>    new set/reapply subcommand options.
>  * No longer set index.sparse to false in 'sparse-checkout completes
>    directory names' test.
>
> Thanks, Lessley
>
> Lessley Dennington (3):
>   sparse-checkout: custom tab completion tests
>   sparse-checkout: custom tab completion
>   sparse-checkout: limit tab completion to a single level
>
>  contrib/completion/git-completion.bash | 68 +++++++++++++++----
>  t/t9902-completion.sh                  | 94 ++++++++++++++++++++++++++
>  2 files changed, 150 insertions(+), 12 deletions(-)
>
>
> base-commit: dfac9b609f86cd4f6ce896df9e1172d2a02cde48
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1108%2Fldennington%2Fsparse-checkout-bash-completion-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1108/ldennington/sparse-checkout-bash-completion-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/1108
>
> Range-diff vs v2:
>
>  1:  955fcab0052 = 1:  bbc2d21e1d1 sparse-checkout: custom tab completion tests
>  2:  cecf501e076 ! 2:  256e5f034c6 sparse-checkout: custom tab completion
>      @@ Commit message
>           2. The --help option is tab-completable.
>           3. Subcommand options are tab-completable.
>           4. A list of directories (but not files) is provided when users enter git
>      -    sparse-checkout add <TAB> or git sparse-checkout set <TAB>.
>      +    sparse-checkout add <TAB> or git sparse-checkout set <TAB>. It is
>      +    important to note that this will apply for both cone mode and non-cone
>      +    mode (even though non-cone mode matches on patterns rather than
>      +    directories).

I would instead phrase this as "(even though non-cone mode can match
general gitignore patterns rather than just directories)".

The basic idea behind the rewording is that I want to highlight that
the completions we provide are still valid in non-cone mode, they just
aren't comprehensive.  Since there's no way to provide a comprehensive
list of possible patterns for non-cone mode, I think what we are
choosing to provide is a pretty reasonable choice.

>
>           Failing tests that were added in the previous commit to verify these
>           scenarios are now passing with these updates.
>      @@ contrib/completion/git-completion.bash: _git_show_branch ()
>       -         ;;
>       - *)
>       -         ;;
>      -+ case "$prev" in
>      ++ case "$subcommand" in
>       +         set)
>       +                 __gitcomp "$__git_sparse_checkout_subcommand_opts --stdin"
>       +                 __gitcomp "$(git ls-tree -d -r HEAD --name-only)"
>  -:  ----------- > 3:  aa9ea67180d sparse-checkout: limit tab completion to a single level

Other than that one nit, patches 1-2 (and the testcases in patch 3) are:

Reviewed-by: Elijah Newren <newren@gmail.com>

Since I wrote the new __gitcomp() function in patch 3, it might be
nice if we can find another reviewer for it. Especially since I've
only lightly touched the completion code and there might be better
ways of achieving what I wrote there.

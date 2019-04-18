Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA5A520248
	for <e@80x24.org>; Thu, 18 Apr 2019 10:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388415AbfDRKMX (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 06:12:23 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54119 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387519AbfDRKMX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 06:12:23 -0400
Received: by mail-it1-f194.google.com with SMTP id y204so2464420itf.3
        for <git@vger.kernel.org>; Thu, 18 Apr 2019 03:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Onc9pjiOtGeBa1DNay8MR6ucG2i1HL1tpMpCa+9KzAw=;
        b=efuRs101KjqM4WcMTjuow0X4lE3F/WcjeSvFQgilNnDWVev1KLBz22zdTAacH+dAhh
         uQi280GnvStkgmMXvPCJ/GaeShEhcPk30cMJhbMAb6fjrIcSKKmLgHvIIkhCGSL6TKQG
         FjZyP0A5iJF0Tq2BwoWnOMzDzpvMRLUieHyDFqpjmoWf+PjhmbxExEnVFq7ezPxaL0+r
         gJR9Aw45/gZgGO3E+bjcZkleduGGdnFLy+TBxJJ//m0tzvZfs+wKP+Aola563a64RwRs
         zxkjiOi+QAjRji5zGPNeNwamJ2mrH/JuTjaRTYZN9cOAe/J83PWauv0GT+4OIeP1BrFm
         86dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Onc9pjiOtGeBa1DNay8MR6ucG2i1HL1tpMpCa+9KzAw=;
        b=jFfEziYtRBey1EmBZSBSJ7fGVq7dvWyUhbbHXCac7qsnpc+/KV6SQCrKNZNz283gVY
         nompk0lYbSEryCrw07AYhjQtcA2ssynNoef3HnlnJj33m1EgKwuo/ZBfZXH9Rn0nYcCt
         wa9slQTUQKkURQmc08ehvHp9qN2WC5oj2+VXnT0sbEo6KKwxGr4lf6XBK3SOQNBO/g7l
         KJHdqzI1TrmSleZWvDqR+zfr/s/Y3Rl1SKlfLr/1hafCFPjH+ambZ1naOmjLhLg7bouP
         BICMoO5mnFfm0J8YUa1thyfg41JXYdjVLeQgAnwHLm84salkN5JiUlQt+Z0CBtFrTj9h
         cnhQ==
X-Gm-Message-State: APjAAAUPY+2Hbzk/GLOiSiULsvhTZfpFjPAqBVyWNc3THVmB4vQxe8mz
        kMKy61O0ySBDH3dlb66mSrmb3y7+e2C7fIaEA/M=
X-Google-Smtp-Source: APXvYqxiiKGkiHKA/QdlwEMMKNygYHyDhofOIpO5Up5jxmCaesc+A19dCbIhF0JeOncWcBjb10J2pxfqXkTVF4xdlIw=
X-Received: by 2002:a24:4d8a:: with SMTP id l132mr2640656itb.70.1555582342090;
 Thu, 18 Apr 2019 03:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190417212128.52475-1-jonathantanmy@google.com>
In-Reply-To: <20190417212128.52475-1-jonathantanmy@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 18 Apr 2019 17:11:55 +0700
Message-ID: <CACsJy8BygpTQg5=8+2KkFCpaJBEkKx+ocVZoa0yRBAQvnkXVSw@mail.gmail.com>
Subject: Re: [PATCH] worktree: update is_bare heuristics
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Mike Rappazzo <rappazzo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 18, 2019 at 4:22 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> When "git branch -D <name>" is run, Git usually first checks if that
> branch is currently checked out. But this check is not performed if the
> Git directory of that repository is not at "<repo>/.git", which is the
> case if that repository is a submodule that has its Git directory stored
> as "super/.git/modules/<repo>", for example.
>
> This is because get_main_worktree() in worktree.c sets is_bare on a
> worktree only using the heuristic that a repo is bare if the worktree's
> path ends in "/.git", and not bare otherwise. This is_bare code was
> introduced in 92718b7438 ("worktree: add details to the worktree
> struct", 2015-10-08), following a pre-core.bare heuristic. This patch
> does 2 things:
>
>  - Teach get_main_worktree() to use is_bare_repository() instead,
>    introduced in 7d1864ce67 ("Introduce is_bare_repository() and
>    core.bare configuration variable", 2007-01-07) and updated in
>    e90fdc39b6 ("Clean up work-tree handling", 2007-08-01). This solves
>    the "git branch -D <name>" problem described above. However...

You actually didn't spell out the problem with "git branch -D", or at
least the consequence (i.e. the submodule branch is deleted even if
it's checked out).

>  - If a repository has core.bare=1 but the "git" command is being run
>    from one of its added worktrees, is_bare_repository() returns false
>    (which is fine, since there is a worktree available). However,
>    commands like "git worktree list" currently distinguish between a
>    repository that has core.bare=1 but has a worktree available, and a
>    repository that is truly non-bare (core.bare=0). To preserve this
>    distinction, also check core.bare when setting is_bare. If
>    core.bare=1, trust it, and otherwise, use is_bare_repository().
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  t/t3200-branch.sh | 14 ++++++++++++++
>  worktree.c        |  7 +++----
>  2 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 478b82cf9b..db5c411e76 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -264,6 +264,20 @@ test_expect_success 'git branch --list -d t should fail' '
>         test_must_fail git rev-parse refs/heads/t
>  '
>
> +test_expect_success 'deleting checked-out branch from repo that is a submodule' '
> +       test_when_finished "rm -rf repo1 repo2" &&
> +
> +       git init repo1 &&
> +       git init repo1/sub &&
> +       test_commit -C repo1/sub x &&
> +       git -C repo1 submodule add ./sub &&
> +       git -C repo1 commit -m "adding sub" &&
> +
> +       git clone --recurse-submodules repo1 repo2 &&
> +       git -C repo2/sub checkout -b work &&
> +       test_must_fail git -C repo2/sub branch -D work
> +'
> +
>  test_expect_success 'git branch --list -v with --abbrev' '
>         test_when_finished "git branch -D t" &&
>         git branch t &&
> diff --git a/worktree.c b/worktree.c
> index b45bfeb9d3..5d52b2ba53 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -49,18 +49,17 @@ static struct worktree *get_main_worktree(void)
>         struct worktree *worktree = NULL;
>         struct strbuf path = STRBUF_INIT;
>         struct strbuf worktree_path = STRBUF_INIT;
> -       int is_bare = 0;
>
>         strbuf_add_absolute_path(&worktree_path, get_git_common_dir());
> -       is_bare = !strbuf_strip_suffix(&worktree_path, "/.git");
> -       if (is_bare)
> +       if (!strbuf_strip_suffix(&worktree_path, "/.git"))
>                 strbuf_strip_suffix(&worktree_path, "/.");

We can just call these two calls unconditionally, right? No harm done
if we don't strip.

>
>         strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
>
>         worktree = xcalloc(1, sizeof(*worktree));
>         worktree->path = strbuf_detach(&worktree_path, NULL);
> -       worktree->is_bare = is_bare;
> +       worktree->is_bare = (is_bare_repository_cfg == 1) ||

core.bare and core.worktree are special. When you access them standing
from the main worktree, you'll see them. But when you stand from a
secondary worktree, they are ignored. It's more obvious with
core.worktree because if that affects all worktrees, what's the point
of having multiple worktrees. Git will always go to the place
core.worktree points out.

So if this function is called from a secondary worktree, I'm not sure
if it still works as expected because is_bare_repo may be false then.
For the submodule case, you always stand at the submodule's main
worktree, so it still works.

I don't think multiple-worktrees-on-submodules will be coming soon, so
it's probably ok. But maybe leave a note here.

> +               is_bare_repository();
>         add_head_info(worktree);
>
>         strbuf_release(&path);
> --
> 2.21.0.392.gf8f6787159e-goog
>


-- 
Duy

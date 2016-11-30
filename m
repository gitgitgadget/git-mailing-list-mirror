Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C2051FBB0
	for <e@80x24.org>; Wed, 30 Nov 2016 11:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933422AbcK3LOp (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 06:14:45 -0500
Received: from mail-yb0-f196.google.com ([209.85.213.196]:34993 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754813AbcK3LOn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 06:14:43 -0500
Received: by mail-yb0-f196.google.com with SMTP id d59so2039350ybi.2
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 03:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Q1Dqub6rvJQIC5kQvCMnjRrYAUEsMSepCFzr+kYD0aU=;
        b=AhKR/10gx0ONO8HYKLQZpA8hsuQehFWottmzLLzaDpGr9y7DAD4DIpXxO99Ygo+czI
         KJSPpuHxGPAUpzXZrELlCDKookmmE7Wq3iHkx+Tx4mEJ8tsv4I6wZBKCulHKr8lQdPZ0
         49hq6W5+jbTyRHZeHf0H+9Ixdno7omgUaFrTyRdXEzbtqGJx1tpSXA/XPcFRYoqodTwV
         HpxIlZJQtdaXllchX9ZnMxYfyUg+6Ad7jXe70fv1yAa5eNwSASdB1cRQZUiB86+2gIcd
         D4VAlBymNsjRwfejdTS/gCbpZ+KFZwsL+M+OOkVjJPoxLbAXOrimV7s8g/nFgW+D9n9O
         odWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Q1Dqub6rvJQIC5kQvCMnjRrYAUEsMSepCFzr+kYD0aU=;
        b=RA3NOFlZ4uLK/fZgmbX4rR3sY2TiQ1EuWrIE6Jtq7Fjc80EOyg+gTRoCqN9ILSzrqZ
         z2/NLbrRUDkrE95Y6P7KCSzR8iXdBjLHZj30ODlOj04MYjGqIb+6LqjCuTft5xacWs5s
         ++lAke/kF3KhYVhNNWa/TQDHzCpaYxhOSg9m11R9xzxHZ+IjaE6FT6MvHFAckfHAOPUP
         SxxSkS5vCPYZ1rpngK4LtryjtbegBTb9h6JXbcelHVAZhMCXhmKOsRkwp6j7+d4lxiNo
         ijPyr6rhVVMR4acCojp20kjjcdBaNOaX3OrwcQC3kX/auhspmJp4AcqYlFyACxMtPOZQ
         pswA==
X-Gm-Message-State: AKaTC01Kx0asqkU36i51AaPimefFeCq+zAQDm3eX3e3ZhlTF4iy+m6niEkHUrRubz2ySRPjGXiOm47Rd0EIM6g==
X-Received: by 10.37.32.194 with SMTP id g185mr2101421ybg.0.1480504482050;
 Wed, 30 Nov 2016 03:14:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.162.39 with HTTP; Wed, 30 Nov 2016 03:14:11 -0800 (PST)
In-Reply-To: <20161122192235.6055-5-sbeller@google.com>
References: <20161122192235.6055-1-sbeller@google.com> <20161122192235.6055-5-sbeller@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 30 Nov 2016 18:14:11 +0700
Message-ID: <CACsJy8Ce3Oa-xJ4BwgRRy6neM=Jxkfqq7yboHZDXLDG2tu9GzQ@mail.gmail.com>
Subject: Re: [PATCHv2 4/4] submodule: add embed-git-dir function
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 23, 2016 at 2:22 AM, Stefan Beller <sbeller@google.com> wrote:
> +/*
> + * Migrate the given submodule (and all its submodules recursively) from
> + * having its git directory within the working tree to the git dir nested
> + * in its superprojects git dir under modules/.
> + */
> +void migrate_submodule_gitdir(const char *prefix, const char *path,
> +                             int recursive)

Submodules and worktrees seem to have many things in common. The first
one is this. "git worktree move" on a worktree that contains
submodules .git also benefits from something like this [1]. I suggest
you move this function to some neutral place and maybe rename it to
relocate_gitdir() or something.

It probably should take a bit flag instead of "recursive" here. One
thing I would need is the ability to tell this function "I have moved
all these .git dirs already (because I move whole worktree in one
operation), here are the old and new locations of them, fix them up!".
In other words, no rename() could be optionally skipped.

[1] https://public-inbox.org/git/20161128094319.16176-11-pclouds@gmail.com/T/#u

> +{
> +       char *old_git_dir;
> +       const char *new_git_dir;
> +       const struct submodule *sub;
> +
> +       old_git_dir = xstrfmt("%s/.git", path);
> +       if (read_gitfile(old_git_dir))
> +               /* If it is an actual gitfile, it doesn't need migration. */
> +               goto out;
> +
> +       sub = submodule_from_path(null_sha1, path);
> +       if (!sub)
> +               die(_("Could not lookup name for submodule '%s'"),
> +                     path);
> +
> +       new_git_dir = git_common_path("modules/%s", sub->name);

Why doesn't git_path() work here? This would make "modules" shared
between worktrees, even though it's not normally. That inconsistency
could cause trouble.

> +       if (safe_create_leading_directories_const(new_git_dir) < 0)
> +               die(_("could not create directory '%s'"), new_git_dir);
> +
> +       if (!prefix)
> +               prefix = get_super_prefix();
> +       printf("Migrating git directory of %s%s from\n'%s' to\n'%s'\n",
> +               prefix ? prefix : "", path,
> +               real_path(old_git_dir), new_git_dir);
> +
> +       if (rename(old_git_dir, new_git_dir) < 0)
> +               die_errno(_("Could not migrate git directory from '%s' to '%s'"),
> +                       old_git_dir, new_git_dir);
> +
> +       connect_work_tree_and_git_dir(path, new_git_dir);

Another thing in common is, both submodules and worktrees use some
form of textual symlinks. You need to fix up some here. But if this
submodule has multiple worktreee, there may be some "symlinks" in
.git/worktrees which would need fixing up as well.

You don't have to do the fix up thing right away, but I think we
should at least make sure we leave no dangling links behind (by
die()ing early if we find a .git dir we can't handle yet)
-- 
Duy

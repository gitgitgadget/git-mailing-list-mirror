Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9313120248
	for <e@80x24.org>; Fri, 19 Apr 2019 20:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfDSURa (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Apr 2019 16:17:30 -0400
Received: from mail-it1-f180.google.com ([209.85.166.180]:38239 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfDSUR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Apr 2019 16:17:29 -0400
Received: by mail-it1-f180.google.com with SMTP id f22so9889618ita.3
        for <git@vger.kernel.org>; Fri, 19 Apr 2019 13:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HopNJqoy+LnwZ+JRSGCUwVAevtP19ryyWwwMbGPcQuY=;
        b=hHgbHaMP/52cEeuhzneBa3OxlasnpePjXjqBcweM9RJbO36IC4c2+6W2kuFzeIqEX+
         oyT5XP1UjPr2QVPUSZzOQZDhjWrFoZR5IzBAwS6g9lGCjRm6etG0TBqYk8Lo5n2WB7+4
         0HIhbpvP5uko9jSPMZeZ9hp+dJqXoMwnFL7B4xNVtKcWG/8pMMJBWc5jzVbpWXTP+2tA
         xntBENAuZcq0HSGeUCONiD0CFaD8CqNu9i4O+MQ1Yc2fEXO+PNmdzvQ7jBS/PYsbPhVv
         0ogovVrjocK7a4pbC4fSL7Q/skPhLuKL1mmldjtfapGcDJAvUJ+Uoz9Jn2dyexk11CQm
         m+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HopNJqoy+LnwZ+JRSGCUwVAevtP19ryyWwwMbGPcQuY=;
        b=U3ATy15KG+mvVz9rFwJ2ahS7ltHttonilFp4H8exTDi1PP6DcIaWob2XWRIx1OGD41
         tQrfQSu0QSwuSVvRJYMDiWcW7c1TA0yVjfhwqWtdHMiwFRy3GYmJwNmNIgMmBPHLVQYU
         uwhf58R/lEFFhmkGUwfY+inuzYdJEoBV9gg19F2SXGmDvSHgvkgzHsEsNXQqsSK4SL76
         +Y6zzGhlE3/tMxSo2rU7c2roYqAQO45x0QGSiTQJjdXescbeOi1VzdI/ya4229U62K5W
         W6tzrqSk8uiRrJLZZ+JbdfarbMUaRmsMBO0/WM3zjzDy33rKZL0VdB8/CDtUSln7MAeV
         0D/w==
X-Gm-Message-State: APjAAAUwKno0b4bYBAiLMVoX0o1IjFPtvaCIh5Q/B4yj37+GMp235nqM
        Mxo0ItjDijSaDIbzEn0dB32HvxSf0HrVJ4N9cK1aEZ1H
X-Google-Smtp-Source: APXvYqwtulYBMwxxs6Dq6zwZ5Q4jSQjn2Ps1N6hIPymwKk3+iRlrvLkeNwsTSs6ooMnzJtextRpIpNgJIbMiIrrcWmc=
X-Received: by 2002:a24:4d8a:: with SMTP id l132mr2312466itb.70.1555671065607;
 Fri, 19 Apr 2019 03:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <CACsJy8BygpTQg5=8+2KkFCpaJBEkKx+ocVZoa0yRBAQvnkXVSw@mail.gmail.com>
 <20190418183000.78138-1-jonathantanmy@google.com>
In-Reply-To: <20190418183000.78138-1-jonathantanmy@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 19 Apr 2019 17:50:39 +0700
Message-ID: <CACsJy8CoaOmJpFygQxrFyJmpzL4wyR0Dbck_TyVOFViRbtqAHQ@mail.gmail.com>
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

On Fri, Apr 19, 2019 at 1:30 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > You actually didn't spell out the problem with "git branch -D", or at
> > least the consequence (i.e. the submodule branch is deleted even if
> > it's checked out).
>
> Thanks - I'll do that in the commit message.

Another minor nit (because I was still puzzled why a submodule was
considered bare/not bare)

> This is because get_main_worktree() in worktree.c sets is_bare on a
> worktree only using the heuristic that a repo is bare if the worktree's
> path ends in "/.git", and not bare otherwise.

s/ends/does not end/. Now it makes more sense because the submodule's
main worktree is accidentally considered "bare" (i.e. no worktree),
its HEAD is ignored.

> > >         strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
> > >
> > >         worktree = xcalloc(1, sizeof(*worktree));
> > >         worktree->path = strbuf_detach(&worktree_path, NULL);
> > > -       worktree->is_bare = is_bare;
> > > +       worktree->is_bare = (is_bare_repository_cfg == 1) ||
> >
> > core.bare and core.worktree are special. When you access them standing
> > from the main worktree, you'll see them. But when you stand from a
> > secondary worktree, they are ignored.
>
> Just checking: I think that is_bare_repository_cfg ignores core.bare
> only if the config.worktree file is present?

No, both are ignored independently if you read them from a secondary
worktree. Tested too with rev-parse, just to be sure.

> In the t2402 test '"list"
> all worktrees from linked with a bare main', "git worktree list" still
> observes the main worktree as bare.

Yes, because of bug :(

When git_config() is called again by cmd_worktree(), it does not treat
core.worktree and core.bare special anymore. So is_bare_repository_cfg
is reset from 0 to 1, even though I think its value at that point
plays no role anymore. What matters is the value at
setup_git_directory().

So yeah your code works in all cases by luck ;)

Fixing that one will not be easy (to avoid traps). I did try to delete
is_bare_repository_cfg (on the ground that global vars are hard to
manage, as seen here) only to discover that I could not simply delete
the core.bare parsing code in git_default_core_config() without
changing behaviour in some case [1]. I should probably revive that
branch (cleaning up gitdir setup code a bit) and submit.

[1] https://gitlab.com/pclouds/git/commit/2cc46d698ebe7af295e0d91f68103675077df68e#db04685516ffb491eb4239291b892fc0784e1aea

> > I don't think multiple-worktrees-on-submodules will be coming soon, so
> > it's probably ok. But maybe leave a note here.
>
> Observing that the problematic case is the 3rd one above, would this
> note work:
>
>   NEEDSWORK: If this function is called from a secondary worktree and
>   config.worktree is present, is_bare_repository_cfg will reflect the
>   contents of config.worktree, not the contents of the main worktree.
>   This means that worktree->is_bare may be set to 0 even if the main
>   worktree is configured to be bare.

Even though your code works perfectly now, I still think it's good to
have some comment like this.
-- 
Duy

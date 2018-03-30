Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F20E11F404
	for <e@80x24.org>; Fri, 30 Mar 2018 14:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751275AbeC3OAu (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 10:00:50 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35802 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751216AbeC3OAt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 10:00:49 -0400
Received: by mail-wr0-f196.google.com with SMTP id 80so8149229wrb.2
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 07:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kZ2VFtMZVDaSfmFFHUjBYAwUSOdOYZZheta8sgBAx/U=;
        b=of07LoK3EzJLrgPSC8KIFxyPlqtKp3Ysd8ehkkfVLO97VDdCwrWTFyJon/HoB+oy+o
         8ugOqFZflSMn+XIx5JN/m/Vn00bj43sSzUQgnhlXNX+inTcHcxhzyms7JTFStrUns2QO
         SE1PopEYeHcHdGzM60Vw2VOovTYON5VjfBuVwxPqfIxJ1H7VXcfSJIaqblqkQ86qvUlp
         5tIFHr1up4xrFR9KWhCn27OpJhPlAkCF2XAKoUCXUWY466ypVkHXSbuZODsZYdk6NywH
         n3AkYrV/2I4o6RkgKqLX3FHgx94lGpwZcHDW3zfFDy1bm8CsR+VDou1ToMOCln67QtLm
         cP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kZ2VFtMZVDaSfmFFHUjBYAwUSOdOYZZheta8sgBAx/U=;
        b=tD+e92qeUgczAZ5tbnCEgGQl5SYvHjX6Ph5qIFEtbkbQirpoIC9P+dgU/R3LspRCR9
         rRw7ESIKND6Li2bGUrVbXfTzMVJHea16ow+6Wv70sRP6GgBwHOIInraJSykrk1KoECmE
         7G5ZWuS+N3gfSb0h/M5ovFBP0jMi31Gd4yDfNZvF7nEHbNtAZcQZihx1xPAOcw1H+XHn
         IfyKdZ+we2f1t+ZF88S05a2pkYqa0mnDCGNeRKQiQT7ym1GE/dvLisYAMdGvvlaA/gih
         V+etPFsE6hGd1ImKhnsS0gzio5xxjvNSebHM60ECoNV/dauzzC2XmxtkAdb0mOLCEJhU
         sNmA==
X-Gm-Message-State: AElRT7GgfmVRYPrSAb0mDfyfWqvlQv8LHKs8Vm4opB4OX6ODtRLUOQ6h
        qUUKSQIRIUqDA/90pGTJ6QpA9JEM
X-Google-Smtp-Source: AIpwx49Eltd2qQ7wNHcjdg7OBLegwqdSQ8XQ7XsDjbvFb7un/2zb7hV9DePrQIh39/cB1kZ7IcQ1Nw==
X-Received: by 10.223.171.213 with SMTP id s79mr9388992wrc.52.1522418448364;
        Fri, 30 Mar 2018 07:00:48 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id m62sm5666830wmc.25.2018.03.30.07.00.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Mar 2018 07:00:47 -0700 (PDT)
Date:   Fri, 30 Mar 2018 15:04:15 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 5/6] worktree: teach "add" to check out existing
 branches
Message-ID: <20180330140415.GC2629@hank>
References: <20180317222219.4940-1-t.gummerer@gmail.com>
 <20180325134947.25828-1-t.gummerer@gmail.com>
 <20180325134947.25828-6-t.gummerer@gmail.com>
 <CAPig+cTmGvkGkcdH45mRO6uwEK2UyR1FQ_fiD=2wgz8Pt_WeOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cTmGvkGkcdH45mRO6uwEK2UyR1FQ_fiD=2wgz8Pt_WeOg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/27, Eric Sunshine wrote:
> On Sun, Mar 25, 2018 at 9:49 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > Currently 'git worktree add <path>' creates a new branch named after the
> > basename of the path by default.  If a branch with that name already
> > exists, the command refuses to do anything, unless the '--force' option
> > is given.
> >
> > However we can do a little better than that, and check the branch out if
> > it is not checked out anywhere else.  This will help users who just want
> > to check an existing branch out into a new worktree, and save a few
> > keystrokes.
> > [...]
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> > diff --git a/builtin/worktree.c b/builtin/worktree.c
> > @@ -317,7 +318,10 @@ static int add_worktree(const char *path, const char *refname,
> > -       if (opts->new_branch)
> > +       if (opts->checkout_existing_branch)
> > +               fprintf_ln(stderr, _("checking out branch '%s'"),
> > +                          refname);
> 
> This fprintf_ln() can easily fit on one line; no need to wrap
> 'refname' to the next one.
> 
> Not worth a re-roll, though.
> 
> > +       else if (opts->new_branch)
> >                 fprintf_ln(stderr, _("creating branch '%s'"), opts->new_branch);
> > diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> > @@ -198,13 +198,26 @@ test_expect_success '"add" with <branch> omitted' '
> > -test_expect_success '"add" auto-vivify does not clobber existing branch' '
> > +test_expect_success '"add" checks out existing branch of dwimd name' '
> >         test_commit c1 &&
> >         test_commit c2 &&
> >         git branch precious HEAD~1 &&
> > -       test_must_fail git worktree add precious &&
> > +       git worktree add precious &&
> >         test_cmp_rev HEAD~1 precious &&
> > -       test_path_is_missing precious
> > +       (
> > +               cd precious &&
> > +               test_cmp_rev precious HEAD
> > +       )
> > +'
> 
> Looking at this more closely, once it stops being a "don't clobber
> precious branch" test, it's doing more than it needs to do, thus is
> confusing for future readers. The setup -- creating two commits and
> making "precious" point one commit back -- was very intentional and
> allowed the test to verify not only that the worktree wasn't created
> but that "precious" didn't change to reference a different commit.
> However, _none_ of this matters once it becomes a dwim'ing test; the
> unnecessary code is confusing since it doesn't make sense in the
> context of dwim'ing. I _think_ the entire test can collapse to:
> 
>     git branch existing &&
>     git worktree add existing &&
>     (
>         cd existing &&
>         test_cmp_rev existing HEAD
>     )
> 
> In other words, this patch should drop the "precious" test altogether
> and just introduce a new dwim'ing test (and drop patch 6/6).
> 
> I do think that with the potential confusion to future readers, this
> does deserve a re-roll.

Hmm I do think that it's important to have the branch we create the
new working tree from different from the branch of the main working
tree, to make sure we don't accidentally overwrite an existing branch,
and to show that the new branch is checked out.

Maybe I'm overly paranoid though?

> > +test_expect_success '"add" auto-vivify fails with checked out branch' '
> > +       git checkout -b test-branch &&
> > +       test_must_fail git worktree add test-branch &&
> > +       test_path_is_missing test-branch
> > +'
> > +
> > +test_expect_success '"add --force" with existing dwimd name doesnt die' '
> > +       git worktree add --force test-branch
> >  '

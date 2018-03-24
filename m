Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB3F11F404
	for <e@80x24.org>; Sat, 24 Mar 2018 20:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752881AbeCXU5A (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 16:57:00 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33496 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752801AbeCXU47 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 16:56:59 -0400
Received: by mail-wr0-f195.google.com with SMTP id z73so15279976wrb.0
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 13:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NSzT8C7S2g6t4e6pfhupCr5bSyBmgcJAfWfmAlQCuq0=;
        b=getTZca/aRwRNSMpQICJh9ogOX+D0IQWIrFcn27l61IGq8H48eu1rbhKLEimG0kG8O
         ti+yKiTq78db+XCyg5BS/4cDCeGElboevX6EsfurZH+HFhwA9624cZ2/R6XsSYIYFwIS
         C5u50YI0aRuW63LemCYtu17PoshDabwLySJWG6/u62TS1bib7gUc9YpRUggVKXMYFy3J
         4dq8mRwabwmJF1V7RbCyKALWW9+jm6rRzlduSdIpEI1VTylHgBM+/Mh77N55T39W9jCA
         ffidCcvpj4CrQ8l4KJOrMPipAmoGTPLdV/4Tsy2tWv2dcWKX7Y2qZOeLERwmtxTqV4hq
         Rr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NSzT8C7S2g6t4e6pfhupCr5bSyBmgcJAfWfmAlQCuq0=;
        b=jugDtGESJTpxPeL40FNfSMBjsMpHLvaP2lu0rR5F2FOQXzWYWMkzCVR+0cYy27nmoJ
         4ExInTsph4vfzmvucI3QwkguEUP8mD8PGXPkmrK1T+3GZX3seRGDumLuzcRhyFo6NoOK
         +DKNgwIi4fMhfFt61yeyAzormqY/POzbP4bXAkYpb7joXwK8K8hHG2of0jfenZKeo8Ev
         X91YgzDq/rt0QaDw/nWoMEQGjnEy9Q6N3GBDTSW+A6n1KIsPYRGt6g8xNQvIlHlS6mQh
         zRfy0b/I97RvvIfypa2Qxs4gMdYsQj6rjgNVHBB1SnId5RvvZGHGBcnKRo8Aop/IPMdy
         ww1A==
X-Gm-Message-State: AElRT7FR4BHKAJsPJCnUfK5Q499EIsLt54a0IHkULOrV5bxv7MZeYpQc
        9BtOj/KeU/uhsKjOdlLNaXGZp4dz
X-Google-Smtp-Source: AG47ELup9/3QvSNpBLJuYBbJrXoyq1eXTpmXVcYQqg+7MT9yrQvTiNySA5b9vWCSFPbCTCFx8i4Ebg==
X-Received: by 10.223.161.25 with SMTP id o25mr15348594wro.137.1521925018332;
        Sat, 24 Mar 2018 13:56:58 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id l131sm11820724wmb.36.2018.03.24.13.56.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 24 Mar 2018 13:56:57 -0700 (PDT)
Date:   Sat, 24 Mar 2018 21:00:20 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/4] worktree: teach "add" to check out existing
 branches
Message-ID: <20180324210020.GK2224@hank>
References: <20180317220830.30963-1-t.gummerer@gmail.com>
 <20180317222219.4940-1-t.gummerer@gmail.com>
 <20180317222219.4940-5-t.gummerer@gmail.com>
 <CAPig+cToFeHniMmqhx8HZrtrzqyht=1a2zbx1yQar=WVt2yF1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cToFeHniMmqhx8HZrtrzqyht=1a2zbx1yQar=WVt2yF1g@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/20, Eric Sunshine wrote:
> On Sat, Mar 17, 2018 at 6:22 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > [...]
> > However we can do a little better than that, and check the branch out if
> > it is not checked out anywhere else.  This will help users who just want
> > to check an existing branch out into a new worktree, and save a few
> > keystrokes.
> > [...]
> > We will still 'die()' if the branch is checked out in another worktree,
> > unless the --force flag is passed.
> >
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> > diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> > @@ -61,8 +61,13 @@ $ git worktree add --track -b <branch> <path> <remote>/<branch>
> >  If `<commit-ish>` is omitted and neither `-b` nor `-B` nor `--detach` used,
> > -then, as a convenience, a new branch based at HEAD is created automatically,
> > -as if `-b $(basename <path>)` was specified.
> > +then, as a convenience, a worktree with a branch named after
> > +`$(basename <path>)` (call it `<branch>`) is created.  If `<branch>`
> > +doesn't exist, a new branch based on HEAD is automatically created as
> > +if `-b <branch>` was given.  If `<branch>` exists in the repository,
> > +it will be checked out in the new worktree, if it's not checked out
> > +anywhere else, otherwise the command will refuse to create the
> > +worktree.
> 
> Should this mention --force?
> 
>     ... refuse to create the worktree (unless --force is used).

Yeah, will add.

> > diff --git a/builtin/worktree.c b/builtin/worktree.c
> > @@ -29,6 +29,7 @@ struct add_opts {
> >         int keep_locked;
> >         const char *new_branch;
> >         int force_new_branch;
> > +       int checkout_existing_branch;
> 
> As 'force_new_branch' and 'checkout_existing_branch' are mutually
> exclusive, I wonder if they should be combined into an enum to make it
> easier to reason about.

I gave this a try, but I'm not sure the end result is nicer.  The
problem is that 'new_branch' and 'force_new_branch' both are mutually
exclusive with 'checkout_existing_branch', but 'force_new_branch' is a
"superset" of 'new_branch'.

I can't seem to think of a nice way to encode that, especially not
without duplicating information we're already carrying in
'new_branch'.  Looking at the code however I see that
'force_new_branch' is already only duplicating information that we
already have in a variable in the same function.  I think just
removing that duplication and keeping the 'checkout_existing_branch'
variable in the 'add_opts' would make most sense.

> > @@ -318,8 +319,11 @@ static int add_worktree(const char *path, const char *refname,
> > -       if (opts->new_branch)
> > -               fprintf(stderr, _("creating new branch '%s'"), opts->new_branch);
> > +       if (opts->checkout_existing_branch)
> > +               fprintf(stderr, _("checking out branch '%s'"),
> > +                       refname);
> 
> As with "creating branch" in 2/4, "checking out branch..." here is
> missing a newline.

Thanks will add.

> > +       else if (opts->new_branch)
> > +               fprintf(stderr, _("creating branch '%s'"), opts->new_branch);
> >
> >         fprintf(stderr, _("worktree HEAD is now at %s"),
> >                 find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV));
> > diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> > @@ -198,13 +198,22 @@ test_expect_success '"add" with <branch> omitted' '
> > -test_expect_success '"add" auto-vivify does not clobber existing branch' '
> > +test_expect_success '"add" auto-vivify checks out existing branch' '
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
> This test is no longer checking auto-vivification ("bringing a new
> branch to life automatically"), but rather branch name inference, so
> the title is now misleading. Perhaps retitle it to '"add" checks out
> existing branch of dwim'd name' or something.
> 
> (The name "precious" is also now misleading since it's no longer
> checking that a precious branch does not get clobbered, however,
> changing the name would make the diff unnecessarily noisy, so it's
> probably okay as is.)

Good point.  I can add an additional patch with that rename, so the
changes here stay more obvious, but the end result would still end up
less confusing.

> > +test_expect_success '"add" auto-vivify fails with checked out branch' '
> > +       git checkout -b test-branch &&
> > +       test_must_fail git worktree add test-branch &&
> > +       test_path_is_missing test-branch
> >  '
> 
> Should we also have a corresponding test that this "fail" can be
> overridden by --force? (I realize that --force is tested elsewhere,
> but only with an explicitly-provided branch name, whereas this dwims
> the branch name.)

Yes, will add a test.  Thanks for your review!

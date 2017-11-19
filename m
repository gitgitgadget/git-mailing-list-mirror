Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E52CB202A0
	for <e@80x24.org>; Sun, 19 Nov 2017 17:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751101AbdKSRmS (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 12:42:18 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36654 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751015AbdKSRmR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 12:42:17 -0500
Received: by mail-wr0-f193.google.com with SMTP id y42so6102182wrd.3
        for <git@vger.kernel.org>; Sun, 19 Nov 2017 09:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fDbyOEWg1hZnyrLU78PrO14+14wEmcWzTPuwSuG3el8=;
        b=Zn0f7IOH2gQUlzsxY/ce2ADi8pEQpv2XAkxuORuEumceS3mJbmR+gi7rzbzxyHvIL6
         L4LM21UpOCvnYwTibmocaW2OU+6wMj0HJ6Y4VwwnBBqc1yRipsFrA//0iiQhxDEBofmo
         92axcOaDwml2ZLPpTeltp+bNu4h/heegd6F8onk4y6CAfVquLdWt7YEJq+Fb5P3ia/C5
         zUNi189cRKzzvIR5OOSxHIunw9GBmqFuCud0dIdXItUo25g4ePurTChEMDav24ET5cCw
         gCPOGNHfwKkRSC3GuGFMmKH1kh2/vBqSGPsrxaKebQQ8nJ6UUoZ2mrGKSzrgMUigquG6
         GpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fDbyOEWg1hZnyrLU78PrO14+14wEmcWzTPuwSuG3el8=;
        b=P4gE2xSV4PXnUQjQsaMR2D2MliUEc3Xt9XT7yKHvJOlSu44rtsAUXV425XN+4yqfR4
         e63knXc2SIwwAHstXySoq3mvi8+2uN8GFnM1pCu9OUIvXbjri0cl9EnQQlc/zqlXV7Kj
         pb2+JgDI0QyamiBb8TA2+fiyplEVpY1/mktX0pu4n1yAGpcFPuAidcApOgaRu4WaWPdj
         LXx6AZCOhg3xJ0BTzx6lVeZgMQU0HyJs3QXSznDDV9lXpVLomhM+3ZiZy24yNNz3PVoQ
         GpeaiZCoVeDbw/91sybKZjB7rB8kpCgQaWF3TewES1gb9OhSDqjydFYMW8QtAg5VSDSp
         7XPA==
X-Gm-Message-State: AJaThX7n2TNk2VbYuUGVIR/83l+j0IVFy3p0ybPTlXZ3t4lQydp0EHHu
        3THkSJeMt/cF7uYHUUKW4Z4=
X-Google-Smtp-Source: AGs4zMYNlAu+cvKyNrxdM5u6KXjwBdeQmXwB1Qbwbqe66qreocjdn+q/lxYRKVpIpLyr9601blWbfA==
X-Received: by 10.223.196.194 with SMTP id o2mr8649223wrf.246.1511113336185;
        Sun, 19 Nov 2017 09:42:16 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 29sm7953832wrz.77.2017.11.19.09.42.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Nov 2017 09:42:15 -0800 (PST)
Date:   Sun, 19 Nov 2017 17:43:45 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] worktree: make add <path> <branch> dwim
Message-ID: <20171119174345.GA24891@hank>
References: <20171118181103.28354-1-t.gummerer@gmail.com>
 <20171118224706.13810-1-t.gummerer@gmail.com>
 <20171118224706.13810-3-t.gummerer@gmail.com>
 <CAPig+cS-eQGXU8YKsOAP_RE55GreqLJXPooddpzewUYUZeP6LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cS-eQGXU8YKsOAP_RE55GreqLJXPooddpzewUYUZeP6LQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/19, Eric Sunshine wrote:
> On Sat, Nov 18, 2017 at 5:47 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > Currently 'git worktree add <path> <branch>', errors out when 'branch'
> > is not a local branch.   It has no additional dwim'ing features that one
> > might expect.
> >
> > Make it behave more like 'git checkout <branch>' when the branch doesn't
> > exist locally, but a remote tracking branch uniquely matches the desired
> > branch name, i.e. create a new branch from the remote tracking branch
> > and set the upstream to the remote tracking branch.
> >
> > As 'git worktree add' currently just dies in this situation, there are
> > no backwards compatibility worries when introducing this feature.
> >
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> > diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> > @@ -52,6 +52,13 @@ is linked to the current repository, sharing everything except working
> > +If <branch> is not found, and neither `-b` nor `-B` nor `--detach` are
> > +used, but there does exist a tracking branch in exactly one remote
> > +(call it <remote>) with a matching name, treat as equivalent to
> > +------------
> > +$ git worktree add -b <branch> <path> <remote>/<branch>
> > +------------
> 
> The example from which this was copied in git-checkout.txt shows the
> --track option being used, which makes it clear that the new local
> branch will track the remote-tracking branch. git-worktree, of course,
> does not have a --track option, but would it make sense to mention
> explicitly in the prose that the newly-created local branch tracks the
> remote one? (Or are readers sufficiently savvy to intuit it?)

It is how 'git worktree add -b <branch> <path> <remote>/<branch>'
currently works, which is also not documented anywhere.  However I'm
not sure it's super intuitive, from just reading the command, so I'll
add an explicit mention about it.

> > diff --git a/builtin/worktree.c b/builtin/worktree.c
> > index 7b9307aa58..05fc902bcc 100644
> > --- a/builtin/worktree.c
> > +++ b/builtin/worktree.c
> > @@ -1,4 +1,5 @@
> >  #include "cache.h"
> > +#include "checkout.h"
> >  #include "config.h"
> >  #include "builtin.h"
> >  #include "dir.h"
> > @@ -386,6 +387,20 @@ static int add(int ac, const char **av, const char *prefix)
> >                 opts.new_branch = xstrndup(s, n);
> >         }
> >
> > +       if (ac == 2 && !opts.new_branch && !opts.detach) {
> > +               struct object_id oid;
> > +               struct commit *commit;
> > +               const char *remote;
> > +
> > +               commit = lookup_commit_reference_by_name(branch);
> > +               if (!commit)
> > +                       remote = unique_tracking_name(branch, &oid);
> > +               if (!commit && remote) {
> > +                       opts.new_branch = branch;
> > +                       branch = remote;
> > +               }
> > +       }
> 
> You can simplify the above conditionals to:
> 
>     commit = ...
>     if (!commit) {
>         remote = ...
>         if (remote) {
>             ...
>         }
>     }

Will change, thanks!

> So, although you're not passing --track explicitly to the "git branch"
> invocation just below, you get --track for free since it's the default
> behavior when creating a new local branch from a remote one, correct?
> (Just checking my understanding.)

Yes that's correct.  The default behaviour of git branch does exactly
what we want here, so we're relying on it, instead of gouing through
the trouble of explicitly specifying --track.

We have a test checking the expected behaviour of setting up the
upstream, so in the unlikely event that the behaviour in 'git branch'
changes, we'd still guard against it there.  Therefore I don't think
there's a need to be extra defensive here.

> >         if (opts.new_branch) {
> >                 struct child_process cp = CHILD_PROCESS_INIT;
> >                 cp.git_cmd = 1;
> > diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> > @@ -6,6 +6,16 @@ test_description='test git worktree add'
> > +# Is branch "refs/heads/$1" set to pull from "$2/$3"?
> > +test_branch_upstream () {
> > +       printf "%s\n" "$2" "refs/heads/$3" >expect.upstream &&
> > +       {
> > +               git config "branch.$1.remote" &&
> > +               git config "branch.$1.merge"
> > +       } >actual.upstream &&
> > +       test_cmp expect.upstream actual.upstream
> > +}
> 
> Not a big deal, but it wouldn't hurt to move this function down to the
> point where it is first needed...

Will do.

> >  test_expect_success 'setup' '
> >         test_commit init
> >  '
> > @@ -314,4 +324,40 @@ test_expect_success 'rename a branch under bisect not allowed' '
> > +test_expect_success '"add" <path> <non-existent-branch> fails' '
> > +       test_must_fail git worktree add foo non-existent
> > +'
> > +
> > +test_expect_success '"add" <path> <branch> dwims' '
> > +       test_when_finished rm -rf repo_upstream &&
> > +       test_when_finished rm -rf repo_dwim &&
> > +       test_when_finished rm -rf foo &&
> 
> Also not a big deal, but could all be combined into a single invocation:
> 
>     test_when_finished rm -rf repo_upstream repo_dwim foo &&

Thanks, will change!

Thanks a lot for the review!

> > +       git init repo_upstream &&
> > +       (
> > +               cd repo_upstream &&
> > +               test_commit upstream_master &&
> > +               git checkout -b foo &&
> > +               test_commit a_foo
> > +       ) &&
> > +       git init repo_dwim &&
> > +       (
> > +               cd repo_dwim &&
> > +               test_commit dwim_master &&
> > +               git remote add repo_upstream ../repo_upstream &&
> > +               git config remote.repo_upstream.fetch \
> > +                         "refs/heads/*:refs/remotes/repo_upstream/*" &&
> > +               git fetch --all &&
> > +               test_must_fail git worktree add -b foo ../foo foo &&
> > +               test_must_fail git worktree add --detach ../foo foo &&
> > +               git worktree add ../foo foo
> > +       ) &&
> > +       (
> > +               cd foo &&
> > +               test_branch_upstream foo repo_upstream foo &&
> > +               git rev-parse repo_upstream/foo >expect &&
> > +               git rev-parse foo >actual &&
> > +               test_cmp expect actual
> > +       )
> > +'

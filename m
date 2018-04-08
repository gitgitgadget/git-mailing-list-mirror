Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E33501F404
	for <e@80x24.org>; Sun,  8 Apr 2018 14:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751635AbeDHOad (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 10:30:33 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46882 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751458AbeDHOad (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 10:30:33 -0400
Received: by mail-wr0-f195.google.com with SMTP id d1so5873133wrj.13
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 07:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c9ZcqokYh8XIRGC1YMacq5qQDJzKKf5lXQdurte1PVQ=;
        b=nsSnfBhX9FS5f9SMCqTqp3MFifqNquZAQKKoPSkteCNV8MFoyV9+S9sPE/DBRcYqrZ
         +yIZ5YIv2lrd0ra2f2s9tXj6cmVF8DPb9lPoHuOFv4HuH5sVcopwbWiGvCosh4sXTx/i
         1wWxeXeX2bap1ZIpBm19BIAevH6W0xguCS9TuxMQHNAoWX0HsLnxZTksyS+LaAqQFJpT
         kelZ/uTrGq2JJY97dFybOoZNdnUkC5hL6wANJ6TRDZnf+d9pgKb9C/+ZlfgWong0sNGw
         rH1yDT0mQwjJOL+73GyvjjgD+d+ZEirnVeaALwwWSUD6WgybPNhaqfMNbZwdny2EiYaP
         3pSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c9ZcqokYh8XIRGC1YMacq5qQDJzKKf5lXQdurte1PVQ=;
        b=aGrXw844kFbGuw5srsBkxz7sLMWnTW1dhklAXE6j8x319UPijR+XP+uJJ7dXKFE7/K
         l4fpeWiVE1uUSIfvLZriFDN291K/LtHbIEaUoEOs2EnbEvZPAlQZF4I8Hi07LUxS1VCo
         YC4oE23TsjCU0LriH/fvgmNRlHPqNiB0/hh9oRqxOD+37fi9Q8LupDUjyzmxlvfc7Ap7
         mK0Kr54ATSbvvlYnOdKJe7DWmzWz3bpPaxNELXbPpkUwd26Mfych3yy7vLkVHKMl12Q6
         Gq7YqIkNGTh50YEbYkDMWqKYd1Sl6a0ya82/vdZf7KNOWD6X62V4UgTaeHqOyGFXXt28
         uzLg==
X-Gm-Message-State: AElRT7Hc1CZmTePCmGFd0KMPPnb3/ty4d60srDBFt/k3TRde2sMAhGKT
        I6gPqTRZXKvyaT5Hu86w/h5FATQl
X-Google-Smtp-Source: AIpwx4+htZjZhod4LLqL9UvTQZs59YKLrQe1nfgD2bCW+nf6NrXAXqZY6XppGyGpkK/1sq+ZmmBH0A==
X-Received: by 10.223.176.61 with SMTP id f58mr22954732wra.222.1523197831735;
        Sun, 08 Apr 2018 07:30:31 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id t69sm24840103wrc.87.2018.04.08.07.30.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Apr 2018 07:30:30 -0700 (PDT)
Date:   Sun, 8 Apr 2018 15:30:34 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 6/6] worktree: teach "add" to check out existing
 branches
Message-ID: <20180408143034.GK2629@hank>
References: <20180325134947.25828-1-t.gummerer@gmail.com>
 <20180331151804.30380-1-t.gummerer@gmail.com>
 <20180331151804.30380-7-t.gummerer@gmail.com>
 <CAPig+cSRa=HQkBKXoNNf2tW+c_j5mPKu2NHTUGXxyd6qsLzcnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cSRa=HQkBKXoNNf2tW+c_j5mPKu2NHTUGXxyd6qsLzcnQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/08, Eric Sunshine wrote:
> On Sat, Mar 31, 2018 at 11:18 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > [...]
> > However we can do a little better than that, and check the branch out if
> > it is not checked out anywhere else.  This will help users who just want
> > to check an existing branch out into a new worktree, and save a few
> > keystrokes.
> > [...]
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> > diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> > @@ -61,8 +61,13 @@ $ git worktree add --track -b <branch> <path> <remote>/<branch>
> >  If `<commit-ish>` is omitted and neither `-b` nor `-B` nor `--detach` used,
> > +then, as a convenience, a worktree with a branch named after
> > +`$(basename <path>)` (call it `<branch>`) is created.
> 
> I had a hard time digesting this. I _think_ it wants to say:
> 
>     If `<commit-ish>` is omitted and neither `-b` nor `-B` nor
>     `--detach` is used, then, as a convenience, the new worktree is
>     associated with a branch (call it `<branch>`) named after
>     `$(basename <path>)`.

Yeah, this is what it wants to say, and what you have sounds much
nicer, will change.

> >  If `<branch>`
> > +doesn't exist, a new branch based on HEAD is automatically created as
> > +if `-b <branch>` was given.  If `<branch>` exists in the repository,
> 
> Maybe: s/exists in the repository/does exist/
> Or: s/.../is a local branch/
> 
> Though, the latter may be getting too pedantic.
> 
> > +it will be checked out in the new worktree, if it's not checked out
> > +anywhere else, otherwise the command will refuse to create the
> > +worktree (unless `--force` is used).
> > diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> > @@ -198,13 +198,24 @@ test_expect_success '"add" with <branch> omitted' '
> > +test_expect_success '"add" checks out existing branch of dwimd name' '
> > +       git branch dwim HEAD~1 &&
> > +       git worktree add dwim &&
> > +       test_cmp_rev HEAD~1 dwim &&
> > +       (
> > +               cd dwim &&
> > +               test_cmp_rev dwim HEAD
> 
> Nit: Argument order of the two test_cmp_rev() invocations differs.
> 
> > +       )
> > +'
> > +
> > +test_expect_success '"add <path>" dwim fails with checked out branch' '
> > +       git checkout -b test-branch &&
> > +       test_must_fail git worktree add test-branch &&
> > +       test_path_is_missing test-branch
> > +'
> > +
> > +test_expect_success '"add --force" with existing dwimd name doesnt die' '
> > +       git worktree add --force test-branch
> >  '
> 
> Maybe make this last test slightly more robust by having it "git
> checkout test-branch" before "git worktree add ..." to protect against
> someone inserting a new test (which checks out some other branch)
> between these two. Probably not worth a re-roll.

As I'll have to re-roll anyway for the other suggestions, I'll change
this as well.

Thanks for your review!

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 109AB1F404
	for <e@80x24.org>; Mon,  9 Apr 2018 19:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752202AbeDIToE (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 15:44:04 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46413 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751942AbeDIToD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 15:44:03 -0400
Received: by mail-wr0-f196.google.com with SMTP id d1so10703843wrj.13
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 12:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KsTHbRGIhz52vZgwjn+M8RD/BP9QfBaAT/94Iic1/3Y=;
        b=G/JYBQ0hoQSXny1i7dGjXJyHMTCtzO+H70ZQXeck+v6ec99T17T0m2rtJGeuLpfugP
         9slc5h9b1Gvg691R9/PzfAlTOxuIrOA+WX5TPgFLnQvD9gtB9VAfIhzmWvtzvPZt9MAK
         zb0B1Go4OCm/vannF3IJIZGpwLnf+aM7P9wX+YRX0tJ7d90pGL4Y7vLIb96fySK0MD0X
         v0io7s75KYP5JrQ5X4nfA+VsXBZ35QgYDPRkfYcD2PcRxUffw0LhF96e5Yunvk7k6VVh
         ke/s0u7/vBDgNOQFPEz6af5jKtxjoLgRDbc/rXp451pFDfBFXRpn+PD3U+mtc/AGGV07
         nC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KsTHbRGIhz52vZgwjn+M8RD/BP9QfBaAT/94Iic1/3Y=;
        b=ObZQ/mY8ZSVv+bdR1n5ntLwCpq+vRq5WQfEnQDpbtDqXGnmxnp6PMjxeFMKQKJV1td
         tfbmlwFHuMtE8Wfil7MgB1zSNzYOQOSqVZUAR9VPMokumQnTSNtL5+OqDYryAv5Uc+Hu
         8bQNSSJhMIZEYMi59WvlxTwjK7mUIzs6YOU4hTeZRpohoYk2Pql9o3p4931I/6CKgINW
         u+JI3H5Jf9Z/5p23V/oAPVah06Zr1ZBkdVE5UrHtOmu/CIDVggnVqUuFe6lc0hE/dYEl
         LI4dp7JoCn7kKaNkFyWcdXxt7FMSw5lqjKuFRsxp4q4EY9yx+p4k1s7mQ43Os8zupYjF
         ahUg==
X-Gm-Message-State: AElRT7HmiEYx1YnEgSFi5s8Ln1J0Tstu/3q75/V4MIzKrCfGT1E7Zm/D
        SjqZR48jZkK7Q12jk7MBTyM=
X-Google-Smtp-Source: AIpwx4/dHyaUEEn2p98qksccu1bwaul0m7JLDLtKROyBcBktNIzNSz/6PKpOo2GnVPNDkG0WtyIMTg==
X-Received: by 10.223.220.77 with SMTP id m13mr24747053wrj.274.1523303041797;
        Mon, 09 Apr 2018 12:44:01 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 39sm1655979wry.89.2018.04.09.12.44.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Apr 2018 12:44:00 -0700 (PDT)
Date:   Mon, 9 Apr 2018 20:44:05 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 6.5/6] fixup! worktree: teach "add" to check out
 existing branches
Message-ID: <20180409194405.GM2629@hank>
References: <20180325134947.25828-1-t.gummerer@gmail.com>
 <20180331151804.30380-1-t.gummerer@gmail.com>
 <20180331151804.30380-7-t.gummerer@gmail.com>
 <20180401131138.GE2629@hank>
 <CAPig+cRYgLwLZnXeOc2VWBmh8j_AxSGmf2x-DJ1kAbY3BzsAPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cRYgLwLZnXeOc2VWBmh8j_AxSGmf2x-DJ1kAbY3BzsAPQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/08, Eric Sunshine wrote:
> On Sun, Apr 1, 2018 at 9:11 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > So while playing with it a bit more I found one case where the new UI
> > is not ideal and a bit confusing.  Namely when the new check out dwim
> > kicks in, but there is already a file/directory at the path we're
> > giving to 'git worktree add'.
> >
> > In that case something like the following would be printed:
> >
> >     $ g worktree add ../next
> >     Checking out branch 'next'
> >     fatal: '../next' already exists
> >
> > Instead I think we'd just want the error without the "Checking out
> > branch" message, which is what this fixup here does.
> 
> Doesn't the same UI "problem" exist when it creates a new branch?
> 
>     $ git worktree add ../dwim
>     Creating branch 'dwim'
>     fatal: '../dwim' already exists
> 
> As you mention below, we don't (yet) clean up the newly-created branch
> upon failure, so we can't suppress the "Creating branch" message as
> you suppress the "Checking out branch" message above (since the user
> needs to know that the new branch exists).
> 
> This is making me wonder if "Checking out branch" is perhaps the wrong
> terminology. What if it said something like this instead:
> 
>     $ git worktree add ../next
>     Preparing worktree (branch 'next' <= 'origin/next')
>     fatal: '../next' already exists
> 
>     $ git worktree add ../gobble
>     Preparing worktree (new branch 'gobble')
>     fatal: '../gobble' already exists
> 
> This way, we don't need the special case added by this "fixup!" patch.
> (I'm not wedded to the "Preparing" message but just used it as an
> example; better suggestions welcome.)

Yeah, I think this looks like another improvement of what I currently
have.  I'm not sure about the "(branch 'next' <= 'origin/next')"
message though, as it doesn't cover all the ways the branch could be
set up for tracking the remote branch, e.g. tracking by rebasing, when
'branch.autosetuprebase' is set up.

But how about just "Preparing worktree (new branch 'next')", and then
keeping the message from 'git branch' about setting up the remote
tracking branch?

> > One thing that gets a bit strange is that the "Checking out branch"
> > message and the "Creating branch" messages are printed from different
> > places.  But without doing quite some refactoring I don't think
> > there's a good way to do that, and I think having the UI do the right
> > thing is more important.
> 
> The implementation is getting rather ugly, though, especially with
> these messages being printed by different bits of code like this.
> worktree.c:add_worktree() was supposed to be the low-level worker; it
> wasn't intended for it to take on UI duties like this "fixup!" makes
> it do. UI should be handled by worktree.c:add().
> 
> Taking the abonve "Preparing..." idea into consideration, then it
> should be possible to sidestep this implementation ugliness, I would
> think.
> 
> > One thing I also noticed is that if a branch is created by 'git
> > worktree add', but we fail, we never clean up that branch again, which
> > I'm not sure is ideal.  As a pre-existing problem I'd like to keep
> > fixing that out of the scope of this series though (at least after
> > this series the user would get some output showing that this happened,
> > even when the branch is not set up to track a remote), so I'd like to
> > keep fixing that out of the scope of this series.
> 
> Nice idea, but outside the scope of this series, as you mention.
> 
> > diff --git a/builtin/worktree.c b/builtin/worktree.c
> > @@ -27,6 +27,7 @@ struct add_opts {
> >         int keep_locked;
> > +       int checkout_existing_branch;
> >  };
> > @@ -316,6 +317,8 @@ static int add_worktree(const char *path, const char *refname,
> > +       if (opts->checkout_existing_branch)
> > +                 fprintf_ln(stderr, _("Checking out branch '%s'"), refname);
> >         if (opts->checkout) {
> 
> I'd have expected to see the "if (opts->checkout_existing_branch)
> fprintf_ln(...)" inside the following "if (opts->checkout)"
> conditional, though, as noted above, I'm not entirely happy about
> worktree.c:add_worktree() taking on UI duties.

Fair enough.  I didn't quite like the code either.  I think what you
have above would be much nicer, and I'll implement that in the
re-roll.

> >                 cp.argv = NULL;
> >                 argv_array_clear(&cp.args);

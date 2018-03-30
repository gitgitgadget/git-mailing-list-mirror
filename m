Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 999151F404
	for <e@80x24.org>; Fri, 30 Mar 2018 13:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbeC3Ntu (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 09:49:50 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50429 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752043AbeC3Ntt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 09:49:49 -0400
Received: by mail-wm0-f68.google.com with SMTP id l201so15717533wmg.0
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 06:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PnzFYVjp659rCiVEBEi4GuILGH4qeT7Tn3uZQFbFzuo=;
        b=clnfFAxjarq2dunvMuYKo71P/U2bTr9duX47srF37/2gdkZ3J1hxeZoEOIhxIRs9kD
         trZ7sT6FHDb8FJDpdKcpwmxB6vle6jUSvWc4LhKk4Unmu/Zo2C4BED4otjGDnpBUGoNA
         /fBAFMPGI+A7uUc2woO9NmoSosNX1aNAGckXD2jHF9PJBBr3rrndwYII5jfjRdejNKxD
         mUVXNCkvXzFP3eiHNpY90WXe5aq1WwEfXH2AmtMjY0FNiMAOy4OPmMfgRAgjemvZ2O+k
         qPb1/m1JDa6iizIPB7vsESRmgL1NQhtBIQLMI9zKmFM6SvIZXeXZZveg6t9LufQbb5Pe
         My1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PnzFYVjp659rCiVEBEi4GuILGH4qeT7Tn3uZQFbFzuo=;
        b=YrXUxUHA2TYWV71zx737ssH2zdnVVuRDy7ZDhh0FJmDpUUELuAif6QVAQgDaQtOA/r
         qrYu2A3MFm5P6uxpDOOXp0BWTB6ZpLZraiHtSJM2pnaQM1FrEKBg3c5kLUKSs1AuYUzS
         IHic/1bl5LCEtSVM0b/jL0P0dic+g48AhRkXHxkLUuErAOsJgtF7beFvDp3JAedVxSSe
         UPg24Q49YrlixmSpKEeiHhIp3mYwNKUuNSy23wNQYKSmIZELnVmwIBWTGf0RWV871qzG
         yxsgeVTKiSvQ9BZzbqrRCK8IZjwXZbwYjcv2+cUoMPcwvgy3+5Of6skpBgcZlIXZk5rn
         P1nw==
X-Gm-Message-State: AElRT7HhIbogl3MbSI+wpMYTbSAjXq5+lNgZuUE+AMosYbz8LjLDJmIb
        qiin6r3DBIUhXlp5SDDsPQ02kjHQ
X-Google-Smtp-Source: AIpwx48RAJZgXUKe/on8YtAVC4+wdNMKYgKbjotZTnSLAF246VK/prPtjLmoOMi+kNfntwdolFGmYQ==
X-Received: by 10.28.10.195 with SMTP id 186mr2344869wmk.136.1522417787887;
        Fri, 30 Mar 2018 06:49:47 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id y68sm9988635wrb.73.2018.03.30.06.49.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Mar 2018 06:49:46 -0700 (PDT)
Date:   Fri, 30 Mar 2018 14:53:14 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/6] worktree: be clearer when "add" dwim-ery kicks in
Message-ID: <20180330135314.GA2629@hank>
References: <20180317222219.4940-1-t.gummerer@gmail.com>
 <20180325134947.25828-1-t.gummerer@gmail.com>
 <20180325134947.25828-3-t.gummerer@gmail.com>
 <CAPig+cSNYdJwBS1me+bkELDmrPHgDZJDwjA=o=O4CzQBT=jpzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cSNYdJwBS1me+bkELDmrPHgDZJDwjA=o=O4CzQBT=jpzQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/27, Eric Sunshine wrote:
> On Sun, Mar 25, 2018 at 9:49 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > Currently there is no indication in the "git worktree add" output that
> > a new branch was created.  This would be especially useful information
> > in the case where the dwim of "git worktree add <path>" kicks in, as the
> > user didn't explicitly ask for a new branch, but we create one from
> > them.
> 
> Failed to notice this last time around: s/from/for/
> 
> Perhaps Junio can tweak it when queuing.
> 
> > Print some additional output showing that a branch was created and the
> > branch name to help the user.
> >
> > This will also be useful in the next commit, which introduces a new kind
> 
> It's no longer the _next_ commit which does this. Perhaps say instead
> "a subsequent commit". (Again, perhaps Junio can tweak it since it's
> not worth a re-roll.)

Right, will fix.

> > of dwim-ery of checking out the branch if it exists instead of refusing
> > to create a new worktree in that case, and where it's nice to tell the
> > user which kind of dwim-ery kicked in.
> >
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> > diff --git a/builtin/worktree.c b/builtin/worktree.c
> > @@ -318,6 +318,9 @@ static int add_worktree(const char *path, const char *refname,
> > +       if (opts->new_branch)
> > +               fprintf_ln(stderr, _("creating branch '%s'"), opts->new_branch);
> 
> I didn't think of this before, but what happens with the original
> dwim-ery you added which checks out a remote branch matching the
> worktree name if no such local branch exists? I was wondering if we'd
> want to see a distinct and more informative message in that case, such
> as "creating branch '%s' from remote '%s'" or something. However, I
> see that we're already getting a message:
> 
>     Branch 'foo' set up to track remote branch 'foo' from 'origin'.
>     creating branch 'foo'
>     new worktree HEAD is now at d3adb33f boople
> 
> which is a bit weird since tracking appears to be set up before the
> branch itself is created. I thought that this was another UI
> regression of the sort I mentioned in [1], however, the messages were
> out of order even before the current patch series:

Yeah I agree this is a bit odd.  I did think about this, and the main
reason why I didn't change this by passing the '--quiet' flag to 'git
branch' which we call in the 'add()' function is to keep the
information about the remote tracking.

Looking at where this information actually comes from, there's
multiple different ways we'd have to distinguish to print this
information properly.

Now that I put some more thought into this, I think there are a couple
of ways to solve this, the easiest and cleanest of which would
probably be to run 'git branch' through 'pipe_command', save the
output and print it after the "creating branch 'foo'" message. 

>     Branch 'foo' set up to track remote branch 'foo' from 'origin'.
>     Preparing foo (identifier foo)
>     Checking out files: 100% (9999/9999), done.
>     HEAD is now at d3adb33f boople
> 
> This highlights another regression introduced by this series. Patch
> 1/6 suppresses the "Checking out files:" message, which is a bit
> unfortunate for decent sized worktrees. I'm not sure I'm entirely
> happy about that loss. Thoughts?

Tbh I never really noticed the "Checking out files" output, because
the repositories I used day to day are usually of a smaller size,
where checking out the files takes less than a second, so I would
never even notice this output.

But while I don't care about it, others may, so I think it would be
better to preserve this output.  Maybe the best way to do that would
be to not use 'run_command' to run 'git reset --hard', but to instead
replace that with the internal functions.

I haven't actually looked at how hard this would be, but I'm guessing
this may be the best option to avoid this UI regression.  I'll play
with this some more and see what I can come up with, and send a
re-roll hopefully in a few days.

Thanks for your review!

> [1]: https://public-inbox.org/git/CAPig+cT8i9L9kbhx=b0sG4_QYNdoEDPW-1xypM9xzBqPmqR__Q@mail.gmail.com/
> 
> >         fprintf(stderr, _("new worktree HEAD is now at %s"),
> >                 find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV));

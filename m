Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44B0F20954
	for <e@80x24.org>; Sat, 25 Nov 2017 20:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751237AbdKYUEp (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 15:04:45 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42275 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750819AbdKYUEo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Nov 2017 15:04:44 -0500
Received: by mail-wr0-f194.google.com with SMTP id o14so22968158wrf.9
        for <git@vger.kernel.org>; Sat, 25 Nov 2017 12:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z3that9OpFYSMjAZiyg4tJt8+rgh+7widi74e8NDqvE=;
        b=ZXj/adPPeBAVoYsYP9I08GyHvhWLgWleX4ZO7D4XX/e0xDQEpqycNtt3lMUPw9BoQf
         pNO4+wkLa35d+RDnH3MP/8EAC7LBrW4VkSWY09rMS0/l5TyuUmB0m0Sr09xSbS5f9AFO
         6PKItuRkihNIYs9IDXHRzmx/OtdSr8hykw0GYdTwK2DduG6fGLu8zgGKlDawuCdkW8aT
         Jko/opDyQwY+Z/+V//rwUP8Y5J5yEfg/3kZ4tWovJQoOdqe95XnUZ5QY3L38U+6ioP64
         q4D0XGLT58B3rrUGxZGXpfx1TIVcPdc6VUgiviMr4J7OjqyAyM9/ifT8n4lhFtjzLYld
         eT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z3that9OpFYSMjAZiyg4tJt8+rgh+7widi74e8NDqvE=;
        b=FtSy3cwcx1qCd4DrUCBF0UtKMsMtv2GWx5pLf+tZE0KhtL4AIkUg/znZKWmeWIanGX
         AazfyJKDK2fpY6leMXwKxEM4XUKxVwC3vBpsnL1CQlSAQ14C5VgIh/61p91hQLtgGXc3
         f+aTTobAPd1vt0ZOqO3VS3NwzpLxOqrUObIDoQ/5RnVc0nuVatkPEGjCA4LlEEF4qN1U
         ybwD7/tn4BVte/gFpQxUG2PVd8dhPcWzzuVMPwNkY8ZYjIGW7HK/rep4blga6/JyaQRR
         gEWKGlwqmJscbmmvBPnyoHQ57djJ+xB2aQnEwj8v8qGgxLJY2Prtu2PGGXkJ7sQhwQAA
         2oag==
X-Gm-Message-State: AJaThX6dkZjQSmhIfJxnkTS9ST1qVo7jIH+WLybAyaosjkB3w8krrNG9
        P6cmJFcPmLkRnOGCaXnDPNGkawKJ
X-Google-Smtp-Source: AGs4zMYTT7S+pF+s1BR7RiQ99390vRktpIFQyhdQDqJXdcBecC0aMwl4ll/qrNi9Rgp+uio8zmTTtA==
X-Received: by 10.223.147.135 with SMTP id 7mr29396372wrp.237.1511640282648;
        Sat, 25 Nov 2017 12:04:42 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id t135sm8014907wmt.24.2017.11.25.12.04.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Nov 2017 12:04:41 -0800 (PST)
Date:   Sat, 25 Nov 2017 20:06:15 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Paul Smith <paul@mad-scientist.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 4/4] worktree: make add <path> dwim
Message-ID: <20171125200615.GA4344@hank>
References: <mailto:20171118224706.13810-1-t.gummerer@gmail.com>
 <20171122223020.2780-1-t.gummerer@gmail.com>
 <20171122223020.2780-5-t.gummerer@gmail.com>
 <xmqq1skonoaw.fsf@gitster.mtv.corp.google.com>
 <20171125175010.GB14993@hank>
 <1511634365.2847.211.camel@mad-scientist.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1511634365.2847.211.camel@mad-scientist.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/25, Paul Smith wrote:
> On Sat, 2017-11-25 at 17:50 +0000, Thomas Gummerer wrote:
> > This would be the output in the new version:
> > 
> >      $ git worktree add ../bla
> >      Branch 'bla' set up to track remote branch 'bla' from 'origin'.
> >      Preparing ../bla (identifier bla)
> >      HEAD is now at 4aade43 bla
> > 
> > vs. the output without the changed behaviour:
> > 
> >      $ git worktree add ../bla
> >      Preparing ../bla (identifier bla)
> >      HEAD is now at 0f215c9 initial import
> > 
> > Of course that assumes that it's used directly, not in scripts, and
> > that users will actually read the output of the command when they
> > invoke it.  Maybe these are not safe assumptions to make though, and
> > we'd rather not have this on by default then.  As I mentioned
> > previously I would prefer having this as default, but I'm happy to
> > hide this behaviour behind a flag if we want to be more careful about
> > introducing this.  Dunno?
> 
> Speaking as a simple user, I find the current behavior of Git worktree
> add very frustrating; I am constantly wanting to create worktrees for
> other peoples' branches so I can look at the code there without messing
> up my workspace, and it's really inconvenient to do that now.
> 
> Also, the current special handling of the directory name as a putative
> branch name is not helpful for me because many of the branches I need
> to examine use "/" as their separator.  I don't begrudge making that
> feature more "DWIM" for those that can use it, but hopefully some help
> is forthcoming for those who can't.
> 
> For example, I need to create a local worktree for the remote rel/1.0
> branch... what do I do?
> 
> What I want to work is this:
> 
>     git worktree add ../1.0 rel/1.0
> 
> and have it create a worktree at ../1.0, then do the equivalent of "git
> checkout rel/1.0" which includes setting up to track the remote branch.
>  But of course this doesn't work at all; I get:
> 
>     fatal: invalid reference: rel/1.0
> 
> Personally I would think it odd to have to add an extra flag to get
> what I would expect would be "normal" behavior (checkout).
> 
> But maybe that's just me.

This part is getting done in 3/4, and is definitely going to work
without an additional flag, so this is (hopefully) soon going to work
just as you want :)

This is less controversial because as you mentioned this currently
doesn't work at all, so there are no backwards compatibility worries.

For the other case of

    git worktree add ../foo

however we currently document one behaviour, which I would like to
change (I usually have branches without a / in that I want to look at)
we currently document one behaviour, which I'd like to change.  So in
that case we are a bit worried about backwards compatibility, and how
this will affect current users that have a certain expectation of how
the command is supposed to work, hence the discussion of whether to
hide the new behaviour behind a flag or not.

Either way, if we do put the behaviour behind a flag, I'll also add a
configuration variable, which can be set to enable the new behaviour
so one doesn't have to type out the flag all the time.

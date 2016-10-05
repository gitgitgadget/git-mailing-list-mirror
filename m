Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78D2E1F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 12:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755070AbcJEMEl (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 08:04:41 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38090 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754927AbcJEMEj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 08:04:39 -0400
Received: by mail-wm0-f47.google.com with SMTP id p138so270010790wmb.1
        for <git@vger.kernel.org>; Wed, 05 Oct 2016 05:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AAnVHc8XSGqIwZYhpIxrhgRHwNJDIGcZ0aO0kH9Ul+0=;
        b=yCFb0pvcW4oEeOEwmv+82f22bxO6b5VNR7GtFRVJvudTbq19ue/mp/vyxU0wLgCRzb
         yDGCa7S8znvSPSIoRu+HzGCjgOdUeLMaRHkx66beG7w0nDskfZkgTAklWdCWllS/2tlG
         ZI3kHhqz7s3RHsxWA1OZM6QY2OziPwNIEzAFIWI64MmRG06qZ+LrAD1J9e+TBPSd+ECE
         cmTZPEEzsaVWAohYT7yPyhxC+Lk1aqXMCBTDsC9weOpnnLn0hAM5fhaHDyEfKHZefAVK
         /ysayliLp7G9iNNqzVQRBRQa5Eqacf5m49w3PhTpMM7XLAAlJrzWi5LdTZ2dvvifFvGu
         BfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AAnVHc8XSGqIwZYhpIxrhgRHwNJDIGcZ0aO0kH9Ul+0=;
        b=d3+Cmy9DGR0PoAkjfStvrqrrd4AXL6vR5KWT9tCyYXGf93XezG6Wd5cluS3QTfTysa
         9nd8LW5skh9Ypm3K3Dxgd87jznc3FZ76H2Zx7oEQaxdhCavOiP/VyEB8yq7Z6GfBgOKP
         WBmRmJKNC/3a14t18xCVD9qlVI65JeF1H++gBDl0eBDKDnj+ZZrDPKIZ1p3tTavqBZod
         lyZYC6UON8WOjRLoXPXyx47bU0f72C+vbl7kUH1yw8ZQ/LVsMt6B+5mYh7zCUZ2scWT0
         4gmUFpKVvhkkSAYDPd8LFS8puVu9C6B/54euxgT5M7iKWgGw5VGNdI//Jnzt2xaaeCTT
         B4bg==
X-Gm-Message-State: AA6/9RmIs1WaUilvEr703D+namRirCkajWObmDFT9ec217GeGmEHW4hNPZV+uQqzsjo9JQ==
X-Received: by 10.194.112.131 with SMTP id iq3mr7461393wjb.123.1475669077693;
        Wed, 05 Oct 2016 05:04:37 -0700 (PDT)
Received: from localhost (110-174-57-143.static.tpgi.com.au. [110.174.57.143])
        by smtp.gmail.com with ESMTPSA id o2sm8661675wjo.3.2016.10.05.05.04.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Oct 2016 05:04:36 -0700 (PDT)
Date:   Wed, 5 Oct 2016 22:59:34 +1100
From:   James B <jamesbond3142@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     musl@lists.openwall.com, Rich Felker <dalias@libc.org>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [musl] Re: Regression: git no longer works with musl libc's
 regex impl
Message-Id: <20161005225934.770d73b7d491d4bf4816411d@gmail.com>
In-Reply-To: <alpine.DEB.2.20.1610051231390.35196@virtualbox>
References: <20161004150848.GA7949@brightrain.aerifal.cx>
        <20161004152722.ex2nox43oj5ak4yi@sigill.intra.peff.net>
        <20161004154045.GT19318@brightrain.aerifal.cx>
        <alpine.DEB.2.20.1610041802310.35196@virtualbox>
        <20161005090625.683fdbbfac8164125dee6469@gmail.com>
        <alpine.DEB.2.20.1610051231390.35196@virtualbox>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.31; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 5 Oct 2016 12:41:50 +0200 (CEST)
Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> > 
> > Wow, I don't know that Windows is a git's first-tier platform now,
> 
> It is. Git for Windows is maintained by me, and I make as certain as I can
> that it works fine. 
> And yes, we have download numbers to support my claim.
> The latest release is less than 24h old, but I can point you to Git for
> Windows 2.8.1 whose 32-bit installer was downloaded 397,273 times, and
> whose 64-bit installer was downloaded 3,780,079 times.

Number downloads does not make first-tier platform. You know that as well as everyone else.

First-tier support is the decision made by the maintainers that the entire features of the software must be available on those first tier platforms. So if Windows is indeed first-tier platform for git, it means any features that don't work on git version of Windows must not be used/developed or even castrated. That's a scary thought.

Being a maintainer for "Git for Windows" does not make one automatically as the maintainer for "git", although that can happen.

So this decision that "Windows is now a first-tier platform for git" - is your own opinion, or is this the collective opinion of *all* the git maintainers? 


> 
> > and Linux/POSIX second.
> 
> This is not at all what I said, so please be careful of what you accuse
> me.

Yes, you did not say that. I said that. And I will say more. Git has Linux/POSIX roots. Attempting to "not use common POSIX features because they're not available on Windows" *does* make Linux/POSIX feels like second class platform for git. The way I see it, it should be *the other way around*.

It's a very sad day for a tool that was developed originally to maintain Linux kernel, by the Linux kernel author, now is restricted to avoid use/optimise on Linux/POSIX features *because* it has to run on another Windows ...

> 
> What I said is that we never exploited the full POSIX standard, but that
> we made certain to use a subset of POSIX in Git which would be relatively
> easy to emulate using Windows' API.

All this just proves my point above.

And - I notice you use the pronoun "we" - is that a "royal we" (which means the entire point is your own or your cohorts position), or is it the official position of all git maintainers?

> 
> > Are we talking about the same git that was originally written in Linus
> > Torvalds, and is used to manage Linux kernel?
> 
> It was originally written by (not in) Linus Torvalds, and yes, the Linux
> kernel is one of its many users.

That was a rhetorical question.

> 
> > Are you by any chance employed by Redmond, directly or indirectly?
> 
> I am not exactly employed by Redmond, but by Microsoft (this is what you
> meant, I guess).
> 
> I maintained Git for Windows in my spare time, next to a very demanding
> position in science, for eight years. In 2015, I joined Microsoft and part
> of my role is to maintain Git for Windows, allowing me to do a much better
> job at it.


Well thank you for being honest. I can see now why you responded the way you did (and still do). By being employed by Microsoft, and especially paid to work on Git for Windows, you have all the incentives to make it work best on Windows, and to make it as its first-tier platform within the limitation of Windows.

That in itself is not a problem - it only starts to become a problem when you try to cut down support for other platforms or stifle improvements on other platforms because "hey it makes it too hard to do those things in Windows".

> 
> Of course, I do not only improve Git's Windows support, but contribute
> other patches, too. You might also appreciate the fact that some of my
> colleagues started contributing patches to Git that benefit all Git users.
> 

By "colleagues" I assume other Microsoft employees? 
I don't have a problem with that - thank you and your colleagues for making git better.

But that does not give the right to you to control that "if it doesn't work on Windows we shouldn't do it". If you do, and at the same time claim that musl-libc (which is Linux-only) support is unimportant compared to your 4 million Git-for-Windows downloads really don't do well for your or your employer's image. I don't have to say why - everyone outside Microsoft knows why.

In conclusion, I certainly hope that your view is not shared by the other git maintainers.

PS: Rich, sorry for the distraction. I have said what I want to say, so I'll bow out from this thread.

cheers,
James

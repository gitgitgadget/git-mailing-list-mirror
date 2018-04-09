Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C62631F404
	for <e@80x24.org>; Mon,  9 Apr 2018 19:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751919AbeDITrW (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 15:47:22 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:52712 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751507AbeDITrV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 15:47:21 -0400
Received: by mail-wm0-f54.google.com with SMTP id g8so21456048wmd.2
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 12:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HV17G+OLs2+AXfYFsUkq3reXLyYPJNPFYH/jlckuE1o=;
        b=nvYYCm93A5fj2CQGHby1yqa2qfapEl5VKRiUVpQH2I0QaboTP7qllU6KXjmFoRTCyC
         w9irw1SFXPROomQwIliYsF1LHPRG801wE4qipZedKsNLPo7kUN96rypaIR5FmTC1wlJN
         QJlmytFojqt6DAcLFuP0xVcaDlu6Qte/m/Yvb311j51m3acZhIw/WybhyGci8/7Xgewv
         QTvOlCNxxsYF/1IXKH4uPfxpMyHHeY14pHGpV2N8+6y79PG25vqSO6pbDGv+hSKRAxIp
         WR0jnysQO7So/N+eCotA48FtwdRr3C27Y0sd1YdDt9Cd1Nk0GxV5iM9OmUVmhW2qy0sZ
         ovJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HV17G+OLs2+AXfYFsUkq3reXLyYPJNPFYH/jlckuE1o=;
        b=Br3UXbla8DLIv7xalJdLclZmz8Pz1+CxuizVYI24pnEyQMlzfydIha40Ng6PmdPefg
         otIL1UDFUkLwT61cdHsVrymQDKWrZnQ7X8kW8drFSHtbd6STg9ihWG7FCypHhgPCLZ3v
         Vd8izfXHvumAIEJ59fpO48ojJQQYWUwrm83uxb+jbhitAzweto5D2iFFBSS0k28bCai1
         M+94XtkVBapn3CTGPyfSPCNIr1MXpWY2eyeY3+SGi/uVJSK63p/hgKHedjQq2YuwXKi2
         KHVb128CvRN2zPsjucNbBguxr9Y9H2VfM7aPAVNIjOKou6ZQfyGLCa6K95az6OT9JdMP
         HRWQ==
X-Gm-Message-State: ALQs6tBtwD9ze8U6/g/HWILcJwNMmWbYK+Mm/yhbXUfbjGPtZtNPFoM7
        8wwhJ3GJsbP2JOSlrPuTSWJAZMCg
X-Google-Smtp-Source: AIpwx4+mFis4acSmZsbXoj31edqp32ipLbeXC9lhoJjVykz//An/elSZv+qqLEEoy66RLe5DnfSehQ==
X-Received: by 10.28.213.139 with SMTP id m133mr799365wmg.144.1523303239841;
        Mon, 09 Apr 2018 12:47:19 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 69sm156755wmn.9.2018.04.09.12.47.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Apr 2018 12:47:19 -0700 (PDT)
Date:   Mon, 9 Apr 2018 20:47:23 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/6] worktree: teach "add" to check out existing
 branches
Message-ID: <20180409194723.GN2629@hank>
References: <20180325134947.25828-1-t.gummerer@gmail.com>
 <20180331151804.30380-1-t.gummerer@gmail.com>
 <CAPig+cQ8VzDycUMo-QOexNDBgQGEGj2BPmPa-Y0vhGCt_brbhg@mail.gmail.com>
 <20180408142417.GJ2629@hank>
 <CAPig+cSGxMgEwqXDb4-_AWbdvm5=x-dgwi4mKqDbNfex2KDm0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cSGxMgEwqXDb4-_AWbdvm5=x-dgwi4mKqDbNfex2KDm0Q@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/08, Eric Sunshine wrote:
> On Sun, Apr 8, 2018 at 10:24 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > On 04/08, Eric Sunshine wrote:
> >> On Sat, Mar 31, 2018 at 11:17 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > Let me think through some of the cases here, of 'git worktre add
> > <path> <commit-ish>' with various flags and what the UI would be with
> > that added:
> >
> >   - no flags:
> >
> >     $ git worktree add ../test origin/master
> >     Checking out 'origin/master'
> >     Checking out files: ...%
> >     New worktree HEAD is now at c2a499e6c Merge branch 'jh/partial-clone'
> >
> >   - -b branch:
> >
> >     $ git worktree add -b test ../test origin/master
> >     Creating branch 'test'
> >     Checking out 'origin/master'
> 
> Did you mean "Checking out 'test'"?
> 
> >     Checking out files: ...%
> >     New worktree HEAD is now at c2a499e6c Merge branch 'jh/partial-clone'
> >
> >     Would we want to omit the "Checking out ..." here?  I'm leaning
> >     towards yes, but dunno?
> 
> To which "Checking out" message do you refer, the one showing the
> branch name or the one showing the checkout progress?
> 
> I'd probably agree that showing both "Creating" and "Checkout out" is
> overkill. However, see my response[1] to your "fixup!" patch in which
> I explore the idea that unifying "Checking out 'branch' and "Creating
> branch" messages may be a good idea and get us out of some UI jams
> which seem to be cropping up.
> 
> [1]: https://public-inbox.org/git/20180325134947.25828-1-t.gummerer@gmail.com/T/#m5d38b0c6427609e8c36aa6af83d518791c1e1581
> 
> >   - Original dwim with --detach flag
> >
> >     $ git worktree add --detach ../test
> >     Checking out 'c2a499e6c'
> >     Checking out files: ...%
> >     New worktree HEAD is now at c2a499e6c Merge branch 'jh/partial-clone'
> >
> > Looking at this, I'm not sure what's best here.  I'm not sure I'm a
> > fan of the duplicate "Checking out " message (I assume that's what you
> > meant above, or did you mean just "Checkout ..."?)
> 
> Taking [1] into account, this might become something like:
> 
>     $ git worktree add --detach ../test
>     Preparing worktree (detached HEAD c2a499e6c)
>     Checking out files: ...%
>     New worktree HEAD is now at c2a499e6c Gobbledygook

The more I look at this solution, the more I like it.  I'll try to
implement this to see if there's anything I'm not thinking of right
now, but I think I'll take the suggestion and send a re-roll with it
implemented. 

> > I als don't think it gives too much context compared to just "Checking
> > out files: ...%".  I think it gives a bit more context when that
> > message is not displayed at all, as it shows whether files are checked
> > out or not, but if we do that, when we create a new branch, the amount
> > of output we'd display is getting a bit long, to the point where I
> > suspect users would just not read it anymore.
> >
> > So I personally don't feel like this is worth it, even though it may
> > give some context in some cases.
> 
> Fair enough observation. The idea suggested in [1] may keep output to
> a reasonable amount.

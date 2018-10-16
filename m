Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDB321F453
	for <e@80x24.org>; Tue, 16 Oct 2018 02:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbeJPKlh (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 06:41:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40454 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbeJPKlh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 06:41:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id n31-v6so10093997pgm.7
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 19:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OlvJYbvItgdFx735NoMehAPQn9N9kzZSH4oaw+T/n/4=;
        b=d0voCSIpkblKpUqxdNGnjmTF6ueW8+Bf+0a03JzYyUfiNk3VxKaU9t6AwfywJFfwJS
         fMEvDHK/qOsUmqX1LvZ8WdG64WQT0TcnkILMYKu1yOZbavE8AqNUlEpv6SeiCngsK1DD
         j/EIwxvh0bj+r41oDomb8fqegKDESEJxIQ0xNaXy4NXm3SMAzUP6GKaGnT+0veDKecwT
         6u21RiqVfFIGTJSvYwN+Pgqe94vRHltZhaKAw7y2k5FeZnuRJbjMfAFZdBMgQZ0uL4gA
         Y+p3i6rE4XAlNOdgJwz/w34X/XLYnb8skmwuMV8OSazCYzOguuZORGwZkbZd4Kdlbun6
         Bowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OlvJYbvItgdFx735NoMehAPQn9N9kzZSH4oaw+T/n/4=;
        b=aO+ty4K+QiRhDUZK8EGTnTaXFwsbV7a30I935tDTDrTAVXT+dQyxInIwrOAYoQGPlY
         er8znjt2lxWmP0ppR3yTx4Kn37l0RFefiKn4F5t+kr43wMpMBZ1mH5AVdxqRBD907vwu
         d5VtnNpEVeFbnMx/jHBiyhk8s4786PB+p81FQlQPPFlS80F6t0vAbH2EvJACetSductR
         vD+J4ms7JjjwlEl6iLDosxf9oEdwZi4g+UNksYc8fvALISXHUq1A6y/iNSUJf7KOzFoa
         2XqIw4qmN6FLkWKQHhSq+SPtrRXHKW2ZjTCghy6zpaDRUXvwjwpfwCzf2WJWFeCnq8Pu
         3HvA==
X-Gm-Message-State: ABuFfogBbnbtyHMO0XU9E9ggCvYHxIMHSBZR7k1Go9r060vX+FNpLS0W
        WtFi0FAykZlgy73mNnyZfgZ7og==
X-Google-Smtp-Source: ACcGV63ndgxnVkQmHqFWx5dE8egY84UIUCHZqlB2q6bJkeOwOEffrV0JFxAtFN3KZpUwZMcEFsrwFA==
X-Received: by 2002:a63:6a42:: with SMTP id f63-v6mr18940612pgc.48.1539658410742;
        Mon, 15 Oct 2018 19:53:30 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:3001:6093:9be4:d17c])
        by smtp.gmail.com with ESMTPSA id h6-v6sm17470792pfc.6.2018.10.15.19.53.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 19:53:29 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Mon, 15 Oct 2018 19:53:28 -0700
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/13] Offer to run CI/PR builds in Azure Pipelines
Message-ID: <20181016025328.GC90754@syl>
References: <pull.31.git.gitgitgadget@gmail.com>
 <pull.31.v2.git.gitgitgadget@gmail.com>
 <20181015142215.GB1764@syl.hsd1.wa.comcast.net>
 <nycvar.QRO.7.76.6.1810151636510.4546@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1810151636510.4546@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 15, 2018 at 04:55:25PM +0200, Johannes Schindelin wrote:
> Hi Taylor,
>
> On Mon, 15 Oct 2018, Taylor Blau wrote:
>
> > Thanks for putting this together, and offering to build Git on Azure
> > Pipelines. I haven't followed v1 of this series very closely, so please
> > excuse me if my comments have already been addressed, and I missed them
> > in a skim of the last revision.
> >
> > On Mon, Oct 15, 2018 at 03:11:57AM -0700, Johannes Schindelin via GitGitGadget wrote:
> > > It is also an invaluable tool for contributors who can validate their code
> > > contributions via PRs on GitHub, e.g. to verify that their tests do actually
> > > run on macOS (i.e. with the BSD family of Unix tools instead of the GNU
> > > one).
> >
> > Agree.
> >
> > > The one sad part about this is the Windows support. Travis lacks it, and we
> > > work around that by using Azure Pipelines (the CI part of Azure DevOps,
> > > formerly known as Visual Studio Team Services) indirectly: one phase in
> > > Travis would trigger a build, wait for its log, and then paste that log.
> >
> > I wonder if Travis' recent announcement [1] affects this at all.
>
> :-)
>
> It did not escape my notice that after years and years of trying to get
> *anybody* at Travis to listen to my offers to help get this started, the
> announcement of Azure Pipelines for OSS seemed to finally do the trick
> (they still don't bother to talk to me, of course).
>
> And to answer your question without a question mark: I do not really think
> that the Travis announcement affects this here patch series: I have a ton
> of good experience with Azure Pipelines, use it in Git for Windows for
> ages, and I am finally able to have it in core Git, too. So I want it, and
> I spent a lot of time getting there, and I think it probably won't hurt
> core Git at all (besides, it seems that at least some of the phases are a
> bit faster on Azure Pipelines than Travis).

I think that there are fair reasons to prefer Azure Pipelines over
Travis. In particular, I am encouraged by the fact that we (1) know that
we won't timeout, and (2) can have a standardized CI interface on Git
and Git for Windows. Certainly, the Windows support on Azure Pipelines
is more developed than that of Travis', so that's another point for
Azure.

> Another really good reason for me to do this is that I can prod the Azure
> Pipelines team directly. And I even get an answer, usually within minutes.
> Which is a lot faster than the Travis team answers my questions, which
> is... not yet? (I tried to get in contact with them in late 2015 or early
> 2016, and I tried again a year later, and then a couple of months later,
> and I have yet to hear back.)

Certainly a good reason. To be clear/fair, I've sent in a number of
support tickets to Travis CI over the years, and have always been
responded to in a short amount of time with helpful answers. I think
that we would really be fine in either case, TBH.

> Also, I am not quite sure about the timeouts on Travis, but at least
> AppVeyor had rather short timeouts: the Windows build (due to our
> extensive use of Unix shell scripting in our test suite) takes 1h40m
> currently, and AppVeyor times out after 20 or 30 minutes. I could imagine
> that Travis times out after the same time, or maybe 60 minutes, which
> would still be too short. On Azure Pipelines, the maximum timeout (which
> can be configured via the azure-pipelines.yml file) is four hours IIRC.
> Plenty enough even for our test suite on Windows.
>
> > To summarize [1], Travis is offering an early version of adding Windows
> > to their list of supported builder operations systems. This brings the
> > list to macOS, Linux, and Windows, which I think satisfies what we would
> > like to regularly build git.git on.
>
> Honestly, I would love to have also FreeBSD and other platforms being
> tested. And with Azure Pipelines, I can make that happen (eventually), by
> adding another pool of VMs (given that I have a free $150/month Azure
> subscription, I'd use Azure VMs, of course). As long as a platform can run
> .NET Core software, it can run Azure Pipelines agents.
>
> With Travis, I don't think I can add private agent pools.

I think that's right.

> > Would we like to abandon Travis as our main CI service for upstream
> > git.git, and build on Azure Pipelines only? If so, I think that this is
> > an OK way to go, but I think that I would be opposed to having more than
> > one build system. (FWIW, we tend to _three_ for Git LFS, and it can be a
> > hassle at times).
>
> This question of abandoning Travis in favor of Azure Pipelines is a bit of
> a hornets' nest, as I really, really only want to bring the goodness of
> Azure Pipelines to git.git, and I am *clearly* biased, as I work at
> Microsoft.
>
> Which is the reason why I did not even hint at it in the cover letter, let
> alone included a patch to make it so.
>
> My patch series is purely about adding support for running CI/PR builds of
> https://github.com/git/git via Azure Pipelines.

I think that adding support for one CI system does carry the weight of
removing the other, for the sake of having few CI systems running at any
given time. In other words, even if you don't intend to start a
discussion about removing Travis, those that want run the smallest
number of services (including myself) will ask you about it ;-).

But I don't see a benefit to dragging this series through the mud by
spending too much time talking about Travis' future. I think that your
cover letter does a fine job to address the point, and we can revisit it
in the future if more people than just myself are opposed to running >1
CI service.

> > I see some benefit to sticking with Travis, since we already have a
> > build configuration that works there. But, you've done the work to
> > "port" that build configuration over to Azure, so perhaps the point is
> > moot.
>
> It is not so much a port, as an attempt to generalize our ci/* files.
>
> > > As Git's Windows builds (and tests!) take quite a bit of time, Travis often
> > > timed out, or somehow the trigger did not work, and for security reasons
> > > (the Windows builds are performed in a private pool of containers), the
> > > Windows builds are completely disabled for Pull Requests on GitHub.
> >
> > This would be a concession of [1], in my mind: is it possible to run the
> > tests on Windows in a time such that Travis will not time out?
>
> To be honest, I spent such a lot of time to get things to work on Azure
> Pipelines, *and* we get a nice view on the test failures there, too (which
> Travis will probably also offer soon, in response to what Azure Pipelines
> offer ;-)), I cannot really justify spending time on trying to make things
> work on Travis' Windows VMs, too. Especially when I have to expect to run
> into timeout issues anyway.

Agreed.

> > > As a special treat, this patch series adds the ability to present the
> > > outcome of Git's test suite as JUnit-style .xml files. This allows the Azure
> > > Pipelines build to present fun diagrams, trends, and makes it a lot easier
> > > to drill down to test failures than before. See for example
> > > https://dev.azure.com/git/git/_build/results?buildId=113&view=ms.vss-test-web.test-result-details
> > > [https://dev.azure.com/git/git/_build/results?buildId=113&view=ms.vss-test-web.test-result-details]
> > > (you can click on the label of the failed test, and then see the detailed
> > > output in the right pane).
> >
> > That's pretty cool. Travis doesn't support this (to the best of my
> > knowledge).
>
> Exactly.
>
> Plus, if things don't work in Azure Pipelines, I (or one of the other
> Microsoft employees among the core Git developers) can easily take a
> shortcut to the team and get things fixed. In my mind, that counts for a
> lot, too, especially given my own, frustrating personal experience with
> Travis.

Agreed, and thanks for your response.

> Ciao,
> Dscho
>
> > [1]: https://blog.travis-ci.com/2018-10-11-windows-early-release

Thanks,
Taylor

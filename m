Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D350C2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 22:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B32F6100B
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 22:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhFVWe6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 18:34:58 -0400
Received: from mout.gmx.net ([212.227.15.18]:34821 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229675AbhFVWe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 18:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624401160;
        bh=IiPth6AKnE1PWvnqEBO1Mg1H3jlHhxL7QKarbcYs26s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QdVXIfgNdva9S1nCClAVOG4DYzNGCwbaO3vPb9AANCBYWQ2eegnbhnV3HKVOXAMLO
         ayTLZfK50Oken9ydkAPcGweVsBMqavV9zR3A1E2ZoK/AiAJ7M1WZ7r68bJvGskIGwo
         T3PPtbrqLPLy/MdHTLO0O2GL3xL0DM4BYxmP/Xac=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.14.142] ([213.196.212.83]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgeoI-1lLgNo0Wfk-00h7Yt; Wed, 23
 Jun 2021 00:32:40 +0200
Date:   Wed, 23 Jun 2021 00:32:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philip Oakley <philipoakley@iee.email>
cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Danh Doan <congdanhqx@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH 0/3] Make CMake work out of the box
In-Reply-To: <bdb8bd83-c3d9-b8bd-2bd5-8b7ee0cd346a@iee.email>
Message-ID: <nycvar.QRO.7.76.6.2106221636040.57@tvgsbejvaqbjf.bet>
References: <pull.970.git.1622828605.gitgitgadget@gmail.com> <6a9150ca-5c1a-1874-5f8b-35187f197d47@gmail.com> <nycvar.QRO.7.76.6.2106101140590.57@tvgsbejvaqbjf.bet> <b52d7c45-06dd-a9eb-bc86-e04d2ee16c5e@iee.email> <nycvar.QRO.7.76.6.2106181540340.57@tvgsbejvaqbjf.bet>
 <bdb8bd83-c3d9-b8bd-2bd5-8b7ee0cd346a@iee.email>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ED3w5aOeZmWxhSb0M5PDHbJOYDwq6gFUnUcZD9bSJSL5EU31MTt
 +mA8Es4Tjw6omooyAX8kAfnZaZoo255OpEpwuaW4WSjQv9zHITMyTXcZGEJxQi/anCuS3Q4
 p6BrK3jRtzBYPvELHM0hbyhi2kyf7VjhjGVcvYBNlA35R7NBlqk1dOVBfPe6khdbiQT0/GT
 hzC1pmGK9WeUxr1edHiTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xqBsqG1bMXo=:Akc/qT/u4+uTAWq0fngZSV
 6owPC4T7t16F17vxHytYr2iG56gz1la30iW9aQ1MuUkoFe0+JjdtkMD4kh/tlMqpNWfuxZCly
 2eVE6lmCkcIbzfw/ASqOQo7ce+ExCGO7sfF4CZSnzz6GJMNnYhCJcp1V0LmI8D5RQgaQyTN9j
 sR3KfTQ0j0OWibwStRswa63ejZagxTfKygW4CacmW+31YT54ppzWrWjr7/IinqmfJ/HX9GuvU
 E0jcTMMO1caHYNX3HmdH5b7Pvh/Z1rC3nZJUB0k29gmH4jn10YIvBZGVSVXWNUAE9DdmFj+uN
 6omwrqP4ILa6KFEmeBCt18WVpbGTfHTwc6MEmg3usZCU+AwVFiGp2Uk4/fYj64kzCDzmjvbAh
 pTVGDBMWAohHmYaR7TFQ6N44x7QGHDHd3sDcG9UY/cs7vnnXy/x48lxxB1tXIGUXvOEnzdSGC
 IvnPo4wMe6f1iamkhjK+FGHezfBncLYWextozZd3RkFZPXF/eoy1oJ8QqDGFR/rDsG+Cy35qW
 TBi9VWOyZGKSC4mobyXwdHWP/MVh5yvt4lKBPkAV5+5d1ZHlb63yljY0lzzdzgpwFNshdDwX7
 XbSQDLKtvuK7Syja9Z3cUawxVMu/OJbJQ9qaoeg/C8MLFNV43ujkkL9pLMCzCqk67aRq37HRO
 VrVi7BXs6Nr4yyOU/1pkNmx42Cquq2mcjDX1w+ISzLMKobCcbF/0XSEongyrEAsuPThKhmWB0
 kK2urfht+ErWSK8YH8Rmwlv8kRYimgiclKZ7k3LFwlTP8AYIUE8TO5RC9Hok4JBlGJKAlSZKV
 BF0YFpS9OEAqjJeRy/+FvAc80s7mImSGlNWq9WapGwqmd3REQHO5GQag/JxjMQt3fjs4Z2Irq
 2lObkyNRbwxW9laoCeWFQzJ9s9x9EW0ZB4hrYrfpDpUbWVpOFBTtSv+ziDNexcigNcAy7yesK
 wobAAenJ95XNI5LRLT6t7iAmWNd3Dw/+dRTkjIBh+DjG4cxsz5QpYfFQgEN3Laglpg3Esk/1A
 8tLtawhjC7NmGWtCEkZeT0RBfoJZmSfIBdK+4WOHa0gfWl2fu0361Jm2nRbRuAWNSL5Ivxb3k
 IpOTX2L0GKsaw1FswF6U1M7WhcFYNx7+7l1swjww/3SAQ8SyV1W1jYKJA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Fri, 18 Jun 2021, Philip Oakley wrote:

> On 18/06/2021 14:42, Johannes Schindelin wrote:
> >>> We already exercise the plain Makefile plenty, and the CMake-based b=
uild
> >>> using Windows (in the `vs-build` job in `.github/workflows/main.yml`=
).
> >> There is one 'gotcha' in the yml (probably historical) in that it
> >> doesn't actually test the approach/changes that Matt addresses regard=
ing
> >> my [1].
> >>
> >> That is, I'm looking at the 'out of the box' view, while the yml test
> >> _preloads_ the vcpkg artefacts.
> > We need to "pre-load" them because building them would add another
> > whopping 20 minutes to each CI run. And I am not talking total time, b=
ut
> > wall-clock time.
> >
> > And we're not in the business of testing vcpkg's build.
> >
> > So I am really not in favor of even thinking about changing this
> > "pre-loading" strategy.
> >
> >
> I can see the common sense in that, however I was trying to highlight
> that the approach in patch series could go stale, as did the previous
> method. Making the entry ramp to investigating the code for the wide
> variety windows users should have _some_ testing..
>
> I don't have any good ideas about how to get out of that 20 minute
> Catch-22 issue at the moment. Maybe it needs an independent, on-demand
> (i.e. infrequent;-) test.
>
> Maybe there is a way of adding a `--CI-test` option that at least
> exercises the logic without needing the vcpkg to be built again (IIRC,
> and I may well be wrong, we build once, remember the artefacts, and then
> re-used them, but .. dunno).

I would strongly discourage tacking this onto the current CI. It is way
too rare a use case to merit adding the cost for all developers using the
CI runs to verify their work.

All is not lost, though: interested parties (such as yourself!) can easily
add their own GitHub workflows in their own repositories and verify that
things work.

You could even put the workflow on a timer, and add a matrix job that
builds `maint`, `master`, `next` and `seen`, to verify that things work.

And for extra brownie points, you can monitor the runs and work on fixes
whenever you see breakages. That would definitely take a good chunk of the
maintenance burden off of the Git maintainers.

Ciao,
Dscho

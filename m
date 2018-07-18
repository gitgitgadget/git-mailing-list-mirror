Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8B941F597
	for <e@80x24.org>; Wed, 18 Jul 2018 12:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbeGRNKW (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 09:10:22 -0400
Received: from mout.gmx.net ([212.227.15.18]:56167 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729281AbeGRNKW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 09:10:22 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M9ra4-1fmLDC0DnM-00B390; Wed, 18
 Jul 2018 14:32:30 +0200
Date:   Wed, 18 Jul 2018 14:32:12 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/16] Consolidate reachability logic
In-Reply-To: <CAPig+cQ0t8nDnE9fVbo_wgth_Y2yuYM1O9AD1y6kvyHTqD57Yg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807181429580.71@tvgsbejvaqbjf.bet>
References: <pull.10.git.gitgitgadget@gmail.com> <6b7a50dc-6b71-0e31-030a-42dd1b26bde4@ramsayjones.plus.com> <20180716161821.GB18150@sigill.intra.peff.net> <CAPig+cTVP2kubTEZBms_x1FvnqjGcX3pjTRXfjBMfMtdpbJt=Q@mail.gmail.com> <20180716185618.GD22298@sigill.intra.peff.net>
 <CAPig+cQ0t8nDnE9fVbo_wgth_Y2yuYM1O9AD1y6kvyHTqD57Yg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:uwAoT3wFNF5iMeESZmzZqitd50cm2w5KGoONfF6bi4gNhXy3TSC
 TQ0ngFfEoTxDfp7k+Dqn6SfhAIFhus2AaLwiulQ7vbl0qSEJo2TpIVD80ykNCQDD9SLeSSe
 o5gXrsMM8FG4sS6YBdrZRq4eHtqNE8TGIRaNwz0r0gWvxBMWCSp75858d276RDY9HmUw/8p
 xv/67wcxotI2S28AJ2lXA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vlpUBI5FrR8=:Did4pAXYxHE8fbFAUftg1A
 JA6nUEaMkWxR6wN5ouEIISpJJM5gENdmT+kIuBY4ztRdOFqOnCeY02Qth+rqp9V+VhkRAWRrl
 KLn8Po61haTMm0XaUZFlRKzDl91Msd2CEfv1FVPkgVFGT6IB8ZJLUqlwA/RRFlOxgS2GdIV/X
 +8xlYqpXxW9x4AbFROxpXXLoP3Yg6mMO5i1gYPckw0VvGcr7bGNOhWjprHt2FokKjXVmE1Dc0
 hTXum5eOqNHnKjK0ZbSbbuaGGVsBqDrAJRjKHQxI2ZGcHE94nSJA6kZLLoaAbLpm3e5zRcznL
 w24vT6r26OwA7NLoLhrhWIutEy6POC04TvVqmbB/ejTe7eik/FnALVRTOi9oDjlKODNf9VjR3
 ZVDHls1n8bPbiCkNxYDqQaH3v5YSIOFwl46GgunJihsHmaRxjyJmgPc+tU0BMCEwbqqXG5pBX
 zH0DtucsFNWRz+7vAKn6RV3OJuxeKgO3Rp9KxXidePeYr1cAMtNubklmyFQSTHcIzX6yMmdN6
 xL1ZfqX63FU0fqyqQMnhZ+6YA9Evvi1ZviHlxYgWqzNqwHNHNVWiehVT5trtiOlFhdFXPNudW
 janhlvKqSHHKJQr1G25s/Xd2xGO+FMwyj6HbBj0UeMWPHT0R21joppwiVXrElOgxAAgNJPq1V
 jr8ADtAqdIqlCERDQHzizNQzpl2ewWh8ILZWd3Luu+FpuJVeHgG2urwNyx6POlejqFFfO4oRO
 s6sdwJwTXmWga2V/Z+r+xM9w3jtmWMNKoyUcHYRp08HObplwnx1C4EZdv/oE3YQK+4Kx8p/G2
 VOG/SwB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric & Peff,

On Mon, 16 Jul 2018, Eric Sunshine wrote:

> On Mon, Jul 16, 2018 at 2:56 PM Jeff King <peff@peff.net> wrote:
> > On Mon, Jul 16, 2018 at 02:40:21PM -0400, Eric Sunshine wrote:
> > > On Mon, Jul 16, 2018 at 12:18 PM Jeff King <peff@peff.net> wrote:
> > > > git-send-email uses the current time minus an offset, and then
> > > > monotonically increases for each patch:
> > >
> > > Junio pointed this out to gitgitgadget developers in [1], which led to
> > > an issue being opened[2]. That issue was merged today.
> > >
> > > [1]: https://public-inbox.org/git/xmqq7em7gg3j.fsf@gitster-ct.c.googlers.com/
> > > [2]: https://github.com/gitgitgadget/gitgitgadget/pull/15
> >
> > I was going to say "oh good, fixed", but it looks like it just merged
> > adding that line to the TODO list. :)
> 
> Erm, right. I actually knew a couple days ago that that issue was just
> a change to the TODO list but forgot that important tidbit when I
> wrote the above "was merged today". Anyhow, at least it's on the
> radar.

It is always nice to get such active contributions.

Seriously again, do feel free to jump in and contribute improvements to
GitGitGadget.

We have a very time-consuming (read: time wasting) code contribution
process, and it is an untenable situation, and GitGitGadget was designed
to be able to address this huge problem.

But I can't do it alone. And neither should you pretend that this is my
problem alone. This problem is as much your problem as it is mine.
(Whether you realize it or not.)

Ciao,
Dscho

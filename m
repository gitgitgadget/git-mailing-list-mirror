Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A14C433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 21:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 987DE206C3
	for <git@archiver.kernel.org>; Thu, 28 May 2020 21:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ghFvDFX9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436502AbgE1VNr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 17:13:47 -0400
Received: from mout.gmx.net ([212.227.15.18]:36967 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407477AbgE1VNq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 17:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590700400;
        bh=wJJEb51EUkCTSycbKfDIwxVq06CouOa7C+tupG8yNOs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ghFvDFX9TZUpsdOh2tPc0oh1sQJClt+liTgC37Jsef7bknfjnB9xtV2rqOyIpKFio
         EHsUl1zvKdT2hIBg7JWhwnPV0U7vIDBVSX/huvxldCBsN310JEgyAOYDhCwNr1sJi7
         AE/AWomI19xwArBd7nRuKXurjp2j10Wtjd0wyW/c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.211.123] ([89.1.215.188]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgvrL-1j4Xin0dnZ-00hQ3X; Thu, 28
 May 2020 23:13:20 +0200
Date:   Thu, 28 May 2020 06:39:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <stolee@gmail.com>
cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Josh Steadmon <steadmon@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jrnieder@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 00/15] [RFC] Maintenance jobs and job runner
In-Reply-To: <980f76bc-c28e-42cd-a85e-acb70861c9a7@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2005280638570.56@tvgsbejvaqbjf.bet>
References: <xmqqv9mgxn7u.fsf@gitster.c.googlers.com> <cc9df614-2736-7cdd-006f-59878ee551c8@gmail.com> <20200407014829.GL6369@camp.crustytoothpaste.net> <nycvar.QRO.7.76.6.2004072355100.46@tvgsbejvaqbjf.bet> <20200408000149.GN6369@camp.crustytoothpaste.net>
 <20200527223907.GB65111@google.com> <xmqqa71s6g1w.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2005272334560.56@tvgsbejvaqbjf.bet> <20200528145018.GA58643@google.com> <xmqqwo4w3y4s.fsf@gitster.c.googlers.com> <20200528150340.GB58643@google.com>
 <980f76bc-c28e-42cd-a85e-acb70861c9a7@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WcBKKWl3pr4hfRuWuFQUk3oL2yVtYSGd/Ljv6lUYH46GiJMbW8B
 rV/2DqDfwesu4iwWY7Qr2P/HzU/UUB8cmRUn+I3keZRSe3O5Dt/AFOoLEO/fMPxSXn2Ha3I
 tocacJoOQvH/cVMQJx6exiWlkgJC1tOTIMbl7J6DhQd3wYNxO2bgF3hTUGLZxPwPhIfEjf6
 upKZ2LzfiMDzU0LZqWcwA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:m2JyszjrFRA=:Rr21tK0qeOD41V4xfWNiJo
 DuyL2b6unh0p5wRdozUlYcVFoM7JqMgWfrvi4sICqHWa/0eeD7PB9/VrI5nHhFK/nu+MBu1pM
 fSqK2xbE9KwTuKOoYP741kUikbsvlzQgFIrC+HcMl6pYYDlSxotYqKntdYFNih2jgaTn06GzG
 s56M8xuv4WsXalzOXX1ORk52dfgLUed+jMgR8Bz0H5kN3GRISrR+17sZuQcjSr3uv56kuBrkV
 mkX1CeB5jlzfle2WeaXgM/VWaNlo2fp3GDfluzaH6ojUdDEgvZdJo3OXxdO1it3JkXIMZaFf3
 9Nzzz/JmlTL9MTAECH/o6FCMkL0jCF0/uHud0c/Jj9AYjq6cA2sP/uOPV7+0OvebirZYyEcI6
 y5jNA4rNOL8Se7OAlimkArUc8kgJ4TWUeeXGt1NYznJlMXyDMZgV8Oyt0xrOik5Xq52do0uhT
 2+8MlkskDOApFOAQ6CElahlwmobT8K3i59L2PkpSDCvPNfRu86fNh2zuGXzpsMPwRWBjjM0lL
 EZXsuUrRUJHNaORk1jlClRk17Zt5bn/UlGTxz/11BflSy/hlLwvH+OFK7V88r7G+rYcNOPqJW
 9yIYfwIbT/CYWCiSVFC1b9Nq/+/AxzeZ5yt5WBI6P2tWM5dsamA8b2+bUWPN29UlMOruaK5rB
 0tfonRdJJ2tFRjonY2NBhuHI03On2aqNjNFII0IYm7i6nLLI1Qjab2AXKaFkeEV3fLT749nSF
 uy7IcbnhLTVzAV6Gny86KAiaDW2GSasuc0u1EjTf2RWNLOiXhjTbkQF0qxeLlTng/oSust8LZ
 7BhtKL8NmpOkNHAXVWJgHxsyj1wIiqegw+o0sg6+nZQdCmowLiuQ5z0E1wzMBDIFOqmdX450Z
 DIXIz2eu2ZnCiAm8jukc99WYu0B+uU6ph3Fo0sZaWkNKiu4WjG051Nprm2DY5QM8ckV1rBPHw
 r6JPvP+ZNpCd8YOazrF4fwKtUNBmP1nbZeyo/SzvwVFWOUEbsXyE/KvZNXEPOf+e/MbjKKZ1v
 ECdUkyBU8CGOMOiPE1YT7BaUJhlExYCWZOOyQNMCA6v8xSHAz+QL4qoa8Gfb5m6TAsSmz/P/9
 ygjeqhgIvBsb1sMApdfjdVZS5/G/g9ZIrbMLunkP8ZKn/wxFpZZYjo7KGZmT2C8eljE7rm/j3
 ls+Bh6rUCOywFkhUm1ASqywF+ozYghA/AzSSFJyfx9HJ3modQ7mK98bQ5T84npzX5c1D17fjX
 I4zjljBnsTncJGkP7
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Thu, 28 May 2020, Derrick Stolee wrote:

> On 5/28/2020 11:03 AM, Jonathan Nieder wrote:
> > Junio C Hamano wrote:
> >> Jonathan Nieder <jrnieder@gmail.com> writes:
> >
> >>>                              The real question is, do we consider th=
e
> >>> existing "git gc" infrastructure such a lost cause that we should
> >>> touch it as little as possible?
> >>
> >> I am fine with that, as long as the "new" thing will take over what
> >> "git gc" currently does.
> >
> > Good reminder, thank you.
> >
> > Yes, as long as we end up replacing the old thing, making a parallel
> > new thing (e.g. with a config option for switching between during a
> > transition period) can be a fine approach.
>
> Thanks for the discussion, everyone. I'm sorry that I'm very late in
> providing a new RFC that takes this approach, but yes I intend to create
> the "single entry point" for maintenance activities, and incorporate
> auto-GC as a default option there.

Great! I look forward to reviewing your next patch series iteration,
whenever you're ready.

Ciao,
Dscho

>
> Something that is a good long-term goal is to have the new maintenance
> entry point replace the "git gc --auto" calls, so we have better
> customization of post-command "automatic" maintenance. This can be done
> without any of the "background" part of my original RFC.
>
> I've just been to busy with other tasks to devote the deep focus that
> this feature deserves. Thanks for your patience.
>
> -Stolee
>

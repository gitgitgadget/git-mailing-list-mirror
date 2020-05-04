Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2960CC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0969A20752
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="a4wQw7wZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgEDTIe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 15:08:34 -0400
Received: from mout.web.de ([212.227.15.3]:36289 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbgEDTId (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 15:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588619311;
        bh=PumEqW3gMKnUIPZZwNA8D+cAQSrGg2dtw/tbizkeB3Y=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=a4wQw7wZsxcyk4B/1/XuuohmGe0fmoMIWEdKM2L58B8we3vF78ByUOuaRrLDYe9Ng
         7sutTO1mDrv8jVwJXGTzCzykDCm0qptvFoxz+k6/KVH2aLPEbEysGhUElTfUfXAmNE
         Oh1/eKqJfnD00TbiS3z31Dc+KzzPoZBCkXmtQjHw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LopIp-1ivGEu0SXj-00grFb; Mon, 04
 May 2020 21:08:31 +0200
Date:   Mon, 4 May 2020 21:08:30 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Carlo Marcelo Arenas =?iso-8859-1?Q?Bel=F3n?= <carenas@gmail.com>,
        Jeffrey Walton <noloader@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Git 2.26.2 and failed self tests on OS X
Message-ID: <20200504190830.g2tlrognjw6ddipo@tb-raspi4>
References: <CAH8yC8myTMOetxgaj1wt0MbvSQ0LSRV0FHz4ywsBM1zzhUQG=w@mail.gmail.com>
 <20200504165214.GF86805@Carlos-MBP>
 <CAPig+cSPXqvFg3-25aDzptuVOHmqOcnmsCKHgjMB9poPyJR2gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAPig+cSPXqvFg3-25aDzptuVOHmqOcnmsCKHgjMB9poPyJR2gw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:PRdXOpZ7CaI0sHCKFI8waCXn0XFpRieUwwblbmx0g/7kmINJS77
 LdKOt6hbxBssyUPScpbPo62Kgyn7RJmrYI0DuzAHGChlcqmEUAl0NoytbDK2xWe7bv/xhOA
 QbfTlJNHINy4YpjHOF5g0/v31Ok3ezuH4MXe9UsXxzpYwlN4k0RfWzM8CFnKM1sGN/WytVE
 IoUktSClCwb/cmNp0fPyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8mZtKj9oOmo=:Qh1rTNzOH0XNKUMNmkdTHY
 s1QzO6y0oS10FMThqIhHuWQCzeUX1cxyB66JuDZar5EwmeiWarrKwqcsry/W2H1ll3pbnbde7
 gAcKhNI7j2k7A9DzO742bUHEru4ZfUPZO6Eb+M/KpaS2U6oQPkPwkomNEEU41So5cH69K4SgZ
 09mlkQ84u0oaS2UBOLjYLac7430rinV6m7XWucsPWGKWZt/P33WoLKqYNWWwoct+HhpV8VF2z
 cVkt37HPhjJ141dVLQ3hzZ7b+mxEnygcJlwbJrO3QtlPF8XRSi3rmrottCZwLiHt4rID+r5gL
 PiRG10JiYinOlbAQMyC8N+riBv3iiFi1pyOVj5cFVTRzju/BcEEov3kGJdQj/CPudNxfy4NYk
 JhosGNEFt9v1E6Y8MB0ECnYfUTojuGrWS/UzsDuGnvWmS90XRuDHYOsbVdFoYgVn3ZM5UtzAg
 S1Cp1wtmOpoxqoHSCNJMp2cGThLLPplYjgcslyoYnuEn0PrN/YN2UBhW5MR96/YeqOiLbwgCW
 taATwygMux129nV9wIiScvNAlCleGf8isoTeTCQ6irZ/DloKVCEoReDZf8+aJWDHC9ktNr/I1
 DIQmPxTYegMOrq7JptZ4KJnehxW5SqM2d0AKCp2IFqYVFYXSM0p6p0OON3Cyk62HKKdoOcjz9
 7/MfVbBR/Q5JwRC2nXDPrIJoYb2YWXXgt3nC65CgEbzlgMeMm+bY3xy60YADIgzwtRigiNHg7
 sjqxU9QLMMaZs22FQ4uY8BqgNKnjK9h1dg50CSNc+RoFIpini5CB6mENc4THq0zfBdIcCG49Y
 f7Y9Zz0+164u9q6lJUPj8LKzuCiKT+UiLOClZAopcnbAO5H9zroP8GVhkY4C3V/MgB6uZSgLp
 gYHy7hAu8hXfXT+tfFTTvNYwmgNmiYzSFUaX1NX74pNGdFf8Dl+BMGd4vBWNw1UHwKqu+otc/
 KM+ZKs4ss2+JeGyi0xKXxR7gk1nf8e6WDwwqKnrYNg1P4UdXrvXZsM8G2XzQw7Fu1nbQEikkK
 bDdlD9tiN7uEUbxtsyPwm6c8W2g8/wFyfimBZeN0d2q0UZfxsASF9ujkFEFWkF1xxufWdNbVb
 Z8RVbNazRLt2vyeKF9+VOYRGgYYsTlisVpIByLD8Swsnz8O6AjBlfvA+4pnqTEAu1k+HDivhk
 jrNotTabqCHRfk2Ykbylf+84P6i37xuYAQiyCMYLwSB11/08BwAfbeGwRzOO0QOrPfU413h0A
 HYVgU098p8tRXcUEm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 01:18:06PM -0400, Eric Sunshine wrote:
> On Mon, May 4, 2020 at 12:52 PM Carlo Marcelo Arenas Bel=F3n
> <carenas@gmail.com> wrote:
> > On Mon, May 04, 2020 at 03:03:01AM -0400, Jeffrey Walton wrote:
> > > I'm building Git 2.26.2 from sources on a Mac-mini with OS X 10.12.6
> > > and a PowerMac with OS X 10.5. Some of the t3902-quoted.sh tests are
> > > failing.
> > >
> > > The Mac-Mini uses Bash 3.2.57(1)-release. The PowerMac uses 3.2.17(1=
)-release.
> >
> > if the problem is the bash version but you can build/install a newer o=
ne that
> > doesn't have this problem [...]
>
> My OS X 10.13.6 has Bash 3.2.57, as well, and I'm unable to reproduce
> these failures, so it seems fairly unlikely that the problem Jeffrey
> is seeing isn't tied to Bash.

Should I read this as
".. seems fairly likely that the problem Jeffrey is seeing is tied to bash=
" ?

I can't reproduce it either, so my reasoning would rather be
"The problem is probably not caused by the shipped bash version"

It could be something in the environemt, that confuses our tests here.

Does
./t3902-quoted.sh   -v -d
give anything useful ?

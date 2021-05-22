Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=BAYES_00,DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363C2C47080
	for <git@archiver.kernel.org>; Sun, 23 May 2021 16:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0712D6117A
	for <git@archiver.kernel.org>; Sun, 23 May 2021 16:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhEWQlI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 May 2021 12:41:08 -0400
Received: from mout.gmx.net ([212.227.17.20]:45235 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231815AbhEWQlH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 May 2021 12:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621787964;
        bh=O2lO+8rEXXGGM7N/II9cujvjJo5L5GNV69H6aDsCmPQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BIv4pmYIRRO38Ph/CwmnjIslmSDvz2r5P7YIB5CHVIKn9CCO7uA8Q1XyoHPe2/5HK
         uY5yztKHRH8uTqraW2KPRp6lE7ui+FZdLtk+JR1+GXjzfdRPqj79u/GZbQIKzFZfLX
         AUBoNjd9EZ9KAKz/mOa5AFyqlDkj/Vi13kuha7Qs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.198.229] ([89.1.215.198]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4Qwg-1lKyJZ3eYY-011Utt; Sun, 23
 May 2021 18:39:23 +0200
Date:   Sat, 22 May 2021 08:57:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <stolee@gmail.com>
cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?L=C3=A9na=C3=AFc_Huard?= <lenaic@lhuard.fr>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 4/4] maintenance: optionally use systemd timers on
 Linux
In-Reply-To: <44d937a0-e876-e185-f409-a4fd61eae580@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2105220856320.57@tvgsbejvaqbjf.bet>
References: <20210509213217.449489-1-lenaic@lhuard.fr> <20210520221359.75615-1-lenaic@lhuard.fr> <20210520221359.75615-5-lenaic@lhuard.fr> <715d8115-641b-5c06-d514-36911eb169ef@gmail.com> <44d937a0-e876-e185-f409-a4fd61eae580@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2138201059-1621666676=:57"
X-Provags-ID: V03:K1:B7MSVBvkEWK5l4b7wy/SLsZ/fpDlXNBqq386X6l3NoYGlBUOIUP
 XzjoZN1Uf0pyFS8PXnOYHhjjFE4p8mbyKhtsTu9Oy8jUXMyLlBXw7vDCUJK7RG0s/CiQ+Jj
 zGjs8a4G1rvoWYJCI0wH5Pd4aBLSEHxamXgPLjDf1whwaCql9E5KBqp35wbnljW82rLzU1T
 kS6HPmQmdyfdHbSfOHqfw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kL+UlE+rP7U=:KzNGm0rJxlpkk8fU7bZjrr
 tkfRHdEqxRpzX8uN+WMW4bTiMqFIu5SAptQv02tui6GToGgMWWAnaMpxaNSrqP0c3jW0HdeXQ
 bJ1PLGYLIqERO5yf3AaYpVbmyxjzCJIosg/EViQkasfmZx8FjMdfNrx8VOzU2//JVEJo15XCR
 0RDkuOpmFLihlZp3NJPnhn0ReJdTdHx5jYcTCl8OtjLGZexSCGI9DkuA7IHWlW1TgGrfgPTtb
 sZnDOV86mL4LTAB5cNjwcpUbeyuebbgjpgVpxR3Q5DQURv2YnXrBYuEpPh0r3vI8SFka47eOW
 J15fN0u9oBJM6IfST7TXRYQ2O5Vm9wsTArqmCjqEMZBSVU1fudeBi3gxU8WyZ5FADJfTGkWQB
 n0xgVtryh+M05NQT9s2EoCWeEaYV7IW2ATRx3iGVtLf68r2RZmCafZBaV9x5BNdE7Rf1a0sIG
 lMjy0j/bcs2dT6G4bW65yOQR/fkJ535a3+F7oeTSqcgdhaHIYbI0M02F1kYgDkJdkp3U2P9oT
 hyZNkIxTZDIgJDD8jvH07P3tyON0xjjZdfc6e9hqYkeYQ3hu5K+XMbpCbtnbJRGVeUTnkchyQ
 j2ta86az2k7h1KFjA5F8HcQ8ZZztIZA2mKHgfw94QXB/mT9CNWi5FG+f1nuO2VGLbQXXJ0PrH
 kO8azCLGSs+oegyPk+xyxABOx6bvrgnu1FGvkxrmtAqnbbDsTm1JsElK6vCaxoqN5WgM1Q0gk
 kljRclc1b5j0GF/FvhrDqtdOfoqxbjz6z1vivyvuD043SNgsR5G3GszSB3R1zBgU5u65K/8th
 +8pgdkXDnnYAjnr3OZCgip+RKFYlwoUX8uVk/HLwaOHro0etvdsCAnxFJ0JSf51bkb2jCj0Gc
 pg2oOeMIl6IKiYA3WUtMg+x3P4+BaTSZnYUuEcMkeuOFhrpZ7lUstCVHkqKANZ4t7cRVMWDoc
 c+ZREWzO9P/MRyUAPIUYAOaA1XEMpTQsrO/4b8cDkb5O7PZKeB6J/KnZZbb08GHxvfrAsqZxO
 yeb/9PILWdbv54tsf2knd66P8xBCCrZ/AeP7v1cJBaeZr0vV26J+qvD7y3W+hIIjdwWsrbBmr
 eFo/IiNbomwXiAVkHFX68E2QxyaPfek+bcTZO1SYnoa0MwcMeEBjsIrbA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2138201059-1621666676=:57
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 21 May 2021, Derrick Stolee wrote:

> On 5/21/2021 5:59 AM, Bagas Sanjaya wrote:
> > On 21/05/21 05.13, L=C3=A9na=C3=AFc Huard wrote:
> >> The existing mechanism for scheduling background maintenance is done
> >> through cron. On Linux systems managed by systemd, systemd provides a=
n
> >> alternative to schedule recurring tasks: systemd timers.
> >>
> >> The main motivations to implement systemd timers in addition to cron
> >> are:
> >> * cron is optional and Linux systems running systemd might not have i=
t
> >> =C2=A0=C2=A0 installed.
> >> * The execution of `crontab -l` can tell us if cron is installed but =
not
> >> =C2=A0=C2=A0 if the daemon is actually running.
> >> * With systemd, each service is run in its own cgroup and its logs ar=
e
> >> =C2=A0=C2=A0 tagged by the service inside journald. With cron, all sc=
heduled tasks
> >> =C2=A0=C2=A0 are running in the cron daemon cgroup and all the logs o=
f the
> >> =C2=A0=C2=A0 user-scheduled tasks are pretended to belong to the syst=
em cron
> >> =C2=A0=C2=A0 service.
> >> =C2=A0=C2=A0 Concretely, a user that doesn=E2=80=99t have access to t=
he system logs won=E2=80=99t
> >> =C2=A0=C2=A0 have access to the log of its own tasks scheduled by cro=
n whereas he
> >> =C2=A0=C2=A0 will have access to the log of its own tasks scheduled b=
y systemd
> >> =C2=A0=C2=A0 timer.
> >
> > For gender neutrality, we can use he/she instead.
>
> Singular "they" is better. Fully accurate and less awkward.

I agree. If the singular they was good enough for Shakespeare, it is good
enough for anyone. See for yourself:
http://itre.cis.upenn.edu/~myl/languagelog/archives/002748.html

Ciao,
Dscho

--8323328-2138201059-1621666676=:57--

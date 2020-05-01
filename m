Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D2DC35280
	for <git@archiver.kernel.org>; Fri,  1 May 2020 19:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D6172166E
	for <git@archiver.kernel.org>; Fri,  1 May 2020 19:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="XtRwtcCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgEAT7M (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 15:59:12 -0400
Received: from mout.gmx.net ([212.227.17.21]:57417 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbgEAT7L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 15:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588363131;
        bh=cff0l9+T4CbM/DM1k4qO+CH1G4ZFAa77/HVKyJz8nis=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XtRwtcCOfq1CLXG4zX4VO0RJ0xq7YhjQS5d3UhYRG0BM2wJlXz43vH5txw4tz/nU6
         U/dpSCoxRnrWUrWkhUW4AyHD3Mfx6uliYthjeT2VO9Tfwsqhi44TIq21UbGnl4j5+9
         +Jzv0SJ9N+Mi7xtiqtaK3W9AUoHkOJgKlWiLKVNU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.213.255]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M1Hdq-1jSwqX1Fr0-002qaU; Fri, 01 May 2020 21:58:51 +0200
Date:   Fri, 1 May 2020 21:58:49 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ilya Tretyakov <it@it3xl.ru>
Subject: Re: [PATCH v3 3/3] credential: handle `credential.<partial-URL>.<key>`
 again
In-Reply-To: <xmqq8siez4m2.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2005012156220.18039@tvgsbejvaqbjf.bet>
References: <pull.615.v2.git.1587685397.gitgitgadget@gmail.com> <pull.615.v3.git.1587728992.gitgitgadget@gmail.com> <0535908dd7ea4487b342c0f86182579279c57b34.1587728992.git.gitgitgadget@gmail.com> <xmqq4kt8bk5r.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2004250027550.18039@tvgsbejvaqbjf.bet> <xmqqr1w7yzjc.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2004291657220.18039@tvgsbejvaqbjf.bet> <xmqq8siez4m2.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9b8CNk+xBbyebOPT0HNbEciCS7xtCjIfqnmQqssF93j/q03Y9SD
 1Qb/JvpKYBXNpgxUlIuH6eztAgYz29W16gIUiQesWQEHVkV5YbIenarVZGDQ9vw2dyaWo/6
 qknYpD/2SY5VfTpDA5ycPi4tXGOOUjQIVgIpK6A5+u63asoG1gM7/jSxNvfNK71jUwQwoR6
 jIVdeEuIUIOofnyIxs9aA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xe//HF9G510=:V7jAS8D98cT978c+UrcKSt
 wuWMKVKRlu5k3f7B0p2rtGVXnMv7QtMtUrE8lb5h1JiohmuTw0VeYs8rRZiO6Uuiwg07zoZKY
 PrIqkJgmpoTSxVJiWMjgmd4ckA/VqjoKdBM8w7jd6gH1KMm8CWjHq0Wf7aNlA7M+ErTChBo48
 MEoEiG+5MUlXkhC+/QxMkiMigUuY/LmOX3pRHEpUrPJI45nvrQxXzrs36RGSjD6fjoMvA3rLs
 SrxpO06bzp+LvGCsLk7fZtpM2/wPLPyBM1n2KcLimklhPIGFjx5Uso7aKGFfXWwDb95j+d4wl
 R/U9Z8LVnlFKJNc45/D+9940mlWRkQjDISVeuoexamGC3Fvzc2tzFD2q98jfaVnw39HaoFirs
 rArLbsZuwygNZqAno4AVdMx70LIpypT3G6gKLDts5iu9aYyG9XWZXJX3j4GPlaK24A0MXfFO4
 4t0vdBql1StWAy9zn6ZWjQXwONN4HPlEdrQIHcp5lPOaHJ3VNXGO4HVM24sDQUK/ovVg3Klcd
 zLzqyYZ9HotPZz0ikfbkDsQ6RwO+gw4O8ZbuHsvJhV9oZXv3rT6FwGnL8FUN/CvhHqh8Smw3U
 DBmCDdT+cK36WANwu0BOmWjaQOKpskSUagnuINtR1xtV/a/QiNs9VcFG7N1fzDJULs3KRr/cO
 BHtF9pYaGLYpPZvZJCpRJ409hoRdQrJysO+DPPOQ8GXMdxbDw5soT/oZDtc8L+p43yjSbhpu3
 5GAUZ4A7wkO23tCaX2GVh4qJa/Y7NmKSmUanB5XX0ah4gSPV1HW6e3L3P4zgymeMKdGCrarvo
 J6QglQo95EKZNBuwXQmhaKJaehVfPIF+Y0gNUis6KxSl6SeYp7urTXtlpFVzrCm1p5vvqQpOj
 OEv6iCdWU3j526BvXAEose2PbjqKvavm/0fFFUzY1uiD71fxi10oNSE6fRA1Gopx3KorC0PQc
 xfxoT4Kq+RWqrFiwnV2SjhuhcyQx0Oosm3lILneZVFKbsExKoQ+uGLPw2hACb0I/HlBOuRc8f
 Rc1XmYMEBCQabpCriDv66hxnO1KlMNEzjSLc1m5T2X5yDGaelMHaD9UEmlJwPe+2tYwTC6LJj
 G7Rzor3dFIdyk1cVo+J1lG+aX/ew1a4KdkH3wHN6f6lDD5JCWRMKTCT7LhWDF5EYHFQVpA5ya
 tGRxNDm+C3covDpXTi9Snk2rMFj0Aca6jRtHsQTUs2rO8GSxk4meR3pzR4rDXdT+O+dmiuVK+
 3AdzNRFosMFmHIp7o
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 29 Apr 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> while the other branch lacks the extra blank line just before the
> >> single quote is closed.  I queued 850ef627 (SQUASH??? ...
> >
> > Thank you for pointing that out. I already did that: ...
> > Do you want me to send another iteration, for completeness' sake?
>
> Then if I squash 850ef627 on my end, we'd be in sync, so unless
> there is any other change, no need to resend it.

Perfect, thanks!

> Have we got enough eyeballs that looked at the patches already?

I would obviously prefer more reviews.

Having said that, GitHub Desktop rolled out a new release this past Monday
with the MinGit backport I prepared with these here patches, and the only
additional report at https://github.com/desktop/desktop/issues/9597 talks
about macOS (and the MinGit backport is Windows-only). Which I take as
good news for the robustness and correctness of the fixes.

Ciao,
Dscho

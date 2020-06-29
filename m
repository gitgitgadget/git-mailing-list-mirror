Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95415C433E0
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 13:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 739D820722
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 13:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="BQOLloe4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388709AbgF3NzC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:55:02 -0400
Received: from mout.gmx.net ([212.227.17.22]:41581 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732117AbgF3NzA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 09:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593525295;
        bh=ZNNK+aB3YU05JXEWTu5d8xqnfdh2yLp/KLJchS9r2g0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BQOLloe4pe+SkpvKahXjsBuX1ESSHi57HLkxq/Gw/dG9+OALm1l3o0Ktq+6W/EwPc
         +4tIvuZJwznYUYXTxElPKXbMKXBRoBiTM9qlOj3oCfZ0/3H1ApCCWlYCtId2bMZVMJ
         O/nlwYqy7Y7A7HE6+39xm7IqtfBxMHHZyjrHKAMw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.116.87] ([213.196.212.146]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5VD8-1ijefF0dUQ-016wKU; Tue, 30
 Jun 2020 15:54:55 +0200
Date:   Mon, 29 Jun 2020 16:05:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2 0/3] Accommodate for pu having been renamed to seen
In-Reply-To: <xmqqd05o75so.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2006291541290.56@tvgsbejvaqbjf.bet>
References: <pull.668.git.1592924655.gitgitgadget@gmail.com> <pull.668.v2.git.1593010120.gitgitgadget@gmail.com> <xmqqtuz08ofa.fsf@gitster.c.googlers.com> <xmqqd05o75so.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:3euljR+ZATStUeqX46ma2qBrb24VYu8TduVIccNs/fUGkLKDl1I
 ibZHuB9oCK/yOaG5GczGqdvG57Je7C5ItkMu78Bsq7HAQnOOsTorMYYKzgDxEMHGxI4Tvxm
 /u+jZKp3Z/BlUW96SuEmIKzzr8b8GtFFRFKP06PgyRh5fZyExUukHtOsXrrINQ9FC41kKgB
 Cm0C4GX3v9B9Gtaec2FrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y97hkiJlheU=:/LBde+1eTCoMdzvfedESWT
 yrErvZ+P9g1wxn1SvdlfoiBvjKZGkX3JQr/Ygzw4dAa9eEL1omKPZe4f4YoC/m0AFQ+LxZT3L
 8C5nsn5biML7K6YOD+vxZFzuW9selAvlGO5DcMaqitAEU4zlk34fLJ3mazFf8Y8gSQRgT6LQ8
 s6angPmQsWddc8/SckIEm8OvTKE58onG1LY++GGReJr133P5C85j9zefPnapmCsjBIwGf3cx2
 4qZSjlR2F0egpqQm/mCgL2lxb23zaNhPwzk++z7jbgX4utmyFqMLqyw/Ki9VgabhGXdSl62m5
 SrUNz6Uj2fsiuvFXByIQSln3khEiPebexpquq3p5zl1EgbwIoSeodvKk64Fakl6DQyh4eOYdF
 peU8M0Q8sw6G0CjZ3iL96n2V527R0E13HcsD0v7UL8I9d9Yi+jWv7mF3JP17d5DQmL+wsJl8Y
 d0pn9ymKrwwLKAdqVt6LmnoBtED2hhCeeSItxOAUXFoa3tR8E1UZPE20iAfZg4306neVtAaum
 HKMvhUBCwQTj5eEWFPa1BMDKPUP8AywtwJ/ADLPFSIk023X2+Wcp4Oa8F1pgPHiPZPFUUQd0Z
 OmbaW1BkygqKe/Wa6+LLRn6jtpdN4N//lxRpxHG0PbmIR/73GZsEbR/uVZGvPyBhYpF4x1Qiz
 tHlhFds+Y7bjhL17mpbiCZ514FjiJEit55VV5FOWP22xLLqrGQ3+ohf9I9C1uRYak5vCisgFQ
 4csmwAXQS+rgf+rX7EahvzEo63DxtWwE2cJAihmgujrjIGcr0Zjj0KPEuhRWUsK8oGJppWYNx
 g12epiu9WRt3MwB+eLtlOHRQ3ieiBcijKHetgB+Mw06gsBwBLHi3faoDPVEiujT13+CkTl49d
 ozqXs6OfI4ZUVpCskvv4RWxFPho/S8SeM4WeszqEp+Hv2mhBjwLMFFvRkk4EuouS2Gc3yqDl/
 GoFkx6ec2+Z1yETgPgf784tuJVzsLfLd+xVYVi46Rg5nIVNx9M8PGxHGZ70w+S4CqufJpOdI7
 B69dyVd0rod+H30tk9jT5Y7QFSaS7/7JOIcgJxAW5K6CApmsutV10lnVCpR7pPLMutJUEw0XU
 Iq09MwTNMoQtrJ+8JUwqbXVocKhdPAOgwZlw2TfoEDTlJc6GZkuoByUuNw9jxu901tZVFA3NC
 PrgB8zV+BVTwg3ti9tZhVkPYbn1NYGPQL5SmVZCeHCdaCEyulVo94bN+eSJzTYBa0aciyky8Q
 I/Ylu9RIYwPgAtas6+TkgVUMKlu6IGaFBwyEhiA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 24 Jun 2020, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> > writes:
> >
> >> Changes since v1:
> >>
> >>  * Rebased onto master (no conflicts, so it is safe, and it is more r=
obust
> >>    than basing the patches on seen which already contains v1 of these
> >>    patches).
> >
> > Thanks, I actually wanted to include it in 'maint', so I'll queue on
> > the same base (no conflicts, so it is safe, and it will be in a
> > maintenance release if we are going to issue one).
>
> By the way, I find myself typing 'pu' all the time, even though I've
> been using 'seen' for almost 48 hours by now.  My private tooling
> all have been updated to work with 'seen', but it seems that it
> takes time to retrain muscle memory.  I'll see if I can fully adjust
> before the next week starts.

I do understand the issue. If you're as addicted to tab-completion as I
am, something like `pulse` might have made that transition.

Ciao,
Dscho

> I do not know how many of you regularly have interacted with 'pu'
> and now need to go through the same adjustment as I do.  Sorry for
> using you as a guinea pig for an experiment for you know what to
> gauge the cost.


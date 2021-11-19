Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA3CC433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 16:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8949B61B43
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 16:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbhKSQmn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 11:42:43 -0500
Received: from mout.gmx.net ([212.227.15.15]:40659 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236520AbhKSQml (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 11:42:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637339977;
        bh=0hT8e/4kkI7dGTRNMHSpk1HiQAPN9w+HY0jWy3H6oLc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dWAkyADD9fkusxZXeH3U2GpxkA2HJbl3WXz4YVyhxP8h5SihTyoJ685uh1naizm/p
         89u42Dzj0iPK1GmPWrEahHhsi69iAaFRI18+LFVUWL8Oeph+JsTXtW81hkJQCbqUEd
         1PVOmYb2VGpNpaJxRgLr8tHGlP6IS9ZfMRv76kio=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([213.196.212.25]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkYXs-1mOAdj2QDm-00m5OM; Fri, 19
 Nov 2021 17:39:37 +0100
Date:   Fri, 19 Nov 2021 17:39:35 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jan Kara <jack@suse.cz>
cc:     git@vger.kernel.org
Subject: Re: Stochastic bisection support
In-Reply-To: <20211118164940.8818-1-jack@suse.cz>
Message-ID: <nycvar.QRO.7.76.6.2111191731400.63@tvgsbejvaqbjf.bet>
References: <20211118164940.8818-1-jack@suse.cz>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:JHMvtYPEqliWxtiS/nq1JCfniNIVYnQwCDlmeafw1pFo9QUCV8K
 iRDc+zm7v8zyzMH9PssqENH8tuHtI5kUgJ0xg0OUvuHP8O6BlJAQA2cu/yuLRI9JQcaOoWa
 mT0+5ppYXLqjOA4NQqW91l6xzM06AUKaiMFfceDA1+aKdClKr21oTD/tlz4Jk/QlJPNTL7z
 TfJK/xeUdzhMH4M8Z5KCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2+XXHHpBiFg=:ItlEGm1tSz5t9ZSQAZls10
 aEGElYdV8HLYf2/U5sivuvzqHn/vS3XcoCD0c2vMMrF+iXVTlUpR/JvtcvXjG+KJrj6sJ7hR7
 N2Uwyz8zJN4QOIyNu5u5lYEUw5vkM5uwaWZYoqxsAvtPcoAiz6Bdvv86W0OBldFiPkFhRsnms
 UCcV/Hvq8hFEzKLr5LIjt9bW/qrurdrW4fFlPD3kf90x0OufDOx4QOsqOMW2eZU6ASf4qD9ip
 T9dVFn1G7Y34aI+4qUVyxT0JaH0OS1Ef9UBRQCEEe/I4jYmkz/wZmqeqQ+DptLSXBsVOicCju
 YZRSCgAvWi31WRhLPysO1O0vmJ89AxSlCFiNvXXCQCsfoDvLU7NJfALRRXbOC3mTGuG2oYwIb
 L0+BmdrEBME/2yTY2jxpbmJeSrpLmnBiQ843tEcGD8S6G2GJRhzkfCe9dKDeMizDegMX99Wa4
 CgQcYQpu0oYQVwf2+kiG+7ZyTwqZpjnh/60lz/J2GA/EKW/dB4IpAvh7HXOPfwRibDxD1Smr9
 R6g3xOpt0u0XEgC13UtXJtl7sMyHFbhe3R1oPgPDFAiZfHuUT3/sIfVo/EWvMt0xghTQhZ3Qv
 dwngM/8VZvzqI7Kn1q1EmO5Hc1W3Ps26tbvRnAIyTDAQ2FIKdzOfURL4WbMyv1bOBG2p0y1LQ
 8TN3ASGu80QJsE51K3HuAhN7oiA2gTZ4ojqU1AGXIWBj8P5szRH0tCG+kKcQqv3NGD5cQOb92
 O8W4ZK6ylbzEW5Swn9aMkqTsED+YpTPfbA3ayIKX7RDX3r8nM1S9A/wGT7RmzhlwpjoonR0lI
 JRySkK5pQqQmHGAIx6fgMw+3cYua/gx0yfc8YwzJR2W48d7CzljJVMQV6B7nxKfunIZLSUAEk
 tyewAPdgZUCvM+Lh2QWqfC+oP2h+apDfmSHCCXh6aZ+A9MQfd9B26+HryiK4Z9OxOH2uZgwVH
 Q2DTQ0bdfO71ulfzOL/3CboUtQvkHClv4b/BEpVYbOx3UmgK8qECbBmBqss8XEU/4+PJW2HQA
 FvJR8WFo4w2ymnEbXXcURzPd4//z6q0ukewxJSXsyFPPZSQn7XoCRdqhSVok8GS/X2irmLs5/
 NkVtxLjGGgPikA=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jan,

On Thu, 18 Nov 2021, Jan Kara wrote:

> In some cases regressions (or generally changes) we are trying to bisect=
 have
> probabilistic nature. This can for example happen for hard to trigger ra=
ce
> condition where it is difficult to distinguish working state from just n=
ot
> hitting the race or it can happen for performance regressions where it i=
s
> sometimes difficult to distinguish random workload fluctuations from the
> regression we are looking for. With standard bisection the only option w=
e have
> is to repeatedly test suggested bisection point until we are sure enough=
 which
> way to go. This leads to rather long bisection times and still a single =
wrong
> decision whether a commit is good to bad renders the whole bisection use=
less.
>
> Stochastic bisection tries to address these problems. When deciding whet=
her a
> commit is good or bad, you can also specify your confidence in the decis=
ion.
> For performance tests you can usually directly infer this confidence fro=
m the
> distance of your current result from good/bad values, for hard to reprod=
uce
> races you are usually 100% confident for bad commits, for good commits y=
ou need
> to somehow estimate your confidence based on past experience with reprod=
ucing
> the issue. The stochastic bisection algorithm then uses these test resul=
ts
> and confidences to suggest next commit to try, tracking for each commit =
the
> probability the commit is the bad one given current test results. Once s=
ome
> commit reaches high enough probability (set when starting bisection) of =
being
> the bad one, we stop bisecting and annouce this commit.

An interesting problem, for sure!

It is slightly related to a scenario that has been described to me
recently: in a gigantic project whose full test suite is too large to run
with every Pull Request, where tests are more likely to become flaky
rather than simply break, a stochastic CI regime was introduced where a
semi-random subset of the test suite is run with every CI build. That team
also came up with the concept of attaching confidences as you describe.

I only had time to look at the first patch closely so far. I hope to find
more time next week to review further.

Ciao,
Dscho

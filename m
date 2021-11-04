Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC10C433F5
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 10:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44A14611C9
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 10:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhKDKVy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 06:21:54 -0400
Received: from mout.gmx.net ([212.227.17.21]:40585 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230365AbhKDKVx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 06:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636021150;
        bh=lNcwIFR+08PIZwARbFfwfHcKHnVU2UgFSoMDA3JEjp0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WT0QB8aNQr2Xcr9M7xDqwZFBbCnLZmhJ2ZGI0lapbFmRpFAUkqwbS991hj/LbG7ed
         kc0r0eIPe7CivggfhcMoPV4IZ8/RoazEuHytif6q5dnBZK1qoMol9SCkiJWpCP8AU+
         KotYyW8TbsWVTqcrdDtLFaD6zLP/zjqVi/LV6rfY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.119.151] ([89.1.212.10]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mw9QC-1mS0t73ofc-00s6Dy; Thu, 04
 Nov 2021 11:19:09 +0100
Date:   Thu, 4 Nov 2021 11:19:08 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] ci: disallow directional formatting
In-Reply-To: <xmqqk0ho4xo5.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2111041111570.56@tvgsbejvaqbjf.bet>
References: <pull.1071.git.1635857935312.gitgitgadget@gmail.com> <pull.1071.v2.git.1635942236065.gitgitgadget@gmail.com> <xmqqk0ho4xo5.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:miNzpYInhPxU74oqBy8Tv1LLZ0hMSF5augsSKOJq4SBnIz/uIL2
 L6V3M+ZV1P9FVEpEp0y6BlnmL9De71axNsGFA+LjKWFEY2vkTwMIW3LwCfVmdsWl0hKTHD9
 9BFhFkgfs9kr1lGlqcLNbefNY2z2l8QfUS11kWe4oAjy/WsAHztz1c/7GClE6EmK6EnMSdN
 qtHlRqM3bGgX2VavoOmrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qHQE5TQ3GMQ=:W2gHk/xWhrDDdZfBKLFfDc
 ZMnh4L8NRP6i9e00cAa1Z56P4XhF7RCqHlK9D1rqhY4Nzva9RZRS1Yjs0sCO9EujWgk+KXtGZ
 LFLBWP6scNvso5c8cFKgocLqYCVMprWpZdoOCdGKinvB4zgPAARniLhK1nTWWucQoGosuAp4P
 cLFAGLo2B45JwlJdfjGL27uXBJAbJm1Qv7mt/HHz8nEyafKdi4ZeLrTRIwTT8ZKHqFGijjwRZ
 pA+mC8nu/RGxVbO7QtISeC5imT7SQOfbFdizUraoD7+Cxhay/UCzxrO/akLj4kNITpIRqcGpg
 YlIE/9imTWlg24FMXG6EX4U33OsrZbhtP6gyihWBuuadOB0jDB546CFyaHU9lU01Rxd08whRO
 gSx0Sq4nRMqmLFmmIDllTyxxv3bJRCM7YG9rGChkAYtXYVOwer2WszFmm4Djm4Dsaor3geJ5O
 CjfxZPJLxm8kHDpdCPkoBSpWlMYkWqk2UZNZZPCJl40OPcYehW3oq7Mg5WHd6jW8ZVs8efYKd
 hsa1XpCAlW4R3CSffYstM8Z158jwtYOMhrunOFDFmuFY12jJknw/gXu9HVTJrYCwHkWkqkT6B
 vxa0foto/smjKOJwE8sYGCrC3iYl0nuGsHMJLMEV2QRAGVq+hJ79i6EzkUYfWodwtsvwVHVqq
 HWDMNHI46xWhkTk0f6/yRE45YvAZc6YqX0wcTvCbFsbyxTVqQJ/c8OjCZ0F+syEVMaWLHDEaU
 wlqLCLEIDIQ3yHOJDDtAAK+eZXekqjGGaJ47GGPw2/l1MYHiKmQWjRm4XyUMvbHcI3VGqDpuN
 EZS6AI9+fQt7Zqb7syCaANteEOeodxjhqtUaNLACexICHtzmb0H+SNf+rrQ7NaemnLWGHVVJC
 3CdVfLjHVZySjTax75MGFZSGO3Vlg8PTZgNPnAULyybXs6b7W+gupRlQHrivnRYaXqYz6+RRv
 cweZ+b5Buxi0brGkzukVou+kFMnSMbXARXVeC72nnBajb986Pm0jwl+0iOHOZI8TEmbh1dwlE
 RovtNBSX/FZtEx/DGKV3hOO9ulh11E8zZ6RUYKzrU0Lxg4N/dfew0lDzfbi9iqHrzzqxckWxv
 AxKGMJBCOPWNmk=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 3 Nov 2021, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > +# U+202a..U+2a2e: LRE, RLE, PDF, LRO and RLO
> > +# U+2066..U+2069: LRI, RLI, FSI and PDI
> > +regex=3D'(\u202a|\u202b|\u202c|\u202d|\u202e|\u2066|\u2067|\u2068|\u2=
069)'
> > +
> > +! git ls-files -z ':(attr:!binary)' |
> > +LC_CTYPE=3DC xargs -0r git grep -Ele "$(LC_CTYPE=3DC.UTF-8 printf "$r=
egex")" --
>
> One thing for the future, and one thing for the present.
>
>  - Do some languages we would add to po/ hierarchy in the future
>    possibly want to use these sequences as legitimate contents?

I mulled over that. And I think you're right. If a right-to-left
translation needs to refer to, say, a `git` invocation, the part that
shows the commandline surely would need to be guarded within directional
formatting code points. We currently only have translated messages that
read left-to-right, for example we lack Arabic and Hebrew translations.
Those would be likely to contain such code points on purpose.

I therefore added `:(exclude)*.po` to the command.

>  - Do we need ls-files?
>
>
> For the latter, shouldn't the attribute-based pathspec work just
> fine with "git grep"?  i.e.
>
>     git grep -l -E -e $pattern -- ':(exclude,attr:binary)'

D'oh. You're right! I fixed it.

Ciao,
Dscho

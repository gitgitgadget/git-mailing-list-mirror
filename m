Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94007C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 10:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600F222440
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 10:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="SDkRfx2L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbfKTKwN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 05:52:13 -0500
Received: from mout.gmx.net ([212.227.15.18]:53439 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727514AbfKTKwN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 05:52:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574247126;
        bh=dj9HX7zh56Um3KwIeKtwR4kT5Am1bGUGC/yWt3bfF58=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SDkRfx2LwoI8PWfb/9BiopQOJT79DtSwSS+MYk1k+SrSnRWYYF/tMKfQhpif/MmCv
         ou/oVtnQ/38MqcoMuPf81ydYFrXYmZsfkZ/eYfk34Pjjtf4vZ4PfFklATnLonNG/pH
         zrfSvKx3Dna9iQnUE1iJ44Ui1IaBRqNiEPKuPKDM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvK4Z-1hgVxH0RHt-00rFSc; Wed, 20
 Nov 2019 11:52:06 +0100
Date:   Wed, 20 Nov 2019 11:51:51 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/9] bugreport: add tool to generate debugging info
In-Reply-To: <xmqq4kyzfknc.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1911201150260.15956@tvgsbejvaqbjf.bet>
References: <20191025025129.250049-1-emilyshaffer@google.com> <20191025025129.250049-2-emilyshaffer@google.com> <xmqqr2284is5.fsf@gitster-ct.c.googlers.com> <20191119202542.GB36377@google.com> <nycvar.QRO.7.76.6.1911200018470.15956@tvgsbejvaqbjf.bet>
 <xmqq4kyzfknc.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:81sRcsdKnSNuKl45fX6KPeNXvgLU2KDPlV/ThUQDyuQFZqGN7lY
 Ll9JGyZTQ5gIvDG/ApV9Y1qekQmEiuurlz5cnSjP/EqaxYYU7iUVskhGsDeIG5eLII+nTky
 HYUwAJOw/5U+lj10kN3haSqi05kHdOJlAdj3iRhTMYLRKBgb5gwV3pn6Ghnoc9vLQcI6wgF
 /a+FZa6DRrSOsJYeQBCAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oddKhrtUSm4=:q8EozTj3fYmcoecH/hC8Gg
 yrWr4TFPUzgU2c+i4GN6So29qlsdiOPMZ7esI139HKr97tZ3O4BhgD4GCl52r3uic+QgaQpQQ
 PXrfXjQxhGbQCB1/6LBKrYquOSzL8ROAizWaqAWrg1RiE++mjSKAtZMc498fXjHwVDOjiu9fP
 YgFbaahx00lWxoYbk7oubwCtE5Q8xp/2wrJ3keLmOJKBH++Jzqd9L4fvHY9eVTpUt86Md9Adz
 0/s/GRco9IHHbu7dRamh5wEjz3KrvR+5M1mBHI/6JV6JyuwFLr31EPymBpaXdcqEgnLC17xe2
 2G7DCB+Z9Crjl43+C+je+j0Num6lulNGF31xtYfjY/rF2GL8Y6c6j0+MD7UkBkZuuYt60DQOT
 HAQx/MDfKHi90fAJGar7R7TO+fHdO2NB0/KZGLsmzjc1RsiMi11dVP4rR+PpWxo68Js9bWM8W
 WRjmdKhF9/ZLzfbicLcWewSR75ZwTjtgk5ol3GmZrhuIQdlHy+nSMiOW85ZHokv6bLsXBsUbH
 4cbO9kcX7fw0CdcPHUHtVhTRIlKyOhHxraFYD+/U+xfSkVAYqlXWjbQ7woiMRqrfwPZc0gK9S
 xnGBf5Il8WtrkW2JRZRGJOYYhXhjEgIFAIGHHfM/qXpx0mDx0kaALAKIKQT8BgUnpPiF5DM+h
 U4/VtbEJACxB7tD4k2goNwuQntpRhOWe7apYXTmj1UWVPEKLeZw+C8pj0KRSjiYQRIMM2DKXu
 DzE6mbo02SHxQILFBPYYQClJOAQqdxdLnU1PHxj6iDNbX/9U62zFau4Tm6aAqnbPG5KSLezS6
 uA4xQXN01lAR3sHwiTN38hWnYiMmXK1/fzPr+jYPmweAuLD9nBe/ihzWHKSXrmokkkBeJs2tT
 CrS7YNdLRpcCEb/PXgW4ubjoM9AUZDIjOvn2CJn+TzIvnmViSvWN53HgDUf0H2NTPThK+ypmp
 6ctpsTVPckse56QBAcLyYQiixFk84UO/CkIxw2+JpQdyMxiLQ19zQNVm6SF/e2DowYGy0oRsQ
 ZVD04Y2ZFz/I/UeknkPT54Q6P9axkea5OqITzlVoehiJyHDnDnqRLp3bVOwcsDJXXlr4P7uaC
 iksN/KFyT5yGul7r62D3GdJeRtr1pMO44dox+VNE/tVWgBpTButrt0ocfCf53Z42WHyIIPxkt
 7Z/L0/giyfYM/PIl0HH7s6Z6wKHAy6YbJpljp/1FJWN+27Zbm6a9B+fw4w7B7NxxgWRi2FkFG
 mKhU4hxqYeGO+Ap8ax0U21ahXL/UAp3DT/NudiIWYy+a7c7ct66EwqhuEFzs=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 20 Nov 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > FWIW I disagree with the idea that a tiny built-in command like
> > `bugreport` would "bloat" the main `git` binary.
> >
> > In contrast, I think that stand-alone commands _do_ bloat. Look here:
>
> I probably should have clarified that "bloat" in the context of this
> discussion is not about on-disk space.  It is about resources needed
> to run "git status/diff/etc" that are everyday local commands that
> are expected to be lightweight, i.e. the same criteria applied when
> making the networking part (which the user expects to be coffee time)
> separate from them.

I guess I still do not understand.

Are you suggesting that `bugreport` would be unwelcome as a built-in? If
so, I would really like to know why. Because I think it would make for a
very fine built-in. I interact with users all the time, and a good tool to
provide good information to accompany a bug report is definitely something
that would improve the current situation.

Ciao,
Dscho

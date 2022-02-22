Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7467C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 12:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiBVMNi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 07:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiBVMNg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 07:13:36 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6429331348
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 04:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645531988;
        bh=Bh5rll44DCTLK1/5n1461pQRkLYaGspaB1n27vy8Keg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CGa2N36kS2gmg/JeBGM9+BW1uYDbQCj6kwsTwolccop9ZcPikoUj/YOcLl3XbKvSm
         iUhEFjtuVMswtaT2ckK6aOHGohK3dX90FxDE3UN/5iEo2YKVk9hy7XCn17BzxUg9Eg
         JRwc4lF0SmK79Kw8Jr7lIAZFMuffZ7hF2nv9PLJ0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTAFh-1nomXT02Yh-00UYaS; Tue, 22
 Feb 2022 13:13:08 +0100
Date:   Tue, 22 Feb 2022 13:13:06 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH] Provide config option to expect files outside sparse
 patterns
In-Reply-To: <CABPp-BHmU8-a+McANE2bdAndGEtVudr74FHEEj6K6NwYECEZ6Q@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202221311480.11118@tvgsbejvaqbjf.bet>
References: <pull.1153.git.1645333542011.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2202212100080.4418@tvgsbejvaqbjf.bet> <220221.86a6ejakun.gmgdl@evledraar.gmail.com> <CABPp-BHmU8-a+McANE2bdAndGEtVudr74FHEEj6K6NwYECEZ6Q@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-432541242-1645531988=:11118"
X-Provags-ID: V03:K1:v9MDPvzUMiXg4V88jU8W3xIsGhZnoL7mdFG7rFI/Ro6+gwHwXgH
 3l0SzmcU9n+gtBwYzMQVs2TUz3+DCHibQyHEZXLB3a3fDSxPux402yUeohQUxHKvWnA19kv
 QbE35xnLAy+1Sb6Bx9HOsf4EnclgsKjgcShLQfTTWQp4GBBtODvHd5EPMe/jfxfNawXOXva
 V9QRAdhXEGGJwLkbbfTbg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OMslHKqELuE=:21B34OGmlO6ZTJjZsC1YXm
 vdDz3fUiQy0/Cqj2waogIvMsVgdx7Wpfav/xstuJqaAXoAuZQ8hsv/wXqYHnAD5QNwcJSmJ7B
 1+bhm7kB77EP9hY5vErIMNcBhy4LAANJRE+76fPnJ3nGDxVQ8N79Di1iabt7ta7VsnnUcITtV
 xwQ+R11ipBOmCswGWRfG4HRk2c3caSIFElxrKalL1/9AfAkQE2ToaFKPPOuMEVmmawMqdLgv4
 ttRlfYzzuyEhy7CV+DxE1g+or4rA+3pYp9p7ETCvDlqNxnoQbp/+S9WqkIZLT+YMQF6VRmelL
 RK5CwrBvtjI+KfEmT2JmWRi5O33Uut27UABiaEGTko2MasGAGIO5k7sS00wlD3HPo3l2isPPI
 XljePHkDB7gr+OGBLp6NAQdTJRlhHvZXAwzt+4J/Wq8SBii7grPTp1WCnWypvUGTTcOn0NGXf
 CmF7Uj/XPdGx0d5FuhWET8oz5TK4px1szLDSyHuokJo5rdLxxwEIFLTEj6BY41dwihVALjcPr
 HGyy2MxVeMrfapRQXaQM2QWnRR7GlNO0hyR342uBFSVpwemQlMS7H/EM9DTjTpXFIje5lAoDU
 ghxFd2HQe2cUljMo+FJHxJQc7gbo/ZKv+ofTKYbAfKd7nAZDrCziEOVf8OdCbUW7aUop/ffr9
 IMjB7Hy8sS1semaCk5pQZtxlDdM+xClhecBeDA4bhvVXPKpgHTkoQ45Lrree7pxr7l1hKIPp+
 coSrIJ8jC1iW+0cllcBIwUKJqlPWfwwG3GMXnH/q3HAHyLtKDf22v5u8UF/UpJLh80aSO4qRt
 llJRcGR3UD27L76PWGuDF3gC8fxMabaKLU5kAffuTKAwBr71pLAfYAJyjVAXuq80K9saqGYd8
 iau4AxCvO7eRv3HTk3GKNG47g+u1LTX10Bz+D07ydd7m5F7BhdAtn/isAXC2dzZC0Q2F3+OUA
 ZIoURmYJskL64QPjK9EI2Uzy4ySKi7nMyMpJA4COizDFyySiHWftv9n4RW+EjqeW9guCTJwip
 TqAZt9mIpU6MhTJ1/sLyLEU7JaJjGc74CscPnb/DR9ipBZmfOXmF4/RHIeohDj0MhXmUEo5Wn
 bTkxl/E6xfJwXU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-432541242-1645531988=:11118
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Elijah,

On Mon, 21 Feb 2022, Elijah Newren wrote:

> On Mon, Feb 21, 2022 at 2:57 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>
> > There's also no law that says we can't have a three-level variable as
> > core.sparse.*, perhaps that would be the start of a good trend, and it
> > would sort adjacent to core.sparse[A-Z].* ...
>
> Interesting thought.  I'm curious what others think of this.

What would make it `core`?

In other words, while it is valuable to consider this option, I don't
think that it solves anything, for the price of additional complexity.

Let's not go there.

Ciao,
Dscho

--8323328-432541242-1645531988=:11118--

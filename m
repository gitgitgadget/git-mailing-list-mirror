Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799DFC433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 16:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiBVQta (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 11:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbiBVQt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 11:49:27 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A293164D1E
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645548535;
        bh=aCLzSnimO/HmBxgtYbUaJP/aJjqaWgUNjMptzdk+Ojg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FJSY1aDUQ/0uGtdVkLOv6eXrskZFUle0iNjr40UkHFf7k1btiu8r5MhlsUjOv196X
         SWAJQ0ZXZlchcGVatapD/3avMPDbRfd9B3yyklVju3MEJP/+1AaUv0bbGWTAJXi6i0
         IJMlFV2Dfasn5MZllKqcVf4dYveLQEHX+sQGjYn8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVN6j-1nmEKG2d7f-00SOoB; Tue, 22
 Feb 2022 17:48:55 +0100
Date:   Tue, 22 Feb 2022 17:48:52 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 08/15] merge-ort: allow update messages to be written
 to different file stream
In-Reply-To: <CABPp-BGzWOqgsiRx0jAitbriCCyP8GaVHcCmYV-+CAJZXf1f-w@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202221747470.11118@tvgsbejvaqbjf.bet>
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com> <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com> <04c3bdc44d2c76ffc82a95db3ca4fd07270f94cf.1643787281.git.gitgitgadget@gmail.com> <220203.86ee4k7lo8.gmgdl@evledraar.gmail.com>
 <CABPp-BHye_Zyw=x8B+QoSxWA1b0xyVL9==7kA4CD0q3eTrk8cQ@mail.gmail.com> <220203.86o83o5jr2.gmgdl@evledraar.gmail.com> <CABPp-BEKuXHELVx4=5JJTj5HVOKZ=Y-4G4BK47BCZYYRSrkFsQ@mail.gmail.com> <220203.86fsoz6hr3.gmgdl@evledraar.gmail.com>
 <CABPp-BFFcFxWL+FRSf9ANwHU1mp_oWcsfLOwvBAuv-J3oNh3SA@mail.gmail.com> <nycvar.QRO.7.76.6.2202211011510.26495@tvgsbejvaqbjf.bet> <CABPp-BGzWOqgsiRx0jAitbriCCyP8GaVHcCmYV-+CAJZXf1f-w@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2054967761-1645548535=:11118"
X-Provags-ID: V03:K1:wSJTUYFVyF2aBRnSxrxTrD6MwCl7cpHvrNVNp5aTqiKTzBDpgPd
 6CYE8zz9E/MX/R6dLv4Ag3ZxXj8WYD6ReoXqoIaN3Bg+krexo2kvafvjoyVBxGe4kXJMOnU
 8O3j6nstlQN62YNUxNK2F6KChFCsTiCpM53UEaTQyhB20UNYAYdSyUdgynTMhV7Z1rTACOh
 +/hyjnkfJYNqXx7qzwUBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Zz0VU/aVdG4=:dPBohOIA5NhzyrBBTttSsW
 1Xwdcu/b0+JSmSQby/lyjWqNzCBRNuwM6MIN+84eZFxBsYTe1fXs5/V+tmattoUAdmCANqaAE
 afXGNTxncGjU4ZL/Z/CThoDClEuxNtUIdNWbMIM/37A7+djy16GAZbipfoUbZthpodV+4V0yX
 gV8s83C9vr+t9xx53FUBjhbrU05ui0q0B5p+oR21ayds3vM2y/yZbkP3pchxiX5VydzW9ehzH
 i+2DmOhcWvqlzqcuUjdokeK6mG/aCKAHu4CyFKMkRaSAUQ3pSpeaQ2nDu9tBjty1N/SykI44B
 MsoLJ4A8eQcTHH0EpjsTZYzjPPQ2sRt/Np9dpkgXxUYf/SX+sa3E/4nYV0FHApEawwbe8Z02F
 4DxafX9cB6/QN1K59i94t0eATmHdqcgwhr5h9JgvpQfZ7Q4N0gXxYePuML3fnaVeGh4J8SyO6
 WjibnkSjK6YM4QcTS1aBjIg1CZehBQ8CRYQBbAA6BcE7EX3nYR3lywDJ9B12dfAqJQEsC3VXC
 Sx1/yuVoO4uNlfbRygBXVTQ0uSrppbgeT0pBQP3WDgd/VB997NJtH8rCKeKUu4CJ8c9Uw+iZF
 X/hGLGr2a3dkgGESuZhC2TFxxrqOsTHxpGE6uPfP0CHFrd6vIkfe041dm7K42WB1xWRxBHqp1
 WT1YR03dFVAvjyskyELhHntgpDloMMHPQIbke9ObpkFzJb2uEoEkYPbjKdC0YMojoB1HOTYOp
 YEAkWbwhmRbB92NnuRNnvYe53yOBDeuB+5ydIq5DPnKCqKt30OVItrkrHXAYEh2021H2coRGX
 6oi3RYHf/jgSpkYUecsNP/u7sYJfHBhb8sBKleUkagQUkEcxlv0u8NsOMp99PdGNvFbo7DNih
 aQPrWZdtG9oAeqzM3OI29CEjGaBHNhdVE8u8jpdBLsJDhho/UtfY2CDeHgKjJBKUxyEEWqWKq
 YJzheTus7zWd4HYIaiOPNkvUcvPNIR+yLweUzpFB7BEAzZnvzH0/RpdJqOjTMGsksVD6ZJPbe
 wAXuvo9a1dwopLV7LH+RM/+KkJcPVPxvnU2dpDhheaY4DD3a2PfVGzJSa7poWqQswLuYNaEl0
 XzrvaZG+aByUjc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2054967761-1645548535=:11118
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Elijah,

On Mon, 21 Feb 2022, Elijah Newren wrote:

> On Mon, Feb 21, 2022 at 1:13 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > Hi Elijah,
> >
> > On Thu, 3 Feb 2022, Elijah Newren wrote:
> >
> > > On Thu, Feb 3, 2022 at 8:24 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n <avarab@gmail.com> wrote:
> > > >
> > > > On Thu, Feb 03 2022, Elijah Newren wrote:
> > > >
> > > > > Man, what a can of worms this all is.  Maybe I really should jus=
t drop
> > > > > patches 5, 6, and 8 for now...
> > > >
> > > > Yeah, I really think it's worth it to just sprinkle a tiny bit of
> > > > if/else (or a macro) here and print to stderr inline or not. We ca=
n make
> > > > some use of some usage.c when there's good reason to do so, but th=
is bit
> > > > just seems like a needless digression.
> > > >
> > > > I hope all of this has helped somewhat ...
> > >
> > > Absolutely; thanks for reviewing!  These parts may just end up in me
> > > dropping some patches for now (since they're not actually being used
> > > anyway), but I think it's all good feedback.
> >
> > So we dropped some useful patches future-proofing `merge-tree` for the
> > sake of appeasing a refactoring with no immediately obvious benefit? I
> > really don't like that direction.
>
> Even before any of =C3=86var's comments, I had already noted on my cover
> letter[1] that "to be honest, patches 5, 6, & 8 may be less relevant
> since we're now including these messages on stdout anyway" -- so I was
> already wondering if I should defer them to some future series.

Ah, that was not clear to me. In that case, I retract my objections.

Thanks for clarifying,
Dscho

--8323328-2054967761-1645548535=:11118--

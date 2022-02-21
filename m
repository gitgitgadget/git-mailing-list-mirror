Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793D1C433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 09:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbiBUJeA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 04:34:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244927AbiBUJcW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 04:32:22 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E36E286E9
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 01:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645434791;
        bh=9F2eSt02QIcqtlTWWrHZ5cXNUrLy9ANb0l1Q+q6mF60=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Vl0M8hmDHkD5w3XR/X1J90gTEBCUR6l25olbTgq25szKfZ4ZWEpOvwS/7fAj2UXLx
         jepi6MOZ2BDSPMnwBp/yOpzJFOL+Sme1F8xSeeJAiSpT+E39NGLBVUQLMfS8AnXJfc
         t/xRoXtXASFbobXdbXJzT/UrCVIXilCVN3jtdlUc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeU4y-1nwVQx2EUO-00aS8T; Mon, 21
 Feb 2022 10:13:11 +0100
Date:   Mon, 21 Feb 2022 10:13:09 +0100 (CET)
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
In-Reply-To: <CABPp-BFFcFxWL+FRSf9ANwHU1mp_oWcsfLOwvBAuv-J3oNh3SA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202211011510.26495@tvgsbejvaqbjf.bet>
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com> <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com> <04c3bdc44d2c76ffc82a95db3ca4fd07270f94cf.1643787281.git.gitgitgadget@gmail.com> <220203.86ee4k7lo8.gmgdl@evledraar.gmail.com>
 <CABPp-BHye_Zyw=x8B+QoSxWA1b0xyVL9==7kA4CD0q3eTrk8cQ@mail.gmail.com> <220203.86o83o5jr2.gmgdl@evledraar.gmail.com> <CABPp-BEKuXHELVx4=5JJTj5HVOKZ=Y-4G4BK47BCZYYRSrkFsQ@mail.gmail.com> <220203.86fsoz6hr3.gmgdl@evledraar.gmail.com>
 <CABPp-BFFcFxWL+FRSf9ANwHU1mp_oWcsfLOwvBAuv-J3oNh3SA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1583770473-1645434791=:26495"
X-Provags-ID: V03:K1:AWIt5evhzDS08spxb2FiqS9+lzjuVyHXiIEV9qWV2juCictHkZ3
 kdKV6SNGKAwMsAzZ397HMp99SkjYA985/tEnRQHEmHH5F4V7qkaujKjtcyadCeo1M9sCKph
 EOT5buxrpN+AB9bIhwqGn9nrJD1nw6QI1JRqeHuJIrsIp+P4YdmfGGRdZT6cYN4XgW3o2N2
 HKXnhd4AotrKNKn3ryzhg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jWzqPvdfGb8=:tQnZn3AXl0oqlJKp0g1ikX
 tdxpjetY781epudDSIgNT3aYafmkdtgWgxi8tV2r2TJKW12O1Y/vs8d1z0n8WWUIW7lXeUXqC
 4wqZOUf1iDfTQQ8ugjUn8qRcSAlObzqLb5c5g9amtvKFHiR3XBOV/dvoC/1zQ7X5qhNS5tb3P
 ARvSoSSNpGgnwD5TKQuQbYOejKQ6q4ivkt7IZ/jI/VHPqIKVyQLx33++MeeteUE3iLOB7Uf5C
 ZDLd1Tj1cyLjUIYCMgyeKsWfihmOntPLyxmmA3QFXLMo0UTwM3oyViPZDHNmQiL/bsjzlLuMM
 0pYAxGtjbO/wahD5KX7TSoxvp6bWehGAga8/Q2qnGby3gATsUeQDx3noqspJR2e3MZfYVapfY
 OGF5D2Mf2Y9jqcjc7nw6XTuCiohWHYi6sgoodKi3/KJ/WAcDytzCLS93DpUz7w7rywgC09Pdk
 ZEk+SL2u3AruKCYNu8XmUl223WoOFbzI8OzVyj7nsX/w0prQDQp9ehiMO1PCrLELj8+ElFBUC
 Gy3KlF2ucaEgpPO8SN2i3PkP0bRRgeLSgeSmBnQwCBX9C32St5xSLlimJUN17hpQyXyOZQNcN
 SnWR7Nhu2FFvZn0cHhrHyNH63p3TFvOxOi1zKQ4Py6EFV+tNnTepqbpTE52I5S1AUGHNNmrIo
 5Nsg0SD16eNDtneuaqhhR4zNgHWMrZ4MQ6GjsL3sSwxNiZqSznGpatrrsucCc/axjc9PpZ537
 s3Izw3hyoxZ1X7/RcOh72NLcrMOZ305vD7xqIfofhPWNbxiCentaiDdHT2u+YA9Gdlenra8AF
 Bp+5OX9uiKgGYvctxgtjStJAHwm2qdVtkDAuxx5pZW5wfDO7UajiwaQFpd7ShSTstlZqKcT+I
 9191zzM5D0iufRhGdOVdMmtxk4zRI/g0qa2HYA7QZEQ2tlgZh8asdbd6aTFxsblUVJ/Hm8rBb
 dpIo/MjUfjBjBuV2KlYPmYqY2ovm/NPvLDleHBsKkyHx5XFUBEbxnGeeF4buYcLJviXCHzrFK
 b4cxKEDZWq+cjAMrKWeQXa/ouiAolVHNRlC4vZXYqqiYQ9ImvBWHUO7Fp8UCKz0HvYi/TKsdE
 rVw8XwpSZYQXSg=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1583770473-1645434791=:26495
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Elijah,

On Thu, 3 Feb 2022, Elijah Newren wrote:

> On Thu, Feb 3, 2022 at 8:24 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
> >
> > On Thu, Feb 03 2022, Elijah Newren wrote:
> >
> > > Man, what a can of worms this all is.  Maybe I really should just dr=
op
> > > patches 5, 6, and 8 for now...
> >
> > Yeah, I really think it's worth it to just sprinkle a tiny bit of
> > if/else (or a macro) here and print to stderr inline or not. We can ma=
ke
> > some use of some usage.c when there's good reason to do so, but this b=
it
> > just seems like a needless digression.
> >
> > I hope all of this has helped somewhat ...
>
> Absolutely; thanks for reviewing!  These parts may just end up in me
> dropping some patches for now (since they're not actually being used
> anyway), but I think it's all good feedback.

So we dropped some useful patches future-proofing `merge-tree` for the
sake of appeasing a refactoring with no immediately obvious benefit? I
really don't like that direction.

Ciao,
Dscho

--8323328-1583770473-1645434791=:26495--

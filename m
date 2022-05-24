Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F1CC433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 12:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbiEXMZb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 08:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiEXMZa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 08:25:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5BE939DC
        for <git@vger.kernel.org>; Tue, 24 May 2022 05:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653395114;
        bh=AznlimO6+p88u/QXZS/u8Jc+iTM7lWAGAIrlCCqa5ww=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Z0lrO5VdjfuJ2lYyVeYxTRQ35ZTuW5viOyMHkx2OT7ZSZHoAg81L1e5KCooDCnx9C
         ALiivMy/NC653BmOL/jnaRuvCRR1x8U5cv14TKoEjqPk773j/MG6RAvKZ5BwbccOli
         XsdrEe0ebuzgDS7vVHkZSjf55Je7d6+xOaTQY7Lw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.214.24]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuDc7-1nYdOR1YcP-00uXDD; Tue, 24
 May 2022 14:25:14 +0200
Date:   Tue, 24 May 2022 14:25:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 3/7] scalar: validate the optional enlistment
 argument
In-Reply-To: <xmqqleuuazew.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2205241423260.352@tvgsbejvaqbjf.bet>
References: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>        <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>        <da9f52a82406ffc909e9c5f2b6b5e77818d972c0.1652210824.git.gitgitgadget@gmail.com>        <220517.867d6k6wjr.gmgdl@evledraar.gmail.com>
        <xmqqbkvuwxps.fsf@gitster.g>        <220520.86fsl43bkf.gmgdl@evledraar.gmail.com>        <nycvar.QRO.7.76.6.2205201753300.352@tvgsbejvaqbjf.bet>        <220521.86leuv199g.gmgdl@evledraar.gmail.com> <xmqqleuuazew.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1172410876-1653395114=:352"
X-Provags-ID: V03:K1:+NBvS/Kc4aiclWVHqEJBPwRe+kPHdcXEKll7gO5tVTeNXTRC9bg
 YE3W9EXV9h/jXpihyzxfgu1cpbnccqW2cPpOaLFLE6T0c5zbxHbW5SknRqI5ziR/jVfniq7
 gy7y06O6z/LYFJKs2DgCp8CSMTFQwUvWZ93s3+/Tr3eofO62+gB6NgQEahk345l56aBU4xc
 Pv/ZmphGntyi1zx5VliZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8pUvE6xzKz8=:LumIVf5bedkg5EEKEGpNHy
 JX3z0iRdF73HQb41Qk2fO0cqX+NrFYKJ8dac6XbRRZWoCi0wYmoDgorgvfEKjxS8OeB2bgHdC
 6VK95x+ApYJQKNgQPH7Et6QA8WtIlJjDZYccV325iLrLXqn5sd+6Mgb33SiLp7zjoo8wZgYKI
 G1rougiV8MEbgAci1zJ6B9wbLYB3PyTRl8LxtMizEJpFQmdKczD34imUjrlkOqOufHS5WQzuQ
 rpXB7KC1G8gmQAXCW2lDy/5ysmn/aJALJPwov2Ltfk1vUmmiRibgwmU9cX7AdcaGUo+yl0dUh
 Mtt15pPApPZorWXUYiEQs7zhpg02xQX1nRB+lOuF05C4I3nrflNA5w6JuwXREz6/f2wQOjulG
 +vSGWIkGju+1dKBra/q59ZkOKXUyubfhdyrHhNx1kaAsnUogh6XkMMzqr8XOT6SkAFBN3fwbl
 mbLLedXWiJMW//gLjGJcSmEOa01BViUusuUBe0nBzP9liWvaU+9AatFak3DkfYnYqe9aY8xad
 RA55RnNorPr1GaQdBbmDr7hlF6R8s5JKBzb/FHYmJ0tutVW3Y8hsgh+WsMYHuBNJAniXLOX6t
 EQjlkS6rWrkNhaTpdRciMVKVlgb+wwgVkpwzhKn+CURnXHwv7A/Tx7Rs0gYvfAIBBpCDwEARk
 RNorg5aq9y5UK0r58SnVFaBYgUt2DwYaipoGPoaBdrMmr+5Qrxl6nc1dKC4M97NdKvpDCJp85
 g7aHQ7tvZuyzkAa7ui9oieOPWEhjvPuoVhm2ldy4Cr16z7lcvT7oGDirkMgGCZGq+WBKihfiI
 KVVx0bJBVMUZvrS8T9XQLWTZ8sW6Yc9kttIQE68Oc5rQNq/CkMZe72Xo+ihnL4brICkelol8u
 m9lFYu5caXGOxPCHLxlOY2S3KH8TKXQpajWYp/qZEywrYlpY2kVtUNp/5R7sW32S06Btyfppf
 Q1KS8CBHmvcU3nN9bubzbZfJEI71au9HV2jipYtWwdqtl1DkSqS5DcT5mH4cdERF8afAcDkIT
 +nljn3yQyedR22Q8Wm1QW1fOBDY0tL+I84rHtNdbsfQ03HcqIf+aK/2CWtc8nWf7haZVCpX6N
 C5bZ5s1Lg4dZkVBmQ3VG9WJb96ihAO9SAS19wSZZB9z4L9Lk8eyY4ahNg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1172410876-1653395114=:352
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Sat, 21 May 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
> >> Scalar is not (yet?) a Git command.
> >
> > "test-tool" isn't "git" either, so I think this argument is a
> > non-starter.
> >
> > As the documentation for "test_must_fail" notes the distinction is
> > whether something is "system-supplied". I.e. we're not going to test
> > whether "grep" segfaults, but we should test our own code to see if it
> > segfaults.
> >
> > The scalar code is code we ship and test, so we should use the helper
> > that doesn't hide a segfault.
> >
> > I don't understand why you wouldn't think that's the obvious fix here,
> > adding "scalar" to that whitelist is a one-line fix, and clearly yield=
s
> > a more useful end result than a test silently hiding segfaults.
>
> FWIW, I don't, either.

Because we are still talking about code that lives as much encapsulated
inside `contrib/scalar/` as possible.

The `! scalar` call is in `contrib/scalar/t/t9099-scalar.sh`.

To make it work with Git's test suite, you would have to bleed an
implementation detail of something inside `contrib/` into
`t/test-lib-functions.sh`.

Not what we want, at this stage.

Ciao,
Dscho

--8323328-1172410876-1653395114=:352--

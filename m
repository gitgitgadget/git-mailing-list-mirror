Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842C4C433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 15:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbiAMPbr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 10:31:47 -0500
Received: from mout.gmx.net ([212.227.15.15]:43759 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232070AbiAMPbr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 10:31:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642087899;
        bh=XsfuhPO6a+lWs836gmP45hmoGNDdUClBq7BZZjanKA8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OurlYfsiVLSgNRwfK/LQSkP2kjakFbPiOela3zFvdvoh4SNNan3bcmWCbvgxZCCYU
         zmz6IS8lQEaq9eNkqwuRPmUgxksZdIgNXkmrdc2tkqMKTmhxPfLoeb1MIigJ5mWie/
         j6dFACbUDLYkpxwn97sLhjG9VCG6RoyimwD7jr64=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.174.184] ([89.1.215.56]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbivM-1mcpO92siU-00dETN; Thu, 13
 Jan 2022 16:31:39 +0100
Date:   Thu, 13 Jan 2022 16:31:37 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 1/3] test-tool genzeros: initialize "zeros" to avoid
 SunCC warning
In-Reply-To: <220113.8635lsvsw6.gmgdl@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2201131629300.2121@tvgsbejvaqbjf.bet>
References: <cover-0.3-00000000000-20220111T163908Z-avarab@gmail.com> <patch-1.3-4dadf7320ab-20220111T163908Z-avarab@gmail.com> <nycvar.QRO.7.76.6.2201121518360.2121@tvgsbejvaqbjf.bet> <Yd8njHz2m099iDfL@nand.local>
 <220113.8635lsvsw6.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1716208071-1642087899=:2121"
X-Provags-ID: V03:K1:nLpO+pJoizD5eWahksoWgqHrgUu8gMhDjwL23IWS4NqdyBIcWXI
 9e8NtMOL2u3co4K4jVccUgtAg1MpkA1RHpfhPV14akDNOqws1fR2zVINA0JPVyhv5WILFk+
 9D29nixNeriHGYaYWhDz0zuhb/2I95mNrfodMH4Tqn1KH1uk3OS5FCTeU26DtMJecVHU4/T
 Y98shE8XB0nB/vyzrzHmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:me0QRAifX3s=:GKqwmclHm0rv86IcixjA+U
 F7jIqGHzJAvPP1JBW9fqYicmijEnxdK8tMLw+/TQe1s91ykK/u91x0Pn8Jd8NlikV806uHYVX
 FdTuO+JQV8wKOiEm0lS+anxkeULsPT2Qn8daZcXBc8LgMoUIxIKN5FFJ9TGfL0p7ORver5hx3
 Ht3Yes5sNT1Mwc55qLxl+i25xY9VMpJ5L7PBCIYYrbut8cJDaVKDOKFpM+xGNq8jpebp9Pzf7
 MHCSV6OPE95B1ZcR1gAfgMt4tzL770Pxbn+zwwMk1xbZbPVqByKR16VGj38NmZbgdvkpV76YI
 6NxAoEvowtcB+wpsPVDHU1HIPBaFoy2VeSxOeCpFvKxiFnSBDJMKtefI5SAFf5jU0spTbIaum
 ZaEIJj1z3nlTraOuQW3XSV0VuC55KRUh2wvLhPWy+D/FmRUAYyV/YR1bg83irMfBOCHMFqLws
 GkS4EEF0xr4du1wNwQRUI/FIQ6qjaWIGbzYUx9HFhXv/JXCkRkxV5kc9eC5XXBApCPbiHFu5y
 uVuDXP6YvIo0x4Rv+5PFH3/FwJX2rPmuQcV/yErGxPooUHi1rTxDfU5hBgDdmuJ5+fasmcNZ2
 oHHFwJNQ7hLF90xL9VUaEvSDBI11HBlbEJqlj+EmMEspEuMslC/W60tGy0XNgDUeEF0Zkdkzp
 BFbP7oOmyG51wuq5KD7WY7nP09o6KlR01/r1j8SG19hcTgXcDaKTFvfit2B1QWy78JYAx/V+1
 aCS44uZ6KXbRucqz7MUVZ8J+OFJ3JZFrIQXDQCJ/sT4BanVwQ44gsJwuauwxl8yIOOKkRmy6d
 hVZkF9nOwy8EPjME6++ffmQ0xwwdcJNK1XyfNdCgGYj+//gX9GNWe1/8l1QjdFR9b7CWr+AwK
 57wV1pOiAQruQLeiuzMO59euxwq4VPd/7KShBl8djB6baooJAF3Q2Ru+isDT0FpwycFDnmOw8
 8oeuJK+E8qI+BtHgi01si2/TqMtNZWg4rT7Q6xcTus4lNAUGLgSn6nrp8iYBsf3TbMlQHmdD1
 8bm/y7hONFg4LUeQ/RLU0exXxpX0JmhRa+gYhpeYJTk4qOp0ZrnPMT5nJHuVbw4FyNWgcTuxs
 R8azBzbJ9gCqnA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1716208071-1642087899=:2121
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Thu, 13 Jan 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Wed, Jan 12 2022, Taylor Blau wrote:
>
> > On Wed, Jan 12, 2022 at 03:21:46PM +0100, Johannes Schindelin wrote:
> >> > diff --git a/t/helper/test-genzeros.c b/t/helper/test-genzeros.c
> >> > index 8ca988d6216..5dc89eda0cb 100644
> >> > --- a/t/helper/test-genzeros.c
> >> > +++ b/t/helper/test-genzeros.c
> >> > @@ -3,8 +3,7 @@
> >> >
> >> >  int cmd__genzeros(int argc, const char **argv)
> >> >  {
> >> > -	/* static, so that it is NUL-initialized */
> >> > -	static const char zeros[256 * 1024];
> >> > +	const char zeros[256 * 1024] =3D { 0 };
> >>
> >> This diff does two things: add an initializer, and turn the variable =
into
> >> a `static`. The former is the actual fix that is required. The latter=
 is
> >> not. During the -rc phase, we do not want to see any of the latter. I=
t is
> >> unnecessarily controversial and distracting, and can easily be postpo=
ned
> >> until January 25th, 2022.
> >
> > This assumes that making the declaration non-static isn't necessary to
> > fix the warning from SunCC.
>
> Just adding "=3D { 0 }" and retaining the "static" would FWIW make SunCC
> happy here.

Probably moving the `static` outside of the function would do the same,
and would be even more surgical a change.

> > I would guess that in reality it probably isn't, so removing the stati=
c
> > designation is a stray change, and this would have been easier to grok
> > as simply:
> >
> >     -	static const char zeros[256 * 1024];
> >     +	static const char zeros[256 * 1024] =3D { 0 };
> >
> > But to be honest I don't think it is _that_ big of a deal to make such=
 a
> > small change during this point of the development cycle.
>
> We'd also need to change the comment, so:
>
> -	/* static, so that it is NUL-initialized */
> -	static const char zeros[256 * 1024];
> +	/* static, for no particular reason */
> +	static const char zeros[256 * 1024] =3D { 0 };
>
> Which is why I stripped the "static" off it, it was only there as a
> shorthand for doing the initialization, so once we're doing it ourselves
> it makes no sense to retain it for this invoked-only-once test helper.
>
> So I think this patch is good as-is.

That's stating the obvious.

> just adding the initializer would need even further explanation in the
> comment/commit message about the non-sensical end-state. I'm all for
> being careful in the rc period, but in this case I think we'd be
> overdoing it.

If this were the only instance where the patch is larger than strictly
necessary in the -rc phase, I would have let it slide, too.

Ciao,
Johannes

--8323328-1716208071-1642087899=:2121--

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6904C433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 15:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbiAMPjj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 10:39:39 -0500
Received: from mout.gmx.net ([212.227.15.15]:52977 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236167AbiAMPji (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 10:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642088373;
        bh=h90Cg/9N/K0lSTr8/eBKiCYMoNvLhoxVClMryRLEiGM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dGroc9jJsw8tMzSds6TyJIdPEaUVnlVRddGSoH4FCBQ8e7WDv0YnOhE/WygDmYMmc
         CBrfPDUfFSEMnSbp3Y3kgSSnNRNfy98UGARgULo7TY05xbD+ndbDi+/V3uQTV8oigU
         z4nkYvGSnTdDzO7YhrHFGmN0gFcm8o6H5TCmC6Ys=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.174.184] ([89.1.215.56]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1poA-1nAF7k3ysS-002Eww; Thu, 13
 Jan 2022 16:39:33 +0100
Date:   Thu, 13 Jan 2022 16:39:31 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 2/3] reftable: remove unreachable "return" statements
In-Reply-To: <220113.86y23jvrrw.gmgdl@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2201131638500.2121@tvgsbejvaqbjf.bet>
References: <cover-0.3-00000000000-20220111T163908Z-avarab@gmail.com> <patch-2.3-7a6a69314b5-20220111T163908Z-avarab@gmail.com> <Yd3XpLaZ3qc25PzQ@nand.local> <220112.865yqpxge2.gmgdl@evledraar.gmail.com> <Yd8pzOh1HLvDWSPg@nand.local>
 <220113.86y23jvrrw.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-246936595-1642088373=:2121"
X-Provags-ID: V03:K1:kFYuCpJFFvmmNoFY8HMGwKBtR8VPq4B77IKoiNr5gdAQDYphrbL
 feunT8bSwuhDPEQoRumBvjKAGJqiYJ7cXD0YsMMHsIHKgURbEMVl+SXVMelK0wkdUr4GxYL
 YcOlaNYWmhJh7pHJweWs/KlHqWbvG3ugVSJ2YSKk57mlwCh4DNqUFRdQ5BNefsgqUlJASwW
 WWjwLKDesbU4Y2Gp8q0LQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qyUTmcfxzgI=:BN6p8UzptfEouarwM0hFfp
 /OhAQzyGRBboB5+6a+8RZAHmyYN4byZR7RwlUpYWaDimXGGMsCtPf6/koYd5FZHLAkaFgnFGf
 x9P37PE0JPBNCL95zawzFTonsN0YK2CNJ74al8eWHoEck5C43QOSFLod6Pp2YuC9Smr885gS7
 MXVWo1saAzlrj7863opyp/tQ8wb4kJaEe5H+txHhRfIjZrYvbm6S1ztRwkcSims6xvfhhVTIB
 xfIBj1E3iBfMvVDKArv4fCimKRCh1XgVwJit0lxTjZlf5SHRW61jnnydCoJ2IyTtmUGMaRKQT
 OY3kKBnVTldNoHxamfPHFyKUK22rOzCBI+SeEikq6g2aBmFLmJWOj+OqP9oz6HcHO3mUgWCFk
 1Wru1Dw+S2XY5R/Dp5+TqkfyrtFlfTRILm5ePID6Rpad62fyd8QHXIm4FRyHBUzSJGpWZo3cN
 VkUIzaUiQdr05KyVcbZOtIl+0fpUpLq/D56bSqPG4eJQiK4ob9nBP9EhDf0fkedBL5SRq27zk
 Vh9qJ1wsdDOkfy3/YN8WT4sTuWeolGXk0CG0fY8Ia1jgw4N4eE6HH8LFAXBG8qP9RbY94HIoJ
 nx3vBcctmMyWZQDPkPvR7zFiKQKGfKh6EGjovuUIB1GTweA/rYzCu4UZ+5gEZ+2H+nnXghNRK
 pD4RH5d87xE+VZ0YVCxsKBMNSQb2pzGC462suSQ8Dzady53zFId6+54599YHPVvo2zdw6E1SZ
 innG06uX3Eet1upYPLtCuXo9UpSFmeJXlZQAvDXki8+HjKLULDIbKdhtHVNSzVS+AjZsHS2gd
 bpeSi2V0EplFyUTuSaVBjjn+Sc0gZ08nz/0Qp3YUBHo/B0lA9KZQCq8Sq7f+b1l9UdqYlipR4
 u1KSBhWb/CreqCsVEH7ROx0rHbKm6t9VlOnz045zYdEEbySYzbVIj1snoIBjYW1yWksjiVg7k
 aHckQmqme/y7phA5pJpdaztvSoimDQrcRmGijFpZLvwVyiKrJ3KWgU/KXna49xv2VR7uzdjXf
 PV3QpNGr5/hql06W9pC9W/CwyUJkXr9sQFFlBJaPHA7AAUkWh5elH7c9v/PYfa959eQBiA0Pq
 4VVsdjjJzGHAUU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-246936595-1642088373=:2121
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Thu, 13 Jan 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Wed, Jan 12 2022, Taylor Blau wrote:
>
> > On Wed, Jan 12, 2022 at 01:47:40PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
> >> >> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmai=
l.com>
> >> >> ---
> >> >>  reftable/refname.c | 1 -
> >> >>  reftable/writer.c  | 1 -
> >> >>  2 files changed, 2 deletions(-)
> >> >>
> >> >> diff --git a/reftable/refname.c b/reftable/refname.c
> >> >> index 95734969324..136001bc2c7 100644
> >> >> --- a/reftable/refname.c
> >> >> +++ b/reftable/refname.c
> >> >> @@ -132,7 +132,6 @@ static int validate_refname(const char *name)
> >> >>  			return REFTABLE_REFNAME_ERROR;
> >> >>  		name =3D next + 1;
> >> >>  	}
> >> >> -	return 0;
> >> >>  }
> >> >
> >> > In this case the loop inside of validate_refname() should always
> >> > terminate the function within the loop body. But removing this retu=
rn
> >> > statement here relies on the compiler to determine that fact.
> >> >
> >> > I could well imagine on the other end of the spectrum there exists =
a
> >> > compiler which _doesn't_ make this inference pass, and would compla=
in
> >> > about the opposite thing as you're reporting from SunCC (i.e., that=
 this
> >> > function which returns something other than void does not have a re=
turn
> >> > statement outside of the loop).
> >> >
> >> > So in that sense, I disagree with the guidance of SunCC's warning. =
In
> >> > other words: by quelching this warning under one compiler, are we
> >> > introducing a new warning under a different/less advanced compiler?
> >>
> >> I'd think that any compiler who'd warn about this sort of thing at al=
l
> >> would be able to spot constructs like this one, which are basically:
> >>
> >>     while (1) {
> >>     	...
> >>         if (x)
> >>         	return;
> >> 	...
> >>     }
> >>     return; /* unreachable */
> >>
> >> Where the elided code contains no "break", "goto" or other mechanism =
for
> >> exiting the for-loop.
> >>
> >> I.e. GCC and Clang don't bother to note the unreachable code, but I
> >> don't think the reverse will be true, that a compiler will say that a
> >> "return" is missing there. Having a function be just a loop body that
> >> returns an some point is a common pattern.
> >
> > Right, but I'm more concerned about a less advanced compiler that woul=
d
> > complain about the absence of a `return` statement as the last
> > instruction in a non-void function.
> >
> > This is probably all academic, anyway, since less advanced compilers
> > probably have other issues compiling Git as it stands today, but
> > fundamentally I think that SunCC's warnings here are at the very least
> > inconsiderate of less advanced compilers.
> >
> > To me, the safest thing to do would be to leave the code as-is and dro=
p
> > this patch.
>
> I really don't see that, sorry. We have an actual example of a compliler
> that does emit a warning new in this rc on this code, but AFAICT your
> concern is purely hypothetical.

It's just a warning.

So I concur with Taylor. This patch does not need to go into v2.35.0.

Ciao,
Johannes

--8323328-246936595-1642088373=:2121--

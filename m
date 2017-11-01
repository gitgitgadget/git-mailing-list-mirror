Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2403C2055E
	for <e@80x24.org>; Wed,  1 Nov 2017 21:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934301AbdKAVq3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 17:46:29 -0400
Received: from mout.gmx.net ([212.227.15.19]:61588 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934258AbdKAVq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 17:46:26 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M8NBi-1dEM0z3dUA-00vwKJ; Wed, 01
 Nov 2017 22:46:15 +0100
Date:   Wed, 1 Nov 2017 22:46:14 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH 1/2] sequencer: factor out rewrite_file()
In-Reply-To: <20171101194732.fn4n46wppl35e2z2@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.21.1.1711012240500.6482@virtualbox>
References: <6150c80b-cb0e-06d4-63a7-a4f4a9107ab2@web.de> <20171101194732.fn4n46wppl35e2z2@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-799530968-1509572775=:6482"
X-Provags-ID: V03:K0:HLAh1JqolanaDqi0zAYhJMjEjARrfx4vRrgW/btiZcSzN40P0Ab
 389/NdWHbVwL+UIPtgo/oPTuN4vqN0H+5l+tjb8BQQGcSH7PX5eV80i6FLu035SyKuYO9jt
 HEMklgDt8R51pOZwNatnWJA4ySv0gYDUYZGf/x+0mHMvDNnAIkN20CdrCvOvJGcGGiACA9W
 K+2otneJHcvm4JjcEM++g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dt32C9mOhjE=:rod63NN9aH4vaieg/iQU2u
 tQ7CQ14yqaxliUafacgY7keeUZxtJK7KRZejRg6HjoDbxP0+0ExFIU+boFcbfa3jRxZoPR8UB
 UfXGcCXi4bFRVCSWqrnKFWoV26KqXgYUXwTmlpWxlb8QHtW6nG5cZJCWtuWLPbmFH+xXzlaPg
 t4sDim93hFXb39WzYz5xDf+auWhWWUYk1DD/y1doWKfMIzsyt62e3znSMTEOKyN7z/MHD5hda
 209G/rX0inNy+ezNbYZmkXys0/V/JZAxXeE3O0S2XA1kelR+KieNCWCIn/D90uIkl6eYc3xyN
 C7+Jcqw9z3+27IuBdjsh56oxD1O4Klm96WtUL/YvKNr3+Ur+sRVRwe82LLQFL227PD/ab96Lm
 rns7WniRf4zl6LJ3LmRJb4uCcRaUeZxVsOCK27y+0sIGqwBPZCR2NyvK+UucOCvE+Z8v4HJlg
 bMbXIEsSN0EHpFWt7HS/dVddZG58Smg12dean89kLM4+015a7BgYqwdpOQN+LLdRhXOTp3TNg
 PixEHWM8NdTEPzYcC5UG4JJEXNBwSm8dGxzPgWD+LbaMIPrYADTqisTQ5mIFpXqe5k6mGkJYI
 uoZ1OzUf7zVHIrxWQ7fJHP5jeJ3xkW1KO1LZHS2LXsrBuKZM9rDlhG47N3KaG4CDYz60uTwYW
 Sd6STR56awnv4aXV82RnJoByNtI4clSUzv9cyFVMYRFcyFci2u1gz9DTWXDtf9UJ7ZBWcyy4o
 dS8r7kYLhYN93glyTjJSxCJmAZEAeNX29c9wSMO84/RkA2u+XfJan1sdP2Qgs4hbZ36J+/7kx
 O/8r9t1S+a9clppOwhcJ9oHpQrsi3td96mNMd+HkEfesjTb9VA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-799530968-1509572775=:6482
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Peff,

On Wed, 1 Nov 2017, Jeff King wrote:

> On Tue, Oct 31, 2017 at 10:54:21AM +0100, Ren=C3=A9 Scharfe wrote:
>=20
> > Reduce code duplication by extracting a function for rewriting an
> > existing file.
>=20
> These patches look like an improvement on their own, but I wonder if we
> shouldn't just be using the existing write_file_buf() for this?
>=20
> Compared to your new function:
>=20
> > +static int rewrite_file(const char *path, const char *buf, size_t len)
> > +{
> > +=09int rc =3D 0;
> > +=09int fd =3D open(path, O_WRONLY);
> > +=09if (fd < 0)
> > +=09=09return error_errno(_("could not open '%s' for writing"), path);
> > +=09if (write_in_full(fd, buf, len) < 0)
> > +=09=09rc =3D error_errno(_("could not write to '%s'"), path);
> > +=09if (!rc && ftruncate(fd, len) < 0)
> > +=09=09rc =3D error_errno(_("could not truncate '%s'"), path);
> > +=09close(fd);
> > +=09return rc;
> > +}
>=20
>   - write_file_buf() uses O_TRUNC instead of ftruncate (but you end up
>     there in your second patch)
>=20
>   - it uses O_CREAT, which I think would be OK (we do not expect to
>     create the file, but it would work fine when the file does exist).
>=20
>   - it calls die() rather than returning an error. Looking at the
>     callsites, I'm inclined to say that would be fine. Failing to write
>     to the todo file is essentially a fatal error for sequencer code.

I spent substantial time on making the sequencer code libified (it was far
from it). That die() call may look okay now, but it is not at all okay if
we want to make Git's source code cleaner and more reusable. And I want
to.

So my suggestion is to clean up write_file_buf() first, to stop behaving
like a drunk lemming, and to return an error value already, and only then
use it in sequencer.c.

Ciao,
Dscho

P.S.: The existing callers of write_file_buf() don't care because they are
builtins, and for some reason we deem it okay for code in builtins to
simply die() deep in the call chains, without any way for callers to give
advice how to get out of the current mess.
--8323329-799530968-1509572775=:6482--

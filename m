Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 993EB207B3
	for <e@80x24.org>; Thu,  4 May 2017 10:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751572AbdEDKYS (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 06:24:18 -0400
Received: from mout.gmx.net ([212.227.17.22]:61513 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751609AbdEDKYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 06:24:16 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M8ZtH-1e0our1tOl-00wFZa; Thu, 04
 May 2017 12:23:58 +0200
Date:   Thu, 4 May 2017 12:23:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 02/25] winansi: avoid use of uninitialized value
In-Reply-To: <243bb3c1-d01f-f5e5-544e-2ece2a4e5844@web.de>
Message-ID: <alpine.DEB.2.21.1.1705041206030.4905@virtualbox>
References: <cover.1493387231.git.johannes.schindelin@gmx.de> <cover.1493740497.git.johannes.schindelin@gmx.de> <758b5a5dbe83832db7362246127b8bd1ca7beb9f.1493740497.git.johannes.schindelin@gmx.de> <243bb3c1-d01f-f5e5-544e-2ece2a4e5844@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1782443062-1493893438=:4905"
X-Provags-ID: V03:K0:ihGYUi7v3p7tK2I98uxXCvcH1ArPn5qCahgfs9YmKwxmyc/CTkb
 v7UsgUHs1IR8+WZUuqz4LgJkc9Rm/jwaMykBrPOTg5oOW8AKuHrBReI4+ACvzZj0i6JKsjE
 me26cpOjtC5NwGHNjsv0K2y72j2Nx09C1kqvGPdrWKwJ6gUOSZBAAxLb+LsLiHT/POK8ym1
 c0QqzikDC7XmHYZ4y2GNw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/5j5hiqPewo=:lTtxUCJ/epH9WoA9S4Om5S
 cbAIfuT4zmJMGejlBXFGJKK73qHW6hvsZbQVOnuJirOin7PYomwqK+G3olGjL7+TzzUn+mfnG
 ZPuvQCIZsUF9aHGnZxwwFoEGxwymTQNJzT4D8xfAA1McRCFrT3k5uXAaveeTVVRVDe7eEqK2y
 ByYblaLyRA4qEgvr4TdNqLaUzeKyBZy+LDOqlumYo4CvT9cgG1fZv4AglUr11ChkBeim/SyXa
 iKW47puFTEdD7a3Skd0yqh1JQPevtGIe0fA+jdzmoKJ2NMcyNOnXBQjqlV9FXqN8c0tlSFA4Y
 cm/XZ0DesHOqKjCpq/JA3pRUxxBBaCayVSQdiiQQRiusC08IB/j63u9gm9yJMU3Mxzg3iKGAm
 kf60hMexV4dHiBEwIRO8L9Xnj8z1zGET33yvxtm2KBiIKuSvNmuEVDtAOkXXGf/LjwQNZIerp
 upEwib/GDNsj2bbNTU20gqgZn7I5rP8oiFK4MxGxVAwcvMoshFvgq5pVexIiadoZgPBEHtT1W
 P7azeqUE1v/GKc4T28fUv3pbOtnsiioiHTlclilDoCVqOY49oBH18/mOlewZICBfWd0g/J5f2
 kcwjcoaGt6aGjWPWfYUoRMFSKkFRu8d4ZsZI84MtSI61eP5b52wzxLax2ZUMmBHMCZS/T5957
 x2Xn6pFvQLuyEY8//Sy/q++InOlaDA0g71G8sSEbifZhiY/+kM6HEA7wEZd3s2PzEwkxdu5J5
 d3mo/gZwIyJezp/z2SWMmZB/4hfpWjql2mldDmi5/4+Xu9J6dU5tpYK2t+SP1W6P7bEHG90C+
 SnFp3PZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1782443062-1493893438=:4905
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ren=C3=A9,

On Wed, 3 May 2017, Ren=C3=A9 Scharfe wrote:

> Am 02.05.2017 um 18:01 schrieb Johannes Schindelin:
> >=20
> > diff --git a/compat/winansi.c b/compat/winansi.c
> > index 793420f9d0d..fd6910746c8 100644
> > --- a/compat/winansi.c
> > +++ b/compat/winansi.c
> > @@ -105,6 +105,8 @@ static int is_console(int fd)
> >    if (!fd) {
> >     if (!GetConsoleMode(hcon, &mode))
> >   =09=09=09return 0;
> > +=09=09sbi.wAttributes =3D FOREGROUND_BLUE | FOREGROUND_GREEN |
> > +=09=09=09FOREGROUND_RED;
> >    } else if (!GetConsoleScreenBufferInfo(hcon, &sbi))
> >     return 0;
> >  =20
>=20
> So is_console is called with fd being 1 (stdout), 2 (stderr) and 0
> (stdin), in that order.

Correct. I guess this is the important part missing from the commit
message.

Oh, I also saw that I talked about stdout in the commit message, but !fd
tests for stdin!

> If the first two calls abort early for some reason we may end up here.

Yep. "some reason" being: there is no console attached to stdout nor
stderr.

> The added code is for white text on black background.  An alias for that
> combination, FOREGROUND_ALL, is defined a few lines down; for a minimal
> fix it's not worth moving it up.  attr and plain_attr are both
> initialized to sbi.wAttributes.

Exactly.

> That as a bit more complicated than it looked initially.  The order of
> calls is important, "stdout" in the commit message includes stderr as
> well and it doesn't just affect plain_attr.

Right, it also affects the "current" attributes.

> Would a value of 0 (black text on black background) suffice if only
> stdin is connected to a console?  Colors don't matter if there is
> nothing to see, right?

I think that would make it both easier to understand the patch and to
catch regressions in case anybody feels the order of the is_console()
calls should be changed...

This is my current squash! commit (the original commit message will be
replaced by the commit message body of this commit):

-- snipsnap --
Subject: [PATCH] squash! winansi: avoid use of uninitialized value

winansi: avoid use of uninitialized value

To initialize the foreground color attributes of "plain text", our ANSI
emulation tries to infer them from the currently attached console while
running the is_console() function. This function first tries to detect any
console attached to stdout, then it is called with stderr.

If neither stdout nor stderr has any console attached, it does not
actually matter what we use for "plain text" attributes, as we never need
to output any text to any console in that case.

However, after working on stdout and stderr, is_console() is called with
stdin, and it still tries to initialize the "plain text" attributes if
they had not been initialized earlier. In this case, we cannot detect any
attributes, and we used an uninitialized value for them.

Naturally, Coverity complained about this use case because it could not
reason about the code deeply enough to figure out that we do not even use
those attributes in that case.

Let's just initialize the value to 0 in that case, both to avoid future
Coverity reports, and to help catch future regressions in case anybody
changes the order of the is_console() calls (which would make the text
black on black).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/winansi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index 861b79d8c31..a11a0f16d27 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -105,8 +105,13 @@ static int is_console(int fd)
 =09if (!fd) {
 =09=09if (!GetConsoleMode(hcon, &mode))
 =09=09=09return 0;
-=09=09sbi.wAttributes =3D FOREGROUND_BLUE | FOREGROUND_GREEN |
-=09=09=09FOREGROUND_RED;
+=09=09/*
+=09=09 * This code path is only reached if there is no console
+=09=09 * attached to stdout/stderr, i.e. we will not need to output
+=09=09 * any text to any console, therefore we might just as well
+=09=09 * use black as foreground color.
+=09=09 */
+=09=09sbi.wAttributes =3D 0;
 =09} else if (!GetConsoleScreenBufferInfo(hcon, &sbi))
 =09=09return 0;
=20
--=20
2.12.2.windows.2.800.gede8f145e06

--8323329-1782443062-1493893438=:4905--

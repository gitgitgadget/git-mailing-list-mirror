Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CA1C2BA2B
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D26520747
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="I/au/06K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgDGOx4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:53:56 -0400
Received: from mout.gmx.net ([212.227.17.20]:54507 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729097AbgDGOx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 10:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586271234;
        bh=/BsABS273QJMHA/c1M8qhu1+BLvZ8oTRkLgjIDnoEW4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=I/au/06K+N0zZArDQZ/95QHTwIwb2KIjnxG/HqNSTW0ndHsQ0uU4WzwUqMs3MIhjJ
         nDHNmFC36PH/fE5DCp5VPlUZKR1XpfoF84aw8nKHlZkf3+oDKjvccMIPMducPcXpay
         fbzwwCqAkkfMwak7k0efO/AUre/GROD9rr/SRa0U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.212.75]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mo6ux-1iyLm525FL-00paX3; Tue, 07 Apr 2020 16:53:54 +0200
Date:   Tue, 7 Apr 2020 16:53:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] travis: build and test on Linux with musl libc
 and busybox
In-Reply-To: <20200401221835.GH2224@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.2004071651060.46@tvgsbejvaqbjf.bet>
References: <cover.1585203294.git.congdanhqx@gmail.com> <cover.1585474409.git.congdanhqx@gmail.com> <6cf6400f2e0f7336e9b13ddbf412101c4ab48dc5.1585474409.git.congdanhqx@gmail.com> <20200401221835.GH2224@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1233032903-1586271235=:46"
X-Provags-ID: V03:K1:xy5Vlz1esnxwfUZfFf6WnEH9Rf9XtjurUHf7/oejDANaAeWGB2n
 HIuTlhmvFPyj2SUSZSxpy0nVgfJ44NrbikYE6Crpv5FSF11XriLeGzTTJp66V6ZP0iwseim
 LfBydXZ5Tlgq9GCtmR1UtGsfZ3UyO6ixzDoGH4m7HuBQb8Ekql0mKR98CnfwabrmTi4Zu24
 +V7bHgDh17fj9SgB5HzcQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vf6738MVdVE=:3Euv6Ur4EH3FlsIdnVT0UB
 FYz7js+umnygDM54zmZfQXmtHoPLrExSR5iDZy1hiJukTIy/JBbzVa1mlDjxRIkyMiXNyGxxE
 TSUec7Vm5R1nkK6AgM5pVfgUBeCRlulB9W+sWv9ru+zfUe8sYqhPpZo3t2312E0ftq/Iq2f77
 n+IaTiC/8ShzrRNlBwrplJCeTUDWl8BS9WkcJue31lMvVlpMNDrCsaD1WUgHTcHlVuvh2SCku
 6v7pEFg9mnPE5CB280+QeMt545evjGxzAEcjGXASKpS6VEbZmMO6P3kU9D1R/q3NeQrp0ILOI
 w1pLegk5mo73Mr0XqUXjLiK+3ojBN1MyCR7NQ29gd8L44qpWe8FPZgCGb8d8JjOCM5k+o2/14
 GfYHW1Qd+hq/gvef8DySg5BpQKN3fMc/ZA/RZH5eMkXa3RPlSxG97kFsdTAADD3v1Z0ORaRkf
 D/ySdbJGRL5u1Evc9av6M9UNVnC2C5nMsBSesA+prFMEOFIGC9+8IHH4Y5RIBQuI2tATZYyKK
 mQNbmC04DIvgB2tOfKF0mcp+jZcyJU20fyCrx5BhD0A7/BnzK02As409sPT8/gDBdySBHu1Hp
 h4TOEkG7DCQN9Wch3QxhWa0ZGQReLCQDwPOvCq8sZlyq8RvKOcj8L0dZcBO89bZ37LDg1KYdM
 Gn4ccDVvL3LlPi62Z1eoCmC9MUkniXEL83B/VwoXaafGNqdWraPToU78EeZ6NvyAmLH3Tc0y+
 51uu11m7J5+ZgWwjLa/os8iMQznNX07olmq8H2GfNRhtCduHSXABWgbj2ulJ/VYUQrBaFlLLv
 4ulRKBzofEdqFAttkpF/2dJnxusD5FEwhsYK5piv4SCfrdaMcWJIv2xy9P4qT5WRHuuDFfI+N
 VHm786NXJBrbQ9PTk5cklZFvWJroWSpqbG0z/SrY5kvP7XiaEQe45Ne95m+7TbP10VztiXeez
 55R9K4PYl4GpR2Jz9rNC+jnfqZeV+1ThhgeHiNmqhg3zbWtCN+oeNDZy1YJD1G29oxhvP/LhJ
 CHbY68Jb1sPOPdZFepXxVSIDj2Yh1z4I3PCim+ZKsDHJvfksZQ3VlgUMRfb4mKgzUnTMlMv77
 VnrP+q9jPiA1zulArUK1h37qTXySveg1nAbkrJiqbyLcsVvI5vMQ4/eVo4qkVOvz6ZLSar6oH
 H6y2J5QOCtBG6Ax5OtkSpWPLY6PNBGPjNOJpFSAuNVhvHZE2hvv8WotOSzKixwsPSrEH/8ajJ
 R7KX53GzHLuf6nrwKBd7OFRpcBF47XKAfDnarjQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1233032903-1586271235=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Thu, 2 Apr 2020, SZEDER G=C3=A1bor wrote:

> On Sun, Mar 29, 2020 at 05:12:31PM +0700, =C4=90o=C3=A0n Tr=E1=BA=A7n C=
=C3=B4ng Danh wrote:
> > Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@=
gmail.com>
>
> > +	set -ex
> > +	cd /usr/src/git
> > +	test -n "$cache_dir" && ln -s "$cache_dir/.prove" t/.prove
> > +	autoconf
> > +	echo "PYTHON_PATH=3D/usr/bin/python3" >config.mak
> > +	./configure --with-libpcre
>
> The recommended way to build Git is without autoconf and configure.

That is news to me.

My understanding still is that `make` is the recommended way to build Git,
and `./configure` is only for those who want to use autoconf.

It seems that the `INSTALL` file agrees with my understanding:

=2D- snip --

                Git installation

Normally you can just do "make" followed by "make install", and that
will install the git programs in your own ~/bin/ directory.  If you want
to do a global install, you can do

        $ make prefix=3D/usr all doc info ;# as yourself
        # make prefix=3D/usr install install-doc install-html install-info
        # ;# as root

(or prefix=3D/usr/local, of course).  Just like any program suite
that uses $prefix, the built results have some paths encoded,
which are derived from $prefix, so "make all; make prefix=3D/usr
install" would not work.

The beginning of the Makefile documents many variables that affect the way
git is built.  You can override them either from the command line, or in a
config.mak file.

Alternatively you can use autoconf generated ./configure script to
set up install paths (via config.mak.autogen), so you can write instead

        $ make configure ;# as yourself
        $ ./configure --prefix=3D/usr ;# as yourself
        $ make all doc ;# as yourself
        # make install install-doc install-html;# as root
=2D- snap --

If you think that I am wrong, I invite you to change the recommendation by
proposing a patch to `INSTALL`, to change the current recommendation.

Ciao,
Dscho

--8323328-1233032903-1586271235=:46--

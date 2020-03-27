Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48793C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 21:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C906206F2
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 21:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Li6tqdCo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgC0V1C (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 17:27:02 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34966 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727444AbgC0V1C (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 27 Mar 2020 17:27:02 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BB87760489;
        Fri, 27 Mar 2020 21:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1585344421;
        bh=MYb6WwVZAvDvkcbtLOQaVJXgVhV12EmFALUKC4qSv04=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Li6tqdCo7yukxoPJbLCyEKIP4AtXfMUJdSVgyhJos7JSCVGEgnMCv5b6zXcOGQktD
         a+ed2IIRWYmjP6o3Lmkfn3773pjWhdyjY1wBfb7i4vRcLGpsN6f5+thf1vr/L1jkWo
         i8XfkClNc0S9RC19W1ee55hLayJqqeTtaBYDnO5BxNsGiDXb75wli7s/E9CUzYnADv
         OxAUQshqBmzo2SH8HIcgQ+PeeNM0ufwVC35ZvvAvl7cUueZBpf6Ung1CrEOTScw0cz
         7SV5R1c35eK3m2hVJYyDfs4FJN1E6IcEP878cKRJb0TiL9AmFH1lWQ/RQYkzqL8Ud3
         9StDdmnvGVX6Z6Zc2rQpZpPLfcnwPydK3G+cpPgWmwv9iYfXKRFdF0ws2X/bRNc1uT
         83uZUoCekgIxVXPaFY+2L6tp3hrBKvv65+DaUpPlJD4/CICEu5+E6mwQvOVBtF2HQt
         w+5EIzotG/96yLyYurFbt2MGdFmkC1yeobBdZ5/MqIjwSw6uEPN
Date:   Fri, 27 Mar 2020 21:26:56 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?U3rFkXRzIMOBa29z?= <szotsaki@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git svn 2.26.0 segfault on fetch
Message-ID: <20200327212656.GM6499@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?U3rFkXRzIMOBa29z?= <szotsaki@gmail.com>,
        git@vger.kernel.org
References: <CAAr69zbzX=ihOQLZRELWHaC42vs=XtNGkuJ+WhzeWaokPNcfAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="20XocjIeMTCm4X0r"
Content-Disposition: inline
In-Reply-To: <CAAr69zbzX=ihOQLZRELWHaC42vs=XtNGkuJ+WhzeWaokPNcfAA@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--20XocjIeMTCm4X0r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-03-27 at 16:36:56, Sz=C5=91ts =C3=81kos wrote:
> Dear list,
>=20
> When I use a "git svn fetch" on my git-SVN repository it dies with
> "error: git-svn died of signal 11".
>=20
> I tried to get a coredump or attach GDB to it but as I see in strace
> there are signal handlers attached to INT, HUP, TERM, QUIT, and PIPE
> and possibly because of them no coredumps are generated even with
> unlimited "-c" and also possibly because of this GDB doesn't stop on
> SIGSEGV.

Git uses the Subversion Perl bindings and git-svn is written entirely in
Perl.  While it's possible we've broken something, it's probably a
little more likely that the Subversion Perl bindings on your system are
a little broken and that's what's causing the issue.

What operating system are you using?

> What I could do still with turned off ASLR is to run Valgrind with
> children tracking. It gave the following results:
>=20
> Warning: invalid file descriptor -1 in syscall close()
> Invalid read of size 4
>    at 0x9B1A82C: UnknownInlinedFun (atomic_base.h:419)
>    by 0x9B1A82C: UnknownInlinedFun (qatomic_cxx11.h:239)
>    by 0x9B1A82C: UnknownInlinedFun (qbasicatomic.h:107)
>    by 0x9B1A82C: UnknownInlinedFun (qrefcount.h:66)
>    by 0x9B1A82C: UnknownInlinedFun (qstring.h:1263)
>    by 0x9B1A82C: UnknownInlinedFun (kaboutdata.cpp:460)
>    by 0x9B1A82C: KAboutData::~KAboutData() (kaboutdata.cpp:583)
>    by 0x9B1AADC: (anonymous
> namespace)::Q_QGS_s_registry::innerFunction()::Holder::~Holder()
> (kaboutdata.cpp:1041)
>    by 0x4A63706: __run_exit_handlers (exit.c:108)
>    by 0x4A638BB: exit (exit.c:139)
>    by 0x154465: main (perlmain.c:171)
>  Address 0x80cf1c0 is not stack'd, malloc'd or (recently) free'd

This looks like you're loading something with Qt.  Are you using the
Subversion KWallet integration?  Does disabling it make things work?

> Process terminating with default action of signal 11 (SIGSEGV): dumping c=
ore
>  Access not within mapped region at address 0x80CF1C0
>    at 0x9B1A82C: UnknownInlinedFun (atomic_base.h:419)
>    by 0x9B1A82C: UnknownInlinedFun (qatomic_cxx11.h:239)
>    by 0x9B1A82C: UnknownInlinedFun (qbasicatomic.h:107)
>    by 0x9B1A82C: UnknownInlinedFun (qrefcount.h:66)
>    by 0x9B1A82C: UnknownInlinedFun (qstring.h:1263)
>    by 0x9B1A82C: UnknownInlinedFun (kaboutdata.cpp:460)
>    by 0x9B1A82C: KAboutData::~KAboutData() (kaboutdata.cpp:583)
>    by 0x9B1AADC: (anonymous
> namespace)::Q_QGS_s_registry::innerFunction()::Holder::~Holder()
> (kaboutdata.cpp:1041)
>    by 0x4A63706: __run_exit_handlers (exit.c:108)
>    by 0x4A638BB: exit (exit.c:139)
>    by 0x154465: main (perlmain.c:171)
>  If you believe this happened as a result of a stack
>  overflow in your program's main thread (unlikely but
>  possible), you can try to increase the size of the
>  main thread stack using the --main-stacksize=3D flag.
>  The main thread stack size used in this run was 8388608.
>=20
> During stracing I found this line around the SIGSEGV:
> close(-1)                   =3D -1 EBADF
>=20
> If you could tell me how it's possible to attach GDB onto it, I'd be
> glad to provide you some backtraces as well.

You'd need to run something like the following:

  gdb --args /usr/bin/perl /usr/lib/git-core/git-svn <ARGS>

Note that I don't use git-svn and remember next to nothing about using
Subversion, so hopefully any information you provide makes sense to
someone more familiar with git-svn than I.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--20XocjIeMTCm4X0r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXn5voAAKCRB8DEliiIei
gf4OAQDnK9Md2UmehT8lFDaLq8FmqWtvmPM5qeP/QvJdIWltCQEAoRzMsRgcejMo
krQm/+AxVNf045U4Y5/82PgENq1f8go=
=xpiL
-----END PGP SIGNATURE-----

--20XocjIeMTCm4X0r--

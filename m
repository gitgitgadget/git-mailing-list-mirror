Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06ADC433ED
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 22:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99B926109D
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 22:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbhDOW3D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 18:29:03 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33938 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234940AbhDOW3C (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Apr 2021 18:29:02 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id ADF936041F;
        Thu, 15 Apr 2021 22:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618525718;
        bh=U+IoVCW4pgb7UdvAHUYjHNdsWKMMXlLOgkULF1gx9s4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=1NzgEb+OoXS6JXR3ztqUkLFp0hOnNuWNDmKtZ7DyzswzUhvkASTQPKbmAh0cuNrcl
         vlVOlxOG2/cA/PnXU52oxXSSdyPmaBTdfcuz7imcmt/WRpHsyduCiS976gcSNzPP58
         4XyiViJQ3hMAjlphDo4g1O1R7vUjHy3E6AGHf/ok9XlUyfObIxm4ZdBGXSjPj3/BQH
         jZDKs54AFmSVw0jKZGd8PcLAL2Nq/OlqVu0bjropRkKei6iIuCLzf+E53xNKjrLM0v
         9XX7EQqi+JkRX/wh8Tkp2dzMrS9aG1E4o0IdLFDkjVT77rqibwwdXCahLcMW6+TLpU
         Rw17qzLJ+wCg0yIaUI77/6evWpLPKCwMwUZqhc5jvYHJxsDx9NJLtdOjcLYLdEk4lb
         Q55ZJdm99CQF/Eevnpuew5G23b/fKDfj0V5g5ZfNEObSDmuvM+ehwUIWh+//hZJVJ1
         YDJ1yyCpBp3ei5Qnf6T9ZM3Uk21BUza5DKEbXx4LEgd+jDnjCmN
Date:   Thu, 15 Apr 2021 22:28:32 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Ed Maste <emaste@freebsd.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2] hooks: propose project configured hooks
Message-ID: <YHi+EJwmAmmU0Ar+@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ed Maste <emaste@freebsd.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        git mailing list <git@vger.kernel.org>
References: <pull.908.git.1616105016055.gitgitgadget@gmail.com>
 <pull.908.v2.git.1616723016659.gitgitgadget@gmail.com>
 <ec031dc8-e100-725b-5f27-d3007c55be87@gmail.com>
 <CAMbkP-S-9cccMpU4HG0Wurqap-WkTmD2zk50nKd9kJ_oWO__qw@mail.gmail.com>
 <YGzrfaSC4xd75j2U@camp.crustytoothpaste.net>
 <87tuoijzsy.fsf@evledraar.gmail.com>
 <9af3770f-204b-253b-d7f2-c9d5e7cf2fdb@gmail.com>
 <CAPyFy2A25EApYOivqhD_-sUNpep9c98DXHh0tXLd7T17qQLFLg@mail.gmail.com>
 <xmqq7dl3qqrh.fsf@gitster.g>
 <CAPyFy2Bf8t_2HggKG7LMY4u=9qBJ0-+xcx-gCv_kh7KYHg1-hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6Apb7GJ2bKyEZsem"
Content-Disposition: inline
In-Reply-To: <CAPyFy2Bf8t_2HggKG7LMY4u=9qBJ0-+xcx-gCv_kh7KYHg1-hw@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6Apb7GJ2bKyEZsem
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-15 at 20:37:54, Ed Maste wrote:
> On Thu, 15 Apr 2021 at 15:41, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Ed Maste <emaste@freebsd.org> writes:
> >
> > > On Thu, 18 Mar 2021 at 21:29, brian m. carlson
> > > <sandals@crustytoothpaste.net> wrote:
> > >> > +* Works across Windows/Linux/macOS
> > >>
> > >> Git supports other platforms as well.
> > >
> > > In particular, FreeBSD is an example of a platform that is not in the
> > > above list, but included in Git's CI. Is there an explicit list of
> > > supported platforms (and perhaps a notion of support tiers)?
> >
> > It is not like there is a Git company who employs developers to
> > support certain platforms.  This is the mailing list for the open
> > source development community for Git, and Developers come and leave
> > over time [*].
>=20
> I'm sorry that my query wasn't clear; I have no expectation of Git
> volunteers providing support (in the commercial sense) for any
> particular platform.
>=20
> What I am interested in is the Git community's expectations around
> platform support, with respect to new features, changes that break one
> or more platforms, and similar. I submitted portability improvements
> for FreeBSD, and certainly expected that if a change introduced a
> regression on one of Linux, Windows, or macOS it would not be
> accepted.

We don't have a fixed set of supported tiers like, e.g. Rust.  We have
CI for some platforms, and we have people who routinely run Git,
including RCs and development branches like next, on various platforms
and report back.  If something breaks CI, obviously you are expected to
fix it, and if someone says you broke their platform, you are expected
to unbreak it (for open source systems like FreeBSD where you can spin
up a VM) or at least work with the interested party to unbreak it.

Otherwise, support is best effort.  While I don't use FreeBSD, I'm
reasonably aware of what functionality it does and doesn't support, and
I'll try to avoid inserting Linuxisms into our code.  Similarly,
sometimes people ask us to support some obsolete OS which doesn't have
security support (e.g., CentOS 5), and sometimes we accept patches for
that.  (I am personally opposed to supporting systems without security
support, but other developers feel differently.)  We will generally
accept reasonable portability patches for most OSes with little fanfare.

Developers often will CC maintainers of specific OSes (most often,
Windows) if they want to make sure that the patches being proposed meet
that platform's needs.

I have broken macOS in an edge case in the past due to its
case-insensitive file system behavior, and nobody noticed until the
release.  Since our testsuite lacked a test for that case and nobody
running macOS pre-releases on a regular basis hit that case (two files
in the repository differing only in case) and complained, it got shipped
broken, although we did promptly fix it.

That's the kind of support level we have.  Basically, we do our best,
and if there's a problem and someone shouts, we'll fix it.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--6Apb7GJ2bKyEZsem
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYHi+EAAKCRB8DEliiIei
gZ2VAP0aqG0Es0qebFfKEZ1GmrDlpEE3BfXNkRVGjZ7v8JVdXQEA5GlMiGJfn91l
PbHYpuO8Aaz8MN0J3WAmFh78ZdJbawc=
=r/Ua
-----END PGP SIGNATURE-----

--6Apb7GJ2bKyEZsem--

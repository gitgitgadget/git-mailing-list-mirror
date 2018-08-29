Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D30E11F404
	for <e@80x24.org>; Wed, 29 Aug 2018 23:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbeH3Dyb (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 23:54:31 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38418 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727191AbeH3Dyb (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Aug 2018 23:54:31 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0AA6360428;
        Wed, 29 Aug 2018 23:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1535586909;
        bh=ub0kJRKuRvA6/ubzRJKImx/iVXg4t15pktlp2C/N9B8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Ny9s4ahWibp7AS06h7WH9C8zlQBwpCuydJpo0DxciNLOAQDhIlQenWNzLwKIhMzlP
         XCZZDt6Os8dkkY1uzw9yVPztw4KxhMD0zz9hGad5WQTBMS5a/AP7+G/d2kIo9MYdfU
         s+2jIoMLS7QWIfvQ/t7hwO1LpjYgQ4qs+kJ/r5v01S+WaLnpk5ddNf3iyfl9b1ZE9k
         1wAPfsmfcRJbmiRZwJNKlOyjsenK26SrQuQHLfGdOcwUDECsbvSTCA2wv/yPc4vjzX
         rHYpSP6s9RcDoiV0K8hU1f+pxOclqj9clsAX6RIqtQhYA7XYkRwQrniOnCFszO5qoH
         W1VJdrdcIFVS4A+cCJmTc/6alT422+1hgccT8SOqTFkIUMNULU6+HrMazAN9QNAWvE
         mYAx+zU34fj1iJwT5dfTB1+ZEu326r0/2Al2Rosap6S3xxPPNKAig+ZdTkjEt95HRg
         ZNz5gQXM/vpwvZGeMZ/IV3V/hUbLL8gJBwAB7KWOsn/LDjYZLL6
Date:   Wed, 29 Aug 2018 23:55:04 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 09/12] Add a base implementation of SHA-256 support
Message-ID: <20180829235504.GH432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
References: <20180829005857.980820-1-sandals@crustytoothpaste.net>
 <20180829005857.980820-10-sandals@crustytoothpaste.net>
 <875zztecx3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y9PDtDHaFrXNoMPU"
Content-Disposition: inline
In-Reply-To: <875zztecx3.fsf@evledraar.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--y9PDtDHaFrXNoMPU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 29, 2018 at 11:32:08AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason wrote:
>=20
> On Wed, Aug 29 2018, brian m. carlson wrote:
>=20
> > SHA-1 is weak and we need to transition to a new hash function.  For
> > some time, we have referred to this new function as NewHash.
> >
> > The selection criteria for NewHash specify that it should (a) be 256
> > bits in length, (b) have high quality implementations available, (c)
> > should match Git's needs in terms of security, and (d) ideally, be fast
> > to compute.
> >
> > SHA-256 has a variety of high quality implementations across various
> > libraries.  It is implemented by every cryptographic library we support
> > and is available on every platform and in almost every programming
> > language.  It is often highly optimized, since it is commonly used in
> > TLS and elsewhere.  Additionally, there are various command line
> > utilities that implement it, which is useful for educational and testing
> > purposes.
> >
> > SHA-256 is presently considered secure and has received a reasonable
> > amount of cryptanalysis in the literature.  It is, admittedly, not
> > resistant to length extension attacks, but Git object storage is immune
> > to those due to the length field at the beginning.
> >
> > SHA-256 is somewhat slower to compute than SHA-1 in software.  However,
> > since our default SHA-1 implementation is collision-detecting, a
> > reasonable cryptographic library implementation of SHA-256 will actually
> > be faster than SHA-256.  In addition, modern ARM and AMD processors (and
> > some Intel processors) contain instructions for implementing SHA-256 in
> > hardware, making it the fastest possible option.
> >
> > There are other reasons to select SHA-256.  With signed commits and
> > tags, it's possible to use SHA-256 for signatures and therefore have to
> > rely on only one hash algorithm for security.
>=20
> None of this is wrong, but I think this would be better off as a simple
> "See Documentation/technical/hash-function-transition.txt for why we're
> switching to SHA-256", and to the extent that something is said here
> that isn't said there it could be a patch to amend that document.

I can certainly shorten this somewhat.  I wrote this back when there
wasn't a consensus on hash algorithm and Junio was going to leave it to
me to make a decision.  I was therefore obligated to provide a coherent
rationale for that decision.

> > Add a basic implementation of SHA-256 based off libtomcrypt, which is in
> > the public domain.  Optimize it and tidy it somewhat.
>=20
> For future changes & maintenance of this, let's do that in two
> steps. One where we add the upstream code as-is, and another where the
> tidying / cleanup / git specific stuff is wired, which makes it easy to
> audit upstream as-is v.s. our changes in isolation. Also in the first of
> those commits, say in the commit message "add a [libtomcrypt] copy from
> such-and-such a URL at such-and-such a version", so that it's easy to
> reproduce the import & find out how to re-update it.

Doing what you suggest basically means importing a large amount of
libtomcrypt into our codebase, since there are a large number of reused
macros all over libtomcrypt (such as for processing a generic hash and
for memcpy).

This isn't surprising for a general purpose crypto library, but I did a
decent amount to change it, condense it into a small number of files,
and make it meet our code standards.  The phrase "somewhat" may have
been an understatement.

This is also why I added tests: because I'm human and making a small
change in a crypto library can result in wrong output very quickly.

> Is this something we see ourselves perma-forking? Or as with sha1dc are
> we likely to pull in upstream changes from time-to-time?SHA256 obiously
> isn't under active development, but there's been some churn in the
> upstream code since it was added, and if you're doing some optimizing /
> tidying that's presumably something upstream could benefit from as well,
> as well as just us being nicer open source citizens feeding
> e.g. portability fixes to upstream (since git tends to get ported a
> lot).

This is a permafork.  We need a basic SHA-256 implementation, and this
one was faster than the one I'd written some time ago.  Similarly to the
block-sha1 implementation, I see this as something that we'll be
shipping forever with little updating.

I expect with the amount of changes we're making, they're unlikely to
want our code.  Also, any changes to our code would be under the GPLv2,
which would be unappealing to a public domain library.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--y9PDtDHaFrXNoMPU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAluHMlcACgkQv1NdgR9S
9otHeg//U4V44y6Txv3SHBw5g6VlZzYoqQH4OMqREIZgt1brm4ViHh4N2xUt626R
lSv7pFqVzTuucrEl5A3jNBYznBVTcRIF20PIHWOc5/jjSG/zW1QFsEDQAyv5rPrQ
DCNxDBzTBfkdg1HUA5DjEnxhK01HyqOTq9bWHISud0jB3E6Fcrf/PhhVAa6r6ONt
kfuOt10uKiJQJ4XBtUZc1fp+ShAU+wue0HxI0A85+L/hiE8dc4vm1XtCXNKUhOoZ
c+cXabXIdmOktqjVBZhJjow5o+WQF+IWATG3TBusfXmvFCAX+A4G9qbX8y2vNwCl
YZYo3/GnjYNsp3TuRSMWh94blKC78axnnrsBtgUv9Y50vWJ54divNM8aPtl2MaLZ
9Ig7xFKmC55aZJc7Pp2mAu1/SWH/jEkTuO0WEV38grYJb+12nV5SIwYH2U09R9T6
QbAljv57ilvzgxgkAPk7aeIsB1FONragORGZS3FEDUrLoID2aFbgfUCQK3Usir0k
AytS/yOKLp4wTucDDN76QgiONOzYuipMqxd6C7hvky7e3UhtZiZUn+h8hSGE5VzP
eShatTuo37aTTOpumPHyhl6iQkKobzB1PNMlnu9vj7gUKmLoCLjXaJDhErf3/9sz
XTvpgyX14uTZfyMpWN2g2miS3i8Rf4mOU/+mMgLvpUAzL9PMj1g=
=M50O
-----END PGP SIGNATURE-----

--y9PDtDHaFrXNoMPU--

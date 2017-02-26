Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D217D2022D
	for <e@80x24.org>; Sun, 26 Feb 2017 17:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751231AbdBZRjW (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Feb 2017 12:39:22 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:41158 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751154AbdBZRjR (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Feb 2017 12:39:17 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:f8da:200e:3546:3090])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 945A8280AF;
        Sun, 26 Feb 2017 17:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1488130734;
        bh=R3q7N3Mj62BhiX+BAuczUMsrVQMmpVRW3HsRbpZ9NIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1dtEo03JIkupaV2mBmgtWBJi+dEgBHorzVlENez4MvCmHb0Ai4TCLCxeLUqwSIDDA
         bkcafdCBrgb91aOhz5feXQ6ECXnWDFUISE+48JJoRbzDALK1I8eG+HvKkTJRXe648N
         KkcWwAdviaBrENtRL4bstb9fHSuQs9kRBv+lRd8HtCybs3mQcJxWa+/Lg7tZBjTt4v
         j7SUKrrPZEJtvvsBYmJGyRI3yWOZFzoteRBINJnnvxahOLFlKVDN/KaBYcJokEA6rn
         GuofClTVIpb6MDODybmBcn8qztt+S3Pk1qs9gXctlyXMA5mFgl8zq//+cxHLzDens+
         cdVuZAXyiAHxEXOomBiKh4681wyLXjDluGoCtP0H/LVd1JlqitrRrRs+pmsfxsiF1D
         BmxVE63LVhjzfA66NOpCvl6ktODnhvbOipoTykDIMaf/f41libQvegT0I8Tz9jxJWs
         btatWj4vy4IWj7sFbs9p5mnoiwwlK50Fanv5jhCpASNScz8xJaE
Date:   Sun, 26 Feb 2017 17:38:51 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Mike Hommey <mh@glandium.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>, git@vger.kernel.org
Subject: Re: SHA1 collisions found
Message-ID: <20170226173851.wxv7j7zibmzpo726@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Mike Hommey <mh@glandium.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>, git@vger.kernel.org
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <22704.19873.860148.22472@chiark.greenend.org.uk>
 <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com>
 <20170225185050.t6e5txrppofgelsf@genre.crustytoothpaste.net>
 <20170225192655.l5dbzq42cvk5surl@sigill.intra.peff.net>
 <20170225220944.fl7fxirtdtcko4xl@glandium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pbjohda4i2rrkhc5"
Content-Disposition: inline
In-Reply-To: <20170225220944.fl7fxirtdtcko4xl@glandium.org>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--pbjohda4i2rrkhc5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 26, 2017 at 07:09:44AM +0900, Mike Hommey wrote:
> On Sat, Feb 25, 2017 at 02:26:56PM -0500, Jeff King wrote:
> > I looked at that earlier, because I think it's a reasonable idea for
> > future-proofing. The first byte is a "varint", but I couldn't find where
> > they defined that format.
> >=20
> > The closest I could find is:
> >=20
> >   https://github.com/multiformats/unsigned-varint
> >=20
> > whose README says:
> >=20
> >   This unsigned varint (VARiable INTeger) format is for the use in all
> >   the multiformats.
> >=20
> >     - We have not yet decided on a format yet. When we do, this readme
> >       will be updated.
> >=20
> >     - We have time. All multiformats are far from requiring this varint.
> >=20
> > which is not exactly confidence inspiring. They also put the length at
> > the front of the hash. That's probably convenient if you're parsing an
> > unknown set of hashes, but I'm not sure it's helpful inside Git objects.
> > And there's an incentive to minimize header data at the front of a hash,
> > because every byte is one more byte that every single hash will collide
> > over, and people will have to type when passing hashes to "git show",
> > etc.

The multihash spec also says that it's not necessary to implement
varints until we have 127 hashes, and considering that will be in the
far future, I'm quite happy to punt that problem down the road to
someone else[0].

> > I'd almost rather use something _really_ verbose like
> >=20
> >   sha256:1234abcd...
> >=20
> > in all of the objects. And then when we get an unadorned hash from the
> > user, we guess it's sha256 (or whatever), and fallback to treating it as
> > a sha1.
> >=20
> > Using a syntactically-obvious name like that also solves one other
> > problem: there are sha1 hashes whose first bytes will encode as a "this
> > is sha256" multihash, creating some ambiguity.
>=20
> Indeed, multihash only really is interesting when *all* hashes use it.
> And obviously, git can't change the existing sha1s.

Well, that's why I said in new objects.  If we're going to default to a
new hash, we can store it inside the object format, but not actually
expose it to the user.

In other words, if we used SHA-256, a tree object would refer to the SHA-1
empty blob as 1114e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 and the
SHA-256 empty blob as
1220473a0f4c3be8a93681a267e3b1e9a7dcda1185436fe141f7749120a303721813,
but user-visible code would parse them as e69d... and 473a... (or as
sha1:e69d and 473a, or something).

There's very little code which actually parses objects, so it's easy
enough to introduce a few new functions to read and write the prefixed
versions within the objects, and leave the rest to work in the same old
user-visible way (or in the way that you've proposed).

Note also that we need some way to distinguish objects in binary form,
since if we mix hashes, we need to be able to read data directly from
pack files and other locations where we serialize data that way.
Multihash would do that, even if we didn't expose that to the user.

[0] And for the record, I'm a maintenance programmer, and I dislike it
when people punt the problem down the road to someone else, because
that's usually me.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--pbjohda4i2rrkhc5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlizEqsACgkQv1NdgR9S
9ov95BAAh84+PaJU3PigEEHaQKYcHwdYPCsmQhlBd3BvRmvW7+3Im/QkRuJPQ6au
b8fobPjHaG8YBtPs3BxSH6KVdj0CZuA1U571TlfDg/gzp/W9CE1pyGnJf0i5HZRZ
FEkXZQuDGDfoeAIbglcDgYn/mUEdk9jua/rR/HWaU8Nm2U0cbFs3oMMN38VycEN/
5xdU1WVSArXadx0qGmzC4RC4DgdQ5kn08lYciSiFhRfEpycq63LY+ieyaC8v/MFH
NVWZolj6/fWcKDq/ef22VJWTTCvFU7pR7jHRT8UmeXopcCaPEQmnh3qkMUgUn8Sz
MmUEyErM0KQvEfsSQTTV39NmLBz/DYGDxkO7mnYBJ4dG+yApmJxi/nJTNXfH2lP6
fFLCtcJvDeaJggipnzUE7367j486aN5UhVyUe2nFKZKphK8li0sv/cWXfkCNTXeM
2yQBE3sRuUH8dzjPEmJrYuZ81NgYyGky4gsHt5BXA1X18SlZkWX7XF5fIIHxxj9R
JtPUtydWQvvJ1KNokY+JIjkLdE1WOHaAROsOvq4FIdJVshfE2rsUgOEZjV0yXOPT
aujwOl2d+wUDeN1CuZhGCSbyik5KxHg6vyNPqmuNfBxRhuFVyH07XIswt0ExrL1A
wR0gQZ5eST2FxAgQmkowL7RK1B7lDSaV7fXXYqtqnjROZ8EtRec=
=QpQd
-----END PGP SIGNATURE-----

--pbjohda4i2rrkhc5--

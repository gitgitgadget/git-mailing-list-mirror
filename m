Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10F25202A0
	for <e@80x24.org>; Sun, 29 Oct 2017 17:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751536AbdJ2R5V (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 13:57:21 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55658 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751437AbdJ2R5U (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2017 13:57:20 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DED916044A;
        Sun, 29 Oct 2017 17:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1509299839;
        bh=Nz5KNFU6cSV3A+ymds1GQiuqx9fFKZj8RzKHDCBbfzo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=HD9qbANi8mexhYoPliIvvVjsEPtt7cABNppvKChrG/PRvpyXNx9dLU2rOkKCjR8I2
         OS5wvySqpo5iJWTM3xLNEUb4Wv9tqidRB/YcfUB3wMEA9n9ZxA2Y1/yW10sKDVEGnA
         zBMRWJUwJCBB5Tqxz+4rVerMIykXswVy3W3SSEwYjjgUXbSIskrrbtG69nttkS/sMz
         lflnhaTF1x+FkJ0yE1Zi2lfc9SHbBtkn6chKxJRy8m053njBpQYAZrn3lrizQqoOXp
         kXE3QpicrnHWjUqeLVxO6cIX+IL7XYPQyaGsOvwfWKUws/hALXsHoPYfP/JP06vwix
         Ndo+oGaF2LFaC1+E8oJGn/dm8t7b8Smt3lqmy0mS5KwsDAr6eBlMSBCtzFniRPrl+h
         CAheHKRppZD+MpFuHrt642PNDycM4PqAiBvveKPzKm7/IFFUv6AUvj70HVBPoMJd2y
         7FFXlEwc4/6wVQmU4bP0VA6Du7Th2X7hf/UZPRSTKgQaNcp/3dj
Date:   Sun, 29 Oct 2017 17:57:13 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2 3/4] Integrate hash algorithm support with repo setup
Message-ID: <20171029175712.ijqirnghcgeufqae@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
References: <20171028181239.59458-1-sandals@crustytoothpaste.net>
 <20171028181239.59458-4-sandals@crustytoothpaste.net>
 <CAPig+cTrAxWczJ5qX2qE-hqoo6hA2QCom25HYB7v48rVnPgTow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zbmpztbusqvtq2rv"
Content-Disposition: inline
In-Reply-To: <CAPig+cTrAxWczJ5qX2qE-hqoo6hA2QCom25HYB7v48rVnPgTow@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.13.0-1-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--zbmpztbusqvtq2rv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 28, 2017 at 09:44:07PM -0400, Eric Sunshine wrote:
> > diff --git a/cache.h b/cache.h
> > @@ -132,6 +133,8 @@ struct git_hash_algo {
> >  extern const struct git_hash_algo hash_algos[GIT_HASH_NALGOS];
> >
> > +#define current_hash the_repository->hash_algo
>=20
> The all-lowercase name "current_hash" seems likely to conflict with a
> variable name some day; the fact that it is also a #define makes such
> a collision even more worrisome. Although it is retrieving the "hash
> algorithm", when reading the terse name "current_hash", one may
> instead intuitively think it is referring to a hash _value_ (not an
> algorithm).

I can do CURRENT_HASH_ALGO or CURRENT_HASH instead if you think that's
an improvement.  I originally omitted the "algo" portion to keep it
short.

Alternatively, we could have a current_hash() (or current_hash_algo())
inline function if people like that better.

> >   * Attempt to resolve and set the provided 'gitdir' for repository 're=
po'.
> >   * Return 0 upon success and a non-zero value upon failure.
> > @@ -136,6 +141,8 @@ int repo_init(struct repository *repo, const char *=
gitdir, const char *worktree)
> >         if (read_and_verify_repository_format(&format, repo->commondir))
> >                 goto error;
> >
> > +       repo->hash_algo =3D &hash_algos[format.hash_algo];
>=20
> Should this be instead invoking repo_set_hash_algo()?

Yes, it should.  Will fix.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--zbmpztbusqvtq2rv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.1 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAln2FngACgkQv1NdgR9S
9ovuKA/+JBrXUn9jIHjDTGt8muYugD7v8ZTPSNu559QWADDze7n4YPQFURNNCpYG
tFQgqk77A02y/zqhAwZN0HTk1Sd5LePaBcG94/nSoTjKvIgAsuS30GdGTfPTNB5y
Isyl7NRpGmhkorMArrLtts4hRdK4/aE6xT9gG5fREoXZrbWBkIsoL84MMRukL1rw
wKAcZEw6tTHCvEqApGUlIPVdRLoyOu3kB0uI8/IjNHcNI3ocDg1BkCmur04fPv05
2+skchM1tg3bPGZsQlM0SCOtYR+mp/xI6V6/hb7kDgVhJeJHcQEk+OKtC9tT+sHw
c0JZmlmG0jRRG1ugLqPFRWvhVfkeWyY9Ai/yEXTpDU7H99qN+SGDtinlHz88RRxe
hoK8hGaDiEKkA1inJrCi7pVctQ7lwFYKxCvYU4qusFejiwKtZ4C93vZIqUaees5x
i+q5IOUnDmetQ6IVsVpbYwDv2C/kuPU5BYwW83JCXEwCcxPXaAsOeKwccA4xZOCW
hEZq5mAts3jtI5wQf/dbRn1sfUioR/4wRQsU1KA22aO0KWxH6LE8gc5ztSJrg7yd
8wXz38ucnltZU1HOh1qa0p150l2IATnfMiidOdC+TeA5TDHBclcirYLbwyW5Rw3c
O4c/gZyR7OY9t5hr9IETFj21fZsIQWkYFbdcFKUsqx1BRoBHx20=
=HTZp
-----END PGP SIGNATURE-----

--zbmpztbusqvtq2rv--

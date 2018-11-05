Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1703A1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 04:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbeKEN1I (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 08:27:08 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:57690 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728037AbeKEN1I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 08:27:08 -0500
Received: from pomiot (d202-252.icpnet.pl [109.173.202.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgorny)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 08B9A335C67;
        Mon,  5 Nov 2018 04:09:28 +0000 (UTC)
Message-ID: <1541390965.763.2.camel@gentoo.org>
Subject: Re: [PATCH 2/2] t/t7510-signed-commit.sh: add signing subkey to
 Eris Discordia key
From:   =?UTF-8?Q?Micha=C5=82_G=C3=B3rny?= <mgorny@gentoo.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Date:   Mon, 05 Nov 2018 05:09:25 +0100
In-Reply-To: <xmqqo9b4l4a6.fsf@gitster-ct.c.googlers.com>
References: <20181104094710.27859-1-mgorny@gentoo.org>
         <20181104094710.27859-2-mgorny@gentoo.org>
         <20181104151013.GH731755@genre.crustytoothpaste.net>
         <1541347654.22217.4.camel@gentoo.org>
         <xmqqo9b4l4a6.fsf@gitster-ct.c.googlers.com>
Organization: Gentoo
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-OHcarDjidmU3O4iENH1J"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--=-OHcarDjidmU3O4iENH1J
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-11-05 at 10:08 +0900, Junio C Hamano wrote:
> Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org> writes:
>=20
> > > It's my understanding that GnuPG will use the most recent subkey
> > > suitable for a particular purpose, and I think the test relies on tha=
t
> > > behavior.  However, I'm not sure that's documented.  Do we want to re=
ly
> > > on that behavior or be more explicit?  (This is a question, not an
> > > opinion.)
> >=20
> > To be honest, I don't recall which suitable subkey is used.  However, i=
t
> > definitely will prefer a subkey with signing capabilities over
> > the primary key if one is present, and this is well-known and expected
> > behavior.
> >=20
> > In fact, if you have a key with two signing subkeys A and B and it
> > considers A better, then even if you explicitly pass keyid of B, it wil=
l
> > use A.  To force another subkey you have to append '!' to keyid.
> >=20
> > Therefore, I think this is a behavior we can rely on.
>=20
> I didn't check how the signing key configuration is done in the test
> sript (which is outside the patch context), but do you mean that we
> create these signed objects by specifying which key to use with a
> keyid with "!"  appended?  If so I agree that would make sense,
> because we would then know which subkey should be used for signing
> and checking with %GF/%GP would be a good way to do so.
>=20

No, we don't have duplicate subkeys to be required to use that.  Some of
the tests use explicit '-S<keyid>' to force using the other key; other
seem to use a default key (I can't find a place where the default would
be set, so I suppose it's GnuPG default).

--=20
Best regards,
Micha=C5=82 G=C3=B3rny

--=-OHcarDjidmU3O4iENH1J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQKTBAABCgB9FiEEXr8g+Zb7PCLMb8pAur8dX/jIEQoFAlvfwnVfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDVF
QkYyMEY5OTZGQjNDMjJDQzZGQ0E0MEJBQkYxRDVGRjhDODExMEEACgkQur8dX/jI
EQoODRAA1WYrydz4bZshAXRLDKVv3LULbnS/L1rL13zQBGTxQi+FVPG0chtSkfkQ
FvJdLEOmqbgTWAHa3mp2hAwcpYd0OwrbL+y6IA09ljf0JhC1fiyaAaPCT6yL93W5
yOaP9X+25pAC4qGZVuKqSgHjxKlP1R3vYfZyyVN6JiXpD1PMSrtpeECsQCGXxKHQ
EJLu+R0d7ewUXOQ5+6/Y4j9mP/orqMwbzgNkiEoYEmaLEpXL4kBppjJigvpx5hUg
lLusyvKaUdllcAzzBhlX9OzYcHKXvZRVaYuCELmIdP/ei8b2sHP4ocgqGbGhy18V
xG7ZS2zkGSIypDmo2d1GCSObT6ugOAiJtXJAcObqW/xgwj18Xgq8RqRmd9oKKc5q
/q9vCfRgK6pho4T9LchXbPHmu3KDVoEorak9lMm9g4dRDFGABMo3dZfGuxsCBo0p
aqa+yQEesGmPvWqC7RUBgjrqyrda7DplNOyfILJIU/lxt8G0txb+xsK+dd5E8+bk
OGemFddsBYjDU8i4n+QAC5nVF7mLMdDtlYhGjQPWIw7wBhpMeZBRBfI48yhuX1HX
famkgSYQ2YS0UuvO8QsBA02JLVZ8tN6sxtlS2F3QB+XtoS8bFdDuEQHFsEEmwijq
H0YYFaOI02ucTzxRJEpF0g0iTvefg98zNdZUv0/zJ48DNN0fR+Q=
=jN73
-----END PGP SIGNATURE-----

--=-OHcarDjidmU3O4iENH1J--


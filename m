Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F7E63CA
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 07:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F33BD
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 00:43:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qvYXw-0003I5-1k; Wed, 25 Oct 2023 09:43:20 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qvYXu-0047wN-14; Wed, 25 Oct 2023 09:43:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qvYXt-005pjg-OC; Wed, 25 Oct 2023 09:43:17 +0200
Date: Wed, 25 Oct 2023 09:43:17 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Michael Strawbridge <michael.strawbridge@amd.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] send-email: move validation code below
 process_address_list
Message-ID: <20231025074317.r3sydthautjjsf5y@pengutronix.de>
References: <xmqqzg0oiy4s.fsf@gitster.g>
 <20231011224753.GE518221@coredump.intra.peff.net>
 <b4385543-bee0-473b-ab2d-df0d7847ddf3@amd.com>
 <20231020064525.GB1642714@coredump.intra.peff.net>
 <20231020071402.GC1642714@coredump.intra.peff.net>
 <20231020100343.GA2194322@coredump.intra.peff.net>
 <xmqqil71otsa.fsf@gitster.g>
 <20231023185152.GC1537181@coredump.intra.peff.net>
 <393f598e-c7cd-4dc6-a221-9aed7ffcc2b1@amd.com>
 <ee56c4df-e030-45f9-86a9-94fb3540db60@amd.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eylsgnegh5fvxtj4"
Content-Disposition: inline
In-Reply-To: <ee56c4df-e030-45f9-86a9-94fb3540db60@amd.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org


--eylsgnegh5fvxtj4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Oct 24, 2023 at 04:19:43PM -0400, Michael Strawbridge wrote:
> >From 09ea51d63cebdf9ff0c073ef86e21b4b09c268e5 Mon Sep 17 00:00:00 2001
> From: Michael Strawbridge <michael.strawbridge@amd.com>
> Date: Wed, 11 Oct 2023 16:13:13 -0400
> Subject: [PATCH] send-email: move validation code below process_address_l=
ist
>=20
> Move validation logic below processing of email address lists so that
> email validation gets the proper email addresses.
>=20
> This fixes email address validation errors when the optional
> perl module Email::Valid is installed and multiple addresses are passed
> in on a single to/cc argument like --to=3Dfoo@example.com,bar@example.com.
>=20
> Reported-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Michael Strawbridge <michael.strawbridge@amd.com>

If you do Fixes: trailers as the kernel does, this could get:

Fixes: a8022c5f7b67 ("send-email: expose header information to git-send-ema=
il's sendemail-validate hook")

I tested this patch on top of main (2e8e77cbac8a) and it fixes the
regression I reported in a separate thread (where Jeff pointed out this
patch as fixing it).

Tested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--eylsgnegh5fvxtj4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmU4xxQACgkQj4D7WH0S
/k65sggAr1BB+MXodFhoZoh+rhiJ2QnlP0/kTKdnt9s2plCMZcAe0FeAHu/RPLtc
Z+JBFwCbgv19vRKQdW3TwVkS6uTgInNNqo1LKuiLAXKkgQ4BtPVLgCCs8Matm1pG
PmF+Qgwf6i2oz6vTMgFCJ5A8j5PrQlGPquKEYOsIcHGsCJpkEd+2VEmw02ulLflQ
IV9oCHlWW9l1MWfNzEPjVlyVxPAVavdK9TJl/6hlLSXA97aVS/zAi+hMXB4JVYnt
SWq+rjjVsWAaDC92+7CdBjiP/1HWPVva1eUaQ1kuijc3Rkwvr8qXmOnHUyNGFUeF
Vup1oZ2ct2+PHtLBCi5WcVUhtOmGbQ==
=mfYw
-----END PGP SIGNATURE-----

--eylsgnegh5fvxtj4--

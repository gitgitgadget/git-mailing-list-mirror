Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E8A1C298
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 20:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="CRRpxObo"
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A3ABE
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 13:24:00 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id EC69C5B07D;
	Fri, 13 Oct 2023 20:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1697228639;
	bh=Bm4Sy5+DGih1EvbZMsQAn8MEtO1L+oZo2GN6ybE4wHY=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=CRRpxObo+hCgWdhARBfMqDmXgolswhtyU1FvSiKTIdTNHf1/4eHfrWg+N1zVyaDnT
	 JG0FJGP6nm/8xQ4DvpCIC5FY/FzhOZNJ4YX3pOToe4kTnsoJWgpPQ9i4tFqwR7WOCD
	 q4IQTxhTalDcTgTL2ir3lv7so9cnePG2k6A3JgOzsnAJ62oBw2FZPQahj86lc3fsaZ
	 Wl9XukdvWzLwPkIIxfdh29W1BF/dgubL7MpRPPg+pgRGS+p5Dt323cw8aG9kogh6qV
	 VVGiYjv+k55IJe/IfhGHXFwI5Cc9ymdV0Y/WO9oR4BCE+tAYVKh7J1jsByT4UFm2hV
	 Ux4zP39ibCxSRPyj1MLDx+FwrTB7r+mkxnoulSeg3LAX14iaJmiq+MzoEEIlVSbUSU
	 5Fruz1F2/59rAITyM96BEfAxnSN7bt1zxAI9TtZxmpk7qwF35vTCq+xXMoE0Uzi2Vb
	 weH+PE3/Q5kRYvsdiI56y6cZHwd80dzvjxLFDBOq6QqAa/UVpos
Date: Fri, 13 Oct 2023 20:23:58 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Jason Hatton <jhatton@globalfinishing.com>
Subject: Re: [PATCH v2 1/2] t: add a test helper to truncate files
Message-ID: <ZSmnXpQ3hpLM6Xpf@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	Jason Hatton <jhatton@globalfinishing.com>
References: <20231012160930.330618-1-sandals@crustytoothpaste.net>
 <20231012160930.330618-2-sandals@crustytoothpaste.net>
 <CAPig+cSUvyCS-NOYOoJAmg7LGyU5Dqky5HyS-QTNW1QoHj-0bA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aGr1q8ALYapPhMWX"
Content-Disposition: inline
In-Reply-To: <CAPig+cSUvyCS-NOYOoJAmg7LGyU5Dqky5HyS-QTNW1QoHj-0bA@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--aGr1q8ALYapPhMWX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-10-12 at 17:49:13, Eric Sunshine wrote:
> > +       sz =3D strtoumax(argv[2], &p, 0);
> > +       if (*p)
> > +               die("invalid size");
>=20
> Do you want to check 'errno' here, as well (probably before the '*p' chec=
k)?
>=20
> Or is that being too defensive for a 'test-tool' command?

I don't believe that's necessary.  The Linux manual page leads me to
believe that if *argv[2] is not 0 but *p is 0, then the entire string is
valid, which would imply that errno is not set.  I'm happy to ignore for
the moment the case where the user specifies "" as the argument, because
it is a test helper and "don't do weird, unexpected things with the test
helper without looking at the source code first" is legitimate advice
for Git developers.

If this were user-facing, improved robustness would be warranted, I
agree.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--aGr1q8ALYapPhMWX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZSmnXgAKCRB8DEliiIei
gcEgAP9yDJV4NNoASOe9atGMgiLzm9fEGEhRQ4R5ugV2dlBdlgD+LNDreX6FJiA9
nUWoFXCk651jTz8v4jrQGlf/YYRrRgk=
=2gEz
-----END PGP SIGNATURE-----

--aGr1q8ALYapPhMWX--

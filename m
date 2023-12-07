Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C5v9yDee";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XDsQeayA"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6D4128
	for <git@vger.kernel.org>; Thu,  7 Dec 2023 05:13:22 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 04ECC5C00B7;
	Thu,  7 Dec 2023 08:13:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 07 Dec 2023 08:13:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701954801; x=1702041201; bh=Lo
	a5bse0w9GYCv9RX9VoV4KS80V0kQOwpWu8yvPiXbU=; b=C5v9yDee7QdpBDtvrW
	gB84R5CCQPwHWlJQS6UIKunujXKX7UUCv2dAM9NYVxIla/R3k2vAMGAU3hZtURuv
	wVM7KfRFA6QIeddu0cRzklI5Q5W50Tc+8HVyzv+fv/Zp4xcFM9gUTWSLICGilC/b
	fs28dit4RWY4pQBqvuSIE5LgjrXV9JMZB+TkMxFLS7awUPRg+bYr1RwWgp19++Bf
	g/kz2QJ9v2VfmL7bNFgqkXaApc++mgM6NZgXjDXT/dOZ8zATPpKIS4sC+89jaPsd
	V9+7x/PcBR5ZDMGKyjXwdeApZCDI/CjtFUJPDgo0h7MolZ/IXWRbRGw8rrsQ4Ffz
	k27g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701954801; x=1702041201; bh=Loa5bse0w9GYC
	v9RX9VoV4KS80V0kQOwpWu8yvPiXbU=; b=XDsQeayAMPxfvroyLYMv3XVv7ia2t
	2wAbk7HDQ46Ky4mSusReZ5ipVlC5MBmboXctsbRS6fOTtnGZ9Cxe3Wfn08IsPmru
	l6gpTBEHQwxdUv8xN3Mktyk7/2Dv0Aa5SszhFJr9hOYt5AOenEYVgqhXOotPRGd9
	l5lHD2setBj7cqiftZBni6jJbER9YVVBjSHd8utc6Y0mQMqs04A9md/Q7mXSQ35U
	HG/DjBgsMGcpBkJuhKqubCmSd4zhyVKlD5fRhk7roFgVLDX98T4k1lMPPQ+DR5oa
	oL9JQFTo/n4IcqQxRlnmOvpEitoYX65Smidnjg/80gXMHVqBhA+3nSj2g==
X-ME-Sender: <xms:8cRxZUyXiFoqYFFpEBodAUbjR1Sb6NMaH-c9XKL27Bnm3bY3hRexCQ>
    <xme:8cRxZYTPHO7OTbwK0u0uFOrc9HImFgoYUX1sPD9-ET33rnimBAc9AJbzdF6-z43yy
    ibxOOCwXMjlZjrXUQ>
X-ME-Received: <xmr:8cRxZWVLxQEbbbBb5IO6S5DYvto_Pg-V43d-tfan6f3Sb1AIeXLQWO9cSxmFBZwtyYx2Lyke3e3jyCosIMeBbK4gUULHcQ4M-YRFTx042WYdvXY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekvddghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:8cRxZShEvV4EUP-gL95NETN_lkwehCQlygjYwJ1nbKv7-JKgk5OXqA>
    <xmx:8cRxZWC59SKbuhlCCkV4lgrgElsICQ2C9bB1Fk9rzfBOmrReeP9FBw>
    <xmx:8cRxZTLKkkwFmJsBbbaM1ZYHlwwrG6q5lbFE2m8pw_nc3AUr0s-94g>
    <xmx:8cRxZZOSekcFjJko7Y4BCGse0F0z088rQWPzZA6fZ_qRSBc-WMXzOg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Dec 2023 08:13:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a03f0a26 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 7 Dec 2023 13:11:52 +0000 (UTC)
Date: Thu, 7 Dec 2023 14:13:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/24] pack-bitmap: simplify
 `reuse_partial_packfile_from_bitmap()` signature
Message-ID: <ZXHE7_KwukSRBET1@tanuki>
References: <cover.1701198172.git.me@ttaylorr.com>
 <432854b27c6731bd6ab1fa739b3a086ec0a90be8.1701198172.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lKFgrdXPUokdYIhL"
Content-Disposition: inline
In-Reply-To: <432854b27c6731bd6ab1fa739b3a086ec0a90be8.1701198172.git.me@ttaylorr.com>


--lKFgrdXPUokdYIhL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 02:08:24PM -0500, Taylor Blau wrote:
> The signature of `reuse_partial_packfile_from_bitmap()` currently takes
> in a bitmap, as well as three output parameters (filled through
> pointers, and passed as arguments), and also returns an integer result.
>=20
> The output parameters are filled out with: (a) the packfile used for
> pack-reuse, (b) the number of objects from that pack that we can reuse,
> and (c) a bitmap indicating which objects we can reuse. The return value
> is either -1 (when there are no objects to reuse), or 0 (when there is
> at least one object to reuse).
>=20
> Some of these parameters are redundant. Notably, we can infer from the
> bitmap how many objects are reused by calling bitmap_popcount(). And we
> can similar compute the return value based on that number as well.
>=20
> As such, clean up the signature of this function to drop the "*entries"
> parameter, as well as the int return value, since the single caller of
> this function can infer these values themself.
>=20
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/pack-objects.c | 16 +++++++++-------
>  pack-bitmap.c          | 16 +++++++---------
>  pack-bitmap.h          |  7 +++----
>  3 files changed, 19 insertions(+), 20 deletions(-)
>=20
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 107154db34..2bb1b64e8f 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3946,13 +3946,15 @@ static int get_object_list_from_bitmap(struct rev=
_info *revs)
>  	if (!(bitmap_git =3D prepare_bitmap_walk(revs, 0)))
>  		return -1;
> =20
> -	if (pack_options_allow_reuse() &&
> -	    !reuse_partial_packfile_from_bitmap(
> -			bitmap_git,
> -			&reuse_packfile,
> -			&reuse_packfile_objects,
> -			&reuse_packfile_bitmap)) {
> -		assert(reuse_packfile_objects);
> +	if (pack_options_allow_reuse())
> +		reuse_partial_packfile_from_bitmap(bitmap_git, &reuse_packfile,
> +						   &reuse_packfile_bitmap);
> +
> +	if (reuse_packfile) {
> +		reuse_packfile_objects =3D bitmap_popcount(reuse_packfile_bitmap);
> +		if (!reuse_packfile_objects)
> +			BUG("expected non-empty reuse bitmap");

We're now re-computing `bitmap_popcount()` for the bitmap a second time.
But I really don't think this is ever going to be a problem in practice
given that it only does a bunch of math. Any performance regression
would thus ultimately be drowned out by everything else.

In other words: this is probably fine.

Patrick

--lKFgrdXPUokdYIhL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVxxO4ACgkQVbJhu7ck
PpQ+ShAAqHQI/2wreMPXFHigBwkx0VqLlQJS+2eZHJ2MzrW/a68SqZX8fHg2oE2o
ObP2uHFWYOldp5lLAUpJZlFxktk9OSrmmwu3ZSMcRQne4tQIn0trkeH4Hg1yDpRo
qf8kMO4+qpCRH2VfsVsz+gorb9UAxifuyeeYJsf6OqJ1xw8SjCB05KWR0ojjdysF
781P+M3W0BjJfOqHKw2unYCSSkxRbFYAVfvRNyY35vn1gmUZw41RoNjasRgLAaht
XgfMq4cw0dHHgVrosJ8QxDWi4jIldnDSESbAIhIAy+dERYTgwEhGPCK7dcs3SzeX
ytxpDm3156pU8xUWOt3ZSCNSyNRA4E6OQ2iZ133fS7o4n/3eqduYmwu88pbVwLbS
OcFLCYTJd3bcD2u2jlj/zmmevmTpP81Gw3xH/cjH5qhn5OTgtZDOyz26m5X3f3Nv
7DcUzejx4PsdTD/k8fYlRNdU4h8y4QxzikOXQRHSHkaI7dI/CmGVoUPP16rgi6KU
xkolAUdfu8OKPrhIFF5+iPE2PGDnPfBARTwarlg6cmbiAo/PxG6YBwytTvzI0K0Q
3CzIe0V/k4Wl0yyxtNiw5+JCiRv/N12Go4/reyPHTsOXTeXNkoDlvPqnUUxlDMt9
gfshCHeWmqz9MyjU++1qMpQFtCFQM1yGOBwzeNEIkHsS+H4hFqk=
=xaUt
-----END PGP SIGNATURE-----

--lKFgrdXPUokdYIhL--

Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3363118C2F
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 16:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="CiIECkUU"
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231B3D9
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 09:24:27 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 6352B5B0B7;
	Mon, 30 Oct 2023 16:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1698683066;
	bh=KSqM50QZIdOq1hABTYufb+p9Bei8TD6ThoRZdG/4Eg4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=CiIECkUUm5mi0kiC35ObnivgKJjSiyZXje3VRNMhnsdaK86XP5i9isdgXo5Bd839k
	 pF1BwMIz9AjRyKvk9JTb/GAytpnpP475rOwuVB5fowmT+Lauul0mJWLUgIRMfY/5fx
	 FamClh1l+gWlDgRklBTnnI9zcOZ2QNkKQnfU3LQH54fscfdSPXYY76EZl9Nn35H8Do
	 VODRhsvwa6hHLWkqNxcrcFTltLrikDKH01vbRgxi5obc+19E9UimsJTjcsHUEfoBjm
	 rrfC0bQHylXNvAlu0CbkeL/IprEpNFc13ggQKaTO1iEmiD0uAfhy2IdQPAho4Tw/ud
	 O2YmL/F4EGKlIo37x2f7dXedn3T3c/G47SbWJJJJTFQA7pHplfTXwl1biDGjyKv2pY
	 ONVqnEvURXbWqF9UDMsmd5SC9dDP5dqS4txW15wp8032c+wmQcARVSu0axKj/enNfx
	 uJ5zm3CUJsHsij29V3s8pAu9Wr6o5jPmHaR3QLA7UVh+bQMMG6Z
Date: Mon, 30 Oct 2023 16:24:24 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 0/1] Object ID support for git merge-file
Message-ID: <ZT_YuF4g-8P9fc4t@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
References: <20231024195655.2413191-1-sandals@crustytoothpaste.net>
 <CABPp-BFJn5NsSaaxEMpicqND_-8CBw370kyBQuKHGOX-3PRyMw@mail.gmail.com>
 <ZT/RpqvfQyx+uzxa@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FwN8kvbKk2GuUiJg"
Content-Disposition: inline
In-Reply-To: <ZT/RpqvfQyx+uzxa@nand.local>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Level: *


--FwN8kvbKk2GuUiJg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-10-30 at 15:54:14, Taylor Blau wrote:
> On Sat, Oct 28, 2023 at 11:24:06PM -0700, Elijah Newren wrote:
> > But...wouldn't you already have the conflicts generated when doing the
> > merge and learning that it fails?  Why would you need to generate them
> > again?
>=20
> brian would know better than I do, but I believe the reason is because
> the "attempt this merge" RPC is handled separately from the "show me the
> merge conflict(s) at xyz path". Those probably could be combined
> (obviating the need for this patch), but doing so is probably rather
> complicated.

That's correct.  They could in theory happen at different times, which
is why they're not linked.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--FwN8kvbKk2GuUiJg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZT/YuAAKCRB8DEliiIei
geRWAPsGpIKVqxgDmdyNnTVkmeve0Wtes9aSb7w7Xo3QsHADxwEAvPf+aqxUwnwc
pU5yPD50f5szb1gfHTj4UkKZEzNemgI=
=wF7k
-----END PGP SIGNATURE-----

--FwN8kvbKk2GuUiJg--

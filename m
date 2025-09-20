Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F7A46B5
	for <git@vger.kernel.org>; Sat, 20 Sep 2025 15:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758381793; cv=none; b=m9imnHLHOxCICq1KPGIpXSg4xV0N1jlD4259FHNridsbxO8PvX9WuFiZnXdz1G/S7lRXpwcJSNEBzxd9qNczWk1DBN+Ye/NVVr+Vt4TgBgYranLJC35Ex9lF7OKy3gVhMeqqS4w/X/xQKD4+gTImmZDLSE5estToSkDooXKSo7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758381793; c=relaxed/simple;
	bh=0k3dv45KMK46wOnWT15Wt6sR41OcEAy+WDB+JnXLvs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksxUg1Lx/MmvkkwihzqOqVplQZHSEhVsz+H8b8zrB2F3MJ5kteOV+R6GOXkT6iS1hPXXPRGhLeZsxcn9cu2bT1ULMNfbCjT4mmKFrZ74T42cva8XF93agYb49/GH6kBHIP60q/GY+OIxRWgUA/uhpzFd9sJaakh72TOvn3ZYRdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=bEUUl4M1; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="bEUUl4M1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1758381789;
	bh=0k3dv45KMK46wOnWT15Wt6sR41OcEAy+WDB+JnXLvs4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=bEUUl4M1IV3naemft+EzIPw9BeZoLxQkqmPAnq31oA7HcNCALWwM1Bg6FYXrxqfl7
	 zRdFkQJP6paxe6Klc9aPaBNworQyXoVrseA7glmuuN1DpaIC0m7dFc2EDXWSyyNhx1
	 1kZwW3uiOCSsuzfM4lc1xqiPYjLi/gghJZ/VvnLT4gGSVKmz+Owvf/WBT8u2oozpcj
	 02xD3Jnf9yTnV3M8efFVB+e9ZtwMv/T3pfiBlfSZkxhSY9i8063qh8Qm/HOR4xz23c
	 jow5HQgFqUpIhj5L8E1CiNc1OLTUv/q2cJ2QcWnfWN246hVniMufazRQjTHKF8aPVh
	 Vjct7AO2MdUT65wNCcgNeoDM6syySUB2DNZbk/A/WZD02nTI7PtSfpiDxWfbUakBcY
	 0dfZuOAIOcfXdeCZ969tFl7XHQK9XevWYRED/2WmXX8hf/p4gaj87SY/0xSYCTXZ34
	 KSlWrIKOAfDAxeNn5rX6EZo232JeArHBa5brRwxbLzdwwbxkd+H
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:69d9:2a04:7f4c:de5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4079B20112;
	Sat, 20 Sep 2025 15:23:09 +0000 (UTC)
Date: Sat, 20 Sep 2025 15:23:07 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/9] docs: update pack index v3 format
Message-ID: <aM7G22LJ47nx8Wqk@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>, Derrick Stolee <stolee@gmail.com>
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
 <20250919010911.649831-2-sandals@crustytoothpaste.net>
 <xmqq7bxu14fw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1ZeCwHnC2FWFVOvB"
Content-Disposition: inline
In-Reply-To: <xmqq7bxu14fw.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--1ZeCwHnC2FWFVOvB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-19 at 22:08:03, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > Our current pack index v3 format uses 4-byte integers to find the
> > trailer of the file.  This effectively means that the file cannot be
> > much larger than 2^32.  While this might at first seem to be okay, we
> > expect that each object will have at least 64 bytes worth of data, which
> > means that no more than about 67 million objects can be stored.
> >
> > Again, this might seem fine, but unfortunately, we know of many users
> > who attempt to create repos with extremely large numbers of commits to
> > get a "high score," and we've already seen repositories with at least 55
> > million commits.  In the interests of gracefully handling repositories
> > even for these well-intentioned but ultimately misguided users, let's
> > change these lengths to 8 bytes.
>=20
> Very sensible.
>=20
> I do also agree that 32-byte is the natural size for the trailing
> hash, but I found that the two paragraphs below was far more than
> necessary.  As they argue, we use a truncated hash anywhere in our
> file formats, so I would have understood if the explanation were
>=20
>     "20" in "A copy of the 20-byte SHA-256 checksum" is an obvious
>     typo, as SHA-256 is longer than that.  Fix it to "32".
>=20
> instead of these two paragraphs.
>=20
> Or did we mean to use a truncated hash back when this transition
> design was proposed originally?

I think we intended to use a 20-byte value originally because we felt we
didn't need the full 32 bytes for an index or pack checksum.  However,
as I mentioned, we use the 32-byte checksum for SHA-256 already, so all
it does is add complexity to try to mandate a 20-byte value.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--1ZeCwHnC2FWFVOvB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaM7G2wAKCRB8DEliiIei
gREyAQDwOAqNzm5fczeOaLdRY1unlrUOoyT8FT6SSGdr0CC+SwEAwYxgCNhpr/jM
agY16cGGeUHA01cXtgSNx21Y6d/8Wwc=
=4z9w
-----END PGP SIGNATURE-----

--1ZeCwHnC2FWFVOvB--

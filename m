Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA5B2253FE
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 22:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754951031; cv=none; b=jcKUZWPKfwKfdMplEscGEUuH/X9B/ggsEI/bZSlF+tKm+WCA4kdRWJ3XwQR/889I3Ny6cUQw9GqlV0QqP//gqtdkyGSbVwcZe+YyERyULNOwShZENXaEQQG0Ik5YO5ISKVQUuwxmq3O35oUTQek1vhx8JIp7ayM/3KEA3yqNGSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754951031; c=relaxed/simple;
	bh=tZznFiJxNb0s0/Vp/LPLsLWHwL4Ngzi1zONmdmHt86k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhUQE3gjKTnIPMBGgEDsWVgamiPu12iuax76Tj0kKWfR5PGYvXwa0Z6fXyljaqXxzpvc01Fvy/FZWVH1Vhy+LEYVnkHBJd265xLpIsPb8x6T+0Y8+gaFZNeswcIV4q/TRcteaDC6Yb21IR7fcykj+OxcdjwNfKdgf1XIMDTcres=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=pvAp31aj; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="pvAp31aj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1754951027;
	bh=tZznFiJxNb0s0/Vp/LPLsLWHwL4Ngzi1zONmdmHt86k=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=pvAp31ajiyWgaseaOUVhYAvJs35UaHMKdUj4HWzcxjbeZE0hW+SRIouZN8nFXqz02
	 vrbvaWduvG4jQXQoZaJKmRM4l12FiEdoIhD3VEh8tsBX0gpQBcgeR9keS95vA8+rvb
	 Pl6kMKC2XRqCNwgEOLW/yrdVOEr81D58af94ycyiWA8oKSZ25VWFAr52Xr5HRW9HAM
	 /ieyKqBSyLRZznQ42WJThJKdmuC21/T7lp3UMC9VEuyQJr3USksbslhaojxhvft7U1
	 OY12jTvq+j6zHSdO1t9zTQ0wlv2IEnOngvF4b8fajQ+3AlBORNGfPXr/UYfImg06Ao
	 L+W+wYYO8lKgIG7yboUldrqMv10QNpLxERJaYFbi1flFoolp4ngiW34uiXO/lclAUM
	 A6lRoESDhF5I1QUVvIoE52z2q/FQbSuqljlwbfgGRolALhX516CHThxkJ9VGr1bAkU
	 NvEp8OOUZXWlutnamuTO3LWrmP1IdfzCyANZ8fgWyhDSNo84xBu
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:bbea:a384:d97f:8068])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B5EDF20073;
	Mon, 11 Aug 2025 22:23:47 +0000 (UTC)
Date: Mon, 11 Aug 2025 22:23:46 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jon Forrest <nobozo@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] abbrev: allow extending beyond 20 chars to
 disambiguate
Message-ID: <aJptcgwQmwIbnrqE@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jon Forrest <nobozo@gmail.com>, Derrick Stolee <stolee@gmail.com>
References: <xmqqfrdx517b.fsf@gitster.g>
 <xmqqzfc51xvk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BYY1ZvBZLZ025aK/"
Content-Disposition: inline
In-Reply-To: <xmqqzfc51xvk.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--BYY1ZvBZLZ025aK/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-08-11 at 19:06:39, Junio C Hamano wrote:
> diff --git a/object-name.c b/object-name.c
> index 11aa0e6afc..8f9af57c0a 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -680,6 +680,7 @@ static unsigned msb(unsigned long val)
>  struct min_abbrev_data {
>  	unsigned int init_len;
>  	unsigned int cur_len;
> +	unsigned int max_len;
>  	char *hex;
>  	struct repository *repo;
>  	const struct object_id *oid;
> @@ -699,12 +700,12 @@ static inline char get_hex_char_from_oid(const stru=
ct object_id *oid,
>  static int extend_abbrev_len(const struct object_id *oid, void *cb_data)
>  {
>  	struct min_abbrev_data *mad =3D cb_data;
> -
>  	unsigned int i =3D mad->init_len;
> +
>  	while (mad->hex[i] && mad->hex[i] =3D=3D get_hex_char_from_oid(oid, i))
>  		i++;
> =20
> -	if (i < GIT_MAX_RAWSZ && i >=3D mad->cur_len)
> +	if (mad->cur_len <=3D i && i < mad->max_len)
>  		mad->cur_len =3D i + 1;
> =20
>  	return 0;
> @@ -864,6 +865,7 @@ int repo_find_unique_abbrev_r(struct repository *r, c=
har *hex,
>  	mad.repo =3D r;
>  	mad.init_len =3D len;
>  	mad.cur_len =3D len;
> +	mad.max_len =3D hexsz;
>  	mad.hex =3D hex;
>  	mad.oid =3D oid;

This definitely looks more sensible, since we're using the algorithm
specified in the passed in `oid` variable in
`repo_find_unique_abbrev_r` to determine the length.

I will admit that despite having touched this code recently in my
SHA-1/SHA-256 interoperability work, I'm definitely not an expert in
this area, so while I don't see anything that stands out to me as wrong,
you probably will want someone else to verify here.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--BYY1ZvBZLZ025aK/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaJptcQAKCRB8DEliiIei
gXDhAQC2krQlavlHVFiT3l+tA9iXtoKD2jePqfgIVX7PFLTr4QD/bsIfvCc2FvO8
mYsvTawfPzmrwoV20bD4l/eotbvxCwA=
=qCui
-----END PGP SIGNATURE-----

--BYY1ZvBZLZ025aK/--

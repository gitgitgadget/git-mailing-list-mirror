Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B525374171
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 23:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769728332; cv=none; b=b9qajAEQnzv1b3/nVkH1M7bt2vORdszF34L14QF1d1MGQyyU77MIUsyjG9F36c4s+tSzIZ/+zqJgsNB1x/ZQL7CkmqHgLhoKQ5IAG562rcXcwkiyVqL/WKytib3PQwXYn7De6WgJPl3zCT3MOY66vsduxEM37VNf3IK4Z/j65m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769728332; c=relaxed/simple;
	bh=gX9IBTujx02UlP662P2lXSyH38pQzB/0NXs+K7D64RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLRW/0xkJYmxhozbf6uDziwZT6kQqRxcAFX5z8Q4fKu6r/74T8uWpoUm+HKi/xWMH0LBQ1SkukSSryQle3DFjLRpiPmnohh4HrL9t3lt5y9HPseiqWwTGEpK8s1/+DzW+Prf04zK3v96VeCedKYbVGH0ZVrdV+IvRdahC8Czqyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=BnGV4lhQ; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="BnGV4lhQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1769728330;
	bh=gX9IBTujx02UlP662P2lXSyH38pQzB/0NXs+K7D64RE=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=BnGV4lhQD+XJ6OXhATYeBc9Yege5IOhtazNc18GzBZDOGHz2mdIdbWflXkXyzv6uO
	 ROkZNrbsoMDrwWxyY82235zMbCpOiMSuaGNNnAytPRaCgLHXqbt6dor97agH4YEwyy
	 qlZ3+0DROS5zTFpPF9pkDTxlBV5uFYAprBJtRP6c50FDJsTlpoZJvAq8RsVUOKlB+j
	 4KD7Spznt+QcMqNHISFeH+7qAmHb7mrphJlUqBO6PuUI6eRSt8QRIhsdrX82Ib+05g
	 +8Nuw1Fy8T/2FQmgCj41gPgE8FApoCDcygk4Mt+hb8VB2AIkpJoz9lmLZIVCFSTE6l
	 mITdP2JRVYf95TTRCjTC5lRv1nJnxdullLmTbKp2YafPBLL77d1MCSdtatB2JidK+m
	 m799lJcbJLQ2GQOZT4EB+diO454aJKv+4Po+t9iOzP1ZH2fUcXHfs+FSIvXGPGh31L
	 J5tMI1BAw3hk+kP8InhgVsOTyH1PI/NZSTGVyS34XImanJAC7fW
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:bf0d:4ae6:75ea:91b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 21D5E200B4;
	Thu, 29 Jan 2026 23:12:10 +0000 (UTC)
Date: Thu, 29 Jan 2026 23:12:08 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im
Subject: Re: [PATCH] show-index: warn when falling back to SHA-1 outside a
 repository
Message-ID: <aXvpSPpfvulKu57P@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com, ps@pks.im
References: <20260120140901.517928-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260129153948.224156-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yJk+mQM5aHx5ZpYf"
Content-Disposition: inline
In-Reply-To: <20260129153948.224156-1-shreyanshpaliwalcmsmn@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--yJk+mQM5aHx5ZpYf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-01-29 at 15:36:55, Shreyansh Paliwal wrote:
>  	/*
>  	 * Fallback to SHA1 if we are running outside of a repository.
>  	 *
> -	 * TODO: Figure out and implement a way to detect the hash algorithm in=
 use by the
> -	 *       the index file passed in and use that instead.
> +	 * TODO: If a future implementation of index file version encodes the h=
ash
> +	 *       algorithm in its header, enable show-index to infer it from the
> +	 *       header rather than relying on repository context or a default =
fallback.
>  	 */
> -	if (!the_hash_algo)
> +	if (!the_hash_algo) {
> +		warning(_("assuming SHA-1; use --object-format to override"));
>  		repo_set_hash_algo(the_repository, GIT_HASH_DEFAULT);

If we're going to start producing a warning, can we also learn a
`--quiet` option to silence it?
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--yJk+mQM5aHx5ZpYf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaXvpSAAKCRB8DEliiIei
gTwJAQDr3LZyuv9imBldbAksc7HzB2kRHq9a1S4/pp6g5b/aFQEAgl5+9YrAwlWs
u8iAE5lV6juOt+ovPXImEoO096yr8Aw=
=P0op
-----END PGP SIGNATURE-----

--yJk+mQM5aHx5ZpYf--

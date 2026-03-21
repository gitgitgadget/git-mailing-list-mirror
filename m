Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63C81D7E41
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 23:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774134567; cv=none; b=EUW790qD0TXNRkmJ+Wa5EOByC2m3ACkvA+uFZmhhLuxxjYn+7Ld2uxRjihqywy5NdHGczmoVkbNctVKaq9NFvuljCAYK1w3aJPgz3So9SNUONmcDedGIi6faLh1vIjfzhIzeQ/FC7IIIoxmMOXTfkJ/b2dOfDpWwZaQEugNRnQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774134567; c=relaxed/simple;
	bh=V7s+RxDYVs/o2kGU75s8iq5fg8HMcXryQdJlboAMI9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHDmCDqvPewDeIXd8tgbPsq+zlwSh/RS+XSOEu0M5XJyNEqS8oKwEpIQP5xk2v+wvAttzb/wRR5e0OkfNotlNJq5daPRpusRlF5J1hwVQBfipvQ1UNBqe39iJdgLQzkToYrfKknUtdhyOLVZX902l3xtQ4mkOsm+wUOTj6Ey5Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=MBWMJy1S; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="MBWMJy1S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1774134557;
	bh=V7s+RxDYVs/o2kGU75s8iq5fg8HMcXryQdJlboAMI9E=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=MBWMJy1SgvnFCEXjh5eQcxqRkaNn5zDHYYhxRMgrBRt6cC9jmyGU/72pNw0LkQw7O
	 uZqa61epPDEe7aXxfavpIvflAvilhWIu+TD/habdbdcYsL57/cSuD6ds28oyFt/w7d
	 2Y+UqosQ4BrthxOXnt1SAF0q5gwJvOt/4TfBx9l+k11ZYYlaDC0GTP0OoncxJVGErU
	 CpO3uV+J0lDn1biaHabjIMScBOWkCgyvRUnga7WRd7onqQg5rPu/wvSzmhT4Bxku1p
	 GUvTtPlHfxjTWvCTzSzM+i05Ij3crRnQ/vU65Y/bSNaLFDhWxRw61hHBeRcTRW/YB4
	 RDpMrel36mV7Qop01NkqIlSVhCVi1SB1qPk4dfpWXd8BYtbZhmwgk/Dl5XFx5Eamc2
	 sjhOJZS2pb+u7emNfxG0k2Qjzccoyc8SkD+9LWXvgtIXYXGbR5N6EpVbbCXnTTvf3f
	 pBpFWferMATCzcJGmjYahdEZIChGiBI96TWYdfbSBWBEEGlDejU
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:1ca4:b7ce:a1d:916f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 7686120113;
	Sat, 21 Mar 2026 23:09:17 +0000 (UTC)
Date: Sat, 21 Mar 2026 23:09:16 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: joliss42@gmail.com, git@vger.kernel.org, Jo Liss <joliss@gmail.com>
Subject: Re: [PATCH] remote-curl: set fallback hash algorithm outside repo
Message-ID: <ab8lHBDvjTjatE9s@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>,
	joliss42@gmail.com, git@vger.kernel.org, Jo Liss <joliss@gmail.com>
References: <CAN=xy38zCRdOAnMtBXtRyUHE=+gtS8J6mwUWFQqxDAaBLAm7dA@mail.gmail.com>
 <20260321194653.24513-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hwpTMKXmVpa19MPJ"
Content-Disposition: inline
In-Reply-To: <20260321194653.24513-1-jayatheerthkulkarni2005@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--hwpTMKXmVpa19MPJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-03-21 at 19:46:53, K Jayatheerth wrote:
> diff --git a/remote-curl.c b/remote-curl.c
> index 92e40bb682..4c85e6b079 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -1547,6 +1547,10 @@ int cmd_main(int argc, const char **argv)
>  	int ret =3D 1;
> =20
>  	setup_git_directory_gently(&nongit);
> +
> +	if (nongit && !the_repository->hash_algo)
> +		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);

This should be GIT_HASH_DEFAULT, which is whatever the default hash is.

GIT_HASH_SHA1_LEGACY is for places where we assume SHA-1 because the
data format doesn't specify (e.g., v1 bundles) and GIT_HASH_SHA1 says,
=E2=80=9CThe user or data format specifically chose SHA-1.=E2=80=9D  The us=
er didn't
specify any particular algorithm here (which is the problem), so we
should go with the default (which will change to SHA-256 in 3.0).

That being said, I also agree with Peff downthread that it might be
better to fix this elsewhere,
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--hwpTMKXmVpa19MPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmm/JRsJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZxJVK0veEyXdaS4lO4eSFzNeHl9otfjHK6j3dms5+f2o
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAGcgAPwK2kQQ/oZq2eRf87aAUF39s36q
piAfCs4RDQcInJFHaAEAzBzbqw3CQLBwA47E9nZFETMuTVzlk+176kvJmwtPqQ8=
=0V1U
-----END PGP SIGNATURE-----

--hwpTMKXmVpa19MPJ--

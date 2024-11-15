Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F79917BB32
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 23:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731711937; cv=none; b=d98r+Q8JXefdlp3zZU/ZGxtlErEjV3OOQ0UTOSzlNsLV+pTi7vICd1BmNeC4DYH9cvaBuf5zGRlLXxxYL32lZgeqmIEaq56JuZemavGaEyshsVaxmnUo+vwc2QftUyjtM5nzaJAPhqpRFuLH95WSO8zp54bxyWw0aL7Lk5FwJog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731711937; c=relaxed/simple;
	bh=3x0lnwqRtZP28VtOidOfRMuHhozNHzppe2T/DaT8ISI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScTroZKhA49SUyoMpjj+hrVAxpkFIfUibk4wBU5m2ROTgI5UnxZXkWyimEuDZF7qNbgcuTPbyqHkJlh4EJeB7hjRtWkyGFeA549VjQ8iGZTHNMgNmk8ZziEs+Hys2PNJk3UZr2F5ZUcgNGtVzZTcQMj/Up/D3iePoNPoOsPHPxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=IwTnCxF9; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="IwTnCxF9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1731711933;
	bh=3x0lnwqRtZP28VtOidOfRMuHhozNHzppe2T/DaT8ISI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=IwTnCxF9rGCuT1DU56icDE9XikDSSAdEhlLDe4Q4/Y7ZUV0vvsytBsASD/i7uOHwW
	 +/zDIKcgjfg8IfOGg+jS09z6hqb6i4o1X/Z+g9jSfeo9eJzucvv1YBkdTPghY7z3ze
	 KDajvWguQzxpDD7FHuhjUePjKS5PJeB/cJ2hc5ZehRfI+xLDel+fHyb/arM/jF7oyP
	 Iet/248Rm9YzgatYYJswe8+Civvk0IvikmKCHZGM6uYBqO8X3TPds9wIIxS0NtZ679
	 AhJgtkmGQeGNuT/Fox8bZ8SHB67aAUwXAkmcpHJksgTMi2oaO26p9sBjH5lgvuXDPt
	 c6c+kfoL7BbqOzgsJh7B3KPtatKj79EtxZNaaqgfH+OzpOBj9ZXzy2U6cwt8/nBhXv
	 p1pqBZiSn2TVQso8uVsr2w+CA2QUnWL/Fe4KZj491yHIuWxgf0pcZKp6/YhhEGgYZH
	 /L4L90WWZwqNLvmU/qgRMv56oD6vX1KxLnlN4MJxMVE9LlHZUtH
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 40E1B200C4;
	Fri, 15 Nov 2024 23:05:33 +0000 (UTC)
Date: Fri, 15 Nov 2024 23:05:32 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, me@ttaylorr.com, peff@peff.net
Subject: Re: [PATCH 2/8] midx-write: add repository field to
 `write_midx_context`
Message-ID: <ZzfTvGvyn7pMe3nA@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	me@ttaylorr.com, peff@peff.net
References: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
 <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-2-761f8a2c7775@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VGfM8f6gqkrlTzSH"
Content-Disposition: inline
In-Reply-To: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-2-761f8a2c7775@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--VGfM8f6gqkrlTzSH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-11-15 at 13:42:15, Karthik Nayak wrote:
> The struct `write_midx_context` is used to pass context for creating
> MIDX files. Adding the repository field here ensures that most functions
> within `midx-write.c` have access to the field and can use that instead
> of the global `repository` variable. This involves passing the
> `repository` field to `write_midx_internal`. To do this, we add
> `the_repository` usage to two non-static functions, which we'll remove
> in upcoming commits.
>=20
> With this, modify the static functions in `midx-write.c` to not use
> global variables. This means, either we use existing alternatives (like
> `repository` struct), or we pass down required fields from other
> functions.
>=20
> Signed-off-by: default avatarKarthik Nayak <karthik.188@gmail.com>

It looks like the sign-off here may have gotten corrupted.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--VGfM8f6gqkrlTzSH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZzfTuwAKCRB8DEliiIei
gcmuAQCPQz7+EFyuexA1w7syFFgkV9tuEQ1y86ka0twX/7MlhwD+K9fzqHOlN5c3
K0Kft89+KpAp2jUBCkXvPOqBYxhC5gI=
=5DnF
-----END PGP SIGNATURE-----

--VGfM8f6gqkrlTzSH--

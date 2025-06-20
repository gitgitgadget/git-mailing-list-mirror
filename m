Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74D91CBEB9
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 19:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750446208; cv=none; b=WnEKD+3Xw0XPF0l0lI+1itxt6Lz5A0qyQALwUEoMDZjzuuSe2cwogeg75+k5vr9hENxafwLg0pKKlB6diJAwpNX8Tlz4kidhu8D3pVAxkk85GMZcPrEnvMQOgarSreywuKPoFy7AmNMUDGzrR6I0/hDdB5XnzSU3n3KxW0J1rOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750446208; c=relaxed/simple;
	bh=L1UfambNAfpuM+C5BANdxOakkVH38KnOGtt0WQ8/Czg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcqrNK+s4t51xbg3M8wVY1uhpcvu+JkseM0oaOqEnO4XVW0g7UzGX6yCMN0tW/Cw3GMcrqfwjhiwJTwOtDX62rcS0zGqsoOPAjlb8pW8CjLcUzxcmWMr9VILII6b0+NuSTtWzXCsoVsMaslh8xQqIFZmS+fg8wZgdVdE5o/KlaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=uKkegzAC; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="uKkegzAC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1750446204;
	bh=L1UfambNAfpuM+C5BANdxOakkVH38KnOGtt0WQ8/Czg=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=uKkegzACturQ14mtLdTBYlmn+xIAKh5tiIPXt/qvVruGao3u41BMyhHCauNqflICQ
	 jEbPbnV27Ods/JtC0Bfzn2Vp0pmf13076meBX0eVuMJuWJkWAh0wLMFfjIwvU4nKVW
	 VJq8sIV9puC1pS/42/q1Tp+dT1qaqFAb4yVU3ckfmfE9Iz8RBtFrbtiLDRs2x0isCg
	 c1qKWV408Ie6FZDAHmb3YG0VStPh/ZaYxgPQJadGaLWdIgRoEx5C8mSoxUDB86Xw84
	 7/INJWU9knnMCqJlKVDn9v60Ma69mU5SZ7/VZnAIdn6jMBZE5nfxxU2wQp3zGXLSHZ
	 FuUPGwFM3ExRwf9qaJRAzmEvAj77qQKbISJ6yknCdLy1jikK0Ico6yKVuRXc1zX2U5
	 0ZVV7KvoiJxijEN390i93N3QTmUWo5Z3JwJF6U2GLpFd1MWXA/ohbRZmUv+t3SEEsI
	 oMeBqwRg2GAjX9Rxh1VAfGvID+gfuoXs4Ew10Pnww6a7YaMiU7q
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:f445:674a:9eb4:f272])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 602AF20069;
	Fri, 20 Jun 2025 19:03:24 +0000 (UTC)
Date: Fri, 20 Jun 2025 19:03:23 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Maxim Cournoyer <maxim@guixotic.coop>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] contrib: Honor symbolic port in git-credential-netrc.
Message-ID: <aFWwez5OEgLt0vRU@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Maxim Cournoyer <maxim@guixotic.coop>, git@vger.kernel.org
References: <20250620041239.27839-1-maxim@guixotic.coop>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ol4VcQ6+owdWBt8R"
Content-Disposition: inline
In-Reply-To: <20250620041239.27839-1-maxim@guixotic.coop>
User-Agent: Mutt/2.2.13 (2024-03-09)


--ol4VcQ6+owdWBt8R
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-06-20 at 04:12:39, Maxim Cournoyer wrote:
> Symbolic ports were previously silently dropped, which made it
> impossible to use them with git-credential-netrc. This is a supported
> use case according to 'man git-send-email', for --smtp-server-port:
>=20
>    [...] symbolic port names (e.g. "submission" instead of 587) are
>    also accepted.

Does this work with credential managers in general (that is, in
non-email contexts, such as HTTP)?  Also, do credential managers in
general properly find credentials when they're stored in one form and
looked up in another?  If so, is that still true when the lookup is in
the URL form (e.g., `smtp://mail.example.com:587/`)?  Is this documented
to work in the credential manual page?  (To be clear, I would be very
surprised if the answer to any of these were "yes" because I've
literally never seen this usage before with Git, but I am open to
updating my knowledge if that's the case.)

If not, then I think the proper thing to do is to have `git send-email`
rewrite the name into a port instead of having the netrc credential
helper learn to handle non-numeric ports.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--ol4VcQ6+owdWBt8R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaFWwegAKCRB8DEliiIei
gf1iAQDevil469bu2DCB+ZnEyHH1U6VcLYqDhKIe9LiyL2IncgEA0vTYCvfZyX+U
Y5NVSLOUH3If91uHzy1Rjw+RR3iSVgo=
=shr4
-----END PGP SIGNATURE-----

--ol4VcQ6+owdWBt8R--

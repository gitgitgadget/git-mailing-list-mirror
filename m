Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073581741CC
	for <git@vger.kernel.org>; Sat, 27 Jul 2024 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722090972; cv=none; b=doMW3Y1Y0xWfOBuzuBdFD6e9eSiDxpcik5iWQhMwwIqijX4018i4wK5caBESDLVxQtWN/6AmQW9Vr2UcZAMOnkDuGzMG3HUmgU2/3ieCnTXWCdg1W3bsgls0eS0GBrfLQjOuwdFAKq2hJFaKw1+Lh2mVV2T7uALqBSAKA3ZyL1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722090972; c=relaxed/simple;
	bh=7B4M5TDq5TjRL9vcflQE+f51pKHc2pn4czgAI1Lielw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLOfU8sQovCg2HWoWTNTDpruyuTb68bqUxs918iFS4Q6OWGeeg4wPw4Fd4hkZC+w27XHe7v1aa5+88c563Y8JV05ZNG1Dos66oJ+aNjEFYb7Czeto1skSjCIuf9inY0v8VPzpXeZdkILCVmaRUF/CUNwX2UecYFoVnUxLeH3SeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=ofCsJXbR; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ofCsJXbR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1722090962;
	bh=7B4M5TDq5TjRL9vcflQE+f51pKHc2pn4czgAI1Lielw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=ofCsJXbRQmN1Re3nlbK53G7ixuzUIG9okrGJnaxVwJwKLdtuRWlC9hxE0BRiOOPNi
	 xsQKOjx5vYBFaCiF5GKZAMJpOhp4IUQ4CvW3fQNp494Rxv/ftYb/WweKYD0FBcpZq1
	 /7gbAwpZ6kj3oyFWeEn6cYikacE0dalxX07l7j51ClNL/8LpAriZXwBMmGZUM8q0LK
	 MW2zVGOfX3y5Ten6Kek6hWfHk2eAWd3+RqJR7+dTZZskb7+JUacfA+BWa9jBFSuf/Z
	 IVb3qnnzS08/hpeUIFsFfQ46XC7fvE0csunM8h6a/5pTv1EuqSjaLdnz2ab4FWR1i2
	 8PaG1VBZaQ5cl0obiPKnZ4PsgngKbrYBzr8rvAMr0tVrDjSlRHOWISIgD4veKVPYLt
	 yknJV/dA0F/mNdYV2PVUws7f0SJX0tVj8z63olP2R7KFxQEU4ugJtIGCbThlD163rE
	 p4CfOZdz2PZgK9pdfdcGzLYbVj5rxhsQWZ76T+lBl1LKHq4lsOQ
Received: from tapette.crustytoothpaste.net (unknown [207.96.251.194])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 91F90209B7;
	Sat, 27 Jul 2024 14:36:02 +0000 (UTC)
Date: Sat, 27 Jul 2024 14:36:00 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Tim Abdiukov <tabdiukov@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Bug with bash and OpenSSL usage on Windows
Message-ID: <ZqUF0ANz9qX-wWEN@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Tim Abdiukov <tabdiukov@gmail.com>, git@vger.kernel.org
References: <CAD+08a87xxVRxO1eiWiam-7xvq=AyKUB-MzqG-r=rM_SYbquBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7zolsBUS9ClBRSRE"
Content-Disposition: inline
In-Reply-To: <CAD+08a87xxVRxO1eiWiam-7xvq=AyKUB-MzqG-r=rM_SYbquBQ@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--7zolsBUS9ClBRSRE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On 2024-07-26 at 19:40:48, Tim Abdiukov wrote:
>   What did you do before the bug happened? (Steps to reproduce your issue)
> Tried to generate a self-signed certificate using git bash.
>=20
> Using git bash, I ran
> ```
> openssl genrsa -aes256 (private key location) 4096
> ```

The Git project doesn't ship OpenSSL, or, for that matter, any binaries
at all.  All we ship is source versions of Git which various
distributors compile, sometimes with other binaries.

It looks like you're probably using Git for Windows, which _does_ ship
OpenSSL, and so you probably want to contact them using their issue
tracker[0] once you've verified that it hasn't already been reported.

[0] https://github.com/git-for-windows/git
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--7zolsBUS9ClBRSRE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZqUFzwAKCRB8DEliiIei
gci2AQDaHd1eA2tlWC/kER0i96Wwnm9Rsd2ANAvg/d28wJLDxQEAqNzQRibXi6zm
g9nu/KSRjhyLzD94TExcrjp8SQ2G0gw=
=7xEa
-----END PGP SIGNATURE-----

--7zolsBUS9ClBRSRE--

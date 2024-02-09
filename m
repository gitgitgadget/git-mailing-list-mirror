Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBD91103
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 01:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707442712; cv=none; b=WyTg5rhyvb4cAUle56ELt8RM6/ruHxPLslQIvKd090PuBzTpiuw/nUCC/y1fmUZjoDrZDyT5qcV7CEj7/Wh/PldElmDKYFPw95D7Nev6Q6WPomWb0h9mAKw8XvoMU/afZQcL7l2c0VZwoBRIev8SU9wpLz02fwJD2LWVm1VXjfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707442712; c=relaxed/simple;
	bh=N/0yj8kwHG+fh/dew8JQvAsEjLv8Q22h6WUUWPp/sHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYasoZa6IBWkzt0uu1VkFT2tBjRgxXvYTEabr5GzaLXUSIfqc8gtBnqWG5anADUT7gTOJ29W31S6QHZD2K/0yhhOYWnRCI1lyfO4H9RgUJZ992tJ+kw2sc917cZNnOs5scR/hAl/e7AT+c3hSsvk1fIyLnLe4gUCalh31S0jPK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=sVbtmPXe; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="sVbtmPXe"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id AD5FE5B186;
	Fri,  9 Feb 2024 01:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1707442702;
	bh=N/0yj8kwHG+fh/dew8JQvAsEjLv8Q22h6WUUWPp/sHQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=sVbtmPXeVI8wYdg9TUcB0Tha8PynfR6MaV4DoUHbTsPZ7lT5uk5Wa+0luhwQL9t4v
	 ggTFRc0XUSvJDX34HCyO6GOJD1FMfS4hO1KsFcuvLfdUjNEWK7KzG91VHDT/e71rnh
	 3tKGFGKwbw4CkwhX0Ly4iqzB5J0UmNUNzQufIAPOpJesIaaW0xIyJrG++c1/BfHXGC
	 3kDuLRGvbPEQNtyqHZYm3AhHLFOqR5FDHuH8+lecMkBFidSInS9/yKRKP+AiQwqJ1S
	 INdbFPbskFCTTaS8UKUaFxnVY07uNc5lk0I//fgkRFF3dStqUx7dkawnF7xjy3+/Vq
	 fm6FYtMG9vJupygAOHkqjNXrlcpKD0PkFS/Kk/7uoz1YR7oWIQp1bGaChsGW5P/HcQ
	 tSNWWm9HcNLtH9eXce9HAKB3QofhVWL8QGemQhc5RqH7OAMn3UBbGQp0XeM0f4szHM
	 UzuegdWyO9Upbf8DsScrOmYoW2BPBQQSVh7SZoZ1bL0GoHT+GRT
Date: Fri, 9 Feb 2024 01:38:20 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Orgad Shaneh <orgads@gmail.com>
Cc: git <git@vger.kernel.org>
Subject: Re: Supporting --no-edit for git rebase --continue
Message-ID: <ZcWCDEnmv97orQyY@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Orgad Shaneh <orgads@gmail.com>, git <git@vger.kernel.org>
References: <CAGHpTB+mCxvzJ4LDpQrMgHmzigUzcAnRcwMewV0oYKM2HwbNXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5BfeRk9vW+RMxDK7"
Content-Disposition: inline
In-Reply-To: <CAGHpTB+mCxvzJ4LDpQrMgHmzigUzcAnRcwMewV0oYKM2HwbNXw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--5BfeRk9vW+RMxDK7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-02-07 at 20:46:16, Orgad Shaneh wrote:
> Hi,
>=20
> Is it possible to add --no-edit for git rebase --continue, similar to
> the functionality of this flag for git cherry-pick --continue and
> similar commands?

I haven't checked whether this is actually possible, but I imagine it is
with some work.  I think it would be a valuable feature to add, but I
don't think anyone's planning on working on it.  Would you be willing to
send a patch?  Even if many people think it's a good idea, we're all
busy, and thus it'll only be implemented if someone is willing to pick
it up.

In the meantime, you could try setting `GIT_EDITOR=3D:` in your
environment (for example, using an alias) like so:

[alias]
  rncontinue =3D "!f() { GIT_EDITOR=3D: git rebase --continue; };f"

and that can serve as a workaround.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--5BfeRk9vW+RMxDK7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.3 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZcWCDAAKCRB8DEliiIei
gWmfAQD/b6vNMsf9NJ5UJ1oBWvhMw4s+BP0RmS+6NbYUt9VPgAD/Wv3/wgDDbSoh
W2Q2ch0fH/d/W3TEKiw3+EIm0eG1+Qo=
=OkP2
-----END PGP SIGNATURE-----

--5BfeRk9vW+RMxDK7--

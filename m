Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=172.105.7.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792703985;
	b=cbLM/U8WTudjgR/SvsZP/snasufBNxNRyuknmr3igvCWnTVqJP0hS2SBupsOX6DGSZCk
	 +M2TTXT6GpYC/iVSR+uy8LYgChYrhnF2vGu+OZMei+sV5T4BiN6Ch4F/ajp12YK/i3kFe
	 o6F3GrXQWssUc8h1/rSjJCPIzcQWksNaXEsb2juWaDIzbqtvw15+Oa3F8cWL3iuCUCUVs
	 T53RXAywPGegFIUHa78rfJ3+oOtd4QFSaNeQtj+qI78cR3XuAtM2KZWwQpEeyafX+euiN
	 g/bbnd6gquHP8wGsRj2kK+sINOuY/CL8xnxlO9gAtnGf881SrglclnFI5L2Isx8Oizg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792703985;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=To+iE1ujYzXRnLEb9YKUiZIRjrH/U4UpEZoUhftA6hg=;
	b=J0vq5m1ZdaRQKQptA/eZqZy3rpqIi2yLTg6RRRwz1CtyaWpKj5i00me28jc04aIMj1wZ
	 ffeBZV8BoBzXBtaZPlKgK1WuRjWTqKBj+6rJEHbRtiCpZgu1RxOuYqV3tLo9PPCsZ69HG
	 +VUxxK94Wi+4KhGbZr8fILlZqUndArDvNLibwKuulS0gbkww1zi4kaNEiALbl8dSnhoKr
	 0Ylsn3ZhqGryKqL2wYmNRFeMCOKUIyDqQrhgQyOJejkxlG5oXgBFVRhCuoG3HcUacCugn
	 K6jWxVo2A/gW3QHTAscp6dvMtV9PD6ZQrXQuRL+Vwa9V1bSKy22DHcZ8ZEEHX9H5uuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=crustytoothpaste.net;
	spf=pass smtp.mailfrom=crustytoothpaste.net;
	dkim=pass header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=gtwiYvYz;
	arc=none smtp.remote-ip=172.105.7.114
Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0825E606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 21:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0825E606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key, unprotected) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=gtwiYvYz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1792703983;
	bh=Cj2U35snBAW+5NN8G7wcjbJQSHmx/OHclvL3YWGlPOw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=gtwiYvYzrttxlfbdsHoki7sMLhFZOi+h/1sXv7BGV6Kqi5YFXbHB5sgMysPdAQ+DL
	 IkmUFCdHiNViH5SOimjX7iJB5ZTjkrfdZGTmKUJlIkMqsBZWYBneKb8UVWuaQExtsa
	 p+uEnsgQl2vgwTXQPbPN2+60wqgO/54ne48jr8TbIJ/4ZAwpqZvgbHIpkutonH8KJb
	 iFOVA3qe6JWcmG8kIFeMFLqZzI/Tmh+CujH9JVCkoEFHgX/ldXbfRtvNAd/g6HH/dM
	 kCPsyH90QldiGig38O/4bRgAoWeCmOCUo6ELCMo/5CrUnZgKZUCw79wrdaJSf3hq9F
	 BNRVazeLt49oNbm+4q4DH30dtfbiQgWYxvVdQLzEEE/HpXUE/Sz2/GvVaYUAlaPHxt
	 /Oao8nBSjERbdy0VevToDpoI/z0KOOV3+p61tDP88uuf/dzHfAA6nxFC//bi94fZIB
	 9zgp5VAY1U7hW6+KfpwLqX/NfFFzWTrkk64pGTti82YMuOrISA9
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b44d:c6f6:4e4b:66bf])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id C1CA12006B;
	Thu, 22 Oct 2026 21:19:43 +0000 (UTC)
Date: Thu, 22 Oct 2026 21:19:42 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: =?utf-8?Q?J=C3=A1n?= Waclawek <jan.waclawek@taphome.com>
Cc: git@vger.kernel.org
Subject: Re: Feature request: update password in remote URL
Message-ID: <atp97X1NaNIWCG9z@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?Q?J=C3=A1n?= Waclawek <jan.waclawek@taphome.com>,
	git@vger.kernel.org
References: <CA+jzbCGmDYCS5XZmEnYpZ31a-cV5bncR04xv2BXz3eCyhBuCiQ@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d+RU3Wu1WQG28adC"
Content-Disposition: inline
In-Reply-To: <CA+jzbCGmDYCS5XZmEnYpZ31a-cV5bncR04xv2BXz3eCyhBuCiQ@mail.gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--d+RU3Wu1WQG28adC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-10-22 at 09:52:27, J=C3=A1n Waclawek wrote:
> It would be useful to have a Git command that replaces only the
> password embedded in a remote URL, preserving the username, hostname,
> path, and other URL components.
>=20
> For example:
>=20
> git remote set-password origin NEW_PASSWORD
>=20
> Security policies on various git servers stipulate to change password
> relatively often. Currently, if a password expires or changes, users
> must reconstruct the remote URL with the new password or use a script
> to modify it. A dedicated command would make this operation simpler
> and less error-prone.
>=20
> The command should replace only the password component and preserve
> all other parts of the URL unchanged.
>=20
> I am aware of existence of credential managers, but sometimes they are
> just too much. I also understand that storing passwords in remote URLs
> has security drawbacks, but this feature would help users who already
> use the embedded credentials, work with servers that require URL-based
> credentials and understand those drawbacks.

I don't think we're going to implement or accept such a feature.  In
fact, we've discussed disallowing URL-based credentials altogether a
couple times on the list.  The only reason we haven't done so is that
we agree it's convenient for test environments where the credentials
have no value.

We also know that since the URL is stored in the config file, it's
actually very frequent that people expose the config file (such as on
web servers in some cases) and then they've exposed their credentials;
this is especially bad if the credentials are read-write, since then the
repository can be written to.

Credential helpers can actually be very simple to use and the Git FAQ
provides an example[0] of how to use one to read credentials from an
environment variable.  There's also `git-credential-store`, which is
shipped with Git and which also uses a plaintext file, but not one under
the repository by default.

You can also use SSH with a public key if your server supports it and
you can use something like a deploy key to let systems automatically
fetch and push if necessary.

So for those reasons (and probably some others I've forgotten), we're
not really interested in making support for using credentials in the URL
easier given there are much better alternatives.

[0] https://git-scm.com/docs/gitfaq#http-credentials-environment
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--d+RU3Wu1WQG28adC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmrafe4JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ9ZzYlBdzNzb6VMsqu1Vkm4tqhEX/fDr0GdT+aK9c6M/
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAKO9AQD4Lhclmct9vsONfgxuLJ1Wtili
W72+Iv4/SK1NaVGrpwEA3BmovPZgtMhWuVwin4Swu6Lh60gjkT7aAGzoG1EwEAo=
=tXqf
-----END PGP SIGNATURE-----

--d+RU3Wu1WQG28adC--

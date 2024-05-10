Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB44C125
	for <git@vger.kernel.org>; Fri, 10 May 2024 23:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715382049; cv=none; b=oKkCGgsjW5xNbPevGVTjag9RrprqQucRtThI4NzypqbOTR1UC0GgWZEYZyDVOn92fFz1CfhyzVouJqk6bB6FpHJ2TEsG9NU5NVt00yB6S9OGSYVl83j4PwPWllhqHzClxl+02I0cVPLaMB6wkVtPSwuLYKw6eKFxvlsuwTJsuu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715382049; c=relaxed/simple;
	bh=5nr6tDt0ZC7lbI38ItZXfEX38AwWW68NCv38vLd8b7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiGctfllAtWqo4TD6HvGkLQblmFKYYOMoIgR41mUav2LSR6DMQDrtOrSKiG7zlmGizse1cVkRCRglSDWHlaa1m0sY9q8mMZL1X3yiRa+eyDBWgx7OMz6L/Oe3H6vNtB4sj7y+M0iyYl52lTOaOvuwtgl27x2HULH/yof6+dY8yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Wq+3OImk; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Wq+3OImk"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id D57F25DA79;
	Fri, 10 May 2024 23:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1715382038;
	bh=5nr6tDt0ZC7lbI38ItZXfEX38AwWW68NCv38vLd8b7I=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Wq+3OImkweOd73nlUCFwWBajMbPPvLnzDxPqv2QRS3jeLNMNxN2vzptWxHKB+vY+J
	 ZcoW428VrWNEjzFtQ7qKbkBloKlHrrpK7kX8YK0C36EXdHiOxNNnd7l0rA8KuV0zz2
	 3WMolpS+5O0pABjGUoRZmm6eDdjJWRYEaDVb1EPdtBSbLlP0ypvl3Lc5LbTmIfNt+6
	 jFMS9HHCHyJpZlPG3XN51xE7SgsYVQPxKWIGIWH9PxUVSVGTnX+EGJN2GCZGsvoEwb
	 h/gBkcqMnbk4Pgyh14uUh93bKFyVJHyckp7xZojLg2N2WtVjZhj4C/zjrFLhQm5JMk
	 6tolBJspkr2YEAEvQf2xXI+erzIqEzrntFh3ed/01wB7SuBGVmcMB2upVht1SvROXb
	 otdvA97nuTXpQKl1xEFux7SayaJ+FNhOLMtldMw9ZNhX/tp/pTQbZsVbWsJn0Cah4X
	 Zsi+nAqEuIl4jUL9/P6X7AJKf3VF7tnd3VyD/XBuHgqk2cjCy/h
Date: Fri, 10 May 2024 23:00:36 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: ryenus <ryenus@gmail.com>, Bo Anderson <mail@boanderson.me>,
	Git mailing list <git@vger.kernel.org>
Subject: Re: Error: failed to store: -25299
Message-ID: <Zj6nFPQBKJg8q7JV@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, ryenus <ryenus@gmail.com>,
	Bo Anderson <mail@boanderson.me>,
	Git mailing list <git@vger.kernel.org>
References: <CAKkAvazeFvCfT7tZm3emwA=k-NnzPD7X0v4t2E9Ja4r-GpZfoQ@mail.gmail.com>
 <20240510221323.GA1971112@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZQUd2Wi2hwnFXUe6"
Content-Disposition: inline
In-Reply-To: <20240510221323.GA1971112@coredump.intra.peff.net>
User-Agent: Mutt/2.2.12 (2023-09-09)


--ZQUd2Wi2hwnFXUe6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-05-10 at 22:13:23, Jeff King wrote:
> I would have assumed this was an issue going back to 2011, since each of
> those fetches is going to try storing the successful credential. But if
> older-but-recent versions of Git did not have the problem, it could be
> that we are being more aggressive about invoking storage for some
> reason. Can you bisect?
>=20
> The obvious recent changes to the credential code were brian's
> capability/state series, but those are not yet in a released version
> (and from a quick scan I did not see anything that would obviously
> change things there).

Yeah, this sounds like a change to the osxkeychain helper.  There were
some changes there in 2.45 that could in theory be related that weren't
in 2.43 or 2.44, but I must admit not being very familiar with the macOS
keychain tooling, so it's hard for me to say for certain.

My changes aren't in a released version and I haven't touched the
osxkeychain helper (since I don't have a Mac), so I think it's unlikely
to be related, but of course if someone finds a bug, I'm very open to
fixing it.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--ZQUd2Wi2hwnFXUe6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZj6nFAAKCRB8DEliiIei
geh9AP9YvpJxizrHkNJF6B67YHKnSv/Z8DLQ5rk45QYe/xd30QEAuxg6z4XEzk1i
4kegoj7ogrxrzvxIz7ExDmx5+JxXTAc=
=thqm
-----END PGP SIGNATURE-----

--ZQUd2Wi2hwnFXUe6--

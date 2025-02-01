Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A582AD20
	for <git@vger.kernel.org>; Sat,  1 Feb 2025 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738404473; cv=none; b=dJLmFuVSQYmxkwpAWKOqYcGcoRk81Fb5C+mDwMlrmBkZ9TLTArWKzVO9yhes3Il2KZVtkf127FxhmIaXpdl8u1c8c7B5aS0RUHWEn6TD2NFZ/1rN4WvH680iAruxEmZQeAjf3tbixG1m6fISKPcr7yUKAqFiyquJY6w9YwP4S5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738404473; c=relaxed/simple;
	bh=AFGR5wOLBhekK4kBt1iwotECHb3vFSUWszSJ43w2YjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKnoxuBg3gG/q8IS/mfFGhrLdq7LyO4YzrkjaDnDUpLRNH9f/KApPt7wfXmH+nDGLGOaZnMSaJW62FaQEMQIjQ7GElXtggNAwaq1kEjcZP1zDN6LDmi+ebXKOZZ6OFBpoqGBKMm2NSXrVvjLVAvVr2nS1XZNssyYgqGQUUEOpXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=yvj9PrCU; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="yvj9PrCU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1738404462;
	bh=AFGR5wOLBhekK4kBt1iwotECHb3vFSUWszSJ43w2YjI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=yvj9PrCULSxgVSlB2dqdej1ypmk+hWQ0F8/82ESGF2GpdOzXEGqmu3w736AOcnOZ3
	 dECJZ9V2lPSJ+efLdRo6j0F7Fao1xkFGPrKBTu0RvnTnaeYV1bGr8UhFUdWdQGELLD
	 8mVgzEEcVd5JjrlFOgwKHc+5UN/a8hDSC2CyuElXJ1EfkHsELD20aBq+6SfxhDp80o
	 UDdl3TnT07rckm2OixcpJzpky/JHDrMsCN3thbvXoyM2KABC1eYgc4YEGAhy2VhNEV
	 IWIf0yYDxQgFPARkTT1lJFTr/Du2qj4fWXSZzYYx3orawyiM+zNXpK8QsDbmowUcaH
	 CGcXVZT926qOoZqFewE1cLDVlStOePjik9FZL/9wbhONe7qIfXsGV44RQGa0iEsu3S
	 a6xm9AZzrHilX4TrDst2BbhEWuCKXgy9pTsrYb43OqIyI18HwyG3qNJw2Y+kWFHmMc
	 EbaD+NhyNL0orms1Rz2uQWY0BCyBGXAJnQCelgbVDPq3TraBSge
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D1D6120042;
	Sat,  1 Feb 2025 10:07:42 +0000 (UTC)
Date: Sat, 1 Feb 2025 10:07:41 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: M Hickford via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, stolee@gmail.com, Johannes.Schindelin@gmx.de,
	peff@peff.net, rsbecker@nexbridge.com,
	M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH] credential: warn about git-credential-store [RFC]
Message-ID: <Z53ybUCIHPG78Vj2@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, stolee@gmail.com, Johannes.Schindelin@gmx.de,
	peff@peff.net, rsbecker@nexbridge.com,
	M Hickford <mirth.hickford@gmail.com>
References: <pull.1856.git.1738352886190.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hCtMH6HVKSbKMCHG"
Content-Disposition: inline
In-Reply-To: <pull.1856.git.1738352886190.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--hCtMH6HVKSbKMCHG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-01-31 at 19:48:06, M Hickford via GitGitGadget wrote:
> From: M Hickford <mirth.hickford@gmail.com>
>=20
> git-credential-store saves secrets unencrypted on disk.
>=20
> Warn the user before they type their password, suggesting alternative
> credential helpers.
>=20
> An alternative could be to warn in "credential-store store". A
> disadvantage is that the user wouldn't see the warning until after they
> typed their password, which is less helpful. The warning would appear
> again every time the user authenticated, which feels too frequently.

I don't think this is a good idea.  While it's typically recommended to
use a different credential helper, it can be difficult to do so in an
environment where you don't have a desktop, since all of the major
helpers use the system keychain, where a desktop is required.

If you have such an environment (such as a remote system) and can't use
SSH (because your corporate environment only allows HTTPS), then you
really don't have many, if any, alternatives[0].  All warning in this
case is going to do is just annoy the user, especially if they have many
such systems.

If we are going to do this, I'd recommend using the advice system, so
that users can just disable the warning.

[0] Okay, I lied.  I have a tool called Lawn (local spawn) which allows
you to run a command on your laptop or desktop from the remote machine,
such as a credential helper, but it's not in widespread use and I don't
think it's polished enough to recommend here.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--hCtMH6HVKSbKMCHG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ53ybQAKCRB8DEliiIei
gcghAP0QYGr62jty4rGqvOsNDuBXBvcXouekO35IDgd8EyzEMQD9GWNozWYw5NbD
QjFCCeLiUU42swsg+HdiYKaifUtxwQQ=
=rtRd
-----END PGP SIGNATURE-----

--hCtMH6HVKSbKMCHG--

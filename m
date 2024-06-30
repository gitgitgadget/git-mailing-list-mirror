Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33F9433BE
	for <git@vger.kernel.org>; Sun, 30 Jun 2024 21:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719783871; cv=none; b=EpR12ni8MjUn7ERRbPi1E4Pf21tuAOIS1GTdv7eSV0NsKU7cGf2uRCLx7JKYtmGhkW4FLRnIrdQO55P59bn/XfLY2VDTYge+DebBugD+zXcoKQBhnVA/7cjazEFVqftFBsQsitQaksLvdM+dLQPOgqkDxjkoQHZqElGpXBd6Oes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719783871; c=relaxed/simple;
	bh=P28GrT4elYUXAzcANSwVdi4fDj4Vihi4IfTz2NXHQyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnFtREj0N5fDZZ8AXVGc7CYV1rRdDCKf2+aCWf171UIJWzyip5lDXQG6TLNBdYH/ChnNT6DhKWahm76ZURCIHdFo9fT9kUiuRMk3lN8ObRgX0k+6TzG6o+kzY+quq6aRGZO18ehsygP9oNiVegNxJCd+gZK2ahF1t0ftFitTdBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=IeAvl5Jd; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="IeAvl5Jd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1719783859;
	bh=P28GrT4elYUXAzcANSwVdi4fDj4Vihi4IfTz2NXHQyM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=IeAvl5JdUIiKGN18+sDcsJ+Svr41U1/TqL7wEvMyysSpwTcdBPIpcDucL+yt3cgDP
	 4IiXoeugedDc4aaV13+V9thIzCXWVX2ghRSdEIj2pgh/I6Uf3BrCCByfXUghcJpwjW
	 iIDHZzfiau0D6VDcqdLD0TMxOGEc2khP+2UD+7sLpegPFIBEsiJmTq67KZ7sc2rxXK
	 i2hEOUFcFrfK1HCAA9x0ReXJ3UPuiGm7RSVrCaoYztFEqSf7ZQFHT3coyCBVD9QA3p
	 Ne5DGOTd7JOee47l+pxKnYyI5JlaOtfrXTk2sHVvG+OUjaxTQR7WxlKz2WJMiyECja
	 jT+felny1e1RNeP6VK7MeVAGOSu2KJzOHCPJDJ02oyytge6YD4SaS0NKSDgaq8W3i8
	 hkjYGWaezOjc1f2yltSg9nn99AodpoPqUNAnkltyVV1xp0CQ8yG1UyWCQRiN51DqiX
	 214U33k5I87Da3XHdhwReI4D6A0rIhoCBYerjUiGodP7TYE9hU+
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id DFCE12638C;
	Sun, 30 Jun 2024 21:44:19 +0000 (UTC)
Date: Sun, 30 Jun 2024 21:44:18 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Mikko Johannes Koivunalho <mikko.koivunalho@iki.fi>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Roland Hieber <rhi@pengutronix.de>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH 0/3] Add a Hook To git commit --message Bash Completion
Message-ID: <ZoHRsoEfh_B5J4HN@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Mikko Johannes Koivunalho <mikko.koivunalho@iki.fi>,
	git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Roland Hieber <rhi@pengutronix.de>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>,
	Beat Bolli <dev+git@drbeat.li>
References: <20240630213336.2212166-1-mikko.koivunalho@iki.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zZA9VtimpJJpT3+Q"
Content-Disposition: inline
In-Reply-To: <20240630213336.2212166-1-mikko.koivunalho@iki.fi>
User-Agent: Mutt/2.2.12 (2023-09-09)


--zZA9VtimpJJpT3+Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-06-30 at 21:33:33, Mikko Johannes Koivunalho wrote:
> I want to create part or all of the `git commit -m *` command's
> message with a script. I work for one Jira ticket at a time and I
> need to create many commits which all start with "TKT-123: "
> (any Jira ticket number/identifier). To make the commits faster,
> I run `git commit --message=3D"TKT-123: add new file"` on the command
> line.
>=20
> I want the Bash completion mechanism to propose the message for
> me. I would fetch the newest ticket number and place it on the command
> line when I type `git commit --message=3D<TAB>`.
>=20
> Example:
> # Doing commit:
> git commit --message=3D<TAB>
> # you would get (also without the closing double quote):
> git commit --message=3D"ABC-1234

This is easy to do with a prepare-commit-msg or commit-msg hook, and
those are the intended tools for this purpose.  I've used these hooks to
generate a message for a ticket based on the branch name at a past
company (so a branch called tkt-123 would result in the TKT-123: entry
in the appropriate place in the commit message).

While you certainly can commit on the command line, it's not encouraged
because you're supposed to write a commit message that explains the
commit in detail.  Only very rarely is a single line commit message
useful, and even in the case you've cited, I'd want to know why you
added a new file.  What does the file do?  What problem is it supposed
to solve?  Why are we adding a new file when we could add the changes to
an existing file?  Why is this change valuable at all?

That being said, all of this is possible with a prepare-commit-msg hook,
and that's a better and more generic way than using the bash completion,
which is specific to bash.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--zZA9VtimpJJpT3+Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZoHRsQAKCRB8DEliiIei
gXgQAP9HQxXXybuBsrOJFO6FNhkkxufguv0hcMekXDP3+feNwgEAmL3H+7DaGR4v
P4rXa1dPK4Y9uq+lSkw7e/61tuRi0Ag=
=hYYF
-----END PGP SIGNATURE-----

--zZA9VtimpJJpT3+Q--

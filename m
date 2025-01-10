Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DCB24B254
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 22:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736546784; cv=none; b=QW/XanA+7kv6dHg4cclo05ZPbirSrcbSxb8IdhNuWsns/Ji7edkVvtxycEyxxTDAw8IymMJdC/SuxVEOd9TLFsV9I/HWyy/qfAcjvZHp2dxyjIUsoxzeO7zLrWrbM8qXC+JGmC7ThDiTnd3Ghe2VIE94aNwr/uOBHS12UKkT1lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736546784; c=relaxed/simple;
	bh=2UWh3/xwGiYH1FikEZDgrNfy9GwH9MPWMqbJwpywaWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dC/dpTUMprtwBr1nF+6uiMKHbMfz57WWd4oPGt2el2v2nKzzyNg2grmfSxc1ViPDm8E7FmHnKhMkvTwudXlu3BLQjMJbkV6UQijcsY8Fzb6xhTRVwg3t5Mz92XtGaW5RPLe4nLVfiRCBSCGlPNr5wViI+DISZhGgCjz8luZRCt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=p8SoXP97; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="p8SoXP97"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1736546772;
	bh=2UWh3/xwGiYH1FikEZDgrNfy9GwH9MPWMqbJwpywaWA=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=p8SoXP97tXMYkQ/wI4rmmhUiHHbCGA4t1KTa1v41CCxKCX5UEgRTJRBpzKXuG5FcR
	 Y3p2R+9ssSSqgtS9N2srcIr8Aa5Jjin5CEheyku6SkTlhOWa6fs+g50WWNACaLBD+l
	 0YnYsGoWUfTgKk0GMA+ru6d9vh6euNY4BZRsKmHSfCrL9CXnqTsFs4M8iA4lbJCPuk
	 +d9Q4LgYPpQ6DEodqLw9uR2jlWyvWWorUkkpfPt5FlgH1b7OJuFMupxPKfJ/1qgqFl
	 to2HL7VFin3zo9jjCZ4w/7cFJhGdmVExKciDr3xOYgGZ/ipq3sAwgq8bwXtNV1yNfj
	 F7W78mSCkB1EOGmtm7R2KN3U5SDCn63RBGIv2zA+FEyqmfHioGarAEBoao8PsoXxw8
	 Knv8tCwsOycdZvszNCIaAIVYjRHtnwWJlEljBk2bsV1TxeeMa81OiMTyyJgagWYUb9
	 kyYmPGkuo+jsMIxrRYJOG/nbgYPdruCSrvVdbKNbpnpJcYnoZR3
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 7E21F20008;
	Fri, 10 Jan 2025 22:06:12 +0000 (UTC)
Date: Fri, 10 Jan 2025 22:06:10 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: M Hickford <mirth.hickford@gmail.com>, git@vger.kernel.org,
	derrickstolee@github.com, stolee@gmail.com
Subject: Re: transfer.credentialsInUrl should warn about personal access
 tokens in user field #leftoverbits
Message-ID: <Z4GZ0oiZCC2Wl3bN@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	M Hickford <mirth.hickford@gmail.com>, git@vger.kernel.org,
	derrickstolee@github.com, stolee@gmail.com
References: <20250110210500.675629-1-mirth.hickford@gmail.com>
 <xmqqh6665p8j.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Yki5U/n4PWHXKr8A"
Content-Disposition: inline
In-Reply-To: <xmqqh6665p8j.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--Yki5U/n4PWHXKr8A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-01-10 at 21:32:44, Junio C Hamano wrote:
> M Hickford <mirth.hickford@gmail.com> writes:
>=20
> > It would be neat to warn similarly if the user includes a personal acce=
ss token in the *user* field of the remote URL:
> >
> >     git clone https://<pat>@github.com/...
> >
> > This is a popular practice according to StackOverflow
> > https://stackoverflow.com/a/70320541/284795 (800k views).
> >
> > GitHub personal access tokens are easily recognised by their
> > prefixes "ghp_" and "github_pat_"

There are also other prefixes as well.

> Curious.  I do not think we have *any* code to special case such a
> "token", so to Git itself, https://<pat>@github.com/... should look
> as it (assuming <pat> does not have any colon in it) is trying to
> access the site with <pat> as the username.

That is accurate.  GitHub has accepted a token in the username for some
time (at least since 2019, and probably longer) for reasons which are
unknown to me.  From a security perspective, I would recommend users not
do so, since many tools log the username and not the password[0], but
it's almost certainly too late to change it now.  I can mention it, but
even if there was a decision to drop that, it would require a long
deprecation period.

> How do we _know_ that this request with <pat> do not need a
> password?  I ask because I'd prefer not to see us hardcoding any
> hosting-site specific heuristics in the code, and these users
> apparently are doing fine without any such hardcoding.  If we can
> reuse the mechanism that is letting them do so when deciding if we
> should warn, it would be great.

I don't think in general we can know whether a credential is just a
plain username or a token without trying to guess based on the content.
For instance, before `http.emptyAuth`, it was common if one was using
Kerberos to put one's username in the URL because that triggered libcurl
to do authentication, whereas it would not if no credentials were
specified.  I still have that configured, and I bet a lot of others do
as well.

It's also common for people with both work and personal accounts on a
site to put the username in the URL so that the correct credentials are
looked up in the credential helper.  And all of that is fine and secure
since there are no actual secrets in the username in those cases.

So there are lots of legitimate reasons to place only a username there,
and we'd only be able to know if it's actually a token by hard-coding
patterns.  I would recommend that we not do that, since I can't
guarantee that the list of patterns won't expand in the future (it
already has before), and there are still some older hex-only patterns
which may be in use and which are much less obvious.

> Are users expected to configure their credential helpers know that
> it is a <pat> (perhaps with authtype=3DBearer)?

No, this is Basic auth.  It's just that GitHub will look at either the
username or password field for the token.

[0] The two systems at GitHub which handle these credentials (the Git
service and the Git auth service) are designed to recognize tokens in
the username and obscure them instead of logging them.  Pretty much no
other tools on the Internet do that, though.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--Yki5U/n4PWHXKr8A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ4GZ0gAKCRB8DEliiIei
gTwKAQCF+ZDK+A1ejCvPatRip8r4//X19yA4nx/dxByzEQX5jQEArXY0JoH7DZcv
lVWzCkO1wcFj8D74cyF5wYCwyCJ6KA4=
=o9W0
-----END PGP SIGNATURE-----

--Yki5U/n4PWHXKr8A--

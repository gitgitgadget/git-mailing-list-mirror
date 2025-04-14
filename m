Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2748B28EC
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 00:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744591701; cv=none; b=LAQsF9KNR3J6hM2oVDx5veN9wXaQf+Wk1bjVXdhuhhAWcFAebGXU7XC3RQ6ghGHjxc+0kUs4dhc5YEL5GisVy+lS61mgHknznH5mZtbn2sbrRI6kQRmAWRVMejrnDxpmB4V0bRK2sbgNCAyA2+LCx9j6YRK9n9wUwMXSUJNEV88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744591701; c=relaxed/simple;
	bh=9cbTsrmlysCqxhCB3n93ysc+MaP8/98ohaEIAFJ1EtI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mwk1Okt0UIkOK4YtdxFP/t+xJwPkUM895xN9c3GZQhSakG6fLAnIL9CbfN1xrMCNHrPlKUg45IS3itOUUyrp1Z2ysZxKyMdi394KE3M+KR04dqHJNtLhnqSv9+MT4tEJFG3bDe+lMGzN37g3GBJCyoyFkD9ypqkGhDLXOwu1FJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=xUSbVl5U; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="xUSbVl5U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1744591697;
	bh=9cbTsrmlysCqxhCB3n93ysc+MaP8/98ohaEIAFJ1EtI=;
	h=Date:From:To:Subject:References:Content-Type:Content-Disposition:
	 In-Reply-To:From:Reply-To:Subject:Date:To:CC:Resent-Date:
	 Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=xUSbVl5U13uBvQv8gRGqOXhbxvHqHX174iFIpUmEuZozRa5aG3t+UI0D3YQKeGNrl
	 O1MNKEZX8icUNvkNOcuKvFSPFO2lbrGbk6qQHI04yKpm9lYvw+z1Lyk2tHvGzCwS5/
	 MqPHDdxnAjBJgxzRB9byC6fdyUmSATBCQzYrjNEA1PidNghrOmiu910gLTqipF+HlN
	 fLsbHRwddSs53ggAuc02KzaFdkouutIKEGq9385Can9rJMhdmKlL3cAa1VyxFkIfFZ
	 1gA3t9KkWjyirgRmHz5bI/A4lL4Uu8MdxRFOWfcDZM/D2ekEe3HQ+dU5oiYhGLb64C
	 J/22USnCGN1tdMu5YN72LMGaDcHAjeYQLB4OxC2EX+3UywNyoYVAlffwCS9GvskixU
	 GkvA5OMmQ0oD9fc1wmXWcX2YLGwBKjMdhIjl34ZBSypcWghg8zp1SUeLR3EGKGdgal
	 jLKmCd09E0zWIjzFKONrtQeY3s1TygIfFhFs6bQLlS0e3bitWGI
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9ec0:b846:49f:a41d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D6FEE2010E
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 00:48:17 +0000 (UTC)
Date: Mon, 14 Apr 2025 00:48:16 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: git@vger.kernel.org
Subject: Re: How to gpg signed email patches?
Message-ID: <Z_xbUDk7ra1-d_gH@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
References: <fx2ofmmhkjmjqfqya5e3qvmovvmpnjepteqobcz4eia5sw64bg@yquuljpwok3f>
 <Z_xAOmQm0e_WE2Dd@tapette.crustytoothpaste.net>
 <0709104c-c951-42be-9300-a0aa9f9eea6c@frank.fyi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IBee2imRRFOo5ZZW"
Content-Disposition: inline
In-Reply-To: <0709104c-c951-42be-9300-a0aa9f9eea6c@frank.fyi>
User-Agent: Mutt/2.2.13 (2024-03-09)


--IBee2imRRFOo5ZZW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-04-14 at 00:23:02, Klaus Frank wrote:
> But if "git am" would support pgp clearsigning it could just easily rever=
se
> that, no?

Yes, but not everybody has GnuPG installed on their system.  It doesn't
come by default on macOS and people will want to parse the emails and
apply the patches nonetheless.

> But I've to admit I didn't fully look into all of the escape rules and th=
eir
> reversability yet. Is RFC 4880 Section-7 the correct one for clearsign
> and RFC 3156 Section-5 the correct one for PGP/MIME?

Yes, although RFC 9580 has superseded RFC 4880.

> That may be, however the signature also shows if it has been damaged
> in transit and that is at least in my eyes a very valuable information.
> (And maybe in the near future to mandate everyone signs (or even
> encrypt) their contributions in order to easily ban "vibe coders")

I agree that it detects patches that have been damaged in transit, which
is valuable, but it also throws a bunch of complexity into the process.

> > > An alternative approach, which has also been discussed (and which I
> > > might end up sending a patch for at some point), is including committ=
er,
> > > signature, and base commit data in email headers to allow reconstruct=
ing
> > > the exact commit with a valid signature.  Whether the maintainer choo=
ses
> > > to keep that signature is of course up to them, but this would allow
> > > the commit to be verified using the normal mechanism.
>=20
> That sounds also good compared to what I scetched up so far.
> This is what I was thinking about btw (nothing special really):

My approach also has the benefit that it works for SSH commit
signatures, which PGP/MIME and S/MIME do not.  I think many people find
SSH signatures to be easier to use than OpenPGP or X.509 and SSH signing
is easier to do when one's working in a remote dev environment (just
forward your agent).

> On the sender side:
> 1. "git format-patch"/"git send-email" sees that the commit{s} is/are sig=
ned
> or it was executed with an explicit flag to sign (similar to git-commit
> "-S[<key-id>], --gpg-sign[=3D<key-id>], --no-gpg-sign")
> 2. Either "git format-patch":
> =C2=A0 a. Somehow embedds the commit signature as plain text [Your sugges=
tion].
> =C2=A0 b. Does "gpg --sign --clear-sign --include-key-block" the entire e=
mail (Or
> [rfc4880#section-7]).
> =C2=A0 c. When "--inline" is specified {multipart message} it creates a d=
etached
> signature ("gpg --sign --detach-sign --include-key-block --armor") and
> attach it as a 3rd "application/pgp-signature" part to the multipart-mess=
age
> (or [RFC3156#Section-5] instead of literally "just" attaching an addition=
al
> .sig file to the mail)

This isn't the entirety of how it works.  I believe the headers of the
internal part (e.g., Content-Type and Content-Transfer-Encoding) are
also signed in PGP/MIME; that is, it's the entire body part, headers and
all.

> 3. Send the mail
> Also "git format-patch" propably should support these gpg commandline
> properties: `--homedir`, `--keyring`, `--primary-keyring`, `--refresh-key=
s`,
> `--armor`, `--no-armor`.

Those arguments are really better left to a script that runs as
`gpg.program`.  There are other implementations of that software that
only support the bare minimum options (e.g., smimesign) and we want to
minimize the functionality that needs to be supported.  I have, for
instance, used a custom script to include a signature from the
environment that was generated on another machine.

That's another advantage to my approach: it avoids the necessity for
additional options to be supported.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--IBee2imRRFOo5ZZW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmf8W1AJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ8wucfnczTJ7fHiTdiKGqeW1dhYrd7zn3piA4T+cbp11
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAIY6AQDJb3CnVbIO4G8fofCqZOzG+a6L
sHh3x5eVphtQ7qfVugEAxblffDR6qVcl7dR7m5cykEGGl7SDl8qUJxx3VzSRUwM=
=+1lA
-----END PGP SIGNATURE-----

--IBee2imRRFOo5ZZW--

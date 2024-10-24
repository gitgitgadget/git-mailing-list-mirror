Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110D3156C74
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 21:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729806741; cv=none; b=gSUhGVc37wkczFAwQgSaH2j3kMi1xMG6hjkq5GkUnQfDaNhOarf8fuGZf9HI9wPmoRBf6A/bQRMRcwJyKn/uMds5VbD+kdcUpQzsd+iRXtRQ+sgjamYFt4cwUUPSSgJFOkMOWTt0sF+fpZAbDDPXNMcjRGpn/gpPSXaUFZ0lMT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729806741; c=relaxed/simple;
	bh=0DbqMbljPiSB56gctp51WRqtEsx9BJrhSVEoArPKf5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHQ9Lncno3i8kT/1fbXlqeuWhNaofYo0MQVYJc4jXdNgsJNsKKXdgcBXHWrrurNf4ZfvzqNZMFVYaCdMyIhdyyB9qk4vDdiyqoYnV73TVeWfYQcY4znBzvSPVZcqjysGT4s/z+qZKiiEWJMbZ/MsQMRexRO91zmccuoxDc1nctY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=zUl4B6t/; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="zUl4B6t/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1729806730;
	bh=0DbqMbljPiSB56gctp51WRqtEsx9BJrhSVEoArPKf5o=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=zUl4B6t/mJuGswOlnB2N4Egf4+keURGcofsYHra/nXkq/GD6mLNI8Q/m6iVdnga/U
	 WvQpXL0RLbvt6km9fMIFdzFG8W+DaSR7XZDiJxTydefZyeRIPXcds46+AMNmk6i5su
	 jgynCki0QIeRzU7SwCMc1gMCUm0bH1WjKkbuJO/zssgKobfbg3UZftPoKJ5pzr8pfC
	 /K3SCaB1F5L8MreyXhBpNA51Ypnd12FrbJ4ewHgvcHI3+ISBcn18cY+bXiBgyWQBh+
	 UG0/jDg00BBqyyje6dlPNjBTVSA+CrAvMvJFPy3gOsEEsRzIhi5la6NpgS0g+va0K+
	 FddDtxlDmF/YwkoARgPutG4KpXqJQYN1mN11VX7VC6NWTz+21Ag45r673xjb734nC4
	 ZZC+MLoe0XoPbR/eNy4Czx1cr5yxEEi7bafWK2X1vsayvRaxzlkseU5dXcFXFsTV2j
	 mqZ1OqReC3R5rm3rFEXoMLqta/slLSCv6Bw9JyLFV/JS+Bt138g
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A6474200B1;
	Thu, 24 Oct 2024 21:52:10 +0000 (UTC)
Date: Thu, 24 Oct 2024 21:52:09 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 12/12] gitweb: make use of s///r
Message-ID: <ZxrBidBicBcipo5R@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
 <20241023004600.1645313-1-sandals@crustytoothpaste.net>
 <20241023004600.1645313-13-sandals@crustytoothpaste.net>
 <ZxjtRXf8IUrvn1tK@ugly>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tMFzUwigEF1GmBya"
Content-Disposition: inline
In-Reply-To: <ZxjtRXf8IUrvn1tK@ugly>
User-Agent: Mutt/2.2.13 (2024-03-09)


--tMFzUwigEF1GmBya
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-10-23 at 12:34:13, Oswald Buddenhagen wrote:
> On Wed, Oct 23, 2024 at 12:46:00AM +0000, brian m. carlson wrote:
> > In Perl 5.14, released in May 2011, the r modifier was added to the s///
> > operator to allow it to return the modified string instead of modifying
> > the string in place.
>=20
> > This allows to write nicer, more succinct code in
> > several cases, so let's do that here.
> >=20
> "several" is a bit of an overstatement.

I can rephrase if a v3 is necessary.

> > +++ b/gitweb/gitweb.perl
> > @@ -1188,7 +1188,7 @@ sub evaluate_and_validate_params {
> > -				(my $error =3D $@) =3D~ s/ at \S+ line \d+.*\n?//;
> > +				my $error =3D $@ =3D~ s/ at \S+ line \d+.*\n?//r;
> >=20
> i'm a fan of "excess" parentheses where the syntax relies heavily on
> the binding and priority of operators:
>=20
>   my $error =3D ($@ =3D~ s/ at \S+ line \d+.*\n?//r);
>=20
> which is arguably semantically clearer than the old idiom, but not shorte=
r.

I don't think those are necessary.  It's obvious to people who use the
s///r idiom what's meant here, and in my experience most Perl code using
that idiom doesn't use them.

> > @@ -2700,7 +2700,7 @@ sub git_cmd {
> > -		map { my $a =3D $_; $a =3D~ s/(['!])/'\\$1'/g; "'$a'" } @_ );
> > +		map { my $a =3D $_ =3D~ s/(['!])/'\\$1'/gr; "'$a'" } @_ );
> >=20
> i think
>=20
>   map { "'".(s/(['!])/'\\$1'/gr)."'" } @_ );
>=20
> should work, and is an actually significant improvement.

I'm sorry, I don't necessarily like that much better than what we have
now.  It's not that I think it's awful, just that I don't think it's a
significant improvement.  If I do a v3, I can omit the `$_ =3D~`, though.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--tMFzUwigEF1GmBya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZxrBiAAKCRB8DEliiIei
gZadAQCdW2TY9iqpBPnWYnawAQ2t4WIcw3wOSrFd0XS4EDKAPAEAr1xgPFvyeFTe
9ljUV+fa8ESsNrFBbqxIEr2xvM0vkwo=
=5r8p
-----END PGP SIGNATURE-----

--tMFzUwigEF1GmBya--

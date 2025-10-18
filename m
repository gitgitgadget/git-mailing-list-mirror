Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A211872602
	for <git@vger.kernel.org>; Sat, 18 Oct 2025 00:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760748740; cv=none; b=dNQCP9ffZyIQ/Pp/7sVYggChc47VGAtJpw4dTMX9J9KUltjs6YjJ2XMZmXgY3STHc6fK+3X2QSXhDTaEmVEkVWseXJi0KGNsGIugOzUCicXxnG1avGi4AQD7q6Q3lw71tGEq4R7w54oMvKPzibdSx1EZ88G7na8PnA0E+ZCGXSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760748740; c=relaxed/simple;
	bh=4Na764+tNkbgcdAVGaU0e0omMIH/hMpQY3RPA1E+2qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dekK25I73XBo72JE7iyYXG0GAjR7Xap85g3hn2oWKymCzGN7BAW6XHCdFoNyRNpQY+WRrBzc2IMGcllWoFMevqh9UfSo6NLaYef8qvLoGbRZePc8jSEJbLiRbCImkLqTG7nC/qDEef5A0KZ1h5+EkFWwbZIv0ISOMRH7gSjas1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=YvFPEFlS; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="YvFPEFlS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1760748729;
	bh=4Na764+tNkbgcdAVGaU0e0omMIH/hMpQY3RPA1E+2qs=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=YvFPEFlS0Yh5xo77dcQTTWtsQ4FsUsJ9pwHfe0wsHKe5RVNwqDC67GWoH4OZvULF8
	 aB8E/fRRnhb9dP3uWDYy+u4ZangjLNOhQjyL9Gs3QSrjd3fOafQnr6ukI+uNx5ezn0
	 0iNrCdf4OFjoJ14K1mG2vMw8CTcCPIDnFJEpKoT2BJvN/GQGajYsRrhIk7NgSfRtvR
	 lmtnuhHl/78HdFHJONODbcO5J1yBC8jqGUktc6h+ZZYe1OAZ/S54xVdlNQ5X0h2mm1
	 3nSx6rd6EgURgE1apgPKMrc6usXlcfleUPUFbwS7nNVEM0Mkig1InWpM/RcZ94rRif
	 91UqVbg4/2YFSDSgpL1fTM+7ZNMswWx1h+ce4xRuyOf57+8czIa7KHHG9sf0l9Bunb
	 +6+4lTL2tTiMl/66kaDUQEa5w5lDJpAi32srIIE/b5Yz1yKzc1Bp8NvG4bTcvgCGuz
	 jugzzYeRQL4CJ8qvUw4kxRfjtNI1Goa0ET/YjKOatSJmOCnRPwT
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:fb31:c7ba:73fa:92c5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E0DC020008;
	Sat, 18 Oct 2025 00:52:09 +0000 (UTC)
Date: Sat, 18 Oct 2025 00:52:08 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc: Junio C Hamano <gitster@pobox.com>, El_Hoy <eloyesp@gmail.com>,
	git@vger.kernel.org
Subject: Re: Making git grep ignore binary the default
Message-ID: <aPLkuPgirAVHkERr@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Thomas Braun <thomas.braun@virtuell-zuhause.de>,
	Junio C Hamano <gitster@pobox.com>, El_Hoy <eloyesp@gmail.com>,
	git@vger.kernel.org
References: <CAPapNH0C3+bU-RUO6oFHUKLjKuNdm-aXgsFTHFobYVrJXWzr=g@mail.gmail.com>
 <xmqqsefhxlmd.fsf@gitster.g>
 <0de410fa-22ef-4495-a6a9-dcd33a329201@virtuell-zuhause.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ee1sYxueL/S+2Fvn"
Content-Disposition: inline
In-Reply-To: <0de410fa-22ef-4495-a6a9-dcd33a329201@virtuell-zuhause.de>
User-Agent: Mutt/2.2.13 (2024-03-09)


--ee1sYxueL/S+2Fvn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-17 at 23:29:22, Thomas Braun wrote:
> Am 17.10.2025 um 23:29 schrieb Junio C Hamano:
> > Simply because we have never needed to do something similar to "-a"
> > and "-I" that we added in early 2006 for the past nearly 20 years.
> > Also because GNU does not have any such thing to force "-a" or "-I"
> > as default.  The biggest reason is that it would be surprising if
> > such a change does not break existing scripts that have been written
> > by people over the years.
>=20
> And if we only would have the config option "grep.ignoreBinary" defaulting
> to false with no default change whatsoever? I always want to ignore binar=
ies
> when grepping and find it a bit tedious that I have to spell it out all o=
ver
> again. And yes I do have an alias as well but usually don't remember to u=
se
> it.

As Junio said, this could break existing scripts.  If I write a command
which uses `git grep` and expects to find all matching files, it would
not work on your system with `grep.ignoreBinary` set to true.

For instance, if I am working on a project for a company and must
exclude source code with a certain vendor's copyright (because we don't
have permission to distribute their code), then it would be very bad if
I accidentally distributed that company's binary files due to `git grep
-l PATTERN | xargs rm -f` not matching them since it would violate the
license.

This is just an example, but there are lots of cases where people do
really want to search every file.

> I'm also curious what people are looking for in binary files with git gre=
p.

It's common to mark PDFs or PostScript files as binary because they
often contain embedded binary fonts, but they are actually mostly text
and can be usefully searched with grep.  For instance, I once created
some awards for a non-profit based on combining standalone text-based
PostScript code along with output from groff, so those independent
pieces could end up being source that you might store in Git and search,
even if many configurations would use `*.ps -text` in a system
gitattributes file.

Sometimes you also have images or such for a website, which contain XMP
metadata (a form of XML-serialized RDF).  Finding those images which
have certain author metadata or a certain license URL embedded in them
could be valuable.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--ee1sYxueL/S+2Fvn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaPLktwAKCRB8DEliiIei
gcrGAP942bbzDPpDoV3026R51EIES7M8YawUEMRLZm1hBrTMJQD9E0q9Q6HNol79
ukeNFznHRoCSbg20JeCj1VHlS8MS5A0=
=RLq2
-----END PGP SIGNATURE-----

--ee1sYxueL/S+2Fvn--

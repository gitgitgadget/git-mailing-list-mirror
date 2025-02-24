Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9488C1F419C
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 22:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740435004; cv=none; b=co4CanvFO76QlUg0vLWKfxThwNJcNiKfY3WhqMOi9uFIBKABRyF3DvukR4SwhSiYZFaFBOZ4mXaSOpdgzRXrrmZQhbEr/APkFA9U7N8idI8IbVDG/OuMvtZpEpOPC8qojh43S7aaX/1uKwxGzHYVJhaJjdNxmYZMvGyGlgdyXjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740435004; c=relaxed/simple;
	bh=UcOJMnjgVhbX2i3GOhjgPkTUuYmaoOu6xH6kt8g15bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdHxKo9uxuQEtQgZ5gcbRVFmq78lO6iTGlbJBrmqDktsb/icFDIHxx1nTauH1q77dP+dPAMzCIGTYIuucTM/vaFw3M2PZqbSrx7q4UW8EX9cUBkuCK9E06fSAtRNpb2sdb0+QjXy/QBOBXeCpvT1c836rpfqAGR/VeksOmis8QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=ZRKihqVB; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ZRKihqVB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1740434993;
	bh=UcOJMnjgVhbX2i3GOhjgPkTUuYmaoOu6xH6kt8g15bA=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=ZRKihqVBxsWEORYlog6CuJn5yqlasm7+y3SzaQsaZUG90v/mEqVfPoJz7DX5cQqjz
	 1OHLAmguGGLGoite0K9lfXLrrICoFjv1GbgrX3qnofxESioMFdy5aWKy7FTVy1yZmC
	 MvfgHFKOAiIGYCFAajqMXF7Hcn3rt/Pt4NQCLf8zOCGiCV0pnuBAXJlZtOyG5827P9
	 tsz2MSEpesIupCpS/Q7qe/Iei32BklQOCBSkDEw3Xpb8YLsk6S+g0UMRtJah9X/hyk
	 60toL7djdjQGyaaINqU93Fso/3P19UcBhOa+xvqz3W3V3tcFzic5UV7s51Yiqa50dd
	 7NiV88GqC0ck1BLbcZkasPwTJiA+Jrld/yYxuRhQz/AtxVt71rT6xMBnVQj8hPm81x
	 idivZruQNx1deMtj0Mjfz7ePwQxwzDGZYba49lWualSWZOc6aVM9IZ6Lk+AJv+Tik8
	 51VGrGqfTbdW/F+gJ8syo4RXkmRAyUVfeJxdOI3a99QWCHxvMFD
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id BF0C62008B;
	Mon, 24 Feb 2025 22:09:53 +0000 (UTC)
Date: Mon, 24 Feb 2025 22:09:52 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/1] Fix netrc usage with WebDAV-based HTTP protocol
Message-ID: <Z7zuMBVrnX_pLE0K@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <Z7UPYY24uk7lLzeP@tapette.crustytoothpaste.net>
 <20250223015331.588161-1-sandals@crustytoothpaste.net>
 <xmqqa5ab70ka.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WceEeUdIA+Dc2Cxr"
Content-Disposition: inline
In-Reply-To: <xmqqa5ab70ka.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--WceEeUdIA+Dc2Cxr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-02-24 at 16:46:29, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > However, I think we need to either decide that we're going to support
> > this as a fully-fledged feature and add documentation and sufficient
> > tests, or remove it, since it's not reasonable to have undocumented,
> > untested features that people rely on.
>=20
> Does "this" refer to "use of netrc in HTTP code paths", or "HTTP
> walker"?  I am kind of surprised that anybody is still using the
> latter, regardless of where the credential is locally stored.

It refers to netrc in HTTP code paths.

There are definitely people using the WebDAV-based HTTP protocol still,
but after reading the comment in the code that implies that we don't
read packed-refs, I'm less and less inclined to say that's a good idea.
It's probably going to die pretty quickly when we move to reftable,
though, since that protocol only works with the files backend.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--WceEeUdIA+Dc2Cxr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ7zuMAAKCRB8DEliiIei
gemtAP4mZiWTA5Lj/nvnqAYDdSQoTKD+1N4KGCp1r6y2rk8yTgEA+0V/6CZfyDUd
euf6eZCgdGTP2DpWBWuyBFSqG4kODgI=
=MOyd
-----END PGP SIGNATURE-----

--WceEeUdIA+Dc2Cxr--

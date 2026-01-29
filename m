Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957E11A76DE
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 22:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769724075; cv=none; b=c3F7YSVTtfk6f2gvPUVe26R2r2Gtjw9+4KGis4ivBzHdI/kJ0kSLBhR0wN9OVbLrR3CERIX+Z6ELX9mMXQhuybUHNFW+s52mRgyRWipYyn1rhAtHJaFsJ3QOdu6yvcfphCNPGk9MnUxDxk48jv7Fn67TF6gr/Fz+eVw7tptnvwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769724075; c=relaxed/simple;
	bh=1U9JNVh6tZEiKD8SIATnOFDDX8yNWGX0c78tJscreyM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RoM2kE0qpa93gGCqf2Heqvs6ITyh0GHBoqwmxo5g+w/qYvtqxC8NMhU7T4bjJWzX0BmnQaUtAOlzMNqhBi14WUhbMSVFMZuKOeQHS15O7S6PyilsXy++OyGz1mHVR/DjOfQFTkjj1w2qaW+9E+G18avbVou0kwMfwD3oTlrc7jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=sdFNstpE; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="sdFNstpE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1769724061;
	bh=1U9JNVh6tZEiKD8SIATnOFDDX8yNWGX0c78tJscreyM=;
	h=Date:From:To:Subject:References:Content-Type:Content-Disposition:
	 In-Reply-To:From:Reply-To:Subject:Date:To:CC:Resent-Date:
	 Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=sdFNstpE2Q+Zet9OhO5y3E0a1zSc3amhG2C3tk29jBKjBUl+YQTaU1mkwsJrYzi5K
	 1WD9NFklKetDYOKFZudZrmQ/RBmNMsW4k8mUpvlZgjxPyyPEQlhU+xEUErqDzNNJTk
	 8BgCMjS3NzOS34R164QdxDna3Qsxsg3bwl/DtVAjDpkWs3qhCS2YkEVLZtmuToXvM+
	 2w0mZlUYLHX0fDuYcS9i70bgiK03tqGqeLx/9voTKY8xVGaQJaCpk5+FVJ2Mbfdg74
	 pCqXipwG62tSUV+MNrkDMOYSGe0r1g0QGe8c/SHZg4NBGCRSfEPGIz9rc5B4DLVmyC
	 7dsjfX1r8efqzVUlIhrifPHYXQFcTpTLNet+UiFhFIpUBhIfZff6KEMWJk9aqTHjhe
	 cc0S3Rcq980HXhesfEG9F/olka0n0RlpH3TEt6evXsIXya84qgMjqigSxBr6OS9LZF
	 iljyLnNDw7dt51GVq2tvmILdqR+x/5Bw1BNerEez7XSobGq06I8
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:bf0d:4ae6:75ea:91b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id DC298200B4;
	Thu, 29 Jan 2026 22:01:01 +0000 (UTC)
Date: Thu, 29 Jan 2026 22:01:00 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <junio@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2026, #09)
Message-ID: <aXvYnCsXPV0yefyD@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <junio@pobox.com>, git@vger.kernel.org
References: <xmqqecnbeyvr.fsf@gitster.g>
 <aXqSyn3Mfcgs8MUG@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+/GEG2BnKuhjDdag"
Content-Disposition: inline
In-Reply-To: <aXqSyn3Mfcgs8MUG@fruit.crustytoothpaste.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--+/GEG2BnKuhjDdag
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-01-28 at 22:50:50, brian m. carlson wrote:
> On 2026-01-27 at 17:42:00, Junio C Hamano wrote:
> > * bc/sha1-256-interop-02 (2025-11-17) 15 commits
> >  - object-file-convert: always make sure object ID algo is valid
> >  - rust: add a small wrapper around the hashfile code
> >  - rust: add a new binary object map format
> >  - rust: add functionality to hash an object
> >  - rust: add a build.rs script for tests
> >  - hash: expose hash context functions to Rust
> >  - write-or-die: add an fsync component for the object map
> >  - csum-file: define hashwrite's count as a uint32_t
> >  - rust: add additional helpers for ObjectID
> >  - hash: add a function to look up hash algo structs
> >  - rust: add a hash algorithm abstraction
> >  - rust: add a ObjectID struct
> >  - hash: use uint32_t for object_id algorithm
> >  - conversion: don't crash when no destination algo
> >  - repository: require Rust support for interoperability
> >=20
> >  The code to maintain mapping between object names in multiple hash
> >  functions is being added, written in Rust.
> >=20
> >  Any progress on CI breakages???
> >  source: <20251117221621.2863243-1-sandals@crustytoothpaste.net>
>=20
> Not yet, but I hope to spend some time on that this week or early next.
> I now have some more time to work on this at work and I can try to poke
> around and figure out what might be wrong, or at least try to beg a
> colleague to try things on their Windows VM.

I did not get a Windows VM working but I did discover the problem and
I'm working on a patch and will send it out once I have CI green.

The problem is roughly that both the MSVC linker and MSYS linker are
both called link.exe.  When compiling with Rust against MSVC, the MSVC
linker must be used, but the MSYS linker is first in PATH (because I
believe installing the Git for Windows SDK causes that to be the case),
causing build.rs to fail to compile.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--+/GEG2BnKuhjDdag
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaXvYnAAKCRB8DEliiIei
gc7zAQDzX5TY4a6PuFaektAa1aQw/3Sxm2gOnI1xhAOYfWf2DAEAjXJ42EjnhM18
7dpRVsp+neVLrUNBpu2Eu/DrtSKxVg8=
=BKta
-----END PGP SIGNATURE-----

--+/GEG2BnKuhjDdag--

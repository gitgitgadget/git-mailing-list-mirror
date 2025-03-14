Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A387206F33
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 20:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741983168; cv=none; b=pu1d/wjCkcC6MilSBl3igywk4KSJ0AV38LHKg46xUq/n27akDdGiAsXJbcfUz0YraDOqboqamYjD23MbnGBBOAfxIvFFB+g1S2cHmbDFYXuW8HCkY6ungQU6peOvgrCUqS+FDMFIvFZJvBbtXnIRSxGG5lRvCbZX1I6r5v0tsLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741983168; c=relaxed/simple;
	bh=BDx7OqSao4givtXRRspk+ROgNeVTM4kg9OWnGPSoWNM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ql40lt1yh0SbRXRmCe4iXt+UYRArhBFhmnc1XEwJR2wseTmjzVWCIg1KKCb/LDJN/ajNEXvZMSZggC7lx0qaNv28BvWhhkBhpSDa+MTOIo4+RhIl70eKL4VH1GB7zAI0bgVBS45HingqyidInEQ3HKRIeo3IZKLqAYEXMy/K2LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=fvja0mlt; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="fvja0mlt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1741983162;
	bh=BDx7OqSao4givtXRRspk+ROgNeVTM4kg9OWnGPSoWNM=;
	h=Date:From:To:Subject:References:Content-Type:Content-Disposition:
	 In-Reply-To:From:Reply-To:Subject:Date:To:CC:Resent-Date:
	 Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=fvja0mltXw66Y4Jir4YXLmMh8jtreMfKItFz5XZcaa7bbjclZhb2EH/6pHQeqqMN6
	 p8H58QYK03ONNUekqkPP7QuR4mQS8Q8lf0DJfjkyflZL8a3fJN9h0CvxI7NxdEI/CZ
	 /P4vS2T0kPSG1vlfJJctANaa8mTPk08DGxT/fRx+H8G4eLW6e4tHOlnCcGUTa97lRC
	 NZCDjmbj40Na9TagV/x/nWgdGp54yTg2Dv7BYXOeFf5KyTeSYbKK0IW1TzhskgoFwF
	 VqgEmKXLVhj7nJgNtxw7DU7fhC+oDgU+hHhnsSwNHmJXs3dHSxImXoMxYgg+wH88J2
	 dAhzp8xXBMZIRGC3A3rERpohXrVCIi+8wNCfCtPm1oS3FNRrDw4ev8LJNmwrBuPIHM
	 VTqhR+TU2NfkXFUHFPkVTEYIMuAQlZHzyfRbWmEgcXpO9hjJF0IKANEq4YgOpkBm7d
	 Rz75rNM2ylI10E1lCH+vTsRYpZCpIwot+3I+nhPHGfVyVCwKSMX
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9ec0:b846:49f:a41d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A5865200B7;
	Fri, 14 Mar 2025 20:12:42 +0000 (UTC)
Date: Fri, 14 Mar 2025 20:12:40 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Josh Steadmon <steadmon@google.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, git-packagers@googlegroups.com
Subject: Re: Problems publishing Rust crates (was: [ANNOUNCE] Git v2.49.0)
Message-ID: <Z9SNuI6hSpKEfv5A@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	git-packagers@googlegroups.com
References: <xmqqfrjfilc8.fsf@gitster.g>
 <4zi3re4viluih7qwvwlu7mp3j6e6gjexz2bppa5am45nnqkezz@7vtwmyrfdwvi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9hZzClyPxjcB9JWp"
Content-Disposition: inline
In-Reply-To: <4zi3re4viluih7qwvwlu7mp3j6e6gjexz2bppa5am45nnqkezz@7vtwmyrfdwvi>
User-Agent: Mutt/2.2.13 (2024-03-09)


--9hZzClyPxjcB9JWp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-03-14 at 19:43:32, Josh Steadmon wrote:
> On 2025.03.14 10:16, Junio C Hamano wrote:
> >  * Foreign language interface for Rust into our code base has been adde=
d.
>=20
> Unfortunately, I've run into problems publishing the new crates to
> crates.io. Specifically, the build process for `cargo publish` is
> different from `cargo build` in that the root of the repository is not
> included, and therefore our build.rs scripts cannot find the top-level
> Makefile or any of the Git sources outside of `contrib/libgit-*`.
>=20
> To prevent squatters from stealing the libgit* crate names, I've
> published placeholder crates, which we can replace once we've fixed the
> build issues.

Thanks, that seems fine for now.  I'll note that we're technically not
required to even publish them on crates.io since Git repositories are
supported, although of course crates.io would be convenient, and we can
decide later on how to handle this most appropriately.

I think `cargo package` should do most (but not all) of the same checks,
so we can use that as a testcase to see how things work and explore some
options.  We can even run it in CI if we like to avoid problems down the
line.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--9hZzClyPxjcB9JWp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ9SNuAAKCRB8DEliiIei
gSYcAQDShRzOrsZE95Bsczs055YznkcIf0xlpKutU99+A8Ep3wD+IZ/J0h18TqH5
t+WuE1pwLjnz+J63FO1WPXrVSIYPGAE=
=i8OY
-----END PGP SIGNATURE-----

--9hZzClyPxjcB9JWp--

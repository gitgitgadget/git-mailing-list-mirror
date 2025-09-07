Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F118F17A2EA
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757257637; cv=none; b=miWnOuTWRj9ELAcmfW1MarRn9B5vQgq3y81I7h1YrIQThSKN0w1qpFtjy4jzrFRnd8J5iXtMkFpss0MOpShR/ec2N9Ln1V1TZc21r+B3x+wULcddkbNryWe9UlRDkgpkB+3kLqRPGWOKtzmq0JCYw7SHIPor1qXsdm54Ww+UwGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757257637; c=relaxed/simple;
	bh=p2SFvpiS8TGIJ2zfwfweOdRoRIAn5ge3rNbeOqS+Nh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZiSWOHiI21M9s7Z1ruwwsDZntBF7+qnjw71y2Iyrxf3XxYNfd1qBpwM5Ehdt6DWNxOfzgNxtEWLIWxnUQxXxRDSjaobbabPJ3qn91rKixiI5JHQPiILx8L7JDjCuvggvgrYs9bQBEdPzNB3oWF7ZrmJR3N9SgCcuC4PcePtZHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=PZi2rwl2; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="PZi2rwl2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1757257632;
	bh=p2SFvpiS8TGIJ2zfwfweOdRoRIAn5ge3rNbeOqS+Nh0=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=PZi2rwl2ZkYLXJXV1Q6phGGrgZXR0vcRcUIiOutQPtvEI73zbi6W5VSyazXO0ffMf
	 rl7KSfhrJNPWYCCFnp+SisFiRmn5AXayrljVsKy+yhut+tAVnLeN+kosEa3IqVF5xu
	 82rWuT/PbtAhmIzyDIoS1cAbW+DUyOA5w+551Mh7LsiqCCPd5/VXX8p74kAm79M6PE
	 xdrIVj2Y5OkvK6UHn70te31ubCRgwijiTDIT8vLWfC7/r15CSQqAbc+iCtYDeJDpCa
	 zw62Ut/yebyeoUJDK/2aEq1janRCx0bir2pNj0f2Xhua6BJAxe0NWBaH06ooUPfnHw
	 +weQ8ZhlGPCW/LGSQrVmmTw8FytMQjyi66HABxZE0pw+K66jVvcfCBx38Jhk8zVA3D
	 qZ2Ux4uj4fo/ASQa9s76zo9VdoNAqHiF++R8gNiENdCLh+ufVDZErZzAxZ4mWZ7mEY
	 zeels0Awkh6UhrE3lKLB7X+z3kTv7t9s1qEwrkb+3U5lBdrCjKV
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:3b61:a7f:90:9d10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8FD12200C9;
	Sun,  7 Sep 2025 15:07:12 +0000 (UTC)
Date: Sun, 7 Sep 2025 15:07:11 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Milan Hauth <milahu@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Git dumb HTTP protocol should work without update-server-info
Message-ID: <aL2fn4j5uhrVWrDp@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Milan Hauth <milahu@gmail.com>, git@vger.kernel.org
References: <CAGiEHCtP29bQRsEyLabNrLuiP96P-o7EEGi88B7pJbP0tfprxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fp6npeyrw4YhEh5o"
Content-Disposition: inline
In-Reply-To: <CAGiEHCtP29bQRsEyLabNrLuiP96P-o7EEGi88B7pJbP0tfprxw@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--fp6npeyrw4YhEh5o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-07 at 11:24:13, Milan Hauth wrote:
> this works:
>=20
> git ls-remote /path/to/repo2/
> git ls-remote /path/to/repo2/.git/
> git ls-remote file:///path/to/repo2/
> git ls-remote file:///path/to/repo2/.git/
>=20
> this fails:
>=20
> python -m http.server -d /path/to/repo2/ &
> git ls-remote http://localhost:8000/
> git ls-remote http://localhost:8000/.git/
>=20
> workaround:
>=20
> pushd /path/to/repo2/.git/
> git --bare update-server-info
> mv hooks/post-update.sample hooks/post-update
> popd
> git ls-remote http://localhost:8000/
>=20
> expected:
> dumb http remotes should behave like file remotes

In general, that's not possible, because HTTP doesn't support native
atomic operations.  An HTTP push locks the remote with DAV by preventing
other changes to `info/refs`, which makes the operation atomic.  If
that file isn't there, then there's no way to guarantee that the ref
update isn't competing with others, which might cause data loss.

In addition, HTTP also doesn't support native machine-readable directory
listings except with DAV.  However, we don't require DAV for fetches, so
we need a list of the refs and the packs in order to be able to download
objects correctly.

> > git --bare update-server-info
>=20
> that command creates the file
> /path/to/repo2/.git/info/refs
> but that is just an optimization
> for http servers with high latency
>=20
> my "dumb" http server
> is smart enough to handle http range requests
> so there is no need
> to download all the files from .git/
>=20
> but also without http range requests
> this should "just work"
> and the user should be responsible for optimizations

As I said above, I don't think that's the concern here.

I will also note that the dumb HTTP protocol doesn't work with reftable
and there was some suggestion of removing it for Git 3.0.  It certainly
will not work out of the box with Git 3.0, since the default is
reftable.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--fp6npeyrw4YhEh5o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaL2fngAKCRB8DEliiIei
gZcMAQD4EFIfClnDMUSmEqjrM3nwsUsud/2O/oTO+PKmMHbhMgEAuU+l3iy/sSwu
3FSCgANJEtTvX943G1Zs2spNZeDNxAY=
=HJMq
-----END PGP SIGNATURE-----

--fp6npeyrw4YhEh5o--

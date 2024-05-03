Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A631EA87
	for <git@vger.kernel.org>; Fri,  3 May 2024 23:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714777581; cv=none; b=WxM1Ys9knNf6Bwuga+X3aY/xtP2mOMTGIFVbpxGDwKEe6hHnsEvT0KonZZIDJEWeJfJ+ix+CCrph6xGvTUWM1B3pn60KmI1mqWu1BchnkBohcbXgGW+0Qh1WBEVSxRNVAxuj7Kg+BpWhawd+KPZZN4aDhsyzyX0kyppjPtxHpPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714777581; c=relaxed/simple;
	bh=Ym/yDuhaxtq21au+3pNmlTVrNhPYT3cmE9IcwYF03yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzmFOq8RuFAna+hbwt5zTU12DWvnsfLUXyZP+rHMucMKKqdOWIvPtrCCtpmkZDBmOx3a3uwDM+FbqEE7/FlFgDJlQwkJ3ECsdVO4nhDIKk7ibNCmV7flmHTqQFsIZy6Q2N0WiV2FjkdEI7mB2eBVLWIrz35L+zyjEG9irYkudY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=O7Dn/kWU; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="O7Dn/kWU"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id F400E5B2EB;
	Fri,  3 May 2024 23:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1714777576;
	bh=Ym/yDuhaxtq21au+3pNmlTVrNhPYT3cmE9IcwYF03yY=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=O7Dn/kWUr57IJfGLbbLo8lPvMwGCRqSXyHitLxRYnPEescW7B+udEwiF1eOdZq1nU
	 2TgIsXZKsSXCePOr+RyN0lKltRiSFFSj9OM/0j2iBi7ErKQjhLhMnX5llxLiEqJUq9
	 x7r9faCDSK7dUvEWVGk+farZsZsrsrUwgOm2Uzuy5xhsMBqHIGUwtxBYqn2YVUPmHT
	 +m/gfqEluxK7uCHz9bBRpqhfrdRAtyjWUTSjhVJvVYNQ/+7VIUGlGs9Uzpwjdc+75o
	 RbodHCndvrCGoFuIJcJfXuA9FeiUJhG+wnEauVMm6EH0pX6sIICivRVTb4TRMgVEG4
	 jyxSvefCptRwnLVhe07UgCIT+zH48/e54r3Cl49zaMJdZWPQWUovvSDaVytBxWn2lK
	 7l0DCIzoZuIzMa2EyuJ7gqRJQ2+eBmI4XAUBRSFdj3CDEmYOHhps0cRCzh3ugv5ajC
	 W5socUei/dq/zdVy4p9mVfZj3QKsAC42sn0A6tE/goEQ863OidA
Date: Fri, 3 May 2024 23:06:14 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Simon Thurston <simongethurston@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [Bug Report] git config includeIf not traversing symlink
 subdirectories
Message-ID: <ZjVt5jtC8cKgWpqQ@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Simon Thurston <simongethurston@gmail.com>, git@vger.kernel.org
References: <CAKx51amU_c9EU+573RWDc0+w3V2u5TSk+mQhts1gYyKRhxGCzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="11arV8MNgvAGXHzE"
Content-Disposition: inline
In-Reply-To: <CAKx51amU_c9EU+573RWDc0+w3V2u5TSk+mQhts1gYyKRhxGCzQ@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--11arV8MNgvAGXHzE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-05-03 at 21:31:59, Simon Thurston wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>=20
> What did you do before the bug happened? (Steps to reproduce your issue)
> On Windows. Create a directory. Configre a gitconfig file to includeIf
> gitdir that directory. Add any configuration you wish to the gitconfig
> file pointed to by the includeif path. Inside the created directory,
> create a symlink to a UNC Path/Network location. Change directory into
> the symlinked directory. Run git config --show-origin on a configured
> value.

I've included a shell script below that tries to provide a testcase for
your reproduction steps.  Since I'm on Linux, I don't have a UNC drive,
but I created a different location outside of the repository called
other-dir that simulates the same behaviour:

----
#!/bin/sh

tempdir=3D$(mktemp -d)
cd "$tempdir"
cat >config <<EOM
[includeIf "gitdir:$tempdir/dir/"]
    path =3D "$tempdir/other-config"
EOM
cat >other-config <<EOM
[user]
    name =3D "Foo Bar"
EOM

export GIT_CONFIG_GLOBAL=3D"$tempdir/config"
mkdir "$tempdir/dir"
mkdir "$tempdir/other-dir"
cd "$tempdir/dir"
git init -b dev
echo "In dir ($PWD):"
git config -l --show-origin
ln -s ../other-dir other-dir
cd other-dir
echo "In symlink ($PWD):"
git config -l --show-origin
----

> What did you expect to happen? (Expected behavior)
> The value configured in the includeIf path to be found.
>=20
> What happened instead? (Actual behavior)
> No configuration data found.
>=20
> What's different between what you expected and what actually happened?
> Git seems to be unable to traverse subdirectories that are symlinks to
> include any git repositories stored inside them.

Assuming my reproduction steps are correct, this is expected.  Git
always determines the Git directory by resolving it to an absolute path
containing no symlinks with the equivalent of `realpath` on Linux or
`GetFinalPathNameByHandle` on Windows.  The fact that your working
directory contains a symlink doesn't mean that the destination of the
symlink is part of your repository.  In fact, if the destination of your
symlink is on another drive, it cannot be in your repository at all,
since Git cannot handle cross-drive repositories at all.  Since it's not
in the repository, the gitdir pattern won't match.

If I've misunderstood, could you help me understand better by providing
a small shell script that can reproduce the problem you're seeing, so
I can provide a better answer?
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--11arV8MNgvAGXHzE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZjVt5QAKCRB8DEliiIei
gU/GAQDD1rfbUKlCIQpxRgEp5NDGdLFmCMq6rl0OYdMoll0hkwD8Ci1QfsA1ZU0P
jqWar8DmlHqNeQ6W+NaljDemOI9/mQo=
=Ohnd
-----END PGP SIGNATURE-----

--11arV8MNgvAGXHzE--

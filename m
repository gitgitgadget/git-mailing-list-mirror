Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F97B185952
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 21:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728337704; cv=none; b=Ci22M2BliUKxuJr9iAmtnk6EsE9V4I2IVFGDbDp6IEF0aDUo7fZfHb3me4u2PFhGt9B0JQYBCyezllIf2BeeQ2a8iTFryMKsGtK6kO7p7MRXN3vg6AmccaPmnRclIX+NvrMcavvusXfn4qDiKskggeMob1R0c4knK1O1iXfbTbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728337704; c=relaxed/simple;
	bh=BFsL231W1slz1XyPig+qsj1KzdhCO89yTcOxeM8qtDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLsxyfPX0v8r83FUxiWnx8PE4CLPIcvxugyMVX9qqupTD50/W1TUhHYFhcfl8Y1P5nlvRsvcjb/8+4yjXG2ONvONXNbINMSPjR9iYj2LuB8xCIpG6YLrlZEIj3cRKuoBgUski6AA9S5So3hd5gmRq79xLx7sjWkDNykk2qlm2mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=pNTHmRf3; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="pNTHmRf3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1728337695;
	bh=BFsL231W1slz1XyPig+qsj1KzdhCO89yTcOxeM8qtDs=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=pNTHmRf3CuIqhNDoXVyTR4V7dXtNHWW86J3mE49fUXNh0RChw27K3rznGQKCFgyNj
	 Qha3cdrIog+3bpeGq3Y5Pw8dV5FT0RNCMe0Unfekdi4++GnhRRyjDindxH4H8Rwkam
	 rjehMgqU6OqCu6Jj7enKU7sEwJXCoJBkiTvWQ2elPn3h0LMAn45xMUnChbaDgF0yQt
	 LBxR83pXOKGe/j358/TNmKzfV9ukiICkc7hpta+XGRnLx3pyS0A8ld8JrOQHxcHWpP
	 IQFgGKy1ZMU5/wBfhpswCe9QvUNqbOGrLFPIrlE/rRc/r2DWnd9alrShbLeTmYypxk
	 SC1G79fl+SzALiFmp0L6JCc+L2Xe3dO+5Gsl+X/047Gp2QV1FKE+/CARlK07PgUzJI
	 lTUN2w2jStmcCAP1H5qWpaEeZE5hj328mUe32dVerZ02yLLmIeA/aCkGCnqOZqWlKU
	 KHHw6M/2W5dfKwQJy9rAL0f/+5roltJrrzwUjWmkJmLOVdXqq5O
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 6632A20081;
	Mon,  7 Oct 2024 21:48:15 +0000 (UTC)
Date: Mon, 7 Oct 2024 21:48:14 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: benaryorg <binary@benary.org>
Cc: git@vger.kernel.org
Subject: Re: how to use git with unreachable paths (namespaces, proc)?
Message-ID: <ZwRXHlzzeSvh7SQR@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	benaryorg <binary@benary.org>, git@vger.kernel.org
References: <353abc17-d65b-409f-8784-e2267e2be243@benary.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zPB4tNMi479gd0UY"
Content-Disposition: inline
In-Reply-To: <353abc17-d65b-409f-8784-e2267e2be243@benary.org>
User-Agent: Mutt/2.2.13 (2024-03-09)


--zPB4tNMi479gd0UY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-10-07 at 00:59:43, benaryorg wrote:
> Now as far as I can tell this is because git tries to resolve the
> symlinks in the path (/proc/$$/fd/3 is provided by the kernel as a
> symlink to ~/Documents/my_git_dir even though it doesn't exist in that
> hierarchy, yet you can access it, please don't ask me about the
> specifics of that) and then access them, which of course here doesn't
> work out. For the shared clone I understand why a path is necessary,
> considering that it needs to add the references to the new repository,
> however there seems to be no fallback for a scenario like this one.
> strace tells me that the call to `getcwd(2)` yields the path (outside
> the namespace) prefixed with "(unreachable)", which would explain why
> things fall apart (as this path is neither absolute nor accessible),
> or in other cases that git tries to walk the tree up (and by that I
> mean the tree outside the namespace) until it hits root, which I
> assume is its way to try and canonicalize the path, which here won't
> work either.
>=20
> So my question is: is this a bug or intentional behaviour (given how
> particular git is around symlinks I can imagine either), and how can I
> work around this and make git perform basic operations such as status,
> archive, or alternatively get clone with `--shared` to work so that
> git can at least operate on a separate repository without all the
> prior objects being duplicated?
> Also note that this is absolutely not important to me, so if this is
> just something that git cannot handle in its current implementation
> that'd be fine by me, I just figured the chances that someone will
> reply to this with "why don't you use --ignore-path-reachability" are
> not negligible.

Git (and all compatible implementations) always canonicalize the path to
the `.git` directory (or bare repository) and the working tree (if any).
In your case, that won't work, because `getcwd(2)` returns a path that
doesn't work with `realpath(3)`, so Git is always going to fail.

The path canonicalization is required because otherwise it's very easy
to accidentally break the repository, and some old versions of Git had
problems when accessed from a path that contained a symlink[0], so it's
unlikely we'll add an option to skip it.

[0] Since I copy all of my home directory across when I get a new
machine, I actually have a broken repository from this era still today.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--zPB4tNMi479gd0UY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZwRXHgAKCRB8DEliiIei
ge6kAQDS8DlEo+x0IsHAmFtNAjzMhex+JR4e2hcAIAZTEQJnWwEAgJF5IEgkKUzE
LpkQB1AIrXEoaXuGEDEuIfwVZNrcNAM=
=FMDh
-----END PGP SIGNATURE-----

--zPB4tNMi479gd0UY--

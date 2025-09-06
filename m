Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDAE131E2D
	for <git@vger.kernel.org>; Sat,  6 Sep 2025 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757172893; cv=none; b=jRK4/zAkSaNrHYy3ahU8GHC+Q3VoC/vLj+rObvrEBfUyzsUftOkEC2IBNlAKxSf3lTR6nu9swOaGyAJKqu5td8euyDW24+Ylc9exJw8J4xUtP55nS3Gzoo3TsGoAeiefLMugyURKYAZ3YljlGj3a0qxpVxLHcWx/9dxgxwnSwv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757172893; c=relaxed/simple;
	bh=7WyAc6+WO8bWoCYn1q+vl4XJRut0FW3dHx453InJyXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMsyvdlbm1NQKCkvEZCHBtmngrE1qmjMUYMcnMrT4GV4z+kxAcvGIVH+SpYQCOBH96ZE6fLpwmrb8UAk8bb6PP/aDC9UH5VKsxDFCtMUqU771tp1PUchSVwdxnf1QIbUV8cTRLT1lv6dWExkLevznE4ht2lVGAMUj/rcTvU5TC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=kA2OyxJx; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="kA2OyxJx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1757172883;
	bh=7WyAc6+WO8bWoCYn1q+vl4XJRut0FW3dHx453InJyXQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=kA2OyxJx17T3mMfFZHhKBeLwwDTLyWhHhwLRb5YXdavvZVWmODY98ga81SvQIZF4X
	 smY3mOIv3KAu4fIbpmx/9SS2SpUGLnboZyshVvnEdV0yTK2YYbs8itvDoUO7ssdNDG
	 XvUZfKloiM1jpiSBlhfAQq9p5yNGnHZGPov5IrFTkHhCvRL/qs8eNgEIpRf79IUCKS
	 SqJ/GwAHWb75l/vMVt8RUQ5DASgMVIfrSyyktW8am7rPVheJcrF/UKSpWpzMvBSDby
	 2JhORx7DvZxjUQpJMkw07VKOk+H6eiQGn3ua86LyItZekEZl+JOOi5lxfC0Q0qDn6i
	 A3NrNAxBtdBE8L2uHXYQwgAxSJBjFgK64a9Qd6dRDBSPEkuVYc6BQKfGMjGrAIYcgB
	 DKr/AYPPkueboRdHfTaISWGMh3IyoKCEzDVqjAiH4Q3ap/zQn6iP0k/n4c8L6OzMcH
	 Et+dYgg5/2n5TWDnpn0fSNH7yEqQLMeEElzwrGZ7GuaVkiOMPOp
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:f8f0:4bbe:8989:f575])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 26E9F20100;
	Sat,  6 Sep 2025 15:34:43 +0000 (UTC)
Date: Sat, 6 Sep 2025 15:34:41 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Kousik Sanagavarapu <five231003@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Running out of inodes on an NFS which stores repos
Message-ID: <aLxUkTzuVaZrWDs2@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org
References: <20250906141711.64419-1-five231003@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vW855D7sBEC5ZYbU"
Content-Disposition: inline
In-Reply-To: <20250906141711.64419-1-five231003@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--vW855D7sBEC5ZYbU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-06 at 14:16:12, Kousik Sanagavarapu wrote:
> Hello everyone,

Hi,

> These git repos come from another service and there are typically
> thousands of them each day. It is important to note that we only store
> the .git dir and expose a url which is configured as the remote by
> default to read and write into this repo.
>=20
> All of these are small repos; usually not many files and not many
> commits too - I'd say ~5 commits on average.
>=20
> Historically, when we ran out of inodes, we had implemented a few
> strategies where we used to repack the objects or archive the older
> repos and move them into another store and bring them back into this
> NFS and unarchive the repo.
>=20
> However, none of these totally mitigated the issue and we still run
> into issue as the traffic increases. As a last resort,  we increased
> the disk size even though there was ton of free space left - just
> for increasing the number of inodes.
>=20
> We can't delete any of these repos, no matter how old, because they are
> valuable data.
>=20
> I was wondering if there was some other strategy that we could implement
> here as this seems like a problem that people might often run into. It
> would really help to here your thoughts or if you could point me to
> anywhere else.

There are a couple things that come to mind here.  You can try to set
`fetch.unpackLimit` to 1, which will cause of the objects pushed into
the repository to end up in a pack.  That means you'll usually have
only two files, the pack and index, rather than the loose objects.

If you have a large number of references, you may wish to convert the
repositories to use the reftable backend instead of the files backend
(via `git refs migrate --ref-format=3Dreftable`), which will also tend to
use fewer files on disk.  Note that this requires a relatively new Git,
so if you need to access these repositories with an older Git version,
don't do this.

You can also periodically repack more frequently if you set
`gc.autoPackLimit` to a smaller number (in conjunction with
`fetch.unpackLimit` above).  If you have repositories that are not
packed at all, running `git gc` (or, if you don't want to remove any
objects, `git repack -d --cruft`), which will likely reduce the number
of loose objects and result in more objects being packed.

Finally, it may be useful to you to reformat the underlying file system
in a way that has more inodes.  I know ext4 supports a larger inode
ratio for repositories with many small files.  Alternatively, apparently
btrfs does not have a fixed inode ratio, so that may be helpful to avoid
running out of inodes.  I can't speak to non-Linux file systems, though.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--vW855D7sBEC5ZYbU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaLxUkQAKCRB8DEliiIei
gcL5APwJH2qGeH7rWKjPlqmXQVaA5trruT6acEOS5DGkRANItAEA9H4ot9Pw/uMW
gByMYR8oZIQ0poucnbCiDbob43aDegc=
=WzqV
-----END PGP SIGNATURE-----

--vW855D7sBEC5ZYbU--

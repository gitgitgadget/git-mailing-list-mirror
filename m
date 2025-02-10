Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD572512EA
	for <git@vger.kernel.org>; Mon, 10 Feb 2025 22:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739226756; cv=none; b=E07B4Ka7A52BQuZzcycAFMwC8roE2eC67Et9h17SAjZFh4wyNwr+d5XFao/0GAWXdYi0Po7MqrBToX7UgAhhK0wHFF7d008TCce34K645TziTN21t8x/oEKXRK8sFfUPHYWvIYkJQ14g3Hcgop6rbyBxxav17rX9LK01ofR3tyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739226756; c=relaxed/simple;
	bh=LgTUs0yaJBL1ag4uX2s/acsSGGPRqjOSTua1tBV+7uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d050CYKA/3TkorC9/NwDgol4RyFX8aVH0XtGq4MtyoKig2BonvcafhEtu/s/Eu4sHwtf0bDuvp0PSbzSqlpdaYcklyYzs7IoxfUVQgwOmsu1zBX6ZEeCUrBMNooF+wCs4tRz66H+CGaHZYvlmsNCf/2Be7GESt/S4qDxQ1EyxeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=NHrqiojB; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="NHrqiojB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1739226745;
	bh=LgTUs0yaJBL1ag4uX2s/acsSGGPRqjOSTua1tBV+7uc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=NHrqiojBYdHFZtBndljqY57pGZWcRIJIUru/Lx2fRgq8Yt8y8GiKcUcZYiYH7Qy0v
	 hKU4ON2Oy2pBYVpxmQGHhHG6Rh5uREJi3d3r0nA5qEPCiZnenzb6AOyfpnM7mwRt6d
	 v2HBkbCzIQQO4ATKo92NL5+ZcO0KwJmDvpu3PzSRpBfaic5wDrzb4Uv5KCwVqZMnf/
	 5FegfipMq2gkRK4JG43qLJxMR5yohKtBs85QPLYLBfvycJdqavQbWXCX0+mARYuSqp
	 G+FjYlg3hjEIPgmMG3mgC3JhrRR1paa1lFBKh+AU1slbxHork3CH2/e4QXj4qAvhn4
	 wCA1ulVNi68LD/JpwY0eAjv3LcaPvGr0YtUt2KzPmycrXjrcN2A9QhZjL1Jnqv36/V
	 7tDk5oEOMW5qmI2r/vq4cFYEjDTYUB/qfbko9OaAiR0FytBf+MZ/hgNX4eoi5ascPF
	 JEsV/BgzCkfSAM1f2kEbKLllhU6UcBN6/ZlWG+hV3w5Oc/oil1P
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B324620076;
	Mon, 10 Feb 2025 22:32:25 +0000 (UTC)
Date: Mon, 10 Feb 2025 22:32:24 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: "Maloney, Bryan" <bryanhm@amazon.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"Perry, Daniel" <dtperry@amazon.com>,
	"Das, Satabdi" <dsatabdi@amazon.com>,
	"Damojipurapu, Deepika" <deedam@amazon.com>
Subject: Re: [Bug] Git ReadOnly Temp Packfile Causes "Bad file descriptor"
 And -13 Access Error With NFSv4
Message-ID: <Z6p-eIxzrFepC3py@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"Maloney, Bryan" <bryanhm@amazon.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"Perry, Daniel" <dtperry@amazon.com>,
	"Das, Satabdi" <dsatabdi@amazon.com>,
	"Damojipurapu, Deepika" <deedam@amazon.com>
References: <18589D54-5E7F-434D-A890-B39102ECB293@amazon.com>
 <17DE42DF-D2A3-4E25-9198-5AF3CA516E35@amazon.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EZvbWufyYOue/Dwz"
Content-Disposition: inline
In-Reply-To: <17DE42DF-D2A3-4E25-9198-5AF3CA516E35@amazon.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--EZvbWufyYOue/Dwz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-02-10 at 15:56:59, Maloney, Bryan wrote:
> ### Error
> Kernel logs:
> ```
> NFSv4: state recovery failed for open file pack/tmp_pack_aR0Mu3, error =
=3D -13
> ```
> Git clone output:
> ```
> fatal: write error: Bad file descriptor, 137.31 MiB | 45.77 MiB/s
> fatal: fetch-pack: invalid index-pack output
> ```
>=20
>=20
> ### Context
>=20
> The following error is seen when running git clone over NFSv4 and a failo=
ver, or server restart, occurs:
> ```
> NFSv4: state recovery failed for open file pack/tmp_pack_aR0Mu3, error =
=3D -13
> ```
> This error is an access denied error that happens when you try to open a =
file with insufficient permissions. In this case the file being opened is a=
 read only file and it is attempted to be opened with write access.
>=20
> Git opens/creates this file with the O_RDWR flag but then applies read on=
ly permissions to it, 0444. Since the permissions are changed after the fil=
e is opened, the file handle works fine. However if the file was attempted =
to be re-opened with that same file handle we would see a -13 error. This i=
s what we see following a failover in NFSv4. When clients reclaim their ope=
n files, the NFS server re-evaluates the file access.

Your description of the problem is spot on.  We intentionally set the
permissions to 0444 because we never want anyone to change loose object
files or packs, since doing so would corrupt the repository.  This
behaviour is specifically allowed by POSIX[0]:

  The argument following the oflag argument does not affect whether the
  file is open for reading, writing, or for both.

POSIX does not allow the re-evaluation of file system access once the
file is open, so it sounds like your file system is not POSIX compliant,
and Git generally requires lots of POSIX-compliant functionality from
the file system. For instance, we also require the POSIX consistency
guarantees[1], among myriad others:

  If a read() of file data can be proven (by any means) to occur after a
  write() of the data, it must reflect that write(), even if the calls
  are made by different threads. A similar requirement applies to
  multiple write operations to the same file position.

The implicit violation of that particular requirement is why cloud
syncing services often corrupt the repository.

Could you adjust your NFSv4 server such that is synchronizes state among
the primary and replicas in case of a required failover?  I know we have
people successfully using Git with NFS without problems, although this
particular issue does often hit non-POSIX-compliant NFS implementations
in a variety of ways.  (This particular variant is new to me, though.)

> This is an issue for active/passive HA file servers. Since NFSv4 evaluate=
s file permissions at the time of opening a file, this FD will always get a=
n access denied error if a failover occurs during git clone.

I'm not sure there's even a good way to solve this problem on the Git
side, since I suspect that if we opened the file as 0644 and then
immediately did an fchmod to 0444, if you'd still fail here if the file
is reopened.  Is that correct?

I'll also point out that there's a variety of other software that does
the same thing as Git does, including zsh and Emacs, so fixing this in
Git doesn't really fix the entire problem that your NFS server has,
since all of that other software will also be broken in at least some
cases and require similar workarounds.  (I discovered this with a
simple, 30-second search on GitHub some time back.)  As far as I'm
aware, all other Git implementations also do the same thing as Git does,
so you'd also need to patch go-git, libgit2, and every other
implementation as well.

[0] https://pubs.opengroup.org/onlinepubs/9799919799/functions/open.html
[1] https://pubs.opengroup.org/onlinepubs/9799919799/functions/write.html
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--EZvbWufyYOue/Dwz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ6p+eAAKCRB8DEliiIei
ge4JAP4gwMKBGJRgrX7sYN7sX/bw2Vm600ZoFxY12QwSP8+yEwD/Ypjs0MNkCWrl
dCVN33m4hx9MvSsIoRmsSd+zRkP8Qgw=
=+y7r
-----END PGP SIGNATURE-----

--EZvbWufyYOue/Dwz--

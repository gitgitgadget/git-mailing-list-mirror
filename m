Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A7761FFE
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 23:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753398895; cv=none; b=lTNhvyOsIqERo8l3zHfcGRkZlRk1kNKj50zmlI1hHcfqHhHIRVd4mHyBYCFgfQDmNwA4/k6PzxcYLBAez0Xh+uEBlI1IJDtFQVF1dUBHnwaiW/kih3qicjLN+FvrkXK5B2FLoSVRWnWbuVZmZqMl3nFytJp1u2Z8yX76UA52JIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753398895; c=relaxed/simple;
	bh=bD21On3GiiyjF7uinSup3hrZ3vCfxiBdmvStEUxlVvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtdaFSXJf+tN9lKeGpEa/aYlbymNxTeWGBVRynkQPkjKOxQIDVQNQ7c93WOHTkA7tvwc3Xo2dg5yeXFPRc6qj4DEmvzzTs7/1YwhWJ6cKV5bTiLw7iHw20NehPZgvcmf3jwr4m8ZWOHA8lj1Mh50TKAEy8oDlZPS45m9zeG3rqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=h6+87PJJ; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="h6+87PJJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1753398885;
	bh=bD21On3GiiyjF7uinSup3hrZ3vCfxiBdmvStEUxlVvc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=h6+87PJJosEYKgY2YX8chD/Cja8NndDGkGyeXv45+EfRYaUHqqR1amL7jDyz9YWaq
	 ri6lK4nnb/pOGXegOVwV/unqGymolD4CZmUYyjpdRUpjiiZmQoML8/aFgIWqij1+1v
	 rmX341OAJanppN0EtjUo7SBC7XLYyqNewglv1HAJD0cAJWMQADqpfL4J644/TLm+Me
	 alP4HK59QlQcD2C/Rwxl/KMOt5pcgC4lldKlh/2Wp7oLSqbLRjkpF466rxA/XUQxWM
	 EW/e+ZTQh0CUOWvjd81naOYjp/mML2GUediVy/0+1iYep2Oz3sMhTXE1zZKXgE/ftU
	 dlLDjVmC0XEMiK/yh6/UdYUXb0QRARu/WUpjYJZ8cVWWb7bJlznTJQ6hmcR0YH0CMz
	 KgFQlp7l+WbEwwbcvHhIISZa7mW3mb3f2/SyIkSjid4Ewmv9HlJ4y+yJeEzBSxxqqO
	 p9d1lM5T03hP9dP78vptD/Au6vPVA+CrF1p2KYXF+LoKV7x5QwV
Received: from fruit.crustytoothpaste.net (unknown [70.158.101.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 3D8CE20079;
	Thu, 24 Jul 2025 23:14:45 +0000 (UTC)
Date: Thu, 24 Jul 2025 23:14:41 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Tim Cederquist <timcederquist@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: git clone fsync error on FSx Ontap
Message-ID: <aIK-YVZWWAjHiIxE@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Tim Cederquist <timcederquist@gmail.com>, git@vger.kernel.org
References: <CAFb3DeA9TwRnieajpa5S88ioc=65bUWh55mvDYz3CBp-xUcB3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nq4J2WF9DPQFIZxv"
Content-Disposition: inline
In-Reply-To: <CAFb3DeA9TwRnieajpa5S88ioc=65bUWh55mvDYz3CBp-xUcB3A@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--nq4J2WF9DPQFIZxv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-07-24 at 21:49:41, Tim Cederquist wrote:
> What did you expect to happen? (Expected behavior)
>   git clone https://github.com/githubtraining/hellogitworld.git
>   Command should have cloned a public repository the NFS hosted home fold=
er
>=20
> What happened instead? (Actual behavior)
>=20
> Cloning into 'hellogitworld'...
> remote: Enumerating objects: 306, done.
> remote: Counting objects: 100% (32/32), done.
> remote: Compressing objects: 100% (13/13), done.
> remote: Total 306 (delta 22), reused 19 (delta 19), pack-reused 274 (from=
 1)
> Receiving objects: 100% (306/306), 95.63 KiB | 1.84 MiB/s, done.
> Resolving deltas: 100% (70/70), done.
> fatal: fsync error on
> '/mnt/home/tcederquist/hellogitworld/.git/objects/pack/tmp_idx_gpahXY':
> Permission denied

This is definitely a bug in your NFS server.  EACCES is only a code you
should see before you have a file descriptor.  Once you have a file
descriptor (e.g., open(2) succeeded), the proper status code if it is
not suitable for your purpose is EBADF.  (For instance, if you attempt
to write(2) to a file open only for reading.)

However, fsync(2) should never return EBADF or EACCES on a file open for
writing.

> fatal: fetch-pack: invalid index-pack output
>=20
> What's different between what you expected and what actually happened?
>   fsync error - permission denied
>=20
> Anything else you want to add:
>   From Ontap storage host sectrace events command, it indicates the
> failure is due to the user not having 'Append' permissions to the file
> and generated the fsync error.
>   Running an strace on the git clone command shows the process runs
> "openat" with 444 file permission but with O_RDWR flag.
>   Ontap creates the file with 444 (read only) posix permission
>   git continues on to write() into the read only file - ontap rejects
> it and fails the command due to read only status of the file

Yup, this is explicitly allowed by POSIX.

>   I've tested with linux "instruction" command to set permission and
> copy a file in a similar fashion:
>     strace -f -o trace_install install -m 444 src.txt test/a/test4.txt
>     This command opens the file handle 600, writes into it, and then
> chmods to 444 << not using 444 to start the file as git clone is
> trying to do.
>   Additionally, I've added an inherited non-intrinsic permission to
> the user of A:FD:tcederquist@domain:wa << this appends the required
> write + append attribute and the FD means it is inherited by all files
> and not overridden by posix permissions. This is not a solution but a
> testable method. With this permission added, the git clone works as
> expected.
>   Suggestion is to use 600 on the openat/fopen for the pack index file
> instead of 444. This is how 'install' sets up the file. However, I
> don't know if this was an attempt at a cross platform mutex? I cannot
> imagine any other reason why 444 would have been used for a file that
> would have content written after opening with read only permissions.

The goal is to create a file which has permissions honoured by the umask
but is not at all writable.  There is no reason to write to a pack file
or loose object once it's written: the file is immutable until it's no
longer useful, at which point it's removed (which does not require write
permission on the file).  POSIX requires that the restrictions set by
the file mode be ignored when determining whether the file is open for
writing, so your NFS server is not following the POSIX spec correctly.

Note this is possible to do correctly over NFS, and many servers do so,
but there are also unfortunately a large number of servers which do not
honour the POSIX standard correctly.  In addition, this problem not only
affects Git, but a wide variety of other software as well, including zsh
and Emacs, as well as every other Git implementation I'm aware of, so us
trying to work around it would still leave you with a server that didn't
work properly with lots of software.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--nq4J2WF9DPQFIZxv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaIK+YAAKCRB8DEliiIei
gfmoAQD9PJwnYvmPeZwco9ty8z+Qxw+Jfm4eV0wxfVFOODFDvwD+McNiXlIQdYZs
YDARV0wHlB9Cy7kCKwBOXNzrvGy7bgY=
=rsB1
-----END PGP SIGNATURE-----

--nq4J2WF9DPQFIZxv--

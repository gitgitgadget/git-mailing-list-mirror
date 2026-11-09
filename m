Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=172.105.7.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263889;
	b=236vdOcDZRBY2r29h6/J3f8NQ0V4KRBdvtpfjLlo9AcQCMKPNXJg2tKUo6pnaYwQ+T+w
	 YVFvTx7f8Uojg+Hbm6s+VBMlmhXEHKw0Cw9pgv66lpmaiAW70o7u1qTAFxvYXfx+Hhf4t
	 UwNlwJG2IfngQl9o7hZipCLwbRnWQL7ualVmFSHPPhKcjHe55k133FOMBb3q/3/CRvU0T
	 2dgqlc7wkdpZG0HnOQs5FGhv6lboMshcwMSzknTmLZADkPzidIK17ZQVBID3+caRDDTsE
	 Rmsuuz/t06B3jTu2IacVvp1yNsJ5lnxqSMq2UpT2I1m0t5jmzN814szi2XsCL4AB8Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263889;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=EbXm5zPXsyQtfY9W+zqDaXHiyn46B6RWIenyMzrtclk=;
	b=njAKbWmZS0uDIW0UnA2xXR6w03v13jyVop1WH7qkKcQ0fEBIUgpahan7XOhGwxtuYhBc
	 88HZQEdhD2jtEkN2KqsGDsPC1P0neNLoo6m1V4fsbhomyuiL+aCLNQ2GNWvJDS3F3MDBM
	 0JpCZuQ3KmPR+fcIEFCGAGTjuW1ri74E0ddIzZyKtEF1PcrTZ2i2eptdsWgdjwH5MyHym
	 rkMze6kwjXkVCP/KS6COecZ8t97XrWaaBvDc/0GEfhi8V2UnwN7SYa2DGpmhe74F3/NPL
	 +EWstpwEzeVfBPcvxSP6vWW6melkzmD6Z1dQwpkUBrfiLZcmQnU7Cz9dRqSUrpCJL+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crustytoothpaste.net;
	spf=pass smtp.mailfrom=crustytoothpaste.net;
	dkim=pass header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=AyouaxMa;
	arc=none smtp.remote-ip=172.105.7.114
Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD34606A321
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 22:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCD34606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key, unprotected) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=AyouaxMa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1794263881;
	bh=VPb0cbQYDWid7I7EjRd/YF106Hy7dVGkKLN2/5LE6ac=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=AyouaxMaYT248aDPSpMb8i/Opz8as2A8ZdkYPT7Wo2HHtheOky8w3MsDZqFeFyd7Z
	 vpTdvB5FLrc+HHbDKOk+mnpFjDJ6e53y0Hb53jLFJY+fgNKdzuhIiNlboyqoIbCrwD
	 GoeT3LoB3YtCwY3ituYoLUNPDbJCzfhD3fD+c7eWRVyTOCxtbBH3lEFNZp/NM4fPcb
	 o6FNIBbc3gIUVyDfJf3NuGy7rukz1v2jLZQToxQD+lcZObsrKajfDi4jms2n84xA/0
	 x2oyM4bXhJMlaNwGr1ygzUUPIXlOfsyteCa7UKFlPig+GqhTBkg6aPmFwMm5YXKaDj
	 81RQjpaNcC9HgcIYGVFyG8jkI5aZS3srs7UM67oQ/HdZESsOX/Dqihrsb2iDowNUy4
	 DfD6r1bj9lC17PoDv0DuNVIGzC/1LRFaSwvmcTLzCKR6gEpU2GHiSjJ6qH/nUBbzgl
	 UVKArPMioXaBdVw7d+2AODwkM81BMXgmXZpzLpOrur+5eMSKAkw
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:7f1c:2d92:cd33:5059])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5EA4720069;
	Mon,  9 Nov 2026 22:38:01 +0000 (UTC)
Date: Mon, 9 Nov 2026 22:38:00 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Harold Hunt <harold@pwrdrvr.com>
Cc: git@vger.kernel.org
Subject: Re: APFS, mmap, and git diff reporting no changes when there are
 changes?
Message-ID: <avJLR6EdZ4OYmTpj@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Harold Hunt <harold@pwrdrvr.com>, git@vger.kernel.org
References: <CA+-E0BVhYRsktwaUDxtobAXV98dymKg2n4ghod292imymE5C_A@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="80eQdgpwfYGvjRqc"
Content-Disposition: inline
In-Reply-To: <CA+-E0BVhYRsktwaUDxtobAXV98dymKg2n4ghod292imymE5C_A@mail.gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--80eQdgpwfYGvjRqc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-11-09 at 22:05:55, Harold Hunt wrote:
> Hi All - I used to maintain Cygwin/X (the X Server for Cygwin on
> Windows) 20 years ago... it's been a while since I've used a mailing
> list.
>=20
> I'm working on my own implementation of copy on write cloning for git
> on a couple Linux fs options and APFS on Mac.  While working on this I
> created tests around mmap'd files and how to handle sharing them when
> creating worktrees with clones.
>=20
> I discovered that mmap'd files on Mac can cause existing git to
> misreport no changes on various commands, while tools that read the
> bytes of the files will see the changed bytes.  I could not find any
> discussion of this being an intentional tradeoff of speed over
> correctness for git on APFS.  I don't believe this is a security
> problem.  However, any tool that mmaps a file, changes it, does not
> call msync(), and holds that mmap open will cause this misreport to
> continue until munmap() is called, at which point the ctime of the
> file changes (mtime does not change on this path).
>=20
> One could argue that not calling msync() (which updates both ctime and
> mtime) is bad form and that git not reporting the changes in this case
> is an acceptable tradeoff for performance reasons.  However, on Linux,
> git correctly detects the changes via the mmap even without calling
> msync().

Git doesn't use mmap on files that change in place, only on
content-addressed files like packs, indexes, and (for interoperability
code) object maps, all of which have hashes in their names, or files
which are replaced by rename(2), like the index.

In general, it's not safe to use mmap on files that can change in place
because if you access beyond the end of the file, you can get SIGBUS,
but you don't know if the file may have been modified at any point, so
you effectively have to deal with crashing anywhere in your program.

> One could also argue that this is Apple's bug or deficiency.  But that
> could take months / years to resolve?

This behaviour is allowed by POSIX:

    The last data modification and last file status change timestamps of
    a file that is mapped with MAP_SHARED and PROT_WRITE shall be marked
    for update at some point in the interval between a write reference
    to the mapped region and the next call to msync() with MS_ASYNC or
    MS_SYNC for that portion of the file by any process.

However, Git relies on the operating system to reflect an accurate
modification time.  If you write files to disk with mmap, then you're
responsible for calling msync() in a timely manner.  However, as I said,
that's extremely improvident for things like files in the working tree,
which is why text editors don't use mmap.

> I'm writing to ask a few questions before either extracting and
> submitting just the tests or carefully vetting the fixes and preparing
> my own PRs:
> 1. Is this already known or is this nothing?
> 2. How far do we want to go for correctness?
> 3. Does anyone else have experience with this on APFS and have some advic=
e?
>=20
> I have an initial LLM-written PR for this on my fork (I am NOT asking
> for review on this... if you want to look, look, but if you don't want
> to: please don't): https://github.com/huntharo/git/pull/14

Please read the entirety of SubmittingPatches, including
https://git-scm.com/docs/SubmittingPatches#ai, before sending that in.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA
Speaking for myself only

--80eQdgpwfYGvjRqc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmryS0cJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ3dkpTj7k3Yapk49DsVAhb+rSuRGDDLjg3BNkWjlQ7CT
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAOGlAP0Sys8K1JmF+FPkb2yxT0sToHHC
Gn8S6DoMzEK0eeSVaAD9F7lGtU0FAXQrZSzdm+2KF72NRBUtYlNm6wrAUV5B3wk=
=uLUO
-----END PGP SIGNATURE-----

--80eQdgpwfYGvjRqc--

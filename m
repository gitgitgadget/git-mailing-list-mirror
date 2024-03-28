Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C411D13B789
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 22:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711664443; cv=none; b=qPcRv4w6TxFYxvT3bLCAjQfT4pvl5z2TXeBFq3l5Ea2pMoia9CrP4eVMvsVLT2oiXj4xVKcqQ2JorJd4BLoChRq7DM4rPCEofdNrjBHj5AELcsf0cvuKauxlAA8gpsQvtU5WovRFF/AiPsrUr6Ax45ySU73+fI8Zu2hrR6b83Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711664443; c=relaxed/simple;
	bh=kBOWTU+FRdb6l76J/XqjdaJRbvZ+ihrJ4kIl2GGKAMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsEAr4M3aYsk0YW2a4FXWktJ/UsfNz+RWnJUPJVF2ScBGLq6AED9Cv6lKDzgz1kQ/t0ZBAkYSDIMigIInlmSIYA8DDC5w6Bj+mTMuLzass7ERLllxMKPUdNzWWqB5+660YAr9uKi5q7/wHm48uPYctm/LwPD8Md6g/AA/oytkOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=swF3DCXL; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="swF3DCXL"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 700415D4A7;
	Thu, 28 Mar 2024 22:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1711664439;
	bh=kBOWTU+FRdb6l76J/XqjdaJRbvZ+ihrJ4kIl2GGKAMY=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=swF3DCXLZBVvqiUY+vIQed7Be/n4LDvc49oYo0/W1JXfhL5DdIxwYS6A6Ci+cR4mF
	 zilSz/EfSMfpgfg3TdtsJbaQvWdhaFP7OgZjZyEA+QzcjTqlxIr0kYmCVEyy0X7Chv
	 m/MFOpML4fG3c3DfUUyb/UeLoUJt1cTfiFZOy93cnU8Oimixmij6uEb9uxfRyFvj3W
	 rkeD4QxO8E20StFF2cquoFqnguj7QMvtXIPVXlExABsjJtxIZ/Af5I6HRELVcV1ymM
	 51dVypTBbeJ5vSxi8+xq0D9c80WhNTmYt71JE2na+RCpDixPExhrh127yGaprInqc1
	 5zkG9DsqFoUsurNyz2a+17kjkk4/5N8C1CN0sk2P/2uPyZ4jWgArU/KOBPvSuqU1az
	 LOqHiNZNnoIn6BzfLWFmu7Y3p3YV39EAqk/zug41odwvXx5OTHLuuZR/kiFaqeLLXM
	 c0QxvSZgrIETzD8oiitk+d/0qsrUK6wYitcAtIlATqC1ibSdU07
Date: Thu, 28 Mar 2024 22:20:38 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Mohammad Al Zouabi <mb.alzouabi@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Ignore specific changes but not the entire file
Message-ID: <ZgXtNknnAIRfzrXt@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Mohammad Al Zouabi <mb.alzouabi@gmail.com>, git@vger.kernel.org
References: <CAAQqY-NKvWMLo_Bcby5-QYPOj-jbWeVA3zGL=_sq2p2bGZQBEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bh1Yz13RDHTUcbZv"
Content-Disposition: inline
In-Reply-To: <CAAQqY-NKvWMLo_Bcby5-QYPOj-jbWeVA3zGL=_sq2p2bGZQBEA@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--bh1Yz13RDHTUcbZv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-03-28 at 07:46:08, Mohammad Al Zouabi wrote:
> The problem with:
>=20
> ```sh
> git update-index [--skip-worktree|--assume-unchanged]
> ```
>=20
> Is that it ignores the entire file.
>=20
> Is there a plan to support something that remembers what was exactly
> ignored, and if there are changes to it, either un-ignore the file, or
> display the hunks that were changed?

No, because the Git FAQ is clear that Git doesn't support ignoring
tracked files at all[0]:

    Git doesn=E2=80=99t provide a way to do this. The reason is that if Git
    needs to overwrite this file, such as during a checkout, it doesn=E2=80=
=99t
    know whether the changes to the file are precious and should be
    kept, or whether they are irrelevant and can safely be destroyed.
    Therefore, it has to take the safe route and always preserve them.

    It=E2=80=99s tempting to try to use certain features of git update-inde=
x,
    namely the assume-unchanged and skip-worktree bits, but these don=E2=80=
=99t
    work properly for this purpose and shouldn=E2=80=99t be used this way.

    If your goal is to modify a configuration file, it can often be
    helpful to have a file checked into the repository which is a
    template or set of defaults which can then be copied alongside and
    modified as appropriate. This second, modified file is usually
    ignored to prevent accidentally committing it.

So the functionality that you're using is not intended to be used that
way and in fact is broken for that purpose in a variety of subtle ways
that you'll notice if you keep using it.

If you need to generate files from a variety of sources, some of which
should be tracked and some which should not, you can do something like
create a directory foo.cfg.d, and use a script to include files from
that directory to generate your config (which would be in an ignored
file).  You can have some of those files be tracked (and hence
diffable), and others be ignored, and then the script can generate the
proper data.  This same approach is used on Unix systems for generating
configuration files and is well known, so it shouldn't be too difficult
to configure in most cases.

[0] https://git-scm.com/docs/gitfaq#ignore-tracked-files
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--bh1Yz13RDHTUcbZv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZgXtNQAKCRB8DEliiIei
gY7sAQCi5kvePA0UpmmG69crgCe0EtAKgr1hJC7vIoWgxEcJAAEA09L64kO+qMmM
yalh1VzxZKnOrlmiPzRa29f3ODiPOgs=
=MMP1
-----END PGP SIGNATURE-----

--bh1Yz13RDHTUcbZv--

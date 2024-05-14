Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D73365
	for <git@vger.kernel.org>; Tue, 14 May 2024 20:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715719459; cv=none; b=mBz9+zCN0h0U4CASJYjOeANkKSxZHNv5QzZG27VsVtYfqiopkybPu4w9cjv626/HtpGc/KvNgG9KVH1caqWPgd19hGi8QjJFBwLSF8rrx7oORtWF4exVmv7AS56/3eQAFYmZDhqluoUqyRiZgH5nQ+NyX0n2YLDQKHbKr+PZZLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715719459; c=relaxed/simple;
	bh=1w0aLAnk4PeeeA4tmx4MBxTgI3ZZ93m/iJDPl4RivCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkdCC2A9/83o6lRLj4vFNH8zkWDz7KLg12eyFaCNnMt4bJC34W0JWrI4m2bhEez6IcHoTHo7pnMEit5OOl+fyvxXUc3njjF33nXVJaf/EHRiY2VyAXbNsD4cqRrDPniJP9UMpL6wwA9wytgc5IjYOnn+R8FOwdzU9xFj79JsrH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=UauRUqzW; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="UauRUqzW"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id E43C45DA8A;
	Tue, 14 May 2024 20:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1715719455;
	bh=1w0aLAnk4PeeeA4tmx4MBxTgI3ZZ93m/iJDPl4RivCk=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=UauRUqzW4cDnekhGCWLomELt9M8ffudkBwxbM6X7LVl9fWtEiECYOFqWj5orbPGL9
	 S/V//RXFNa265N/ZK4f8obTeiEJ0YO61BJxTdywCOH9EMPEKS9URrMaWNENNelU4CI
	 TPO4YFPMlNXNrTu8BPBs9ol29UsvooKdIjafy2x8C5T45eBQ+IMIa0fD5VhIRjz2cX
	 k7dOIOEKxC76ToTb6WbYhEoPG6R+fmnQWIbx/0nag0Z0v/1nASzULB5vRfMtkVjgZx
	 XStlXIEptNq4kRrWLHhdr7Wy4hCLcCieBd+0fXIf+VCPKs4Cu3A3gopyz0SHL2lBfC
	 //8DGcPwY+Wiooiazbwnpe2Y2LMemmL/L7k70xQHTiu1Aeg1Ka3MAlfdP1DvSrzmHZ
	 qq6y/ASjgfqubJ/aogOL7TnMP25keAZ1jbutDTVHN/QZo/4x/uJwAxTIO6Cn74+lua
	 wvuuXtZveHgCM5ITNY+xIBWSXlnqcNjrwsYOVXfBAx7kV3ylff6
Date: Tue, 14 May 2024 20:44:14 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Yongmin <revi@omglol.email>
Cc: git@vger.kernel.org
Subject: Re: git format-patch displays weird chars when filename includes
 non-ascii chars
Message-ID: <ZkPNHqAUemfdfaFD@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Yongmin <revi@omglol.email>, git@vger.kernel.org
References: <ea41a92d-35df-4b71-be70-a736d620b21f@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VY4kbua+h0mOAyXa"
Content-Disposition: inline
In-Reply-To: <ea41a92d-35df-4b71-be70-a736d620b21f@app.fastmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--VY4kbua+h0mOAyXa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-05-14 at 15:31:43, Yongmin wrote:
> Hi everybody,
>=20
> When the file name has non-ascii characters, the file name gets mangled s=
omehow. Is this anything from my config side error or something gone weird =
with git?
>=20
>  Steps to reproduce;
> $ git init
> $ echo 'BlahBlah' > =ED=85=8C=EC=8A=A4=ED=8A=B8.txt
> $ git add =ED=85=8C=EC=8A=A4=ED=8A=B8.txt
> $ git commit -m 'test commit'
> $ git format-patch --root
> 0001-test-commit.patch
> $ cat 0001-test-commit.patch
>=20
> From d2aa2b2f5aa290edec6a5fd141318a479ac9de8e Mon Sep 17 00:00:00 2001
> From: Yongmin Hong <revi@omglol.email>
> Date: Tue, 14 May 2024 15:15:52 +0000
> Subject: [PATCH] test commit
>=20
> ---
> "\355\205\214\354\212\244\355\212\270.txt" | 1 +
> 1 file changed, 1 insertion(+)
> create mode 100644 "\355\205\214\354\212\244\355\212\270.txt"
>=20
> diff --git "a/\355\205\214\354\212\244\355\212\270.txt" "b/\355\205\214\3=
54\212\244\355\212\270.txt"

In some cases, Git uses escaped strings (often octal[0]) to avoid
problems with encoding when sending patches over email or producing
unambiguous output.  For example, the file name "\r\n.txt" would
definitely break sending over email.

In addition, while it appears that you're using UTF-8, which is great,
Git does not require file names to be in UTF-8, and it's valid to
specify 0xfe and 0xff (among other byte values) in file names in Git.
However, if we wrote those bytes in the body of an email, many users
would be upset when reviewing the patches, since they will usually want
to write their emails in UTF-8, and it's possible the patches might get
mishandled or mangled by a mail server or mail client.

Thus, Git prefers to encode names in a way that is unambiguous and
doesn't lead to mangling.  It is inconvenient that legitimate UTF-8 file
names don't get rendered properly, though.  I don't _believe_ there's an
option to show the regular UTF-8, but I could be wrong.

[0] I don't know why we chose octal and I'd much prefer hexadecimal, but
I wonder if it may have originally been to pipe to printf(1), which
POSIX requires to accept octal, but unfortunately not hexadecimal,
escapes.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--VY4kbua+h0mOAyXa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZkPNHQAKCRB8DEliiIei
gRCMAQCITe4i87oIgWBET1MqlcTxy82G6+vqD3tdtU8wUtbzTAD/VqSecpAj4txO
WiqRAfUgO1mQuNPvYzMvHoq5sFeVNgo=
=IRG/
-----END PGP SIGNATURE-----

--VY4kbua+h0mOAyXa--

Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFA517722
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 21:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="z/2qfzFs"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id A8EAE5A3C3;
	Fri, 12 Jan 2024 21:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1705096212;
	bh=Chz6Kv6iQmuQfuhKqn2dXhgUgxwcv7ctGOwbjvv6ZNw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=z/2qfzFsgbOxqYwWbhBGWmQ9ltqjsNlNoSLbEStkYl56n5Gia0pGNI5xw5OkjFc7L
	 R30Fo9+bfOJBIKtIX+3f73z8qw1zTF0++2MI4kLuQoDpZOfTGpmmTZpZiT485nAYHP
	 9g7gk38UrjwEKDqOlTdOB4qJkPBqApxQk7wxVViBNPl1/pRLkiftpnivRfIQALvEDk
	 9k4eP/tYGzl0yNXIyiuLTmJp4kpmmohVec6BuuilCqRBt/+i296jO4sIf/T5pt0D24
	 g5gxbmzut50eyhgG96HXMyVZmioy6t2wvccjwo8wdC6oQ3yGh/vglXBiq1er7oSpQ1
	 dtiwSKFj6EeuoAocmRrUyAcTTM1+6F/JGWFq321Oi8oRdto+AFqhAPT7IGyma/EH09
	 fQssBijpJxbbn8iHd7GAP5HIRNfnwZMJ0x+FwPvTJVhIBCtBEiA/RVf1xfVx/+SXSx
	 tC+fJ3M5q/DQ1Hzgq9IqkpmoPzRX79FS0w+0sX66eLNtI4HxHkf
Date: Fri, 12 Jan 2024 21:50:10 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Michael Litwak <michael.litwak@nuix.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Suggested clarification for .gitattributes reference
 documentation
Message-ID: <ZaG0EkADl8hQZaqf@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Michael Litwak <michael.litwak@nuix.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <SJ0PR10MB569379A093B83BE01A04C789FA6F2@SJ0PR10MB5693.namprd10.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rwrCizz4Zd1U9WmR"
Content-Disposition: inline
In-Reply-To: <SJ0PR10MB569379A093B83BE01A04C789FA6F2@SJ0PR10MB5693.namprd10.prod.outlook.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--rwrCizz4Zd1U9WmR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-01-12 at 21:25:19, Michael Litwak wrote:
>     Please note, Git for Windows does not support UTF-16LE encoding when =
running git
>     commands from an ordinary Command Prompt.  Use a git bash console ins=
tead.

This sounds like a Git for Windows bug.  Rather than documenting it,
could you open an issue for it on their project?

> NEW TEXT:
>    =20
>     You can get a list of all available encodings on your platform with t=
he following command:
>    =20
>     iconv --list
>    =20
>     For Git for Windows users the command, above, is only supported when =
running in a 'git bash' console.

That sounds like a PATH misconfiguration on your part.  Have you checked
your PATH settings to make sure that the path including the binary is
included?

> CONCLUSION:
>=20
> Text files encoded with UTF-16LE with BOM are common in the Windows
> world, as some versions of Visual Studio will use this as the default
> encoding for .rc or .mc files.  Solution files, project files and
> other Visual Studio files can also be in this format.  Other encodings
> are common, too, e.g. some older versions of PowerShell defaulted to
> UTF-16BE with BOM for new .ps1 files. Yet users continue to experience
> encoding errors even when they are using the proper
> working-tree-encoding in their .gitattributes file.  Part of this is
> due to the complexity of Git and the number of different platforms it
> supports.

I should point out that UTF-8 is pretty much the standard these days in
many domains, even on Windows.  For example, nobody is going to be
pleased if you write a web page in any variant of UTF-16, and some
languages, such as Rust, are simply defined to be in UTF-8 and won't
work if you put them in any other encoding.  Almost all editors these
days do support UTF-8 (without BOM), even on Windows, so we do want to
strongly encourage that rather than having people use UTF-16.  The Git
FAQ specifically outlines UTF-8 as the recommended way, which is most
portable and most functional.

We have also documented the UTF-16LE-BOM case specifically in the Git
FAQ (git help gitfaq) under "I'm on Windows and my text files are
detected as binary".  Answering questions on Stack Overflow, I realize
that nobody actually reads the FAQ, but we did clearly document how to
do it.  That being said, I'm not opposed to an additional mention in the
gitattributes(5) page if you want to send an actual patch.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--rwrCizz4Zd1U9WmR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.3 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZaG0EQAKCRB8DEliiIei
gYQhAQD5gp5DodwyLprV7sbA+W+flAtpZOdxCgYr10/llmW5bwEAp1EZlf3xQyU7
Wn1+cIB3TSESoPmownYdO8Wu58NcYAc=
=rP8T
-----END PGP SIGNATURE-----

--rwrCizz4Zd1U9WmR--

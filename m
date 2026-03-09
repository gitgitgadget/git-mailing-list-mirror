Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB9E2EBDD0
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 21:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773090196; cv=none; b=WxmL9jm5GSB3fPylabfM/Mke7MdGS1BdAWH35pCan8/7tD2BiVrdL+Cj49zoBQ8845wVWdOcz7nHhouJl3HgqQVxGQMph6Rwp+nCDchWvdcCGa70ZrgCTry3xovzBcr29ldadxPUDVipVekvAVTmcVKSm3skH4h7MmMjFiY2phk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773090196; c=relaxed/simple;
	bh=03JjaAVMCcbK2YCJRQz+3vcgmz2FbzHR/INOx7ETJqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYYUy0cbCC/0U+a1aK+/3rCTcGd2jqBAFp24BU/Vl2ECE4SOSSJElBQN6vlJretwiPDCk+OVuHMm5Nuf+v/gtISo1JaW5yyrd7JWGnMfixW1sXRgq0XmwwGG9CLuElzW+kQbyJo0URkuwweL2v858SKGQtoL95XCJUdJLjJ09Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=MS+oFe4m; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="MS+oFe4m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1773090187;
	bh=03JjaAVMCcbK2YCJRQz+3vcgmz2FbzHR/INOx7ETJqo=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=MS+oFe4mr3Qo67CC5J4+X8IKBGbkT04V+i2qCF0YU/ZoRyC0UfCe+i8aWXqGHoRRE
	 sD7GMq/wkgk4IViuJ2m7Ig/cxr/Pt9ZN+PC4Hkr5PLL6c3tAcFlG4Eaj3IDxXkB9mh
	 LDqim+DClfBIrbB09okhWCx3Q+CV/99NINDUShUPBwPKwTTE5bPFFRX3lu0FsjAk8O
	 jdTos9qlXCHusn9eeJVqL5J3Iu5lXGYN9U4PWYhnerBoQ8+hXFkgIQCULrduMXgTB0
	 ABVE5Aj4E5LbGHjnMXqcokSAy1Go4rafl4LSYen974zl4maPrMupASVvxkBeDfyBS6
	 h/qtHLqF7Up7UbgcOzFi17f3EJ6yQ8w9MX01XxNT5bnDtO6XzPWTPk0f2jWYyJJAnZ
	 KKnTEX3kfHPmQhuEcSrj36/EgH1xAp8yOXrxP92AtAjsZ1c4faWZI4vcFYZi59Svp/
	 xSbycshpFWTehPM4Ea91psGBBRKhkDCIcSpSDCwcvxWnL81vDZo
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:f669:fd7a:4a47:9188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id EB86D20107;
	Mon,  9 Mar 2026 21:03:07 +0000 (UTC)
Date: Mon, 9 Mar 2026 21:03:06 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: Florian Schmidt <flosch@nutanix.com>, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Option for "git submodule foreach" to also run on the parent git?
Message-ID: <aa81ivufua5uJ4nb@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Florian Schmidt <flosch@nutanix.com>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <032a7767-2350-4312-a7b1-75080519c72a@nutanix.com>
 <xmqqsea9591f.fsf@gitster.g>
 <66419a04-67b0-4b60-bf23-078cf92b2c04@nutanix.com>
 <20260309193001.GD309867@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F0tb+9c4QC9S8zpq"
Content-Disposition: inline
In-Reply-To: <20260309193001.GD309867@coredump.intra.peff.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--F0tb+9c4QC9S8zpq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-03-09 at 19:30:01, Jeff King wrote:
> These days we also have git-for-each-repo. It is primarily about running
> a command in a set of otherwise unrelated repos. But I wonder if:
>=20
>   git for-each-repo --submodules do-this
>=20
> would be a natural fit as an alternative to "git submodule foreach"? And
> then you can imagine a "--current" option to discover the current repo
> and include it in the list. And then:
>=20
>   git for-each-repo --submodules --current do-this
>=20
> would do what you want.
>=20
> I dunno. I do not have any need for this myself, but just thinking out
> loud.

I think this would be quite useful especially if it could operate on
submodules before the parent repository.  My particular use case is with
the SHA-256/SHA-1 interoperability work, since that would allow people
to recursively convert submodules into interoperability mode and then
the main repository (which needs the submodule mappings first).  This
seems like a thing others will want to do as well.

So while I'm not planning to work on this myself, I think this would be
a fantastic feature to add.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--F0tb+9c4QC9S8zpq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.9 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaa81igAKCRB8DEliiIei
gR+LAP9MQTkG01fGVz7khTgDQeXgUO10eyu6gzykv5HZJML+HQEAhi/falDQABbE
8Xmf3Yi4/50/uEN59ehlTOHNeZksig8=
=3SP9
-----END PGP SIGNATURE-----

--F0tb+9c4QC9S8zpq--

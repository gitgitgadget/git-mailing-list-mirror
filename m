Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024E6EA4
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 01:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714093700; cv=none; b=KwGX1NXflaSZClsVk+kSUwH5zsRE8R4+W8sZVPndqDJNGSd6yKjjHrGEEbkK/bkj8f6xexS7ICXPBqFCJdieCBEmhNPMC6bcQWe4V3+It2n4PU+hsp108Gkj/mGsfYoVOuZ0jB6MdXVSj/OSmONpr5g8Khn0n0eB8zRmrZslF5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714093700; c=relaxed/simple;
	bh=gL/ot+WhitXFELCc4aqBGcBJhY6UHkVRCEOGyRsULBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W59YowygcuiNhj3FWdwkU6XbiCBXN8yifPtxM9AnU81QulcG2f0+fXWfgax4iIz4C8BsNCS2U+SuPiJ+J+TW9eWeir5/jB+kvW+w++U5qhq2WgUpjuNAxE+ov1b4hBtPvReLS1/Vrse9gbsmb49XZvGH3hs+FBhhmfIxxg+8nZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=nVufUs61; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="nVufUs61"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 572CE5B2C9;
	Fri, 26 Apr 2024 01:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1714093691;
	bh=gL/ot+WhitXFELCc4aqBGcBJhY6UHkVRCEOGyRsULBU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=nVufUs61Lppb/K/ULkVqdz+Fj0FJoruVNxCY98qUvG1wWWtp07BzCOXi/CcOBT75s
	 6nu0sDYXuPiHEs8yib2amGOvH9/+3DA6qq1EIOen/830v2jAONDY1M5+1Kr2fx0y+Y
	 yQXkxRvtRU0pcM3P0eO2wpCMMsRZAQCObONDZOijZg6FMxQasMlY8VV89zwEQSLDDb
	 9qnn19ggLq6Wk0p1vSpWi5XADPn6ImpiTc+J2sV8Y7D6UZXK1hRBWlA3BI2URgUQVG
	 R56FubMC1He2zBOBkMmBieRMiBYfqx/OI7hJtVWWD97Anb/yfJMDkGuzh07ut+X10J
	 oQjw4MbkEAelQH+t8Ua+FG9sJse6+g9VSX4UE1yDsVSWUPT14Fcdu1tFnqS3TWV+IJ
	 PF6d5DCTr5uTBl3MiYfXPkzRAw1s1F/WBCVAMeUx+GagU/b7Qgp8tzI8Vw4s8eMcno
	 wwKLfSXM/sWoYXJXEnMDTqMQxPMCJWgVi2YOHZmMg9iB2mmK0az
Date: Fri, 26 Apr 2024 01:08:09 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Thomas via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Thomas <thomasqueirozb@gmail.com>
Subject: Re: [PATCH] completion: fix zsh parsing $GIT_PS1_SHOWUPSTREAM
Message-ID: <Zir-eeK0CZxVLhcR@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Thomas via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Thomas <thomasqueirozb@gmail.com>
References: <pull.1710.git.git.1714071592035.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hDuITTDDSgta1SVH"
Content-Disposition: inline
In-Reply-To: <pull.1710.git.git.1714071592035.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--hDuITTDDSgta1SVH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-04-25 at 18:59:51, Thomas via GitGitGadget wrote:
> From: Thomas Queiroz <thomasqueirozb@gmail.com>
>=20
> Since GIT_PS1_SHOWUPSTREAM is a variable with space separated values and
> zsh for loops do no split by space by default, parsing of the options
> wasn't actually being done. The `-d' '` is a hacky solution that works
> in both bash and zsh. The correct way to do that in zsh would be do use
> read -rA and loop over the resulting array but -A isn't defined in bash.

I wonder if it might actually be better to adjust the shell options when
we call into __git_ps1.  We could write this like so:

	[ -z "${ZSH_VERSION-}" ] || setopt localoptions shwordsplit

That will turn on shell word splitting for just that function (and the
functions it calls), so the existing code will work fine and we won't
tamper with the user's preferred shell options.

My concern is that changing the way we write the code here might result
in someone unintentionally changing it back because it's less intuitive.
By specifically asking zsh to use shell word splitting, we get
consistent behaviour between bash and zsh, which is really what we want
anyway.

I use the above syntax (minus the shell check) in my zsh prompt and can
confirm it works as expected.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--hDuITTDDSgta1SVH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZir+eAAKCRB8DEliiIei
gYpZAQCktwtdq7kr8I7QfcU1cJxRa8AmrKZ+u09YKZ/PHogG6AEAjBQk7GFv/ytA
hOQIFXoFl1iwcmFhy9jTd0T4o7QGmAE=
=Gtfr
-----END PGP SIGNATURE-----

--hDuITTDDSgta1SVH--

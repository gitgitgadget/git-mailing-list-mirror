Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291B417B50A
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 23:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738281494; cv=none; b=PMLKGCm1vb7DQb0uA//G2z+xUW7j807gsDnjZOJbvFSLkMd8fKmXCch0R+Bn//62XK6S6hqb2dWfGGzmIY16TNtlAJWZi00zgsp9goF44jlDOeo2DpJWj5j7fj6C1/Pdz8CO31wZbrqSpC89P1b+Xx+5xfCAgXHpaed7qq2RQ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738281494; c=relaxed/simple;
	bh=+3SDP8PhLVQSPYiTsJiK465oDaGhhQ+gpcFDfHG4mDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuimRQ1Us98LY6Op2ezRlaRJq9ANzC8mlGESYcGCGkJ9LueEEDHEGmBdu8xBonlqKs8mKaVHNJ+tWhUMExmTMeTwBASu4MlHQf7pfH2bJJSyve0NsshMc3/Os6NPNXs5SueJVZ/U6ruo4/lp1I+Z34oNBWj+b7ubdFekI6ncZeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=UdiOaMlY; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="UdiOaMlY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1738281490;
	bh=+3SDP8PhLVQSPYiTsJiK465oDaGhhQ+gpcFDfHG4mDQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=UdiOaMlYhBIgaIanJByaGoCjrNN5p08/LxNOiLmKnBA+wVjlqcbGdcdESJAmbFjFZ
	 PiXQEpXSg24yrVzjX+wIUy5DXgSHNnivNC6/uK4qjYTF2qM+Gj6vJRO+yDPyGn6COD
	 6KNcX8cOekM+mwGdsBa5NAouR3debvQ+9rBwbEgR+AgB2PBOmSfkfelH7+CZ2RecF+
	 +U6PAoVHltBJw13aThdjaQhrOxTJNCMmSMl6aKeL+Qpy6NEX0GXNt/04Km64MP25dk
	 nnxgGXfOn6XQFIzsoI5IfqYNOFArkEtkEuSr4p7GJ9s2L3q3jvJ+hdhpLXxzKB0rZo
	 KXzCiHeUEEadPtJHWxqrJzJN5sJipP2Cqt2+Tg0kRwl1tLCSFc5ZetIcCHnytEXXeC
	 JGKZ84PGdz8X3hd9GKFBYKzf+tyWdy/9uMoiW7FuItwSBB4aPnczatcsBI42HZh8Xp
	 qHh8OqdJGP5jcO9MpbE69uNXE/ZcSxZFHSKREs7+sT2hL5bwMOX
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5E31320065;
	Thu, 30 Jan 2025 23:58:10 +0000 (UTC)
Date: Thu, 30 Jan 2025 23:58:08 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/3] setup: fix reinit of repos with different formats
Message-ID: <Z5wSEBZJU0qebKYY@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20250130-b4-pks-reinit-default-ref-format-v1-0-d2769ca01207@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jApFe8HM3r4hdQUs"
Content-Disposition: inline
In-Reply-To: <20250130-b4-pks-reinit-default-ref-format-v1-0-d2769ca01207@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--jApFe8HM3r4hdQUs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-01-30 at 16:24:16, Patrick Steinhardt wrote:
> Hi,
>=20
> this issue with the reinitialization of the ref format was recently
> discovered in our CI systems at GitLab, where caches contained repos
> with one ref format but we tried to reinit them with a different ref
> format. But turns out that the same issue also exists for the object
> format, so this patch series fixes both issues.

I looked at this series and it seems reasonable.  As you mentioned,
reinitializing the repository in this way cannot possibly work in any
meaningful sense, so rejecting it is the prudent thing to do.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--jApFe8HM3r4hdQUs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ5wSEAAKCRB8DEliiIei
gVLcAP4/JZ/tinxaO89Vw7exPJNB0DcG9mqHaK01+XXlpMX02wEAs7N3ZgKeJatO
aJjLCV0+8/TWeE+xz2pNO7QWHpZqDgs=
=anc1
-----END PGP SIGNATURE-----

--jApFe8HM3r4hdQUs--

Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AC81D5CCC
	for <git@vger.kernel.org>; Sun, 23 Mar 2025 09:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742720925; cv=none; b=ZjQoRg+m8NBgvg+w/+wi1979EkK+pbQ2CRfkJkreZS+XagNDyhBT0o4OEpZBeitLJjvcfLe63qiC0Y094JUM3hhKxZxmHUaap2Ucyg05Cxwf6ReQJlBub0z8bw6h3PxsmqEmbUJd9JNysm5uX2COJRqRuccyvuVzHSfBu93cbNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742720925; c=relaxed/simple;
	bh=MWv8KkRROhhep178ImUFnxYvIcnrswEGoGKhZIx3IdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DW79v+ETYQ40eZIiBA+uCVmlHkzZE9S86TngPss24mSyZgr/eNAyvDpwQvRfswuarjfYS7bkzG+N/eWE67KPb0P49FuQotTHnTR3u4DbGZu9VsOXncxDQXx3CzgAb1rqZy4y/6y7ZT/HJKJRwbMlfNOPEWAvdkQG0jsRPSkpRlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=OAhiztTr; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="OAhiztTr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1742720915;
	bh=MWv8KkRROhhep178ImUFnxYvIcnrswEGoGKhZIx3IdU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=OAhiztTrhafvCh9gO9uRefgaeYunq0gUmMsdg3A+l3cU5Q1kR4cZJc+ZZWaH5T1Bp
	 VApYs9HIWMBlR5AsdQf2M/SLiHt/Rp8lYSgpzMt01ZOdNHnpnoVvCGqjabseGzBz4X
	 ksK2p6zt8Zhr3ROPl8vddIP9YxILnzSaWgnMC8efo5otnJAcrfgAnXSl3RKk3fY/bZ
	 D4jR3QvbWCBnCHmRobOVChu9IOoqAxcII6At+xmCFCzN6SLTuXRsC+t7P8IXaok2eD
	 xGIxqi9o2pGhT0z5fic7Vx8yfJDsj6ZNpRDlaN+NmBizHcKubbe7j/RHnmxQlq7/yo
	 WG+Xq0LXNd3xl1H4kfgOvZaqFTIIpRYwA/SGzMJ2M8o3JAhtkuTN7izP5+qCNvB67L
	 kNtl8LL63DZ+eeIKY3r2xjWKBc5FlNhXMfSaMpVdmxyd+lspfeOQ+A7PsZAujrVWjp
	 guCnt7sAiiu/9B7UqTpV4rbj0yugbbrplFNgwJLtkGr6NWU+2sP
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d5c6:e1bb:f3a5:7a20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 616D3200BE;
	Sun, 23 Mar 2025 09:08:35 +0000 (UTC)
Date: Sun, 23 Mar 2025 09:08:33 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Eugen Konkov <kes-kes@yandex.ru>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: Why merge conflict block is located at the wrong place?
Message-ID: <Z9_Pkb7N1J_J9ECo@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Eugen Konkov <kes-kes@yandex.ru>,
	Git Mailing List <git@vger.kernel.org>
References: <1145598425.20250322191649@yandex.ru>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E5DkBgdB+hi5+5yr"
Content-Disposition: inline
In-Reply-To: <1145598425.20250322191649@yandex.ru>
User-Agent: Mutt/2.2.13 (2024-03-09)


--E5DkBgdB+hi5+5yr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-03-22 at 23:16:49, Eugen Konkov wrote:
> Hello Git,

Hi,

> Why merge conflict block is located at the wrong place?

I think it's a little hard for us to comment on why this happens without
a reproducible testcase.  Do you perhaps have a public repository that
you're working with that you can use to demonstrate this, or a shell
script that shows the problem?
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--E5DkBgdB+hi5+5yr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ9/PkQAKCRB8DEliiIei
gZHtAQCuK1gpVS3WzKnhxFXAVZfQnLuzq3qJ1Lu5jMLVtUglgAD/TPsEMUyuljwn
15hodub6ZiWo762EGw0cbhRCEy4aTw4=
=l3WB
-----END PGP SIGNATURE-----

--E5DkBgdB+hi5+5yr--

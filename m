Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05E435968
	for <git@vger.kernel.org>; Sat, 18 Jan 2025 20:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737231299; cv=none; b=jJTHxsWpkBwMEl8euM/St3zg94kVXYwJl1H2F9R/LXf7ShmzVFrTx6kwtjUQ3jYXBSF3m/X0aDJE+VM6DAsXPQfeLqPv2xsHGbELnyaXFtszDbRG+GdiUudqEmW5tTj+LCeTiJfDiT8BmLVbI1ArdKcL7QQ06VUS7fA5A3qiC1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737231299; c=relaxed/simple;
	bh=dFDhdU8jLjv52FgJTF7MpllL5sNinTG7MxwCXzMf4rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIkyujX59DqvBoSixUIm928iQI4b0ESfN1efJEwDTY+zPbLTLBvMpm2csesZ7AaO+ApDbwPbKJy8Cddab4z6Dcg/2ofq0aG7aE4LqggiBGJvAgqVZCN6Yp19uDOMT1l9wEMLxD9918gOsilMc2rzC/iIBmeV6FPw66cXcosrIk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=qEQAhtf2; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="qEQAhtf2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1737231290;
	bh=dFDhdU8jLjv52FgJTF7MpllL5sNinTG7MxwCXzMf4rU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=qEQAhtf2FZhldLsJN0RXjwMEU5V1rFGonYJ3kxJbrRTfVeWau+Zi8Nz3Wyt6bX20U
	 9UFmDGlbpddGTYbLCEFKySnT0ELSE2d8JzwFr3NIFby8IT5BRg1n5g3OWnozgZ8eud
	 fjTb7+pYwgBK9KsnZbPq/s6sXDrl2gNs2hTDuBlYvJRFC4SyRXtX7fm8Zgi9pS5VDc
	 Ly/DCgQoX1JYHPCbwDmzuivXnBSGvbLBn4/lX2vUeoVa6hhMlm7a+bzpSxtJZZbADu
	 PB2KYMPylB36EfHR3naHqkml1lSJ7jps6c4fuA8aWiiC3bpTA++4NYPgRb4S7nBq4G
	 gIeNNGQrCM4ZsjRIDLt1bbEF3LEoyDuaUgtlv5ZRlADlJMXKLmjOLEaRE7C0Wt+i8X
	 hGA7kF1QwgYile9/bGbH/tnkE5Bixs7fq+n1T6JRyi+crfMoc/EWpFX6J/Rn73m1Gs
	 +N+fo7kh4AFKnFSNotFrrj7a7SjAVn03jJ73epYx/mlc1Qxbw3c
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:2cb2:1b88:3581:fc02])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 9858D20033;
	Sat, 18 Jan 2025 20:14:49 +0000 (UTC)
Date: Sat, 18 Jan 2025 20:14:47 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: M Hickford <mirth.hickford@gmail.com>
Cc: M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v5] credential-cache: respect authtype capability
Message-ID: <Z4wLt3oPlR5p2_e5@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	M Hickford <mirth.hickford@gmail.com>,
	M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com
References: <pull.1842.v4.git.1736212760709.gitgitgadget@gmail.com>
 <pull.1842.v5.git.1736462721156.gitgitgadget@gmail.com>
 <8ef3bd22-d2e4-4361-93da-581d2f76204f@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o+r0HetOAwWC+e2L"
Content-Disposition: inline
In-Reply-To: <8ef3bd22-d2e4-4361-93da-581d2f76204f@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--o+r0HetOAwWC+e2L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-01-18 at 20:09:50, M Hickford wrote:
> Hi Brian. Any further comments on patch v5? This addresses your comments =
on
> v2 and expands the commit message as encouraged by Junio. (Thank you both
> for the review so far.)

I think this looks fine.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--o+r0HetOAwWC+e2L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ4wLtwAKCRB8DEliiIei
gVm1AP4wPeVtTy1XEaIOniJKCEF4maL48T3peOpCx//j8sGC4QEAlEClLApvTNrL
qBSrlz19FkiIpFSHhqVEEJ3gv+gKsg8=
=bgai
-----END PGP SIGNATURE-----

--o+r0HetOAwWC+e2L--

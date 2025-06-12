Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C2C1BC2A
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 00:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749689160; cv=none; b=KxD40Kwq5xej3sVdO68iIdBmA68l4fzGeR27ny5ShrupYhpZ7zcEbl63TGPTw1pZ2HFwXkSoRMvVeSV9qZEZx0hds5FDKWqBAf50q6N9eRqP9Pt++jtlUantERpaw9fnMVhGASVd1bXcFYFProfszKMYJ479JG6YSZ6S9vs/60I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749689160; c=relaxed/simple;
	bh=Qn7cG4GIyqSqaHS9ZBwf+yHkf1IiwZrsDsw1Jq4A+Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6NBc3Os4Wt71+tOZL8JkorDs3NWWHaKCzhjDM5WgtPlz/Iwia8S93BHPNw8OSePIB61tyu0txnfHnof+uxqekpXxyQjxs14eBfbrRLTho6ldyIK2QGQPrbLRfX34Xd6bahpv7G9Utq6qcbBzm1IBEqRr7j5rHrvrV3aId+EQ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=EtDes/mn; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="EtDes/mn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1749689157;
	bh=Qn7cG4GIyqSqaHS9ZBwf+yHkf1IiwZrsDsw1Jq4A+Mw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=EtDes/mn/MtjAyAcBY1yQkrvXgcHhjzBQ2/w750MDNblsl6X9jxIEIgMKdn36K/Xo
	 bZN3X6dWsS9+vTll+6bEV8OEZJXYOhe54K0SB5C20ae3uhYvUYPOg8G2xptGtcYGQg
	 RrZMkyBaw9htHlgDwlru/mHdMxjTaEipONCDlnIBeD1F3hpXBgh3BjYg70xgTbe+yS
	 JDJdL09lBX/RnpEsngvHj6t2N/ixtA/8Oa/r80r8S0Bym9/HgMWPXGQxxK+ZNmHKSF
	 mWXYonQLt7hmXZ4JVVor1YnC3iWWQIFktjMkM3JqMf7MbQE+AXSiYbZgoXOPHkosG9
	 53HlUxeg2VyHXXbYbz91LEWhHUG7h/mLGHDSJX32ufuzIwAErjIKS4i0aHo01tUUiI
	 HFmxFCLI9VLUFsU4mu5IgSHwVsIQukEexyCfur6tTLtGvBsiEW8ThT2BXyzy8b3QKS
	 IYGCyBfae6KWgvVsNRsJvaCqBic6bL/2tZg12B1O6ucuXWMmR3j
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:828b:3227:a916:b7f5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 3DAF92008A;
	Thu, 12 Jun 2025 00:45:57 +0000 (UTC)
Date: Thu, 12 Jun 2025 00:45:55 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 0/4] Importing and exporting stashes to refs
Message-ID: <aEojQ34wpqhCjGaV@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
 <3526b0c0-7020-4c39-bc09-99b63a58db8a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3Res+FNIAjz0HbJ7"
Content-Disposition: inline
In-Reply-To: <3526b0c0-7020-4c39-bc09-99b63a58db8a@app.fastmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--3Res+FNIAjz0HbJ7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-06-11 at 11:35:12, Kristoffer Haugsbakk wrote:
> I think this feature works well.  Exporting locally is simple.  Using a
> whatever-ref to export to the remote is a fine implementation.
> Importing locally is simple as well.  The `--print` option for
> script/machine consumption is a nice touch.
>=20
> Also I think the DAG implementation is cool.

Thank you, I appreciate that feedback.  (I would also have appreciated
feedback about how it could be better, but I do like that you're happy
with it.)
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--3Res+FNIAjz0HbJ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaEojQwAKCRB8DEliiIei
gakBAQDnaw9MUksvatEykd+j1uy0CDyFSHYeBBAuBAugJyzbQAD/RhBAytaSLsU9
+e1r5ro98vwI47Rr/GCSdJAw+mdEDgs=
=6jXx
-----END PGP SIGNATURE-----

--3Res+FNIAjz0HbJ7--

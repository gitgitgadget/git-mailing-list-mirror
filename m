Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E8C7D3FA
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 23:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718147774; cv=none; b=jJt7CEHodYFSPKIuN3NDwq1hlxgE0E1iRbVfOq+q73u7EONl8vPQHsSLRmr56xb9mcZBL8aDWSu9XbwMiQbq25/dBGTeFxwB4mlgVgp2r5VG/USIoeO+dPk8I+YSXFPxR3KVRoanC7bUZyAWI8D+IXAZNd8UDmpYGPUTyv3K8R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718147774; c=relaxed/simple;
	bh=hjBw3wqJuTsPXFMUszHXYYOaUW3gZl3DMSdUpKcMcwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5tTCB52M13V/Af88dIxZkEXKzPJmgROvToYp0x8y4CuL8zJeFCh3fhv5rmLBvuyCOvsiCD8vrNPe/CSla92Gih88Y+S1ppf20zGXSwWws6ExBUPD1hH6dbgW8DHJTmVR3D8FUDc5Zq0WsqfteIyYSKF8d/gG/o3nJG02aXtHsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=g67wEkRG; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="g67wEkRG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1718147765;
	bh=hjBw3wqJuTsPXFMUszHXYYOaUW3gZl3DMSdUpKcMcwM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=g67wEkRGzz60gqmb1/+VePl04JtAoMihivDL+fvt9eEllm3myt0rf/BlUSbOtarPN
	 R/aAR87girtddsMB6kee0bori1cp6LcKsBwbGamBNZpUkq1NzpjrIeXw+A2MmCgrLk
	 eHbDtxQhg9J7HFHotaSLEGrDCnkZXeTExJ/LAQ+nXxF3kygOYnNEqZVKsIi2t/Gy0i
	 6foziHYlHPjrPcmvjBS9oHTa9Scm6ZyE2+62nNSWxKBhDEI0PwfDgGVJPqkGLu6euq
	 +5O9sVzt8I+0CCgnxUFkhLOshkKsvokSjUw06DjWOy5ZHI4QAd2zySuOdCRDBQ5b4R
	 143nNpri0RjU7SmOU++p5MvE0eAT1LCUEmXWOzAqtGdJvE5Az0MBNsdLIoedgjA/+N
	 KBMynGD9aVITpNCDOFEKJP3Itq+lyaXWfG61nbVsQXpl11ec9k0iMxsrlEkha/Frzh
	 w7YM7E7cOasQ17Op8TzUn2Pr7umE/ZO51X6/KC+dXSBE8e3z4Md
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 2BEF92639C;
	Tue, 11 Jun 2024 23:16:05 +0000 (UTC)
Date: Tue, 11 Jun 2024 23:16:03 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 16/21] compat/fsmonitor: remove dependency on
 `the_repository` in Darwin IPC
Message-ID: <Zmjas3s9OPJ9Ff5E@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1718106284.git.ps@pks.im>
 <d4e87f9d6b4813fe359e22f4b5d5ebda28e09a08.1718106285.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5hbQvqdmQbN1lNMq"
Content-Disposition: inline
In-Reply-To: <d4e87f9d6b4813fe359e22f4b5d5ebda28e09a08.1718106285.git.ps@pks.im>
User-Agent: Mutt/2.2.12 (2023-09-09)


--5hbQvqdmQbN1lNMq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-06-11 at 11:58:47, Patrick Steinhardt wrote:
> The IPC socket used by the fsmonitor on Darwin is usually contained in
> the Git repository itself. When the repository is hosted on a networked
> filesystem though, we instead create the socket path in the user's home
> directory or the socket directory. In that case, we derive the path by
> hashing the repository path.
>=20
> The hashing implicitly depends on `the_repository` though via
> `hash_to_hex()`. For one, this is wrong because we really should be
> using the passed-in repository. But arguably, it is not sensible to
> derive the path hash from the repository's object hash in the first
> place -- they don't have anything to do with each other, and a
> repository that is hosted in the same path should always derive the same
> IPC socket path.
>=20
> Fix this by unconditionally using SHA1 to derive the path.

Let's instead use SHA-256 to derive the path.  I can imagine that there
might be a time when some users would like to drop support for SHA-1
altogether (for FIPS compliance reasons, say) and we'll make our lives a
lot easier if we avoid more uses of SHA-1.

It is also typically faster when compiled appropriately, although the
amount of data we're processing is very small.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--5hbQvqdmQbN1lNMq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZmjaswAKCRB8DEliiIei
gRp0AP9A/PACQm6uw/jpdX0pJa1QQ3E0Ol5mvJw7CQqKp8ASdQD7BdGU2FY2XnG+
+oXT81zRAJzBRjDBjRL1820qOIN9gQ8=
=V44C
-----END PGP SIGNATURE-----

--5hbQvqdmQbN1lNMq--

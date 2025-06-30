Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5021487E9
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 18:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751308191; cv=none; b=gCR2GSFaGLqzewcEpL+k6gLwlaN6NI8LfxItOwc//OSSXX4R+0rUTKcPlRYFCrBduJW9GtVL265wCkUAbOHoSXyGdfB68bLk7XyneOqUVz8G7DOczcLIXljmFX+ctH91k9MbpnHT3cL9rBHe8w3waT9oaBfVrlkDXgf1ZlRsF58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751308191; c=relaxed/simple;
	bh=BlqGrXk+uNbjP0xBfzM8nMNpcWRIxk46gg3s2Dbrg04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FyhzrR7UwAjwsLnW2iJX0joXiayaJQI2pB2MvLZQBYnN3ZfNEL5Q/XJJFX+XzthNLRmDpjuXlrmUGezfdqw4E4hw0rltogDyoTB+qyuPu1mZ7QRZYD/DcU0znUUJf82oRpCOUtxpxDPxcWcAEhNT5dDlIuI5UVPMnZrtqDMUpII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=H0gn+9h5; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="H0gn+9h5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1751308187;
	bh=BlqGrXk+uNbjP0xBfzM8nMNpcWRIxk46gg3s2Dbrg04=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=H0gn+9h5xl9pF/4l7RCuHtnodDHlsofgCGYDvfm06ib2qkYaLWKNMPo3eEUSuiHLD
	 qYczQW2WDmrxVxolScp+ViZyIbKQX7Q+GykA4nXGPqADVFPDgxzNDecopyYaWSrbWd
	 5qKBf8JrxqDd7cUFfzH8IDawGXqR+rY+ewkU/eo485OyiGVyYWBQ9dYp5aOTSnQsyZ
	 YiJZSMfspRJxPDTvOSbbyqQW5IeQAF3FFxh7CG5YsaUYFIDglAxBq7PmHMYWZswY4E
	 kQ+akrU8qcBLdHtt5pkSSb3H5/ErecqHF97PtN58xXdxqhlccc1ZgCJflOYNTlMAVM
	 k5Tx4RtClFlpCI78lygDrxEDLjaVRJhYeOvIT4wMOOeclrPRdCJhNbsxBxxAt/Z4xi
	 cqzBIauM99/62zRMid3U41CIUy/6puhLMm2P8lWhW8/Co48DsKPua+npYvbTyu2D5u
	 aum9wBvVKglxfJGE5kgiZrB+G/rNOTnteW1bhJegHbd0KhIvxd/
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:a75c:9d59:319d:c156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E99D22003B;
	Mon, 30 Jun 2025 18:29:47 +0000 (UTC)
Date: Mon, 30 Jun 2025 18:29:46 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: git@vger.kernel.org
Subject: Re: Failing to push to a repository erases authentication helper
 credentials
Message-ID: <aGLXmiYuM2C_xfWJ@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
	git@vger.kernel.org
References: <aGKU-o9eXB1VHuN9@kitsune.suse.cz>
 <aGKfs5VRdmnw6Pqc@fruit.crustytoothpaste.net>
 <aGKokqPJPh5fQ3fc@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zIbdIxR1IXN0Vkk6"
Content-Disposition: inline
In-Reply-To: <aGKokqPJPh5fQ3fc@kitsune.suse.cz>
User-Agent: Mutt/2.2.13 (2024-03-09)


--zIbdIxR1IXN0Vkk6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-06-30 at 15:09:06, Michal Such=C3=A1nek wrote:
> On Mon, Jun 30, 2025 at 02:31:15PM +0000, brian m. carlson wrote:
> > It is in fact desirable because otherwise the user continues to attempt
> > to use the bad credentials and then can never again authenticate
> > successfully, since they are never again prompted for credentials.
>=20
> My proglem is that the credentials are actually valid, only the
> operation is not. The current behavior erases valid credentials.

Then the server needs to return a 403 or 404 and not a 401.  A 401
prompts Git to expire credentials and a 403 or 404 does not.  Only the
server knows whether the credentials are actually valid for some access
or not at all.

RFC 9110 =C2=A7 15.5.2 says this:

    The 401 (Unauthorized) status code indicates that the request has
    not been applied because it lacks valid authentication credentials
    for the target resource.

and =C2=A7 15.5.4 says this:

    The 403 (Forbidden) status code indicates that the server understood
    the request but refuses to fulfill it.
    [=E2=80=A6]
    If authentication credentials were provided in the request, the
    server considers them insufficient to grant access. The client
    SHOULD NOT automatically repeat the request with the same
    credentials. The client MAY repeat the request with new or different
    credentials.
    [=E2=80=A6]
    An origin server that wishes to "hide" the current existence of a
    forbidden target resource MAY instead respond with a status code of
    404 (Not Found).

So the server is incorrect in returning a 401 in this case if the
credentials are actually valid for a different operation on the same
resource.

> > Git doesn't have a behaviour to do so, but you could of course craft a
> > custom credential helper that just rejects the erase command and passes
> > everything else through to another helper.  That would achieve your
>=20
> I do not want to use another helper. I want to preserve the last valid
> credentials.
>=20
> Of course, using credentials that are not maintained by git at all (such
> as ssh authentication) does not have this problem. Only git-managed
> credentials get erased on invalid operation.

In general, Git does not presently offer this functionality.  We could
in theory accept a patch for a config option that makes this work, but I
expect it will lead to hard-to-troubleshoot problems for the exact
reason I mentioned.  It will also require an update to the Git FAQ to
disable that option in the example, since we use the exact same
mechanism to delete credentials for users who _do_ want to expire
credentials.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--zIbdIxR1IXN0Vkk6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaGLXmgAKCRB8DEliiIei
gQBpAP4q+j5k5glT8JSxwYzFsMseQz8KpV2oUMxoSsGX/F8D8wD+Pjtt2kyO1xV4
O+2SW458VAwyUbX+MAAUSI2RQowucw0=
=7sSy
-----END PGP SIGNATURE-----

--zIbdIxR1IXN0Vkk6--

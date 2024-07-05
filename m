Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9314610B
	for <git@vger.kernel.org>; Fri,  5 Jul 2024 00:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720140593; cv=none; b=V8S/eiDcGVh/7g8bsAf+zLPowe9vHA9IIq5xzc73gcC7lIAOfDqjIdr8ZNWTgbmv06LuezuV2ADIBmClaEpKJI4/kz/C/cy6Cu5piDUGhVCv/0GaE3BxB+rhnZE584devcm/QVhXDQJQ/8lFOew8lQICwXsr0tRDVpXUNoo4mCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720140593; c=relaxed/simple;
	bh=NZRIlrs2rRG9LzuoHsfzp5l3Bh6ZIhnRMldez7Zxlvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M17vpcy9/Uuzj2ef62uy8HnpIqIp8PC4IMSLP7SaAKsRfdTC69/BwekJLcGdHaKbkwA3MUjyqvNCusyqAuFsvnIbjdb0n496r1FwB+stYnMQ6ATlJsIvQcH6AkxVwYZLCA+cYsWeb1RCyFUa25+G5nv9kFazSFXWHlmffZipbaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=kQZORbRs; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="kQZORbRs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1720140584;
	bh=NZRIlrs2rRG9LzuoHsfzp5l3Bh6ZIhnRMldez7Zxlvo=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=kQZORbRsEi3WHm3c4aeRxpXEGYPsCfXRAWuDyKQyHcrN025G2M8hA1lud1Dtaml61
	 uMSqdr3jMVf2M58HJsVD/h0DXkDkcF+0NAFYNIdTxwvBjoajj0tdO0qqhIGcCBAoeD
	 hT/QKBw4KJ88MFhBYVrBryj8c/JE+cXnytk4/9yuZHc+qMacdEgMCkGN11fm0nncG+
	 JN1KNGj9e0eMSMuUhtQ68sStlFWh59mwtYJTrBMFbMTYAcantaipBhr3KyRvTXhHPY
	 s1DVKt5VQ+2PAijbIybwf2sEEU8pT8j0OhMr7oISgEHxt7iihR2iOxY3QnOPdOUiF1
	 rShk1bb6PvvUp2PDSF5tQQ8/+dUUdF7lMFl3Aaay7QppYmW6IsGv3xG7VEK9lleyIq
	 sLUlRw7eL/hzk7cVQMglLCob5hlxW+xJG3slYg1IWMzbXdK6lljixaxXP3Aa8MgrZM
	 VE/zjrTXfTSWVyKxffGxknHkWes2TSK1cuXE3NZMt9oYqenVALQ
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5CCB220993;
	Fri,  5 Jul 2024 00:49:44 +0000 (UTC)
Date: Fri, 5 Jul 2024 00:49:42 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Dmytro Ovdiienko <Dmytro.Ovdiienko@iongroup.com>
Cc: Elijah Newren <newren@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Losing the file during rebase
Message-ID: <ZodDJq_SzONsP83m@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Dmytro Ovdiienko <Dmytro.Ovdiienko@iongroup.com>,
	Elijah Newren <newren@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <SA3PR14MB6519B74CA58C9AE49DC28513E7DE2@SA3PR14MB6519.namprd14.prod.outlook.com>
 <CABPp-BGE1aDb5Nch8kQx+uZkCvbTz6sN0m2Yad=1D4=z0C9JNA@mail.gmail.com>
 <SA3PR14MB65191BDFF1F6E867969A678AE7DE2@SA3PR14MB6519.namprd14.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VyOciXetmGasrlUN"
Content-Disposition: inline
In-Reply-To: <SA3PR14MB65191BDFF1F6E867969A678AE7DE2@SA3PR14MB6519.namprd14.prod.outlook.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--VyOciXetmGasrlUN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-04 at 21:45:25, Dmytro Ovdiienko wrote:
> Hello Elijah,
>=20
> Thank you for reply.
>=20
> I guess the simpler explanation of what is happened would be the followin=
g:
>=20
> Let's say there are three commits: add_c1, del_c2 and add_c3.
>=20
> When they go like this "add_c1 + del_c2 + add_c3" at the end of
> execution you end up with 2.cpp. That is the case before I do rebase.
>=20
> When I change the order of commits into  "add_c3 + add_c1 + del_c2"
> (the case when I do rebase), I end up with no 2.cpp as add_c1 after
> add_c3 does nothing, because the file already exists. However, would
> be great for Git to return an error that it cannot create one more
> file. That is probably would be the best solution to this issue.

Unfortunately, that would cause a lot of spurious conflicts, since one
technique that many teams use to incorporate changes is to rebase them.
Thus, if Alice has added file X to branch A and Bob has also added file
X to branch B, and branch A gets incorporated into main, then Bob has a
conflict.  If the contents of the file are the same, then the user will
not appreciate resolving this spurious conflict.

Note that the behaviour you get for rebases is also the same one as you
get for merges (which isn't exactly surprising because rebases now
usually use the merge machinery).  If Alice creates branch A as above
and Bob creates branch B, then once A is merged into main, B won't
conflict for file X.  That's because if both heads in a merge contain
the same file with the same blob object ID (and thus the same contents),
Git short-circuits the entire merge machinery and just incorporates that
version into the result, which is much faster and more efficient.

It may be that you're thinking about this process as applying one patch
on top of another, which is the way that the older git am-based approach
used to work.  However, the modern rebase functionality is designed
around merges internally, since this tends to avoid the brittleness of
patches (such as misapplied hunks), it's faster, and it tends to be a
lot more robust in a lot of cases, including with renames.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--VyOciXetmGasrlUN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZodDJgAKCRB8DEliiIei
gYvCAQDHI+wSHUXg3Mt0x0L+1hYoPFnbIKFTp0CWhZurMFRtpwEAjEf+Npe63ga7
N74GdTLCKxc32IiS+rpBZATG/nmwPwQ=
=cEsz
-----END PGP SIGNATURE-----

--VyOciXetmGasrlUN--

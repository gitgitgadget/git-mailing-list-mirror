Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF704651B7
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 21:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711660739; cv=none; b=gEv+aW80W1EddNRG0fItZosSvZu9JM4VXBCXEdkzgdvrqgQ1nvY2Oi7pQ4I/4nW3QA6bHTUAq7bcDWOzNtDW+VKtpAzayjw7/Jz95zkCutEtc+CxYFHDXPm7OvfS0UmLq/F78ieLDg38YWZ39NNv6g838p4GtBv1yQ+yuqxAnYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711660739; c=relaxed/simple;
	bh=Q5nU80CaKl7Xk2uq34pLitWOoQAe4gI5qv9r8k6X28o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAu1MQFb46ogoS5I0GY4Z9c269i0ZLeFuMDdwoaYXaFgYNfo6iGFXkzz/Zcf2Q5ma3KbKSTk/+4GJ3LWCFQlvBcn8Kd6iDow9KszsUc3cz+KJSU22ETkK9jFW0S6HliHuHu1HrSA5+IO25PA9V91HbM30xpEZhXi8LabxMoACZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=zZMvzbmn; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="zZMvzbmn"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id AE58F5D49A;
	Thu, 28 Mar 2024 21:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1711660734;
	bh=Q5nU80CaKl7Xk2uq34pLitWOoQAe4gI5qv9r8k6X28o=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=zZMvzbmn2e3kr2fkCA0KD5OpAKlZiAsGSO1bdEKGdiRvQvMe3XWLNwRwsV2W+gR2/
	 wPoluYdWZXmakUFRjV/YHnstMxThnn4p77b0DmK4pnkGB4pW9oIoyYyigLT4ARdYmt
	 jnX09Qyv0okjSg0O8uvvVZlvRwbIVmDrKlETpSlJD0Gqu03lffQlUs+4TF9+SDyll+
	 ol9n1eySQvfiuB3veyhtD0dd9aLSdHqCW2REOBn6perWMkx+KzJn/R+GqkyHC3wwqy
	 r8hGX+aU/iTZ4Q/W0CnZ9L9RMfvAftrb5BRSg1KSFddJfgIHO8hIyqw7ltIevNTB1v
	 FhXqgyUdjmukvPro89se8YtHT66ba5PdQaLGaC6gINyw3Z4+SKGsadneKxVvtmT89I
	 9Qg02J+rJBVL0CQwCBPnJaGvYqCqSrDtoTe378WryzSNYkTn0CLA+PvHgJvq+kTBXM
	 nwyexgU7kGbhbsBDdQ13UYaYsXzZpjzQVOqJ/KtUovdGTAT6B2c
Date: Thu, 28 Mar 2024 21:18:53 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH 05/13] credential: gate new fields on capability
Message-ID: <ZgXevTHIkZoC3vnj@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
 <20240324011301.1553072-6-sandals@crustytoothpaste.net>
 <20240328102053.GA890906@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p7YjxkPGSYNEp9ww"
Content-Disposition: inline
In-Reply-To: <20240328102053.GA890906@coredump.intra.peff.net>
User-Agent: Mutt/2.2.12 (2023-09-09)


--p7YjxkPGSYNEp9ww
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-03-28 at 10:20:53, Jeff King wrote:
> I think this "|| return" needs to be "|| exit 0" or similar. The Windows
> CI jobs fail with:
>=20
>   --- a/expect-stderr
>   +++ b/stderr
>   @@ -2,3 +2,4 @@ verbatim-cred: get
>    verbatim-cred: capability[]=3Dauthtype
>    verbatim-cred: protocol=3Dhttp
>    verbatim-cred: host=3Dexample.com
>   +D:\a\git\git\t\trash directory.t0300-credentials\git-credential-verbat=
im-cred: line 10: return: can only `return' from a function or sourced scri=
pt
>=20
> (actually if you count the line numbers, I think this particular case is
> the similar "|| return" added to the script later, but both should be
> fixed).
>=20
> It doesn't show up elsewhere because only bash complains, but not dash.
> Even running the test script with bash isn't enough, because
> write_script uses $SHELL_PATH under the hood. But building with "make
> SHELL_PATH=3D/bin/bash test" shows the problem on other platforms.

I'll definitely make that change.  I run Debian, and I've left the
default dash as /bin/sh because it's faster, so I didn't notice.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--p7YjxkPGSYNEp9ww
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZgXevAAKCRB8DEliiIei
gWc1AP9zSIuY2VFM9nPpVNRKRodCBGnEU1EFGcuNukff6oaQAwD/dPUm12VUll3x
wtIbjP4X6ar7b8cSiFJH9wCTF37fKgY=
=i520
-----END PGP SIGNATURE-----

--p7YjxkPGSYNEp9ww--

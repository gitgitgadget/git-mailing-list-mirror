Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBA2196446
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 12:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730980930; cv=none; b=qoKeo06L/iv42jeEgouY0iLvp9MqkBNm4lS0mSX5GnHTpF9bP2tL4ZOGOwpP/CNbSbn1Bf+dW2Lz4VCWE1zcRPGK2jNRun4yS42YZ2FVMOoT6NJX47Mz5cul/cY0oZr7HkATl5j3OqZHM+Zs5IqOQgGdKTtm6Lp7LPvArMqtrVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730980930; c=relaxed/simple;
	bh=VzNJl+Df1GtbYIn0ohp2MDzCwo3Q2wmwlTMXvbc1RyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEl+YcSG1lFAIXojA1qCVXCx61v6RWRFO1c6zRZbNjIWEPK+V31vQROJnb0NZNAwbsEUlT9vzeQZabzjLKIZpxrNgY1wNRa3QHB5Jt9EeO6edZyqyEm9pbdeol62ufsemlMvTsWIYJrbJnUFd55KVkzRK/DP9XgK2CnMgGMh7sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=ncSAkAC2; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ncSAkAC2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1730980926;
	bh=VzNJl+Df1GtbYIn0ohp2MDzCwo3Q2wmwlTMXvbc1RyE=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=ncSAkAC2g5Ofl39xYoVZ15TouQ8/FG3+Pct4OTxKlCqhhsYpSwMkFQtr1ii8IfsYv
	 yHPQom6daYUIYI/amNpieC830uhBED8sfp8TTJ/u/zL3YDVujRAZW7aNYTiS94wGdt
	 5mAW0RJZLKTQEQdyKMmGMe5ZdwSAiJVFmtE/DltgZgFKYD5YS77AQIaY/+2zrYHerr
	 4mjP4uqMYHdINb3RGxRbXeGZq5p53HS3bFZZcDqsdSp7H/j2vhg43xllq4lGtk42Be
	 UfqLLi7RPWJCF/SfwjqmekuKJm5PUeW6XBcsaJPIZZkGRTHhl2X7yQsysyPbrwAyJD
	 L5L7HHx07LVXSiVYgB0F47Kxz89VLPgFpViAAhKE307KYG1LQKXvq5uEsU89e88FMp
	 Yb62DfBhcXMb5Y5tWuqOWYzh4NMPyWdKI3/MUtouvjpNvf3gO3+q1NGC+6iDcJWZcb
	 7ULsih2jm3AF6hjM0RL8bENCD2c7CZCnfnun0D9pYpL++SyvkRx
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B1219200C7;
	Thu,  7 Nov 2024 12:02:06 +0000 (UTC)
Date: Thu, 7 Nov 2024 12:02:05 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Julien Maurel <julien@maurel.me>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: Question about merge & cherry pick
Message-ID: <ZyysPeBRXvTAxLVf@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Julien Maurel <julien@maurel.me>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org
References: <711a0faa-6d82-48b6-819d-9ddbeda03f6a@maurel.me>
 <eb367098-0c88-4bc6-b824-32ee6e6d273e@kdbg.org>
 <a129e967-efba-48ba-b5a0-1abbb0af5c9d@maurel.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pYYYgzh0fD/w3YSa"
Content-Disposition: inline
In-Reply-To: <a129e967-efba-48ba-b5a0-1abbb0af5c9d@maurel.me>
User-Agent: Mutt/2.2.13 (2024-03-09)


--pYYYgzh0fD/w3YSa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-11-07 at 10:32:06, Julien Maurel wrote:
> Ok, I didn't have this vision about how merge is apply, thanks.
> There is no option to merge by considering each commit individually ?
> Rebase do it but not applicable in my case :)

There's no way to do a merge commit-by commit.  The recommendation is to
do a rebase, since it essentially does a commit-by-commit merge under the
hood (due to using the merge machinery).  The title of the FAQ entry at
[0] doesn't perfectly describe your case, but it does sort of explain it
and it explains how the merge and rebase machinery works.

[0] https://git-scm.com/docs/gitfaq#merge-two-revert-one
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--pYYYgzh0fD/w3YSa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZyysPAAKCRB8DEliiIei
gdEAAP0dakoRxx1sA2IaUR5qA4J4iLv4f/zXTaf5GotoJKGiQQEAhegOmkURx2Tz
Q5rCctNrsPbGvB14SoBfqm0v/vO0LwI=
=VVMA
-----END PGP SIGNATURE-----

--pYYYgzh0fD/w3YSa--

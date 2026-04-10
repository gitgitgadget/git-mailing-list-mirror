Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDC938C2AA
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 20:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775851454; cv=none; b=EBHjfs90yRlwlZq30pjf0YOif4NDawZTaDpZ7aWqnToafQQH//PNk7oKrpVOkOwNo0yfuqakmkKbT9QypIv+MiN0zFDTmNoGUOnA1vkmnc1oDdaicbc5EZUqRg+yO3DJMVn2T3mVLu3h0hOSHORdxDCiQYLsZiNuhokOuGAKJes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775851454; c=relaxed/simple;
	bh=Q1ljhmsHBC3jIlxtneKHsx+2du7A9Yq+xUfJKPYAXfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+ZnQVRvMx0zTdV0SgQfL4jngCnrkXzZpQr5/Z7kMJivbhe3iDbif1VUqZVsvgb8PAqj9Lpp7lMZ9NIMa/f/frL9aUoNBfjLWJ+BpjaA0yrcgHl4fI59hvxnR5TewD1wC/NYCeTk3+XEt90TIFuptPz/q34SnDgnVT8FsCYb1MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=CmN/c+Cm; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="CmN/c+Cm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1775851442;
	bh=Q1ljhmsHBC3jIlxtneKHsx+2du7A9Yq+xUfJKPYAXfM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=CmN/c+Cm9HE++q48PpMk0ss0LCEXVpvuL2r4v9yQl2M7a13mz+VeYdfzQQmEr6sN9
	 QtXVq1gzkpDY7ry5JNpPFYR6O0nFTBt17I/ASI3MAKyoiyhq6GFwKmi3AjUl0D/ZSq
	 8vmYlcJf+YLxj2pD2N2HmSyZwuCvOy2GW8b/SKqSG3t2JE0zc3mmOqVT2oomrRaqXH
	 s/UPpK550gXP0bzzoKdTfz44qLzwtwtyCqiqF3oDiEeohXRa0loMR/VdGQxd7i8ZaR
	 YeGnjMfOOwQNwOaMNmUBxO2yVnw+ckMtpW8rB4RiPo+5n9GF81o38OTAvanuuOYZDl
	 meeBpXd1OP+bVDxnSbE4GBVKMOlxyfQpbCp0bdx5RPYWJyffqiUsgGTj97I/hYvnip
	 +03JPNJ4rGnNr46zyfbwCZy2yJYcZtWkwdLIl0U5S9gkTqEtafItGpIFcAQET8Mnl/
	 JsONGwNazvrpTuijGa9tD/EeZlHBIfNN+PgoGROhMzA3mMdoXmj
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:690:ed17:613c:3cb7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id EA9A020041;
	Fri, 10 Apr 2026 20:04:02 +0000 (UTC)
Date: Fri, 10 Apr 2026 20:04:01 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v2 0/4] Enable Rust by default
Message-ID: <adlXscAv57Xd7p01@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
References: <20260409224434.1861422-1-sandals@crustytoothpaste.net>
 <4efc4133-3726-4b9d-8f06-03c07d48af99@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="37+0V378igOde9Cn"
Content-Disposition: inline
In-Reply-To: <4efc4133-3726-4b9d-8f06-03c07d48af99@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--37+0V378igOde9Cn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-04-10 at 13:02:13, Derrick Stolee wrote:
> I'm glad you're remembering to help us follow through on this promise.
>=20
> However, I'm worried that we shouldn't do this change during the rc
> window for 2.54.0. Perhaps we could get a small patch that updates the
> docs to say "we really mean 2.55.0" that lands in the 2.54.0 release,
> and then we merge the requirements for the build in the first batch
> after the release.
>
> This would give us a full release cycle to simmer with the requirement
> instead of slipping it in for the last rc.

This was actually sent out just before rc0, but Patrick requested some
changes in v1.  (I forgot to thread it to the previous version,
unfortunately.)  I would like to have it in 2.54 if we can because I
suspect 2.55 will be the last release before 3.0, so that doesn't give
much time for people to update and adjust if there are problems.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--37+0V378igOde9Cn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmnZV7EJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ+/nsq8htVcYMnWrc8DEzV/zRpYh8aDcXEYmC04NyRkc
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAN3eAPoDji/0EOnTG7o1Z6cRdJjtmgfq
9pPDazG3C6X/hfYpXwEAhM0OQd6n/yXefssBaV/5+Th/u5TcI/YsFTL0qu0SGg8=
=Y+hR
-----END PGP SIGNATURE-----

--37+0V378igOde9Cn--

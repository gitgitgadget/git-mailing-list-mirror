Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9155724A04A
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 21:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836824; cv=none; b=SFH5XKCHiRmxQZik5D1geGapKl3yGOB7BMCrH13BtYbi+wLouKnIY2xk8+dOU2ZhlOtB1OfhPSN3GZZdKUujywyqHKoklVmUAS3FbHaqiQklI+HmWYvD7oWtD1/6Hws8icc4PQ4vz3/YYHDTlaR5IlKQQPKZSyzdRWg/to7nztQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836824; c=relaxed/simple;
	bh=h89ICDPDg7eMdsQfT7Gm2Sj9IkUtiDMEqWzmSZGw43g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwIjUL4F/NMLiClb9YMnzxCnAhd5LSMXlDQBq4JVk0PXIHNg4cfFkV88/PfzOkY0aPdJz9qwMA6ZlQBfnQBci2gO4XpFwGAa6A80WmxF944L07kd2YCtLP3fqgZlDx+Tqs5DMlauEnNe1yE3HaRVsfbObqT5q3zdTTuO6DgX6Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=OaU8EBPw; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="OaU8EBPw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1758836820;
	bh=h89ICDPDg7eMdsQfT7Gm2Sj9IkUtiDMEqWzmSZGw43g=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=OaU8EBPwtaRKPJKwPmTw76gc0PcVevI3NX7N97BHOKMiEuy2kiWQGToCuat1h6I+J
	 w4tAGfN/cUdUDT48RojTo/az+WR8Ui3uHApZ0EDyzsqnyH57YvZO6n0tLFsGfHKSgx
	 KfxcV5ISgeuGUPtASJ2DjqDgDvJ21dwUMD6YwtDd8sOF1R5ZHlsnfpjcBHxIrhehXP
	 0q6JCpgHp9sAloNPgz/rdNq9NZapFZHfv0xYBbtt9byrolpAGrxKI1O8KlloI8Rjpy
	 CwBIqTji3VodfJA3esU8bwqM2SO8vs9VC/XHkx2QqqfNFfaKtdmmP+k1Mt0bGYemY7
	 xSirRLwyBdzKnwtV3uOQOL36FHFbP7IDtA8u/yDb3NrJLe6ZO1RI0G4YnPO0ENpOwa
	 jCTYAXgqX2GyZ1r6N3FiP4oTIIcLNErhQKP7p3HGfpGBfW6fWXwtlOVOMG5LNi/p5/
	 Ea+wbCCk7Nc1etTU/Ged1HREi3l4N84h6saSrU83CIdmflyISqf
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:916c:9d5f:e4b:808d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 228BE20107;
	Thu, 25 Sep 2025 21:47:00 +0000 (UTC)
Date: Thu, 25 Sep 2025 21:46:58 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 3/9] docs: reflect actual double signature for tags
Message-ID: <aNW4UgPE_sitLgGU@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
 <20250919010911.649831-4-sandals@crustytoothpaste.net>
 <xmqq348i138l.fsf@gitster.g>
 <aM7IQibwwKFJZcYE@fruit.crustytoothpaste.net>
 <aNOj-1xy-UTP_3E1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hv7I24J2NwH6lS/x"
Content-Disposition: inline
In-Reply-To: <aNOj-1xy-UTP_3E1@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--hv7I24J2NwH6lS/x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-24 at 07:55:39, Patrick Steinhardt wrote:
> You mentioned a "missed patch" in the commit message. So is this design
> here intentional or merely an oversight?

The original design was to implement all SHA-256 signatures in the
`gpgsig-sha256` header, but the patch to do that got dropped
accidentally for 2.29, so we shipped without it.  I decided to fix it in
a compatible way for 2.30 using the design here so that users who had
created SHA-256 tags with 2.29 would not have them be mistaken for
signatures over the SHA-1 values of the tag by Git 2.30.

I knew that people would try things out nearly immediately and that some
people would use very old versions of Git from their LTS distro and did
not want to risk making an incompatible change that would break the
object format, even while things were marked experimental.

> I'm mostly asking because it feels weird to me that an object shouldn't
> have both fields. I would assume that it's easier to implement and
> reason about if this signature always was a header, or multiple that is.
> But I'm not familiar enough with the logic here to really judge, so I
> assume that there are good reasons that I miss.

We should not have both fields.  In the SHA-256 version of the tag, the
in-body signature is SHA-256 and there is optionally a `gpgsig` header
for the SHA-1 version of the tag.  When that tag is converted into SHA-1
format, the in-body signature moves to the `gpgsig-sha256` header and
the one that was formerly in the `gpgsig` header is placed in body and
that header is removed.

So we will never have both unless we have an additional hash algorithm,
say, SHA-3-512, where, when in SHA-3-512 format, the in-body signature
is over SHA-3-512 and there may be both `gpgsig` and `gpgsig-sha256`
headers.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--hv7I24J2NwH6lS/x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaNW4UgAKCRB8DEliiIei
gS6+AP9EzG9XicbhlyoD43t7FjFUjRK6SeIPhVqOoFTpZu5KpgD8Cl5UAfZIeYKe
hl2cVdUUz9Q8pIflY22S8edhCRUN1w4=
=cVcQ
-----END PGP SIGNATURE-----

--hv7I24J2NwH6lS/x--

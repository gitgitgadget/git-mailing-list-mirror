Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C42E5616D2
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883171; cv=none; b=nAba9Ou46hELs+EIALbDXXdnmgaINt84D2i6YSJnDRZy5yeY3g9EsG1MIdOneNebmeqbk2BhLxhNHt+3FKxh1ksbL82Hzc+wTvt7yvJcAoymtdI73dpirhC2G/lnwV1C47KI/JCoEi6bmsApBXFn1mRDb3iWyKWEdltILFbHEhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883171; c=relaxed/simple;
	bh=yk2AnH3Ue2GmKndqzjlMRU7W20uDmDJcIpZ+YRQErfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTiqGpYV8cdIvc0JVVWKtSXUhpyKgQkKk2sgAi/1qQL5iZxDcgnidxcj2wiQ0kLc/79U5CJm4eP/iYTGsc81fMNVdGMpOJNYRc/XeFEy5N0WfrSZGSPEid2g0Z/n0IcegZf2fSdj76Xd6+Nq+XY3NDfUGWTFroCPQdK0BkUOVEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=UGREPPgK; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="UGREPPgK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1788883167;
	bh=yk2AnH3Ue2GmKndqzjlMRU7W20uDmDJcIpZ+YRQErfg=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=UGREPPgKe/BZDvWMlNoC0dGbEXakNFpUTZnlFr4JD6k2X37Og0rhCOLFzuUUK3/5K
	 CyA5aXu6nL0dWtTwE4u7FEcZvK6L5OcKvWqM+OYFwaPz7VoutRO8bs0K6ElUEnu6mt
	 qUvcaJ/Tp6GzTWbNaUfPPlDx//FsF4maRYvfQYssA3QFXmvFhhOBnkZoTwoOPf5hzm
	 624KyZToZBRSuxkeVd8HBkF5I91a3Q4JJu4+VCyKtu/6q22V0gICjGNu+xvBP9lDB+
	 +Vuq2w18DX1PdHrwWjqOFtqACidQzYSqAEmJ8WUm5/DxHAtsLfgucDhRcauqBbUZsI
	 g1rWFb9VNCVueIQd7B98qFExErXU5vphDgoqmzXo0QZEew4N7sepE+ZD+xSUplXbJq
	 lcD32yV4q2elJaWmy/8vJ5H80aPFfswyoADyvYos4m5X50aby7SE6zOBJV+tdZNAsA
	 3MRh7x/kL37PjZ58dzYnCVRbJa1qyKGRIvh7F3mRgunzKc9mInw
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:7b23:2dc:c9d2:f0e4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 6366720113;
	Tue,  8 Sep 2026 15:59:27 +0000 (UTC)
Date: Tue, 8 Sep 2026 15:59:25 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: rsbecker@nexbridge.com
Cc: 'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What will come after Git 2.56?
Message-ID: <aqAw3a3Ek0EZg0CH@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	rsbecker@nexbridge.com, 'Junio C Hamano' <gitster@pobox.com>,
	git@vger.kernel.org
References: <xmqqmrtu50av.fsf@gitster.g>
 <ap2tjx0z7kiFjDM9@fruit.crustytoothpaste.net>
 <010801dd3fa9$3277ae30$97670a90$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HrtgD5q8KHOmGDXe"
Content-Disposition: inline
In-Reply-To: <010801dd3fa9$3277ae30$97670a90$@nexbridge.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--HrtgD5q8KHOmGDXe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-09-08 at 15:46:16, rsbecker@nexbridge.com wrote:
> On September 6, 2026 2:15 PM, brian m. carlson wrote:
> >Similarly, I am not aware of anyone who is seriously undertaking Rust su=
pport for
> >platforms that do not already support it, so I don't think that should b=
e a blocker,
> >either.
>=20
> Actually, I may have some news on that score. While it is unlikely to mak=
e 3.0, it
> could be soon after. Unfortunately, all info is NDA, so I cannot really p=
ublicise it
> at this point. I remain very hopeful.

I'm very pleased to hear that some progress might be being made.  I,
too, am hopeful that NonStop or other platforms might provide a suitable
Rust port that would work with Git.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--HrtgD5q8KHOmGDXe
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmqgMN0JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ4sX9tjzPPTF/1/w/7YMH+VgxWPtMtiPMSJy/LR9PkSI
FiEECCzmip28ZfuD0cORfAxJYoiHooEAADh6AQCAyatMVDiVeLaXTJfM1fIWmPCn
l1NyukCSjS7yeJ3CKAEAmHIWQ6eC0DrNRCRqDIcVOLzIX0uJdYCJs/w9/ZQ+JA8=
=MS2G
-----END PGP SIGNATURE-----

--HrtgD5q8KHOmGDXe--

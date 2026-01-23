Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D698E2DCBF7
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 20:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769200168; cv=none; b=PG4DidWb4Mb7seXDR3ggHFiDLd2cSsKW5cOFtvP2/iuam9ZezkUHicyutZ3Zp4pHwx4z3IW6dvv9xZbAZKAwUGUHXq/RUn5KI3vGYOrAXf0rqs6FwSSchMqw4wLEKQF3vRAPMWIZAw3sfAf6QNoUfDHfNMUgP3J4yTOwS5eWe0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769200168; c=relaxed/simple;
	bh=bE7bU2PxxT0/iarZlZjDHAEnYZAw0uh+Cqc8CCB0+JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqpdL1iZ5JijgtxtoLiXnQUytij7A/8K2V83u6UXpp02Zz7vKNi69hRAEFiXqpY98p7Su5AeO0Cfr9Y1z2n5BVgLobBPXS7917rymbh6szHVobEiRT81iSHrMHlp0Ie8Vrl3Qlyh8BA34hAZqYY34wCtBm4KLKDV/5o0VeNsm80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=lrdfZZzw; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="lrdfZZzw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1769200158;
	bh=bE7bU2PxxT0/iarZlZjDHAEnYZAw0uh+Cqc8CCB0+JI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=lrdfZZzww5+ZL2jhwHasFHGtSf5qttJnWTsgWnUENBOR4yIMx1f7cWei+6PJ5Ckku
	 pk/4Ca9qvybpHRRaHBIHtq9YHal9/QFkMXA6cAPAimGAL1Nm7k6QexVHcoc0OrP7Ce
	 qUJFckA8/tprwzFgIVHfOsiCz5O9veIE4tqLjQIjaQ1dKrsGpL4TBs7ASkugN8sen2
	 zmcnR2JtNxwV9ksYe7LKoZO6Lwp1CFc7I/dO3qwzGLurnraIO2Zq9c6QSbCD8CLfjT
	 oLHtuZT4VcCMnlf0nZgB1DEZdb2kR5262WzFFhXsYuyDz8sdP2CcLjoErOT7g+tzuY
	 8YSd0u7Do0sGUYw/RhB5Kewa7H3ghifZAKUkIEk47z/XxeQiRVizGGK9QI8Or440Zn
	 0/kkCMDr30BfPorx6PtiphmDF/OBsU9ClExTiu2TmNj4oXzYQfKQBT304D74WYFpUK
	 1mF+SDk4w327c+Kz988CmxsLSJshHvY4oKksho8Ty0AHunQemgN
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:504b:5db7:29f5:6f63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B883320081;
	Fri, 23 Jan 2026 20:29:18 +0000 (UTC)
Date: Fri, 23 Jan 2026 20:29:17 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 1/3] show-index: implement automatic hash detection
Message-ID: <aXPaHWV62HEfHyy_@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>,
	git@vger.kernel.org
References: <20260120140901.517928-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260120140901.517928-2-shreyanshpaliwalcmsmn@gmail.com>
 <xmqqzf68yx75.fsf@gitster.g>
 <aXCJp_rGPetsXE8J@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vkcZplau7xBFZkZS"
Content-Disposition: inline
In-Reply-To: <aXCJp_rGPetsXE8J@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--vkcZplau7xBFZkZS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-01-21 at 08:09:11, Patrick Steinhardt wrote:
> I think if we wanted to fix properly this we should rather introduce
> index v5 with a header that encodes the hash used by it. Like that we
> wouldn't have to guess anymore. Whether the hassle is worth it might be
> a different question though.

Index v3, which will be used during interoperability, will encode the
hash algorithm and can be used for single-hash implementations as well
as multi-hash implementations.

There's an implementation in my `sha256-interop` branch at
https://github.com/bk2204/git.git and we could simply enable it by
default at some point in the future.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--vkcZplau7xBFZkZS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaXPaHAAKCRB8DEliiIei
gQANAP4mhmh6HphOuGNWWf7/1FCt6R9SSfkFAE3r3j0F9JEx1gD/aBstUeezHpMD
1QdYXdcFRLwgo/1MLujAWto6NiuyPQA=
=PYsy
-----END PGP SIGNATURE-----

--vkcZplau7xBFZkZS--

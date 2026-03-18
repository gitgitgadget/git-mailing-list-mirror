Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C4118DB0D
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 00:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773793489; cv=none; b=YjCtSc9o1OUK+WO69jovnpKuWURKW/pd35HbFRtNr1i2Tro/bMbjEuD1IKKeSHpZK89lwy6j743GxOupm2AIhu/PUoBu+Eir7k5kjdN3G/s9+25cth/wEP0YtBduIwQKpiPYWs/NP7p/tyspg7YJqzDXynHdm9cn2eUNv5b/Omw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773793489; c=relaxed/simple;
	bh=2q6sCBogS/0U9vqg6Rv8ppTXHErAeSEKOCQxKjXNxwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpGs3N+kw/EAdkwDAwdQIu+fgW88ZIm7IvEcdtcfPtTOfJPnSXHWTroxYbODaRnZcR5wCG4Q/g1uXusSOwsmh5RV6DUMAdq31WGp/4Fk3SFte/cxvjPt3GEWhpw1SAa9BWfGepH3Xp//lnINfHdjmiqw9F7Ckt/EHyQ7BiaPdyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=FAb0GE+N; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="FAb0GE+N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1773793480;
	bh=2q6sCBogS/0U9vqg6Rv8ppTXHErAeSEKOCQxKjXNxwE=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=FAb0GE+N2e6q18t44i8Y0n1uA7noJZXe0lL4Llg/3nr4L461DdaSb3ISJvlNpQQPb
	 PykjSOk2B+1Qv/4/tEz45MPNYs2jx2+MDO27+qjeHJSribcAMEX9WzgPnWiTvlgesn
	 XhdegshhxXXmVF7tKynrWlGBBP+b6I58J4g1QWJh/WWdPp4LRaSfaI+R/TOQPi0RaK
	 MD1+k9WntVHsTtSCiPwH1zITkYST5+ueR2XlxozPJhBnf3ZQeGAyWhXGg4boxXz/f8
	 HL2Ts3ftgK7iswMfMMKGWPbvZUQkT32Ksl5AZzB/CsykZB9Aux/gE4HLa3iKQiyEuD
	 hjKWytXJpb+v54xxjMt/7ds//T/Kc3xzXQYreyCKfMF9JdZA+QHDc1qSLiyuv7p5rL
	 2Rk53ujgDcsw3ep9ttP7VWGUgl1GC7olAbfNZubXDvjGbyLUWerqKcxA0VEVPteoPf
	 GiDPDrdS4uTZ0GK5reFNPtySwiX6N37BsEetARSK1u91MXW7mN4
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:e78:738c:708d:b4da])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 0266720113;
	Wed, 18 Mar 2026 00:24:40 +0000 (UTC)
Date: Wed, 18 Mar 2026 00:24:38 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] rev-parse: have --parseopt callers exit 0 on --help
Message-ID: <abnwxmoOw-ZLT858@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
References: <abYCxrEEPaI21g3H@fruit.crustytoothpaste.net>
 <20260316220742.1286157-1-sandals@crustytoothpaste.net>
 <xmqqcy13mgdk.fsf@gitster.g>
 <ablCBkmOdoourCnO@fruit.crustytoothpaste.net>
 <20260317145543.GA1828@coredump.intra.peff.net>
 <xmqqv7eul71y.fsf@gitster.g>
 <20260317184441.GA574291@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F+2BpZT0u2dQmXVa"
Content-Disposition: inline
In-Reply-To: <20260317184441.GA574291@coredump.intra.peff.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--F+2BpZT0u2dQmXVa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-03-17 at 18:44:41, Jeff King wrote:
> So unless somebody can come up with a more compelling example, I don't
> really see much backwards-compatibility risk. But maybe I just lack
> imagination. ;)

The only reason I can imagine intentionally using `-h` in a script is to
find out whether an option is supported.  For instance, I have this
alias:

    co =3D "!f() { if git checkout -h | grep -qs recurse-submodules; \
        then git checkout --recurse-submodules \"$@\"; \
        else git checkout \"$@\" && git sui; \
        fi; };f"

(`sui` is `submodule update --init`.)

In most cases, that's going to be upstream of a pipe, so unless you're
using `-o pipefail` (which is only in POSIX in POSIX 1003.1-2024), it's
going to succeed anyway.

I suppose one can also use it to generate a manual page, which manual
page generators do, but that seems silly when Git provides much better
ones unless you desperately need one in a different language for which
Git has translations but no manual page.

None of these seem like they're likely to care about the exit status and
I suspect that if they do, they are probably using `|| true` to ignore
the unexpected 129 exit code.

So I agree that there's unlikely to be any sort of backward
compatibility issues.  If the consensus is that this is shipped only in
3.0, then we can do that, but I think many people are not going to care
and those that do will welcome the change, so I'd just rather treat it
as a bug that we fix.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--F+2BpZT0u2dQmXVa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.9 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCabnwxQAKCRB8DEliiIei
ga+8AP0S2kYeuJkbE9Fv2V7A3IWzUqUQHNxjhh0LM1cFpXFWfAD7BVkv3QYSvD4e
Jw+kNgrY+6OFreDlLcDztqZsMrXmhAU=
=XQzY
-----END PGP SIGNATURE-----

--F+2BpZT0u2dQmXVa--

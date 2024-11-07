Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D57DBE40
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 02:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730945131; cv=none; b=LfAZCbiFlw6s1yPVhaVTEbBpgtFnzITf7Wdu8E6gRKFA8OGHhjscvYn9hc+jTLF48GB3in7/44hxAXZ6Omk9AGDR6VM7oGVbwANBwjgFWmfi9Ahi8bv8gc4bhZ6NmuOLoBGFcL7u8YxPn3tVIpHs0N/MTEYSx86zej11jU0O2aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730945131; c=relaxed/simple;
	bh=HRxGf7l5M72KGwogdKHCeH/zjAuXo162GE3Ale/eDVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKozfthXuM35H5jo6CiWCbl8LD4M+5CDFlzVW8SwNxBVHwZr7hQ8VGBYnpv8fYHB6j8ZhAp0PMGbTGsu3/Ndbyli1SveIsxvCYRitouKJn1vUq+DQrMmRm7FjL5Ai+hpMWZoUrWoGRbic1a+5NCtFmCeJSJv3Kx+ZSxI+O3WXL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=c5kIGyCo; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="c5kIGyCo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1730945128;
	bh=HRxGf7l5M72KGwogdKHCeH/zjAuXo162GE3Ale/eDVw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=c5kIGyConDZxLcbJwiFLqRGl2o3JUkNO4C/X/p1zZjK8EeEfO9arOhfpNQ5YH+9la
	 2lhuXwXJJ4k/6VqvtH40Bjeb6iA85W0Ov/YhC+QcWsmVLqZNuI+GLaMdhzhhwND8iS
	 txguqiT/UV9Shfz4zmFpszmsu9XOcj1xw/SyVvYW5JbZ4XlnzvSgj32q0xXOV/po9k
	 nznbF8oaH/blcLWletXxus6YASIJcKEI29dksJEJS4GsQf0x8Iy8pvKCgiUmegbcd/
	 bd2E4/oq6YnnD09Dqw/Ua0+RVOMKERJEty+rPDf3ayaSVBzOEIjQv9dGA0Mm8fb95S
	 buYns2UNdTrPRPgfAzqYBrGAXPrKPNMgQdjioCfFXYrvU7DVT60datcuu8/Xo0qSk9
	 G69uyeJuTvQb6bE8gMvnukcyWb7zsxYYfNngZswJVPd1gBm1eEN98RK3SGMJTiBLJH
	 Y/LJrJBZD/8OgbahVEvLt3cYR+IWrgn6k5wYAM7wFMfTX1rC8AD
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5E43720073;
	Thu,  7 Nov 2024 02:05:28 +0000 (UTC)
Date: Thu, 7 Nov 2024 02:05:26 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] t/helper/test-tool: implement 'sha1-unsafe' helper
Message-ID: <ZywgZt419SfPUVkQ@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
References: <cover.1730833506.git.me@ttaylorr.com>
 <20241107014737.GB961214@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LTnx9g/TEkRs18++"
Content-Disposition: inline
In-Reply-To: <20241107014737.GB961214@coredump.intra.peff.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--LTnx9g/TEkRs18++
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-11-07 at 01:47:37, Jeff King wrote:
> I think this is a useful thing to have, and I didn't see anything wrong
> in the implementation. I did notice some oddities that existed before
> your series:
>=20
>   1. Why do we have "test-tool sha256" at all? Nobody in the test suite
>      calls it. It feels like the whole test-sha1/sha256/hash split is
>      overly complicated. A single "test-tool hash" seems like it would
>      be simpler, and it could take an "--algo" parameter (and an
>      "--unsafe" one). I guess in the end we end up with the same options
>      ,but the proliferation of top-level test-tool commands seems ugly
>      to me (likewise "sha1_is_sha1dc").

I think we do in `pack_trailer` in `t/lib-pack.sh`, but not in a
greppable way:

  # Compute and append pack trailer to "$1"
  pack_trailer () {
  	test-tool $(test_oid algo) -b <"$1" >trailer.tmp &&
  	cat trailer.tmp >>"$1" &&
  	rm -f trailer.tmp
  }

When you posed the question above, I wasn't sure why I added this
functionality: was it just to test my SHA-256 implementation adequately
or did it have some actual utility in the testsuite?  However, I knew if
it didn't appear straightforwardly in `git grep`, any uses would involve
`test_oid`, and boom, I was right.

I think a single helper with `--algo` and `--unsafe` parameters would
also be fine and would probably be a little more tidy, as you mention.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--LTnx9g/TEkRs18++
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZywgZgAKCRB8DEliiIei
gWcfAQCptbfzc0DJt6wCYzDq655j/l6/n91K3d9kXnI9MIWidgEAqOfYVbPLdzF1
2uMusimxom40dEJLL3BZTXS4GjR3tgw=
=F//8
-----END PGP SIGNATURE-----

--LTnx9g/TEkRs18++--

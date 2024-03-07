Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3185313E7CA
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 22:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709850028; cv=none; b=iZHtRy/+UdumpwYDykZWBlGQLCIiaGtoIsyR0sCPHMuZuu3M3oC6k/tCc1MdunF/TDo8VAk8pX/XzvdcrGpFNIcuUfWfs7i8TToEFvCpXeFbUGCORvTCectnHbDvnJ8QTKVhmLX67ZUGwsJqlHr/1DcmRxhd0MKGG/bDY1AsSAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709850028; c=relaxed/simple;
	bh=LPbiwXDRpA4ezFagvXRiVttlSE1GRKsfOwyt1qpVbyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHGl6xKAHynqbP2Gi8QDEBpY48ZVo1kbgykQLuJACUCHaIcLSKDdoRSYxJ+qqf9KqTMW/xl7TGwGp9aBKKDd4JIBAcEybBKySFDQxU8LjM1PDPkXuqVophFSxilK699/9nwhkdOZ3f/gl09dmN1xsg6xljtpgH0yEYPu20DUD2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=ot3X520t; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ot3X520t"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 563565B3CF;
	Thu,  7 Mar 2024 22:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1709850018;
	bh=LPbiwXDRpA4ezFagvXRiVttlSE1GRKsfOwyt1qpVbyA=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=ot3X520t7QLYbFwjWRICqha84mKYsjAANEpnKD/mnY54IztbOZ3L6ayG9UGAv1Yh4
	 eOLiqd/9mnMKbrmOSNzqli1JNqVH3pNzZxyAaUPCG0RLdsvWizs3XWms4ULrLIVOA0
	 H3l0RQ+9Jm46OTayFeu6xBVo4wPZ8fQ0h9YpJY0HwDRrQdAV0pJuRhXWlmlJJ0QWOg
	 rUSgj/+ePkHo6vu2DK3AvQd+FNuOlRrTINL15RyP8EMrx03fp4Xy4hqyR6nutane62
	 jhWVf3uVpl3JEC4zaaO0/t7xgAErncMccd2YJbCYrxtutFL/0RNcB3zkhQA4m/gfTu
	 fw9tAqNuMU9wlBgvg0tX9XdjhSC51VyGvi8W+SXzD05Mbqf8q7q2TyzwP/l0t8Arht
	 sg5TYl2LkBuDkI92RyAfWBLJpuMx8Yp9gIBCeJAv1cvafZ6dFoCfEubBfJCPcWY/aX
	 p/2qMv2cykhAbILh35X7+vVSxd2kqqCe9Zq2uguFv9oV6K2t7z4
Date: Thu, 7 Mar 2024 22:20:16 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] doc/gitremote-helpers: match object-format option
 docs to code
Message-ID: <Zeo9oAkL6kxZRugN@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20240307084735.GA2072130@coredump.intra.peff.net>
 <20240307085632.GB2072294@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iPTnXuo69D64Prqy"
Content-Disposition: inline
In-Reply-To: <20240307085632.GB2072294@coredump.intra.peff.net>
User-Agent: Mutt/2.2.12 (2023-09-09)


--iPTnXuo69D64Prqy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-03-07 at 08:56:32, Jeff King wrote:
> Git's transport-helper code has always sent "option object-format\n",
> and never provided the "true" or "algorithm" arguments. While the
> "algorithm" request is something we might need or want to eventually
> support, it probably makes sense for now to document the actual
> behavior, especially as it has been in place for several years, since
> 8b85ee4f47 (transport-helper: implement object-format extensions,
> 2020-05-25).
>=20
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> As I discussed in patch 1, remote-curl does handle the "true" thing
> correctly. And that's really the helper that matters in practice (it's
> possible some third party helper is looking for the explicit "true", but
> presumably they'd have reported their confusion to the list). So we
> could probably just start tacking on the "true" in transport-helper.c
> and leave that part of the documentation untouched.
>=20
> I'm less sure of the specific-algorithm thing, just because it seems
> like remote-curl would never make use of it anyway (preferring instead
> to match whatever algorithm is used by the http remote). But maybe there
> are pending interoperability plans that depend on this?

It was designed to allow indicating that we know how to support both
SHA-1 and SHA-256 and we want one or the other (so we don't need to do
an expensive conversion).  However, if it's not implemented, I agree we
should document what's implemented, and then extend it when interop
comes.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--iPTnXuo69D64Prqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZeo9nwAKCRB8DEliiIei
gbTfAP4rvNvvMYopMGn4Tbs3yS1QqVdyPLMx9t6HFn5yrBoJAAD/VuGNaXSg5P3V
HhQAIrH935jTtA9EQw/0yrK4WXTN9A8=
=nmB8
-----END PGP SIGNATURE-----

--iPTnXuo69D64Prqy--

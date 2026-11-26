Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=172.105.7.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795732070;
	b=adux9zYsu/+MIFEbTSR6ga6s5xO/u5bsIUScNGe0kRjJiYe2dPWPk6+BO27AI1LwQkiN
	 faduIqmhitAqG08pUtbs/wXqRGHTLqnwIeQGT8P9ND7i3lC3KQPE7X8OfiqEk9buMZs5r
	 e//FvumcPeraEBuTr4B+7qrDeMvClSKy7FCMIoKfetb3JrX0iS2J3JGKyoWKlcTftPPCG
	 ArAvdqYcHvsMz/eEksM0UCkCo+kjDc9KUzpebXxH1w8y/8g4awluoXSkryvOOEOrCrMf1
	 fiMZQiY/uffTODGgOmZeCZSGnOVMlr+b6cBRCePsPZ5P3wNoLwSfjAOGipdqU+Mue2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795732070;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=a1bb35Nt+4SKng8oyu+GDVZQcDpijRSK5jYRjNR2cmA=;
	b=5qfIT2iE3V3bUYKu+aUGPXKPM/z97C+GMqRBb6+aqjM5PZ99K8pE401Wqmcu74ynSoyL
	 q1RI6qo3P47D6KUChIYaK9nw1FQp/1jHHbAE2FJJXmOV8I0220XqJy9lc5uMw/hxstu3H
	 D9ByvhrOXqEGPIuc21DWFUtMJ7m+9VaZSM4VCJK5b/S2pT7aMjqq4Y6QUCM0D8KBQs/e6
	 Xd/ZYItH/hsldbwCXjhoq5SB/F2EwKqN1UDus6e7Mf7WsmshOFlrxW76NuLHTyLIlVC50
	 Ha/dRlkn45pMm8j4IPm0oj6+7M7HjXgv/4DvpFckUxPWmGdRXkX/JT4pUjEZTcmfnxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crustytoothpaste.net;
	spf=pass smtp.mailfrom=crustytoothpaste.net;
	dkim=pass header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=fBC86A8v;
	arc=none smtp.remote-ip=172.105.7.114
Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EB2606A31C
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 22:27:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40EB2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=fBC86A8v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1795732069;
	bh=TWagn8bRKC5/ZrAlJXaNNBqJycTXhRQFxZjFQjtUJ18=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=fBC86A8vWcGdPM1Vw8cAJK9dI3XTbpfpZiXlLgP9jz1mUlpwMUVMbd080g611ZocS
	 5ezg8yszkyn9CsYwbZYS++nfkrzjr4G51z1NgpmJ/xyYYToBdmDOsrM70Dk5XNkC6l
	 EnEKgqgyUiRbiNNS4XFUlAu+An/hkjRmquTYxiysr9vq4AO1WTF96+3aVBkkmlzYLY
	 jkulYqhGSizLYTFzzDLCosjDYpgbi9y0kfoGIBD2PBUtazeywOojKK338VlGOkcmjv
	 rul1bAs3+S0GtSc1YTfr65o4+aIEG+0OVKVnPAEwXvotHDKLtTffBspdFv+qO16GIr
	 yOIKyNtCBxK///vfeBiJ4orL/jObQvdjLs0mnoPecqO0haIcHrjy1+RWsBViE9omLs
	 43fmss+F0uB4jWFYs1sh/J0Ab07AozGFGcUNx9Z0DalnyFFhBpBRohLyy11Qgv56d2
	 thtOrcTHh9k/upj0C6LYL0FgCXNIqcZCrSlApsXkTpCiA9N8fbU
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:3039:9617:3790:4535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id EDE60200B1;
	Thu, 26 Nov 2026 22:27:48 +0000 (UTC)
Date: Thu, 26 Nov 2026 22:27:47 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 07/13] builtin: populate pack index v3 fields when
 indexing
Message-ID: <awiyY0v5pUnWm-Gd@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20261023072559.3204273-1-christian.couder@gmail.com>
 <20261023072559.3204273-8-christian.couder@gmail.com>
 <xmqq1p87i7t1.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+JDPK2lUW+uF/RkK"
Content-Disposition: inline
In-Reply-To: <xmqq1p87i7t1.fsf@gitster.g>
User-Agent: Mutt/2.4.1 (2026-07-04)

--+JDPK2lUW+uF/RkK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-11-26 at 21:47:38, Junio C Hamano wrote:
> Christian Couder <christian.couder@gmail.com> writes:
> > @@ -483,8 +493,15 @@ static void *unpack_entry_data(off_t offset, size_=
t size,
> >  		hdrlen =3D format_object_header(hdr, sizeof(hdr), type, size);
> >  		git_hash_init(&c, the_hash_algo);
> >  		git_hash_update(&c, hdr, hdrlen);
> > -	} else
> > +		if (compat && compat_oid) {
> > +			git_hash_init(&c_compat, compat);
>=20
> Doesn't this regress indexing using v2, though?
>=20
> Here in unpack_entry_data() (called with &obj->idx.compat_oid from
> parse_pack_objects()), and similarly in resolve_delta() when checking
> 'if (the_repository->compat_hash_algo)', the conversion runs even when
> opts.version < 3.  Because index-pack cannot yet convert commits or
> trees whose referenced objects appear later in the pack, running an
> ordinary 'git index-pack' writing a v2 index in a compat repository will
> now fail on packs that previously succeeded, even though '.compat_oid'
> is discarded for v2.  Gating compat calculation on 'opts.version >=3D 3'
> (for example, passing NULL for compat_oid from parse_pack_objects() when
> opts.version < 3, and checking opts.version >=3D 3 in resolve_delta())
> would avoid regressing v2 indexing.

You can't use index v2 (or v1) in a repository with compatibility object
IDs.  The reason is that we need the mapping preserved and v1 and v2
don't do that, so they lose data.  If we use v2 to index a pack that's
already been indexed or a pack that's the result of repacking one or
more packs and we have a compatibility algorithm, we've lost the mapping
and a large number of operations will simply die loudly since the
repository is effectively corrupt in that case.

I believe a later patch in the series will force v3 when there's a
compatibility algorithm in use.  This is much like SHA-256 bundles
always use bundle v3 since v2 can't express the hash algorithm in use.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA
Speaking for myself only

--+JDPK2lUW+uF/RkK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmsIsmMJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZxkWvUL0lxBPlU3qFDbpqRiBdKV7283UEpgMd2f3I/CG
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAK2IAPsGhJo0TIb2b1d+YNyU2bBIS2eE
dFwqmsWoagPAlHZjtQEA1hmRVK+z2Ax4YF++0DJMNwD/UlRQ4CctXvfpdgTVJwg=
=33uG
-----END PGP SIGNATURE-----

--+JDPK2lUW+uF/RkK--

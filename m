Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HoW8/7Rr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vC3vJpUW"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1FD10CC
	for <git@vger.kernel.org>; Thu,  7 Dec 2023 05:13:33 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id B350A5C01BD;
	Thu,  7 Dec 2023 08:13:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 07 Dec 2023 08:13:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701954812; x=1702041212; bh=PK
	U5el/4t7zKOEImcQqRK7x4/QvfdtExH0gH/CwLxqk=; b=HoW8/7Rr3IijJopyC8
	7YhEGs8ErXo9j+KuvBgdt3bETA0mDVChUtTdpzJRjj0q8Q8Cxk1DTHTrlhOpHqJM
	ffuvNHRcPgbgiJ136CV0CYDLRvki7bIS0XhuVXWZ+VM/8Nvt7CwXvvU+9xpo3uEc
	KzZawnOB/3AjdUEuCXHDEvWNMGItWFv6eo8IWwjU3Bd/5Mn9wuR/58qLxRzHrGc3
	wfn+OO29ogZX/cP7ykkxDoIbYUOMqGLSzH2BBUWQWJ/P6MFV5pvP5zKwGTQRZ96r
	xFsVMmrgFaSNRTwZnLpqs3Hl6beQryI3FSaZHSL1nFKb350grlbcxZ1PkiFGXuFr
	15Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701954812; x=1702041212; bh=PKU5el/4t7zKO
	EImcQqRK7x4/QvfdtExH0gH/CwLxqk=; b=vC3vJpUW/z6hBHEFcpG3Pf928pdH/
	i6uH0Pc+4mX9gqpB4d06WKTD565a31slgZfJsTomnglSATWeC7mQPgMBqvIfKFk7
	IrWB5dNWDh4m3YM9CU3x4ckraxDD49300AcbSHgnJku7p0+/4ZMnoJVZ9S/Fxg9v
	MLDd6NmhSTfRQHOYvqFRDPAfU71IBQSF92jguCxFC9ojSEBxJBBylIGf6jWiN+Oj
	9FLhOOKWQQottoMe0xHNyzirvhxDNpqmjtwSDMw4bLP3z6ooMzuf9hNXSlbVwd65
	c7ySgCbitEMl7CMZm/gd8gatVw44mcRcL8/vvq7fW2akjf7F6TQwHppKA==
X-ME-Sender: <xms:_MRxZRdpzuJg0wHHsDJb6D6SgMmAfmOuheOUXV7sCDfASS2vDt9WLw>
    <xme:_MRxZfOEdx-VRnbaZX25xVvxombG_0HuerHpZ210EbW2Erfwcxa_HPj3dOW98oDhh
    egeooFPcCXb6ZMRbg>
X-ME-Received: <xmr:_MRxZahFughtUDAMW1WLJbn59C7navoC2YaKkHKujXlSmjhypESKyCPzegRP_cBdGwMrQSAP4jmjFNtVYTLjeBCNoGNhtL4OijjXW4ScoiYWe8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekvddghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:_MRxZa8EqD0_wzVtfR5JNKwWqqvQCZT7EQSEAcbl4VH1NoIfh2KRLg>
    <xmx:_MRxZdv8VoTd09UGFa3E4FLnHU00P0U5SpwUtKdyX1b5seYijDitrA>
    <xmx:_MRxZZEHAQUVju6DJdBV41D5z6lT94xRevY9J1aUXHtTZkleqSKyVw>
    <xmx:_MRxZW6qtGMIE9d6_8llZE-2mXC6iWAVY5TQokRH2x_ZM3OCvueCkA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Dec 2023 08:13:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2a0c8257 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 7 Dec 2023 13:12:03 +0000 (UTC)
Date: Thu, 7 Dec 2023 14:13:29 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 16/24] pack-objects: prepare `write_reused_pack()` for
 multi-pack reuse
Message-ID: <ZXHE-cLrP7iRHWHY@tanuki>
References: <cover.1701198172.git.me@ttaylorr.com>
 <67a8196978244b56d4f60861f140b78c59d15e30.1701198172.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="weMgyVlWs/m+aesh"
Content-Disposition: inline
In-Reply-To: <67a8196978244b56d4f60861f140b78c59d15e30.1701198172.git.me@ttaylorr.com>


--weMgyVlWs/m+aesh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 02:08:37PM -0500, Taylor Blau wrote:
> The function `write_reused_pack()` within `builtin/pack-objects.c` is
> responsible for performing pack-reuse on a single pack, and has two main
> functions:
>=20
>   - it dispatches a call to `write_reused_pack_verbatim()` to see if we
>     can reuse portions of the packfile in whole-word chunks
>=20
>   - for any remaining objects (that is, any objects that appear after
>     the first "gap" in the bitmap), call write_reused_pack_one() on that
>     object to record it for reuse.
>=20
> Prepare this function for multi-pack reuse by removing the assumption
> that the bit position corresponding to the first object being reused
> from a given pack may not be at bit position zero.

Is this double-negation intended? We remove the assumption that we start
reading at position zero, but the paragraph here states that we remove
the assumption that we do _not_ start at bit zero.

I'll stop reviewing here and will come back to this series somewhen next
week.

Patrick

--weMgyVlWs/m+aesh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVxxPgACgkQVbJhu7ck
PpR1nxAAn3XCbnIrQgM/MrtTS3gilHDBY5/UFFUAYwQ29utPnfLvg7TPRFI32Tr9
gM6q8AdxwG+iW6gh09CEqo9xQITmO6cbGpjkpuQun20vvTXl0lQlS/VVP4WdW4N0
0xGVLtZPQaTdfbuWjLrGcW18ki2gvsb0XNNFpVQYXOusSxjaj4xBk/gGiptDYqmO
ek+I4a7WurQOaRW7PXofGu87OtPEVFuTVIKKp2D7IEsnn8PbMni03fmH3v/zPIZ6
Z7/4wglzlSIlknrqUfw34i2d0tzxqwxD/Y9GM1vZvP3XD8zMnAHzQhq0n3coUO0r
zNsucbZq8yH9KMIIeK2KtsU8y6RjZOEcKbeSLmoUExPF0oL8oyvrbDi2xnyKdQJ8
7Lfp3cr2N/l4g1jYSfiJC8lJuiiFol6J/76lMBnaZBjxicicGJAcoZpyi2p7/lWl
6pBFZytutcxD7SALXC9/ajES004MmtL6jQMKidD66nfIseG/2nheA7Umoe9CyaKh
Gx1gHncmI9kieTbsZr5am0IiqDDRvuVkRGwJizJMZudolv4JDvYO5Uo1/3lZB7Rr
w3SAQ8ZCMpfZLtKimU9pb1fuH+KXZR3UmaCdgrgwkFaDY/P9v17U2lmJnKSJxA3W
D1+Cm2RlF20cB5Ma/uZ23b1ye46tHD1AYZVinPsFdPH1W8Fm6Tg=
=gRr1
-----END PGP SIGNATURE-----

--weMgyVlWs/m+aesh--

Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042D0125C2
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 07:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mO6SSXLX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ukGl5HBy"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7637B10E6
	for <git@vger.kernel.org>; Sun, 12 Nov 2023 23:12:51 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 21DED32003CE;
	Mon, 13 Nov 2023 02:12:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 13 Nov 2023 02:12:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699859567; x=1699945967; bh=Fd
	Q+QbJkPCS9NJJoNs9tfJR7seEOaGksBYFdJeMh/oo=; b=mO6SSXLXuXs+lIpib1
	LNa6qK0KYPgiN6k3TLKYtzFx5RNZfCYIYkptsfg7XYkUdvbve5/dKiJU70qbwwAS
	CY4V75vPvqYQum5+tMglhXUNrHUWpmcOk5eWpZXHPPn3370bBeLSsZSuqUbr6ydj
	KSmgSUCvQ0DVoLyS+qApKIE5tmX90QapudhqgMLksa+aTzw8QJTev63eknXR/l2+
	z+fbtj+Cj7mVBeU7qurxPjVEfvhNilSpQIHQeMsFKa3PwVcKNqrxCvwl4XT83i4Q
	9+s3qGt3Lr/rmvSaPFRvNYXDG+cCtHf1LduQM7omKlUaiiGIRtPDG5JgCvfmX0UL
	3jgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699859567; x=1699945967; bh=FdQ+QbJkPCS9N
	JJoNs9tfJR7seEOaGksBYFdJeMh/oo=; b=ukGl5HByIhsPayAz92TSDqUDXgz3x
	2lzTWeO+Sf2kmhXENYijWrCddhDwZFgtewZNedkHw+OVEeXHQj5v5Hss8X5Rr7Bx
	L3RHqMsgUdSqgMFpZUqCEvuyhMj6Ce9yb0FVoUyomPticemD1xb2C1gtBQgtqaV7
	+LnzY1gwA3OlY1mIJx8edJcOdtTSWy2bRxmNnWqvYuvvPrrCQAjlQjjyrH/EK2JW
	f8Y6pEJLj6G4qXjpq9ZAxYiBhEX4rl+wF+wTNK2fbslHf3LX8kgxkGk8o45g+bch
	vcqwQXsE0V5Pa3DF3sgAS4VEhtUL+fPEjq/kCbZjNq0bEyKdss8dLA4ZQ==
X-ME-Sender: <xms:b8xRZWSM-XTnFBdM_S_jmQr7lV-jBHsfMYF19ybZXXZ_tmfOGvhnuw>
    <xme:b8xRZby6iG4xZrvBDi17t9Z5pnPYbHkja18nCz_Sbw5416mv-t_ISkO81-9rYzqer
    BNDqSl7_gcVZqA7FQ>
X-ME-Received: <xmr:b8xRZT3CrAxv8n4_37TBY2qUoo3346L9nvKCBRctZbNXN8FC5o8wgi98xuFcqYIE6CYvnGoJJCTpo9Gr1oEwbWEjvd4rrWNVVgZSBKQDdkwuuXn_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvledguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:b8xRZSDuMNe0MoEY0E1c-UdcFF0mzuT1kfkkEcusFPliBvvbiVtGlw>
    <xmx:b8xRZfjniRdNl6B4I50cB13S48toJ0l2QCbQWuAi1NzsMH6ev0Idvg>
    <xmx:b8xRZeowp1Ue_wo4KeG89_UdSANkyS0RjoSEYM5st8_TdPAGAKreOQ>
    <xmx:b8xRZXadK4djrfjrsKnp5VjU02EZx1nP7ma1xhT0_mossJCZGc8A9A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Nov 2023 02:12:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f994e9a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Nov 2023 07:12:08 +0000 (UTC)
Date: Mon, 13 Nov 2023 08:12:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/4] global: convert trivial usages of `test <expr>
 -a/-o <expr>`
Message-ID: <ZVHMaoHW_nxzWnRb@tanuki>
References: <cover.1699526999.git.ps@pks.im>
 <cover.1699609940.git.ps@pks.im>
 <2967c8ebb460934eb4aaaaebe5941bff643d4a94.1699609940.git.ps@pks.im>
 <20231110214423.GC2758295@coredump.intra.peff.net>
 <xmqq34xdtac3.fsf@gitster.g>
 <xmqqr0kxrvij.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Wq6IDQ+zE8nQubA/"
Content-Disposition: inline
In-Reply-To: <xmqqr0kxrvij.fsf@gitster.g>


--Wq6IDQ+zE8nQubA/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 09:20:04AM +0900, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > I am not so surprised that this one was missed, though.  I didn't
> > point this one out during my review of the previous round, either,
> > and not everybody is as careful as you are.
>=20
> Ah, sorry, thist came out in a way I did not mean to.
>=20
> I didn't mean "I did not point it out explicitly.  It is not
> surprising if a contributor who was not careful did not find it on
> their own and took initiative to fix it themselves".
>=20
> I meant "I failed to spot it myself hence I didn't point it out in
> my review---I was not being so careful to aim for thoroughly cover
> and find all the similar issues".
>=20
> In any case, I'll tweak it while queueing.  Thanks for noticing.

Thanks indeed, I missed this instance as well when I scanned for any
additional subshells.

Patrick

> diff --git i/t/valgrind/valgrind.sh w/t/valgrind/valgrind.sh
> index 9fbf90cee7..3c8ee19975 100755
> --- i/t/valgrind/valgrind.sh
> +++ w/t/valgrind/valgrind.sh
> @@ -23,7 +23,7 @@ memcheck)
>  	VALGRIND_MAJOR=3D$(expr "$VALGRIND_VERSION" : '[^0-9]*\([0-9]*\)')
>  	VALGRIND_MINOR=3D$(expr "$VALGRIND_VERSION" : '[^0-9]*[0-9]*\.\([0-9]*\=
)')
>  	test 3 -gt "$VALGRIND_MAJOR" ||
> -	( test 3 -eq "$VALGRIND_MAJOR" && test 4 -gt "$VALGRIND_MINOR" ) ||
> +	{ test 3 -eq "$VALGRIND_MAJOR" && test 4 -gt "$VALGRIND_MINOR"; } ||
>  	TOOL_OPTIONS=3D"$TOOL_OPTIONS --track-origins=3Dyes"
>  	;;
>  *)

--Wq6IDQ+zE8nQubA/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVRzGUACgkQVbJhu7ck
PpQNtQ/9Fhr49kB5WorEqynLRCW4RfxLThWQqL4f8TeO/BwAGhgp+A2zEQTitrJs
g543WuPmEOSuu/8wSPVogW4THiFUhgfGrvHyKIAyd2dsMurdYCQq4REVW630baHH
ZGs8lB11X9cbjZCnudZsXcf5XwhauSGvzeUW97SW2NT9aa6fVl19MOAQsb3viyRD
EfNvtRTmuinGybcEFebsQodBnSM5xH5NZlBTUN66qSBVyUWBjSEeE/i11VTHJTmA
cK+08NAX55CWOrd9tx7JHSDX1t+cfFTQadDVhkicAwT32iTXnOrwCvgfNHOTTiWQ
IdbGSkFJNvdxv4+HPRYpEUWZbIqwKgGJKH8TcgA/Ws4V6EQvUKCaCEcFKAB8gMnS
UyEylXQ6hrWZqifZ82x2fB1g26Gz/E/Uq0FTFhloQZ0x4WRVenby77MpA71b3Hcw
bFmzieIG+54ifzlNX41aD4CkDrkc12nOuPEsBjFdB3+3JACSOw4qvD5d8igaZbOt
A4UUrNVQv1rg2oblJGRyR9N3xbyDWOZ8GMRnAkFpYt5h5+XfpHifCd3Bx5L+5uZ4
JCTdRxI2LwduyXcmG8d8vGtMGRH5wSXhE6h8XWTaGH4EjBIbEshsUgVthAei1fRq
E7Lx44Jh/fX19er1u0i5bK7dezqSKDWdmB31smlgtKgfG9DLSRc=
=MHFb
-----END PGP SIGNATURE-----

--Wq6IDQ+zE8nQubA/--

Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ttf+WE/x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kwBwysOp"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BBFEB
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 01:08:47 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id E4C8D32027C1;
	Mon, 11 Dec 2023 04:08:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 11 Dec 2023 04:08:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702285726; x=1702372126; bh=rG
	0gkQghOoRDwZCKK51fyPwtONRX7ZURkjNrDhdXVoA=; b=Ttf+WE/xOL9XFzC3Jq
	JC5kRjR4qwLYOn3CQvl1atRpd9BxKeKZNL6n8ajTRf+OpaFyRo0KbM+70XZ/IM9M
	kcH7ebe++0Bsw3ixQ9IICwQ0X8gtFdN27a4KcFgJEKM6TWVV9fJaJk/AVYJEf3cN
	MM3qT2oooIkupYJ5qk+vcojmLWeKfD6jzFXcJIudK/gUHEamYl8Q9tdQUzb3AYEH
	ddd5FPPUpdtiGPFEBvHfncXQjYCUhVsWfrZyUYN+8h1790eeT3qAZQaaCYXIlxEn
	LaMKEETljBeVRxlwbGsGYMK3rqx7ZhgYAEO0+4mekp+hRBU8qq+8jB7dZ47/WECd
	XKDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702285726; x=1702372126; bh=rG0gkQghOoRDw
	ZCKK51fyPwtONRX7ZURkjNrDhdXVoA=; b=kwBwysOp2fdKuNYfHm43AH5JH6sdR
	3u8kI93XPg9jG44JYOCWqonS6yTYBnV6xkzm64ZKeeEEIZbVCL/I+y7qpg8jRoef
	w3qRr2M2LhwZJ7gbJXsJwLDndBO5rU6WNB2cKOHvyvwCRPa0cp+hnE1kD0iktmZg
	IxTSDnifn5trCnk2bQhsn60muwP1c1SV1US9FqXhgbQnbWNGJTnVgKWuFWj1p232
	r5+4cHPC2P3ONBD1kvJ5r1AfGFbu/jgJxln+ocgDshMvs8VfdaocZUVqxuospHDp
	sih2WgFF4BNiJtgtmaj66aRhISYfEFpASwgGu1VQfHm9t3qo33X46Xlqg==
X-ME-Sender: <xms:ntF2ZdBAQlexKcbu708HTuCOQjwDvkuLqG8PpPem6td1NDzjxsQiyQ>
    <xme:ntF2ZbiUJhWdWqtgYfJgfUVsV2Ca5WWOJ_081o1mIwe0mWyYt5wj-VMSxdX1_tzPT
    AZkU7-H3L1o1NX5MQ>
X-ME-Received: <xmr:ntF2ZYn6CkwE8hgn3PZOvZ5yAYisLPaywlDmRhJf9X4iS2W8bUVU5ZPX5CJkWlhgWdt4kBZicJiKFRz8JvZ18KHy8EugzieAx5MsRNd3egfL0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelvddgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:ntF2ZXwu80aqaYSdW4XxKFFrfpvt8X3krgSyHxvW3RjV8wKVvDwcsw>
    <xmx:ntF2ZST34U_eot52Rl200F2ej5Gyjzwv6GJA3u_aGssxhW4G1-53NQ>
    <xmx:ntF2ZaYuV5X5sMPOw4k3_nl-QBL0DAGr_l2fDpdhQzVcfkSoT7Eo4g>
    <xmx:ntF2ZddEn3VpisleXmvr6Chm7FTLgB94lH3Xc_ueQczOeKIHIL6H3Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 04:08:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 11e5ae29 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Dec 2023 09:07:09 +0000 (UTC)
Date: Mon, 11 Dec 2023 10:08:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 06/11] reftable/stack: reuse buffers when reloading
 stack
Message-ID: <ZXbRmwj1vZ2dA3s9@tanuki>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702047081.git.ps@pks.im>
 <f797feff8dec383f1db9ae403cd89b80d1743432.1702047081.git.ps@pks.im>
 <ZXOV8TCqaH0xXRnS@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OHLMzcqO4M/ZF0Nl"
Content-Disposition: inline
In-Reply-To: <ZXOV8TCqaH0xXRnS@nand.local>


--OHLMzcqO4M/ZF0Nl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 05:17:21PM -0500, Taylor Blau wrote:
> On Fri, Dec 08, 2023 at 03:53:18PM +0100, Patrick Steinhardt wrote:
> > In `reftable_stack_reload_once()` we iterate over all the tables added
> > to the stack in order to figure out whether any of the tables needs to
> > be reloaded. We use a set of buffers in this context to compute the
> > paths of these tables, but discard those buffers on every iteration.
> > This is quite wasteful given that we do not need to transfer ownership
> > of the allocated buffer outside of the loop.
> >
> > Refactor the code to instead reuse the buffers to reduce the number of
> > allocations we need to do.
>=20
> > @@ -267,16 +265,13 @@ static int reftable_stack_reload_once(struct reft=
able_stack *st, char **names,
> >  	for (i =3D 0; i < cur_len; i++) {
> >  		if (cur[i]) {
> >  			const char *name =3D reader_name(cur[i]);
> > -			struct strbuf filename =3D STRBUF_INIT;
> > -			stack_filename(&filename, st, name);
> > +			stack_filename(&table_path, st, name);
>=20
> This initially caught me by surprise, but on closer inspection I agree
> that this is OK, since stack_filename() calls strbuf_reset() before
> adjusting the buffer contents.
>=20
> (As a side-note, I do find the side-effect of stack_filename() to be a
> little surprising, but that's not the fault of this series and not worth
> changing here.)

Agreed, I also found this to be a bit confusing at first. I'll amend the
commit message with "Note that we do not have to manually reset the
buffer because `stack_filename()` does this for us already." to help
future readers.

Patrick

--OHLMzcqO4M/ZF0Nl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV20ZoACgkQVbJhu7ck
PpQljRAAoZkb6r+mlid5G0KshBoPSTDQzXvssuK+reFRjdDxfrlYI/YF44WeOPG8
4uJvxMMFwyar1PTaYj28YWnpVo5tlkSD8lmJzmhujnGUmrPn3DM0XhxvtTR3V512
EnNXjdEYzBQ4f33sucYq7Wv96d7wvLz1qKobNumk259shtEVPdjAiA31qPyvo83R
yZjNPcmDYUjGl4XUFCz+Z4rKjremXqV9ujjHRIUdGKfYWd7tDKKvINJzYt98diBV
c5tZi7GmcSACq141QjpAQ5tsno0qrbAZoZzYmJX+WTmZ8KwQAZMR1fgXTiWIAlFW
Oa82dt6Qw8F0Sn/uDHRRhve0UYrJNgBKAYxRNIlbip6Ma1a+uVkXv6vFP7GS6YPE
oYTAYMzDs94AH3qv2+7l9tn5xanTE8EYYbnnAvc2LaNfDRo+g8XtqFbcdjTmdtYJ
TfFamTFtEqT/BNp2MUEHbmf1baGPJSSlfwCJhgz7EfC22G/WjpuDPxDAe3J+XIy1
EwRUg2xabl0LukQ6wXmmbkykshbp5kYOEWU3zjF5XnyzGIFJ1wTU2xRWpZicunLM
rBbfX08E0J4stPRxuB/3nq88ySZTBvECyCSEGZqN0wID+l/ibx4IG6sdK+soBaAX
c7LdIaJC4afnTbxt725stdpE5pkK/qrMvpcY1iCgI03KrBKaQmc=
=mba/
-----END PGP SIGNATURE-----

--OHLMzcqO4M/ZF0Nl--

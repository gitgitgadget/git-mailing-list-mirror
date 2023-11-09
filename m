Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AAE2582
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 07:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i3+tT3Hx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aSq0HfOJ"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCE3186
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 23:02:18 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 3037E5C0359;
	Thu,  9 Nov 2023 02:02:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 09 Nov 2023 02:02:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699513338; x=1699599738; bh=Lg
	/OceOki1QQMNHfpWuskhadK71VO3olt8HcPJtA/g0=; b=i3+tT3HxKO/qTToe/S
	ccjORcOszbGZa9JSyT8gA7dvBDtzqV6TlaL2blc5R0LyHkPH0T2zYGMUnJ5Vgz1Q
	zaOgVvGyw2cP4xpbCJrr79rPZUa86ziMrzZS5g4v8DTVYnK8wQwR3Q9bxVb4HnQ0
	wcJUSWBfYvxNSn/f21t8npzEQsEAmSzOEnbh/uXSNp9WaUl0BQuLlrqZOvqQHRCC
	mEnAotzCfAUHACBSaP94ewgr2K/xFoSWfjtN2gPY8M8I8sOnQutHRD6VrBvOvT1D
	J2DcNpW94D8NF85b9Ef0U/XaIAxN7zaAJaKpJs15hKtmG8vGnKJBQNRgrW75LY66
	jRSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699513338; x=1699599738; bh=Lg/OceOki1QQM
	NHfpWuskhadK71VO3olt8HcPJtA/g0=; b=aSq0HfOJJIEeafXZ69UFdg2BiZBv1
	9IXIv+BLM+JSQdtRfLSAa02PDa7wnL0vxRYdYVYtU3sNlctsby8WM+WCMS4FSCmi
	NP66oiFjSQu8N4YNeA5lWOX+G3jNPMSmtXDDBYFExz/R47ekdmUtyKBC9vjiYyy8
	HfCl5Z3hsP5XWG0pvsfhdfQxTmtYvLRdgYdUcxYevoOnBAfBjoaDiP86YH/i9Y7t
	7pTMqIk+D8i0vHPCHxqiSBYeKuXAvPywYuFGisTSXTBYDBenYn+/QDmeMuy+rGAl
	EvjPtHMZ9Rg7pE0R3C/vWJpltjKJJEw9J6AEAxrJzENQnxtJFUz7g37uw==
X-ME-Sender: <xms:-YNMZZJSTdFbDmLvikWwXBXHBGQR7NAQ2orawlE208QtHB8-pw1V2Q>
    <xme:-YNMZVJwqZiML81Wjf982pWsEcqS9XVshuFV1GfQkJsAUYTqMATnM9AEkTQQFHI_E
    RngIFDIlt4IuFQLTw>
X-ME-Received: <xmr:-YNMZRvXBtpeztic2DA9eMUSlmFx0NpyJTZgCixQ79jTQkYpQKIe-3I204epQfpiyO28VBqCAakPGtymdFXWDG4zB_3VfCUKnxsv7xb9iTJnFT0T>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvtddguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepteeuvefhhfdufedvgeeiueeileegtd
    fhgeeftdeuveejjedtgfejhedujeeutddunecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:-oNMZaZE8_UVmWK9AZwFjiDRuk0t7LsQ4U0napZm3RiTnXU1jDO42A>
    <xmx:-oNMZQYjjcEfTwuCmKRUzxhWxJ6h8MH4M_2YwuylEmJp2VacH3zKSQ>
    <xmx:-oNMZeDp_TSfT9c6qJyN96j1FuUoH1afOoRuv-rZvywe6VgJMarE0A>
    <xmx:-oNMZbz-U-1Fx6YTCZkI6cVEVEWYCz7Ee6j5qzf23B1FzJc6q3PABQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Nov 2023 02:02:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2f8fdb0b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Nov 2023 07:01:48 +0000 (UTC)
Date: Thu, 9 Nov 2023 08:02:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] t9164: fix inability to find basename(1) in hooks
Message-ID: <ZUyD9Z9tsq9O2IkU@tanuki>
References: <cover.1699428122.git.ps@pks.im>
 <cover.1699455383.git.ps@pks.im>
 <361f1bd9c88e3e6b7b135ba67b39d3bf4d70e322.1699455383.git.ps@pks.im>
 <20231108172125.GD1028115@coredump.intra.peff.net>
 <xmqqwmus3zvd.fsf@gitster.g>
 <ZUx8adNt3Ky-U09W@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FC0MrNSXWMV3cD4y"
Content-Disposition: inline
In-Reply-To: <ZUx8adNt3Ky-U09W@tanuki>


--FC0MrNSXWMV3cD4y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 09, 2023 at 07:30:01AM +0100, Patrick Steinhardt wrote:
> On Thu, Nov 09, 2023 at 02:43:02AM +0900, Junio C Hamano wrote:
> > Jeff King <peff@peff.net> writes:
[snip]
> > By default, Subversion executes hook scripts with an empty
> > environment=E2=80=94that is, no environment variables are set at all, n=
ot even
> > $PATH (or %PATH%, under Windows). Because of this, many administrators
> > are baffled when their hook program runs fine by hand, but doesn't
> > work when invoked by Subversion. Administrators have historically
> > worked around this problem by manually setting all the environment
> > variables their hook scripts need in the scripts themselves.
>=20
> So it's not an issue of the environment, but rather an implementation
> detail of how Subversion hooks work. It's surprising that this does not
> fail on other platforms -- maybe the shell has a default PATH there that
> allow us to locate basename(1)? I dunno.

Yup, that's in fact it. Bash falls back to a default PATH that can be
queried via getconf(1p), and this works alright on most platforms. Not
on NixOS though.

Patrick

--FC0MrNSXWMV3cD4y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVMg/QACgkQVbJhu7ck
PpQ8+g/+M8+VlrfD2rCFscAm0nmB1yGjhIxvTORu2G7Ru9tCjz0N8Ab7on+Jwp3P
chEWUtKGqEJRX+iBdNQtmwqDbfC+klklwOMTU7+vBJDDM8zhqssBNkyfeJAOns5N
E0NCk0nG4gta62seuBp9U1hfxd7TEdZG57OMUaAKB4UdheRSUYpMvNQE2s98lQeH
gdOB5CDPF6CHxoM4dPegiVJmxJRbVZGsKONez35IHuDJf+DRkkmKw5kwEdU5pN2S
QC25x7ZEOs13499EqZGdadpjFQtLwSkaQxuJ4FtbdvrMf+paDD4oAyYd4WolINkB
u3HOPxHwMnB+517q3VS4fEyCRyhTY8k/52yiIdFCp/SW14dJ7FbE+wv/ynGU1ASB
BXyqoEVfXKSQcsWtSWHLFclQSdVKGZgOTEznFchjqCxHtfnAM0rVlxTrIAplc/Da
wiadx5RnquXsvKdNrwImG/uNBb0utmjMLQw0JX2+Bzq9/ErKDT8EXpUQnTFU/jGm
v8nbZk8XhJrstPzV8iGWQBDP2uQ3lqTHb55ko9qWogA7IEyZavKoq797C4IxuQTe
le5f1iGGHvsgXih6/Z7SzwuvCxWt1zem7HiMnX/cn1DQrHK/ZJDau/HO86cNR2E1
OZGmdavt+5gmUzdfrFibw/Za5i1WLvL+TzAoR+HuvgdaD2X3rlM=
=fTTX
-----END PGP SIGNATURE-----

--FC0MrNSXWMV3cD4y--

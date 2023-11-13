Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58711401F
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 07:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gs8RgMih";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UhJXGP/A"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65EE10E6
	for <git@vger.kernel.org>; Sun, 12 Nov 2023 23:15:11 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id E565A3200034;
	Mon, 13 Nov 2023 02:15:10 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 13 Nov 2023 02:15:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699859710; x=1699946110; bh=bB
	F/iOjmSfjSugeA5hr8/z0zEgb3nMO8/Ly/n4leCDA=; b=gs8RgMihcidhr04x6Y
	9qoO3QSw/ZlQlnKvz1Qm+lXKvB4eqxqDVLI3WC1qQBP36+pSjmOeBum0gIS5ecTZ
	6FJGy80TNgaiXtQFkoBMf9DLU4DOu7rVw0eSgZ2cMCICirKcseh7UsIMnykCKYOM
	FQ3pUdcl+OmEmnLOBfVbsoKISNKH++NkmR3dVhAdxgjrhAXFuCoiJjQnMxryQVjp
	xz+0QgCehW38vUBpONO0VCfhbMs2mK19PLCvCf3AJFjuUFISXV9oIr5tzxC/kBO0
	iWzHQUe0r4FMjXsiMo/mQtbLORhNUDt3zG4s7821rDPyQHsnh1+BSIFSYacHq8bd
	NWHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699859710; x=1699946110; bh=bBF/iOjmSfjSu
	geA5hr8/z0zEgb3nMO8/Ly/n4leCDA=; b=UhJXGP/AQ75YM1NUuFeW1ejM/Zim3
	Qq7BdxT7fGB0QODGyckrDtDkAGEW/i/Cbv0dWZyXZ0Ud4/kbzuoTbQTimhmgR94o
	24Vv51Y38LbLVvkRcfP4a17EnCgaIKE2f3RsF5uCvQJ++lym8YfrNULIOq2N1A2Y
	lncJkRQ468zQS4UC6fC/r4MzP/94RrjoeKK1sfUNaSADsk+XKyraJ8E/PvAV1E/y
	eyXrKhLvw9WJoAIYzne5VHNrmBlG6sDuC9+bHFzY1sHq76hBxOY8wp84GMof6O/T
	0otsgcbhIxvdRKt31aupURpn78I6Uhtk/C3lyP1FgU7NAv2EQ9nlIkE5g==
X-ME-Sender: <xms:_sxRZU0TH4bnlMDfqM4kkmrQ2FR4ymOOw0-RMLp5SnJxoV9AVJAKsw>
    <xme:_sxRZfGBhN8y791UMeWkDNYZisKIwQYx_IAgGo3O3Jaj9jihcQLO0QL6naslXEbk9
    YRY9GKwTiz7m-8YiQ>
X-ME-Received: <xmr:_sxRZc4xtvcH0II8DiQddXEpYS_WTNHEDpDlMMJIgSczOTfhyQmAci90Xkl7cWTBcMIK0SsupC_kU-oNWaOD-jG-fRVu7DZQZDG8E4Sm0baSewWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvledguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:_sxRZd20Hfw_LO21oGpgEgBtm2ak6t6bDEXMT_7S-njC1a4ImHh0kA>
    <xmx:_sxRZXFUJKdYBuxhZTNJ8jwwyfIeJ3p1EmiKB-FWtNFeRwL_AbFssg>
    <xmx:_sxRZW8WaCUbACZtEEGMj9YYnWcx5BIday3koJvWMW0BF3Y3mTKMwg>
    <xmx:_sxRZdOecXUWHDvg_lFA-vEcSVmT0qR-ll294h5vu0zZQRVJWSQSMA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Nov 2023 02:15:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 33bcc6e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Nov 2023 07:14:33 +0000 (UTC)
Date: Mon, 13 Nov 2023 08:15:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 0/3] t: improve compatibility with NixOS
Message-ID: <ZVHM-0d7g45P3Uoj@tanuki>
References: <cover.1699428122.git.ps@pks.im>
 <cover.1699596457.git.ps@pks.im>
 <xmqqh6lttaj4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gj+s+FOMXjDPXcC+"
Content-Disposition: inline
In-Reply-To: <xmqqh6lttaj4.fsf@gitster.g>


--gj+s+FOMXjDPXcC+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 09:10:23AM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Three changes compared to v3:
> >
> >     - Switched from `test <expr> -a <expr>` to `test <expr> && test
> >       <expr>`.
> >
> >     - Improved the commit message to explain why the new
> >       runtime-detected paths are only used as a fallback.
> >
> >     - Rebased on top of 0e3b67e2aa (ci: add support for GitLab CI,
> >       2023-11-09), which has been merged to `next` and caused conflicts.
>=20
> Please, no.  "The other topic has been merged to 'next'" is *not* a
> good reason to do this.  Before that, the other topic was in 'seen'
> and causing conflicts already, so getting into 'next' did not create
> any new reason for rebasing.
>=20
> I'll manage this time, but please do not do such a rebase unless you
> are asked to do so.  The rebase will force me to do (1) detach from
> 'next' and apply these, (2) discard the result and detach from the
> base of where the previous iteration is queued, (3) apply the new
> iteration with "am -3" to undo the rebase, before I can compare the
> new iteration with the old iteration.

Fair enough. I assumed that it would ease your workload instead of
creating more work for you. But I'll keep in mind that it doesn't and
refrain from doing this in the future.

> > Technically speaking this series also depends on 0763c3a2c4 (http:
> > update curl http/2 info matching for curl 8.3.0, 2023-09-15), without
> > which the tests will fail on NixOS machines with a recent libcurl.
>=20
> Thanks for that note.  This topic has been queued on top of
> v2.43.0-rc1 which has 0763c3a2c4, so we'd be safe.
>=20
> Will queue.

Thanks.

Patrick

--gj+s+FOMXjDPXcC+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVRzPoACgkQVbJhu7ck
PpTITg/+J/o52BS/QPH2IQMTCmgAr9IauNbDIr0axjHhR5mlrgXSEVhFz711P67b
+gWuTrswo2IL5e29Nghljr9Jf7PxWQROSvhHy4DWwATlhR7TPNwwMYRKBkM6TakH
K208ex1vgSan9j96hczAyvl1YUv4O8mONtQFuRT6ttkUZGeg08rzJk7zAFosf/ne
j7w4n6si5vOkUmpQQOeagDmL40EkplUsdbb11G4SpWC9K+VhN42rJZIcb3hVrZS1
qrLmQe3fjS7EHUPk8Xh4YWfquBJTkpg6l8KHAuykZTYN31EiBQ1X7uYbITwO6EGu
BesphdsV2MFLpJhUr3TebWcY5aWrW1w5MhvLH/+cCDyw3iEzvb2aDBoO71SLTZij
tAbTbxauo0GbnVmPRC1GWend5RRMRPD/cG+JElC1jh4G71/Af/lOPW/EgEMyaNBi
nbN/lSwDlMHpMvahVkySlgx3qfEAVgzF7qnBfP7txajBhW6XbRPsAAKq78ho+mI0
HNp5rUC01PIQn2NAAOYJWmqCTFa/qLZo9PSU4HcIJEuQDzstVR/fnX0LusRR6T7W
doX24l36x8LpVs70ZCIa3oldjgwF+GZt76FALBDo3JDkjAqShDZsAh3HUm939YBm
2mWltUu8mh2VJU8K7dA+K06W8QUhuRiUxedudQytqAa98c/baWE=
=on7a
-----END PGP SIGNATURE-----

--gj+s+FOMXjDPXcC+--

Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BE1179A4
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 05:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vbVfj4X1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BQFW9YTg"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 354BB3200A9C;
	Wed,  3 Jan 2024 00:53:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 03 Jan 2024 00:53:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704261231; x=1704347631; bh=dxGDAnz3xE
	KVmET7WnUuKHrevsTsEdEUEbU0C9p/XIE=; b=vbVfj4X1bRjUTPHf4yobV0zmue
	OLrFxPp4Vyzue063NgDqz/yO1dAi4Ex1vlgKhA8J+w7rD7LeKrxBdEpxG/GBrHyi
	DWm4fCH1+CR9/L864lDVVeezh9smkXSqBVj8uZfPiEXKzFePYIxBO5BaNDNVc8Yy
	qsk4E6yoWw750nQLu7hxD/zvRzlEAv2et42S3cpByo6vLmzPeoWaMcN/D3Nu1O0R
	+1yJEoQ4s5t0dXNlwZbKOg3ZzKLDk/W1sCzEUmMULOrBsmPSz4Kg31I1sK2Bg5ha
	XFBYH82XS/Szq9Cpsd4w7PhvWw+0EKTWK7yPD5Jj1nJx16dtYq2PnMzI0Zpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704261231; x=1704347631; bh=dxGDAnz3xEKVmET7WnUuKHrevsTs
	EdEUEbU0C9p/XIE=; b=BQFW9YTg91fH4LE97TzFCuBB9blbQRyVYX4M5S10r1sk
	1dk6ihMuSBk2DQvYBwXxhfHYJIa9d2qdfJ8T1VvP9/Gwvcs5pxst8uS99IkmL3iq
	2pDB08jGAjr9CXu3qu0HF7xaECPQrMQEvQqM8TMeg+nB4RagiVT0DTzjUvT+6HCF
	pMvL60RWoHac6AJEKCv9IQEGyOTLUhIc48865j4U6USGkobY3/3ljkTfHn+9t5jx
	jRIZjFfVMmgewBLpRkVyDInXwyiQxLGjs57RiqMujEIBL5jANz4c7rg9EI8AiXS9
	pN7DJo7iGgDCgNLe6085ANDWJemma25fLN+CxcPkwA==
X-ME-Sender: <xms:b_aUZeWvcSms7oiUoHCAOOsWChUhv2wCVlyx_EZ4DrCOFB1xBog_aw>
    <xme:b_aUZam-gc5nA22iwmBOhR6IyKNwNa-VPAAj-7dK0kAbpW_kZB-zga8ATGLlz9ApC
    pd8KoltKvslIkrudA>
X-ME-Received: <xmr:b_aUZSZctsc0z_d0PUp438lu6OCw4N7crA9bK_tcAQn9dB15Fv6sQnYuCGAbPaxMrMePJ8WKXziNH23i-QkeBIKKmJQ8r2ub2FvX-KrpZKmkNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeggedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpedtieetveevudekkeehieeuvedtiefggf
    ethfekleegvedtjeeuleelffetueeiueenucffohhmrghinhepphhkshdrihhmnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himh
X-ME-Proxy: <xmx:b_aUZVXMWgtqql7J8Ht5FiOFOlpoyIzXppgvYmXL_bnf_xSMKF_CpQ>
    <xmx:b_aUZYki3bkAMrEbAgskUMcp6pCiNcv8QUK9yfBBGgVvxrsn_RUuIQ>
    <xmx:b_aUZadmYfWXsXAy5XLCiFhn_5XA9FiFkKrfWZb-oJGHBowiHAt67A>
    <xmx:b_aUZfuXiBXESmZQ2E28U6rABHJp-VsVMwjtbLjR1n4L65fYdgmsZA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jan 2024 00:53:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b56ebd27 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jan 2024 05:51:23 +0000 (UTC)
Date: Wed, 3 Jan 2024 06:53:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: ps/refstorage-extension (was: What's cooking in git.git (Jan
 2024, #01; Tue, 2))
Message-ID: <ZZT2WoJDg-Z-_N5P@tanuki>
References: <xmqq5y0bcjpw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WqjiBQ+xZg2bjcRU"
Content-Disposition: inline
In-Reply-To: <xmqq5y0bcjpw.fsf@gitster.g>


--WqjiBQ+xZg2bjcRU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 02, 2024 at 05:02:35PM -0800, Junio C Hamano wrote:
[snip]
> * ps/refstorage-extension (2024-01-02) 13 commits
>  - t9500: write "extensions.refstorage" into config
>  - builtin/clone: introduce `--ref-format=3D` value flag
>  - builtin/init: introduce `--ref-format=3D` value flag
>  - builtin/rev-parse: introduce `--show-ref-format` flag
>  - t: introduce GIT_TEST_DEFAULT_REF_FORMAT envvar
>  - setup: introduce GIT_DEFAULT_REF_FORMAT envvar
>  - setup: introduce "extensions.refStorage" extension
>  - setup: set repository's formats on init
>  - setup: start tracking ref storage format
>  - refs: refactor logic to look up storage backends
>  - worktree: skip reading HEAD when repairing worktrees
>  - t: introduce DEFAULT_REPO_FORMAT prereq
>  - Merge branch 'ps/clone-into-reftable-repository' into ps/refstorage-ex=
tension
>=20
>  Introduce a new extension "refstorage" so that we can mark a
>  repository that uses a non-default ref backend, like reftable.
>=20
>  Will merge to 'next'?
>  source: <cover.1703833818.git.ps@pks.im>

It's ready from my point of view, but I'm happy to wait a few days for
people to come back from holidays.

Thanks!

Patrick

--WqjiBQ+xZg2bjcRU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWU9moACgkQVbJhu7ck
PpQSqQ/7BfTmTD5rosvQPNbha2aO0Txoe0PAJE9PBpcbCy+DpFojZz0qDpUz+fBJ
7qdWX/MdVEt54SLfSq9FT4MEOstSLHavMsqMdQ6XLFDqS+YYJeY2ldB1LbnhO7cW
XGKDJOF3JatJymzhB+1yqNaG2pW6byb2y+2k4/QWsTUl2DIbWFa+LlO+jBZHMgDq
WzIi4xtAfBVDxPAnB/AV4PrptklReVOfy7hHQZqahyO1DTWE7EqDVwLh5hT4jPEO
fgOmduFQlnW/72ZYWDdFTClWQBjlqj7xpDXeOzmKhq3Cq5AGTjRwj5B5+nttXjQx
tsrjub4U1+L/Ps4H3FLfMw1RX9j/NmyVqVwInhBIUZpWA5z18+y3kLCbuk+C2hEY
neR6/5ATq0QSQNBFaT29zQFtw3mPD8D2/rgXJOgIzqaSZYJDFTPUt4TNrDiXXR29
PxYMO6CSBvkg0JKo5qaTwnS52H6dN+DjY/jl+IxK9hTSrrpXojdthCh02eOaMTpl
6+yjf8Q5CfMQOZzN+GIh8IX3x4gb+B0GSYjbwcArh6XUoptA5C51cAfQ29+/6lRU
ZfiS1wc8HVlGeh/idCfXpGtUCgNmwkhcGse/aO5jZLF2aqR1xJjsWo+Cxeq4wj3r
h8o5/FgpQj1yHK5X2j6q0IQQpB8kgKugDP6YdicGzuPYMBhjCMU=
=Mez0
-----END PGP SIGNATURE-----

--WqjiBQ+xZg2bjcRU--

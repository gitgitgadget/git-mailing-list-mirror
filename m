Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6626FAD
	for <git@vger.kernel.org>; Tue, 19 Dec 2023 05:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W9inFoyH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vgduG+d7"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 609F35C012D;
	Tue, 19 Dec 2023 00:41:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 19 Dec 2023 00:41:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1702964482; x=1703050882; bh=BJxt753mYb
	4pmC6FWipEwYWxHqqAaWF8ra3PVQfcnWI=; b=W9inFoyHArtz38Lk+KD6eugo8t
	dOI3j0v9xuIIOw5/zE2dzTwzLbfe/jUY3wqR0PMkZF+n8MhpLH1PPUtQkcjBpluY
	QGTqnJUyoHSaeNmP4GcxWuj/nqAgaTMFLQ6fCHZ1R/uEQ8dhz4nbOePBEExsPAGu
	ZWWUWnm49pMIRC/IKNEY+wtLUOGsWYYF/NSEP08JzPCjj7/QB69iZ4+S+szadvgz
	kjdL7g0lDmD8aG2LNAk82MjNxzni5Hx7+Gls9C6+CCvsOMSN98I3/wDP/Mf4NMYH
	DIBBowfSpH1cPVBoaqKoRtzqXCS7dyOl8szkt9bdJu78Lpsjftd66PZZqAFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1702964482; x=1703050882; bh=BJxt753mYb4pmC6FWipEwYWxHqqA
	aWF8ra3PVQfcnWI=; b=vgduG+d72ZnltkxaGmh02eTi247G4SRX0SPEbFJaYqhl
	847dxpR8Gdhm/NiP7jVTiZkgf67k7s6rxb1kJUXoflp6nQiotVw434u39I8OKU2I
	twIaxuXRCPZn5KZdWNhaY2JtteRurEwQy4tYVlHDuafa3rC9tHuB8S7ZU4VQhBnZ
	4e0mtmaNXD4MzTb200l4XwSmSdiYMpzeaITE/j7y84jFddlD71j8bpNL6icsdCbM
	Eux7AZhm2iCQ7uMiQ5XIYGg1iCH5xsOQa+KEG60sXYVxGgfQyvKpwXRq7MAqiYNf
	06KAKFbLZpHR2x0OsTWw5Xn1wfdlK7UoxmqOw/QIgg==
X-ME-Sender: <xms:Ai2BZZgNRJQXj-82pCepshdJnmgGnuawjc2G7EeqQeUwWoMP9xj8Pg>
    <xme:Ai2BZeB1RuVlPr2N5akSVy3qyd64hfzjTGGxOys5ObuKX7R0ld8Hy2JwR2rIZ8Oic
    -ONkUu9R4zxIXxD8A>
X-ME-Received: <xmr:Ai2BZZHIx85I60m08RvRxCHisK8-weZ8PtXndBwy_6yBP9CBYA4qoe2X2QPd7BHGTDhL8YzuR7vectP7NVFj-0CUDbcLGr39HpVDzrESUigx8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtledgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpedtieetveevudekkeehieeuvedtiefggf
    ethfekleegvedtjeeuleelffetueeiueenucffohhmrghinhepphhkshdrihhmnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himh
X-ME-Proxy: <xmx:Ai2BZeQX0nHKcXgpxbOs015EiUrIroYW_IPZQg2sltxl6hICXaRiIg>
    <xmx:Ai2BZWzIXjLsKma9PBefqovooOpMUnxeBElAg_z9wrjkHFWLqe04rQ>
    <xmx:Ai2BZU764oZXWACBotoXSWRKnYydpFU3ERpUqKC_HeXlcZsLugTQ2A>
    <xmx:Ai2BZcYGlfEkWxxMuy6IMUUEeJN1kgq6GMqZRYDchXmrU-phqrKzgg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Dec 2023 00:41:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e9c5d211 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 Dec 2023 05:39:26 +0000 (UTC)
Date: Tue, 19 Dec 2023 06:41:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: ps/clone-into-reftable-repository, was: What's cooking in
 git.git (Dec 2023, #03; Mon, 18)
Message-ID: <ZYEs_brEzRTXJZM9@tanuki>
References: <xmqqr0jjc86e.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="irgFbdhCCUxewdw/"
Content-Disposition: inline
In-Reply-To: <xmqqr0jjc86e.fsf@gitster.g>


--irgFbdhCCUxewdw/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 05:06:33PM -0800, Junio C Hamano wrote:
> * ps/clone-into-reftable-repository (2023-12-12) 7 commits
>  - builtin/clone: create the refdb with the correct object format
>  - builtin/clone: skip reading HEAD when retrieving remote
>  - builtin/clone: set up sparse checkout later
>  - builtin/clone: fix bundle URIs with mismatching object formats
>  - remote-curl: rediscover repository when fetching refs
>  - setup: allow skipping creation of the refdb
>  - setup: extract function to create the refdb
>=20
>  "git clone" has been prepared to allow cloning a repository with
>  non-default hash function into a repository that uses the reftable
>  backend.
>=20
>  Will merge to 'next'?
>  source: <cover.1702361370.git.ps@pks.im>

I personally consider the series to be ready for 'next'. There are no
outstanding review comments that need to be addressed, and reviews of v1
were favorable. I don't think we need to wait for additional reviews on
v2 of the series given that it really only improved commit messages and
adapted a test.

In case you feel uncomfortable with the lack of more reviews I can try
to get some additional eyes onto this patch series though.

Patrick

--irgFbdhCCUxewdw/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWBLPgACgkQVbJhu7ck
PpRN2Q//Yf5V2UOn8xUqr/rIuBSKIWysRUUP6JGT45py0tekJ3QQ4aRJhHUozxKt
YO6HBXgAUKMapbVa93eUh4Uszi0+/dEV9LTENDcbORzdbNIqtY78n2cV2xJNH8NL
CSaWdxG8icyuK+CxT+aLZtPPkEebVft3Ur1eyPkaTf3Ikk9e3tcR0cmay1SbBGrx
WlHyQ/NQgANZEPnATJkX0DXjOCTi/KgkRD11wALZl2zqOKgAe9RzpI8202+aUxEn
4nmPf4+H0MyzXwwKzdXVBgi0Ob3Aku+oLVA2Nh1ui7X2eBtSv4iEP04fek4abG7F
GYrTXI4FaWDGif5oZ8jLas19joMTxq+C5t1x+c4NGmA9c0Xvf311u0gSIFWOTiAL
lOQV4gy4EcPyesbvg7Y07zH+WjjeIaf6WfR7aLJOro2gi3+7qdE+mmetbNFHgxSC
IxILXqE/BwMPg0s765oij8QYxq2J1gIRe4zK2Vdp2h6xKjvFoTMK/Fu8rDmpXPPt
t7PU1hLKYrco+946vkRviX34fXCRoOWgGBC8cPEF1s0wJbZ6weCwOjR6wTyldJkw
7xSIS0NCzPSTiHB/4xW2UDiYObd5YNc1gRxDGHCUid+Mhs6AFE4ztsKjgrh/XeYd
EF+YQyahYQLftYt50wqiai8kMpOWRMpdg61XhmJtfXoWpA1zi+A=
=AgWV
-----END PGP SIGNATURE-----

--irgFbdhCCUxewdw/--

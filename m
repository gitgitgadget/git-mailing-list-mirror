Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ficvKrHL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R/km26vj"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CA9B3
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 19:45:10 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id CCCD85C0275;
	Mon, 11 Dec 2023 22:45:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 11 Dec 2023 22:45:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702352709; x=1702439109; bh=C87Fj7bx+f
	P5NumpauDJHxatinvwnWmfijQg/ZUWxhg=; b=ficvKrHLFcQCvSELde53Ekarex
	bYcJl4QOIGyr3gfN0PRPm5F3ZZ5aq9St8Jyk8l3Qp8pth/g9TGdLBw+gL8MYmKE7
	4YTtSfHu3AL/f1uPgbP6JnCy0XX5RIF2IhTwQk2vNKw/dIZOV1TZ3narpcvw1Bf/
	vNG0wOPNDWBZTkUEsv8Zc9zXs6uIPu5I0JW0nKeL/QW4/2Ru3DPNodx5pAtqVgRH
	lW6wDGvAuQacWeBgN4o7mZOO1wgowY8XWMnaHgnQozwsfZm3ss0JR7iivtRYXUKB
	62pI/JHnuh/RoLRDRye6fhKQ6S6TESSBn6QlZeVkCo3lttc9JjtofZAHGi1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702352709; x=1702439109; bh=C87Fj7bx+fP5NumpauDJHxatinvw
	nWmfijQg/ZUWxhg=; b=R/km26vj42SH6emLNpG9T3Y0QRhJXDyPDfA2ZnsszQRm
	WRnb//xTlAOIN3hhfgUn1Zw5yrkTEJJpaKmiuPAo5tDq5TlIb4VvCe5WqoQhl2SR
	habm/vb9RACsSlr46sGh5NvhZmO0shriH4dBWcwTJRHgMziUUiv3XCCL4umycFxd
	hQgwWfgKe2aNa18EJgZ4TLJEoIV4AsW8sH2QbqVL13+8wltFrx95l9LjBwOQBwGc
	IeNlduPl54HGYoktyxgmpLWb2pLPD9MIdEKJktb9Db2e5YIqDU1c9ui8kqfC324J
	SDgWaPnn5XK7+QiwLzTlb0q3xMPbnDYhp9TUhDxEGw==
X-ME-Sender: <xms:Rdd3Ze7F4AMXZ6raohRz0rt15ffR3lCRqL3X0yth6GFH8tO5elRVxw>
    <xme:Rdd3ZX425ruZSOFZWkozFGpkDo0m33F1S1FOZNp-rJ_7QGgy-wMAfZDo_wl1m2kMJ
    -W2wgvWteo9fqYTeg>
X-ME-Received: <xmr:Rdd3Zde_gk0D8SjBgXZEizSW3zhIORT9F2mqLPz9rUpg8nR-IEdEk_MyPKdNuUEk1nIBWHoAT5Hk1lrVwvpTH7dbA7ZZ1zUB77wsVvAIo26k9lE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelfedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Rdd3ZbJEHgo8ZfckmI_W7Y8MuT4uaPOZ78JcZihc8rVN0yTQP6wtPw>
    <xmx:Rdd3ZSLw9myo-uEYDc-5wODl4chO3DLpxJwA5o5lgalyaEUkBx3t1A>
    <xmx:Rdd3ZcxmIZ2cSRSy_D8fflwtfWPPZ3KFEy-Tf9y4O1V5Jr_5Ofz2LA>
    <xmx:Rdd3Ze1ZS3WhsST5pILJY3BVKtJi6fxISpBcW-XhCS19wPXx_nqRMQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 22:45:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 81232e75 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 Dec 2023 03:43:30 +0000 (UTC)
Date: Tue, 12 Dec 2023 04:45:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 00/11] reftable: small set of fixes
Message-ID: <ZXfXQrNVReK9-RLP@tanuki>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702285387.git.ps@pks.im>
 <ZXduGvCJIa25eldZ@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="myrKhHFhKsh4xDh3"
Content-Disposition: inline
In-Reply-To: <ZXduGvCJIa25eldZ@nand.local>


--myrKhHFhKsh4xDh3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 03:16:26PM -0500, Taylor Blau wrote:
> On Mon, Dec 11, 2023 at 10:07:25AM +0100, Patrick Steinhardt wrote:
> >  reftable/block.c          |  23 ++++----
> >  reftable/block.h          |   6 +++
> >  reftable/block_test.c     |   4 +-
> >  reftable/blocksource.c    |   2 +-
> >  reftable/iter.h           |   8 +--
> >  reftable/merged.c         |  31 +++++------
> >  reftable/merged.h         |   2 +
> >  reftable/reader.c         |   7 ++-
> >  reftable/readwrite_test.c |   6 +--
> >  reftable/stack.c          |  73 +++++++++++---------------
> >  reftable/stack_test.c     | 107 +++++++++++++++++++++++++++++++++++++-
> >  reftable/test_framework.h |  58 ++++++++++++---------
> >  12 files changed, 213 insertions(+), 114 deletions(-)
> >
> > Range-diff against v2:
>=20
> I had one small question on the new version of the fourth patch, but
> otherwise this version LGTM.

Thanks for your review!

Patrick

--myrKhHFhKsh4xDh3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV310EACgkQVbJhu7ck
PpTd9Q/+N2uzunvcTl5dyEK92ZtOEeMCp+Z4a0cjfriESZ1kTeT7qGVciwTb6qwe
c7/jR7xx9LUQK8GLS4aNCGFhNYx4rJOHtxXlYdIcOXL2BTMDaGQcQCpD2HKxzAdv
GZ56qY4p0uLqwkLRBXas2NsAuSKAfI/rnCQo4MSWgw3kKpdUTbEZhecWdT0Vg2tG
4Menfx+HQGtSlfahPfPDVI0wMxpvOevlxr71G4EmkMdgLhAQx9yg68+ERY1OcRrd
PVgDjKGq2MyrIohP6a0+esMbUsstAiRLgEnss067y0dzY4klR4sZ0LufzStZwFaB
TNcQnxrKHWWSm31gUucrI5c6xtmUAUK4BEmk686+CJ0SR/Po9ahxILwdJ2uOo2rw
s/9ZX+GYjGLxVcyUEEUA7VjlIT2aVNYPiLn+SZ6kr/D5EGaNqR934drLEyxul2aH
18/npbPFW3iosluepKJTM9Y7B9Ui/+Q56i54mYirzQp/roWFtvkogGTwb3gquQ7O
QXskYiL+I8zBxts22zQECyhRWCF+xyv0BpSHHfrq3p1UKNdlvwBPBwC37WbDUT6u
bzv4gtSbz4++ji08cx8zA8ztF1xleTGc5FW40SsMoW3nhwwwDv4ZtV/BxgtNSJNq
8YroB54ijPdXndpM6cfdLmfyorIWmB4XvLE9JyzF8+s5l2yWaXU=
=P7ua
-----END PGP SIGNATURE-----

--myrKhHFhKsh4xDh3--

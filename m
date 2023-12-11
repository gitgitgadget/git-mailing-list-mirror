Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WN9Mrwd4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g5Ki/y/I"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562CED9
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 01:08:42 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 83D3B320247B;
	Mon, 11 Dec 2023 04:08:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 11 Dec 2023 04:08:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702285721; x=1702372121; bh=y2
	0iABX70I5k7mhBr3rVPXBeeeQP/MHTJn7BItEzOyg=; b=WN9Mrwd4L1fD/AiWhy
	j7lrUWqvI1Ss32hDRMz1fA1gVHott1j4CmICTcFabGyCuYjDpj9NKi42h7ZR2Rxu
	6tcVm/iTPU0qvT8xDPuhIRa3POAESu0hJ3PA0msInAPaZ5HZemRoG5oQWmvYxZyj
	aYhe0MsqR8cHY0mdZkug/hOrzHZ6EUGVWa+o3srA1wfs64po1SSzE5ZG6MhN94Sn
	nXw4WOUWLQPI331zo8bY/WHCRCVV2cF30fy/tt5knStmr5D6gpVFIL6i0+/U3r4A
	a+VwJoZjINg0dDdrzjVmcHF3AJp5UhqMG7Gbc/mHayXbJeNjxaM5SAn971zso2g0
	rrGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702285721; x=1702372121; bh=y20iABX70I5k7
	mhBr3rVPXBeeeQP/MHTJn7BItEzOyg=; b=g5Ki/y/I4KU21uW6lSha8a0xoiRWZ
	v1U7ehFIYxw/090A0U4jwkGdC4WwfMU05yzrJW/YZRR0foTSS1wZ18axOwt54DlI
	eGR+qOwX3LAv7irDHTdzhUKsqdMDHq8OJkeT3kuQtoRlJ0dj+z8No5NxoKoBwxef
	UXHX/zGi291XOkPk64cB71zF0kWv9N/54GkayUWoWwam6RbLe8KePHD5ecGEennt
	S3JxYUuiOj3OAudotHT2wni6yPAF9dl29I9aDIa7+bKSY88VqX07s/p7v8C4wFMS
	RYOS0HnKmn6UxXKL0JVuPpiE3LVfQ4okmeDyJhqJQHi/ub+aVk2ncYtqg==
X-ME-Sender: <xms:mNF2ZZA5wyXNGkd9IdNNcZ4tgHUKm3qu2zmR9v2qss_j0gAUipOghQ>
    <xme:mNF2ZXj-jLI3bHoL1I0Ql9sYJracvNskTMNHNaVlXYYVAqx42HIBAWKWwySTBmKmN
    pnAyYa736mTxhOJfw>
X-ME-Received: <xmr:mNF2ZUmBqFBByB4DjGveTdrMF-meTalyzaeSswhZKMjVSiv0k1qT7eYIBzv0W8IlY7fgDN-MMFgAvOhEBhIAVyDMlgCLLLxjMk0OabGtEFrdig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelvddgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:mNF2ZTwOFn5GZhcAvs1d6yYaAsCNgLBcAEOuq1ovwCa5kjdouqFEpg>
    <xmx:mNF2ZeS7wePhREWrlYCROvtYMp9T4CH_DRPnT6mG47uqbRAk0SL4sw>
    <xmx:mNF2ZWZ0YndUov9hZabVK_lNxpQBVkNl1RDEGZuxLVsvxrkfzwiGFw>
    <xmx:mdF2ZZfhajCWD2yRZB2WvXX3DL8jaqTUn9dQcZ5tYrhfDIrXl-2WrA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 04:08:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c7c6e1f1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Dec 2023 09:07:03 +0000 (UTC)
Date: Mon, 11 Dec 2023 10:08:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 05/11] reftable/stack: perform auto-compaction with
 transactional interface
Message-ID: <ZXbRlhcx9f22hILb@tanuki>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702047081.git.ps@pks.im>
 <77b9ae8aa675dd96dd10f4a5369f1f994fa59939.1702047081.git.ps@pks.im>
 <ZXOVVWGyUtrGWYMB@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7ccu4QKEF28pBe7r"
Content-Disposition: inline
In-Reply-To: <ZXOVVWGyUtrGWYMB@nand.local>


--7ccu4QKEF28pBe7r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 05:14:45PM -0500, Taylor Blau wrote:
> On Fri, Dec 08, 2023 at 03:53:14PM +0100, Patrick Steinhardt wrote:
> > [...] It can thus happen quite fast that the stack grows very long, whi=
ch
> > results in performance issues when trying to read records.
>=20
> This sentence was a little confusing to read at first glance. Perhaps
> instead:
>=20
>     The stack can grow to become quite long rather quickly, leading to
>     performance issues when trying to read records.

Thanks, this reads better indeed.

Patrick

--7ccu4QKEF28pBe7r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV20ZUACgkQVbJhu7ck
PpSQ/A/9GMs/xf3ez1V6quxkjpNgCgqHU/w/mqUP76blgbkO9ROS5nJUVBicqTWB
BieHK6ISIXkOvl84S4DYTxNWZ+v05RNWe+r3CFWTCSGYRnCxIhrrHMQlJB4XDFcH
vuCygIFYDA0OKvBuMCS6hA8kofxukji2QsMiY1YrjiG3Bx7gmQMBE1k2QSlGcmpv
uRDrvpXNp9UwfwntFUhD3MPuCO+JayTYdkd2YCZxLz1O3UzEJRGnx3BMWlsrkU6C
pVm5RZxVZpA/bZNS9oI7jv1SQa4C7iTJAoOH2OsYdgr1xYaw+X46ut2TkAoRcIkw
tDNd0Pn/H1pSCxVvmfzuX5mVWTHe/PQxwW+gi/KwHacTSVOVUVT1seY0644ABJ8j
aen7JFFNcHfWdnsX/dk1Vtr+hnlFTrwYEtTkxz9n1qFGwlw0aX32v40FgAPWHHLX
Not5Ehnf6ResXPE5qiTFTF0ehXRLFcrH651rI5vqfVzfgN0OEhM6cgChXL/1nIQO
JefjzxjJY6HrR3SSh+8hhBzLPYPKmamHQedDUn8HvuLF+wukTZl8nvJQm1+gL63Y
z/fnB/iyRieVQeX6oLw1T58Oije7PxEF7GqLwW3O16eb3kz9kAZx5Fsjp10lxUi9
cteIDQnhcetS1gG6Kq7+feRcYzRRohgzmu2DKIz2I+G/krAElN8=
=SkuM
-----END PGP SIGNATURE-----

--7ccu4QKEF28pBe7r--

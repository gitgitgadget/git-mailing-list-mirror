Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8B216432
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 10:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rCsgs6Gy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EP3Xk+6C"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83596CC
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 02:45:55 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 17AE45C00EC
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 05:45:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 06 Nov 2023 05:45:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:sender:subject:subject:to:to;
	 s=fm3; t=1699267553; x=1699353953; bh=O8+7Tov/1f4s0ck5GiELg6zRg
	hyArfsW+8bzBmGti1g=; b=rCsgs6GyUYPh8V+PKx61fxAnYoNhYQ7W5j5ZJr5mQ
	I0wlzNNaKwlmMqgg6etadXN0asZctHj4jmIhUcL2Q0QZHx/q93fuJ7DPB+qbPYj+
	RA9WxOzauWLunrekPXgwHkkbM5w1m9RRdNAWqt3UkO/VCqEmcWq7gfabMx6lldZ5
	ApI2l0L6vVli8ZBde57lNGOiOkxdhbKM8KacduEwyXLimbKilKZruC+GEp/nK9DQ
	scx5SVXKZ5CSC/jAejg48mSlPtYQF3VeGf3mrYla2mZlM0/6GaXa6tQP1yRMChs0
	dBOM3sVzqJHOT6T7+Pf4LeJjewDy9iHashWmyVFUr8bzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1699267553; x=1699353953; bh=O8+7Tov/1f4s0ck5GiELg6zRghyArfsW+8b
	zBmGti1g=; b=EP3Xk+6Cky6+9A7drtVnfK4zakluf5S7wct9DVAm88kV5uljL0i
	T8y4DzcIisCpSrPcb1bh4u+uWcpM+O0DCGrcQRpbS2cNEnPiZTYSAa1XfdQZuGFS
	NdzONi8Ks4C9dgcelevH3Oed67VwVDWEex845wYHdm/pqs9msEsMNYzvbCaaMMTN
	Fe3hW6MM+2qsco7Wso/43qZ7n85HXdsK+0/F+4fjzgScqxx6kz3Py6Hkq84FMix9
	9FJbyi7XBbngWYwPX7zcIL1WpfhvLNx/aGVcbl+b/zxjADG+otkbDEih7pxdDhu2
	G9yWevYt7jPdI3HoQJ4jA+fQze03FtYdh/A==
X-ME-Sender: <xms:4MNIZbVhz6PGJGXUNJC80Yd43ELkXrqIDdiIgHxX5Qyc_amTvvAJUg>
    <xme:4MNIZTlU52F-j3b78W7cY3keUQEyy4nn-CM-Ww7va0Dfda47cDqoQh3gRAfcWxM-b
    1EdRtKnqHookpUDfA>
X-ME-Received: <xmr:4MNIZXZqFo-FIFD66A6g_9XkFt5E21ls5ypjiYMWtAVV3jBWbMKtV61QLTwUAbXY_qnn5KtghduxW1EsTsEqaa7_cQ1IOAjE_CAo6KvUMKfhQ0s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddugedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:4MNIZWXE3M39yk5IIcQS-jkCzin3Z5mgVFYaLAE3ZDruyE99Bfixqg>
    <xmx:4MNIZVkh0t75yu_SmoWwV7ORK_DCwwSFAdPxWJnj_5VrMUCb_obd0w>
    <xmx:4MNIZTfFYBZHNCSnet9pDjCuVDbbb8kwUNM13aHIAheAUa7WQi7KNQ>
    <xmx:4cNIZTR1Ik-d9FFQcFlVR00WHq7AfTi6m4GMUDQKjTXH46ntHmIr3w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 6 Nov 2023 05:45:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 342b5be3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 6 Nov 2023 10:45:29 +0000 (UTC)
Date: Mon, 6 Nov 2023 11:45:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 0/4] Memory leak fixes
Message-ID: <cover.1699267422.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vPfhL/UL88GctsF2"
Content-Disposition: inline


--vPfhL/UL88GctsF2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this patch series fixes some memory leaks. All of these leaks have been
found while working on the reftable backend.

Patrick

Patrick Steinhardt (4):
  test-bloom: stop setting up Git directory twice
  shallow: fix memory leak when registering shallow roots
  setup: refactor `upgrade_repository_format()` to have common exit
  setup: fix leaking repository format

 setup.c                         | 33 ++++++++++++++++++++++-----------
 shallow.c                       |  4 +++-
 t/helper/test-bloom.c           |  1 -
 t/t5311-pack-bitmaps-shallow.sh |  2 ++
 t/t5530-upload-pack-error.sh    |  1 +
 5 files changed, 28 insertions(+), 13 deletions(-)

--=20
2.42.0


--vPfhL/UL88GctsF2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVIw9sACgkQVbJhu7ck
PpRFVA/7BEQt/oaGFBCIAQgsdIiPf8oev/ktHaY83evdxlcR0L2VVLTxBCTrIR2w
MyrGhNQPawxZ/c9ONuSBPidQrdxJ+0UljU8Vtolnr5QibLV7yXts+RBcSJRYwtOH
JdZs0k9Wi1wn+uLtxmpDYL0pQTdh9+HWjMcKLcyJc+mL/qixnkPylcgzoMYIka9T
4TyO3XpJJALtMJ+An6lKMf1ub+gzjcJZVpagGj66WinkkSB5J60rh+5yU2/hS/WF
EpmpajXKtald33kxcOqcP4Z1AV/yJCcnEF8BvRW6m+lQSX8u4yunIgjtfaB3iRB8
2eXkG56RMSy2oFrYBhevP+3AJGHVPqJkm85aVJAzK37p5/swDlM/UDoMbk1jEPZ6
YsKqWyOQbP4Qx1YSavz1S9slyUXRnZ3GsvfcE6BBOsv7P6FNA0wOljGDA1MJzQjv
kyyuggVS0InUT8YY8U92I0m77YmZ84S1cV6sovmfJdKNIl/Zr8ii2kHGlhk4hKJV
0MENR0GopfIspTE6PPESktlTG5ofp0cmJv3uCl1Lc4Hlt7iGmjU+gxlSFWpIzNlL
6xEJ3o3iJnd8i9gUvzRIaGvx9lUxrxLQrQLlJf+hfk2jE0Ic6R5ruhtdn0EIX6k3
hvg+V53pAGjThHBRTZ+l/r+ERYgfqUmBGtHvOWNaCPCJ/gzoONg=
=VXoQ
-----END PGP SIGNATURE-----

--vPfhL/UL88GctsF2--

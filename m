Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BE5156D2
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 07:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="t+I+KsKH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="geoeivEP"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C5DDC
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 00:19:54 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 09F8F5C035E;
	Mon, 16 Oct 2023 03:19:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 16 Oct 2023 03:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:sender:subject:subject:to:to;
	 s=fm3; t=1697440791; x=1697527191; bh=JrEEE2bd5fhGGaM2VrEKCQ11d
	1wYDrjXkuA5excOZLY=; b=t+I+KsKHOUespaavbGkZY8EIFSeuJufmpr+Luebtb
	wgkVVrxzIcvhfNFfMfn7mvTs3kXEckt4MWB6UP0jnsAxbNA4kjRcNfYN9ZVhp9ux
	pQpzqgu8WOlEohqpsO2RKvgrFPy5rQ0psX0h0r4siVXPUyma4qLpWKBDOfjyzQGY
	buqe3d+VxjL6f5K1lB7ATkJYKe1Fn3nJKT7GGnQk7ytQqcvj4ItqXsIZC1BlLcLz
	GPVZkfk9sH3snfvpObur79311p+J/vnAMG+cQhfBuTxhoUZkER0jQj37BJchAOte
	syWNelGsYKakcdRepm8f95ceEiuGPOtNMJDfJ6bfBtUug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1697440791; x=1697527191; bh=JrEEE2bd5fhGGaM2VrEKCQ11d1wYDrjXkuA
	5excOZLY=; b=geoeivEPYwv5fA9fg6lHPPFSVjf82m5VJ639FcfN2Yjqe7Qu/VX
	nZkUH8ZXGfaHkj6RDHL0tTxUG6HjH/ESG1TKIVM9mmWMx0PwypJ715rBiHMcEE44
	R4yJl7GgvuV3Al245q1djXNPXoHAc7H7/6f7izSpTWwhM0DQ1a1NI71TZ7JgNY4Q
	37/YaRGCw2vGdFzEVmuWck9ONB4GoEqQchCc/1fJDBXWBUTMuxHFNTG6kB58CuWv
	3nYqjV0FgBlXEOig8Exql9Kk/glibG7AKY+x3z2oSE4atSI9hKFdw5hwJ6jCxQDY
	Kw3+DordHEhvm7npKU2pXU+uaapPcGKJChA==
X-ME-Sender: <xms:FuQsZT8CDBioEFQSGk3qzKAZasFGD4xWO-njIQStqkwxfGGUe9PE2g>
    <xme:FuQsZfuqKwOIrE7VXH1PLAv19ul4ZljNYJsoXaVMH4EI7j1HoxTRjLxFBEL-fDqNt
    26_BD9y_JNN6JfrYQ>
X-ME-Received: <xmr:FuQsZRCn-dWJodfHuJ_ww7hrhxlAZ1-kCFpoFAsEBz82ezmyl5t4gqOlQhzP4q36Y0riP72KT29psYDzobRItAs1SBwECK13CCLM5TGKKhsXgHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrieelgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfggtggusehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeeugfeutdeuieehteelveegudejkeejheelje
    ejhffhgffhvefgkeeukeejtdeijeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:FuQsZfftB4-zDNs-HD7el9UTscXKYRaqsLUXpdt4wd_WB9hA6CT65Q>
    <xmx:FuQsZYMAJNTfScagYPCZkgpp12t-HYYamw64n_tTjzOrLvuP-CydMQ>
    <xmx:FuQsZRmGdD_GeGzCCGdXhfvYwDaCZx3OfvyZBGXFdPdP5ELvRRFmSg>
    <xmx:F-QsZSWWjuGoUz5bV04h8EqTZiBySO3ZtJV-ci5lqP8SUHzqmxhhHQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Oct 2023 03:19:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 42d48076 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Oct 2023 07:19:48 +0000 (UTC)
Date: Mon, 16 Oct 2023 09:19:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 0/2] doc/git-repack: small fixes for geometric repacks
Message-ID: <cover.1697440686.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+DvbGm7pJl+3t4i4"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--+DvbGm7pJl+3t4i4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this small series addresses two issues in our documentation for the
git-repack(1) command that relate to geometric repacks.

Patrick

Patrick Steinhardt (2):
  doc/git-repack: fix syntax for `-g` shorthand option
  doc/git-repack: don't mention nonexistent "--unpacked" option

 Documentation/git-repack.txt | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--=20
2.42.0


--+DvbGm7pJl+3t4i4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUs5A0ACgkQVbJhu7ck
PpTd2A/9GWxrXIRpXfMq4bcSVWKYkWkC69Rvg+VGMJmE3j8T1Vz2Jw4BzTfMfQVY
ZVVy1QibmJP4nKMEmPmsvcgBEYgXe3XIxUj5Ti3667zJVaBI3k6WSmBdEPKMilKO
xd2ATtxQ90whhOX2g3msdWq22x/0Bf9NHxvFfP8KksoIfTlNaggdxK6AWjllz9mj
mgMNtJyT5FHT3+xvS+vHe3kBOpKYmBModOh1LcwtK5K1KTA1EPRTeIvWbie2kDT3
3pA0qBh0SQgJLQ32KvlztCZd7zmJnG2Q6elUjcMi/+UFpoo06hSAo+yVKE3m9/wD
WSOrZVufV8laYj5dAheH8uWDMWRYRFEXQwdkgFxUuwiXuBwUISL7KjdyQ8iAU01D
JngbGTURZIy7iMRHdukDt7dvZnooq1TQW0RVeFQdD6bEHabplBKnMdMkhKqsdhPE
vVu0DfDO35YJgEnnvN/emeKStM1aEBpG5pwXnWTdFg1CgeKVlLuMG+L2MCVkfIaM
s3zvvR0cGLxvm6/r9MKIWENMEt1TCDiyWXl3DggMjUzbc2Jtb4HVGsWNivyG7jQY
R/Z4oEzbizbDCb2Otr2DJbmIiP8NIpLrmFCzyjGdgNQRMwz3qicAslfbyw92IyKF
PuWJlN32R81wmhf11wtZWFkWGKqpAFRVcPw0MYLcyl6pvfva2sQ=
=G5SK
-----END PGP SIGNATURE-----

--+DvbGm7pJl+3t4i4--

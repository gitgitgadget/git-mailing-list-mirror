Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95A3154B2
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 07:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iqavtIJ6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PKmqzOGp"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93ADBD9
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 00:19:54 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 082295C036D;
	Mon, 16 Oct 2023 03:19:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 16 Oct 2023 03:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1697440794; x=1697527194; bh=54
	0wG+CiKb+KgQA3CprL/XVgZwHeaOyMmCqSdcMXOek=; b=iqavtIJ6FeVFAX3oeW
	ZP3fGjR5sGPAHi3s7EJrN2PubAMTt6nQMzZHiM7K73yAyIxhJsj05U43sw34gquU
	XMw6VRjLMQwqZQDBH1WCj0I8LJgU8z96/6vIM9tYPxmGYOOO+aogdz/2YnbIXU1k
	jhsk12VHEIMf3lk3r8lT5ifmb8Ha88d3kTozwu5tLruRQpHxO2n7sEeD7WR5Dh8d
	KpOtT3Y9bfrh4h393Xpu9PDmygc6qlki0LjeXoAHBjCvBAKlAqvhvGfYUrQDQbyz
	9jKoj+EL3Ii4R9CA+XZ0Q4/v41AtFUMV7er/bvPnro9c9Gouj5RipQcOg0E0UCn/
	rmQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1697440794; x=1697527194; bh=540wG+CiKb+Kg
	QA3CprL/XVgZwHeaOyMmCqSdcMXOek=; b=PKmqzOGpeVGhIcRA7ACowrGQSbb3H
	qnJpNW/HjGwjg59K0D7gCaZ7BJ6NivvKYzvcBZuTyet8ycWgph0NK46cRpslvG4R
	DKmqqY+tr4AkGEcF2k4S0H2u0P4NgOh63qKbgyFsfPEeXY8jUvz/T1wxKLSMzict
	Tm400b6+Xtaxyxnyxwic9DceaJaNA5bLWzZkWSK7gDD7IkNt3I/VhrFWxLNvotk+
	vKGBK150BFbtLl0AOYD7XJ33tkksdgeiCa8bIGqyBwaJR3/iDGp2ISc7DroJw19w
	veSRHxCp4D6IRyM41zk2jjpBY5vgvxrwLTBDVqjPiLYTs3ZVgPS5ilB2A==
X-ME-Sender: <xms:GeQsZRP7bxOrilV-LOjF2p3-XiEHzreSsUzKVCnX9wJP3Lar1NuwRA>
    <xme:GeQsZT8VuxnPsM4Yb1NBnwlbhir4I9w65Qhcs1I1U6o1fED3IGVCGf5tXvO4UB8iO
    KKG5nN_dqlaocYuOA>
X-ME-Received: <xmr:GeQsZQT-MjlF1AYmQlWEY2j5-2AXkxxwZCdc-Wg-2XCSmA6gfLitb7uaodPUdMvmmSznJ7wY2UfhIlwUDXyN-K8cSQV-KldYXqYD0HmsZ5qnaGo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrieelgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:GeQsZdsrgROXg5Qtelt3HXqcnMRlI1KC1BGNS06e4mjtCPoYzmHeWA>
    <xmx:GeQsZZcyju9xOlFUi7OWOj6v4PAoG7nWcYQRHlaKZ0XYSugFidoKNA>
    <xmx:GeQsZZ3QGddQNnLNYYlMxRnbUfRkexonIU0vLVfH2Sym_R9liyrf_Q>
    <xmx:GuQsZZlXOGanmAI8WFlNXH__LwW06lpP4Qjfno3qwlTKZHHi6N02VQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Oct 2023 03:19:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 37679156 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Oct 2023 07:19:52 +0000 (UTC)
Date: Mon, 16 Oct 2023 09:19:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 1/2] doc/git-repack: fix syntax for `-g` shorthand option
Message-ID: <bee3cfbe359c62cfeb9803917d661fbba54e404b.1697440686.git.ps@pks.im>
References: <cover.1697440686.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fm1xVWo9R9Gg1VGk"
Content-Disposition: inline
In-Reply-To: <cover.1697440686.git.ps@pks.im>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--fm1xVWo9R9Gg1VGk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `-g` switch is a shorthand for `--geometric=3D` and allows the user to
specify the geometric. The documentation is wrong though and indicates
that the syntax for the shorthand is `-g=3D<factor>`. In fact though, the
option must be specified without the equals sign via `-g<factor>`.

Fix the syntax accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-repack.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 8545a32667..dfd2a59c50 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -209,7 +209,7 @@ depth is 4095.
 	Pass the `--delta-islands` option to `git-pack-objects`, see
 	linkgit:git-pack-objects[1].
=20
--g=3D<factor>::
+-g<factor>::
 --geometric=3D<factor>::
 	Arrange resulting pack structure so that each successive pack
 	contains at least `<factor>` times the number of objects as the
--=20
2.42.0


--fm1xVWo9R9Gg1VGk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUs5BYACgkQVbJhu7ck
PpRp/A/+POmEhXFCy8vxR0fxMoraoP1Q0CNveMhct3Tp5JoXXrc1D1QjAvUy3kke
huw058hsjt5/oP7FxjZGuHqxkzpSgM0iy3ZWGoxWr+FXrBqMsCJcjci4llubJhqj
ka3/Oz1UuQWz8loJu6oNc1Ec3Ib7hxO87e0k/IlLJKjlwQiv6uNx7JZ7uH4J4H3/
vadWC5w3e9Oen3EYb8tVsjMClJYU899sstOZxL1uc9kSnj1ptU+w7gtpcBlxhdIm
TGFzAvrF24wOeApdd1BbcX6mbJD5xE3TXo9il/QtXbI7B94NlXyzgi9pkkve/wZb
ia2K32otTFGJt1N84iIovMat0MOfYldcj4Ylbtq3cnLNnATbEzZOb74qR2V9lnGm
7WVVzoW6OkWjATfu2Y51cuOpuqE+2BNJx0ZNNkC5DgShnbV96Eq/45FrBN6Kk0dX
msQCTrsi5VZMkAZ9Zq5srr5u+MkDA/FQlC4FPED5aiihnmIGcT+xlS+flEqhd7uR
UpBhBwdRBVaV4rE0pTTQVI+ZqtUad64CPqSj6ZQavPuIP0gTNRxW9MeHCqa6CTas
1nxwR0hi6phTD/ljQChiUlyhiwQqlfoUooAQ3V8sszUgUc9X/7XEnm9ztO10glCR
xeXOP4uEAHmAMBNBGEBYCxWg5eCwRUN0qEWStOwzbb+C4QMqugM=
=tB3s
-----END PGP SIGNATURE-----

--fm1xVWo9R9Gg1VGk--

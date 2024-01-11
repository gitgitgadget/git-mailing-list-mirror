Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39287156F0
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 10:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="t/AEu5mU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UpMAI+fa"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 400533200A9C;
	Thu, 11 Jan 2024 05:41:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 11 Jan 2024 05:41:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704969717; x=1705056117; bh=jscV7EmjFS
	QTAtX0YFaxYJuLZvQfyhm7pN6JweHobwI=; b=t/AEu5mUJDid2Whdm1uUCT0+dQ
	JV3OoNmJGOi7SSItQybgabJxFO5270y5MG0Cpg+K1rytS/CPVTi1LhAlciVU2vJ2
	MC07lRkHoLOvNgpIUVRks/QvdEdvpotVlK7VjSVK6cZpCso4YbljJT6BCIz4vhUt
	RuoC3woNrc4tssNHMtYr9GjaJHVKOTSuglyPxGpHF3tfxrVbByAEeURW+tqK0r6D
	g48q+AM2QLcCbSyFhH/ybZvNPtZRHeJAOBfttEeq/Bu3k0HXcatmEvnvt9TVWPDe
	zJB1tYhLSjGS3QV/3NyI1qd+iqiSZ+ATEEteJk6PC2emQUKCLhuvx2fgyrJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704969717; x=1705056117; bh=jscV7EmjFSQTAtX0YFaxYJuLZvQf
	yhm7pN6JweHobwI=; b=UpMAI+fawMjDTjTvwxRVoFEt5B/B5auR2wgJeVKRLxM+
	7gVeN2k41IL1fLpd8AifodwppH4jrl+m7kClCU6vTdArd+fW0j1A0d0tg0TA687Y
	EzgGqk0hGSD0GvwGvaIwvgaRcsQcw1263DNydRTwKYXwPu7nKQEqfjHg0FnHYmvp
	Z4kGoflg+4oRHR2UTehsNF8ITmnKLfs14MpcZTWCuUH5FFURVEeHDPekxdX0npQM
	uvrio4k9KO3p+FpNTo3AbHAz1pIjPW/rgQc63A5b6bk0AM0AwqgXJMwe9ROXyjJP
	+WOiSIQRqtCpt9p0mdw0nWvBXTFV3PVIxpj0xXLvEg==
X-ME-Sender: <xms:9cWfZeyqL8sIxo373Bl1eJFrjtkzgDxpYFI8KywqIsiG9bvxdhkABg>
    <xme:9cWfZaTqYdge8Qtwm7kQk_w0XW3VXXmnhULkIVTPJc3l2Am5JKM-_qaYObfTLJVWU
    WUdPaEnb7FMqYZ4Ig>
X-ME-Received: <xmr:9cWfZQWYEJlNueIa2KqIdw748e7wunmWg-HlcE5DbuA9i2RHPWyhRR6ikk0eI_M_Gov-67n6iEwEWKSWlLrZK8AQfAgn5Pu8oFXRO33b5Iq0Q3PSqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeifedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:9cWfZUikJNQuQ0hBsQBMSNt8nrMVNcWasjWnHVUt_DOY6bFQMqn_Uw>
    <xmx:9cWfZQBn1l2uuucS6u10N7c-eEnJNwCkRyIWkH2nXkOEjznMf33-qw>
    <xmx:9cWfZVJ3ugnTWAfRnSRQ1xVUxg3w2OCMwy0lKSycLaT64SjH5chQ0Q>
    <xmx:9cWfZbrQlEWiTs1eoX7tn0w0Fv6EZr6stZZlM2V_MTdEO4wleCSJjg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jan 2024 05:41:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4b3ae6ba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jan 2024 10:39:14 +0000 (UTC)
Date: Thu, 11 Jan 2024 11:41:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Stan Hu <stanhu@gmail.com>
Subject: [PATCH 1/2] t9902: verify that completion does not print anything
Message-ID: <73406ca9c8f38ac2ad8f0e32d6d81f1566a6b4d1.1704969119.git.ps@pks.im>
References: <cover.1704969119.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8u0tNs/vgAIksUjT"
Content-Disposition: inline
In-Reply-To: <cover.1704969119.git.ps@pks.im>


--8u0tNs/vgAIksUjT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The Bash completion script must not print anything to either stdout or
stderr. Instead, it is only expected to populate certain variables.
Tighten our `test_completion ()` test helper to verify this requirement.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t9902-completion.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index aa9a614de3..78cb93bea7 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -87,9 +87,11 @@ test_completion ()
 	else
 		sed -e 's/Z$//' |sort >expected
 	fi &&
-	run_completion "$1" &&
+	run_completion "$1" >"$TRASH_DIRECTORY"/output 2>&1 &&
 	sort out >out_sorted &&
-	test_cmp expected out_sorted
+	test_cmp expected out_sorted &&
+	test_must_be_empty "$TRASH_DIRECTORY"/output &&
+	rm "$TRASH_DIRECTORY"/output
 }
=20
 # Test __gitcomp.
--=20
2.43.GIT


--8u0tNs/vgAIksUjT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWfxfIACgkQVbJhu7ck
PpQvDw//VyQ5AF1zxPsFbVkQsG3N8GNxE2h56SB8pKYl43qC87Vhzj0QjC9ntTZv
UxYlxW2UVOi87m0xIzFPiU6kvo6qCnMAOe+wlGuiJReNvRJRKzg1JjcbD0+eaPEY
Rhsl1yqU2qh3fCevzxSWXvKtGXnNOiOHs2rxpzdgb+mUq9Jlqi3gukfrmWlFkcqK
8kE70uIPcRfOfDRN2e9Fg/JFjnU51HMD2CcGiJTTE0ikSul/kzrwHfQ8i5c6izzs
ErzbwFJZxuHTEubR9VGXQKYYxBwieAY/1pejRqxpl+Iv8859o+l3tkmnm7gLppYC
K1VUabXUHHOhDUKklTogzYS1M/TWO8T9WlksNDe3hk6pAvRwSZpinsFL8n1dHQxy
2mzsq1IGlf0GPeY8/l1pOIoFcHz/rXsP0SLzY3bJ+aj5wggvMeIPc6jVsPaMPN7z
OAwkvcFRDZuqHa15aaWOkZzfHhIgMY2z07VgkTOD2sIcPJrk8Ngzpf533WaA198z
+0PZrK58Lhu3JNGjNRkjdMf0e9ohDza4bsK+A6SYrLVau34DVo2DbS1U+COBTRwA
yLPNTIi6VyIplvZ3r6ZlEd7iU4dJ3gLbLsAawHuoYhjS98GamjVvuncMVUU7ylLU
mAm3gwITHLAKk+ZILO0f/wjp8y0Sh4E44caA1EHzLs14QDqjpfU=
=dWqw
-----END PGP SIGNATURE-----

--8u0tNs/vgAIksUjT--

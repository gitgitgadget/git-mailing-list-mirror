Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OmgYkrty";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rAn/B9av"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBF4C9
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 23:24:56 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 3A8DC5C01BD
	for <git@vger.kernel.org>; Wed, 29 Nov 2023 02:24:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 29 Nov 2023 02:24:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701242696; x=1701329096; bh=4+
	unpVzOvVryyzyC1aPUoj1ZJ9BSn+4Vqc281WHt5uo=; b=OmgYkrty94wvEvRaO2
	3AANA0BcjInutRS55dhX0QIALZ50Gdhnq20TIinALqjJI5hKDh3FxVlU7qiJcqE9
	0cZIuWDP/1JnjMaWVpE+dlzmM6T8QTsXlNZ9dwyqEeWWGWQiymtn+KH6/HAj/9Of
	HGrfwmW6kWVnCz2Tj21n6tLcJbxKQ/vohbop695ydwUovAqfLTxXWlwYVvPhCRI/
	nYJM3I0tcTASW1hDCtV3ZOmc4xXZP4nObvzJ6e2k7EYOq+ASefMbRHKI8Xk9BYxG
	X9dfbS0TahdZVsPFHcUxSYVR49CCXUHcJ/neZ8SRXRr2U82/0iV3wkOScDP9fnmm
	jLvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701242696; x=1701329096; bh=4+unpVzOvVryy
	zyC1aPUoj1ZJ9BSn+4Vqc281WHt5uo=; b=rAn/B9av9/lKHIg+DYYNmKJf3CX5o
	VNUkqVRYRPzoZ19eT53DTZQcWcVWmUhdX7Yl3FUF+wyCuUtNWzZn/aBeQaBA0enr
	USWVKp8pvvbK1hLikYmd8zf7hnqYTuhCcNCVOXe2ek7em9TIE9Rx0HzhsutpJgcQ
	jlOYmougj4N0HXZSCCZ2bxOYI2TdBup9P8v3A0acVfHv1DXAohg6j1mixIxrNN3H
	zB1+/l08eqV9DXUROJvWt1gA27RbrIqJ244qwig/4HSTS0uSr7Te8zahCYDwCkgV
	94XZARPjJxhHww0E4IGoruybY4v+lLjeoL0Q4q/mUgcyToBZgZEmcPA9g==
X-ME-Sender: <xms:SOdmZQq-sxExvxz7wKL5pSmVxzVtecnX5UykLaHNglt4Arx6gAqeJg>
    <xme:SOdmZWoCcyvPCR7KvV357qLu17KYzXldoNKW04xqkxNV70sxSeecX6QNB726bixjf
    6x-7wC1LD4VyjAIxg>
X-ME-Received: <xmr:SOdmZVObO_GticWowuI56k2pG0EnPK_Omac8LOC7qXZzCzRN-cIoNJWRncZSpiBNWE6Q-r2pgKk1D5CM3vvZbsGn1ZD2l0GBgYoYYfNgMBsGtnAG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeigedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:SOdmZX4gVbM3TEfpmVz51CD3d1cqsDlM1ZnVuRIZkFBzpcTJNwd69A>
    <xmx:SOdmZf7N20qHs5YGFY0LIh9s2-WuiDAsZh-36NgG0rO5QEydXwRVTg>
    <xmx:SOdmZXiFtwVGUNfzGsdfgH1w_MQHoL5makQcmf_zz8bECLMuD9YgIQ>
    <xmx:SOdmZYVYaadoBGR8zFcrLnNs_tCi2mqh2fVRZV1tffqCmsLT0aY4JQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 29 Nov 2023 02:24:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 74e281a8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 29 Nov 2023 07:23:44 +0000 (UTC)
Date: Wed, 29 Nov 2023 08:24:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 04/10] t1410: use test-tool to create empty reflog
Message-ID: <c06a5192aea94152639cbf7ac8d72172727b902d.1701242407.git.ps@pks.im>
References: <cover.1701242407.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LY1kV4ByymC7C0QS"
Content-Disposition: inline
In-Reply-To: <cover.1701242407.git.ps@pks.im>


--LY1kV4ByymC7C0QS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

One of the tests in t1410 is marked to be specific to the files
reference backend, which is because we create a reflog manually by
creating the respective file. Refactor the test to instead use our
`test-tool ref-store` helper to create the reflog so that it works with
other reference backends, as well.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1410-reflog.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index aeddc2fb3f..a0ff8d51f0 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -469,11 +469,11 @@ test_expect_success 'expire one of multiple worktrees=
' '
 	)
 '
=20
-test_expect_success REFFILES 'empty reflog' '
+test_expect_success 'empty reflog' '
 	test_when_finished "rm -rf empty" &&
 	git init empty &&
 	test_commit -C empty A &&
-	>empty/.git/logs/refs/heads/foo &&
+	test-tool ref-store main create-reflog refs/heads/foo &&
 	git -C empty reflog expire --all 2>err &&
 	test_must_be_empty err
 '
--=20
2.43.0


--LY1kV4ByymC7C0QS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVm50QACgkQVbJhu7ck
PpQOSw/+P4/SW+OLGQrFOTQrNtA1LJZw7N7AezU1B5M0HmvtrCxS0lVzJ3MQuNyV
/tPZCP59Y5MydhP4sYyFHd4N+FOZBvt9bVBVRFaMp/s4fGTlO4O+bawRgKqoLoYv
jTpStwdn0Pkn4cX4sk3gz79xPXM21d2tixYG80NWaVEEeBeRJWkyt0s6rWCVTWhH
MvPJvk2egKYsgrSAB7K0jl0dR/OM2maOTY86QQb9kHOurnP3DDXw/CrIWl4LwkjH
i3A89h6bh7Yij92Q3JlqPX247vfui96A036n5cEJNKQvsvdZY8ZGqVLeb653gKih
ESZCmSRvEiiym71sMh0p2jPxxOa/0TWZoUYKQ1RB0GEqPppz+L5qs7K4mxyuexPh
pEVwLGOJgtDAfaqvxX+ohGcuq+DzOsxW41RaMIyljklNCscHY76fd6u9jDCLexaK
rJcbM3cSQT3fbpX8vYs7SYZHjoQcXKr6ZTpY56uWd4UPDAhugCNn5r4zXLWQTIEN
YKgGIpYb8qg+CMeX1fsbPuFMAshZZfgGYMX6jjTyq4FbLbhNqsUJVX44pB+lyhLx
yMZ6tKb21B1RKUw/eNasDXCg4nmDd188+13HF8VtUbT+BGGcKapPNmcCHaZFzuR3
ZOqo5gTVqw/GUcLaaW+/PX/44JBu1adda1RoRDHMq/QjWNw7y0c=
=tcuK
-----END PGP SIGNATURE-----

--LY1kV4ByymC7C0QS--

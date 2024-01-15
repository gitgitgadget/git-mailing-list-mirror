Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035CF2C68B
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 10:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c3Oaup4e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="STtVsiyh"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 4EEBA5C011D;
	Mon, 15 Jan 2024 05:36:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 15 Jan 2024 05:36:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705314969; x=1705401369; bh=+Y0V8uYcmE
	3A65OAsGja2Dp1vjjNDZ+r/WDP0ilS4Rs=; b=c3Oaup4evqJOarpCOOuqS3l51r
	EpQIfIpj3BCpZVaYlUfRoaDjNUS7PNwpR4LA+PWsDIZwvqS/EpD6xVhijfV0NeLg
	C7kYBrqLayHA2vmde4XQQkiem5HsUtTE4VdluFyw6FB2hukShwMkpFdd1Tg0db5A
	OtyoxT36jeeWday2MCmuYPOZAg5UHhTKfr4ZZyziRLfD/FLk6Yc2IMjefFCI2iuu
	dlG+hig/LMaRlh8Sjt9CJh3mNcItBqvO4DB8dJLKkhPEw6olmE8WhAdfXeAr9r94
	9E+/zqWoi3Af437PKI/OWCZuXYNnAc11Hnwtz6do/YGKdpJAe3ikVBy5nlqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705314969; x=1705401369; bh=+Y0V8uYcmE3A65OAsGja2Dp1vjjN
	DZ+r/WDP0ilS4Rs=; b=STtVsiyhX5ooU6BFfAgiOGDecuSNSj9DcO89m8YmEwV8
	y+iNitsQoqRl/QKwsf3I7W/llCAo9b1CuZyl+eqV1O1GcvQMOkk3o7/NOyLmzFJU
	4WDpab21Q/itreO5svyuVsVoDVnsgZoK+i+4V8rG0Ybtzz3wCTyFW/Fpd6x2QNkz
	gqVvhJgbAnyddjWscF6+blNcafkeGjAptsAc10stcAapFJLwXpVvc+t6aHdph8zF
	3llipurFhqVQV31fvCYU64JCaaJomUkblWX04EIqr7Owlzaa13QpibII2WzjXvk5
	sBGW5DbQRytG2bs5fwcect1cuBYxVHUJOOafhbLEzg==
X-ME-Sender: <xms:mQqlZTsqgbyxUKBPLe9ZA5cU7AQ77h1YrbiJHyWEWyPahqSRxAJHig>
    <xme:mQqlZUcZSq9LAZAK6iRCmaY5VxCr6-vPNELrbvD02-eVXUG6B1nzYnFYfmNIdZhUI
    bJ_nZ8a4AaidtUh1Q>
X-ME-Received: <xmr:mQqlZWzlFgzsyOlOQmREUXHgod0w8zZ28HOXesd621ehteQo7dJdKghps8OYext08t-BvoS6FrxE6xt4J0g-4b9EgxnyNhT3xsy3oH1HGvEfJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejuddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtudenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepfedvleefueetgeeitdekheelffekkefgffduhfduvdefffdtheekiefhkeejkeeh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:mQqlZSMjUiRtWhk-Wz7ZK38cx_CtMGELXbdThWPCadv0pWmuvjgH8g>
    <xmx:mQqlZT8sEj2UjzCDIGI0_yIqLVobYhjJmicBHCUatYaUm8jjYhacMQ>
    <xmx:mQqlZSUNeEFYCV23eC2S-a7jmXm32BcV5X8ZCsjYm7O3_uk2jHutmg>
    <xmx:mQqlZfYYbJK-nV9gqzGW2cMdejka3QYxXG6kSlULbrivmhx8RlSFkQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jan 2024 05:36:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9e03a28b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jan 2024 10:33:18 +0000 (UTC)
Date: Mon, 15 Jan 2024 11:36:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Stan Hu <stanhu@gmail.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/5] completion: improve existence check for pseudo-refs
Message-ID: <ab6e9118a552308d7121b6a1c12a8f04c4788326.1705314554.git.ps@pks.im>
References: <cover.1704969119.git.ps@pks.im>
 <cover.1705314554.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KxnDZTbf9fSFEnyU"
Content-Disposition: inline
In-Reply-To: <cover.1705314554.git.ps@pks.im>


--KxnDZTbf9fSFEnyU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Improve the existence check along the following lines:

  - Stop stripping the "ref :" prefix and compare to the expected value
    directly. This allows us to drop a now-unused variable that was
    previously leaking into the user's shell.

  - Mark the "head" variable as local so that we don't leak its value
    into the user's shell.

  - Stop manually handling the `-C $__git_repo_path` option, which the
    `__git ()` wrapper aleady does for us.

  - In simlar spirit, stop redirecting stderr, which is also handled by
    the wrapper already.

Suggested-by: SZEDER G=E1bor <szeder.dev@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/completion/git-completion.bash | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/gi=
t-completion.bash
index 06a9107449..d703e3e64f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -137,6 +137,7 @@ __git_eread ()
 __git_pseudoref_exists ()
 {
 	local ref=3D$1
+	local head
=20
 	__git_find_repo_path
=20
@@ -146,9 +147,8 @@ __git_pseudoref_exists ()
 	# Bash builtins since executing Git commands are expensive on some
 	# platforms.
 	if __git_eread "$__git_repo_path/HEAD" head; then
-		b=3D"${head#ref: }"
-		if [ "$b" =3D=3D "refs/heads/.invalid" ]; then
-			__git -C "$__git_repo_path" rev-parse --verify --quiet "$ref" 2>/dev/nu=
ll
+		if [ "$head" =3D=3D "ref: refs/heads/.invalid" ]; then
+			__git rev-parse --verify --quiet "$ref"
 			return $?
 		fi
 	fi
--=20
2.43.GIT


--KxnDZTbf9fSFEnyU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWlCpUACgkQVbJhu7ck
PpSYlQ/8DP3zGRat+F2zGzPGLXiFNbkgT2yQmcFp/+I3z8+t/gnmjkQKIDIQcNRo
sswgJopKZia0Dm0/6+V2UurZZOd8Q/uJqweXGAHuW7ys1zLtdck9VHwmvGfmU6jL
ohu410NOIWyQd7zAkl/XrQaDsmKXyto0GklzZWONlCMmxcdVriPD9pI3KoBWOvFi
7lIP3jAHNTNkiqMnBUscr89VFX1yrIQBdN58L7E47yfHqVyyywt61Av85H3ivWIA
hVJHc0+7jbu7inztDubdyK3zPNxm7uAE3WhOonVxfHBGEcfaN01v8wJCTCioAFi/
BY2v6Hke0OgYAwpbvc6LQ7YC4KC7RqwNWY1+QGdI21xFT/hsYPrg99KKmRjiS5Pq
1C5DED3RznyaYxlr1fhsTgXHc+rEDm2jEanYxtjWegEJ8s5EJCZAtpCKdjwAkPMo
G7GP+D850DhjYKAx20gNscEad22ugL9csG0UilK0tq5sRJvSu2eGqxDfUNmue4TN
VOr35Hsvu59TH6/nhzxIKlGSSuTA4xLPNMc+VwiCMOHYtJcHuahCew3dUKt/iB0r
r2uhHtHQDM3wJgCz06BIqXdcbQ2LJ5krJnPForruWzyUV6D3lRiD4g9/mJlA5UCq
eCTrpOwNgykP59E0AasD1XJTU/F8TbgmufjNc1uIYnwvmYJ7OI0=
=810r
-----END PGP SIGNATURE-----

--KxnDZTbf9fSFEnyU--

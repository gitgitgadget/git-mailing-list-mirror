Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252D21945F
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 08:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="irlTzin2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bf77x1vw"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDCACE
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 01:00:15 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 5C7743200A0C
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 04:00:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 26 Oct 2023 04:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698307215; x=1698393615; bh=ho
	pNqA1aCKeGo4sKc3LlhiLkwLBxItuLsm1UGuPVoBk=; b=irlTzin2Lw97son+Fr
	Kl2BWwpBj5trB8qy/UI7xd+TlFSMBAbclmQTmL9Wzdv6IU+wUKmiqp6omJBZd38n
	tYfgUUQZomjNBtqezPSUXfFxzp0fi04/UxJhEmaPNbcJV6NRBmunJ5n8ln0J1OrG
	tsr0U6CbgBoBGWuUk87dnkkn7bknnZwkgjo898Lf77JTon0+2xLU71ObuUHAQ+G6
	jXRcQn1YZkjc8U3tXH4fJC9P1s3FfLl8CXQP1sMOSvO2APn0oKcJgy7U+8rzMm06
	PDVXxOhHT7xkhzp7rsNDu3nclGC2p0NpPNNLWpScsqkzkey7NyWWxEENbg1QBdiN
	FQxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698307215; x=1698393615; bh=hopNqA1aCKeGo
	4sKc3LlhiLkwLBxItuLsm1UGuPVoBk=; b=Bf77x1vw3YAp4CTdOmzgV5bYJSvwr
	elZcS/MtYcCfcaZz9ChD9h5pYLKicizSyOUIHe1O3Tt7Fj6DHEOgVJJsMl/X++sG
	LuvbeC4WJKQCzJrWLqusBAICG9lMLkAIlnQQ9Rgmta+rhESRdzpoOa2RpMmhoFJl
	ATW0N0Or1IVrd/+nG+a9ozzFplY7criQMqGcES8hvH0S5xw/TUTvCKrxfuf4U4py
	CIxkbqwjx7+wvnVN8e4Qhv9uZbeulpXsW3Sr4S1YN/JdcLmkAHtGmUOwU3fJl6NF
	6R7iKpq1H/yWDtbCLmM5+wBcuPj6NVrUGXJR+B0nh2eHR8F9OE4aNYATw==
X-ME-Sender: <xms:jhw6ZZc4ZXYeuhmW5M6bBb7Yvq5ODXaW1BS92QrnGth2CSrLDeynpg>
    <xme:jhw6ZXPeGr8gdRXDGoMZxYq7KYcGgCEMFlJm4t-kGzmVdM2cINOiJo_fhU-HZAOXD
    swRar8_UoCUpvTo1w>
X-ME-Received: <xmr:jhw6ZShhsEU6VBdfe2-BDCc4bqloFH-8cmPmPcrda_Sw6tIepRUcv9tmC_d4dpipVfg0L06iczVubgAyaYz4po9uabT1yChh5erfJ8qaOtov0Ls>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledugdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:jhw6ZS-6Jql7_-rzyXuoXQID0HW9BTtiWyxWSiaqRagNug49zB54Yw>
    <xmx:jhw6ZVtEW3JFdmawy6y9IVYGGJUw8n5AaalPQIqr4SCYwlzLm0hkgQ>
    <xmx:jhw6ZRF5EB8t33_YNu69Qo4eEmSuG1Gv0kmhTeHkHcSy1JPp1_pCZw>
    <xmx:jxw6Za5MA1YcibSgc4CaLVCGitWS89EhA69rpvpYeWE2yiI_rAYSRA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 26 Oct 2023 04:00:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c789c6ff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 26 Oct 2023 08:00:05 +0000 (UTC)
Date: Thu, 26 Oct 2023 10:00:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 3/5] ci: group installation of Docker dependencies
Message-ID: <a65d235dd3c14df4945b9753507d9cdab777966c.1698305961.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YJD5bq9zRa8dmnQG"
Content-Disposition: inline
In-Reply-To: <cover.1698305961.git.ps@pks.im>


--YJD5bq9zRa8dmnQG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Pull in "lib.sh" into "install-docker-dependencies.sh" such that we can
set up proper groups for those dependencise. This allows the reader to
collapse sections in the CI output on GitHub Actions (and later on on
GitLab CI).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/install-docker-dependencies.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ci/install-docker-dependencies.sh b/ci/install-docker-dependen=
cies.sh
index 78b7e326da6..d0bc19d3bb3 100755
--- a/ci/install-docker-dependencies.sh
+++ b/ci/install-docker-dependencies.sh
@@ -3,6 +3,10 @@
 # Install dependencies required to build and test Git inside container
 #
=20
+. ${0%/*}/lib.sh
+
+begin_group "Install dependencies"
+
 case "$jobname" in
 linux32)
 	linux32 --32bit i386 sh -c '
@@ -20,3 +24,5 @@ pedantic)
 	dnf -yq install make gcc findutils diffutils perl python3 gettext zlib-de=
vel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
 	;;
 esac
+
+end_group "Install dependencies"
--=20
2.42.0


--YJD5bq9zRa8dmnQG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU6HIsACgkQVbJhu7ck
PpRU8Q//U+I4oZwE6G+2gw49SV6HLCOIq78xb/YZaMRZ918mMvFZ0w1yyI4HYiMe
bu5dwRkK/6pjCEYm4pg/S7BwibV5gs9lmuRGyAnn1VMnWJ758oQ1sbkQ5yUKd8D8
6SX7QvBmQaBhHG47vnJu0QGzys8ftPchkubMCi8CW4V8vueHOFJFj4C8xL5Kjzt2
ESvBtQnveab/SPk9U1/p7hRU3qwyTFetz7Q2lYShr1UWlOftNG+oUCoFpfkoa1kU
6Rrmc2o/gIDagFSiet0EvEw38e3WKd+eOytx0R5NT2d7mH4L5GdDEli9bI78GoT5
m3EFl5zW8J4ppxnT1VlpnQyduUzfzmt6jANNs2eO9n6xXhVDEQHMSZHIEwAaIiH6
ngxaChDrf5lORyiJwcjVw7AmNwQ/zN4mk6L14BKOOAjPpNyBwXrynC0LEfJYfFom
VQ8Z/vwbMZ2ILgdl90T8BdvnPbMTpT2WvPIAAo6ss4k2tb7Utq3u+F7QXwkU2TCw
uiMueGdB16KMUzBX+YvKewOt4VPKSavEmott+sewsxbIeOBxVerBFAltDX0/DG/Y
7gY0ZbNa025FDvtWIfIb3fcA8Jm5+iRe6Pyo+tz9/lvfZo1c/hdtP/xfRRuD/Tcp
NodvD9ZANPLsvaKvoXOUQpHvn+FINDrwDH7nyFESK6UfC+kjBlM=
=w9oi
-----END PGP SIGNATURE-----

--YJD5bq9zRa8dmnQG--

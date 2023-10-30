Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD3D15E96
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VHjuVAqY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ONF1CAGT"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964FAA2
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 05:14:52 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id C504832009BA;
	Mon, 30 Oct 2023 08:14:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 30 Oct 2023 08:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698668091; x=1698754491; bh=aP
	dr+FDQJqUSn8SOprKEUrOnjm41kutOxCvKrwPcWrk=; b=VHjuVAqYgkK2G+Vbb+
	nBlKramT+Uw7QI7Ha48MVLuPj+jxrid+0D2BDz9cFgVd9YlgRjld9anaqEBAif9j
	F2znrwNk2BbnhYtoxl++Gatea2dxXWGk30KLEMEM4aSALGIbzQnaWJGx94eTovhn
	7Gv49B38a3sL98raCbpvplS6U7EdR3dz9HgdKuk+HC710LLaKkJ0lJcJ5JjPmi4E
	07MRLTW5oK9mavMgJ4BwNa8G9jrgXCodAw53eGxUCPwC49h7sHX2u7XgB+nnODJN
	D7+9m+fBpNjYUUr45MTcziBhWbhwz2NjOJxsGmciV8v9+7QuYDYLjzLgR2phzk7Q
	RpNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698668091; x=1698754491; bh=aPdr+FDQJqUSn
	8SOprKEUrOnjm41kutOxCvKrwPcWrk=; b=ONF1CAGTfpw3lz/5p3UbhZvL4FuIV
	OG99ZpujEw6ta76xX3JKVo4Y3Cjl4+R0+tug1zLJxClFMWYTecq751czUYmwg+s0
	P96fdvM304MEBC3/ic/2/ga83cHHS2CQYJOmLUDqfPkDbyUsy/RNSmBmLrxpT/X1
	3RF8kzZzuzIsSDgFnyGzt83fUPa6QudGwOCAXgSjFFJw9otUGOg0uP7unRfId7dV
	CgSOfeIIAaZ5j4BUgIWnrf55SBElH3aLcbGYZ4Pz8FglpGkBc/kzS0bDb57ZdsX7
	4+n/zWvXdKaGz2u93Fc1f8Ih+hujBD3mXJOh9p5klFSfRBHN8r8hGWbTQ==
X-ME-Sender: <xms:O54_ZRrJuInGZgbUzmijMAxf4_6KfPRnZraNLjejZuilUoOCSbljTQ>
    <xme:O54_ZToYSeCKxxJdmTE85ZWVQ70CGh2neUl9MIcmNlzV7-JdFvNVrfNexphE6Z85W
    BJDBxobZuNZbOYm9A>
X-ME-Received: <xmr:O54_ZePEu8NNK6VIzUG0V4_4h-LVcNItdCY3gHZVqvkbPijQG-Q9Iv8YtnH5PMG3oUq04bT3Ws8eXQEnaXxZS4bJ9irJshbIQsluX4zk5E6GAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddttddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:O54_Zc4y_qnrycMN5YVzXYUWva03wSmGMw-s2P-7ygOb0mujve2qsA>
    <xmx:O54_ZQ56DHkfdP5uUy9Z9xUxqCUlWEpj2S58bbiQ3sl2hQdipWcITw>
    <xmx:O54_ZUgox-m8Gh3q48gjWUra4RabvZkID-MYryrV_QXLYOIL_S1A7A>
    <xmx:O54_ZQF7O20Ay54ttP4_GJTbQkFywfl64ab4XstTNjltLw6RAVWg3g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Oct 2023 08:14:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ecd14b32 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Oct 2023 12:14:44 +0000 (UTC)
Date: Mon, 30 Oct 2023 13:14:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH v3 2/8] ci: make grouping setup more generic
Message-ID: <77798fa7a7aa084c1bbd9fc9118346c47770125a.1698667545.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698667545.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yj5tIbAKTlInbJNr"
Content-Disposition: inline
In-Reply-To: <cover.1698667545.git.ps@pks.im>


--yj5tIbAKTlInbJNr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Make the grouping setup more generic by always calling `begin_group ()`
and `end_group ()` regardless of whether we have stubbed those functions
or not. This ensures we can more readily add support for additional CI
platforms.

Furthermore, the `group ()` function is made generic so that it is the
same for both GitHub Actions and for other platforms. There is a
semantic conflict here though: GitHub Actions used to call `set +x` in
`group ()` whereas the non-GitHub case unconditionally uses `set -x`.
The latter would get overriden if we kept the `set +x` in the generic
version of `group ()`. To resolve this conflict, we simply drop the `set
+x` in the generic variant of this function. As `begin_group ()` calls
`set -x` anyway this is not much of a change though, as the only
commands that aren't printed anymore now are the ones between the
beginning of `group ()` and the end of `begin_group ()`.

Last, this commit changes `end_group ()` to also accept a parameter that
indicates _which_ group should end. This will be required by a later
commit that introduces support for GitLab CI.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 46 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index eb384f4e952..b3411afae8e 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -14,36 +14,34 @@ then
 		need_to_end_group=3D
 		echo '::endgroup::' >&2
 	}
-	trap end_group EXIT
-
-	group () {
-		set +x
-		begin_group "$1"
-		shift
-		# work around `dash` not supporting `set -o pipefail`
-		(
-			"$@" 2>&1
-			echo $? >exit.status
-		) |
-		sed 's/^\(\([^ ]*\):\([0-9]*\):\([0-9]*:\) \)\(error\|warning\): /::\5 f=
ile=3D\2,line=3D\3::\1/'
-		res=3D$(cat exit.status)
-		rm exit.status
-		end_group
-		return $res
-	}
-
-	begin_group "CI setup"
 else
 	begin_group () { :; }
 	end_group () { :; }
=20
-	group () {
-		shift
-		"$@"
-	}
 	set -x
 fi
=20
+group () {
+	group=3D"$1"
+	shift
+	begin_group "$group"
+
+	# work around `dash` not supporting `set -o pipefail`
+	(
+		"$@" 2>&1
+		echo $? >exit.status
+	) |
+	sed 's/^\(\([^ ]*\):\([0-9]*\):\([0-9]*:\) \)\(error\|warning\): /::\5 fi=
le=3D\2,line=3D\3::\1/'
+	res=3D$(cat exit.status)
+	rm exit.status
+
+	end_group "$group"
+	return $res
+}
+
+begin_group "CI setup"
+trap "end_group 'CI setup'" EXIT
+
 # Set 'exit on error' for all CI scripts to let the caller know that
 # something went wrong.
 #
@@ -287,5 +285,5 @@ esac
=20
 MAKEFLAGS=3D"$MAKEFLAGS CC=3D${CC:-cc}"
=20
-end_group
+end_group "CI setup"
 set -x
--=20
2.42.0


--yj5tIbAKTlInbJNr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU/njcACgkQVbJhu7ck
PpQfFw/9GDBuucjtpYkytjRkujjx6a4ZjTQBRmA/UdJK0B1yVs3uaZUifjTpr5ZV
ETkN1oaF5GW7kJPN5/k+2UtRxpZ6tIuLrWww9nv0FVgGEVkadfHndm25Mn4bY8Bg
JXNlERZUVpHYPszDJmCI5zj/HMSf0QeuBPEZInt47cwM/lonq5fQhnSQJvDdF1my
+5c7o9p4S7Q2pyRuEPhgsoW0TkbI/3sTsHf06lytIdslXvP4IheDkvHZkyvIbAHp
fEAxcxuoJqXcumY9veB2BtLsHzi9Q+yEl0moTFfDHGeLUukvMhJ6xTyjwHLSKMQX
kFtAiNw+p/dCp1Gya1XvoHfQgTikYAq/AQ62vQ8C+u/gzt2boYUBL9f/dybFTos5
2BYy4IZhEYyQ8AZ8pCkqnYHCtGT/IxyqB88GmrjxDx4+2AppcUolSau/VHR4CNqI
lmSWGmudKTCqPzt5XW3IAVzOvxiKvpDeSOwXG+yavDedqbu0BdLNiPFarF2eGmWe
qlLIx/JpQB17eURg+e1myQa8XX73XjqJarWl3ZCDfRREtHPhqEUskWDT8HGdmsAf
HGf0Jb7EoGV7/8Ck932N2wUScGnfT7x+gvBs+AMxh9LaeJhOtA1Yrz68nmTZBKOM
HOHSRKyB7d+Wz0LEdNbEyHolmT0gsiwazcKiMo3XkS7tj3QGXgQ=
=b2WM
-----END PGP SIGNATURE-----

--yj5tIbAKTlInbJNr--

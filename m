Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2131618644
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 08:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bZwwa/DY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QoI26bHQ"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991C918D
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 01:00:11 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 206F43200A05
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 04:00:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 26 Oct 2023 04:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698307210; x=1698393610; bh=Ba
	cV0TdBwgF9XfrN//Zw53Br5b9V+qEXQ6hAxsurEDQ=; b=bZwwa/DYSkbsoAIUsa
	THWrmwh9X7HvwtBB2LdqYZiOXWiQ+fLKv6H2WKLXb08IbhoHZlBlpzzPwQK2+Pb+
	2NviSFR3ZttX5JqZ+Ue5WzBZZbrNFgh3X450MKbBJqwELFN2H6Qx0LNUiQUzFrdU
	amwxbrq7MXUXIZG4v9yifr+oPYvMnuTi4m1Boo6QTk/cY0AntGGKUgwwJcOSQXc3
	yJcFwAM/LA/pyLJRHkuY4rhjG3ni5qEy3iW9ZzrcJC/yvxbvho0xwADPb0RLjGDO
	8yQOOc5cJQYklrDSS2NyEEsDmGJeof2UFxMXfICtkYQH3OS4LFdCV7msTGD+aGRW
	ZaOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698307210; x=1698393610; bh=BacV0TdBwgF9X
	frN//Zw53Br5b9V+qEXQ6hAxsurEDQ=; b=QoI26bHQdUuC4E6JrL/80nv4+cEiv
	DN1S5cJje2DZte1Qo+9Ql89mC+6Z522NUCirak+Hdej9F+ZG41ezhlA78BNyKfC8
	abK35IZZNkxunXud67OyXrSskMDr+HYxGFiPBH5AwOwzmBctRSr2dLHbvzRwRS2O
	pxURfDTaBpBnLcukmEjCMX/4ykhGsO2dLUvhe+OjAZUskp+ubSyIEkVq5GkMUFbM
	sMq+FQ05LMLm4JvOwWj8mtgjEZS8Q7uckKru1yjQz1VsTtmGBcbSSczkdN4nQjUz
	xhrbC11KWsirPZ176rqVoOZRAiLQ7pcTP19SGPJhD4HKFN3tmK4GAYrvw==
X-ME-Sender: <xms:ihw6ZQnkOwJsEcWl48u4qi3oFD2Z7ciSjfz4RxGAUc_x2EgONa6izA>
    <xme:ihw6Zf1JohDgyMf-qhgjg8C3O_9Z-Vk8NCGikmb29kaXDeMJQ7-DKZs1VAptsXGtQ
    T0zTJQEAStRQiaTdA>
X-ME-Received: <xmr:ihw6ZeomL3a945ZCfpWYBepj_7TqTR6XuxlQuJBOiu4cYOBU7Z_Wq82gbm73q93an_oAnheU4NGwUeFyeQdqdIOkT9KtZMnCpX-nsOtdnlAWsQM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledugdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:ihw6Zck5pb8p4QGkGCuNrM9tlx1dWUEQVDNdbb0_VLQyBqanTxEJXw>
    <xmx:ihw6Ze3009oDCVbpIkU9iHrVwrO40W2lMN6pbysJ9RermsupoVPmbw>
    <xmx:ihw6ZTvTrmvKs4AWREI6PKkdaY_XyrYPsmvLOBm_wFe4qUNFf7EX1g>
    <xmx:ihw6ZXjfNDWfcWrhoCRroQIxOf1mxq08tBumItVLCum7lMPfwLDtOA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 26 Oct 2023 04:00:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 341a2c29 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 26 Oct 2023 08:00:01 +0000 (UTC)
Date: Thu, 26 Oct 2023 10:00:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 2/5] ci: make grouping setup more generic
Message-ID: <ec390354f15604eb440bec0d3d0d817441e0f5b2.1698305961.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BRn9FQslFNmdApzu"
Content-Disposition: inline
In-Reply-To: <cover.1698305961.git.ps@pks.im>


--BRn9FQslFNmdApzu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Make the grouping setup more generic by always calling `begin_group ()`
and `end_group ()` regardless of whether we have stubbed those functions
or not. This ensures we can more readily add support for additional CI
platforms.

Second, this commit changes `end_group ()` to also accept a parameter
that indicates _which_ group should end. This will be required by a
later commit that introduces support for GitLab CI.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index eb384f4e952..957fd152d9c 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -14,12 +14,14 @@ then
 		need_to_end_group=3D
 		echo '::endgroup::' >&2
 	}
-	trap end_group EXIT
=20
 	group () {
 		set +x
-		begin_group "$1"
+
+		group=3D"$1"
 		shift
+		begin_group "$group"
+
 		# work around `dash` not supporting `set -o pipefail`
 		(
 			"$@" 2>&1
@@ -28,11 +30,10 @@ then
 		sed 's/^\(\([^ ]*\):\([0-9]*\):\([0-9]*:\) \)\(error\|warning\): /::\5 f=
ile=3D\2,line=3D\3::\1/'
 		res=3D$(cat exit.status)
 		rm exit.status
-		end_group
+
+		end_group "$group"
 		return $res
 	}
-
-	begin_group "CI setup"
 else
 	begin_group () { :; }
 	end_group () { :; }
@@ -44,6 +45,9 @@ else
 	set -x
 fi
=20
+begin_group "CI setup"
+trap "end_group 'CI setup'" EXIT
+
 # Set 'exit on error' for all CI scripts to let the caller know that
 # something went wrong.
 #
@@ -287,5 +291,5 @@ esac
=20
 MAKEFLAGS=3D"$MAKEFLAGS CC=3D${CC:-cc}"
=20
-end_group
+end_group "CI setup"
 set -x
--=20
2.42.0


--BRn9FQslFNmdApzu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU6HIcACgkQVbJhu7ck
PpRMpxAAk/6l5ShyRZK535Jj6TucnuNzKDy85pRBSk2sAAYwad/fOamh4hfH/o84
ND123El/Elh4qaLZ8S8thCHO49HsXIqTamVGR9MjAmjz/1udjDDjRPA09eHpSHal
DOI+ZnzmpZaJbcaRSYNgvOUMLpYvU9MgDA6cXLPad+23sUU5tXHKogf1Iz3hr2Rh
ElHypB8z9SZ+0s43aLWR0fiNXyRJREBAEd+rItPLp8PwexC5hI99+ZG17NqAnEnd
BSXulCstivhmAEEpWTb8gP3fJI2yVZj4uOdBDJa/oTt2yKvbzMn5ehy9FFaxBPaq
9ywnMHKgNfLeXKsaPV5j1iV8qSDHGwoDeDPThurMxvACZ7rBN7tNslXx01qc5x7a
hLKF40lzS+VXY7HkK7Ywx7gUmnXZEbjFRAWg8rJfCDY7x1knBrTg1aOVeTSqeUGA
K0kD8JQcHYkVwd7CAIOiMF+uCQ8FEqgfvO5q9nvzznjgq0Dp3NVkIowFMETHp8nN
W0p9zhtqRcolXYnw5Mz9KZdL1VFAl5zUGjNRwHw01diSgv8mhMeQ9MGW7e9q+bKf
FNuRTiIlPyNBBpHhcf5CvYvSz9SY7PwPwzaVgNRJE5z/ZrxiHDV2R6N2oSceKy8n
ScY+es+81EEQCSwV4p62O6av/8ML+9mFLCY8gnhIwURkl/OpyWk=
=IS9m
-----END PGP SIGNATURE-----

--BRn9FQslFNmdApzu--

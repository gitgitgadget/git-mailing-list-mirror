Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610CAFBE1
	for <git@vger.kernel.org>; Fri, 29 Dec 2023 07:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MzZTtxTe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KKiufb0E"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 74AD95C0186;
	Fri, 29 Dec 2023 02:27:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 29 Dec 2023 02:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703834836; x=1703921236; bh=i9gH5W3LBe
	0bZoqSCQncGAJnaw6GjU2/YA4BQ6aMEK8=; b=MzZTtxTeoOtSgwmTkIwmIGl45j
	JIs/2txFDSVwsG8muSUTiUGnoFXOG9NQq8m+BsGvCZ8tnL1Ycj6Gy7VkEnTDMIlS
	VjogOSZMgGla/enLQQBQZpYZeIFtlynPDF1BZj5L4JXULRT4dTCW2Nhcsx/f2oyF
	wb5SLcXoLOrFiW8r2SJJBWgvDhGKq1vBTqJzMzAgol7liF2S8GgLdKRIAFNG9mfn
	iWlW54oHl70xvoGyc1JJrs7SKJeGaeLSouCklhMThwIiWxEQjLwuala+ejbmrmSi
	rTkMU6dYE/RRQO+y6sxxLdE+drp68U1UCO2tHC2YsFAYd5C1fTC2HRzhjWqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703834836; x=1703921236; bh=i9gH5W3LBe0bZoqSCQncGAJnaw6G
	jU2/YA4BQ6aMEK8=; b=KKiufb0ECcA0rOkewl4QHJwlv3MpTXGYnye/uvPlOX0n
	Z5E/TIHNNsCJZ0l3PKElPs9epeI4spjtRabfCzArXXslbus9y9Kjtj6DFkmlU9lI
	jYtyuPNP546phnTiRgGNBnaKU0Xoixz7MtaoqgIY+xzJuMywlpk4tmEMAPAPrsY0
	iWN71FM2ui7fSi1+USzEBiIVLaRlQhFPXrm8F8gzEY7eZ7f6LvzgAe+M0R0P+iCV
	hdKzSeqqFkZdZIum7+n5ts41RbjVxK6Ep+trZ8fk4lx/58V5iVht2JdiRHhNx3EI
	FHgfpNfdqebF/msYdl+MIA0IuAhb7TBSHp908A+3iQ==
X-ME-Sender: <xms:1HSOZXlvc4eDKhcBDeu7Yy-yZe7hs6bRAxTOWcB2vqM8vqbWME65bQ>
    <xme:1HSOZa1Iz1tBhk0lTrZav0wrkC5D9POgCXhZ1ROiAeA_hL-_ZcPeBEm0N1kfZn1BZ
    VVT6pCBHZWjjwJIZA>
X-ME-Received: <xmr:1HSOZdq3aU_7ajugiJHVqCJkz1UQh9azWAjYdBGCJ3LRtUV3Dw5vNPAXKp1DIv8aI-wnvxKBl6XQLAp1DqQcGNGE8my1E4DAe5BLuthd62BKDYDr0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefvddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:1HSOZfmPDJndmRJ2zUaWeslCfy9aEwZcGRReHgKiJt3OdUped22MsA>
    <xmx:1HSOZV3HglcO4AAIcNYw_AocEb5ffLlTWCdE23fdKBlpXCGwBx-mYg>
    <xmx:1HSOZesMb7L1ARyEuikjQm1axjCb3UDAywH4pXTPNYZ447g6wEQsSA>
    <xmx:1HSOZTCD6tG0wBv_mB-0n3Zj2kNm4RqTiYK2ip8b2gx2S_cwU_f0dw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Dec 2023 02:27:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cefa5698 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 29 Dec 2023 07:24:59 +0000 (UTC)
Date: Fri, 29 Dec 2023 08:27:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 12/12] t9500: write "extensions.refstorage" into config
Message-ID: <2e7682b2f3b066b7e122b2ce3fcd32df0604a427.1703833819.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
 <cover.1703833818.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mpagg8ZHSP33HhU+"
Content-Disposition: inline
In-Reply-To: <cover.1703833818.git.ps@pks.im>


--mpagg8ZHSP33HhU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In t9500 we're writing a custom configuration that sets up gitweb. This
requires us to manually ensure that the repository format is configured
as required, including both the repository format version and
extensions. With the introduction of the "extensions.refStorage"
extension we need to update the test to also write this new one.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t9500-gitweb-standalone-no-errors.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standa=
lone-no-errors.sh
index 0333065d4d..7679780fb8 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -627,6 +627,7 @@ test_expect_success \
 test_expect_success 'setup' '
 	version=3D$(git config core.repositoryformatversion) &&
 	algo=3D$(test_might_fail git config extensions.objectformat) &&
+	refstorage=3D$(test_might_fail git config extensions.refstorage) &&
 	cat >.git/config <<-\EOF &&
 	# testing noval and alternate separator
 	[gitweb]
@@ -637,6 +638,10 @@ test_expect_success 'setup' '
 	if test -n "$algo"
 	then
 		git config extensions.objectformat "$algo"
+	fi &&
+	if test -n "$refstorage"
+	then
+		git config extensions.refstorage "$refstorage"
 	fi
 '
=20
--=20
2.43.GIT


--mpagg8ZHSP33HhU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWOdNAACgkQVbJhu7ck
PpR20Q/8DqzZNyL7R22JeepLKlUiEtoDyp1yLZdSneqkYn9xacz4d20P0iUZCU3I
QjjrnmvByF333KczJqhrc+qd8UGih0B3sxdapB5AFriGQLXHqvADHyxtqIHJDYS1
UFxnYeHv0y99Vt1YpFQK/fjh1m9hJ2ng/HEb2G7oTCazJCPZfq7RaU1fJAJR3jpj
7KW3AlcN46UPLjv+fQTe0I4ETr9uMpauqNExYWNt7FGWK5MXx8X5WB4f6WyktLAb
6hXpHHPyqMdE/xPp1PQtgnBxOpqPFOSW98Lx7u2J4IWbHWMtTL4Jym7y+xnnPKN7
7gMkv3PdW3GugbWqvKsu90azXRG1YPaoKNq/TytiTdYTpHeuqB/r7hN1Lp88tZJg
1jvSU9quYg8RePfyhbDx5lJP4ATdbdZwDuVscTCLpouO3p3RnwTysIUWugCdGYxs
SRpv1XILnbExiydkntxi31jWqnAOy7CBgUjWkkzANdlBIVlrmCwrL7Fd1GSQ/fP2
r2vjUYzaME70WdrF5GqHnlxn9r9sw3eavfk6X4VX68L7UJXlNmmPZYpam20pLAPS
Vx8KtFnHjKJ9AyIANYcsKUKDFFjyMTzU/AUiyGmKXmGqc2m5CVsPV6UV6UKATX7S
265s1ssAzld8aELUL/fqAybM6z72tPZWkQwCPrQ6DBSWqzRggVU=
=PVnT
-----END PGP SIGNATURE-----

--mpagg8ZHSP33HhU+--

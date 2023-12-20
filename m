Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9D02209B
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 10:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qFtWxmnQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="8qvDv5OQ"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 3DB7C5C01B1
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 05:55:45 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 20 Dec 2023 05:55:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703069745; x=1703156145; bh=UwKEfNoS1V
	nz5xVoxKTG7/5/USu9zUoOfEj0TWhjq6Y=; b=qFtWxmnQx0ydlZI2RD3iiKZBRF
	MlRsIBztUbB/zclKJbdy+tfL52+lf+lbP+oBNJEZVvb2F0AAabVKy/shpnUISV2p
	9Tyd6K0OuUK9ElzGga2HkcS/msNouM5dVYJoT8IDfkkVy5b/X994LhqMwKQpt1FO
	7drbDyyTIKgzm0V9MBBhkheOTmsj8gi1TLTmNVRjliSdHSCSDXOS7KyYWh7jLUNx
	cRCHdzVtcUQvQzQ8tdOsPQghzUWqyxxIY2oEq0BjlfSc5+J+BUJ/F961mACs52vx
	Ho71+6gkNoZGZROcCQeyS/E5FUKVafMwINn4e1Ql/2PUyvxu2Nt43BMzSesA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703069745; x=1703156145; bh=UwKEfNoS1Vnz5xVoxKTG7/5/USu9
	zUoOfEj0TWhjq6Y=; b=8qvDv5OQV+O28pwAxaIqCTTiemZFeJxwpIP9RbimqF1y
	ltZ6AeoaGDvY1LhWap+SZih1LKq0H4uRKAvbTTV2U7VQpVy8LhwFNuzOOYB28GVN
	kl44v/39geO5Ak+EWh0WNjNmev+RC/zqdjmnGoX41CJuLSwgEqmVWkVmZ7aCNV3B
	lBWDZdxAmjtcLPyd8k5/wus9hwEmWQbKQtFa4EG0DWniWbsmIwzK30BZzXcKcV5R
	Lqq62vOz/Ulks3ZzNlec2OL809VS2Ih25kM44PfQbXP9yowKHsAxk5sXl3nMSJjB
	f1ygzh1SOs965ySXliAtLTAvg6SU+jHBoZWx8btDCg==
X-ME-Sender: <xms:MciCZQrx7nXRniHMq-XA041eIrWcG0hISBPi579_gljCxenYmtqr5w>
    <xme:MciCZWq5eQxfBNO6r9xovTCHB28rCKRJoCiZWC3FT-ZyLFdtJAK-tV9ctORTF0PKm
    ac5pM0TdnnPihzg6A>
X-ME-Received: <xmr:MciCZVOGgX06M1E0JH2FiAU5ooV6Lvl3L9ZR1tZ8Jek1bIVgmMvnI4tapKdGyDblbwla6t2BKAWkLBGOU0DXnA9nfyBuhXpGdisItpMf10L1KA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:MciCZX4vPOIhDM50ie-etCn3e97GhJxQp-2fUc529gdVJwoKrUB2Sg>
    <xmx:MciCZf4wt67g7eUN2hEqjbpSdNrhOff4hXFixh4Jii823OkqPt6QTA>
    <xmx:MciCZXisEultdNcpXya07OM2CrszXnubc0GfztyRpH-Hym6qvWNdng>
    <xmx:MciCZYXv70cSKbX2uMMJfMGktRowbV96YgHGXbZo2379kuB6B5vMqQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 20 Dec 2023 05:55:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2683b519 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 20 Dec 2023 10:53:49 +0000 (UTC)
Date: Wed, 20 Dec 2023 11:55:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 12/12] t9500: write "extensions.refstorage" into config
Message-ID: <bbe2fbb15495ad6c8eb0824b4b4aaa7f3e6e2537.1703067989.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iluyBiIn36D71XhY"
Content-Disposition: inline
In-Reply-To: <cover.1703067989.git.ps@pks.im>


--iluyBiIn36D71XhY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In t9500 we're writing a custom configuration that sets up gitweb. This
requires us manually ensure that the repository format is configured as
required, including both the repository format version and extensions.
With the introduction of the "extensions.refStorage" extension we need
to update the test to also write this new one.

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


--iluyBiIn36D71XhY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWCyC0ACgkQVbJhu7ck
PpThwg//ZSUqaknW1xvPkkyGsplt2Uxs5lJQZM4puKYQGPjtSCzoKK5w9YNHa3vF
N3asGFBr1yT6smiHVBmDHaio49bmesoqugyc4eZIo4FNfK5GYj4Hn9jAw6towm13
EpJ8sCcKWTBYZcALuYrtY89caKvx/HjM+qby2w75c1F1GY9eTS8E9o61YlLEBcck
dK930RSEjEF8Ze9VWrZLCC6OdKWvNj+273mF9ZU1F4GUNnOhy5aOfus02jLljF64
gs0OzvI2Wbk2ND0QWT39fllwmdy0jzQLKaaZgNGNswvjvPj+3/BNJwCLVYOrucgx
YlpPiyEy5mF4Nk0r8jGKM3uUT5qb/KasA8YvbdI+5VgmUyQDH6Hno+wFjOASeITx
KIVl2VfkkAGvxXdoFMCRDTCwTvVkttlw9VH3/ocyCTjLUVlUV05tTin9DHnTtJiU
htytHRGEGSRLCTf87fSMyODlbAT9ascZPaC/98myhA0dFGEOHc9vFUmpWHUkTbN+
uSlsySHMAzra5tsplWRipY/IxJcf8x7vtzNNGjSvsR2gFYiRqBdYtzGjigx9Vrw3
bWfq/TlnObh4LA/aqbVoIHEaoAoR0SRRzZmIyjzUSglWFQeLm0F8gMe7yyQehgBK
bUMnJccBgjfqhGhRvSvvj69BfKTYnNum4NlI+U8PKt0aYHhMBjw=
=JuMx
-----END PGP SIGNATURE-----

--iluyBiIn36D71XhY--

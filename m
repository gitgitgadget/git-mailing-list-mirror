Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E043B1A4
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SAqKzYW5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="94ECpkq3"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 35F833200B51;
	Wed, 10 Jan 2024 04:01:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 10 Jan 2024 04:01:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704877305; x=1704963705; bh=phw41TJKeE
	FGfh1MoHP9GCVLn/dPS6G6gZWpkt9ypYM=; b=SAqKzYW5vYmZSB2VyQZ2rPz0Cb
	tvEnVE5TzKGfanhmewmjQPfMwZ618lmXpCVRn9LoBD5vSQeB7pDKm+10+vEeU17V
	Z51u6VpK6wJd9b1UASYiJ9uTBEWKRjbP1bHElrQ14D4DhK390k/kyQDms4USDwK1
	T3KTwfLpprztqsO0W/YQAaeCvZ+3CEBuifBID6JOI+PbvJFIbOBn7vfjTkQlkaJq
	Z/1FsOHpPZdoLs0AIyLQ0AMwN8nZJQ73DUu8DWxH1Y3YiRFa+T6k9aQwYtpuHDke
	fPiVZ0Q93DTkSxXGbG/RL0AoW1/vNc3BayaQpQMJNUqWFx2RkEAKaMVvG2RQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704877305; x=1704963705; bh=phw41TJKeEFGfh1MoHP9GCVLn/dP
	S6G6gZWpkt9ypYM=; b=94ECpkq3dG7Dkrr8SVsLiCnqTSMb8wyAKlEsrdk/zsiH
	QGhOV6EAZJwuVQxhRsuHKFYTDfNcSvElcXALhqHIz9vliaknV1UeF0EEEhDf667I
	g2+YZ9dpTkKc0kINjrV5hdWmMlssfsEQbuovpQmAuK6OqLPt3xOxkap4yxDRfwfs
	VZ2fybHYgoF+leWOiqyCmZoEu/gGLQVJhN1AolPwa5SE1sRmoAQhGp8vj+wzI/r/
	MF7FFZwUhVmvYB7gBCZ22wE+0gDlSG98DNNbZAZwLwxft6PWDuztOMG8kwV2PGf0
	3UPV2Uiql6xUYI1SAO0fTG1gSDHhD1ur5iNVhix+3g==
X-ME-Sender: <xms:-VyeZQVKt8tiay6gWzgvYAGIE1uOr8MlMajE24szFvS8FdhLD9GAJA>
    <xme:-VyeZUkeHUQJVhDwoTukh8PNqZ0rvs3TOImBWDOvdO46ImA3uGJXU8DvT4TVQ4x3G
    4gOIpH4_njvDu9_Ag>
X-ME-Received: <xmr:-VyeZUbTR1qgtoy79fEiwl1jNiEd_cYZpfvPWQAPXTPClLGIP3_sFMHulIKvo2Xb89Bb0aIMVKEQz-kQPmIOLioSuxa9gP3jrUOkbEQM3aMlQVI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeitddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:-VyeZfVE0bU6utBofW8lkpsu1s72RKPYhLfc5-g0MJ6b3R48WLpVoQ>
    <xmx:-VyeZak-LrKIu1IMaiKBCHu_fMub5sf-LgJZaH_l8M01LLZfgLH7mw>
    <xmx:-VyeZUcgrzwk2lXJ6K9IuCwqUq7s7UPKI6Sgqpc-1Yoj1j7-9JHvGg>
    <xmx:-VyeZesZjqfz3EL34bzSXRPKUUHXkDoUA1nFpqe2KTTT8h_TmAgkFA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jan 2024 04:01:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fe6f6c06 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jan 2024 08:59:05 +0000 (UTC)
Date: Wed, 10 Jan 2024 10:01:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/6] t1301: mark test for `core.sharedRepository` as
 reffiles specific
Message-ID: <384250fec217a806cc0f9930034f04ba2ee29201.1704877233.git.ps@pks.im>
References: <cover.1704802213.git.ps@pks.im>
 <cover.1704877233.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zt85SpZTr2UHsz6j"
Content-Disposition: inline
In-Reply-To: <cover.1704877233.git.ps@pks.im>


--zt85SpZTr2UHsz6j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In t1301 we verify whether reflog files written by the "files" ref
backend correctly honor permissions when "core.sharedRepository" is set.
The test logic is thus specific to the reffiles backend and will not
work with any other backends.

Mark the test accordingly with the REFFILES prereq.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1301-shared-repo.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index e5a0d65caa..8e2c01e760 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -137,7 +137,7 @@ test_expect_success POSIXPERM 'info/refs respects umask=
 in unshared repo' '
 	test_cmp expect actual
 '
=20
-test_expect_success POSIXPERM 'git reflog expire honors core.sharedReposit=
ory' '
+test_expect_success REFFILES,POSIXPERM 'git reflog expire honors core.shar=
edRepository' '
 	umask 077 &&
 	git config core.sharedRepository group &&
 	git reflog expire --all &&
--=20
2.43.GIT


--zt85SpZTr2UHsz6j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWeXPYACgkQVbJhu7ck
PpRvdQ//Tb3HxPdPtx1qXS+VsXkIibgSCj/8uVFLT3+YjP7GlrXuQWi6buUv5iFD
XRKZD8GTQA/q3vdxlg0I67y2C+5ppjwuUmWLYUBRl8tYq+in98z1yeUeQSQeHGyb
Sk0o8TaKFuoRJlZdmvz2eBE50ZAxK859zCjkIy0NUWmi6/FZfzbmtLEbj/oyY70K
8XVU/2F81pLBYcCIq+siOMJTzcr3o+SgwOjNlr052kmnaNcKaGeDyR2RN2RzvQyD
8bdmCBThUOmYxGCPp8z8PKp7kYpcGN/mm2i+bNmHCAxiqPJHQWOO4fc4jxjoDOiw
TcYrNVAqNrRxg4uyh7tNsilQdbAD7rfKmFackhXXZKblZiqsT7+nLhHWbg/4+QQg
kIpY1x6xt7jN4TwelM3t63chQK5ClGEgbYCqH5wROJ38zVBF4FrotS3WrVdjQA99
+xfjGirS69PVGZAgt0ZMDtXUazPANI8FSAnHDyPABZTDF6iYnwbt4Ns3rOiE94Lm
6IxToO9i9WceTUsBZMbG638q83K2glGQRuG/z3PVSBBVnzUWKfzM4T1vULyVDuyv
BZb3C0S7Rncq9TcWSuJGoIYRfVH1M4nwtwmmaWBV5qfRSI41u7g6qSj4/h9iThXR
7FhUfoakmrvAl4t6wAviGzwUKUlfNZclsQTExDuSWbMo22dfrr8=
=GKTi
-----END PGP SIGNATURE-----

--zt85SpZTr2UHsz6j--

Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a+t+tkQ1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XiMAa5KA"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECED7C9
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 23:24:52 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 6131A5C018E
	for <git@vger.kernel.org>; Wed, 29 Nov 2023 02:24:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 29 Nov 2023 02:24:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701242692; x=1701329092; bh=D9
	5v0vudcpan72uWXEUfFA1hBCQaHXQR3zF08zUZAwc=; b=a+t+tkQ1TPSTHWXU69
	ScaO5WZECc0Lp6EgdFyMbWC3B1j/u7phMvDwz05ckJz9XuMdrO9KcIlCtr42joUt
	oRS16lgXYHvaxYY4/zVzw7tEc5E+ue6s0diS9tymo+W+S/SFgQc80wdMxap+VoPP
	SgkhsV9D4EBYlMZkuTEJ1pS4oX467yOKC8brUlKT328ueYn5YfjP3cYPqjwmIqcm
	OaexUDjRG2ozv1ISXI5svdMSYPyJQ4gq5p6N1L/jaid4unJFYBhRT10KTM+J8npr
	x5P8QjeSJu8ziHOZbY8i5ig56l1SPI/kuRzZxMx9TA3re3iYxVbDY3lpGEJs7XET
	bluA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701242692; x=1701329092; bh=D95v0vudcpan7
	2uWXEUfFA1hBCQaHXQR3zF08zUZAwc=; b=XiMAa5KAlVk7yln8yBWCCsukx1VJ2
	NUYMMdSeMGTtYGgtUnRRSDZpzwnxK04qF3a7YrD4tpNizCTtXyWm88cx3G0jGof7
	nh4Bxdax+ZFljzi7EKKEpkxt9BfxMdAu5gb4hlZBOd+miUPYAcUYgCcvzK4jzYo+
	HfpuAPVrdpaVOCVtoy94QLP8jGPTYXbZ110NNS47+fmniIYtj9gf6UVYiU/bcfub
	vVoh2mfXUQ1FmVJC4+7JLDzos7YuQnhUjpqI981Leb3OMC/Bd7wn9dz+wz1E5Tyw
	cGe79jgY5Ko/R+rsp+P0TOj8uuriu7tJ+5A74tro2JDQbbCgqupWm4FuQ==
X-ME-Sender: <xms:ROdmZQSTbqYSh6jX8qdx4Z1dSE4dRn1mLrQtPD35AxyIoVwStoy-Ug>
    <xme:ROdmZdxM0HxOxql1ttUJJZRdzfKyKGKBLnfaaFk34FSbf6CCRp--JUEqwpQUDQi6S
    ANHc3PX0zeul1p6Fw>
X-ME-Received: <xmr:ROdmZd257uPoyrHKTT5RbjyaN760sD5E95HAnt_fgO6ZMEnnY6x3uAZxjiaS-BG8-MnCPEon25IjnpHZ7nkaj7pUq_26fimWWbIpeK__cspYCFBU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeigedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:ROdmZUAdQcrWt7II6EpMGULkQ-0VNYyKzEXx1Q267JSEcBrsJ2QYNA>
    <xmx:ROdmZZi4RFG1Idz-3B45AS_vi43L49LdYGaAtcLOBekYZezPpYe4fA>
    <xmx:ROdmZQrFIdVIp4lLK4L75eMFwqm5fcRX1CBTVHnlcwYwkgkV0nFXLg>
    <xmx:ROdmZTe_JqYLKwe6vESvEKFHnE3G2V0pQuIROTeGjvqjcYY6KCaJXg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 29 Nov 2023 02:24:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 856218d1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 29 Nov 2023 07:23:40 +0000 (UTC)
Date: Wed, 29 Nov 2023 08:24:49 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 03/10] t1401: stop treating FETCH_HEAD as real reference
Message-ID: <d905952a1bcbce9f1d96d303d325849901f4af13.1701242407.git.ps@pks.im>
References: <cover.1701242407.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZHpdZR1ACAmai29o"
Content-Disposition: inline
In-Reply-To: <cover.1701242407.git.ps@pks.im>


--ZHpdZR1ACAmai29o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

One of the tests in t1401 asserts that we can create a symref from a
symbolic reference to a top-level reference, which is done by linking
=66rom `refs/heads/top-level` to `FETCH_HEAD`. But `FETCH_HEAD` is not a
proper reference and doesn't even follow the loose reference format, so
it is not a good candidate for the logic under test.

Refactor the test to use `ORIG_HEAD` instead of `FETCH_HEAD`. This also
works with other backends than the reffiles one.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1401-symbolic-ref.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index c7745e1bf6..3241d35917 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -171,8 +171,8 @@ test_expect_success 'symbolic-ref refuses invalid targe=
t for non-HEAD' '
 '
=20
 test_expect_success 'symbolic-ref allows top-level target for non-HEAD' '
-	git symbolic-ref refs/heads/top-level FETCH_HEAD &&
-	git update-ref FETCH_HEAD HEAD &&
+	git symbolic-ref refs/heads/top-level ORIG_HEAD &&
+	git update-ref ORIG_HEAD HEAD &&
 	test_cmp_rev top-level HEAD
 '
=20
--=20
2.43.0


--ZHpdZR1ACAmai29o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVm50AACgkQVbJhu7ck
PpQfTQ/7BGhHiAV+YWotBMyEUSEUdCrsI6PBYS0aPDSeheEL/qqiKTzI4mEin/M3
UK+5d9uOlDg9ueYfjDnTkDydn9k5j/GFmIqQ4tzgE+TCWCb7S2sCjIbv9h3m45S9
umjLrwtJijxYCNbA7WZsmFaXzHg2ViqunF270EJ9ZTMoJxAk7bYLM0qCDYBkJaqo
AjAG9I9GKlsz8qmEI9LECIpmGlwi8njMGJGkqV7yZpbhW04HV28NyD782I39rxPp
yeHrfe/x5PCqnuuE5NznvEmlzYhPy8lKf/7yNdHnoBtmVejQ1WJV4hyfclpLSiS7
tN2YLN7PKo2N+ddl8qjBenU1+beQGj11e/2Hq58Kdwr/DfHR0nWRhR5RDWiHwoeB
qLgIyEKQC35919UlifI1m3PcHG7jcvVBk/kp+wGR0lDd4bKNQo1VwOw02lInPTor
uJgQFK4KaKpjwBqWJJia53zjiwMtQ6CDdukOx8ud5SvYWp8HVVsn9cB0vZUyJnby
OyeqnlVWDb0vOS90J5vwcs97/kJmv91vFUIk5QjYtSJ472UtRMUUV0bJToqMmOQa
G6ZtpmcbzU+taM8tDlYhmcDbOcvsUjEB/f120bk5adlLEUw90kmCjpUc9oEsV30g
3p3dxYmjefIcHFqCFHz7jIHei/GbPBVx+YbPfLQmOe6XxMAZBTg=
=rqqz
-----END PGP SIGNATURE-----

--ZHpdZR1ACAmai29o--

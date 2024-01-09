Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74D8374C6
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 12:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jhNzTK/m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xWCr7BJi"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 033A05C03AF
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 07:17:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 09 Jan 2024 07:17:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704802626; x=1704889026; bh=u8B2Gts39V
	JRNik4t75pSlaRpCTIInBcHQTFEfL6dF8=; b=jhNzTK/mPAhyFtWMDJf+QbrQpI
	2BOEa6/1aiFOmQSDlEemStNXnXBUsF9+iHlcSfqMx+9meDrZba/KgloTpKBhenX+
	WjV5RQM+g8zXLdBO+5gjI5JMLgeA7XudyrorZNm1vbAfakJXLNdMf7JRA8kJ0jPV
	97wXB9LhWur4jGONZxma1n0s4UXBBo9D3oVIwt+NwoUByQC8cTB6xn0GHRuAo39N
	35jGGzTdga4XIQwRlvTucS4tFJHGvZ3+XXQ6iLz/BaG4hL3zXxk0OUGmy7zyWPrc
	BGFg38Dk/BdeL7q/QmgY6F/G6b6OgHVp7IPW0c3OheidMWlzhz65j/HLgV0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704802626; x=1704889026; bh=u8B2Gts39VJRNik4t75pSlaRpCTI
	InBcHQTFEfL6dF8=; b=xWCr7BJirhJttwYUFqVS5F9H9jPd/eHho8nR5ixU+b16
	eCcF7HVsN52bFrTBWQuFGXAwpyT123bkjXNE0xrGkXWC3YLK6eaXto1ypcpdaSAH
	KVAz2ukP/RsMMqoHs86DCdkdANghhY3QbDHnc3OaO54J1iK13GIr8MkkDEK1x+/W
	RNOg+hWHiVqM+bh7iyEnP/tcglFJMErBmV7hYNjjTQVMFezn+hLB5f5pjHKDLB7T
	4ghJajAIRmpSnrAKQJBd8eU+Rc4WjJ9oj7c55ViDp+w7G/ue2FcN9RZ+2sGNMCEz
	gGAnkiE1usXdmd+RpwqTMl/SFPFqRKRTUOKMLSYfXw==
X-ME-Sender: <xms:QjmdZcaebiFgII8dzox3n2JcNJGMqBgTdqa5En6eNIniHhR9RfLs-Q>
    <xme:QjmdZXaaPfnVjA2WN7F9b4cnuZHC4khhd-Qp3uwGtCobmDNPhJgwbT836VKYZIJfn
    Q_eY4D2QetUEo-ahA>
X-ME-Received: <xmr:QjmdZW8gKSj95PK72-iG3LTLB_x9ZRQgvV79AfSNdeUEa5FirzcFCOyMb5FolGM9HPzDRuvYj3UGz1sY4Ckq9lwI4JlpBcX0wIKdHW8lj_Pw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehledgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:QjmdZWr13XnQFE4CdxERClxvEMDYQoT9NxVVx3l0rEQxoorTZkQHhw>
    <xmx:QjmdZXp--rPowYEd3Yri3NEGIP9O4YwOeIUm4NSYjkIAml2d35Yy3g>
    <xmx:QjmdZUQSqJQs_o-T0KQxjPcY0pOSSAjmLnc8Roud-0_J4Hg92_uOaQ>
    <xmx:QjmdZRFmsnCIbrGHqb7GJdopCxeQxYfePADpO-SlyT8oJVb5a7Yo1A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 9 Jan 2024 07:17:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 25e63ab6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 9 Jan 2024 12:14:27 +0000 (UTC)
Date: Tue, 9 Jan 2024 13:17:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 1/6] t1300: mark tests to require default repo format
Message-ID: <ec1b5bdd176e6a3f093b76b732fd9e960a7880ca.1704802213.git.ps@pks.im>
References: <cover.1704802213.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jip3F4K7cUWQHOH6"
Content-Disposition: inline
In-Reply-To: <cover.1704802213.git.ps@pks.im>


--jip3F4K7cUWQHOH6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The t1300 test suite exercises the git-config(1) tool. To do so we
overwrite ".git/config" to contain custom contents. While this is easy
enough to do, it may create problems when using a non-default repository
format because we also overwrite the repository format version as well
as any potential extensions.

Mark these tests with the DEFAULT_REPO_FORMAT prerequisite to avoid the
problem. An alternative would be to carry over mandatory config keys
into the rewritten config file. But the effort does not seem worth it
given that the system under test is git-config(1), which is at a lower
level than the repository format.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1300-config.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index f4e2752134..1e953a0fc2 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1098,7 +1098,7 @@ test_expect_success SYMLINKS 'symlink to nonexistent =
configuration' '
 	test_must_fail git config --file=3Dlinktolinktonada --list
 '
=20
-test_expect_success 'check split_cmdline return' "
+test_expect_success DEFAULT_REPO_FORMAT 'check split_cmdline return' "
 	git config alias.split-cmdline-fix 'echo \"' &&
 	test_must_fail git split-cmdline-fix &&
 	echo foo > foo &&
@@ -1156,7 +1156,7 @@ test_expect_success 'git -c works with aliases of bui=
ltins' '
 	test_cmp expect actual
 '
=20
-test_expect_success 'aliases can be CamelCased' '
+test_expect_success DEFAULT_REPO_FORMAT 'aliases can be CamelCased' '
 	test_config alias.CamelCased "rev-parse HEAD" &&
 	git CamelCased >out &&
 	git rev-parse HEAD >expect &&
@@ -2051,7 +2051,7 @@ test_expect_success '--show-origin stdin with file in=
clude' '
 	test_cmp expect output
 '
=20
-test_expect_success '--show-origin blob' '
+test_expect_success DEFAULT_REPO_FORMAT '--show-origin blob' '
 	blob=3D$(git hash-object -w "$CUSTOM_CONFIG_FILE") &&
 	cat >expect <<-EOF &&
 	blob:$blob	user.custom=3Dtrue
@@ -2060,7 +2060,7 @@ test_expect_success '--show-origin blob' '
 	test_cmp expect output
 '
=20
-test_expect_success '--show-origin blob ref' '
+test_expect_success DEFAULT_REPO_FORMAT '--show-origin blob ref' '
 	cat >expect <<-\EOF &&
 	blob:main:custom.conf	user.custom=3Dtrue
 	EOF
--=20
2.43.GIT


--jip3F4K7cUWQHOH6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWdOT8ACgkQVbJhu7ck
PpTwrg//XKOgZ0zzToqy7nyS0ddsnQIafqJtJUC50bD65xiAAdtiYHpevus5+Xfk
CFroUOYbQeGm69j3DnpaGYPHwUSfmsLB5y5Q91/vh40cZ4d/ixCOxi5jJoO32eF3
iJ14Z3qqyF+1fLf7qFgw6egc/FcUjiAVPWM/Hqlo3TATWJYpLr562ra/KFb7z0Ue
sSEOPELyGXmNiWWznAL6FNuX47jOWvlhq6GXVSIzxt7AtjuT5JitnJ7KahArcpsu
U9uWaKVwegKI0Y6oLcvGV1k5uNO+XS+8YTCaqXzbvlC0W7P5QftFXbo60UtPcxA4
PfuKtknTQDt40LrWW6yZKseeHLpb22D0f4FkU5pyTiGSs0o62UnJeT1cbe1/2iTd
ETEvgTluxwPVPeeRrT3YSCGRrjmDAKoE2SNz47eVQ+jMeGEWNB787aAfEjiETKy3
KANfDpBdxi0QyQUvs3qKUOSxXNpksK8NbLoap8rcjHn+KOiLz6sDCvwmIorg8+7r
aSi8RODsRKIykv4Mg8bmyayzqxnEYOqw5rY8NPfsoH6VmN/vgWuLSa2bpEVrRJdQ
l2LrksNAwQbARzTJ6z4dQAkorPIIDLQ3ZphQ/PxFak2/WBps7dW3QF2vBnB5j7Gw
Jxkb8Hqq7ZXUhEkR7ODZwCdWVBdqe3/oJbQ4qXmHspOXLBVs+qI=
=VOKs
-----END PGP SIGNATURE-----

--jip3F4K7cUWQHOH6--

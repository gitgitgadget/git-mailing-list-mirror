Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B7215AC0
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 10:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WhzfvldF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kY1nXb54"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 192643200A9C;
	Thu, 11 Jan 2024 05:42:02 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 11 Jan 2024 05:42:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704969721; x=1705056121; bh=ol8OE4HYDW
	5lASP1wtYeUjhXQKpbRs+9Br+A+leJj7w=; b=WhzfvldF9a7xwzIXbkmet4QipO
	ZwVqe8rRVZI1orZ5LHlQLp54PBmozGF9todDJmOvdhClVNeArW/l0z+6dSygtDpm
	kT9UOBLwfx61aaLjqs59UzPa0pBdXpHxpiBe3HzJn+/bonGGBTR98g31ZndZOZ56
	xOo72FysxkLUpQCpVljyWfdPxRxV4Yz9SoTIZPUcUqPnm6jLj61Te3sDOF5Qr3OL
	98avT6jFi/MaL6ZQjK/RQU3vkb04mKbbZto0IP2KBFZYXrXxZYF0addFKNc8umt7
	6rNxrppkkM1zWDzL1RsZ8Z42vdzIjcXLly5s7SFC8y4qUBANaHCHoaJtynnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704969721; x=1705056121; bh=ol8OE4HYDW5lASP1wtYeUjhXQKpb
	Rs+9Br+A+leJj7w=; b=kY1nXb542YG7vFtbL0OPI1oupz1UuOqcu0yYHolHB0XY
	NAtHbZMBwPr5gX9gQr5Ko1LwIWI24ihvAqZzaSOhv9/f3LeUnLZiMglIm1atsgA/
	Eqf4h9NwlaJK9l2XL/PY1rApRFF2+IEKHiGE0wyYqFFF9u2MyD+oVCRKjN1U7KnQ
	IyKQEJQM5YI7cTLmm9WD1IzD1KvWIBqtDFR5CrpRhtnPE64BgEB/OmWSGBIAp6n9
	OCWkAq3WxEFFzkKm8WLOYGMdzKRtY6KMfSJoSE+hJpvaXtQjT/gJxtCBPUHsmrtF
	t0x+kiT62VWULipZQsKUM+sZwBi6iBHF/gib7GBXUQ==
X-ME-Sender: <xms:-cWfZYC2kIG6rLGsH-oqhWO7UpvT1jUTgpvEsgBFt2rdPozXhRL0nw>
    <xme:-cWfZajQirR4rbh5zRop7VldtbOE8qvCqf5CWaIB6SMygcHJUUhnwsV38Z4DE4nPF
    TjRk4UkZ4MBdRaAXw>
X-ME-Received: <xmr:-cWfZbkf0pjQVnJV0KItAebccEwjbqU044-oJd_jVf1v0S-wcRNt6i3Y4kehnnQY5K4Y5WWIUJond2bakKpmc6v12wxmlDFhf_BhB2JX0TW9CRVpHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeifedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:-cWfZewjZ8vjXLkX2o-SBLZ6VzqclOhER4yTiH3IQyfjzYFyeSzIMg>
    <xmx:-cWfZdQXBEfcYz5UAnEeu_-U4HMb0yNADNK9fKUcSVVqaAjGDPw4hQ>
    <xmx:-cWfZZY5fTplrDoSyce-5AxITwYeDnYxu3DH_WgDByIjzzDSlfqOCA>
    <xmx:-cWfZe4a1NnAmMu8vZ-zSYaVFbOPc5qIzaSG2K_5XNJcqD7oVqC_YQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jan 2024 05:42:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7c75b04e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jan 2024 10:39:19 +0000 (UTC)
Date: Thu, 11 Jan 2024 11:41:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Stan Hu <stanhu@gmail.com>
Subject: [PATCH 2/2] completion: silence pseudoref existence check
Message-ID: <24563975fca8df6ae73917e9ee3534933d47c429.1704969119.git.ps@pks.im>
References: <cover.1704969119.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y0I6TvBtuyYQ4DSe"
Content-Disposition: inline
In-Reply-To: <cover.1704969119.git.ps@pks.im>


--Y0I6TvBtuyYQ4DSe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In 44dbb3bf29 (completion: support pseudoref existence checks for
reftables, 2023-12-19), we have extended the Bash completion script to
support future ref backends better by using git-rev-parse(1) to check
for pseudo-ref existence. This conversion has introduced a bug, because
even though we pass `--quiet` to git-rev-parse(1) it would still output
the resolved object ID of the ref in question if it exists.

Fix this by redirecting its stdout to `/dev/null` and add a test that
catches this behaviour. Note that the test passes even without the fix
for the "files" backend because we parse pseudo refs via the filesystem
directly in that case. But the test will fail with the "reftable"
backend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/completion/git-completion.bash | 2 +-
 t/t9902-completion.sh                  | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/gi=
t-completion.bash
index 8c40ade494..8872192e2b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -146,7 +146,7 @@ __git_pseudoref_exists ()
 	if __git_eread "$__git_repo_path/HEAD" head; then
 		b=3D"${head#ref: }"
 		if [ "$b" =3D=3D "refs/heads/.invalid" ]; then
-			__git -C "$__git_repo_path" rev-parse --verify --quiet "$ref" 2>/dev/nu=
ll
+			__git -C "$__git_repo_path" rev-parse --verify --quiet "$ref" >/dev/nul=
l 2>&1
 			return $?
 		fi
 	fi
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 78cb93bea7..b14ae4de14 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1927,6 +1927,14 @@ test_expect_success 'git checkout - --orphan with br=
anch already provided comple
 	EOF
 '
=20
+test_expect_success 'git reset completes modified files' '
+	test_commit A a.file &&
+	echo B >a.file &&
+	test_completion "git restore a." <<-\EOF
+	a.file
+	EOF
+'
+
 test_expect_success 'teardown after ref completion' '
 	git branch -d matching-branch &&
 	git tag -d matching-tag &&
--=20
2.43.GIT


--Y0I6TvBtuyYQ4DSe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWfxfYACgkQVbJhu7ck
PpTlHBAAg5oxASXYxTgLh4UB6mxIF0yKpGF7Y+VY2iWPkCcw33O+D/1y+/uITIAh
MmIkq/fcJVzEeUZEG3VKQZwfjBHNnWDO4cb7OgMfG+wLufpHnAOl62SDPOFMXDXU
/jAZObXYxixhQiFf+EbHPruREI2ztb+uYoYj9goyX5x0d/oJ8xsjCA0v9wGtOR+U
VM6JnulzzaRPcwyro+2CVaLildxdzmYIm5324bMaGkmn45DbZ6Gw2L4slsGfZ97i
QYUq6d2tCXxmEWII2ihgaPE4MNabZ7bx+/QgfCwgbCR8ZkGqAxOtj40r4vMs50H+
AX/yFIrQiI2xKqlzkslHx+CIywlyG5n72owEPfw03X31LAQ17eFeUbvokKUSfEcQ
RCQsGugEZJF1Rl4ptRdcaivGBCDF3fj2Ggxicby4X/zDBWk5fJnMuvnTb0wlZxzb
6AN57nv5D1+1cuKDpvJnVGyZoFKiktPoThXAR1+rsct41eIiNeU4RDvx5bc2Atwu
8sluD3Y8jfOqHYkfj8frTmQtA4UBGuS1DrfXboHyXsvo943tSRgQGg9+ai5F4B+5
g2eyXAWkrD/jziCnq1fIZL1QjebczjmRNdr2LwIkk3iCUuguRqt5AQoUxPWDRpc5
V3lJpKTV4uyHTVlZqgIku0vKjigGDFqMTa4eEtBhA95PfAsPc18=
=N0x0
-----END PGP SIGNATURE-----

--Y0I6TvBtuyYQ4DSe--

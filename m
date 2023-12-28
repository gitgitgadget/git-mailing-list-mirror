Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA2C6ABC
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 09:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AWW3c+BH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0wq8JwId"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id A59365C0080;
	Thu, 28 Dec 2023 04:57:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 28 Dec 2023 04:57:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703757457; x=1703843857; bh=HK22ZIT2vO
	p/SuYOWORykKAZuvADvA/vueO80xD+kNo=; b=AWW3c+BHP/DsWj+1FSkKrCOoeo
	ewztksueEMReF8o06xEsMHrzNy6BbtWHftHRsiINcP7XDo16HgPBuo9tXwkZEzq7
	RVGmJF8ViPCHVJjQYiunn4/d8d8WJGlsFu+qvRsKeJkxtpySAepGgcxixH+2cu8g
	vraUcpT+ocHtgCxAYZPHx3d/quyvQx9+5kEfrQSr/4b8oz7WlYKP6Y7jA1X9OnK2
	1NXJiQjna87i3kcD/RAGxpZFHq/BSKqzwI6zCZ5wrBfBn9413PH1YI3dym+lHnjt
	f4vQ/QLyfaALEYU5xXxa9MnQ1UgFwxPmWzGkq95i2Zjs4/gpZUXgpyeRxebw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703757457; x=1703843857; bh=HK22ZIT2vOp/SuYOWORykKAZuvAD
	vA/vueO80xD+kNo=; b=0wq8JwIdPBovBGze7f+cpW6e3r5/ZMaPQ9THXr9qMlvL
	lqjYT2vo6Znqvlsuid94XoyalhK9AB1cUEjRVy8JGsZrPW6cSyrfAlEUEm6PPO68
	jBieLQ9cnH336HYxBpgg0bYmPgPoNW/ToAfYFyQnlkki1eyCIiB2ji/92K9ufVVf
	GeM88l3SX+17D5CqTc6Z0P7xyrytjpN9HjoIl9NT9C5ABq6OgbVVwzPJOkrKUiTn
	L5LpKJaeLz527sBrSB2kvDyREFxyHLvnvx/AGt+KnF3JQW/ylOWLuxWMq5/hsYWg
	msasPfk/xiUaNeloJfA6pWcjf2WhPmAM+wlWF+JJOQ==
X-ME-Sender: <xms:kUaNZX71qzthntYrEIBQOsGd13nipHmKdB3x0r5QslfmZuKCvpRNhQ>
    <xme:kUaNZc7W5MLxX_GUsVOTlt6gIIOT1o1vG_SxvgrHAunvjsoET9GqQqcDuLkKfe85C
    gEvRwl84aFWRAI1yw>
X-ME-Received: <xmr:kUaNZefhtDXx8gzcamvzbD2E0tMj95gP8N5bB-sA1wzaaOsiuPIXxrj3GZAe6t2mcLToctPp28kfTS2kCfWIWnyz02MiIKqMeiHyTdQIZkvCfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefuddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:kUaNZYIl0TiUZFg0-j5iAvSAovx4L4PxAjgBHEINwghSdPyYdItb0A>
    <xmx:kUaNZbKI26RimfTSHT1kNchBcUr5zADLLWbLbUGVydEwl6z9eeCGIA>
    <xmx:kUaNZRy8R08V19Vim-UZkBYMz7SePvMORFSM_j5L4tVFrSvgb88j6A>
    <xmx:kUaNZRifYn4YZmPIhGVkOlOoihbmeGauRv9xc4Ods-EZ87VTNo9D5A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 04:57:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6a85214c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Dec 2023 09:55:15 +0000 (UTC)
Date: Thu, 28 Dec 2023 10:57:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 01/12] t: introduce DEFAULT_REPO_FORMAT prereq
Message-ID: <3613439cb7c40054111998da9fb8dfb2d5c46a72.1703753910.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
 <cover.1703753910.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dqznG6mz/LRUiThc"
Content-Disposition: inline
In-Reply-To: <cover.1703753910.git.ps@pks.im>


--dqznG6mz/LRUiThc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

A limited number of tests require repositories to have the default
repository format or otherwise they would fail to run, e.g. because they
fail to detect the correct hash function. While the hash function is the
only extension right now that creates problems like this, we are about
to add a second extension for the ref format.

Introduce a new DEFAULT_REPO_FORMAT prereq that can easily be amended
whenever we add new format extensions. Next to making any such changes
easier on us, the prerequisite's name should also help to clarify the
intent better.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t3200-branch.sh | 2 +-
 t/test-lib.sh     | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 6a316f081e..de7d3014e4 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -519,7 +519,7 @@ EOF
=20
 mv .git/config .git/config-saved
=20
-test_expect_success SHA1 'git branch -m q q2 without config should succeed=
' '
+test_expect_success DEFAULT_REPO_FORMAT 'git branch -m q q2 without config=
 should succeed' '
 	git branch -m q q2 &&
 	git branch -m q2 q
 '
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 876b99562a..dc03f06b8e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1936,6 +1936,10 @@ test_lazy_prereq SHA1 '
 	esac
 '
=20
+test_lazy_prereq DEFAULT_REPO_FORMAT '
+	test_have_prereq SHA1
+'
+
 # Ensure that no test accidentally triggers a Git command
 # that runs the actual maintenance scheduler, affecting a user's
 # system permanently.
--=20
2.43.GIT


--dqznG6mz/LRUiThc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNRoYACgkQVbJhu7ck
PpRPIxAAiOQxsJ+4EX4Kan/VKiVRvltsOgpuyjntET5U2J/VCLeDy0tkRp0s3+os
m9/BAQE70BD7SLoSN2lQV1ZK/CvpFaVjXssQvq5X9iuc8F7Go0H9OVWEMSAVTmMw
1nnqJIqYNErFV/jDCV1PtxFJUsJklHLmqZEseWZczeEte0sa5SqEy8LJkDkBDuK8
NHi+WqR48bHBVQrIrMAtrVj59+W3fU8ceR2FkWu4z918m5ixbn0zr5rLpse2kHPC
uL7FKwqhGqLGC+XzcNhgHBWf78m7K2/JeYzqcUIdE7X8bXHMY8VSkOEDl/aMEjdp
XG7IXHx74YngydxlCKMLPVWfONCRObztJiD4yjt1YybEP0TERjEH3ZFIKKRyBvCm
RDeSxS1tn8T+ShuX8SHuNohGkJXecRsPy32HpSzIYlzeLKxLpml63hHMiGDveNrl
LO3F1UCgFOdsGzhJA6WpwF6jxfeM4LVO9idFU7phc6QO4pYKqHMdoSaT4/PIOgrs
vSIni2IN2vxOYAGTctChc0ueoOGJJokoLhLiJHiLjWefCXiGCXki22T0GHoO1fWu
G8cQ3Mrd7SWYxhxcW7NmYfSKiiBeljqKOiyHAJd+s6ahJwMy8yxd/0oXwX2zgJUb
/gDVM1Luqe9bxaoZBiWnIaFkwDmPhcKyvbNF5/j1v0W4PV+CVvM=
=AIOf
-----END PGP SIGNATURE-----

--dqznG6mz/LRUiThc--

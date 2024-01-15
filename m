Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E5A1E86B
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 10:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LHvhu4MI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sjM0GoZo"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 66A8D5C0129;
	Mon, 15 Jan 2024 05:36:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 15 Jan 2024 05:36:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705314961; x=1705401361; bh=/D4chCHc7I
	ayETMg/xYJnlNXiRWeNoreSBjnfRG29Cs=; b=LHvhu4MIQYIBFNBIYfUOIgVyqN
	6yWzeMgLTKdpPuxmcthaku1kUp9L0mcX8yE/V3jRC5chr3+zhE/Xn8HtEGnYzwrS
	Misa+b86Iz9rlm7iNgcsWS9PSQiffHQgPJoSRxVEDXLdNeVtispnQXec6cLKbpQN
	6TYrBoQ8jZNVyHbWLd5IK6Z/2TWLuWuZ66g0ely/H1grhJvzn9xI85JnqoXh9tpw
	HH68Qu49LfPBvZbHBKMDCybUezJNGiJVwb8//4u5/t3T9R1hr+p4OOeIXUQttNy5
	lR4jYbdDbVON7SNddmtasRFrXy7AxiuSvQVMXRxnluqVDVOUfO3XkcPaYz8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705314961; x=1705401361; bh=/D4chCHc7IayETMg/xYJnlNXiRWe
	NoreSBjnfRG29Cs=; b=sjM0GoZo35B+VHIJFpaaYEMEGxrQfVZjh9xt+au5MOJq
	ypVnvWyux4lP6Ta1hLPLm/qjXyLQp+lrmhMfLwxXeW3T+k+b3bdZmkIgI7khirX9
	GivtaxkQtDiKV8P+r/l0DwHXBxh8zMOwi22eaK8uWX8AhPaKk6vRWGwn2sN0ELsN
	Y2T6THp6d0G1n6KsVD/gAXsD4QmISETzgDxgktUapOxPUJUjxSehjr61xp9Ac1n2
	nKNfSQniubB2fQpeLC9d0qqGrMEDYX57vjSZ4sw7X/AxHiqEYnI7YROpXJ7BdF4I
	v1i5OLV99bYHRe1LBPrDyxRpos5ewWjJ7Z012E72LA==
X-ME-Sender: <xms:kQqlZT82AtHT2oLEV84IztYNBh7qMbapbGMFC-HjQFdxKk7kvFakVg>
    <xme:kQqlZfvOt-Z7RqIr6XN0jIg-Tei_augQ6Py-9Mz4q1XG0SOww8mu0IPP7KSLkaXBH
    495ujGMIfWdlWJSYA>
X-ME-Received: <xmr:kQqlZRD7_NBVkToh4ReN8ZPBKXRzkRO4Blr8OOhhjt6mes_z1n1Smz3zcT6Q2zxRv56DEqynYVhq3mJIV0HDMokO7RE1VsjTFjZg3BeDz5TDAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejuddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:kQqlZfex6twBeUuLA19P-X7bFYunATifvaTgeFjrqJGEp1V7NmLsFw>
    <xmx:kQqlZYN0yWknIL5NvhQYmcpns-iiGFa7uSYiMn5QyJd18X3EPiDTdw>
    <xmx:kQqlZRnqHo0-afNE73Fk6EpcgHw54eOMwZzA2YLEez6ekA6pg3HujQ>
    <xmx:kQqlZVp968_42_-8kcXjfi5YyqphZ6GdRIXdpe9gb8NXXb_XiAzNWg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jan 2024 05:36:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 85304bf0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jan 2024 10:33:09 +0000 (UTC)
Date: Mon, 15 Jan 2024 11:35:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Stan Hu <stanhu@gmail.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/5] completion: discover repo path in
 `__git_pseudoref_exists ()`
Message-ID: <8b6a45664a210ca5a18810fc6a8ff95823f92390.1705314554.git.ps@pks.im>
References: <cover.1704969119.git.ps@pks.im>
 <cover.1705314554.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TYmP2aJzlIu1Pdci"
Content-Disposition: inline
In-Reply-To: <cover.1705314554.git.ps@pks.im>


--TYmP2aJzlIu1Pdci
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The helper function `__git_pseudoref_exists ()` expects that the repo
path has already been discovered by its callers, which makes for a
rather fragile calling convention. Refactor the function to discover the
repo path itself to make it more self-contained, which also removes the
need to discover the path in some of its callers.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/completion/git-completion.bash | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/gi=
t-completion.bash
index 8c40ade494..06a9107449 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -138,6 +138,8 @@ __git_pseudoref_exists ()
 {
 	local ref=3D$1
=20
+	__git_find_repo_path
+
 	# If the reftable is in use, we have to shell out to 'git rev-parse'
 	# to determine whether the ref exists instead of looking directly in
 	# the filesystem to determine whether the ref exists. Otherwise, use
@@ -1656,7 +1658,6 @@ __git_cherry_pick_inprogress_options=3D$__git_sequenc=
er_inprogress_options
=20
 _git_cherry_pick ()
 {
-	__git_find_repo_path
 	if __git_pseudoref_exists CHERRY_PICK_HEAD; then
 		__gitcomp "$__git_cherry_pick_inprogress_options"
 		return
@@ -2966,7 +2967,6 @@ _git_reset ()
=20
 _git_restore ()
 {
-	__git_find_repo_path
 	case "$prev" in
 	-s)
 		__git_complete_refs
@@ -2995,7 +2995,6 @@ __git_revert_inprogress_options=3D$__git_sequencer_in=
progress_options
=20
 _git_revert ()
 {
-	__git_find_repo_path
 	if __git_pseudoref_exists REVERT_HEAD; then
 		__gitcomp "$__git_revert_inprogress_options"
 		return
--=20
2.43.GIT


--TYmP2aJzlIu1Pdci
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWlCowACgkQVbJhu7ck
PpRtSxAAkOJzTneRYIY/7B2RGKXNXKxzu+XRr4iG1uJaY1pPf9GBqMZUBp9R6//t
smdfBrjA95lXlkjWE8uhi3ONIuR2qgH9bZt/yvprKTBh1wJpGVJC29cFjqUSvRtA
I9XEBjDkxkBrLlc7Xqa8/3viTCGN+9Hj6dathU1CpjUkuUEe74yWlcO5w4ihMgU1
bgqhTEynzmhQOZpGCosn+im7r8JYQ0q+dmpPBmuhq29I7vQbv3Gcxbhm6E0r53Tj
cyMiAghU0Scu1wl5gol7Ou/L7zE3womRChYdrUxJHEzIC03sAabm9D5uUlETXfQ4
7MUTz+XOxAROwnOQ+MIzOjF69r390+KcMQzcb23XJEp0bbhdLDb4YaF634T8toLb
N2zLi3jD7oUYcxKE+/Rr/BKd37r1bc3FVmUU4DCtmVigHNXT9STbHaRot7XKTk4V
A1G3/FE/M5WzEp6KYFljVk9Du/Hgh4qH0bd4xwxUaS4rTUQBizXQSy+sAf1IdzcX
QwsQ59rL/kPED9On7t0sqL2MqWJHDgRLIwt4195GCekv/PPIVF4JBFzzEdu6Q1ZI
Ff5zztN2H4jjWJpI+PJBIi6fWz6OSQBgFR3GlUpyFgrv29HhDLXhhoWLL+0lx4DW
FWLdYOidBqXrY5nENlmVHyGn+zobL2yaOPVObvNd7mFD10phsj0=
=GskQ
-----END PGP SIGNATURE-----

--TYmP2aJzlIu1Pdci--

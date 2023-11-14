Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2CA16412
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 10:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qofN1KD1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cYnztU2A"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E09191
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 02:23:10 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id D9D0E5C02A8;
	Tue, 14 Nov 2023 05:23:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 14 Nov 2023 05:23:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:sender:subject:subject:to:to;
	 s=fm1; t=1699957389; x=1700043789; bh=d0aDP6QK1WMPGk4EFO0NvsMo/
	4gp+CvJe6P200UE8Pw=; b=qofN1KD1DXBMg1avUFNyXeiPKXOgw1iS+kgn1Boxf
	BuP6C6Y23jeERF95jB0iqH+XLYut1IFPiIQqnizl2OpOF58RMtAr3EuvyK8uFG2O
	4zEnL9ccO2Qb6ambyP8dZlydcs5zgX17Z7CiH0mRmr+qbcTsgoIFxZZMkzJqjPta
	YAfFkCDAo1UARc6OfopEiYAio/e80p8Y2vryA3JineTHKmqagJpsZpa40rqSnpO6
	Ii0oFnM7exCFuaOvo8M9UvsxYzqaApnuMY1/7ESvBklz99EK+oqs6ceKwODXCtRQ
	4zcvij8xV67TuaTNYhMyQqW0/rhUCB0iUOWBLLUid/kog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1699957389; x=1700043789; bh=d0aDP6QK1WMPGk4EFO0NvsMo/4gp+CvJe6P
	200UE8Pw=; b=cYnztU2Ah2wh1knzpcnkgsLT0gv8tyZA/WLyE+HOonJWnwR7Tdq
	6uK/xtWumS906gRmZaS6f7zUHUA0a13pHW+yAyFTp4tb9VTLDPV/Aec9IJverpiB
	vcbPrHEu7M1pktxiVj8Pxeee4nY6B8Ucea1LCbkAhIFu4SygNYoiXFINdE0o/hjN
	Re7TX/5qUxi/wz/bup/+DXQRUzRAGxHwOtEmIJnEd4apCSkGTy5S3FcoEzJ9O7/v
	WXDCNiwrr4Q132ivlcHuX7ktMC1M17sp3psm5tmXp4mNXU7ZymM2waMTvMnsREaa
	rsRLBJkPD3DxWxh0+y57rSiJVNCXUEfn0ng==
X-ME-Sender: <xms:jUpTZYXbd3VVIJP7kSV-16t4plC2_aM0im-j4sWbd9cF2KKnrIURIA>
    <xme:jUpTZckR1K-1yBnUzCFw5fcbqWqV6xeCg-kKBzthK9wmL1xwGNsn06x6UFW8_cFRa
    -bgMG4Sztr1tJ6JeQ>
X-ME-Received: <xmr:jUpTZcaA8g8Ytt_rNLCzVU9-0a8rzQlpDdg-WyPLYiI4Vu0iOnxzsAXZbxmpZZp2epFvppJQg6nw9OfHeelF91nbmKhoFvih5BWMCCDJQ6MWFSY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudefvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkgggtugesghdtreertddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvedviefgieektefhvdeliedvtdefffeigeeugfetfffhkeeilefhgfelleejjeejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:jUpTZXUkXlmZBxXhKU8R85Pz_kRAcaERFZcVt76rNlNhBf-RQllAxw>
    <xmx:jUpTZSlo9u9CkoJw9QwXlEE2b8WaaH4Y7td41MdRtV-xTERYsVkQ3g>
    <xmx:jUpTZcfLMaLBjX6FHJ29sgekoUEuBSvHWAMFkIvfMBLnIBEkpGLl1g>
    <xmx:jUpTZXzxLDsEoTBFJXQ36iTIPXbM2nWaA3aIkYg6frT4zA0qsO_mVw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Nov 2023 05:23:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 459c6ffc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Nov 2023 10:22:29 +0000 (UTC)
Date: Tue, 14 Nov 2023 11:23:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH] commit-graph: disable GIT_COMMIT_GRAPH_PARANOIA by default
Message-ID: <7e2d300c4af9a7853201121d66f982afa421bbba.1699957350.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0ofDRjFb8S/24D2i"
Content-Disposition: inline


--0ofDRjFb8S/24D2i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In 7a5d604443 (commit: detect commits that exist in commit-graph but not
in the ODB, 2023-10-31), we have introduced a new object existence check
into `repo_parse_commit_internal()` so that we do not parse commits via
the commit-graph that don't have a corresponding object in the object
database. This new check of course comes with a performance penalty,
which the commit put at around 30% for `git rev-list --topo-order`. But
there are in fact scenarios where the performance regression is even
higher. The following benchmark against linux.git with a fully-build
commit-graph:

  Benchmark 1: git.v2.42.1 rev-list --count HEAD
    Time (mean =C2=B1 =CF=83):     658.0 ms =C2=B1   5.2 ms    [User: 613.5=
 ms, System: 44.4 ms]
    Range (min =E2=80=A6 max):   650.2 ms =E2=80=A6 666.0 ms    10 runs

  Benchmark 2: git.v2.43.0-rc1 rev-list --count HEAD
    Time (mean =C2=B1 =CF=83):      1.333 s =C2=B1  0.019 s    [User: 1.263=
 s, System: 0.069 s]
    Range (min =E2=80=A6 max):    1.302 s =E2=80=A6  1.361 s    10 runs

  Summary
    git.v2.42.1 rev-list --count HEAD ran
      2.03 =C2=B1 0.03 times faster than git.v2.43.0-rc1 rev-list --count H=
EAD

While it's a noble goal to ensure that results are the same regardless
of whether or not we have a potentially stale commit-graph, taking twice
as much time is a tough sell. Furthermore, we can generally assume that
the commit-graph will be updated by git-gc(1) or git-maintenance(1) as
required so that the case where the commit-graph is stale should not at
all be common.

With that in mind, default-disable GIT_COMMIT_GRAPH_PARANOIA and restore
the behaviour and thus performance previous to the mentioned commit. In
order to not be inconsistent, also disable this behaviour by default in
`lookup_commit_in_graph()`, where the object existence check has been
introduced right at its inception via f559d6d45e (revision: avoid
hitting packfiles when commits are in commit-graph, 2021-08-09).

This results in another speedup in commands that end up calling this
function, even though it's less pronounced compared to the above
benchmark. The following has been executed in linux.git with ~1.2
million references:

  Benchmark 1: GIT_COMMIT_GRAPH_PARANOIA=3Dtrue git rev-list --all --no-wal=
k=3Dunsorted
    Time (mean =C2=B1 =CF=83):      2.947 s =C2=B1  0.003 s    [User: 2.412=
 s, System: 0.534 s]
    Range (min =E2=80=A6 max):    2.943 s =E2=80=A6  2.949 s    3 runs

  Benchmark 2: GIT_COMMIT_GRAPH_PARANOIA=3Dfalse git rev-list --all --no-wa=
lk=3Dunsorted
    Time (mean =C2=B1 =CF=83):      2.724 s =C2=B1  0.030 s    [User: 2.207=
 s, System: 0.514 s]
    Range (min =E2=80=A6 max):    2.704 s =E2=80=A6  2.759 s    3 runs

  Summary
    GIT_COMMIT_GRAPH_PARANOIA=3Dfalse git rev-list --all --no-walk=3Dunsort=
ed ran
      1.08 =C2=B1 0.01 times faster than GIT_COMMIT_GRAPH_PARANOIA=3Dtrue g=
it rev-list --all --no-walk=3Dunsorted

So whereas 7a5d604443 initially introduced the logic to start doing an
object existence check in `repo_parse_commit_internal()` by default, the
updated logic will now instead cause `lookup_commit_in_graph()` to stop
doing the check by default. This behaviour continues to be tweakable by
the user via the GIT_COMMIT_GRAPH_PARANOIA environment variable.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git.txt   | 6 +++---
 commit-graph.c          | 2 +-
 commit.c                | 2 +-
 t/t5318-commit-graph.sh | 8 ++++----
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 2535a30194..6c19fd1d76 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -917,9 +917,9 @@ for full details.
 	avoid issues with stale commit-graphs that contain references to
 	already-deleted commits, but comes with a performance penalty.
 +
-The default is "true", which enables the aforementioned behavior.
-Setting this to "false" disables the existence check. This can lead to
-a performance improvement at the cost of consistency.
+The default is "false", which disables the aforementioned behavior.
+Setting this to "true" enables the existence check so that stale commits
+will never be returned from the commit-graph at the cost of performance.
=20
 `GIT_ALLOW_PROTOCOL`::
 	If set to a colon-separated list of protocols, behave as if
diff --git a/commit-graph.c b/commit-graph.c
index ee66098e07..a712917356 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1029,7 +1029,7 @@ struct commit *lookup_commit_in_graph(struct reposito=
ry *repo, const struct obje
 	uint32_t pos;
=20
 	if (commit_graph_paranoia =3D=3D -1)
-		commit_graph_paranoia =3D git_env_bool(GIT_COMMIT_GRAPH_PARANOIA, 1);
+		commit_graph_paranoia =3D git_env_bool(GIT_COMMIT_GRAPH_PARANOIA, 0);
=20
 	if (!prepare_commit_graph(repo))
 		return NULL;
diff --git a/commit.c b/commit.c
index 8405d7c3fc..37956b836c 100644
--- a/commit.c
+++ b/commit.c
@@ -577,7 +577,7 @@ int repo_parse_commit_internal(struct repository *r,
 		static int commit_graph_paranoia =3D -1;
=20
 		if (commit_graph_paranoia =3D=3D -1)
-			commit_graph_paranoia =3D git_env_bool(GIT_COMMIT_GRAPH_PARANOIA, 1);
+			commit_graph_paranoia =3D git_env_bool(GIT_COMMIT_GRAPH_PARANOIA, 0);
=20
 		if (commit_graph_paranoia && !has_object(r, &item->object.oid, 0)) {
 			unparse_commit(r, &item->object.oid);
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index d4fc65e078..4c751a6871 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -909,10 +909,10 @@ test_expect_success 'stale commit cannot be parsed wh=
en given directly' '
=20
 		# Verify that it is possible to read the commit from the
 		# commit graph when not being paranoid, ...
-		GIT_COMMIT_GRAPH_PARANOIA=3Dfalse git rev-list B &&
+		git rev-list B &&
 		# ... but parsing the commit when double checking that
 		# it actually exists in the object database should fail.
-		test_must_fail git rev-list -1 B
+		test_must_fail env GIT_COMMIT_GRAPH_PARANOIA=3Dtrue git rev-list -1 B
 	)
 '
=20
@@ -936,9 +936,9 @@ test_expect_success 'stale commit cannot be parsed when=
 traversing graph' '
=20
 		# Again, we should be able to parse the commit when not
 		# being paranoid about commit graph staleness...
-		GIT_COMMIT_GRAPH_PARANOIA=3Dfalse git rev-parse HEAD~2 &&
+		git rev-parse HEAD~2 &&
 		# ... but fail when we are paranoid.
-		test_must_fail git rev-parse HEAD~2 2>error &&
+		test_must_fail env GIT_COMMIT_GRAPH_PARANOIA=3Dtrue git rev-parse HEAD~2=
 2>error &&
 		grep "error: commit $oid exists in commit-graph but not in the object da=
tabase" error
 	)
 '
--=20
2.42.0


--0ofDRjFb8S/24D2i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVTSogACgkQVbJhu7ck
PpS7Dg/9EedJ8jrNlbwkA7ZzJectWbeJSqgYCKohi7Z/TBkK1UNmiRNCQpPcx0jd
bbSguzKM3xw+sy4q1K9SuW3EN+vDsaP1zZHqHQ6UFVvjHznpq52ZL/XWqY+byDqJ
SONpS+1GqMXCzmbViLPc32sxZHNfg/u44mEz6dBCdQGrFDA1yzLXcLibfG9HH7dJ
a/KBibvOLPNC9lx/8lSWZPIVEqqrc8MKSMcB+QgHI2eXt3Ty6TBX7sFrfcF57pOG
iGRh/1Pwbjj/xalGXo7N0PFVfFTvd7a5dVD1SbfA/kg4J8qUKG729Kso2mPxPJg+
qkjnY721LuM6NhuLMyAw29o3tbXQxnof6ylMpPUZ62kKjf9mhn3d5iCZyrs/mmQw
612lxeIWNQsYelhKyCHdxGm6Nt7y+WanC46Xz9ElrJtixiHhQV5wiGxWS9zec+rO
xTigfJ2gVNPpD7WW/8lw3f5qH/869Qt5x0lddemFgYlElPcKbvJ6QYXMWsEZPYbv
wUVxx23IMuewjsbJrETvyUB8pbxC5vjNa9G1z332wCyj4fhoDZ8uGQeVw5P0rqqg
jmOdOgxhkqQbV/ZS6kKOXz2Bsc+oLaOZRRklV6ChMf8xn3bfN/Lz6vUqm7iDl1ou
pmyfxZPDlbcs6JzfhFeMmyxX5xMerKgVSi4pN7m4lNlmaFV8taw=
=QO9E
-----END PGP SIGNATURE-----

--0ofDRjFb8S/24D2i--

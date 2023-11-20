Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Mu+aPb0b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xg+iSz6k"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ED9F7
	for <git@vger.kernel.org>; Mon, 20 Nov 2023 03:01:20 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id C1B7A3200583;
	Mon, 20 Nov 2023 06:01:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 20 Nov 2023 06:01:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1700478077; x=1700564477; bh=mE
	EaB7CS/L2MngKqUgQ9BbxzirvD6cNr8mS1Rw9aax0=; b=Mu+aPb0b8ZTtp54Obv
	xWrfsHhjg4lkL2SlaRU0q3oRG+cWAXOge4dMSjbWz286GOP+/IznPR8PFeAaqUn9
	Hg4g/ZwBAu100SkqxW6wuNVkmkzDCEEfVt0iuNwFkGFom3Q1VH0Iqy3UJiVD+pWf
	FEXMdcXyBMzwoiiMWMNqLIbqQ3hyytsuBc9QFvYmoSAawZnDtFpMeZTfIFgZqDps
	TuIRrfAoqUWOrZCZpaanpldSLknycD1nssN0uDzFrfMyV8fJ3yj8rvjB/gJ4uub8
	lbJx5R9ecx293xzUNNyyAUhqsCPJ69sgMFlyB4+zUUk7dd6rU8swbwjZWs8mff90
	Dw7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1700478077; x=1700564477; bh=mEEaB7CS/L2Mn
	gKqUgQ9BbxzirvD6cNr8mS1Rw9aax0=; b=xg+iSz6kLOXor1DW/+vs15gquzpP3
	Em4sFxJGIpwldsi7bpQcGxQXOtpUf3/0XQCgaBIPDTtqx0ch4DTugl9RD0c0x2mV
	Tw4UCH0RWuDmURZ8X9lIWvz6b0Oz5DMQ9l732aQpsSnsFuc5UrTmct0iLLNfb+8P
	iplclSRDztn+sJ1dNRhfxQZFdfrSjxycTZrIQWoQW2vbXxpLTqiA/fQtcr+lbOrl
	CLjF70kVbxVOPmQLrzYDo0zh8V+4li/zQXpzbJAMVvktj5PK/r/bzemr0EUh1GwD
	u/hu4H3i8biiMH4vfsqXu0r5dycU23Dy6ZBNw3pPEvB6tP17lyKma+s5Q==
X-ME-Sender: <xms:fDxbZRFFahMhxpJE9ybupvgsEwm0OfWz20Iz7xMFNS0heDUPgi661g>
    <xme:fDxbZWXK7m8RyvhAgygghrirDuBiY88YUzkTEEw4Ci0sHedWR3uHUyeMryJCyj1ZI
    IFB4zAcSGEay9tsvw>
X-ME-Received: <xmr:fDxbZTJD_1TNe2kqES3Kg3_S3XUQGaBLHWH_kj7eTiEY5p32EDEc1lA030Np93pnKybfJF14_3ZBXXRDkX2DugYV2ZdDbm5PGglgy7uPtF0LPnGz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegiedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeetueevhffhudefvdegieeuieelgedthf
    egfedtueevjeejtdfgjeehudejuedtudenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:fDxbZXH0CRo01QWu7mbmnlADHiMmag4BR0R4Zsr_Gs823SwXVvthdg>
    <xmx:fDxbZXVeSpqz6lpcaQwaV0ymDEbuUUQFlzlIhmX5r4NLREsHnISNrg>
    <xmx:fDxbZSPySY2Ax0fK_GXravWIogIWhnsfYBBA4ATYsw-0PxdLJiBILQ>
    <xmx:fTxbZUjl9CJvbba9rfpzLWmhTjL4lqrJuUi7_ionpUKhFCWeNvBq8Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Nov 2023 06:01:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7b3f53a3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Nov 2023 11:00:23 +0000 (UTC)
Date: Mon, 20 Nov 2023 12:01:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] commit-graph: disable GIT_COMMIT_GRAPH_PARANOIA by default
Message-ID: <f1235741cea5866e67c83aca83a760e0cdde8730.1700478031.git.ps@pks.im>
References: <7e2d300c4af9a7853201121d66f982afa421bbba.1699957350.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JK7N9skD0X/gvg06"
Content-Disposition: inline
In-Reply-To: <7e2d300c4af9a7853201121d66f982afa421bbba.1699957350.git.ps@pks.im>


--JK7N9skD0X/gvg06
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

Note that this requires us to amend some tests to manually turn on the
paranoid checks again. This is because we cause repository corruption by
manually deleting objects which are part of the commit graph already.
These circumstances shouldn't usually happen in repositories.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git.txt       | 6 +++---
 commit-graph.c              | 2 +-
 commit.c                    | 2 +-
 t/t5318-commit-graph.sh     | 8 ++++----
 t/t6022-rev-list-missing.sh | 5 +++++
 t/t7700-repack.sh           | 2 +-
 6 files changed, 15 insertions(+), 10 deletions(-)

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
index acac9bf6e1..6fad9d195d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1005,7 +1005,7 @@ struct commit *lookup_commit_in_graph(struct reposito=
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
index 7fe7c72a87..a2b4442660 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -911,10 +911,10 @@ test_expect_success 'stale commit cannot be parsed wh=
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
@@ -938,9 +938,9 @@ test_expect_success 'stale commit cannot be parsed when=
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
diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
index 40265a4f66..1ca4eb5a36 100755
--- a/t/t6022-rev-list-missing.sh
+++ b/t/t6022-rev-list-missing.sh
@@ -13,6 +13,11 @@ test_expect_success 'create repository and alternate dir=
ectory' '
 	test_commit 3
 '
=20
+# We manually corrupt the repository, which means that the commit-graph may
+# contain references to already-deleted objects. We thus need to enable
+# commit-graph paranoia to not returned these deleted commits from the gra=
ph.
+export GIT_COMMIT_GRAPH_PARANOIA=3Dtrue
+
 for obj in "HEAD~1" "HEAD~1^{tree}" "HEAD:1.t"
 do
 	test_expect_success "rev-list --missing=3Derror fails with missing object=
 $obj" '
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index d2975e6c93..94f9f4a1da 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -271,7 +271,7 @@ test_expect_success 'repacking fails when missing .pack=
 actually means missing o
 		ls .git/objects/pack/*.pack >before-pack-dir &&
=20
 		test_must_fail git fsck &&
-		test_must_fail git repack --cruft -d 2>err &&
+		test_must_fail env GIT_COMMIT_GRAPH_PARANOIA=3Dtrue git repack --cruft -=
d 2>err &&
 		grep "bad object" err &&
=20
 		# Before failing, the repack did not modify the
--=20
2.42.0


--JK7N9skD0X/gvg06
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVbPHcACgkQVbJhu7ck
PpRYNw//bHVrjv4n/hvplViTiWF8ZA2L2Pp4mu6bZDsnLPaZZ4iouUOncoKGo5wX
H8EV8ViM6AGByHr1RGEuLC2tT3Wv+JqkIuQRvMDXmeBOU/RQi/J91prY1Of1ogBl
HkWUfxssNgX4bpE60WRfYXBX+UfJteMhZKRQTBnkbrRQ6ZzdFDWjuDn+Ta70C9x8
X7TOH2NNw5jb+q3EBkE1Vmyx0Gxs2OYUqCNAlM4VNmBg9/7beKOevXckums95qg8
KMZZXAMd+LzEfsgtFA72sn4sx/6xEq5lmriZMj6ACdQO60ZTUJRXQx07fsfoi5JM
ocms+6steDlQ9swjlixLdktGUK7Sr3MWPupaSvWQoujY1F8FVl9xqDFyYA17Uukx
600/GXoBiZD4NzworIPtEzT0SNDGp1pu3lCiAwSIlUfnhbeQ15xTREMHvkZ8T1Sg
RDu1wlcLHN+Kxn04bdSD2C7Q7P9JfcHE+sic492xxLJTCWRxMIJ9zBU3zc/5kQjb
Xe0cP0SdHgnaeWNYNlcaSaSp1CQBvQbfioUlxs4heNRLjyxkZlo64sHuzKT2rLqm
HVT0xJjzawR4nmkrfNfv8riQCZPhTDJ/eJzj2HLb5JjM5xQ5H6ooWhlbils5SoN4
5qGdPAF37Zd7KvLqKarj86vp3XGH1ieJ8Op7lTTojpMi7wMVW1A=
=cqFu
-----END PGP SIGNATURE-----

--JK7N9skD0X/gvg06--

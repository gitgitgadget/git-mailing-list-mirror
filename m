Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NxZpuVRu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pxIK/wCn"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E1CD59
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 03:08:26 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 90F353200A32;
	Fri, 24 Nov 2023 06:08:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 24 Nov 2023 06:08:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1700824105; x=1700910505; bh=ax
	hrtxmyzn4oR6MZjzP4TqhH7cD4Ii1lrtngljgNSC4=; b=NxZpuVRuzs1MfFPnu/
	RJx1Y5RMh+iRNzbOG1klzZwR+0evYcEv8ffPUJmosURrqbZEi8daHFOIbfWnh5Nv
	LozhgkmcH5lZxQyAaIC8vJQ09eJrGUEEzpcgSsv8FlS0984iyullZaC+tX+bH98A
	VAyW2dqpKa0IOpoHlWNtifMOkCaCGrLG3VY8187+42DCEAu/dMvH1MCrbt3KsjbE
	oqyWmhd6c/p0/yZMRow131UErSMaIofZP15BupyESDhMrxitnW9oaiarGn8gPS4u
	LJUgluhm4oMZ8N4apTGJtXxfdmVORyuONH+KhmXggxZ50ZMfvSg1A+qB04QAEyPM
	3OBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1700824105; x=1700910505; bh=axhrtxmyzn4oR
	6MZjzP4TqhH7cD4Ii1lrtngljgNSC4=; b=pxIK/wCnntg/EfaPg50e/PLp25+sO
	9Gs3FmthCg2+u9sHkerL2bwJVhCSFPOYNLBNO93hjOPMmmrpVxGxzzZxoQuZhCuk
	5ig0OiV/y2HCVtiQgF/5rcNctgZDc9NGPlRlS9wO5V4c0z2V6XqCtDf384IhgGbB
	4hfR/g73kSlrR+sv/mwcxB0rj8wxAxYzfeCOBADioQNqSfxnsuTGEazXIWPC/37F
	bn2IRIKZNKMoDldV9+4UbYdVyzXKw1NfixkNjlzCg5ls89y+nxpF8PMF9lRBvGQU
	KF4pQOIfjdcJRGIxeT5jtUQiyuVfYvGyc1ldquZ8SI8accMTy47/o9Zcw==
X-ME-Sender: <xms:KIRgZTwRRT_iiMIJoPdTY0MnyU6Lcg7Xr1QVmHZt1OvoIwPBrOjbIw>
    <xme:KIRgZbRaKjHcNxc-w5NNoQHFamGfqj-EZGw9SRrL4mqffoG3mk34bDSkFYifkZAFo
    Bejedqg0CbhPj1G9w>
X-ME-Received: <xmr:KIRgZdWu1qmvUD_yMTMNajDjnNFj669VsTdRS3qiTejwgYXxa3k7Fu2lhsDoEbb9SsxckgPFg0gepwUgeJp7yJ2t3bj488sIwQz9IPupDPxprrs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehhedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeetueevhffhudefvdegieeuieelgedthf
    egfedtueevjeejtdfgjeehudejuedtudenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:KIRgZdg6u1j3H9XD3rz4aUrxengcfA8krggG4Wp_X9lTC0My3wAWUg>
    <xmx:KIRgZVDi-ckF9cU5Phoj8-anCNFHan8UdmL25vaBHaQ1dcZ7c7yWqA>
    <xmx:KIRgZWLYXwOGI800UMhE9AajqIqzM5QFd5S6_eu6QZiQvH1ZA9xwxQ>
    <xmx:KYRgZYPpIF_5yo4VjXHJ6udRgrOXmsTZ0CAg-kmsJqzfnOPo5D7FBw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Nov 2023 06:08:23 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a7e99bc7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 Nov 2023 11:07:24 +0000 (UTC)
Date: Fri, 24 Nov 2023 12:08:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3] commit-graph: disable GIT_COMMIT_GRAPH_PARANOIA by default
Message-ID: <17e08289cd59d20de0de9b4e18f5e6bf77987351.1700823746.git.ps@pks.im>
References: <7e2d300c4af9a7853201121d66f982afa421bbba.1699957350.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Pu9gX5LBjM8nehV4"
Content-Disposition: inline
In-Reply-To: <7e2d300c4af9a7853201121d66f982afa421bbba.1699957350.git.ps@pks.im>


--Pu9gX5LBjM8nehV4
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

The only change compared to v2 is that I've split up the `export
GIT_COMMIT_GRAPH_PARANOIA=3Dtrue` line into two lines as suggested by
Junio.

 Documentation/git.txt       | 6 +++---
 commit-graph.c              | 2 +-
 commit.c                    | 2 +-
 t/t5318-commit-graph.sh     | 8 ++++----
 t/t6022-rev-list-missing.sh | 6 ++++++
 t/t7700-repack.sh           | 2 +-
 6 files changed, 16 insertions(+), 10 deletions(-)

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
index 40265a4f66..211672759a 100755
--- a/t/t6022-rev-list-missing.sh
+++ b/t/t6022-rev-list-missing.sh
@@ -13,6 +13,12 @@ test_expect_success 'create repository and alternate dir=
ectory' '
 	test_commit 3
 '
=20
+# We manually corrupt the repository, which means that the commit-graph may
+# contain references to already-deleted objects. We thus need to enable
+# commit-graph paranoia to not returned these deleted commits from the gra=
ph.
+GIT_COMMIT_GRAPH_PARANOIA=3Dtrue
+export GIT_COMMIT_GRAPH_PARANOIA
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
2.43.0


--Pu9gX5LBjM8nehV4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVghCQACgkQVbJhu7ck
PpQyfw//ZXLxGSwJt+OWyUou/RZW4LuV/DhTQ2iJ8E20LPLPiYLUKzBwUettm364
WnvzYbsOVQKXYwUxBCas4bYxuMMNRkkmc3ZKM9y9tCkJNsqKmF1YzISURojIRKwo
i/Eff09uvR+iQACxN0a8+XHJkN6N/I4iBjTY+D1FrAEF8sQb/pcT/aIyfTG1p3Ws
kju7AXGXh14tqxlwgqe9GGrkmHKgBQMEEMhcK6P9vKR88xri+ds9I+/6ZZO6Nl2o
UPZ5tIA+Es4R8d/aDwf2FidR9fA9A+7+xLDwLyMxz75uKjId4g6KBJQeuXuykyl6
T0MK8PeRbiu2MOjOMgvurMaX2obPkzbLnhtMK4xT8zFwhwCK+DjtMVWY4Mr5gehh
ZOFbhq5dnwgK2DOPbIZW7w23bJ933dhw5mQH4coU7OuKJ02X5u0amRcOnMlY7pwX
LXF6zBypTRHtRdebazga/NtOTvFPHHdLJrBeH358a95Z8/OTNVd/a/aSxES+Ww9V
uMeU5312sqwe3pkuKeSDlXZiglDxF0jEsNsEjQa+OlhPbTf+dWlpTESKqNH2XBXj
zRwwQkuyz/jR2/9+W9I9p29dmT9pGT/UI2BjEdbeTv5XBB8cT+5etDcxL1N2xUeV
EuraGwZov60O4UUGKFKaJrzdljPSTXujtrMYz1vDIdmwK8iE5G4=
=AKu2
-----END PGP SIGNATURE-----

--Pu9gX5LBjM8nehV4--

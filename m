Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B2115E84
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lnxWsnS0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="djq+BGZr"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178D0E8
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 04:27:20 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 977DE32007F9;
	Mon, 23 Oct 2023 07:27:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 23 Oct 2023 07:27:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:sender:subject:subject:to:to;
	 s=fm3; t=1698060436; x=1698146836; bh=XROFSa9bm7OWnP90sJr3WgPmY
	1e89ZTnfYqoxQcFOvU=; b=lnxWsnS0g/zDu3dZqqEhvQRHUP9Vac2/KZyxwolnw
	pQhFHopJVmmVQg7aLMnFib1kyb20L0ONvFwNHURFpwyN4iYELMvoD+9CTAchboy0
	F2WnSvsXUotSGYs3ZARt6MYMxzWUarpYX/8RqW3Yv94KOlzS17KEHiRoSRk5Gn1r
	B/pwg4ojzVOBv/hkN9mDb95mD6vwBGZR3Hk5pAsmVrE4gwIDU9s+RCgw9qAAnlRY
	Bvq2825jf6yQoPJ5ZU32m27qF+TdJeTlXKJI8+OHnBdp6gI3FCE907ao457Zkrz0
	TjoyS/f0EiqmShHQlXPnCFxiA//+T9FiBvJZsJI3+nQ8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1698060436; x=1698146836; bh=XROFSa9bm7OWnP90sJr3WgPmY1e89ZTnfYq
	oxQcFOvU=; b=djq+BGZrDvTOJr329nYOizjpR0pC7PJygJ7wgH/TbVxpSY18ckZ
	5iX7P4pPMUiZrKa3Xm+8bSvmTaQIMoFMf6V2RwjGoW+ymUeVQ4Y4PIMLaxvi2RuT
	PKeqQ2yz0Tepa7qtiSxIyti/qacGr+AJpAmcB4e8okwniEOQQkpcF65172Z2Sg1c
	7aZ8hThc29t/BPhiGUR0Uykt3llTuATQDH/RbtiN2sw2+74seicM/pVd7TOHM5eG
	q85ZwOYNj22HIGNYinV/mvzaJx5GxQiYANf2Hr646Sc4CoiNgU3rWTsRM6RhgAWk
	96/T6ezeooYW+CZMdY1/0YgwRWXuvX8Q2CQ==
X-ME-Sender: <xms:k1g2ZVxy4gdP3ulUlpIS0DhFM5ve9nErs0HphEs5zwXRMK7292iy6g>
    <xme:k1g2ZVR170qXsIdkx4lowoZ7QESSCmVqaeGykJES3eyjwTnwT24zGUI75Gi8w1M4v
    VDKx9hJ4nb0xcN5rw>
X-ME-Received: <xmr:k1g2ZfXELgREDw23y96HLP6ZkupueRQ5ghl3_fts5BsCoweNKIfXsYN8u5Y5ZXrFemhDqhcVjiuzWCayWL0pbgsmo9dD3SFkBsg5NMrNQvCE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeeigdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfggtggusehgtderredttdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    eghfefveeuleehtdekteevfeejfeekteeiudeujedtleektdeltdektedttdegueenucff
    ohhmrghinhepphhkshdrihhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:k1g2ZXhmnRnNN_wJ5bZ8oogm9zBfeMFcP_YrRnYjzejisbZpRfmwsg>
    <xmx:k1g2ZXA1-BTbtkPW1gHwZLYqO0WTeqnHzD_5VtiQEUFk8jseQTRtmA>
    <xmx:k1g2ZQL919ERZB9AfaU3suvGAmxt4Vb6jiy_DFf56fSyrGbjIYsqpw>
    <xmx:lFg2ZeNA7uePtuJrjbwTY2IjhiyTyzX0CkBVFsHmTxQyg9YqpNNarg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Oct 2023 07:27:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 10da9b5d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Oct 2023 11:27:10 +0000 (UTC)
Date: Mon, 23 Oct 2023 13:27:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v2 0/2] commit-graph: detect commits missing in ODB
Message-ID: <cover.1698060036.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vaqLBqt0kDPRk91u"
Content-Disposition: inline


--vaqLBqt0kDPRk91u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is version 2 of my patch series to more readily detect commits
parsed from the commit graph which are missing in the object database.
I've split this out into a separate thread as version 1 was sent in
reply to a different series to extend git-rev-list(1)'s `--missing`
option so that I don't continue to hijack this thread.

Changes compared to v1:

    - I've added a preparatory patch that introduced a new
      GIT_COMMIT_GRAPH_PARANOIA environment variable as suggested by
      Peff. This envvar is retrofitted to the preexisting check in
      `lookup_commit_in_graph()` so that the behaviour for this sanity
      check is consistent.

    - `repo_parse_commit_internal()` now also honors this new envvar.

    - I've amended the commit message in v2 to include the benchmark
      that demonstrates the performance regression.

    - We now un-parse the commit when parsing it via the commit graph
      succeeded, but it doesn't exist in the ODB.

Thanks for all the feedback and discussion around this.

Patrick

[1]: <b0bf576c51a706367a758b8e30eca37edb9c2734.1697200576.git.ps@pks.im>

Patrick Steinhardt (2):
  commit-graph: introduce envvar to disable commit existence checks
  commit: detect commits that exist in commit-graph but not in the ODB

 Documentation/git.txt   |  9 ++++++++
 commit-graph.c          |  6 +++++-
 commit-graph.h          |  6 ++++++
 commit.c                | 16 +++++++++++++-
 t/t5318-commit-graph.sh | 48 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 83 insertions(+), 2 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  a89c435528 commit-graph: introduce envvar to disable c=
ommit existence checks
1:  6ec1e340f8 ! 2:  0476d48555 commit: detect commits that exist in commit=
-graph but not in the ODB
    @@ Commit message
         behaviour by checking for object existence via the object database=
, as
         well.
    =20
    +    This check of course comes with a performance penalty. The followi=
ng
    +    benchmarks have been executed in a clone of linux.git with stable =
tags
    +    added:
    +
    +        Benchmark 1: git -c core.commitGraph=3Dtrue rev-list --topo-or=
der --all (git =3D master)
    +          Time (mean =C2=B1 =CF=83):      2.913 s =C2=B1  0.018 s    [=
User: 2.363 s, System: 0.548 s]
    +          Range (min =E2=80=A6 max):    2.894 s =E2=80=A6  2.950 s    =
10 runs
    +
    +        Benchmark 2: git -c core.commitGraph=3Dtrue rev-list --topo-or=
der --all (git =3D pks-commit-graph-inconsistency)
    +          Time (mean =C2=B1 =CF=83):      3.834 s =C2=B1  0.052 s    [=
User: 3.276 s, System: 0.556 s]
    +          Range (min =E2=80=A6 max):    3.780 s =E2=80=A6  3.961 s    =
10 runs
    +
    +        Benchmark 3: git -c core.commitGraph=3Dfalse rev-list --topo-o=
rder --all (git =3D master)
    +          Time (mean =C2=B1 =CF=83):     13.841 s =C2=B1  0.084 s    [=
User: 13.152 s, System: 0.687 s]
    +          Range (min =E2=80=A6 max):   13.714 s =E2=80=A6 13.995 s    =
10 runs
    +
    +        Benchmark 4: git -c core.commitGraph=3Dfalse rev-list --topo-o=
rder --all (git =3D pks-commit-graph-inconsistency)
    +          Time (mean =C2=B1 =CF=83):     13.762 s =C2=B1  0.116 s    [=
User: 13.094 s, System: 0.667 s]
    +          Range (min =E2=80=A6 max):   13.645 s =E2=80=A6 14.038 s    =
10 runs
    +
    +        Summary
    +          git -c core.commitGraph=3Dtrue rev-list --topo-order --all (=
git =3D master) ran
    +            1.32 =C2=B1 0.02 times faster than git -c core.commitGraph=
=3Dtrue rev-list --topo-order --all (git =3D pks-commit-graph-inconsistency)
    +            4.72 =C2=B1 0.05 times faster than git -c core.commitGraph=
=3Dfalse rev-list --topo-order --all (git =3D pks-commit-graph-inconsistenc=
y)
    +            4.75 =C2=B1 0.04 times faster than git -c core.commitGraph=
=3Dfalse rev-list --topo-order --all (git =3D master)
    +
    +    We look at a ~30% regression in general, but in general we're stil=
l a
    +    whole lot faster than without the commit graph. To counteract this=
, the
    +    new check can be turned off with the `GIT_COMMIT_GRAPH_PARANOIA` e=
nvvar.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## commit.c ##
    +@@
    + #include "shallow.h"
    + #include "tree.h"
    + #include "hook.h"
    ++#include "parse.h"
    +=20
    + static struct commit_extra_header *read_commit_extra_header_lines(con=
st char *buf, size_t len, const char **);
    +=20
     @@ commit.c: int repo_parse_commit_internal(struct repository *r,
      		return -1;
      	if (item->object.parsed)
      		return 0;
     -	if (use_commit_graph && parse_commit_in_graph(r, item))
     +	if (use_commit_graph && parse_commit_in_graph(r, item)) {
    -+		if (!has_object(r, &item->object.oid, 0))
    ++		static int object_paranoia =3D -1;
    ++
    ++		if (object_paranoia =3D=3D -1)
    ++			object_paranoia =3D git_env_bool(GIT_COMMIT_GRAPH_PARANOIA, 1);
    ++
    ++		if (object_paranoia && !has_object(r, &item->object.oid, 0)) {
    ++			unparse_commit(r, &item->object.oid);
     +			return quiet_on_missing ? -1 :
     +				error(_("commit %s exists in commit-graph but not in the object d=
atabase"),
     +				      oid_to_hex(&item->object.oid));
    ++		}
    ++
      		return 0;
     +	}
     =20
    @@ commit.c: int repo_parse_commit_internal(struct repository *r,
      		return quiet_on_missing ? -1 :
    =20
      ## t/t5318-commit-graph.sh ##
    -@@ t/t5318-commit-graph.sh: test_expect_success 'overflow during gener=
ation version upgrade' '
    +@@ t/t5318-commit-graph.sh: test_expect_success 'stale commit cannot b=
e parsed when given directly' '
      	)
      '
     =20
    -+test_expect_success 'commit exists in commit-graph but not in object =
database' '
    ++test_expect_success 'stale commit cannot be parsed when traversing gr=
aph' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
     +	(
    @@ t/t5318-commit-graph.sh: test_expect_success 'overflow during genera=
tion version
     +		oid=3D$(git rev-parse B) &&
     +		rm .git/objects/"$(test_oid_to_path "$oid")" &&
     +
    ++		# Again, we should be able to parse the commit when not
    ++		# being paranoid about commit graph staleness...
    ++		GIT_COMMIT_GRAPH_PARANOIA=3Dfalse git rev-parse HEAD~2 &&
    ++		# ... but fail when we are paranoid.
     +		test_must_fail git rev-parse HEAD~2 2>error &&
     +		grep "error: commit $oid exists in commit-graph but not in the obje=
ct database" error
     +	)
--=20
2.42.0


--vaqLBqt0kDPRk91u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU2WI4ACgkQVbJhu7ck
PpTraQ//c3JF2PyZoxWRzRyfFE8ZZXkjlkhlHx23KmeDzeEKHpOFL9reHr2v4YA2
1bnCny4W32rfwWhStJygeAA1kYXQykVCC+5Tuu6r3XX96EU8AlezxMIh4/ZxhKcZ
rVMNDWPTd+r6Jh1pksLOdEJmMBvUkfDdj/2pfCo+q+/DTzDdaYHX3HoDUUu/Uffp
GQ3edXYtbtjLey+RLdcoQRUXAhU344qDJkj5XpyxtkuIZOunIjK8Z3n70b7++E2e
hKAUUy96k80/amJlEZKvSTvzLv5M4OzSuXR/MuY2cLGmAlFDpF5uqsQ3Op+Tj95d
Ie69CUxe7YueZubhr/GI9jpODtXGFgxpnZulx8Ca+pjU0bnfXcQNYq0q9jeQ+zIU
jZk8NjYCCFvCH2Upmexu39aFmGjfA5pgFI0LJdRdovh+wGfa3V9aTgdt9hkJo3n2
4G870DcwqHPKrZaNNCfszJ/7TLzSx+w67VtCTXKhU4wHhDhfaJ6ZLqqlie3ewNvr
G+CqkQPRO16fuMHEADJep40OetxWA9SET0hM7URPJoyvfVSbiyx/6zZ13mETXVC8
Od8M19zDhi5KUS38S9/XmrDXz+REpn059QU7xIM80b+pLkplENdB8EKVyj+tCzc5
kDRPkU3lUea9xA/G2gSxNHG171uzLilbYED/YehZL8Zc8UldOms=
=YMYS
-----END PGP SIGNATURE-----

--vaqLBqt0kDPRk91u--

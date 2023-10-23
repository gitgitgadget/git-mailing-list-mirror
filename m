Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BC715EAF
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 11:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="s2I6JjSt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SB5KXRki"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9819DD
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 04:27:25 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 7A4F2320090D;
	Mon, 23 Oct 2023 07:27:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 23 Oct 2023 07:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698060444; x=1698146844; bh=F5
	yV8G+cbj2c585o0UE2ZNQdz93HkpH7WTisKFlq0Jc=; b=s2I6JjStta7gU/lZie
	4D8cRg9Xdb0TWfmaV4+7VWSsLUhBkOB6PTwRLTghiRMY8J1Jljrdv8oFshkOfq4Q
	c+w3FRIv8eVpU5Rmxehz61dZ/Qit7dsK7OnaVHX6UYM3nT1ZNFnLaD8BxOdoaR3H
	d/IVHMELUD3C/Wlv/6K6+x0+CNdS1o/k76XQYZN+KGdfeQqiEKT4ypxtrxFiJ1vl
	lOWgKBp7Kq8dYJJZFXU1gyaN3wNCxkOg9OEEFJKjwZBEDVborwJpIigehaVcnuj5
	bRCOx4jomZM6U1qnjjm3GSCCXwv+gE1SlXhHOV62maiNDtTnPq+2RlTsHC4sFeM1
	1IYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698060444; x=1698146844; bh=F5yV8G+cbj2c5
	85o0UE2ZNQdz93HkpH7WTisKFlq0Jc=; b=SB5KXRkiT/9gY41mMkekIRMG7np3/
	cc6iR8QCGlykZFlpyRv0yEbluHMYqAQDAPJH5dGrpz0smiO8p8v2Zcs+XGkP1bk9
	qomzMgtnJXG+hNBl7EK6hcmjYHkZ3gNowgvlfP/IdEaOfQVKBmHbdaNJRXTWgZ5T
	Vm4odKl5hT+/vtizrGjiFiv1ONZ/+x91+UqyGhnWufFlKx8wG6vO3rj7H+313q5C
	WBcjQAC3wYes4hYh5TkGvTXRi0ITPB8EAPOgbppLYi0OdXm5ADj91sxnSyyy83Wy
	NOVd+rTKqOppTAIVAULo7ZaOBVWcygbdfoyYQRUNdVEuhJY4hnqPlrfbQ==
X-ME-Sender: <xms:m1g2Za1F1MSjcPZ5lvzhgebCPQIWeW7_Fz_HjmIah1Om5uOS84IanA>
    <xme:m1g2ZdE0bQ49z2ayhkuClmjZ0WYjRu5LSQhYrPgadRqcP-i4j7v_7LYzi4wizIArX
    xsP2zIPypI9eSnwNQ>
X-ME-Received: <xmr:m1g2ZS6b_yeegZiF5ScDlgesXwG7-yyGCVK3zT3e3OJ6VQ5PBKErIP16ISNUvDJRi0hWN2rvNBHnHauQHuNt0GIgVgN9Ljyi6IGFt2duac_H>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeeigdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:m1g2Zb3Si-SZOe9jg4kCKA1XzzdR-QJQnaum9AhgWW0F9I0tarqTUw>
    <xmx:m1g2ZdFMXlcg0aVVpUC8-Nsc3xJqFpGvu5Ej3J1LvV6rqzzzTz6vXg>
    <xmx:m1g2ZU8XvXtitB4fDkCGFH6cXnMtij0PPWhheJKD57Y4j8Zu-dpprw>
    <xmx:nFg2ZdB37bkZ2RcwPaJFCxyqaOYVIw1xIJixVmTwgh_NXeXG-UDYaw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Oct 2023 07:27:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cb50daa3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Oct 2023 11:27:19 +0000 (UTC)
Date: Mon, 23 Oct 2023 13:27:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v2 2/2] commit: detect commits that exist in commit-graph but
 not in the ODB
Message-ID: <0476d4855562b677ced106a4cc7788b46434cf21.1698060036.git.ps@pks.im>
References: <cover.1698060036.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KLSXDr7N+S677JSj"
Content-Disposition: inline
In-Reply-To: <cover.1698060036.git.ps@pks.im>


--KLSXDr7N+S677JSj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Commit graphs can become stale and contain references to commits that do
not exist in the object database anymore. Theoretically, this can lead
to a scenario where we are able to successfully look up any such commit
via the commit graph even though such a lookup would fail if done via
the object database directly.

As the commit graph is mostly intended as a sort of cache to speed up
parsing of commits we do not want to have diverging behaviour in a
repository with and a repository without commit graphs, no matter
whether they are stale or not. As commits are otherwise immutable, the
only thing that we really need to care about is thus the presence or
absence of a commit.

To address potentially stale commit data that may exist in the graph,
our `lookup_commit_in_graph()` function will check for the commit's
existence in both the commit graph, but also in the object database. So
even if we were able to look up the commit's data in the graph, we would
still pretend as if the commit didn't exist if it is missing in the
object database.

We don't have the same safety net in `parse_commit_in_graph_one()`
though. This function is mostly used internally in "commit-graph.c"
itself to validate the commit graph, and this usage is fine. We do
expose its functionality via `parse_commit_in_graph()` though, which
gets called by `repo_parse_commit_internal()`, and that function is in
turn used in many places in our codebase.

For all I can see this function is never used to directly turn an object
ID into a commit object without additional safety checks before or after
this lookup. What it is being used for though is to walk history via the
parent chain of commits. So when commits in the parent chain of a graph
walk are missing it is possible that we wouldn't notice if that missing
commit was part of the commit graph. Thus, a query like `git rev-parse
HEAD~2` can succeed even if the intermittent commit is missing.

It's unclear whether there are additional ways in which such stale
commit graphs can lead to problems. In any case, it feels like this is a
bigger bug waiting to happen when we gain additional direct or indirect
callers of `repo_parse_commit_internal()`. So let's fix the inconsistent
behaviour by checking for object existence via the object database, as
well.

This check of course comes with a performance penalty. The following
benchmarks have been executed in a clone of linux.git with stable tags
added:

    Benchmark 1: git -c core.commitGraph=3Dtrue rev-list --topo-order --all=
 (git =3D master)
      Time (mean =C2=B1 =CF=83):      2.913 s =C2=B1  0.018 s    [User: 2.3=
63 s, System: 0.548 s]
      Range (min =E2=80=A6 max):    2.894 s =E2=80=A6  2.950 s    10 runs

    Benchmark 2: git -c core.commitGraph=3Dtrue rev-list --topo-order --all=
 (git =3D pks-commit-graph-inconsistency)
      Time (mean =C2=B1 =CF=83):      3.834 s =C2=B1  0.052 s    [User: 3.2=
76 s, System: 0.556 s]
      Range (min =E2=80=A6 max):    3.780 s =E2=80=A6  3.961 s    10 runs

    Benchmark 3: git -c core.commitGraph=3Dfalse rev-list --topo-order --al=
l (git =3D master)
      Time (mean =C2=B1 =CF=83):     13.841 s =C2=B1  0.084 s    [User: 13.=
152 s, System: 0.687 s]
      Range (min =E2=80=A6 max):   13.714 s =E2=80=A6 13.995 s    10 runs

    Benchmark 4: git -c core.commitGraph=3Dfalse rev-list --topo-order --al=
l (git =3D pks-commit-graph-inconsistency)
      Time (mean =C2=B1 =CF=83):     13.762 s =C2=B1  0.116 s    [User: 13.=
094 s, System: 0.667 s]
      Range (min =E2=80=A6 max):   13.645 s =E2=80=A6 14.038 s    10 runs

    Summary
      git -c core.commitGraph=3Dtrue rev-list --topo-order --all (git =3D m=
aster) ran
        1.32 =C2=B1 0.02 times faster than git -c core.commitGraph=3Dtrue r=
ev-list --topo-order --all (git =3D pks-commit-graph-inconsistency)
        4.72 =C2=B1 0.05 times faster than git -c core.commitGraph=3Dfalse =
rev-list --topo-order --all (git =3D pks-commit-graph-inconsistency)
        4.75 =C2=B1 0.04 times faster than git -c core.commitGraph=3Dfalse =
rev-list --topo-order --all (git =3D master)

We look at a ~30% regression in general, but in general we're still a
whole lot faster than without the commit graph. To counteract this, the
new check can be turned off with the `GIT_COMMIT_GRAPH_PARANOIA` envvar.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit.c                | 16 +++++++++++++++-
 t/t5318-commit-graph.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index b3223478bc..7399e90212 100644
--- a/commit.c
+++ b/commit.c
@@ -28,6 +28,7 @@
 #include "shallow.h"
 #include "tree.h"
 #include "hook.h"
+#include "parse.h"
=20
 static struct commit_extra_header *read_commit_extra_header_lines(const ch=
ar *buf, size_t len, const char **);
=20
@@ -572,8 +573,21 @@ int repo_parse_commit_internal(struct repository *r,
 		return -1;
 	if (item->object.parsed)
 		return 0;
-	if (use_commit_graph && parse_commit_in_graph(r, item))
+	if (use_commit_graph && parse_commit_in_graph(r, item)) {
+		static int object_paranoia =3D -1;
+
+		if (object_paranoia =3D=3D -1)
+			object_paranoia =3D git_env_bool(GIT_COMMIT_GRAPH_PARANOIA, 1);
+
+		if (object_paranoia && !has_object(r, &item->object.oid, 0)) {
+			unparse_commit(r, &item->object.oid);
+			return quiet_on_missing ? -1 :
+				error(_("commit %s exists in commit-graph but not in the object databa=
se"),
+				      oid_to_hex(&item->object.oid));
+		}
+
 		return 0;
+	}
=20
 	if (oid_object_info_extended(r, &item->object.oid, &oi, flags) < 0)
 		return quiet_on_missing ? -1 :
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index c0cc454538..79467d7926 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -842,4 +842,31 @@ test_expect_success 'stale commit cannot be parsed whe=
n given directly' '
 	)
 '
=20
+test_expect_success 'stale commit cannot be parsed when traversing graph' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		test_commit A &&
+		test_commit B &&
+		test_commit C &&
+		git commit-graph write --reachable &&
+
+		# Corrupt the repository by deleting the intermittent commit
+		# object. Commands should notice that this object is absent and
+		# thus that the repository is corrupt even if the commit graph
+		# exists.
+		oid=3D$(git rev-parse B) &&
+		rm .git/objects/"$(test_oid_to_path "$oid")" &&
+
+		# Again, we should be able to parse the commit when not
+		# being paranoid about commit graph staleness...
+		GIT_COMMIT_GRAPH_PARANOIA=3Dfalse git rev-parse HEAD~2 &&
+		# ... but fail when we are paranoid.
+		test_must_fail git rev-parse HEAD~2 2>error &&
+		grep "error: commit $oid exists in commit-graph but not in the object da=
tabase" error
+	)
+'
+
 test_done
--=20
2.42.0


--KLSXDr7N+S677JSj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU2WJcACgkQVbJhu7ck
PpT5gA/9FVjjCm3NeWSOpoAdRp92KNJDq2M/yr0vd8AlObEKo81EmZhnTAclkBP2
b6DOHpWdIox2g5O9oLo1zxjYqUGDfYMbHZi5JbbRvCEFfl7E9WGMUV35ot9mk2cv
IQsXcJDX6sPTSn/0FZ3E8a4/GSwWg/LyrXY/6BbA5fWyuvmejixxFC6Ay2jx2vE3
gn4iCRol3q9c1WXyaS7RVW85EhlGqp2oK2JdZQWmTmWgr2b9txtYqN2m+dpkT7W4
Y0yk5YUplef8oDrxh81h3xsoqKhpbzYVG3YroOmWiNVhVhqjaGX1J6r21zE6dA+f
G6kWz5BOC29i7yQ3BhfYUxshPnMJmzHuYBVqsIiilfioa/Uce85ZvixI8h7Q5CSK
F3xz85RaU4m+gaoN9sbEHfJGmFn5Dt5Pug3dX7zC8fUAo2W5mlyOR77NyuL2HNwr
Wn/GVXb2N4KRjbpIho2tbubdkOW0Kf16LHLQibpWbCq1XfEzD5Zg0J8ZCdERJ7uJ
+78R8yYnzZkpCQgrjqAyfrKjNwiolgx5nlVOomZExQ+W9/+VOsY64bdkVzF19Hdz
1Hoet7/ykgyfPnmIbQ7yyTcd4MLtkJIKdRGt/UblmrLPH1xhdc4WpKfVzl9QhSee
yT7L8RTgpuUgFZWaKsGT3Co8buPTMnHnDfQvNnIgWcOEIKT0ueo=
=bFhQ
-----END PGP SIGNATURE-----

--KLSXDr7N+S677JSj--

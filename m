Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29CA1097E
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 07:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="u9ZudfCn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vJqXJAPl"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F8CC0
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 00:16:22 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id C71D53200A06;
	Tue, 31 Oct 2023 03:16:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 31 Oct 2023 03:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698736581; x=1698822981; bh=gv
	QXy7Gg92r+IZv+hibASUGnOkCf73e+XmJLN4/irqE=; b=u9ZudfCncz1Cs+syY7
	zQUROlK26hVvd6SfPXjxi6tAytASg2jrQcMa97V8fFCw4buaB1RccrIzkRdVKE6J
	hr0WHiESe4iACFMoQsTV7Gg+l6nQ4J97eJUUcJ300ou27ZrSx+D+WsA+NiFn7leB
	jCfbpE4TFrmMLYtkEtceN8xyRmr3JLDFs/h7vHUoIa6+mq05YU7pmdNP3a/EPoHn
	iN6zlTRo2OSrB2ECwzqFZgnlI8N8BHcwlWSkomjpJP5SdMhlE96BQWyXuxPSoGWF
	bGsT5aXJwvenKvFTS4rBxSr23eyKddjMK9g4zmISN5zZ6GBX/e1YC0ASUcRO6A9I
	1v3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698736581; x=1698822981; bh=gvQXy7Gg92r+I
	Zv+hibASUGnOkCf73e+XmJLN4/irqE=; b=vJqXJAPlMZCkIdKSoFmohaMdz0wps
	o0scpW3/SUGHWtSnlRMn9v6UKetL8CCqF6afOvdKfLUhDOED1uz7l24dqZVF6TmM
	sU98p/g/RZYWtg77+IzBQg1knqLP74nIzRpnFdtbuNaoH8RQOeFOhUame4C9lHHM
	OrLJ/TWmGs9enzBUfAM4MdYsGwafZ+om4wY3vLIkNn6jaVwbu+V/BXeh6tETOKRG
	+u/mLH59FW9iY6bA3OsK3SGI8d3aV85Gj5u228mkxYLGy4O5QG9Lg1783Hx/93SL
	bQYivZys24NS8TJSlciO3E2RL/nXhEGkP+pfxss49jMsBm0gVwCsoNY9A==
X-ME-Sender: <xms:xalAZYTQLBm0uQh39IQv80Y-Yh_tixn8itMsJmvRaneh3jMboUAZbQ>
    <xme:xalAZVx8EfUrKGc7HrcdoMnMv0ugXBF4CRt-lS4pDkacJ-zFin5rmNRj3ByquWrFp
    PlXj8SLS9eeu3-jXw>
X-ME-Received: <xmr:xalAZV3zXHIMX73_smjrNz1c5WLCcpBv0BHq862zS8m-cmCZjXf-xaJTE7Gz2wtQ7_rOBBhvkN18zGm68BnFLZj9IvNBx5kTuPfAn-uUG6tFwrfS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedt
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:xalAZcCY2HiNfgsBNRxEMD9uHz60p6jYaysGI8DArw_3_BB-InDu1g>
    <xmx:xalAZRhOuZpOXU1dMXoIHSdquze1TkGw2HqedpxQ73h-lTfE8nJKXA>
    <xmx:xalAZYpsFqxpTPAV5-6M2tpeLBcS8BqeV5OPuMpO3V-cuFVOQMXKYQ>
    <xmx:xalAZWsZ6Gf_v22KY9326kCZU4PMDPmxxm3ydlBcpOVY7WFbnK7xgA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 03:16:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id adbd042f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Oct 2023 07:16:12 +0000 (UTC)
Date: Tue, 31 Oct 2023 08:16:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 2/2] commit: detect commits that exist in commit-graph but
 not in the ODB
Message-ID: <8629fd0892f6f1007f770ec9edc09606864ff6ba.1698736363.git.ps@pks.im>
References: <cover.1698060036.git.ps@pks.im>
 <cover.1698736363.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="93jah6KrASg+p7aa"
Content-Disposition: inline
In-Reply-To: <cover.1698736363.git.ps@pks.im>


--93jah6KrASg+p7aa
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
index b3223478bc..8405d7c3fc 100644
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
+		static int commit_graph_paranoia =3D -1;
+
+		if (commit_graph_paranoia =3D=3D -1)
+			commit_graph_paranoia =3D git_env_bool(GIT_COMMIT_GRAPH_PARANOIA, 1);
+
+		if (commit_graph_paranoia && !has_object(r, &item->object.oid, 0)) {
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
index c0cc454538..7b1c331b07 100755
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
+		# Corrupt the repository by deleting the intermediate commit
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


--93jah6KrASg+p7aa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVAqcEACgkQVbJhu7ck
PpQvGQ/+OYN6odgU6w3VJZMySzakDDg/MCepeS0wLSeQNKV9G8H7hM+39ZBxKfHN
+4x/Bu/kWjJ0tOGdKzvpkXtGChPDoWsN7DByGrA3djiu31UpBWXkiIDPozC5JRPw
YRH0AcpiTPHWaxEAaf9xvGfTpQSo93umu/fNBOVksjJOE8fXOUa9NWdLhGzZg0Ro
x7JVTZ8mC5cqFKJgLFaWGs+nyzg0PjS2fTHBuzipI1u3rcPLF73vNvW4glrL2X6J
1U8/iiElUFxYvfkSMqZjd6ibhRm9CNb5L9nMmdK3Pl6b+RkLU4gmmeDyWTUxpJZy
m0VWTKSxXhOoLfSodKD3YkAkwXweHgueUE31qkLobWINSCERfTJwdUScoYpPcTko
cX7BTddwYNdqDzdFqipNAid81WxwReQcGRxEOqablzEtnYU8jzFE3yYkhtdZNtIf
dOIfPlj5uGiUvzDlF+A9Oo4OvjSDL2FV/vKHrzecy7riZmVlLK5iEconqLoTf6fk
ZoSwMy8as845aHm6vRaCybcjstA5lBdAVAwfs6oe+KYSuAscUZwN+1yWQWA3Xdj1
f6KN3wbV+AVZcqeJwRjJRHDsyFUGvusg5Vk6HizZNMf3FjehHrPuI8bBaMaziZhL
AX/ThVN/I3w7yG1PFkXceF6WbtNl+nHBNEuGOWjQoJHsmjs42Q4=
=w4/c
-----END PGP SIGNATURE-----

--93jah6KrASg+p7aa--

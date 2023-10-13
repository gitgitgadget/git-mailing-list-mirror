Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF09415E8A
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 12:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZyY67RQj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YIzmFzlT"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3CBA9
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 05:37:43 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 5A11F32009FB;
	Fri, 13 Oct 2023 08:37:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 13 Oct 2023 08:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1697200659; x=1697287059; bh=Dw
	yElQdLXsOdeluKZPDvx6w7ahP3Gfnt8sPcWslcKuw=; b=ZyY67RQj1ifiybXtet
	hHuX4l5PYXbJILR10Tv4eUnz7Ip7PaBlKqLi7HSZW8Bk0H8dtqmdhoSHxo6tCNbZ
	4LqO3nspn+bMZqshp1vrNKeWzXUkmPwgbtkpyC4r4IhDZQ2vCy74elXI8z/o8/1b
	vU6379fKVrjevm1kJu+a11QjA6gnw2glbzFJCN6dn9P8C536ThbEpnDDgvjrt9zP
	TN1G8+SGp5Kl41a6U7RtSlKAZN/hpmf9lrNhPBTMgjfOHH4X9q/pHXySJ34B4jTc
	LbdJt6IRVgLcS0F71rgJv4SnW5V0cAVyQ+vrblZHhPRAAcotfiH8sF6k5szomMk3
	IwZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1697200659; x=1697287059; bh=DwyElQdLXsOde
	luKZPDvx6w7ahP3Gfnt8sPcWslcKuw=; b=YIzmFzlTzXbQDRtV42Jv8JVQs5Ndc
	SqP3WBXmzg59pniCfriMMWrnqaE1Tbbww0yT9mZRnvRLKYvBMggHNtUSGv05oKel
	mjraFaN0pua4mRdLjPlhJI5uA6D4Jporm2NVw6/0uaHMK7lzC2oazqf1dsXA/t7V
	mJPfBpxtO8Hmp7Z4+x3vIW3R9aIvPTzxu0IlShXRd9n+dpSEQ2M0olXRfJKos5Og
	WoafX58bhdVhrm6B6Fa/8esA2abLm1ig5x9z2wMhwDfTD8+wFjuMBBaKiSpE90O2
	y6cZIpnoWrGuWo6lR2ySbownjMJ/2R+Vd2GUB67XDiKaSgzEUkph4XGLA==
X-ME-Sender: <xms:EzopZcJ6-UXGuv_ZrhHIKt2oP78Ipv8vNjJXKV3uikGL4qXnSWpSkQ>
    <xme:EzopZcKsUZ7czk8SrhhOuu9dPaOEoVB_vTWrulrIRxnQf_qP_FObDliEB8dLuE-2F
    jlvH2TGdk1JwYxi5A>
X-ME-Received: <xmr:EzopZcsyNUBvRa1xvSX-TBOjSug2RPS2XoaV5q_8YLLnRpqHR291gY5m-o6ugpAheDN3iztIyGRPka7k2i1a7Hu_WZJJi9ND7fwXH_O3Z_Z7iJE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrieefgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:EzopZZZuUETNjUWFSITqs-8nNSVdLZD_vx1hoaLK6XteoiBDbzTyXw>
    <xmx:EzopZTaeJZy3VWi_gRDTcfkpXhThKiKQc389bp2yF6Kb3NfNHzQCuw>
    <xmx:EzopZVB913a1CaA4dMKG56UmP6OZlbXmSeZ3ZAMgDIySy-UOcWnqVQ>
    <xmx:EzopZSn8taK2xIPAFcik-leP18aKyNLUz-U5J6aITFDklQq-6xbM0w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Oct 2023 08:37:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 830fe830 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Oct 2023 12:37:36 +0000 (UTC)
Date: Fri, 13 Oct 2023 14:37:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH] commit: detect commits that exist in commit-graph but not in
 the ODB
Message-ID: <b0bf576c51a706367a758b8e30eca37edb9c2734.1697200576.git.ps@pks.im>
References: <ZSkCGS3JPEQ71dOF@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="K6vEJ84LU30PsE27"
Content-Disposition: inline
In-Reply-To: <ZSkCGS3JPEQ71dOF@tanuki>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--K6vEJ84LU30PsE27
Content-Type: text/plain; charset=us-ascii
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

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit.c                |  7 ++++++-
 t/t5318-commit-graph.sh | 23 +++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index b3223478bc..109e9217e3 100644
--- a/commit.c
+++ b/commit.c
@@ -572,8 +572,13 @@ int repo_parse_commit_internal(struct repository *r,
 		return -1;
 	if (item->object.parsed)
 		return 0;
-	if (use_commit_graph && parse_commit_in_graph(r, item))
+	if (use_commit_graph && parse_commit_in_graph(r, item)) {
+		if (!has_object(r, &item->object.oid, 0))
+			return quiet_on_missing ? -1 :
+				error(_("commit %s exists in commit-graph but not in the object databa=
se"),
+				      oid_to_hex(&item->object.oid));
 		return 0;
+	}
=20
 	if (oid_object_info_extended(r, &item->object.oid, &oi, flags) < 0)
 		return quiet_on_missing ? -1 :
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index ba65f17dd9..25f8e9e2d3 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -821,4 +821,27 @@ test_expect_success 'overflow during generation versio=
n upgrade' '
 	)
 '
=20
+test_expect_success 'commit exists in commit-graph but not in object datab=
ase' '
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
+		test_must_fail git rev-parse HEAD~2 2>error &&
+		grep "error: commit $oid exists in commit-graph but not in the object da=
tabase" error
+	)
+'
+
 test_done
--=20
2.42.0


--K6vEJ84LU30PsE27
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUpOg4ACgkQVbJhu7ck
PpSSCxAAhp54WnQ5s/vTWwS2Eiq4jRBWVg2ONWGFJhUyZYeFuCx/eND5tnGSE+TX
Ajj9NM6J+yu+WYvzqGToLMgr69ruV8aQJ2BvhZIcFGAwz03Cv23boxovXmQ8LugL
tbuu+bGt321FEb27r0NebdY8NyjjXSFMphI+h7GTQIuMZhBXFpMuD7e8Ug41Ni0m
0wusjunqGEacV/mLCE5tBRMaLKhwgHAbXsZBygfXqNvXVDPAMGO+mhfJQD573i60
A3SsW0eWGsmjSNi87WrkJvHa6mC8PVovdQmuSZJJan7pLbZCPa3qh/ommdQMDjlB
gaFMlQhjUXbuiG6qZX3wyrVDMPQldXpUgoxk4MoVjyS5TfAMQfsRiIYrUOkNc/XN
29jGqVrrHCjblZ6VM6F4DTaXHhtJViObc8gk1Xq6XtzlCIkH2GjSeYPuXVxTPvIX
1DMuk4eUbE+s6QO9Py5Nel3GiMG/NZPgIDwqD9gXiuygrQAgapUNEA2eDrE34FBk
BGNaSAPho05rZi6wOw9ted6cPEc9x1MsK2Zg6Xqp7kOfBGmzqgIaTnV6wqI6kY0k
Vzm4MgSGEk3KiV+ZbGAtaXBq/tltnoN6m8hhp1Wp6GcjDWD8G4xkGyrNluMTL9BJ
uf5Tf4E/AHU0JUu6WEhYe5xYADy3Du5BaaFkXFyqsxnokarQlvY=
=7qRh
-----END PGP SIGNATURE-----

--K6vEJ84LU30PsE27--

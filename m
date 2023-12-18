Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBED12B6C
	for <git@vger.kernel.org>; Mon, 18 Dec 2023 10:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UDa/pkzZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1Yuz38Rg"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id DA1355C0069;
	Mon, 18 Dec 2023 05:02:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 18 Dec 2023 05:02:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1702893752; x=1702980152; bh=Aw7Ec2h9RxeU/HG1XtCXLlgqmtJv8qQ4
	EFF/2LFIz5c=; b=UDa/pkzZEPOMyjk5J48pSIzrKGKkBm7/1h1jMCQKlmmy/9dd
	2Gq9pPKQmACFvdKnl9635p81HyxYhzyWM1xQlcjZcr42T1nMCjytNoP0BWA3iMEF
	rZFxNA10pLJoI3I32vqL90hU7V3txA4yi6r+3yzbwbiDaZ3CcuSIBneXbNmI+KIt
	rvFRHdowWPShpEGHP8Tusr/q2ruDiUXt/AZfu9aATo2x/xkw1tkEqvJkjT5MxZSc
	2cqsPD+7cPii1L0THQkJfZHOvKaLWSiocchxJguDLN7YXu5e9j7NcQ5dzTWuJzMn
	tYqkQNfXpJgZRyqxk0mZCG87H7clbEOaBkFF+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1702893752; x=1702980152; bh=Aw7Ec2h9RxeU/HG1XtCXLlgqmtJv8qQ4EFF
	/2LFIz5c=; b=1Yuz38RgAA62DNOLNtdkVql3Uc+oRi05FNvepTK1qGceJV6c7u0
	hzTIrTjDd5kvZnmsixqjBK2m8sMswSBbSN/r65y3BHORXH8Y8xbnhZ2gOUggWrYk
	Rk5eR1PMuIsNIxLgmPWeOJLITVae41eNqPCHzwntGJiphduCbI4mnALxjgS0jfZa
	GHLvZ5cI0NYqOn4TLHZOBaC68SxYmIz1DLaAgmsGXr+TsuFRKbBTPi/9ykFuG9+C
	3RKREMb67oYsmro3f9qw4mb754BucQZnqxQFU2kYbyrPGr3J0QGqIUYK1LU0R5nh
	xf74bbRWDdlVxqR/7dmGK8nw7QnczSntLmQ==
X-ME-Sender: <xms:uBiAZfe2FN5alkleGSsc-ZQWhbJB4CftTmHKYUy-0zUBEcMIwAc2zg>
    <xme:uBiAZVPt3VAJ1cgEaYlnR9BEIGSpE5k6Xipb9wtzAaVEdhbQvMnpuEX1OU0lMk2sa
    stJVQpO-xnA_bZjWQ>
X-ME-Received: <xmr:uBiAZYj2mosq840J6mN_AuqR_7qPYQt8Q70teN_eaMoFjv-xANUuLWJf4kKphWST2EDWdEQ2roNOD7rszRr2uxkRhmNr5fPK77MS2yZ-NIrCXVo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtkedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfggtggusehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeeugfeutdeuieehteelveegudejkeejheelje
    ejhffhgffhvefgkeeukeejtdeijeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:uBiAZQ-UvCSupQbJQk8wkAXKOuyiNCNOtyYdRTVZM3EHkrNbaRkOXQ>
    <xmx:uBiAZbtIaM0V3v3mgSa0H293-cBY1_kXrkV2cpcR7Vrh1q7njFGnfw>
    <xmx:uBiAZfGVCd491QsbThavae3VUnGYJLeQgbT7HuQWAVZdsAmJJFMjlw>
    <xmx:uBiAZZ1cDYBj-I84YiL8ruoutUHyN7TQ6fxRHIHuLfEah5jtMAgj1A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Dec 2023 05:02:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bafded0f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Dec 2023 10:00:39 +0000 (UTC)
Date: Mon, 18 Dec 2023 11:02:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH] commit-graph: fix memory leak when not writing graph
Message-ID: <0feab5e7d5bc6275e2c7671cd8f6786ea86fd610.1702891190.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="153xU+yJqYgIcTzE"
Content-Disposition: inline


--153xU+yJqYgIcTzE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When `write_commit_graph()` bails out writing a split commit-graph early
then it may happen that we have already gathered the set of existing
commit-graph file names without yet determining the new merged set of
files. This can result in a memory leak though because we only clear the
preimage of files when we have collected the postimage.

Fix this issue by dropping the condition altogether so that we always
try to free both preimage and postimage filenames. As the context
structure is zero-initialized this simplification is safe to do.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-graph.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index acac9bf6e1..afe0177ab2 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2617,19 +2617,16 @@ int write_commit_graph(struct object_directory *odb,
 	oid_array_clear(&ctx->oids);
 	clear_topo_level_slab(&topo_levels);
=20
-	if (ctx->commit_graph_filenames_after) {
-		for (i =3D 0; i < ctx->num_commit_graphs_after; i++) {
-			free(ctx->commit_graph_filenames_after[i]);
-			free(ctx->commit_graph_hash_after[i]);
-		}
-
-		for (i =3D 0; i < ctx->num_commit_graphs_before; i++)
-			free(ctx->commit_graph_filenames_before[i]);
+	for (i =3D 0; i < ctx->num_commit_graphs_before; i++)
+		free(ctx->commit_graph_filenames_before[i]);
+	free(ctx->commit_graph_filenames_before);
=20
-		free(ctx->commit_graph_filenames_after);
-		free(ctx->commit_graph_filenames_before);
-		free(ctx->commit_graph_hash_after);
+	for (i =3D 0; i < ctx->num_commit_graphs_after; i++) {
+		free(ctx->commit_graph_filenames_after[i]);
+		free(ctx->commit_graph_hash_after[i]);
 	}
+	free(ctx->commit_graph_filenames_after);
+	free(ctx->commit_graph_hash_after);
=20
 	free(ctx);
=20

base-commit: 1a87c842ece327d03d08096395969aca5e0a6996
--=20
2.43.GIT


--153xU+yJqYgIcTzE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWAGLMACgkQVbJhu7ck
PpSerg//UZ2dWEqZuHO9Rb8aYGp30/DpVZwOE9r0qQwCaSnRgqC9IaxzRCOo+Jn6
thl67MXGDbDuvwCjl+0wOAs/T87dOJ6Q3LydMhyZ75buFxcsLfP3gu4U0o6k090E
w8CIXKlSZTmWISfqah7mIG31ZVAGrq6EfimI6TRANOMrYqHZ0bkFr+iFXoJRZCGJ
JQ1Xr9tQEdUQGvrYZBrQJgZRekaXFqVIyqs5R397aflUZFl53586gkyCbs9yF0OH
jou8MG3xx7fcbxzWnOO1b5dJJ/fMInZ3zFqWIOQvFVxqKew+IVRr/BvuzA6L+YAv
YwnYBAW9mPoXLm2vzWpAXV5DUN3w1RRZ8oRf2i3fADNSdKnkR3FMl4HO/gaa1lOu
o55PxYBv5ecELrzbQF6jCjctW7gewlgFOLAAPS42IizYLSbiZy22RurPYWUAJSU5
rUv2rkTGYMzeTYo1MSLJArOJop4Rr8J4hLFb8++QzzmG/RWxJeIkgOMmHuYNbF0/
Mo1rXcxkcJwX/ZRWVw9AMpA8Rd5/EaK2C1UwCPnNHyCDo16zo993CX/FAb2Bk7Nc
49HZ1gxeymdu1wvsE3huRxTzl96XzLgU19WnDR8Nx3lBJU7dvFlo/A1Ytf9XelLT
bPfqG7YbOyyYgrTjMGHmSy3pRILFQgM1bDcPGkn/H+1lb+Otx2o=
=uGOg
-----END PGP SIGNATURE-----

--153xU+yJqYgIcTzE--

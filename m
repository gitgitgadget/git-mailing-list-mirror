Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6154929404
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KejSKgq0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yf5bZ1Ah"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C68510F7
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 06:10:45 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 3BF4B3200A27;
	Tue, 24 Oct 2023 09:10:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 24 Oct 2023 09:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698153043; x=1698239443; bh=4k
	7MKiB3q6wYj5DiWFe3VjKUx/nnZuUeoUeNiE2DEms=; b=KejSKgq0uDk3KRR9yL
	qxdzhq2VJvPXGDY/LI3mU9ToxU6QHCJsSUU4QB2aTyspJLi9dUV0ep2FmO5BuqVA
	oDIrYzAps6uTw9nPBPHVHOlYptno68ViLxq9iQ586J4zXuvMzVG1bl/FwZQ9wxWN
	/MIBRJDwqGyJgWNmV6OHh4xar8tqzCr6XuoGlOqPDk6igv5ehaKMsLz7BTNAUa5T
	a/W6lR8P1OOw50/ZSgDd3/gWZZhaFWgg47n5MIQ+beHcv+iAjkGrLxlV7rJTjtjM
	x3A7APUU7D+GAVT9pRLpPFcnC5RCnmyZmkZmlm42OJgQhU9l07gCHzUBrTa6L8jC
	ZpOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698153043; x=1698239443; bh=4k7MKiB3q6wYj
	5DiWFe3VjKUx/nnZuUeoUeNiE2DEms=; b=Yf5bZ1AhG+pYixPzDKbX7gQiOWidn
	Udq3QkSbGV0A8CzjhlAo8B3+Qo0q4z6ExQaTdSRiT2ZZTVNAeHQkw+6s3ThnWzUW
	OQUaAfHVITL71X7zzIZnFG/OmReOOPI/9U2Qau0xZqsSBiEczBFjoWPt7dZgXDhj
	IcTTPpXDjUqaelFwZQdEUKDp5mMN2ZCO9hT4zk8wl5NchifVIKkMOdeCvRZeVUwD
	lzwD+THxWgIXjTOzvPoXXpUfYsfzZ8slp3ibuH9u4CglbuFsVRRg7pl5lvn6A9+0
	KSNn4sWuKg+qa8PQ4kj6t7mcWUuj7EAUO+LtiKlBfCZfS3yokmyKJpfOg==
X-ME-Sender: <xms:U8I3Zbkefyv30CzOP_lBWpgQX14w3VEhDcByBUz4rMOrhd_CeKQRBg>
    <xme:U8I3Ze1mPMMdzZOMYepzftjQfcqs-jJ9E-4tRASbQCrY0RiIbNK3rFuD-5PUP1d4n
    PQcWeKMbTo3EqnbWA>
X-ME-Received: <xmr:U8I3ZRoZDcUNNa-6phRa1UQWKgi-faWu2fwYo3Z9e28rguwvT9xVeXtNoDSJAnYWlJ8JCWSOCCqa_BvQJFmQCt-VsCg8w-yRc4yKCluDhORhUHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeekgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:U8I3ZTl4_J8ukCXQU_GfwXNU_rnEwUYlP97mkZqO0L-i_rF4K_koYw>
    <xmx:U8I3ZZ0qUnHy6ILOoaMVhrALX0wcUGGThW1HqJtEUZNxq9032Mli3A>
    <xmx:U8I3ZSvP5wF-riqeFU0KahC2HUn_aXx6tuUm__Ip-kYDEpjlahQxJA>
    <xmx:U8I3ZXAOiwzcY3ekYw64yCf1jUGDLz6LuDhJjznb7tKVFS8zonRHuA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Oct 2023 09:10:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d377ceae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Oct 2023 13:10:37 +0000 (UTC)
Date: Tue, 24 Oct 2023 15:10:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 01/12] builtin/show-ref: convert pattern to a local variable
Message-ID: <78163accbd2c39721249474512dedd8ed2f0fe4e.1698152926.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NcnBag3+U2E3FSqN"
Content-Disposition: inline
In-Reply-To: <cover.1698152926.git.ps@pks.im>


--NcnBag3+U2E3FSqN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `pattern` variable is a global variable that tracks either the
reference names (not patterns!) for the `--verify` mode or the patterns
for the non-verify mode. This is a bit confusing due to the slightly
different meanings.

Convert the variable to be local. While this does not yet fix the double
meaning of the variable, this change allows us to address it in a
subsequent patch more easily by explicitly splitting up the different
subcommands of git-show-ref(1).

Note that we introduce a `struct show_ref_data` to pass the patterns to
`show_ref()`. While this is overengineered now, we will extend this
structure in a subsequent patch.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/show-ref.c | 46 ++++++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 5110814f796..7efab14b96c 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -20,7 +20,6 @@ static const char * const show_ref_usage[] =3D {
=20
 static int deref_tags, show_head, tags_only, heads_only, found_match, veri=
fy,
 	   quiet, hash_only, abbrev, exclude_arg;
-static const char **pattern;
 static const char *exclude_existing_arg;
=20
 static void show_one(const char *refname, const struct object_id *oid)
@@ -50,15 +49,21 @@ static void show_one(const char *refname, const struct =
object_id *oid)
 	}
 }
=20
+struct show_ref_data {
+	const char **patterns;
+};
+
 static int show_ref(const char *refname, const struct object_id *oid,
-		    int flag UNUSED, void *cbdata UNUSED)
+		    int flag UNUSED, void *cbdata)
 {
+	struct show_ref_data *data =3D cbdata;
+
 	if (show_head && !strcmp(refname, "HEAD"))
 		goto match;
=20
-	if (pattern) {
+	if (data->patterns) {
 		int reflen =3D strlen(refname);
-		const char **p =3D pattern, *m;
+		const char **p =3D data->patterns, *m;
 		while ((m =3D *p++) !=3D NULL) {
 			int len =3D strlen(m);
 			if (len > reflen)
@@ -180,6 +185,9 @@ static const struct option show_ref_options[] =3D {
=20
 int cmd_show_ref(int argc, const char **argv, const char *prefix)
 {
+	struct show_ref_data show_ref_data =3D {0};
+	const char **patterns;
+
 	git_config(git_default_config, NULL);
=20
 	argc =3D parse_options(argc, argv, prefix, show_ref_options,
@@ -188,38 +196,40 @@ int cmd_show_ref(int argc, const char **argv, const c=
har *prefix)
 	if (exclude_arg)
 		return exclude_existing(exclude_existing_arg);
=20
-	pattern =3D argv;
-	if (!*pattern)
-		pattern =3D NULL;
+	patterns =3D argv;
+	if (!*patterns)
+		patterns =3D NULL;
=20
 	if (verify) {
-		if (!pattern)
+		if (!patterns)
 			die("--verify requires a reference");
-		while (*pattern) {
+		while (*patterns) {
 			struct object_id oid;
=20
-			if ((starts_with(*pattern, "refs/") || !strcmp(*pattern, "HEAD")) &&
-			    !read_ref(*pattern, &oid)) {
-				show_one(*pattern, &oid);
+			if ((starts_with(*patterns, "refs/") || !strcmp(*patterns, "HEAD")) &&
+			    !read_ref(*patterns, &oid)) {
+				show_one(*patterns, &oid);
 			}
 			else if (!quiet)
-				die("'%s' - not a valid ref", *pattern);
+				die("'%s' - not a valid ref", *patterns);
 			else
 				return 1;
-			pattern++;
+			patterns++;
 		}
 		return 0;
 	}
=20
+	show_ref_data.patterns =3D patterns;
+
 	if (show_head)
-		head_ref(show_ref, NULL);
+		head_ref(show_ref, &show_ref_data);
 	if (heads_only || tags_only) {
 		if (heads_only)
-			for_each_fullref_in("refs/heads/", show_ref, NULL);
+			for_each_fullref_in("refs/heads/", show_ref, &show_ref_data);
 		if (tags_only)
-			for_each_fullref_in("refs/tags/", show_ref, NULL);
+			for_each_fullref_in("refs/tags/", show_ref, &show_ref_data);
 	} else {
-		for_each_ref(show_ref, NULL);
+		for_each_ref(show_ref, &show_ref_data);
 	}
 	if (!found_match) {
 		if (verify && !quiet)
--=20
2.42.0


--NcnBag3+U2E3FSqN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU3wk8ACgkQVbJhu7ck
PpS3VBAAgnc+SglazDlFTC3nZ4Nx8ahSCAf+7X7OLDcgEiZUvKe+008j1YtihUm4
CeAVdunw43x/Bk5tR6duBPTRM71shvGEuIwXVJCRpJYXmxQ6eY1oKpeCaGGnJ1UN
7Ph+yoFHdeDguh9+ZVdNxyGVDGBezGTS60AXURp5f/v9bFpf5lVWvxF2XMeCSIAZ
6Cc0uVNQ8C8lcKrP9X0mh+bVvAmyW8KsUxeE7nQwWtn7gS/Ha8YXk1Cz7EL4lxmK
HA02THI0qDwl+c3q+3dBwr8e0Sh0DalDzRpSD1S9EH6aozMWNygyPsMYZ1d2YqXh
e3gcS35shJw2au6vPfv5DMXLKQhIZSpa6mC+Dx6x9+157ODQo9etVi10sbyi0mjg
6P03e/vD34MARjLXX5ZOtJNiph36oaEBe0AlVKZRn/up37b4n20CuFVOs8A/wxz2
SZBTxEoBWr0P79iNmI5hqCp1J8AehBTN9JaTPDYorhHac6zWH3KGMUEmadYecgz9
34Li3V49D0l+FW2DidyFCrygA0E+F3Eooz3Tox9jmKU/0zLRFUJFuSebzZa4g8U/
KsXWYWqrYcJbatzLL5uQvf5e38k+5MWmJoV8Zf7/Pedi2IGpOsNr6g8LOjbPtGbm
xKgqkJUTS4QSTIHTkQqS9nXeHXMjoq7PwHd6+3ssF0ssujhM/LA=
=Fb0X
-----END PGP SIGNATURE-----

--NcnBag3+U2E3FSqN--

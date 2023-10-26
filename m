Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C412D021
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 09:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n4dcPhDm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O6hX/jdD"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0678195
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 02:56:41 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id C3447320098F;
	Thu, 26 Oct 2023 05:56:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 26 Oct 2023 05:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698314200; x=1698400600; bh=uj
	kcj6m7fp9gXatQniAyqp/mjcc/GgjYBPUh5MEmZ34=; b=n4dcPhDmMqoGRRp75u
	pctDRW34T6s4RWslnlc3/7IOSqFa3lew3jFEDDP1oEs2it7brDsLNX4ElsDfC+xs
	zaoy2YlOBmOIkTU5xDA65DbvC+e1uia8s6dKtJCCUy1vyiNbQxNy5hDO7l1SF9AE
	5S0Oa9XjGUH7nNKBNckMZJcBJr17GYjmMWQPufundZcSDdvehL9Ohu+SkqO0GLWR
	7yYJ5MAlABQO5A8eW8NfN2pgticjFLwicMMG1DYZLJk8GAyzQUZyWmnDKy8vw0AX
	maAmx4HkoQPHM1Ti+zXdvEEIil/F5T/fgHvxDc/UWnJd7NzHq2Nn3ja25ie495hx
	dsIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698314200; x=1698400600; bh=ujkcj6m7fp9gX
	atQniAyqp/mjcc/GgjYBPUh5MEmZ34=; b=O6hX/jdDOzlDKcgVxidv5e/cYnX1T
	g38mAH1DJwf0N0AQAHJRdmp947cuPnqmf33AQTzP8F0dkyrq/fANO/mHLc7xTkJW
	iQe/xXE2VXsjkfc0sNcLTl4Vf6cUyA9mid4rWLzWnfP7HURn2BErsMjQZP3D9i9l
	GKI/r6J9y+e8uTtly/yceO26ZqdfDWDSOTQ8c4Mw3fA9jaUWLjC7BFX4XStX0EQm
	2bVSw7LyVTr7j6Rs5Z3DilJi4B4ZVACGm2yMay2bGxho6fQzKvExU+IEwv1j0y25
	OfRmXs49sVtFIjUa8sUJjMBmWllHQO+8HvpitTutfR5SpFV0YcvlKhiDg==
X-ME-Sender: <xms:2Dc6Za7eAXmo4WQKy393e8wZigHzkdLEDbBcRTjldyQFdGIGkBmvnQ>
    <xme:2Dc6ZT5AOqjueCSu9g3Yy_yA85aTstQ8iepsWSJ1ERkFg-nOHpLdX4N6c4Iz0KUHi
    TZYnePZiPLkluy2Ug>
X-ME-Received: <xmr:2Dc6ZZdmDeu5ZPkVyyQHsJiJbiTM-s1q6t_oLaIgIa7fQgI1dEdd9iwytUeqKTuU3LKs51u6J38nKdjycmZyst8CwU87_DHbf4zdbYYDwSWkmwU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledvgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:2Dc6ZXLE9-ggdGuYS8et9KSWreSqy64HqvLnWotL_6ezgPyS9Ppd9A>
    <xmx:2Dc6ZeLUWP2AUILS9Y7v7qFN37WGxCysrvyHjWMmOwoeT7Go0qV9kw>
    <xmx:2Dc6ZYxMVGsBmO9T2aPgqPOsts7dXdCJ_ZQukyOSBIBYWXFwpAJlIw>
    <xmx:2Dc6ZVXcILSgsMb1_H6tQFyVyltWq6p-sp5OnVlrFfd7_VRcrKfAaA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Oct 2023 05:56:39 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 36a09362 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Oct 2023 09:56:31 +0000 (UTC)
Date: Thu, 26 Oct 2023 11:56:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v2 05/12] builtin/show-ref: refactor `--exclude-existing`
 options
Message-ID: <bed2a8a07696371e07c0b2d1282ed51c0b1b9fee.1698314128.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
 <cover.1698314128.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ivoMxkj8SVjOiFO0"
Content-Disposition: inline
In-Reply-To: <cover.1698314128.git.ps@pks.im>


--ivoMxkj8SVjOiFO0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It's not immediately obvious options which options are applicable to
what subcommand in git-show-ref(1) because all options exist as global
state. This can easily cause confusion for the reader.

Refactor options for the `--exclude-existing` subcommand to be contained
in a separate structure. This structure is stored on the stack and
passed down as required. Consequently, it clearly delimits the scope of
those options and requires the reader to worry less about global state.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/show-ref.c | 74 +++++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 34 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index f95418d3d16..90481c58492 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -19,8 +19,7 @@ static const char * const show_ref_usage[] =3D {
 };
=20
 static int deref_tags, show_head, tags_only, heads_only, found_match, veri=
fy,
-	   quiet, hash_only, abbrev, exclude_arg;
-static const char *exclude_existing_arg;
+	   quiet, hash_only, abbrev;
=20
 static void show_one(const char *refname, const struct object_id *oid)
 {
@@ -95,6 +94,11 @@ static int add_existing(const char *refname,
 	return 0;
 }
=20
+struct exclude_existing_options {
+	int enabled;
+	const char *pattern;
+};
+
 /*
  * read "^(?:<anything>\s)?<refname>(?:\^\{\})?$" from the standard input,
  * and
@@ -104,11 +108,11 @@ static int add_existing(const char *refname,
  * (4) ignore if refname is a ref that exists in the local repository;
  * (5) otherwise output the line.
  */
-static int cmd_show_ref__exclude_existing(const char *match)
+static int cmd_show_ref__exclude_existing(const struct exclude_existing_op=
tions *opts)
 {
 	struct string_list existing_refs =3D STRING_LIST_INIT_DUP;
 	char buf[1024];
-	int matchlen =3D match ? strlen(match) : 0;
+	int patternlen =3D opts->pattern ? strlen(opts->pattern) : 0;
=20
 	for_each_ref(add_existing, &existing_refs);
 	while (fgets(buf, sizeof(buf), stdin)) {
@@ -124,11 +128,11 @@ static int cmd_show_ref__exclude_existing(const char =
*match)
 		for (ref =3D buf + len; buf < ref; ref--)
 			if (isspace(ref[-1]))
 				break;
-		if (match) {
+		if (opts->pattern) {
 			int reflen =3D buf + len - ref;
-			if (reflen < matchlen)
+			if (reflen < patternlen)
 				continue;
-			if (strncmp(ref, match, matchlen))
+			if (strncmp(ref, opts->pattern, patternlen))
 				continue;
 		}
 		if (check_refname_format(ref, 0)) {
@@ -201,44 +205,46 @@ static int hash_callback(const struct option *opt, co=
nst char *arg, int unset)
 static int exclude_existing_callback(const struct option *opt, const char =
*arg,
 				     int unset)
 {
+	struct exclude_existing_options *opts =3D opt->value;
 	BUG_ON_OPT_NEG(unset);
-	exclude_arg =3D 1;
-	*(const char **)opt->value =3D arg;
+	opts->enabled =3D 1;
+	opts->pattern =3D arg;
 	return 0;
 }
=20
-static const struct option show_ref_options[] =3D {
-	OPT_BOOL(0, "tags", &tags_only, N_("only show tags (can be combined with =
heads)")),
-	OPT_BOOL(0, "heads", &heads_only, N_("only show heads (can be combined wi=
th tags)")),
-	OPT_BOOL(0, "verify", &verify, N_("stricter reference checking, "
-		    "requires exact ref path")),
-	OPT_HIDDEN_BOOL('h', NULL, &show_head,
-			N_("show the HEAD reference, even if it would be filtered out")),
-	OPT_BOOL(0, "head", &show_head,
-	  N_("show the HEAD reference, even if it would be filtered out")),
-	OPT_BOOL('d', "dereference", &deref_tags,
-		    N_("dereference tags into object IDs")),
-	OPT_CALLBACK_F('s', "hash", &abbrev, N_("n"),
-		       N_("only show SHA1 hash using <n> digits"),
-		       PARSE_OPT_OPTARG, &hash_callback),
-	OPT__ABBREV(&abbrev),
-	OPT__QUIET(&quiet,
-		   N_("do not print results to stdout (useful with --verify)")),
-	OPT_CALLBACK_F(0, "exclude-existing", &exclude_existing_arg,
-		       N_("pattern"), N_("show refs from stdin that aren't in local repo=
sitory"),
-		       PARSE_OPT_OPTARG | PARSE_OPT_NONEG, exclude_existing_callback),
-	OPT_END()
-};
-
 int cmd_show_ref(int argc, const char **argv, const char *prefix)
 {
+	struct exclude_existing_options exclude_existing_opts =3D {0};
+	const struct option show_ref_options[] =3D {
+		OPT_BOOL(0, "tags", &tags_only, N_("only show tags (can be combined with=
 heads)")),
+		OPT_BOOL(0, "heads", &heads_only, N_("only show heads (can be combined w=
ith tags)")),
+		OPT_BOOL(0, "verify", &verify, N_("stricter reference checking, "
+			    "requires exact ref path")),
+		OPT_HIDDEN_BOOL('h', NULL, &show_head,
+				N_("show the HEAD reference, even if it would be filtered out")),
+		OPT_BOOL(0, "head", &show_head,
+		  N_("show the HEAD reference, even if it would be filtered out")),
+		OPT_BOOL('d', "dereference", &deref_tags,
+			    N_("dereference tags into object IDs")),
+		OPT_CALLBACK_F('s', "hash", &abbrev, N_("n"),
+			       N_("only show SHA1 hash using <n> digits"),
+			       PARSE_OPT_OPTARG, &hash_callback),
+		OPT__ABBREV(&abbrev),
+		OPT__QUIET(&quiet,
+			   N_("do not print results to stdout (useful with --verify)")),
+		OPT_CALLBACK_F(0, "exclude-existing", &exclude_existing_opts,
+			       N_("pattern"), N_("show refs from stdin that aren't in local rep=
ository"),
+			       PARSE_OPT_OPTARG | PARSE_OPT_NONEG, exclude_existing_callback),
+		OPT_END()
+	};
+
 	git_config(git_default_config, NULL);
=20
 	argc =3D parse_options(argc, argv, prefix, show_ref_options,
 			     show_ref_usage, 0);
=20
-	if (exclude_arg)
-		return cmd_show_ref__exclude_existing(exclude_existing_arg);
+	if (exclude_existing_opts.enabled)
+		return cmd_show_ref__exclude_existing(&exclude_existing_opts);
 	else if (verify)
 		return cmd_show_ref__verify(argv);
 	else
--=20
2.42.0


--ivoMxkj8SVjOiFO0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU6N9UACgkQVbJhu7ck
PpSHIA//RpN/6EdWm+0o6WWJ50zFtvrSLLE2EvD0L+tO4cQ6HFDxocUMJIxl8tmY
2C/jYz2GgFcD8z1HD6kXjlaaN7a81LzYRGgO0aPRqKlzlSh62f3Fu12DTNhvNX7E
FPctSp30aCgz4MFP9KaRoZ7MAXGB8+kAlo814plGN7Vj0IUBNawEKlvOrxO9opT1
swyMFFV9JqjDPPoMesvl+Tzk7nU6zqbpFJZnOKo8Z+5MirIBRtxIO0bJTkwoLvmE
5zGbhaQY5KekG75+ekXUg5nssM3YdTRlVgJluEY48MAzRUxg5QTmt0BbeBXfbHay
JhwABGi08Laa6/58+18jgfxjCDoyWxzxjB78Qj3n8MTElYwWS8vqx1MTrdbys6If
tsra6F/j5hSGAHPHjIPQ8cNwZKpALTISyWKquZA+dargV+TIYIrCsTi4iLj8uJ9j
T9RP7ysjQdvsd0+lFSim/wUnh+ShsA/V7Fg6yGmgYmY0teolOWRTbRdbXXQabhAK
TMBEAbDZtvDSorFjmHezK3RBFLT9BAp7TTj5GLQo0lkIXihpgxF3SJXLh8l8/tTq
yulpyP2UXGPelHLX1qifIaDDqsGwZwT0dhFx+42dHdvpiM08Bt2QeR6HzyhI5swY
l89Ou1uvM0c7z35RPlnz8EWS6XtiAO1nH3FimGnAlokBpoWs5v0=
=jYGk
-----END PGP SIGNATURE-----

--ivoMxkj8SVjOiFO0--

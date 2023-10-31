Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB8B12B7B
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 08:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BOUZimzk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HRLa8OOp"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4454ADF
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 01:16:34 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 7C1A43200A37;
	Tue, 31 Oct 2023 04:16:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 31 Oct 2023 04:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698740193; x=1698826593; bh=dt
	6bEe1Q02K19CGzEmyJmcGdmoeXdrBuAvVz3AVdWTk=; b=BOUZimzkhfraBhYRUR
	5Auuy6eWXaT65z407TTpuH0n2qoAsDYEdp78LBVvUbtbUnZcvQyYAGZzzHFiLr82
	or38lEt2Qasy+LeTfPDSZFTMS/EyvGMy95ac/p3ckeVklpGkj9ruQKdcG+l27ztp
	WzDyNvCogLrsmUjItO7uNxofm7v1N55EdZmiIi8AaN27gRHPXqq+PuCALd0izZwg
	9DukZ8L2xgraVmPMpPU62sAjEJ+3S9XjiyQmYM5lFMHjv51aidyrf9nyafzGPTvz
	kO9C0mYlONahANEOgT3KHwxwMyDFH62pCL63rpBy6NkD0GS5C3gvc1GAAZWMHiAu
	eCLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698740193; x=1698826593; bh=dt6bEe1Q02K19
	CGzEmyJmcGdmoeXdrBuAvVz3AVdWTk=; b=HRLa8OOppSJ+lyyV0qMc1F3LFY7nW
	HtA1d67nF0GyRlGrACS/j0fUNcRXygZVy1s/RbgWtLZvvk4wcNBIn03RweNawalC
	AjD1xadU2WYiyEmud3Kjzcpi0FG7wMh0XR8ZOEzZZXJoWMFdTJdNALb/E2kcomuW
	Ba3qji/s9LW3RwqP4JvKjX91IsWo306lOh7QB2I5wZDInFJvPua/wF02Is2tgtrX
	4SZ+F1glUHfj8wEyYfEIWGyPI7/WHRYEEKPiRSxrJ4cGKWwBgCIDD7xmyqPHNLQc
	zlITrOWJQ4j/whCHsEgJBRXtCyVM4OWjAyIIXRTZBqERXp8tegsW7ISIA==
X-ME-Sender: <xms:4LdAZZYxwSVbhCgY5EfHaTLT32IAP4qZ-67WYObujL3_AIMsCb9_nw>
    <xme:4LdAZQb9DLj9UoPGgOu7KgxC-MGecWTS2ZAAK1AgtKJV_unvFm6NQDNjG3oXwo8vd
    bs085bIaeWckbY9kA>
X-ME-Received: <xmr:4LdAZb93w3VvmNiTUQcft6UXXu0aBrEos_WtvNsBOMZZ34ohg8seCbcQpni1DUOqqBREbnI7bNdvmrivMJl2DAFnzeFoHS6gI2lfTrqD8CN3SMUi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:4bdAZXoCxwyffF8gA33pMZPR8Yni8PGq7HKjOfMqjLCQiKPvHl3waA>
    <xmx:4bdAZUpusY00cqAdKWzrIEcvS2w1at-EYvtYc-f_iWIwANRDqVQQSA>
    <xmx:4bdAZdQNwRZVUqukLRWkbBnLWEpORdYU-7GhrM2YOm1cSwKvfqumSg>
    <xmx:4bdAZfXZxWdcYE44fLAm41PQpbF68s_OD3I4tKvoflse7TyRS0baUg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 04:16:31 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0973973a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Oct 2023 08:16:23 +0000 (UTC)
Date: Tue, 31 Oct 2023 09:16:29 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v3 05/12] builtin/show-ref: refactor `--exclude-existing`
 options
Message-ID: <b47440089b6701061786b5729501bbbbda8387be.1698739941.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
 <cover.1698739941.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6NasJylcbQEugp6G"
Content-Disposition: inline
In-Reply-To: <cover.1698739941.git.ps@pks.im>


--6NasJylcbQEugp6G
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
 builtin/show-ref.c | 78 ++++++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 34 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index f95418d3d16..5aa6016376a 100644
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
@@ -95,6 +94,15 @@ static int add_existing(const char *refname,
 	return 0;
 }
=20
+struct exclude_existing_options {
+	/*
+	 * We need an explicit `enabled` field because it is perfectly valid
+	 * for `pattern` to be `NULL` even if `--exclude-existing` was given.
+	 */
+	int enabled;
+	const char *pattern;
+};
+
 /*
  * read "^(?:<anything>\s)?<refname>(?:\^\{\})?$" from the standard input,
  * and
@@ -104,11 +112,11 @@ static int add_existing(const char *refname,
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
@@ -124,11 +132,11 @@ static int cmd_show_ref__exclude_existing(const char =
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
@@ -201,44 +209,46 @@ static int hash_callback(const struct option *opt, co=
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


--6NasJylcbQEugp6G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVAt9wACgkQVbJhu7ck
PpRpGRAArHnBiJJjk+SZSt2MW0AHgTSLhg3D1cQZAOeXXvDPHpnLuLr0aDN8ctgl
8itmvKVB0HHiW+6kjif351tFpgJCkXv/M/fbyOIrSIDI2FcxIdp4klxx4q+wDa2c
sYxBccNiWdgo/QpgLOlAw4xoRZX2uQify2KtlHCBjM75u4acQCWmiTwaJ6NgeFyC
VoTiYek+0PyOQ1PE/8FcqC1rVH0goC+fqLaw7mMTT55ZVhruNR+pvkxMNA8ledrA
HPEI0r4lrLNqC/wBTdoNGRIipvPtddLbhkOLeXpJYFf/u9+VBMXuJ80a+a+PmU56
zgMQYTswrNjLPuaLRzYMjtpy7+B2zBulOUPdRRLfknLoii8pwJNN062WHN6rP1R3
r9Lt3iofiAKtoSJOGiMdOpcbEQps5gWtcVeU/ZxMsfbgOUHgkpvHaQPh97cotuyZ
aW54OV3H7mVoNB1eHjSxs8nsY0ysjdQEChGgtPgmuD/1DRoq4MOf4N4YG9N5CUX8
2Y8izdNZwg6HNzF1MV9ktsolGtRGQvCgOc2nO0upZLhhSvwLzKqudMSce1ZBNidP
Yz0zyN0DIpEZVrUbo2r8abM7WlcoGovDtcwsvbiTfTT8aK46i4oRvZj8Z8ASWYu0
qlzhoX+1TJ8DRyR82gr9eF/HloW0ouV9SwQ1x44PcQrzjdPf/O4=
=MK8Z
-----END PGP SIGNATURE-----

--6NasJylcbQEugp6G--

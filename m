Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7A62AB29
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 13:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GhbiEa4C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BUau//e8"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2599D12C
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 06:11:10 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 0D01832009A2;
	Tue, 24 Oct 2023 09:11:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 24 Oct 2023 09:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698153068; x=1698239468; bh=4O
	+QhhRPzjMcG4fhQuEBHVoFnp353aobwTW7NxcHFzw=; b=GhbiEa4CGL6eNTaqj7
	mjmaEMU70wW3DqMyrOfwDO3j4O3rx/n9nqeL85+2MYKiapzIAQwU5OuWFV/BFTJO
	MIFBm4DClW+c1NJLLVlpg3YYeMLRdrO8JAvgPm0/M5NoucfHBcrproh3gk8jo8+I
	3mBYFLCh5pyFSl37RJitdpn9heHrieFaiypx7wF2bASuuZrkuYBMQD1SBFh1dumj
	yum28QlojPE6PGvefqgv8ZiyIGhU9WBuNtjYwbNy3gYkFrOQik5Zqk7I8A9a1Uld
	yQ3zREISr4K69Mux0D3wZ8+cKA+Br+86uJMszz/M1ZPthJxRFquPrExY6dCYOGas
	Iy3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698153068; x=1698239468; bh=4O+QhhRPzjMcG
	4fhQuEBHVoFnp353aobwTW7NxcHFzw=; b=BUau//e8uSWPf+YoF2aPWNFEHH4t9
	uFhBIkb5I7k0nJbc6a5plyGepoamNyIVBHk+VjUJ8kF7PEfu2mpnAZ+37qL034Fi
	RJj2GU0XZ04ZUbittJG3P6JagljGGgBFzbLrLJ4jdrEw+6+FDTX77p93784/sc2m
	nN+M1/LIszgOPssXYcAjSdaZXvwIgqUQ2wMvo4R8WiOXic2h/QqzN5cQO1dDzTE/
	GzQsET4xhjCB6Hayd5ggHg/ttjkX0WjeN7iZza5SGKHAx9jjeIKhAjTHvA+GTSvw
	HjpPGUuUpzM/3h8r/0kYGx/bf+8GfKo2ywn05vvAT9VpiYH+vR7a+hntw==
X-ME-Sender: <xms:bMI3ZXS39LftXNd71KQcWrgr-r4qTMLdLTnhJgwshI-nmbBPYwB15w>
    <xme:bMI3ZYxw6i6emC_Cw6OVLzA2bziBPg95hWssxvVigFrejx77c6U0LrfBnvMizD6d9
    GeJeop7Mz3uw5tWUg>
X-ME-Received: <xmr:bMI3Zc0LYLul0gnlBDdns_N0Vnt0em8QR54ZDDBrviAvkZ-9qjdlBzLyHARna7O66wFwX1zr_2CNc8cwJ0K0XSDFFKfX0kJFy5bVBIBNWPzSPK0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeekgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:bMI3ZXCgXv5YMC7-qI9TmwN99GOb6ED19NbvdU5J4CE6eYUGzEuCRA>
    <xmx:bMI3ZQi08pViIXzYXrt_8hNpg1otCsidT7TfWhnkqONs4s74v_tH1w>
    <xmx:bMI3ZbpzXE5BzfUt-ZcRg3okRvcvvSkmMuV01PyeeCqCkWUFIQrddA>
    <xmx:bMI3ZTs6DcyyYeixAzuX01rcK4Ht2pntuTFu2N__oljwMGehUcFyDA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Oct 2023 09:11:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bbf255d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Oct 2023 13:11:02 +0000 (UTC)
Date: Tue, 24 Oct 2023 15:11:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 07/12] builtin/show-ref: stop using global vars for
 `show_one()`
Message-ID: <2da1e65dd8f92b3b6955321abf6b497cca75ce0d.1698152926.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QER6bsBnz//r1SmR"
Content-Disposition: inline
In-Reply-To: <cover.1698152926.git.ps@pks.im>


--QER6bsBnz//r1SmR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `show_one()` function implicitly receives a bunch of options which
are tracked via global variables. This makes it hard to see which
subcommands of git-show-ref(1) actually make use of these options.

Introduce a `show_one_options` structure that gets passed down to this
function. This allows us to get rid of more global state and makes it
more explicit which subcommands use those options.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/show-ref.c | 59 +++++++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 21 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 4c039007dd1..589a91f15b9 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -18,10 +18,17 @@ static const char * const show_ref_usage[] =3D {
 	NULL
 };
=20
-static int deref_tags, show_head, tags_only, heads_only, verify,
-	   quiet, hash_only, abbrev;
+static int show_head, tags_only, heads_only, verify;
=20
-static void show_one(const char *refname, const struct object_id *oid)
+struct show_one_options {
+	int quiet;
+	int hash_only;
+	int abbrev;
+	int deref_tags;
+};
+
+static void show_one(const struct show_one_options *opts,
+		     const char *refname, const struct object_id *oid)
 {
 	const char *hex;
 	struct object_id peeled;
@@ -30,25 +37,26 @@ static void show_one(const char *refname, const struct =
object_id *oid)
 		die("git show-ref: bad ref %s (%s)", refname,
 		    oid_to_hex(oid));
=20
-	if (quiet)
+	if (opts->quiet)
 		return;
=20
-	hex =3D repo_find_unique_abbrev(the_repository, oid, abbrev);
-	if (hash_only)
+	hex =3D repo_find_unique_abbrev(the_repository, oid, opts->abbrev);
+	if (opts->hash_only)
 		printf("%s\n", hex);
 	else
 		printf("%s %s\n", hex, refname);
=20
-	if (!deref_tags)
+	if (!opts->deref_tags)
 		return;
=20
 	if (!peel_iterated_oid(oid, &peeled)) {
-		hex =3D repo_find_unique_abbrev(the_repository, &peeled, abbrev);
+		hex =3D repo_find_unique_abbrev(the_repository, &peeled, opts->abbrev);
 		printf("%s %s^{}\n", hex, refname);
 	}
 }
=20
 struct show_ref_data {
+	const struct show_one_options *show_one_opts;
 	const char **patterns;
 	int found_match;
 };
@@ -81,7 +89,7 @@ static int show_ref(const char *refname, const struct obj=
ect_id *oid,
 match:
 	data->found_match++;
=20
-	show_one(refname, oid);
+	show_one(data->show_one_opts, refname, oid);
=20
 	return 0;
 }
@@ -149,7 +157,8 @@ static int cmd_show_ref__exclude_existing(const struct =
exclude_existing_options
 	return 0;
 }
=20
-static int cmd_show_ref__verify(const char **refs)
+static int cmd_show_ref__verify(const struct show_one_options *show_one_op=
ts,
+				const char **refs)
 {
 	if (!refs || !*refs)
 		die("--verify requires a reference");
@@ -159,9 +168,9 @@ static int cmd_show_ref__verify(const char **refs)
=20
 		if ((starts_with(*refs, "refs/") || !strcmp(*refs, "HEAD")) &&
 		    !read_ref(*refs, &oid)) {
-			show_one(*refs, &oid);
+			show_one(show_one_opts, *refs, &oid);
 		}
-		else if (!quiet)
+		else if (!show_one_opts->quiet)
 			die("'%s' - not a valid ref", *refs);
 		else
 			return 1;
@@ -171,9 +180,11 @@ static int cmd_show_ref__verify(const char **refs)
 	return 0;
 }
=20
-static int cmd_show_ref__patterns(const char **patterns)
+static int cmd_show_ref__patterns(const struct show_one_options *show_one_=
opts,
+				  const char **patterns)
 {
 	struct show_ref_data show_ref_data =3D {
+		.show_one_opts =3D show_one_opts,
 		.patterns =3D (patterns && *patterns) ? patterns : NULL,
 	};
=20
@@ -195,11 +206,16 @@ static int cmd_show_ref__patterns(const char **patter=
ns)
=20
 static int hash_callback(const struct option *opt, const char *arg, int un=
set)
 {
-	hash_only =3D 1;
+	struct show_one_options *opts =3D opt->value;
+	struct option abbrev_opt =3D *opt;
+
+	opts->hash_only =3D 1;
 	/* Use full length SHA1 if no argument */
 	if (!arg)
 		return 0;
-	return parse_opt_abbrev_cb(opt, arg, unset);
+
+	abbrev_opt.value =3D &opts->abbrev;
+	return parse_opt_abbrev_cb(&abbrev_opt, arg, unset);
 }
=20
 static int exclude_existing_callback(const struct option *opt, const char =
*arg,
@@ -215,6 +231,7 @@ static int exclude_existing_callback(const struct optio=
n *opt, const char *arg,
 int cmd_show_ref(int argc, const char **argv, const char *prefix)
 {
 	struct exclude_existing_options exclude_existing_opts =3D {0};
+	struct show_one_options show_one_opts =3D {0};
 	const struct option show_ref_options[] =3D {
 		OPT_BOOL(0, "tags", &tags_only, N_("only show tags (can be combined with=
 heads)")),
 		OPT_BOOL(0, "heads", &heads_only, N_("only show heads (can be combined w=
ith tags)")),
@@ -224,13 +241,13 @@ int cmd_show_ref(int argc, const char **argv, const c=
har *prefix)
 				N_("show the HEAD reference, even if it would be filtered out")),
 		OPT_BOOL(0, "head", &show_head,
 		  N_("show the HEAD reference, even if it would be filtered out")),
-		OPT_BOOL('d', "dereference", &deref_tags,
+		OPT_BOOL('d', "dereference", &show_one_opts.deref_tags,
 			    N_("dereference tags into object IDs")),
-		OPT_CALLBACK_F('s', "hash", &abbrev, N_("n"),
+		OPT_CALLBACK_F('s', "hash", &show_one_opts, N_("n"),
 			       N_("only show SHA1 hash using <n> digits"),
 			       PARSE_OPT_OPTARG, &hash_callback),
-		OPT__ABBREV(&abbrev),
-		OPT__QUIET(&quiet,
+		OPT__ABBREV(&show_one_opts.abbrev),
+		OPT__QUIET(&show_one_opts.quiet,
 			   N_("do not print results to stdout (useful with --verify)")),
 		OPT_CALLBACK_F(0, "exclude-existing", &exclude_existing_opts,
 			       N_("pattern"), N_("show refs from stdin that aren't in local rep=
ository"),
@@ -246,7 +263,7 @@ int cmd_show_ref(int argc, const char **argv, const cha=
r *prefix)
 	if (exclude_existing_opts.enabled)
 		return cmd_show_ref__exclude_existing(&exclude_existing_opts);
 	else if (verify)
-		return cmd_show_ref__verify(argv);
+		return cmd_show_ref__verify(&show_one_opts, argv);
 	else
-		return cmd_show_ref__patterns(argv);
+		return cmd_show_ref__patterns(&show_one_opts, argv);
 }
--=20
2.42.0


--QER6bsBnz//r1SmR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU3wmkACgkQVbJhu7ck
PpS4rQ/9E49QdaF/AQMFTyjQjnDSoppSTK9LO2VAyptmEFlZivzNHbtdnYmY1r7Z
HQEiVDCwA0Kzlc0PZI+Eux0lfamXHGr/6Ok54+wsojYgVpd+DUZRWCiY7x+MPgfV
OEVlRjE+s9dZ0o+svPJD5Wl7OlvGA6HuRZmgS/RZZrI9wECK7w404h8TKf/mLxCI
srZtn8VcGXtWkZzwWDh2xv+PxVJlxB3tnYKgA82Q0vQt7uDiu4e6cxcVhphkTcLB
XonGaZB7yMdMy6fnAZ1CeRoXJ/UzUvIFIS7fxl+NMveXuMhm9q3RqmbPmbAQpWU6
NJAd3gvCMunVghLudJmddSuHTewSUi59WcL4oK38waXpZcK23clqgRQ1IAWIFwjU
kjat01XdQ1maIxsx6g/nrfshgHS4igtlcOJyD82+yxgfZ/kDT/Yl/CUQYl3fog44
0W1/zl+g9XgRg9Xw87R4HXjerRddz8ubpmxunlFuGB6od1m/c+Pp7mbRKzf6/1Zp
jzfQMtNHRI16XciUAzeDaKRbvZbRn+TkrT2fL/osLdT2LayOTVzVe/ZDttAAZZtO
9kaHzaG0vrR3iuq8Gj+sul4aiV0Uro7c0qGVjUIzOfw41otBVb7UolKtvul+bBz7
YLauPq67zh8G+DrTpkEjUKWGekjOnnQRT8FMhPJ+M8c3P6kWUvs=
=TvZI
-----END PGP SIGNATURE-----

--QER6bsBnz//r1SmR--

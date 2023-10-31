Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A0813AEC
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 08:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qXgeMFyp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T0BI56m5"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EECDB
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 01:16:42 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 3C4D43200905;
	Tue, 31 Oct 2023 04:16:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 31 Oct 2023 04:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698740200; x=1698826600; bh=Zq
	LdwDphgDAemOBzuNRUhMzJVV8mMdGN+u90BrM/tp8=; b=qXgeMFypVggn2X/S34
	vveyI4bTgLDY5Yp8dhdhJs3wUHfTsJOGclkL+LzbGXEfBsR1XHxnRdP3pSQglojb
	ksmWrZ+xT+9OZtGyhHPDi0FgQTvoTmzHXyRKXv2mHK13+C7mF8o1fo7WlMXNvFzK
	rnQo85BSexD4wtidkVR3nmhXnxsvVl16H+50/Hyx2e7bZFSHuZDV5O8UHEaa4wSv
	6HHoFk3lcV3XLRCkhe8o0qno/5/qb+LHs23G3Ya6dqe9ERYVNZe6pmD0uvs1Abeb
	05Oz3uFpKqj0lLdKyjm1a395vkfAwYHPDEtFwQpq6pOLcqcHj/En8Xi+ojHvDQqT
	q/gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698740200; x=1698826600; bh=ZqLdwDphgDAem
	OBzuNRUhMzJVV8mMdGN+u90BrM/tp8=; b=T0BI56m5viEDgoUYXT4bpjrSRWPsV
	2PmsL/nGqRF05NNV5E03V9ajoo1kvegW+f43n7O5GdwM0QPY/1+yHb2x7+wfhvWD
	DmrKv5Nkwv/w09NoQnHAIi668PT1iG28dSUM3GyUMv2fzsqk7X9SmrcJR8op3Ybv
	xtnUhdo604ZDMgS2iFdUXps+cBPpsQvjPaZ6m3yqjr1Ys/9emYBxoy8D8Y4mQpRC
	yBsiPFJi4C0YXn3BOsHsR2VnxkEl5xZWphZ1Df7BDaekfL6tgCsaC/R+6/CGN8MC
	m9T4EynhGPHfmEey7tDyf37VbIxsFWcGt16k0O9qP++xO3ucLZWA6x1VA==
X-ME-Sender: <xms:6LdAZThncZKStwusw9nngObwCVDZaYYNfI-fMPhg20Y4dZEoIfUkSg>
    <xme:6LdAZQBfmzzlsEBnGXK2kLOUYUR-qlbtp2fqdm46NJ7s7046lQ4DnKIH9dmfEh-NA
    uugcvn0_naQXajRYA>
X-ME-Received: <xmr:6LdAZTHL4fC2TK-kBF9q2UflYJAPVV7RH2tTerqQSfBfzsZAs-yVWe75dlIg5NVSmu62RN2ostkn-UEKT8vI9ginn4-o6T7eMFscIqJVCLD_NDcD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:6LdAZQT2wIBLFDRpczUHvSe4Ee9l5HeGJAEpJ6m3PjNIXGOgFCmmug>
    <xmx:6LdAZQwcJK-PF6jWlJIZOrX5V5vS0w1uyjNJNBA99-BOpiyy5WpAUg>
    <xmx:6LdAZW5ViccsiNtSbqQI5Y_IXLoYC32dpU6P7fsc_Irm3gia9Cp5Vw>
    <xmx:6LdAZc-6UZX44CJQd9gEOhUXeD05Aol0jhyGKBNBF6O1_6b7jFzC7A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 04:16:39 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 51c70132 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Oct 2023 08:16:32 +0000 (UTC)
Date: Tue, 31 Oct 2023 09:16:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v3 07/12] builtin/show-ref: stop using global vars for
 `show_one()`
Message-ID: <bc528db7667cbe9323162b80ad47bc9d46c4b275.1698739941.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
 <cover.1698739941.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Op7/KzG/QKjOg7S+"
Content-Disposition: inline
In-Reply-To: <cover.1698739941.git.ps@pks.im>


--Op7/KzG/QKjOg7S+
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
 builtin/show-ref.c | 62 ++++++++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 22 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index d0de69e29dd..fb0960ac507 100644
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
@@ -153,7 +161,8 @@ static int cmd_show_ref__exclude_existing(const struct =
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
@@ -163,9 +172,9 @@ static int cmd_show_ref__verify(const char **refs)
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
@@ -175,9 +184,12 @@ static int cmd_show_ref__verify(const char **refs)
 	return 0;
 }
=20
-static int cmd_show_ref__patterns(const char **patterns)
+static int cmd_show_ref__patterns(const struct show_one_options *show_one_=
opts,
+				  const char **patterns)
 {
-	struct show_ref_data show_ref_data =3D {0};
+	struct show_ref_data show_ref_data =3D {
+		.show_one_opts =3D show_one_opts,
+	};
=20
 	if (patterns && *patterns)
 		show_ref_data.patterns =3D patterns;
@@ -200,11 +212,16 @@ static int cmd_show_ref__patterns(const char **patter=
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
@@ -220,6 +237,7 @@ static int exclude_existing_callback(const struct optio=
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
@@ -229,13 +247,13 @@ int cmd_show_ref(int argc, const char **argv, const c=
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
@@ -251,7 +269,7 @@ int cmd_show_ref(int argc, const char **argv, const cha=
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


--Op7/KzG/QKjOg7S+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVAt+UACgkQVbJhu7ck
PpQclw//YqKPs1OEkfFGKgGJtlB/QRU4keTDsmhIOEG7Cno/85rUJuLkp9p2WnEk
n74OxkopTuUVI4bbG5Iz1ZYnYMKulJAp85EJocGtMQnXu4RGw1c41TMR1NODwuFx
1970iaIJ+NwmFJUOlO5L8Ux0aQkpdtpUxG9j9GwHeE8E4L9312QuyoUyzdSPi5Vu
tZ6GL097V7bKTv29d5LtbnT++lIXQkbk8jPilWvFyHeTOOIy0Dlfrev2xMIZtWr2
hmTIDu8ldMHDBujuxvY01/aCPneOgwy/bk2JLt8VrokOSe/+JeDEihAIVBawLlWn
UZILRXuLbYxgoXA7D+yYIppdTbpTUbnWhU6bOnaxD4UL3EgA1l59AJ098csulvw6
V90e3/HcrvVclA5gKwaYyBlZaXLuPSHgbecon90rJWf1QKuXLyuQfK80pmZ/tBBT
ftklrlSLud+6o0F9gWA7ysYQfWJgdzbq3qpi/j+djvhpBisGi/dTXNW+9Tfucw9F
FQ7QsHGZvdn1C5CabxK4gnxYwEvgVft9ImfoyaLPqUN3p3qcDX08iiSprkOmHX6x
mYPw2BDg4xgxBiVr73BZpHYdlZcVCPanaVDFmgn1Ggv8FNQxGw/+A5GZMfTXGi/4
i7Lsztq98mRNGYpPqGJHw6Fs+UBLvY4c1JGX2UJ3Nr43Bv53Lj4=
=uTab
-----END PGP SIGNATURE-----

--Op7/KzG/QKjOg7S+--

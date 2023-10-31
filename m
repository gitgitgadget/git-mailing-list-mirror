Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBAE111B3
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 08:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OJaQHHHE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ThxDaX+k"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF469C9
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 01:16:16 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id E57633200A6D;
	Tue, 31 Oct 2023 04:16:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 31 Oct 2023 04:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698740175; x=1698826575; bh=75
	HwvSBQJ9vj6977D+UrNhePVdnw81ZJZlilm+JMNLg=; b=OJaQHHHE+RuIGgZwmj
	6/7JKvwu4j4SeuFkDhcE+B0hTLvhnEvXYtqBL6puSS/NQ95bMt3dMgrHPvBSLwNn
	1HzMhTKjVOhaG+4m9nGj2NJqD2OSuhwAJ1WNuhh+duWiqjKrCEkPp8yulTcr48Vf
	tp+OKmGwaaLURkeYxI0Dy+6RoQQyGuFfVxpWfKiRihu6MQuKCoQXqHgQjyn7lamC
	d3rcB6haOJxM3xnXpuTUDJ2zZZqA0NNq0+U4Wbq9CnWute+bsY94dUmj9q9kLUGw
	3riiuQs4gZjbcxweW8gEGYfrd2545O6u1TRT7jC7OwXaMScCA16F2ICaSkDD+9Qp
	KXKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698740175; x=1698826575; bh=75HwvSBQJ9vj6
	977D+UrNhePVdnw81ZJZlilm+JMNLg=; b=ThxDaX+kHZDLabjr1cTKcFMQxyvG9
	1I0nWLuI1ms3ada+vzEJKMhN3aigtyP2GgrcdOEcH2Ri278CdQLAZs7Yd/RkI3NW
	rDYf7NXAUqn4ZUuENxofL/5O3VvVuRDO1jl/I5PoHdQAeEy7TDCKsNkIJMCx8eFB
	HpauwcT3tZSUxHeUfxVkn1ovXQ33BrUzXptW6rTgNRVdyYo8cGxq8bkCHhATzz2N
	Z3ipBLguvR4H01m6oXlc72hDH86ipliHUM+/05QlEPuZhhKiMF4QNCyuQzuJ8Iu8
	vW4Ac/QP4aDfjRnNa288Gms/etVzYC3jpPlqpBnkXZMJgwtnwG3S2PSKA==
X-ME-Sender: <xms:z7dAZTjCwDH52MFyShaNwjJ3qRDCVKgoPlQo8Bz3Ggsg6MDsEQHVAA>
    <xme:z7dAZQAeJ0HkA6JJQ9LQZ8VGrT0o499psro33g9qxO5zJxVfhUokIg-y_KMuY9qRp
    FZNHh0T1iRhbtFvGw>
X-ME-Received: <xmr:z7dAZTEe_IFu9a6L-gg8CkEOATvI5qYWF-J1es0XtqlhSmnI26R6Onj0wP5WvO4YpJObWCWzrw__lFd97o77ZM3mlQ_t08LEHJ7EJvLMJQyFx6pW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:z7dAZQRNiHNAFVbRb05saB8Zm09BBBD0_fitkYiqVn4CH8sdYOE0Gg>
    <xmx:z7dAZQwnLlpQhjj3isDtboEiVT-xY-sR3iKypH9MJjNUEWEPdO4uhg>
    <xmx:z7dAZW4EssTwSenz_JExJFHCN9yDwdXuhENjqiHgmferUHYAObeh7g>
    <xmx:z7dAZc9JQcf4C8E0YK6gw8M8Sk1Wz8USAgZcLueE90Vh4uxaGEx5Zw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 04:16:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a02d7f02 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Oct 2023 08:16:07 +0000 (UTC)
Date: Tue, 31 Oct 2023 09:16:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v3 01/12] builtin/show-ref: convert pattern to a local
 variable
Message-ID: <9570ad639244066802958ea52069ffcad05959ce.1698739941.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
 <cover.1698739941.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ixDXkIXmzJOm5T3V"
Content-Disposition: inline
In-Reply-To: <cover.1698739941.git.ps@pks.im>


--ixDXkIXmzJOm5T3V
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


--ixDXkIXmzJOm5T3V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVAt8sACgkQVbJhu7ck
PpT2Vg/+LC1CP6DH+ejhUJLh9FEzy9ZkWNF8RUH3OFP6U0csZ5cT35FBFfmxKrys
ZLLKswFvG9slmhtHr33tWJh0zGjsaWyecIMGmz5uH0oCQSUlM1nYu0tKV0i4wy3Q
IuE6kby1uWRTelMUavyfppB6b0LHRHRlCeXYmX9E3Pj69yvxnD9QL9E8hCLtmzFb
om8EfAWErLG7VNsMwigWPacHcUCkP0xsF6vtrPcB8PzwZIihwYHvpHCtc0xoRtMr
fMgKFCZ11U4pwCEoymSap4T2nPRq2fOFle2q0Nc0qmZVoQ8wGWh0hGkfnlu/rzVG
r5fSZKIUDtup4joZj2W7MZdtEilJo/bJMyGD1dhQb1TiiZpGT+/YmN0xWJY1F7ad
jKEqOxXwmebj3qRzOaJtlKKXKqQvOIBF1D990yQVY+ShXiewyptdcIbq1yVbx9BZ
jOY9NvNapR6NFcoj3Q5BeF0kNjNlAvkE3uYpvv2DWNkIQRNDk7zZ5Z5ryMXcu5T3
wPBD9qPe2yjQv+IvvUI/PTvjjgIgH6J0bKJF56U4i7BSzNIi4+EQwBMxlfh1z5Og
oyavQl6Q7/PokUhaXaJn6m6H00IM6Ayv7dlyewdchw3+dqVeN7nYyLd86CU/YsHd
XEsrzMDmU1EMInVxEH2oCd65er2kxqMKf24au5HxYhAYpkE4ASw=
=k9Hg
-----END PGP SIGNATURE-----

--ixDXkIXmzJOm5T3V--

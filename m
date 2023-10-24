Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD2029439
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 13:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gP4YN6eJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DloN5qZ/"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3AC171B
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 06:11:01 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 8038C32009BC;
	Tue, 24 Oct 2023 09:11:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 24 Oct 2023 09:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698153060; x=1698239460; bh=Yn
	vpPzdGk4bUNY/bhU20UOcJo8wC+m4Qxkd/16716R8=; b=gP4YN6eJClfhNfl3Rv
	NH2/RzVJjtnC5bJC7v+Ma2/iEn6ik2I5NuUdsO3pLlBxCYYId0fObHETkqVc4jPb
	Zk3GCA8YwN2OTruBYL87ihhOjHjQTCvJcs4ZNRamMzX+41hAJDwj08fRtln2+Q7O
	BKIswIYBFLHoO/SuI3Z9VN//tKblFyepUXVLFAu5RPHfAD6RonIyCDwz2CRLjcVQ
	k9WkGNW8c5vHp458RL0bIveVPT4/OZQW46RuBU3GN5aQ4+IVabXXOWvHPDiPelXy
	cGWi7ugqK4CHROwZM9tDVLxp0lXfF0tWcfs1jd9Pp9eFSStX3JK9MGfEHkAbkxNV
	5WRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698153060; x=1698239460; bh=YnvpPzdGk4bUN
	Y/bhU20UOcJo8wC+m4Qxkd/16716R8=; b=DloN5qZ/jJRBZQtdPFxdmDdkAF3u2
	5A41roaa/FO6PEb8YgzQH7WfEFuTC4Yuw92cZurwapbuCU/Qpy+5353hcdw4yStv
	UQWyAVH7P9VHZ1HbMLcnIJRjlyM9yy0+TOTc0tlPEjX/qNCW7RXQeqplir+F5iUR
	d0S4wKNseukThavu3Wl/8uqgsEX4/BmtJTCZ4zdFAvKnf8UxLwXgOB8T2+w+1nNn
	hvIaV7OZbcqhATJ6d8rBUFubOsyz7V5gGtZpuq8wl8W5b6iRbnn14/h2wgrhhBTT
	/sMQw7E0LtPSk5yknvx81Zi0TZs1bIYXmHn2baIgrU4cr/o+kphEcl1+w==
X-ME-Sender: <xms:Y8I3ZcEKbRfbNkvj8tMkByplf8FKnvF1ktmfA9SYMxCOG8KX57eFRQ>
    <xme:Y8I3ZVUW-YBFgitFrh0ItK8EWPliJkzyuGV0Pns6FFrlIMOz-13OjXMuT9kxEqCGe
    HLptaU394OZETohcA>
X-ME-Received: <xmr:Y8I3ZWI42_czupqcbNh1swJ2AN7fPC_wUAR3t3b3onta1pHwC7HYPKyslIF3X5mZk4INSI4TxjhwuZAb_O-M73PYTdNrEXO9IksiKG8fuVhGRFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeekgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:Y8I3ZeF5OrjqHcf2zeLrsQUqBguIUReVF2vGoWcVx8vi65xB7f--XQ>
    <xmx:Y8I3ZSXPFbDmgtS53xVMwhU-Avc_vMrD4dq4VrZJIP8oaNURsuD2Cg>
    <xmx:Y8I3ZRMNZx4sc7qpomwt1zE8ZQci_lGEEMIR3cA29KCw8EBaFtiYfA>
    <xmx:ZMI3Zfi7m-YimcYRwfmdMifknK1OLwWfUEUSOkkI7Fr1qRgmLQY0WA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Oct 2023 09:10:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ed772654 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Oct 2023 13:10:54 +0000 (UTC)
Date: Tue, 24 Oct 2023 15:10:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 05/12] builtin/show-ref: refactor `--exclude-existing` options
Message-ID: <8d0b0b5700c7ffed6b3a74760d0d9155b404bb4f.1698152926.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bV1YzbxvZaDkhK62"
Content-Disposition: inline
In-Reply-To: <cover.1698152926.git.ps@pks.im>


--bV1YzbxvZaDkhK62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It's not immediately obvious options which options are applicable to
what subcommand ni git-show-ref(1) because all options exist as global
state. This can easily cause confusion for the reader.

Refactor options for the `--exclude-existing` subcommand to be contained
in a separate structure. This structure is stored on the stack and
passed down as required. Consequentially, it clearly delimits the scope
of those options and requires the reader to worry less about global
state.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/show-ref.c | 72 +++++++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 33 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index eb60f940a3c..e130b999c0b 100644
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
+	int matchlen =3D opts->pattern ? strlen(opts->pattern) : 0;
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
 			if (reflen < matchlen)
 				continue;
-			if (strncmp(ref, match, matchlen))
+			if (strncmp(ref, opts->pattern, matchlen))
 				continue;
 		}
 		if (check_refname_format(ref, 0)) {
@@ -200,44 +204,46 @@ static int hash_callback(const struct option *opt, co=
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


--bV1YzbxvZaDkhK62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU3wmAACgkQVbJhu7ck
PpT7yA/6AoCL0VGQSQ2Ay7ptgumhrhr4F2C69MTMZ0nJDJWj6yIq7jREuOeQMGSp
qAOuy3TFV8PtmwxYEznZMxRJwltUq/9h/LzvDvhjiA9F569KDqtVOItRSNc7WEzK
2/48f0GWxVkb4Pr/YGf0AP5mgQJlm/xI98Gyb9Fc3IWRnzY2qn/5KJ9tMyCTKoUS
kn6BAZVsSTpL3EYCHLKwOXNJ9teZqBMUQDXSJyavlVQYm1qKHR9hzGLxRsy/3PhB
QgLXC1gcUuysdPvhvNi40l5aBuqljm0BVQqm4BQFFSYTuEaKPRtgolnfPGuhR4Ox
zTAQazlDtwcc3FpmmI1KxCGibRJY0eABYSexPsqWfMfJBowmNiOz1eXDoDr8DEew
BSLni6jBtKOzB6FskaG2tYW5dlTXeTLNxHpQxOYVO1XzHYMyzSXemV7IkYmJIDnt
vx4NRDI9MvpoHFfVYofJZfLY+WekFfA0wj1MBgUZJ4YncVSK7pki79gzL6FgGwbI
l/b3VgwBqVbcmpoQWhH2PCiKKgQCbPRFb2rOUuHVvBDiffUKvAhiLrQWhbyCNOG2
b3+fGRZg85jUCQuIrKtpkzyU9NvgHx9w1KxVPk0KGhiSwqyxwlITciMGNB9rcSPN
/wc5UX6nsiLdQ6jgd6TMhxBgCh0OaIs4PsWeLwm3p06wjtUErSM=
=aaG2
-----END PGP SIGNATURE-----

--bV1YzbxvZaDkhK62--

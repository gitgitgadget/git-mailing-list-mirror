Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BB32941D
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 13:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Bg/Jdkot";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WfZ8m+5t"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101DB10D0
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 06:11:14 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 41C3532009F6;
	Tue, 24 Oct 2023 09:11:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 24 Oct 2023 09:11:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698153072; x=1698239472; bh=hx
	qvT3H5tPvDkXCFWLFIGM5ut63nYUI8vmf59Cq2ywQ=; b=Bg/JdkotBpF0DAkOtp
	2OkO2rzeaBat6o18NOr+Yo0BnVBX+WfTIc25n1HUVvDkJYC1/sSM77XxpZ7XU4rl
	xSM4CM6pKPuFCFgfpX9cE56Abs4cOYS3G1GhH2znH3JIEvs/Q/32c+jY4ITQVu0V
	1sAtdKWlgm0moLc3QMTYH3QjCTXNEwMNy1Jgrsr+S3cnyduZfK5xENDdvxp7ECCx
	rXs9d09h0RYQVlqKdyVvGMy7PDx0fvvibzSZMAwEY7akSwPzpnNSVwWHwlRulwIi
	sANPsAhnWlarFE1BkRf645A2q9kk4OCRXjFh0XdGYx3QJoZ1bWxo0RmvEu55pj0s
	XWCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698153072; x=1698239472; bh=hxqvT3H5tPvDk
	XCFWLFIGM5ut63nYUI8vmf59Cq2ywQ=; b=WfZ8m+5txr3j8L3SzMA9J9h9SFtjS
	vpaRTQT8iuVJioi/gZg1lWQLN56Gbw7gEEGbOzhXlp4eZIOM2aKeDgmf5nn3fSCP
	rVk6aR7PHLWd6rllA0MsqXcfxYAi8otUW/0R10RZBqcrQSysd4W3pW5YpUo1VrT2
	Uv43naAi5D12mBxMeTeRMxi9hd/0LrOB6zH9mZTaI89MdZ5lLINqHljWdlsw110M
	MrgAI0vbbwIb3/+qyJ6I7jPDnytbZsJVWMfpqwx2APjNZTOyEC+ROZluNyFEYUts
	raNFDqbiPtF9Ge4yiEvh2/xjFm2fNF93RUZpG5pJW+ariYN3B2EkCt21g==
X-ME-Sender: <xms:cMI3ZWVAzGUsNeMCp5u8LmU1Y69goRHFsYLj8RwN4iUGkFZTQsgedg>
    <xme:cMI3ZSlF5BT1gimHlJaWzPiGEBFZ_Q0ReteEj72icXiEfg7EXnLEWrcaAFjToSG8F
    3wbI_n-5inXf2E6CA>
X-ME-Received: <xmr:cMI3ZaaggEI9Lw4xhsuTKK8__Cf-MZztOKvykd_y5q1f-yFP0b89dFtQU7kBtJTnySktGw1L72vsBbnXs205c_o90CfHd1v9UR_WlybKIk0Lbwo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeekgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:cMI3ZdX2BDOonk1B8yfCgm44DmXSjb3eU0CnfloASYfE_ZySranGwA>
    <xmx:cMI3ZQk7gK1FGNKIcjTwQYRkf0oGc5_NzLMJ2aN6m4H3ylZbGp96Ug>
    <xmx:cMI3ZSfV1c9miuqo9BQ4wLdW187LwuZ1mLEG7U7yX3deHxyLIsCK3w>
    <xmx:cMI3ZVxASt6FOi43WgkM_cvRZCs6V1rxbF1-fWj-rSuJljGyRXa06Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Oct 2023 09:11:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 295b1b49 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Oct 2023 13:11:07 +0000 (UTC)
Date: Tue, 24 Oct 2023 15:11:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 08/12] builtin/show-ref: refactor options for patterns
 subcommand
Message-ID: <805889eda4cf89e6aebf8a408ceb2a5c60551526.1698152926.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NMMPgd6XQYC0jPXj"
Content-Disposition: inline
In-Reply-To: <cover.1698152926.git.ps@pks.im>


--NMMPgd6XQYC0jPXj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The patterns subcommand is the last command that still uses global
variables to track its options. Convert it to use a structure instead
with the same motivation as preceding commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/show-ref.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 589a91f15b9..5d5d7d22ed1 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -18,8 +18,6 @@ static const char * const show_ref_usage[] =3D {
 	NULL
 };
=20
-static int show_head, tags_only, heads_only, verify;
-
 struct show_one_options {
 	int quiet;
 	int hash_only;
@@ -59,6 +57,7 @@ struct show_ref_data {
 	const struct show_one_options *show_one_opts;
 	const char **patterns;
 	int found_match;
+	int show_head;
 };
=20
 static int show_ref(const char *refname, const struct object_id *oid,
@@ -66,7 +65,7 @@ static int show_ref(const char *refname, const struct obj=
ect_id *oid,
 {
 	struct show_ref_data *data =3D cbdata;
=20
-	if (show_head && !strcmp(refname, "HEAD"))
+	if (data->show_head && !strcmp(refname, "HEAD"))
 		goto match;
=20
 	if (data->patterns) {
@@ -180,20 +179,28 @@ static int cmd_show_ref__verify(const struct show_one=
_options *show_one_opts,
 	return 0;
 }
=20
-static int cmd_show_ref__patterns(const struct show_one_options *show_one_=
opts,
+struct patterns_options {
+	int show_head;
+	int heads_only;
+	int tags_only;
+};
+
+static int cmd_show_ref__patterns(const struct patterns_options *opts,
+				  const struct show_one_options *show_one_opts,
 				  const char **patterns)
 {
 	struct show_ref_data show_ref_data =3D {
 		.show_one_opts =3D show_one_opts,
+		.show_head =3D opts->show_head,
 		.patterns =3D (patterns && *patterns) ? patterns : NULL,
 	};
=20
-	if (show_head)
+	if (opts->show_head)
 		head_ref(show_ref, &show_ref_data);
-	if (heads_only || tags_only) {
-		if (heads_only)
+	if (opts->heads_only || opts->tags_only) {
+		if (opts->heads_only)
 			for_each_fullref_in("refs/heads/", show_ref, &show_ref_data);
-		if (tags_only)
+		if (opts->tags_only)
 			for_each_fullref_in("refs/tags/", show_ref, &show_ref_data);
 	} else {
 		for_each_ref(show_ref, &show_ref_data);
@@ -231,15 +238,17 @@ static int exclude_existing_callback(const struct opt=
ion *opt, const char *arg,
 int cmd_show_ref(int argc, const char **argv, const char *prefix)
 {
 	struct exclude_existing_options exclude_existing_opts =3D {0};
+	struct patterns_options patterns_opts =3D {0};
 	struct show_one_options show_one_opts =3D {0};
+	int verify =3D 0;
 	const struct option show_ref_options[] =3D {
-		OPT_BOOL(0, "tags", &tags_only, N_("only show tags (can be combined with=
 heads)")),
-		OPT_BOOL(0, "heads", &heads_only, N_("only show heads (can be combined w=
ith tags)")),
+		OPT_BOOL(0, "tags", &patterns_opts.tags_only, N_("only show tags (can be=
 combined with heads)")),
+		OPT_BOOL(0, "heads", &patterns_opts.heads_only, N_("only show heads (can=
 be combined with tags)")),
 		OPT_BOOL(0, "verify", &verify, N_("stricter reference checking, "
 			    "requires exact ref path")),
-		OPT_HIDDEN_BOOL('h', NULL, &show_head,
+		OPT_HIDDEN_BOOL('h', NULL, &patterns_opts.show_head,
 				N_("show the HEAD reference, even if it would be filtered out")),
-		OPT_BOOL(0, "head", &show_head,
+		OPT_BOOL(0, "head", &patterns_opts.show_head,
 		  N_("show the HEAD reference, even if it would be filtered out")),
 		OPT_BOOL('d', "dereference", &show_one_opts.deref_tags,
 			    N_("dereference tags into object IDs")),
@@ -265,5 +274,5 @@ int cmd_show_ref(int argc, const char **argv, const cha=
r *prefix)
 	else if (verify)
 		return cmd_show_ref__verify(&show_one_opts, argv);
 	else
-		return cmd_show_ref__patterns(&show_one_opts, argv);
+		return cmd_show_ref__patterns(&patterns_opts, &show_one_opts, argv);
 }
--=20
2.42.0


--NMMPgd6XQYC0jPXj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU3wm0ACgkQVbJhu7ck
PpR97g//REqtD9Q1OT5sZFFqzimnfwhzVKjHUxZU0G3XTMcMpS6IzS9Rpp2N95+L
8Ilo8jdlP+5JhKJW7z29iHWp1hA3lIzcWeMJPgq9ePaE0/Uoo79HqnrbvW5btNaF
rw8coTviSD34Ih/sFjzAQ9CXWr+DqPpjiyrzJH1TM3JDBhrym+ziBnakh5OjnCrH
OfMqFtkUDdpZl4I12x6QUEQ3PjPvoSr3SkcYDgn+5/PiGlC5V6QAgrK/yH8KC5cF
xx3fK9pTuxAG4Q6gMT0AQmdborxnlV9V1ksHocFwtiHpTGQMuVZGF63eMoF4/P3l
LaLVjY3U1l7KE2SiGDb9Ujm6ILlSA46WD/BXHZiq90ezmsO7DKsDA71+DvTLlciz
8RKr1CNK3CovWrfOkoKCEHSYkxk4DF30EFcOp9zo8ahhjdLiVQ6AblXy0WhE+vpN
aRyK8m6zqRaJ++iyDMYKj0cqJiPozi+eFzauitf4QBxJwJt+JKEHCbxbkxafgneF
GqAV6sIffzgaGAGeaWIcC+QJijL4GltN5bgEE0wfAxjbcsLeQtEcHeLmnjkkghZo
lLvNb6LPvwlXTiOiYuuiJLIm8sfBtMi3EDqL4IpRKTjZvv5+Sw/2Ap9lp64XroYy
3aah0Q3o9rfao+wquW/l5hdINik24rXWmnszSzEQtEe0kqT8dLw=
=3NBc
-----END PGP SIGNATURE-----

--NMMPgd6XQYC0jPXj--

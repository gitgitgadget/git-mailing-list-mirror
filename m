Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D615515EA1
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 08:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q7/7wJQn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ng1FTZIc"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A98ADE
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 01:16:46 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 94B5A3200A0E;
	Tue, 31 Oct 2023 04:16:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 31 Oct 2023 04:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698740205; x=1698826605; bh=Ta
	3/neLt1YNEskc0nm/3+dI+JeK1BIMQarU5iYfssfM=; b=Q7/7wJQnEl3Qzj02h+
	r0a2bZ3vpCvHcqcMuckodZLKq26VmvE0sMWotO0Bw/mjVuh7nr6Gb/EQVeMSB1Js
	wPpBFyXM+UDORD6qYuohZOUEgWR2GbUS8vD2OpY65Sz0o4SqoAe8LM+53J5pUTmN
	HX1F8sabjVNeSQpznliouc01a6rkSeBcZeJhq4I1XGhuXOLPCYTpWCA2gXfZJhxf
	7PTbF/jlXwvfqWdy8fCluTInsQBKE0TlOpGH2MFkddc14mhq/im8a2p36PrTdUpe
	u9VflNWRg6BskTjE4psTmu2JEGTYIDsooU2gFpaJ4+B9R3ouXGlNztaS++CKgv8Y
	lChA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698740205; x=1698826605; bh=Ta3/neLt1YNEs
	kc0nm/3+dI+JeK1BIMQarU5iYfssfM=; b=ng1FTZIcnFvt9E5vMcrezTNyaejMe
	KHIZBBy8JhLoikkKxxN017epA7OMIZ0ZDRHXMeNVkk5KPUjSe2Y7IQDK2IycJst+
	gccz5whp2c5rS84Ig1NlJ3yInex/jHjDAkTXe6OlFpEDAlUb/sFcZ7VRvUXjdvbl
	8rE+7Oq6i9q1CxyebBsNXxNbQKeWOeqgfbhqOw3u2rhufBI5sPFRmN6GnAyxNhWC
	rZMRpFvf/uo/M7Ro1og31cvWwUrthxxB8jG5L26Tve7zo699ukBcrrPIsObBAA8e
	i9Ys2fPVdc6SfxawXVkm6EusWTCNGlsqD8Z5H6J1m4AAEezjZw6aaH8fg==
X-ME-Sender: <xms:7bdAZYcOhzLJQVs087mUp8zagZTegT74neJS560KlEbw8zN1C6qvUw>
    <xme:7bdAZaOV-JiFC3wrEC_S4sg3ug9gj8wRwoPIfMN7Xjf9TY8XYZcImxfZW4OjceUlm
    FJtF7dQicr89LT4_w>
X-ME-Received: <xmr:7bdAZZiA7LtiuszqE2nPPjehXEvhyaR6sq6g6XXRHWIZKXzM536ytmMiTCEuJTlLZ3bkdEsCXYjRY-pKrE0qAxR8ziJbG22qbQan-3KNeBGX6O-I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:7bdAZd-8PiC1zlBwWRdr4qIgjpYVPPen3-Mqc6O8WKgbKv4VglyzsQ>
    <xmx:7bdAZUuJPtQ2EgQUrvDcHSIWkrOg7Q91311fQAbxrtoxi_7I4YrMaA>
    <xmx:7bdAZUFzBKo4cUAulDyNzJFVoAp37Se7ITGqC3g8CibUHBrPqEGl9w>
    <xmx:7bdAZQKgNZsKs_ynQPMGfdRWFLeCp6Ny4P1lJcpZd2AEPcgheDkXYQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 04:16:43 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d11f53de (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Oct 2023 08:16:36 +0000 (UTC)
Date: Tue, 31 Oct 2023 09:16:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v3 08/12] builtin/show-ref: refactor options for patterns
 subcommand
Message-ID: <e3882c07dfc9e114c0317e7a82462607b0eb8d43.1698739941.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
 <cover.1698739941.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="B4z6E1WAsxAHgCHD"
Content-Disposition: inline
In-Reply-To: <cover.1698739941.git.ps@pks.im>


--B4z6E1WAsxAHgCHD
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
index fb0960ac507..36ac10551da 100644
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
@@ -184,22 +183,30 @@ static int cmd_show_ref__verify(const struct show_one=
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
 	};
=20
 	if (patterns && *patterns)
 		show_ref_data.patterns =3D patterns;
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
@@ -237,15 +244,17 @@ static int exclude_existing_callback(const struct opt=
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
@@ -271,5 +280,5 @@ int cmd_show_ref(int argc, const char **argv, const cha=
r *prefix)
 	else if (verify)
 		return cmd_show_ref__verify(&show_one_opts, argv);
 	else
-		return cmd_show_ref__patterns(&show_one_opts, argv);
+		return cmd_show_ref__patterns(&patterns_opts, &show_one_opts, argv);
 }
--=20
2.42.0


--B4z6E1WAsxAHgCHD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVAt+kACgkQVbJhu7ck
PpSE2hAAicpuU+nJjnrPe1y9KkkfJH9IDtJ93PUK5AAWXdcZjIWp3PJ3rl0guH+O
HuRG6KE3KCifTdc0wPoORgVPx6v7eobTUNhVeQ5GPpAhmk5JAYQ0DSB7A+sq2Cw+
x6M1PU+wIZ7PfUwgvIj8c6ht494QB4aJktEK9FQk4NvkyG4/DwFaJnnvtfMicX14
XJuH3t6/rKboAGA8+QJJPMbGvKGUCb/cWgeG/lCZu5p6CxWY/biCMtAodPx+r/Mw
7MH10Sc2N2T5MDfjk+iCZEEay9T1gtBb+TPCoT9/rB0g2MuLpP3RFtMtrNdnFssQ
5IoNmkv03oW0ydspmaKXuANvbM3rCFL9Sdp8YZnQqBBBFixIx95Wt8fyBLRxeNc1
Cqsd275IIYbM7mMPEw7rzY2w709uXWpnmFwr1u3tHBiu48TDY8/VH+POgV3Uyrej
ztE9qQjPaadQassJ0GcdppBKAjZkJ1mRAaHUba1jAUL6ducIwObZxVfbgIQHV3dF
XeB5GKRSu5tdbVfd2iaYADr8X9P080WYqRbhg7OhKQjsNV3Niy4AKrOGaQa+N8N6
cOb3lZDa5EEwwDhe91XIB39D5cJcDWsEDe0qGclxkYU0Gu6byHL0qfC+ev8ci0Qq
wuSvHNf0ePkOBYexoD3tFVtEpHJEOKAbAtF5vDQUMTvZiAmeCkc=
=gFeZ
-----END PGP SIGNATURE-----

--B4z6E1WAsxAHgCHD--

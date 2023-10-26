Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5859E2B75D
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 09:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b8AkkUeE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rjlXycbu"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8DA1A7
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 02:56:25 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id E5B543200928;
	Thu, 26 Oct 2023 05:56:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 26 Oct 2023 05:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698314184; x=1698400584; bh=yL
	uvweuH0oMfdASyQV703Khqqv4zEuGn5mmt7rB7+Sw=; b=b8AkkUeEmb8q3WRMNE
	mmDnW3shM2V8W3TW7E/qbZ9qtbmbZ+kgGdjE3q6effgL4p1JHw7DqFsPWJxF0lSD
	RW96ne2x42+EYF2rKP9XGmh1eTth1jaVZgT03jMmcjqrCura1zD614ohipcuD2gJ
	NeniwJeK1WkdT7+SUiYwT4TB2YFDgAU21u/rWVoz0HfOQ4gA64V9fW/0WwpEk8WN
	EqJ3PNY5WKZQqlY7fqOMD6NdFJEbMwje4cmkPIXprzdAYcV67sVZvTvu3F+n740o
	tKqII9+oJHm+Mw8XZaeoz/fYnz1qvispIUNoCbHjmxYzsCDdXqfZ/4txnZVXfAHP
	UzeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698314184; x=1698400584; bh=yLuvweuH0oMfd
	ASyQV703Khqqv4zEuGn5mmt7rB7+Sw=; b=rjlXycbuOT1DqGO2MFVK5p46nQ/tw
	mb7+Q/3BadrYXwW1a5wJIgIPlyHFqYFRtFbI0BlQnkF7nGxMgPP+fCdh96z39Gqv
	K7WJNHnXH2V3QeiOhXp/UNSU1KDXO78zzcT5Kks7GQWteKtZPJtP/8bdPtgKZufv
	z05UvKH3cOUDr42aIxK2z1yrZIi7yueGKYTqQkMu6KsU0Sw/NVDWB9UIcQKWoHOf
	ZFklgGHNBMUsZb/9kZy9HGIyUcufL6a6jXRD7xyG4TRwIFpPHoljRqSgH2/gTb9b
	OVmknJPQxCFfxegOVq+Rz40oWt2aU9WlRkNKB32tlBiTV446oLClzA0sg==
X-ME-Sender: <xms:yDc6ZdrGmWc8h_7ZwGf_IdANlzpfBvE0hf6kKXal7Ajk1K9GE6qAmA>
    <xme:yDc6ZfqiD-r0sziKAa7nw7eRLr2DbuAulzLgbTeeUT30xcNUzyBiBfapfC03RV2gP
    w1pd9aa8I_vEACk6w>
X-ME-Received: <xmr:yDc6ZaNY7bYYFwavwNgJKkWaQ0HgLap40McvtDBXXMs8wZ5lKCrEaOHP-SolCaZpeeo70fsIyQt5DoaeDW_XQJwjC0CIKNPBvhkqIf9WcB7mN08>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledvgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:yDc6ZY6b2HUh7ENK_YMxqngcTfb58Y_4rm7nDU_3VzuVF-W4lOzDqQ>
    <xmx:yDc6Zc6TJ5DH7oh_2aUlkTvYRkOoPXjsFqmFKWWasldtlJc2KCQWfQ>
    <xmx:yDc6ZQifc1aiPdm-BWsCUV9qJijRCOnDnHI5_Kyy853MdcHhOgfVbA>
    <xmx:yDc6ZcEMeDW13Lo9fXMWnf2AZ-VApByD-Jpv0Fn8fqi725Y0OjvncA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Oct 2023 05:56:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 084f9a37 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Oct 2023 09:56:14 +0000 (UTC)
Date: Thu, 26 Oct 2023 11:56:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v2 01/12] builtin/show-ref: convert pattern to a local
 variable
Message-ID: <78163accbd2c39721249474512dedd8ed2f0fe4e.1698314128.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
 <cover.1698314128.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bn/QtVhC4ahXXV1P"
Content-Disposition: inline
In-Reply-To: <cover.1698314128.git.ps@pks.im>


--bn/QtVhC4ahXXV1P
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


--bn/QtVhC4ahXXV1P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU6N8QACgkQVbJhu7ck
PpQxQRAAl2MSGHlvvgKbJPdef2P6f2VPY3CF6hsNd478ZqH9Q7gefjiW9eXX4bog
HOTz09naf8lftlYWd0DdbMgvXql28K8g34BXejUORqw7kOyIS/tng0ZZzgr3vIpc
4ukUPDp9J1tc/ivBnJ/4JQkFvve0i9S1gv9E6+OnBo6YzZmsqGSOb16/Xmynjpmn
++2PalXlWroxYgnBT4mD1Enufs9dBNjxtFAql3mQqwDtsg3GxeVw28QqWEljgDoc
BjHvSYxrnlhCDz4npKSolCz6B2mRf4tz/n8W/9oAzHVe/o9josq8DwUP2iXfKm6n
BTHmMuCbKn4HDCK0Mnrzr7JKaUL0KIwy8lrN3h5K6W4zDF970TSdDi2j6LORymxB
mdk6U8cbjq6Kh9v/yNzI4poc8DY9mzHtTWB6nlY62AHOJN1R0rcITJnDLQzglJvv
2ddRfyZlU4xUNwDgDLt5MlLFiuYzRWq/dJP7WLnB6bNsQS3WPnCHBSH2fWiYACSz
cFKckQKtGP/Z4ZNLFztdTpvNbvqAeslEtiZZ1Y/mpa8Ln8Ew5c0UeD5RUgJnM/bm
rHvd4BJCRq4hW1MS3Fog9Kmfir1xPGAuFzlJcsrT3QcFXrfLBvS9QrvR/66T8EyZ
brVxSetHSXrH+rWEciXPzQHx+MpcHYJh6Co3fPq0g5DXNBBQu3o=
=ZBZw
-----END PGP SIGNATURE-----

--bn/QtVhC4ahXXV1P--

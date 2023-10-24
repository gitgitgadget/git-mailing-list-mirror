Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADC529416
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 13:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="t1Hbid+I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y+Wq738K"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822581709
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 06:10:48 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id B31BF320014C;
	Tue, 24 Oct 2023 09:10:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 24 Oct 2023 09:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698153047; x=1698239447; bh=+u
	gdG4V/QxZS8eRrEzLxumySsavclQKDyGlTq/LQYsQ=; b=t1Hbid+IqR7VHLsG0G
	fjLSfGoqgmJrLnMPgrgxAGCw/6xLDQf17pOrOHyT2e48dTKap+bXcvU/+6+KJAQl
	1Yiu43kXLsi+l9YT7jwqfAJbKx4BFf6Q69PE42dj+wkxoWd9NomN01j/6vuN40w9
	JgcJDzfQlmomfVom99n6DSl8pkjS7pnMUItLfnOIs+icPiAOFbep8Qg2y7iLZydX
	n9Dpiq96yZeUDLkrJ3X/Ux9o9+qbJYtWGfdRFwtFeP73wocale1yWY1lPNFAWC4e
	KS3f9sh7DLgo/rQfDbpizjzchDEOBX0sHgvrZHr7IItomZ6Ug/5BSD4nhFqi+YTv
	ZkjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698153047; x=1698239447; bh=+ugdG4V/QxZS8
	eRrEzLxumySsavclQKDyGlTq/LQYsQ=; b=Y+Wq738KEYokIr10SdIID+BKOEZsk
	Z3973mQu+boGbJKrPH8G8yOnMdyQWknMVvg1SC/J6dqpv4qPJOAwGPja86PSrdy1
	nEGBMFUUvTjlSpRwomblusRkE0Jbw8GRjmK9tboJ4H5jkAVEwabrjww3P4YhdyPI
	B7A4LnkAc2r3wCk/4FS0CnHeRo5GEa6UssYitz5C0RN+tNuI+3AK8rhaMxUmwrKm
	D9k6OoO977fVb0v/eBZgtPfl/1+jq7vDuF1krBULorH04jWVO7VbVGWtMYxRQGQY
	LxMHHs/0TNNFSbaHHf1vnC8yZFx/nq4vmyP9S6ZUpuwW3ySiZODAu4ZdQ==
X-ME-Sender: <xms:VsI3ZR_8li_kc0RCZ1LDf3DQiT7AbGCLP7d-K3zHBxLGwUqoEZoRiA>
    <xme:VsI3ZVtPV4B2vRkhaAYt1KGNeLJlmaxWN1vMp_0G2XMIAFtwMUgbOOXKzDP6lhr_i
    iv0qVtoUr1U7pb6NQ>
X-ME-Received: <xmr:VsI3ZfDjvB-ZsUT50wCrh3WRsByp6qaKs2R1MsMs373dGsOe_eecVnbGtDr6X8Go1pZHRMnUnInvSu7iC45J-wXhYOxr8zz3PBvQc4X3DnefCGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeekgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:VsI3ZVcZWr6H2As--TWhVzA59CAPmzlrVlRAydVzEZmmCS_ZiV7-Eg>
    <xmx:VsI3ZWO4mAliP6zEwVIKjjI8jSaHs9SBfG7NaJ30G_TTQ9fSGUr-eA>
    <xmx:VsI3ZXkQ2qE7fOWagU3h8KWdDZJuYbzIz_Gw1rTkuXl3IV41Qtqy0g>
    <xmx:V8I3ZfZOT_dCao2oBEIuLDULvKWGgrreNP27DZOnsoUadJ7AK5xSnQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Oct 2023 09:10:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f12babd4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Oct 2023 13:10:41 +0000 (UTC)
Date: Tue, 24 Oct 2023 15:10:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 02/12] builtin/show-ref: split up different subcommands
Message-ID: <7e6ab5dee230dcb66cb8adfe4a8114a06c805802.1698152926.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VlzkQ7PLjYeXel5x"
Content-Disposition: inline
In-Reply-To: <cover.1698152926.git.ps@pks.im>


--VlzkQ7PLjYeXel5x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While not immediately obvious, git-show-ref(1) actually implements three
different subcommands:

    - `git show-ref <patterns>` can be used to list references that
      match a specific pattern.

    - `git show-ref --verify <refs>` can be used to list references.
      These are _not_ patterns.

    - `git show-ref --exclude-existing` can be used as a filter that
      reads references from standard input, performing some conversions
      on each of them.

Let's make this more explicit in the code by splitting up the three
subcommands into separate functions. This also allows us to address the
confusingly named `patterns` variable, which may hold either patterns or
reference names.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/show-ref.c | 100 ++++++++++++++++++++++++---------------------
 1 file changed, 53 insertions(+), 47 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 7efab14b96c..56ee3250c5f 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -104,7 +104,7 @@ static int add_existing(const char *refname,
  * (4) ignore if refname is a ref that exists in the local repository;
  * (5) otherwise output the line.
  */
-static int exclude_existing(const char *match)
+static int cmd_show_ref__exclude_existing(const char *match)
 {
 	static struct string_list existing_refs =3D STRING_LIST_INIT_DUP;
 	char buf[1024];
@@ -142,6 +142,53 @@ static int exclude_existing(const char *match)
 	return 0;
 }
=20
+static int cmd_show_ref__verify(const char **refs)
+{
+	if (!refs || !*refs)
+		die("--verify requires a reference");
+
+	while (*refs) {
+		struct object_id oid;
+
+		if ((starts_with(*refs, "refs/") || !strcmp(*refs, "HEAD")) &&
+		    !read_ref(*refs, &oid)) {
+			show_one(*refs, &oid);
+		}
+		else if (!quiet)
+			die("'%s' - not a valid ref", *refs);
+		else
+			return 1;
+		refs++;
+	}
+
+	return 0;
+}
+
+static int cmd_show_ref__patterns(const char **patterns)
+{
+	struct show_ref_data show_ref_data =3D {
+		.patterns =3D (patterns && *patterns) ? patterns : NULL,
+	};
+
+	if (show_head)
+		head_ref(show_ref, &show_ref_data);
+	if (heads_only || tags_only) {
+		if (heads_only)
+			for_each_fullref_in("refs/heads/", show_ref, &show_ref_data);
+		if (tags_only)
+			for_each_fullref_in("refs/tags/", show_ref, &show_ref_data);
+	} else {
+		for_each_ref(show_ref, &show_ref_data);
+	}
+	if (!found_match) {
+		if (verify && !quiet)
+			die("No match");
+		return 1;
+	}
+
+	return 0;
+}
+
 static int hash_callback(const struct option *opt, const char *arg, int un=
set)
 {
 	hash_only =3D 1;
@@ -185,56 +232,15 @@ static const struct option show_ref_options[] =3D {
=20
 int cmd_show_ref(int argc, const char **argv, const char *prefix)
 {
-	struct show_ref_data show_ref_data =3D {0};
-	const char **patterns;
-
 	git_config(git_default_config, NULL);
=20
 	argc =3D parse_options(argc, argv, prefix, show_ref_options,
 			     show_ref_usage, 0);
=20
 	if (exclude_arg)
-		return exclude_existing(exclude_existing_arg);
-
-	patterns =3D argv;
-	if (!*patterns)
-		patterns =3D NULL;
-
-	if (verify) {
-		if (!patterns)
-			die("--verify requires a reference");
-		while (*patterns) {
-			struct object_id oid;
-
-			if ((starts_with(*patterns, "refs/") || !strcmp(*patterns, "HEAD")) &&
-			    !read_ref(*patterns, &oid)) {
-				show_one(*patterns, &oid);
-			}
-			else if (!quiet)
-				die("'%s' - not a valid ref", *patterns);
-			else
-				return 1;
-			patterns++;
-		}
-		return 0;
-	}
-
-	show_ref_data.patterns =3D patterns;
-
-	if (show_head)
-		head_ref(show_ref, &show_ref_data);
-	if (heads_only || tags_only) {
-		if (heads_only)
-			for_each_fullref_in("refs/heads/", show_ref, &show_ref_data);
-		if (tags_only)
-			for_each_fullref_in("refs/tags/", show_ref, &show_ref_data);
-	} else {
-		for_each_ref(show_ref, &show_ref_data);
-	}
-	if (!found_match) {
-		if (verify && !quiet)
-			die("No match");
-		return 1;
-	}
-	return 0;
+		return cmd_show_ref__exclude_existing(exclude_existing_arg);
+	else if (verify)
+		return cmd_show_ref__verify(argv);
+	else
+		return cmd_show_ref__patterns(argv);
 }
--=20
2.42.0


--VlzkQ7PLjYeXel5x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU3wlMACgkQVbJhu7ck
PpR/Sg/+MdsaNVqKSgsBWPQWNnR2x8g1T+ZNPjpIvbDPGrFh9K1WTptq3d07whU3
NRnackuCPqQ6slkX0Vd4vz49uYlHHCOnvoJ2Yv4TtRaPnl+tAT9gqO40IjB7fS4w
snVHL5XyI1cs6Q9It8tg60dP+TV/Je6/UPePfbqfPEwzTARczaWTqoNFrnuhumhW
Q9Nank47H93Zd6Oe+ilhtFOQTs/xl9CefsDeg97di0OqxmLqT1mdkuuWSDYAePjw
m7KGp5ERuTTFf/mhzDb2zoAuIaBOJIdV19zQQ9o2MDOvWHOvb7cYZU0sem5qrQte
L7qljUhDyOApmrNlP7DUO2sOIapa1x4fKGrMGsge+dWQu4fJsgn9kDE92Nt6u2Ec
AYGzcV/xstF3vYolrwojPR/l2XiHWeSwyMVXDbfvazgcXspJtMJiHVvDDeilBWaa
LeRGJ2AvnzTUJRPcj3lRqoMKSIrAMWWte/P/iepc/EsPV6UkGc4R9O8OoTDub/UT
OpkYHdyjsTjxIL/ATFekQa52WX+GupukaaMJPN4dSNqQYZXLGy6EJpRtPrY+HvJ2
7ISe3xCjgsIHhm9iTjlqoy5mRiSAml/fOKE9KAoU2BmyY5TMaDQwFLUD9Ft6Zk6u
yAdiejX4/wHRpK9K3Uqfp6Xg6qycgcG8UMdte2w8xdQAVqyRnjM=
=ylXQ
-----END PGP SIGNATURE-----

--VlzkQ7PLjYeXel5x--

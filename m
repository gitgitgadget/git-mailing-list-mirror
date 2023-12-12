Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PjEXYcOH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cF7oiQIu"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48163BF
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 23:18:53 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 8CA3B3200A49;
	Tue, 12 Dec 2023 02:18:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 12 Dec 2023 02:18:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702365532; x=1702451932; bh=ht6WP2WCLu
	iTaS8C7EZrdkVveLwGbvEcCSEFFiZGeJ0=; b=PjEXYcOHQQd1280smGExk6CGIB
	GLzIy1X6NtZeTz0y9UYYbj7xwPC2w1WM3dOcMcFJrY0lCwX73vXNQ0KzO7sFu29w
	ZBVH/asOrjYPIwgk+XZ6MlAvS0aUKEpqZWj6Ih8l7ijhZtFQsLe3Y1Clzp8pw10S
	uWPp90BBlbMMNcI/+ebIcuXxubFmXlY30AW3KWYrFPLAZ6OJIIbawkfYW7G3VjZD
	HtWsH13Hd7rHLhigeeEryvHlerP28rptDAZ5J7OXT7Ihenge2voKCxuaq7mnuU8C
	FY6SdabN7Ibe62Mt5JIqKpwiqXxP3rzClrhJqcLkogpSKZlm5hX9Ntqta/NQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702365532; x=1702451932; bh=ht6WP2WCLuiTaS8C7EZrdkVveLwG
	bvEcCSEFFiZGeJ0=; b=cF7oiQIu2dBNnM0uwdpyk7XjKJmWGQleqhlwDuxayrAu
	sTucN0Modo/wGJcB5wJJutKzUyTnEp+o8U5JybU7TF2BAuUzzCvSXPjFIq2dJzhk
	NZCQ80Mt8LbyT1XtM43KokEQakCZAmGBfAtsvEaLCoQdLsTRI8MTYVeqwcmbsnwt
	02OhLgXjD2EoBQD64AA9Lw1xlaVMyvH4o6LAOL+O/D5SEnncNEJp4LEOWo4PHwn9
	r1fiR0tqcQo8M5ZAMKgr1PaUUO1D/CsuYw/jIFH7VGExHAHQeCEuaAyePywz12yS
	ohvBMAlDqG07gr5AjfTrS0jJ61e9HVVH6VlSbl1vWw==
X-ME-Sender: <xms:Wwl4ZTBNKbr8YcpTGP2zQxxMnzmZ192theqve-jboLWK4uiDhtPA6w>
    <xme:Wwl4ZZgZJW84FAfnGYO3UCupRnOpEPw5lwz4mSuGeus7DWhuQHV8bKB1uvUSMCZFO
    v_NrcDhlhcVDVlGyw>
X-ME-Received: <xmr:Wwl4ZenNSgfHay0Dt6Rz8zEswtS2pPzIK8H6GygN3g1K-ET4mykRbwKYRDymcxXzrQQKGKOIPJI6ZTenJLMih0Hk-ECzGua7tKCw6epDXVBfYIs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelfedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:Wwl4ZVxuiHUehV_CIJ2Q61OU1ELHmNRcbml9trV-gKsz1oePvzgyvw>
    <xmx:Wwl4ZYRpUV-PxDqtodBddaaxs1c7Tq4-MwdvieMD2WkNDkGPy_FnUA>
    <xmx:Wwl4ZYYhDfmbU3SVhzOUMaOmwJ--cPOTQ_iI2ibtDob-BAHvEHyaKw>
    <xmx:XAl4ZTJpxBXz0hw_U4biQV05505Z592V0zYOFjo5IaXWMLhZgCU6aQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Dec 2023 02:18:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c9ad96c2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 Dec 2023 07:17:12 +0000 (UTC)
Date: Tue, 12 Dec 2023 08:18:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 1/4] wt-status: read HEAD and ORIG_HEAD via the refdb
Message-ID: <1db3eb3945432964aabe1c559db4c3ac251e83fd.1702365291.git.ps@pks.im>
References: <cover.1701243201.git.ps@pks.im>
 <cover.1702365291.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F0Slyc/Q+IzrCCK0"
Content-Disposition: inline
In-Reply-To: <cover.1702365291.git.ps@pks.im>


--F0Slyc/Q+IzrCCK0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We read both the HEAD and ORIG_HEAD references directly from the
filesystem in order to figure out whether we're currently splitting a
commit. If both of the following are true:

  - HEAD points to the same object as "rebase-merge/amend".

  - ORIG_HEAD points to the same object as "rebase-merge/orig-head".

Then we are currently splitting commits.

The current code only works by chance because we only have a single
reference backend implementation. Refactor it to instead read both refs
via the refdb layer so that we'll also be compatible with alternate
reference backends.

Note that we pass `RESOLVE_REF_NO_RECURSE` to `read_ref_full()`. This is
because we didn't resolve symrefs before either, and in practice none of
the refs in "rebase-merge/" would be symbolic. We thus don't want to
resolve symrefs with the new code either to retain the old behaviour.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 wt-status.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 9f45bf6949..fe9e590b80 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1295,26 +1295,27 @@ static char *read_line_from_git_path(const char *fi=
lename)
 static int split_commit_in_progress(struct wt_status *s)
 {
 	int split_in_progress =3D 0;
-	char *head, *orig_head, *rebase_amend, *rebase_orig_head;
+	struct object_id head_oid, orig_head_oid;
+	char *rebase_amend, *rebase_orig_head;
=20
 	if ((!s->amend && !s->nowarn && !s->workdir_dirty) ||
 	    !s->branch || strcmp(s->branch, "HEAD"))
 		return 0;
=20
-	head =3D read_line_from_git_path("HEAD");
-	orig_head =3D read_line_from_git_path("ORIG_HEAD");
+	if (read_ref_full("HEAD", RESOLVE_REF_NO_RECURSE, &head_oid, NULL) ||
+	    read_ref_full("ORIG_HEAD", RESOLVE_REF_NO_RECURSE, &orig_head_oid, NU=
LL))
+		return 0;
+
 	rebase_amend =3D read_line_from_git_path("rebase-merge/amend");
 	rebase_orig_head =3D read_line_from_git_path("rebase-merge/orig-head");
=20
-	if (!head || !orig_head || !rebase_amend || !rebase_orig_head)
+	if (!rebase_amend || !rebase_orig_head)
 		; /* fall through, no split in progress */
 	else if (!strcmp(rebase_amend, rebase_orig_head))
-		split_in_progress =3D !!strcmp(head, rebase_amend);
-	else if (strcmp(orig_head, rebase_orig_head))
+		split_in_progress =3D !!strcmp(oid_to_hex(&head_oid), rebase_amend);
+	else if (strcmp(oid_to_hex(&orig_head_oid), rebase_orig_head))
 		split_in_progress =3D 1;
=20
-	free(head);
-	free(orig_head);
 	free(rebase_amend);
 	free(rebase_orig_head);
=20
--=20
2.43.GIT


--F0Slyc/Q+IzrCCK0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV4CVcACgkQVbJhu7ck
PpSMwg/+OaBkBNX1pikvLI4G+ikvL/jHZb1rpTc+UIVW9Q/4fBYOsLZM9U/bGdnj
v+YAqeHploFUXpDogZUvOohEKFsYu8g4olBRrl+q1Y2CUH04i+R4kdnpHA2xcbXh
i+OYGoh2g/8qzCYG+XiYvjDLdkYOfnBP+1rviTzB4rjzzFm0vAq4hcQdi9qw6oom
kucl6XkQTq5EHzFYkwGFxzXqISF+2eBEj6YDr2BkB67CFJaKJcrmQGOvHnOk0wjj
GH/Sz51rAyO0f1rh9GtMeLc1Mr2DEjln9Fdl8q1Jtk7odAlkweQL4cYA4v/JB5BN
8SSOEZcbZTUqOa6G+F0Op8Y2BL2eHBQetnCp66UR5QpWjA7/hu8E5HhrN4BlbvAa
ml0WptP4/l9/6xRoqtcfEn7bzzf49AGM4VzmqVtl6GaG63XicdTWtyNg1TsReU7E
8h8TZr98GfB0Ja17JSYCR+ALR1h8tHEWY51BZ60vht9An/JD7r9JJETB5DrdAQdA
et6qb3MUGh8jtttpK6Jf2bvXMlEU9A+Ysjai5JKAGo7jYwmO5QN2VRoKuCvy6b+d
G6KdtKh32JJsq3hjUUawpZWlfSx7bwdnNJvuDM7xJwWFahyAY/LWeB26MqXEsbbK
v7Z66Fs8vHUrlv+uTb7jhBKoTjPZ8qvONz62RbVs+IxV3gr3rNs=
=j7pM
-----END PGP SIGNATURE-----

--F0Slyc/Q+IzrCCK0--

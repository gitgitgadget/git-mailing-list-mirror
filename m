Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEC72C850
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 14:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XTJi66ZC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mEJ+9fl/"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AFDDC
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 07:05:15 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 272863200A8E;
	Tue, 24 Oct 2023 10:05:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 24 Oct 2023 10:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698156313; x=1698242713; bh=Wx
	3ZUx2HqPkZz8f/zHU3CJgu7TWN6FHawgUmSnqQ1/A=; b=XTJi66ZCZ6hArG78XP
	hrPQxvf1LIMjllqvUipMzaN4LZyKXXLvkGbRFpZAuJoe0Kr05ywp1xB4tDtdWUkz
	BcnGQmUKhITBmm9NqkaYAe5BfFLfnbUWQaExvaidchmuvacr1o4g9IX4mSJqF4e7
	5aua4rmuGuPda578UaTcx4UgtdGOZFj4jvYHHn4io2MrOWIT9+NbJujyA9zF+0Le
	nCVsZhJOQknuw3XaW+5bOobFdoyOPNnpE1Ajioj7bQun4ziJ9MkwFqhk2lklAOyN
	HMhcgDSt42hZ7ptCtbsKkP+2saNmv1hpN+CYZ44gq7jTXjx2/VrjviFoXJukoQ6Z
	cobQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698156313; x=1698242713; bh=Wx3ZUx2HqPkZz
	8f/zHU3CJgu7TWN6FHawgUmSnqQ1/A=; b=mEJ+9fl/IF/YgzDE0j14+dejtS/eR
	VW4IJeYHa4KHHsoNEY0axWdkWkoJEGiPlT4kxkKwQfFSaFl9Al8NV+jD11+n3mEh
	aPXEvJ8sjHveGwt64hyMjqreh5N7ZFJOxOyOqMzRLxIb6dDTWXY8qABg9QAkX+3+
	H0OQ1lXWb2vzrY7HyyQtjzsQ/8clQWOzDRreYsYPcv8WoZ7+6ST8FUDludtkgWcs
	2rtJysf3HR7T+TktsrNYDrTd+6175Kmqgqz40AlmI6I2HJ/IAELsxAUjUzT+u8vx
	dbSvInyLqwYxzL67ktSL2KIvqZAoV2QkT4hrNoyFoCYUBAVVL51tARR4Q==
X-ME-Sender: <xms:Gc83ZZ8e7eYxf7RgGzM6MGICsITxbboeCOJkwoZj-lvPPY6fd80NoA>
    <xme:Gc83Zdv_AsG1IjuHZe5pfS8hhfhEn7U4Vquxw5hn6fc-OMSylCSGEnQDEOZ75svZy
    2naYcJoOJAiTaOiEw>
X-ME-Received: <xmr:Gc83ZXAKap9ESlgkGahniMRB-0IdLDZlU5gC-IA8omoa_m2_l8JHb87BP5avlqwsrUUrMOC4JianW4YugkyDYV7BJOzq6LWprBwLT6C14WKts5o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeekgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:Gc83Zdd9qilzW-8YFGBnwkyB3aL5NbePP7sAnQCf6oW5HV3tGQZadg>
    <xmx:Gc83ZeOCHpttdQZzihCe4DlCUoaTcUm5BDx00M01Dy9YW4WaegBH4A>
    <xmx:Gc83ZflIwHn5UvbeXVrs6y5vXgxhqaAu75bs7KzkgpY0HWGfmCdyeQ>
    <xmx:Gc83Zbp0wTdlbZdhgxSLJN1p6hJUeOtZS5Q1-TpHk7tnwiSNk1fMVA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Oct 2023 10:05:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7f8a1993 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Oct 2023 14:05:07 +0000 (UTC)
Date: Tue, 24 Oct 2023 16:05:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwen@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/9] t1450: convert tests to remove worktrees via
 git-worktree(1)
Message-ID: <089565a358eb28544f0ad6b83b8c47e1edf2db6f.1698156169.git.ps@pks.im>
References: <cover.1697607222.git.ps@pks.im>
 <cover.1698156169.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jR/NE5SfnHaMqMiM"
Content-Disposition: inline
In-Reply-To: <cover.1698156169.git.ps@pks.im>


--jR/NE5SfnHaMqMiM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some of our tests in t1450 create worktrees and then corrupt them.
As it is impossible to delete such worktrees via a normal call to `git
worktree remove`, we instead opt to remove them manually by calling
rm(1) instead.

This is ultimately unnecessary though as we can use the `-f` switch to
remove the worktree. Let's convert the tests to do so such that we don't
have to reach into internal implementation details of worktrees.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1450-fsck.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index a3c97b9c7fc..a6af550867c 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -141,7 +141,7 @@ test_expect_success 'HEAD link pointing at a funny plac=
e' '
=20
 test_expect_success 'HEAD link pointing at a funny object (from different =
wt)' '
 	test_when_finished "git update-ref HEAD $orig_head" &&
-	test_when_finished "rm -rf .git/worktrees wt" &&
+	test_when_finished "git worktree remove -f wt" &&
 	git worktree add wt &&
 	echo $ZERO_OID >.git/HEAD &&
 	# avoid corrupt/broken HEAD from interfering with repo discovery
@@ -150,7 +150,7 @@ test_expect_success 'HEAD link pointing at a funny obje=
ct (from different wt)' '
 '
=20
 test_expect_success 'other worktree HEAD link pointing at a funny object' '
-	test_when_finished "rm -rf .git/worktrees other" &&
+	test_when_finished "git worktree remove -f other" &&
 	git worktree add other &&
 	echo $ZERO_OID >.git/worktrees/other/HEAD &&
 	test_must_fail git fsck 2>out &&
@@ -158,7 +158,7 @@ test_expect_success 'other worktree HEAD link pointing =
at a funny object' '
 '
=20
 test_expect_success 'other worktree HEAD link pointing at missing object' '
-	test_when_finished "rm -rf .git/worktrees other" &&
+	test_when_finished "git worktree remove -f other" &&
 	git worktree add other &&
 	object_id=3D$(echo "Contents missing from repo" | git hash-object --stdin=
) &&
 	test-tool -C other ref-store main update-ref msg HEAD $object_id "" REF_N=
O_DEREF,REF_SKIP_OID_VERIFICATION &&
@@ -167,7 +167,7 @@ test_expect_success 'other worktree HEAD link pointing =
at missing object' '
 '
=20
 test_expect_success 'other worktree HEAD link pointing at a funny place' '
-	test_when_finished "rm -rf .git/worktrees other" &&
+	test_when_finished "git worktree remove -f other" &&
 	git worktree add other &&
 	git -C other symbolic-ref HEAD refs/funny/place &&
 	test_must_fail git fsck 2>out &&
--=20
2.42.0


--jR/NE5SfnHaMqMiM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU3zxYACgkQVbJhu7ck
PpRL8Q//e1d3k3J4jVH1i4/fqowMy1LwgjCb8bD1M3pImoXtE6Z7ok/ZL/UpHVqJ
gc5UPEkVVyv5IggtDjdleqxeMlv3ZBGYpKzoHpV3QEoEiW9A4w46digj+B7wUKu0
c+Kp1VLEeUrW1UB8GC5xu0Ntx0m2hISMeOYlKaTyB3WAYw4QeROnHEeO6JxJ3wl/
dr8wHWDuM6xP5hzgMMgs+9EU4PfEW3VetG5txJIWl8smUD0PoxqJ5kVU5FeHs8sO
wLjbSvxHI/T1hdIN2U6B6XcEtKrjOgQwEZOXlvOn6b/vVpVYUSXKTgz3DeQ9JAwG
/QlnwgfxPPyySV6dRRx59pXtdMKtt7okbdzTP/b952VQhubrB2cxnIq1Lfi/2rxV
lbji0ADbiq7UsEv8Mqm4PNMKvKOW+ggTjX4T/YKSWLtUdWKPffqIH2zNECNWDj3a
gXVSX6AtSvRquWAWsLmB8PG/pYWfyI8Lgc7bfAlP+3J+cHG54foP6kylBcqjFOaB
k3ksl/2fXcl2VxfxW0uyJNic4s3FJsiJs4DisZ8b1asTyBVxKhHfBO9ZFy3UO+lm
OG2dGWzFUpAE8dgDFJNje0W3T9TacFIQqPJfMy9XVUfbbvDOsrJGPcj0L+Vf0cRB
7lYeZw7l2xae7gSoc/bKArUzVTFmRLYNuiLSGoaHEiDx5HQbYAg=
=D4nq
-----END PGP SIGNATURE-----

--jR/NE5SfnHaMqMiM--

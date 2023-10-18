Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54C411C81
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 05:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Elx2UO5s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gHxyAKZj"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92217101
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 22:35:37 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id E8B513200B3C;
	Wed, 18 Oct 2023 01:35:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 18 Oct 2023 01:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1697607336; x=1697693736; bh=cl
	rUqti/8Eznkz84u5rw4q7Oi0n/aQ74TEJ+XsmZEsM=; b=Elx2UO5sFd7ZvWBI0t
	GCdt72KiHjjMpHjuCorYvNeYYx3VUvUxkupCHnaYLav4yQbod0aNH5LgeKd4DoYF
	S1kPRk8XfKTEPifK6oqfoUaVEBTmAYwsjW5LFLKb0ybO9xVeHFaXZ3J7sDUvK4PJ
	6EZusS7zemmId7Kf66wYZjDobTx9OKIC7N6GUSUrHN+dYXO9KxnoQbf4GLb5oDKc
	mjPVStv6VP8XHF4kQ+ZT1QXtEIZGf4yUKcJr5c3wfuiku4+JXGdcC78lqJw6S4tZ
	IhAqzlFEYsAZBZRJHlGxBhv5QHr14nl4E0Glci4HHD8PIhLd+f63Cvte/DvvfHKm
	K9rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1697607336; x=1697693736; bh=clrUqti/8Eznk
	z84u5rw4q7Oi0n/aQ74TEJ+XsmZEsM=; b=gHxyAKZj7b2Ror+WjeHihSHePVQBX
	hJnYStkZiXfTGK48ut2ooD/u5DyUqzyVY4qSKyY+rglSb0GdnWUwwK8m+PtpVaN1
	VM9wKWXhBmDgrE0nnVA96dNwwKUsNXC9Inq1YUeKLWTyF+uWaJOIabiMxPpesAAg
	pPJ3P0zFgDqif7l82hyrBpSrTpFDwKFrYgLMQp0ocvtkjuhcnIbolx0eFcWqBymU
	NthNFrVDzq8tsGkRRVUpn9FF0xbZ4cXf9IppLAVEvTI8wzgzGxHFOewDRu44TmYC
	CKU+exnHwo3peYBPQ9Vf2moH/JuV8LpfXSkl+XRW5wzahucXcILmyQt9g==
X-ME-Sender: <xms:qG4vZYMamSBjiDAqDxA5xQzHNvEh-aYtL2ixDosdHxAPjGrR1sQH5Q>
    <xme:qG4vZe8XvMHERmIIN1vX1_Y_9UNaGWcJV8f_egTFjxewbWHK15jsK4vG7Ss1WJOkj
    oFeR0Lt3C_EoVkmmw>
X-ME-Received: <xmr:qG4vZfRCS8Qbf9exvSikOzQ4SJdDaL_QbVltBPMpfdAQDb7LpgXiYDSFP6f6kupcer9XGM4yxRsebrNI7V5UTuTst32wi9JC8cCKjRQTeVc0xYxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeefgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:qG4vZQsmBsh3lb-CTxmSUaQppfVn36M2092irsAkeIiyvRH3Pu9Isg>
    <xmx:qG4vZQfZM4lrMjvCpa0cvZLzV1x5PrX8v2p_WT-E2ED97LKA7eRtjw>
    <xmx:qG4vZU1OaqVVESzrvbZNPWG8trMZztamSb0luZt6JyL_cvRN47DpEg>
    <xmx:qG4vZYlK2m0h_NF1DE9ymUBYlRfXXudJHZxVAo75NxY3pUwjV84CJA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Oct 2023 01:35:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id af4c2e57 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Oct 2023 05:35:34 +0000 (UTC)
Date: Wed, 18 Oct 2023 07:35:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 07/11] t1450: convert tests to remove worktrees via
 git-worktree(1)
Message-ID: <3dc65a800746d54e41460fb019abddb7d4524586.1697607222.git.ps@pks.im>
References: <cover.1697607222.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hLrreL9wsLoeTpvo"
Content-Disposition: inline
In-Reply-To: <cover.1697607222.git.ps@pks.im>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--hLrreL9wsLoeTpvo
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
index 804a5594ddd..d356605d132 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -143,7 +143,7 @@ test_expect_success 'HEAD link pointing at a funny plac=
e' '
 test_expect_success 'HEAD link pointing at a funny object (from different =
wt)' '
 	saved_head=3D$(git rev-parse --verify HEAD) &&
 	test_when_finished "git update-ref HEAD $saved_head" &&
-	test_when_finished "rm -rf .git/worktrees wt" &&
+	test_when_finished "git worktree remove -f wt" &&
 	git worktree add wt &&
 	echo $ZERO_OID >.git/HEAD &&
 	# avoid corrupt/broken HEAD from interfering with repo discovery
@@ -152,7 +152,7 @@ test_expect_success 'HEAD link pointing at a funny obje=
ct (from different wt)' '
 '
=20
 test_expect_success 'other worktree HEAD link pointing at a funny object' '
-	test_when_finished "rm -rf .git/worktrees other" &&
+	test_when_finished "git worktree remove -f other" &&
 	git worktree add other &&
 	echo $ZERO_OID >.git/worktrees/other/HEAD &&
 	test_must_fail git fsck 2>out &&
@@ -160,7 +160,7 @@ test_expect_success 'other worktree HEAD link pointing =
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
@@ -169,7 +169,7 @@ test_expect_success 'other worktree HEAD link pointing =
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


--hLrreL9wsLoeTpvo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUvbqQACgkQVbJhu7ck
PpS+BQ//QESi4Ht/+G2TjXF8wn8Jb7qLViChxwtcORl9L7zpI4AJc2xItULa79mG
IRn5zied3K74hielgzOFIQACihcl9GlY7hrSfwC5BATgThAYURC1iGRshgyK4Wj3
akffxO0ItlC6LvtvxRmYM6EF/rFsnaa4uQj3oE8IvY5K8mH9nOOP5d4Vl3uAUgg9
0x3xh4dkFXplPI/xTNfx6c+pnu73hdvanVKB6kH1b+gsdl+QMY58fe7g4a60NXRb
HhEpCnOTo1DPmDcuI1eVUZKybArhoqiwQv/AA8MGdZAaUPt7taPqNwJLt3yB4fxv
4K7Q0nfSC05/zxFSac2mTecl97rBsO99gvHwd3wYMHR83AycSD+JBn8RkoG04E3n
tz7T5uSxCAA6ZgI1rVHz1iKwxlf4qq4QCrm4CsqAiqQBcVbFKkb8F+WxBRbumh1p
AdJ18icy9BNjGb7h+twilUBZmFfv/RYttPH7/8xaMFFv3aEQJ7kRW1npd/QsBitn
Gg7J+M8nI8VjE+8IdK2wm6ZwSo152ilNGoedPn3EkUwPq4JNcvEv+4SEojQ6FaCT
LbRwEMObMxpP+TSHwPO7k9h8G105mjTnea49DY5tiT2+BBAhDHcnlUE/c/1W70yy
sfPlp0JpkjtXzdNyIdeNOLD1qNIp6+IdET/dzPp58Ceoq3BfdaM=
=0Rgs
-----END PGP SIGNATURE-----

--hLrreL9wsLoeTpvo--

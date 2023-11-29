Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OBSvy4/G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xut1qifl"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3947819BB
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 23:24:52 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id A1F9C5C01B9
	for <git@vger.kernel.org>; Wed, 29 Nov 2023 02:24:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 29 Nov 2023 02:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701242691; x=1701329091; bh=/i
	Yl6Y9SWonrSiL+JkK0h8gNWsdHv/uqQTYKLILDoZU=; b=OBSvy4/GSsVeAgXfXj
	TeolQ9bC/2IpGgFSWbqvzXXYye7Vvkru7jvDARGrsHsN7ezkcrahWidB64JHbJd3
	B6KFUssu0AL6FD4wdVmCxL7U0cY0dIKXPVqYgfA8e3E5za1FX6uHwsTpNhbL7YQm
	9VVfiCDtOFfe4mOyp7OkvZ1VAVgt9kgKAi+OmNx5X3NmyGUMi7xykO/wyGB06xW8
	7LODwdZi7ctCoRK5R7JUTMPDuWX9/rR7/BiOog/an9x6A2mvT239LNOIP0QYAymJ
	9n6PE2Y/zCt2L+17kq8DnDZdrZ0eXYcAnlbdrJcFYaeL+xjVS+JaYj4lago14B4K
	Z4jA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701242691; x=1701329091; bh=/iYl6Y9SWonrS
	iL+JkK0h8gNWsdHv/uqQTYKLILDoZU=; b=Xut1qiflVkDUFlRXO7fiKe8quRATT
	kh9X/2Tm7rdssqSXPkaBjyfNqWo5MbxBZD6vvIg8j22KolDjuUww318yrKrnebyv
	0vyqvFxkdL4G1ZuPcHg44VZJSs4nMUN5GEnbvLWKxhUJBQGNkFQwtvplZa8P7RJB
	gxGkb7wutgE/qWDWykmGvxIhoCGqTQIfZMV4JUaf2P+UG4Hxk4zCCm6k+Oa2CQaY
	3Q56Wm1c8QrM0LR5ZqeHK021ba2M/sewLmkX6IQ4UaCgXFRmiF2XHQZYp1nfxcdE
	6A4HDhmEkmncsLFJqIeR8hXZILJ93YWOGUbZM3ZqPsSolONTTQIGBc0rg==
X-ME-Sender: <xms:Q-dmZfxomBBZOkSnij_yFK1y7eYTPTqWr-NxQI6PXW0MnTfTez-DBg>
    <xme:Q-dmZXQ3fZeV_tzmlYXl07OjxVTiijhzDBwMPDMxySmdUaur4NNNzxCXqu0-E55g-
    hVpyNrKWgzBDcOWug>
X-ME-Received: <xmr:Q-dmZZUsc642fOgSuCAPjMjVM0jO_ulYIELRkkX6Xz9FW2PhHXTOvNt_p-4w-e49GlVHOl-PVLavLgAN2CJeFevqfxqTIlDWbED7gjyQDyq0PN7H>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeigedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Q-dmZZhFV1Wt1mW9jMY78YDEGo-EQU2scFkb8E4EWphxx4Og-R5FIw>
    <xmx:Q-dmZRD2EvO8ryubwwJCsWgM_b_XD6fPTq7rOfj1TwKAWFaKco6zvw>
    <xmx:Q-dmZSLBy7-qTjygcfbsVbRHDE-Zxd_l3I2CVLZfaLkz5mHoUIzYiA>
    <xmx:Q-dmZc9kHcy_fOfkda1ztTmYs7VJPajEHrYEKrzPx6wm5wftf6QGJg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 29 Nov 2023 02:24:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3d652ad7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 29 Nov 2023 07:23:36 +0000 (UTC)
Date: Wed, 29 Nov 2023 08:24:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 02/10] t1400: split up generic reflog tests from the
 reffile-specific ones
Message-ID: <f07ddfaf2cca7f2afdfbc21319584ef68333680d.1701242407.git.ps@pks.im>
References: <cover.1701242407.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="48R44SfAXCXyY/dp"
Content-Disposition: inline
In-Reply-To: <cover.1701242407.git.ps@pks.im>


--48R44SfAXCXyY/dp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We have a bunch of tests in t1400 that check whether we correctly read
reflog entries. These tests create the reflog by manually writing to the
respective loose file, which makes them specific to the files backend.
But while some of them do indeed exercise very specific edge cases in
the reffiles backend, most of the tests exercise generic functionality
that should be common to all backends.

Unfortunately, we can't easily adapt all of the tests to work with all
backends. Instead, split out the reffile-specific tests from the ones
that should work with all backends and refactor the generic ones to not
write to the on-disk files directly anymore.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1400-update-ref.sh | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 9ac4b7036b..c41cd9b6bf 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -354,14 +354,28 @@ test_expect_success "verifying $m's log (logged by co=
nfig)" '
 '
=20
 test_expect_success 'set up for querying the reflog' '
+	git update-ref -d $m &&
+	test-tool ref-store main delete-reflog $m &&
+
+	GIT_COMMITTER_DATE=3D"1117150320 -0500" git update-ref $m $C &&
+	GIT_COMMITTER_DATE=3D"1117150350 -0500" git update-ref $m $A &&
+	GIT_COMMITTER_DATE=3D"1117150380 -0500" git update-ref $m $B &&
+	GIT_COMMITTER_DATE=3D"1117150680 -0500" git update-ref $m $F &&
+	GIT_COMMITTER_DATE=3D"1117150980 -0500" git update-ref $m $E &&
 	git update-ref $m $D &&
-	cat >.git/logs/$m <<-EOF
+	# Delete the last reflog entry so that the tip of m and the reflog for
+	# it disagree.
+	git reflog delete $m@{0} &&
+
+	cat >expect <<-EOF &&
 	$Z $C $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150320 -0500
 	$C $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150350 -0500
 	$A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150380 -0500
-	$F $Z $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150680 -0500
-	$Z $E $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150980 -0500
+	$B $F $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150680 -0500
+	$F $E $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150980 -0500
 	EOF
+	test-tool ref-store main for-each-reflog-ent $m >actual &&
+	test_cmp expect actual
 '
=20
 ed=3D"Thu, 26 May 2005 18:32:00 -0500"
@@ -409,13 +423,12 @@ test_expect_success 'Query "main@{2005-05-26 23:33:01=
}" (middle of history with
 	test_when_finished "rm -f o e" &&
 	git rev-parse --verify "main@{2005-05-26 23:33:01}" >o 2>e &&
 	echo "$B" >expect &&
-	test_cmp expect o &&
-	test_grep -F "warning: log for ref $m has gap after $gd" e
+	test_cmp expect o
 '
 test_expect_success 'Query "main@{2005-05-26 23:38:00}" (middle of history=
)' '
 	test_when_finished "rm -f o e" &&
 	git rev-parse --verify "main@{2005-05-26 23:38:00}" >o 2>e &&
-	echo "$Z" >expect &&
+	echo "$F" >expect &&
 	test_cmp expect o &&
 	test_must_be_empty e
 '
@@ -436,6 +449,22 @@ test_expect_success 'Query "main@{2005-05-28}" (past e=
nd of history)' '
=20
 rm -f .git/$m .git/logs/$m expect
=20
+test_expect_success REFFILES 'query reflog with gap' '
+	test_when_finished "git update-ref -d $m" &&
+
+	git update-ref $m $F &&
+	cat >.git/logs/$m <<-EOF &&
+	$Z $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150320 -0500
+	$A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150380 -0500
+	$D $F $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150680 -0500
+	EOF
+
+	git rev-parse --verify "main@{2005-05-26 23:33:01}" >actual 2>stderr &&
+	echo "$B" >expect &&
+	test_cmp expect actual &&
+	test_grep -F "warning: log for ref $m has gap after $gd" stderr
+'
+
 test_expect_success 'creating initial files' '
 	test_when_finished rm -f M &&
 	echo TEST >F &&
--=20
2.43.0


--48R44SfAXCXyY/dp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVm5zwACgkQVbJhu7ck
PpSeOA/7BkX5AdgW6tsP+pbMS9NSMx0wsjEGuwhUvZJvn8TB2Ceh3QEp4aqjjEbF
bu3NIch+f3iToW92Z1e2GYb9aiLZLw1XSE3Roa2xMOIjbh34HCp51RP2KAMVC+gx
s10ig9fOgU0x7Rgn9vPqMPh969VuL7q/dv0j5//MtpJdmM6+n4Cy7soAaVAFvzu3
MLFxjWeNjtKCgnO0bgUw130v3M2nFa6wywsdSeIVzPxllRQpEiUvEb69LJ65Hpi3
iisKhafeMdiKoUslqgpabcAQyT/JMYpsZxF5JxlZMSn5VZPlmhPgbd4455dIN1kf
XhVem/zp7F03Gn5ZiYID58PZqDtxikDuh34MCAhki74X5NSedueJkUcG+i0PkO+k
HKbyUNOGX1dCMQ6Lg4bHB0mTjLG04jjVw1hJ5m1YlGr0nZYc70o6SSuSVfBwvdpY
uzBf7sH1HCVcLEw9OF8+GwXG/igqLjrGl2FbFJm7CR60Q/iAbBsM6/mBFQ2a901f
uI54EhrGTaUODyKzOL9mpB6hUYVLqxTj6lYJQ6QLaaBTI8nKe7ZkQirjMEwkrbuE
4jFjhjkmmYEbcbvVbt4Uc26nXyF0JvAsq1ujlngECrDTnyjMYJQjMRyWe7dmKZ7M
YU3F3qXxvS/SVaVeHSmlJN0ath2YlDymSpgIDwhGqTaBeGWmXJc=
=/DiA
-----END PGP SIGNATURE-----

--48R44SfAXCXyY/dp--

Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752151C6B0
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 08:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KR1hJwdL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qMMa5zhB"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAE4B8
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 01:00:20 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id BBB913200A13
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 04:00:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 26 Oct 2023 04:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698307219; x=1698393619; bh=9Y
	RxLSlcTgN+nhEkpBVuC+J5zbIdi7doC2MHWgQ5A+U=; b=KR1hJwdLEwx09aWJ3i
	km7VxhseP20D+RuxNGdjAimR+MLcbHGAyhCxoW6IB+Lkly4Te3knsx2N8X76AnAV
	RSS9t88bwrV/YGALhWNzfztEfnPXXF/4jAIgQqE1YECMtaHDKmg0gMihAW8gHXAC
	M0XePEm9PmGKqfKzCHmUvD289R+3INUizalT4B+SZvUeHN5/QwEGuPYYyWDpSBLl
	vPb6fk3JCFU0Qgv3AF/w8hPpE0HTXLG0E5m9bFjxF4BuBYleyHgtK/bm87gyllzj
	8FFYbMSVbeQNUQ/60aWKPRz1j1mAIYwIzIWN3DcYAAp4oJ9/RR2fCgEMF26hX2JP
	NOxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698307219; x=1698393619; bh=9YRxLSlcTgN+n
	hEkpBVuC+J5zbIdi7doC2MHWgQ5A+U=; b=qMMa5zhB+ZZmgsVdCmtf4fDeS0yzX
	yLeq2w+KiRBz2m4ndFbPZ9bpLS1S3lsuIXi7kM2uTpggk/F3JOcS19tp+d/mn0PM
	XbWGsbsWcYNkWzX9S+PvF1mrJOIAml86ENF4poD2kc+a1C5bvakhgCAE4DaYTudf
	YOe6d05f5SszOnKVsqHxVJz+Q/SBA+0tpMJPHbmoHarhGV3QO2FF17W/OMuw+J1x
	SPeWtFjdyLRBiMGLonnNwQIzwaT/Z4LYbZHPdgLDaRTgLIpr3vLPn7DcdtYguGeB
	SmoFrB719SGY19WcOFi++vAypv0rRi6lYcZLRwIbYZcWnwlI3FA3TvSQw==
X-ME-Sender: <xms:kxw6ZTD_gJjfZSeb9mYxDEdm8poA2-xriwY4fq8A0MkdcLO4nK8CKg>
    <xme:kxw6ZZjjZ_wTrA1TiaLr2Te-_A-WqTUKBuGcwKlgtOy4rJ6k2W1iDMQiKG6fPPLfg
    lxlBMhoQCHi3mM9lQ>
X-ME-Received: <xmr:kxw6ZenPNmZYXg4NBPLM1ebOyqSqhHjZ3loNL62JrAh0RvUbCrC6_1RxGtvbkU-U221N01FUZknMOewtSvqSulCnewh4Laq2yjtny7UF1NBP-JY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledugdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:kxw6ZVxI0cFQOpyDXwVnhD6YnDTWvYMl7_vYaAhS7siFmLRaCxIGaQ>
    <xmx:kxw6ZYQ7MkaDtxKIDWxaEoABYIFEFGwn1oXCivh8VWa1Am62RR7MLA>
    <xmx:kxw6ZYaLctu31GFrY4Yy_yH12yJ4_jI6-Rn02MNVbjdXI7wK2mqLbg>
    <xmx:kxw6ZXPxe8zQtvLTE1wmHndRqsDw4Zd_R-aFK5gV-tHqKFYoUBtU5w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 26 Oct 2023 04:00:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0755e1b2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 26 Oct 2023 08:00:09 +0000 (UTC)
Date: Thu, 26 Oct 2023 10:00:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 4/5] ci: split out logic to set up failed test artifacts
Message-ID: <4a864a1d174f7d4d36202a375302d450fbe9f2a3.1698305961.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xQJewRLN8gdfCtuw"
Content-Disposition: inline
In-Reply-To: <cover.1698305961.git.ps@pks.im>


--xQJewRLN8gdfCtuw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We have some logic in place to create a directory with the output from
failed tests, which will then subsequently be uploaded as CI artifact.
We're about to add support for GitLab CI, which will want to reuse the
logic.

Split the logic into a separate function so that it is reusable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 957fd152d9c..33005854520 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -137,6 +137,27 @@ handle_failed_tests () {
 	return 1
 }
=20
+create_failed_test_artifacts () {
+	mkdir -p t/failed-test-artifacts
+
+	for test_exit in t/test-results/*.exit
+	do
+		test 0 !=3D "$(cat "$test_exit")" || continue
+
+		test_name=3D"${test_exit%.exit}"
+		test_name=3D"${test_name##*/}"
+		printf "\\e[33m\\e[1m=3D=3D=3D Failed test: ${test_name} =3D=3D=3D\\e[m\=
\n"
+		echo "The full logs are in the 'print test failures' step below."
+		echo "See also the 'failed-tests-*' artifacts attached to this run."
+		cat "t/test-results/$test_name.markup"
+
+		trash_dir=3D"t/trash directory.$test_name"
+		cp "t/test-results/$test_name.out" t/failed-test-artifacts/
+		tar czf t/failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
+	done
+	return 1
+}
+
 # GitHub Action doesn't set TERM, which is required by tput
 export TERM=3D${TERM:-dumb}
=20
@@ -177,25 +198,8 @@ then
 	CC=3D"${CC_PACKAGE:-${CC:-gcc}}"
 	DONT_SKIP_TAGS=3Dt
 	handle_failed_tests () {
-		mkdir -p t/failed-test-artifacts
 		echo "FAILED_TEST_ARTIFACTS=3Dt/failed-test-artifacts" >>$GITHUB_ENV
-
-		for test_exit in t/test-results/*.exit
-		do
-			test 0 !=3D "$(cat "$test_exit")" || continue
-
-			test_name=3D"${test_exit%.exit}"
-			test_name=3D"${test_name##*/}"
-			printf "\\e[33m\\e[1m=3D=3D=3D Failed test: ${test_name} =3D=3D=3D\\e[m=
\\n"
-			echo "The full logs are in the 'print test failures' step below."
-			echo "See also the 'failed-tests-*' artifacts attached to this run."
-			cat "t/test-results/$test_name.markup"
-
-			trash_dir=3D"t/trash directory.$test_name"
-			cp "t/test-results/$test_name.out" t/failed-test-artifacts/
-			tar czf t/failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
-		done
-		return 1
+		create_failed_test_artifacts
 	}
=20
 	cache_dir=3D"$HOME/none"
--=20
2.42.0


--xQJewRLN8gdfCtuw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU6HI8ACgkQVbJhu7ck
PpTBZw//bApv712v65gtY6PqyeAYjgHUs+4hGpHP9+EsMqFUQU4qVkrynWu1W6HZ
ulUSfrdrhx4Y0so5wxuGVDQESCIvVz/np1tXQJf06oy8UNCmQIu+6nni0mg83lMt
xKbffhv2y2QlLke3vg+Ia/CQUW8SX5dQ+iITOzGgri249IoVM9K9VUyXJklmyVOq
pTXlb8jbKaGDbHqcNjiw3a1sm5p/eSDhFmHFFiBOvAFr0dG6xci0MTEXo8z6GLUY
zlWulLQRUvbZC1iZeho5yn93OLW7bkn9oi9+sHLnoh7r0Sle3aTeyzi496Pwq/WC
JdSGqFUz+EkIl6X5hsvakXyD9DoVLMY+hUuTtlxZirosP+LFxtDXCZJMvzna04r+
QXFBRCBAFH1JYN9sE5WYASFsWs4onUbD/+yedt8Jnz6Ke5jNWjm9ZH1W1VIrGyH1
qN4VdFDumyruPz/H407yQgPtUwyiqHloE9+FoBcY9fEgb99wNx6Z3mkROjLDvM7b
ly17700Ys4/D+DppXkulv07FTdvE3E3F9K2C6VfFnVwNClTKYsxb48Q0V6fjsc2w
FVwPm98Wj8Kfw0Ul1HCPHjPK/8W0d1w7PVgWOWLtviRh5GTAxhqSs63VembYsu3B
o24SkxzIN89NvXq58WuszMU8U5D+O9fJUHVlFIMe/kZ5MtU9HlM=
=LfzV
-----END PGP SIGNATURE-----

--xQJewRLN8gdfCtuw--

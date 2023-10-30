Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9171415EAA
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 12:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZNl+Uooq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NkEBlrmC"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A82C9
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 05:15:01 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 58AA03200944;
	Mon, 30 Oct 2023 08:15:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 30 Oct 2023 08:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698668099; x=1698754499; bh=Ed
	zvlZ7v+/E6saB3Tsm6WxxNGDfx0V1FcydChnHKS3s=; b=ZNl+UooqyqqKvp50xs
	jgbPPGjgnQdIsYWDKGWpYScETZ7KXSHtB+cRQvaW1ppuKHT+rSVzjfUB+4b6wNxj
	wMPF0OBZWkVSXVxofnjs4mUYeeg46Bns18Wp1qSH/5cVAcHMK5P+h6m7rNoqVuac
	LKs4aU1B5nNccNSaaQFeepeSyEpvETxNUrHW+VK4Me5NuS25PUsX2nGCYihrsT3u
	Xh9h+HAZxWzxLxMpQAm5XAdjDpT04qhYS8bxueHtkLP+vGmz4TmJQE8kwgbuEZo8
	FIe39DSptZUUIDwOZWozUxjrdUoQH7AozHs4QbYPprbjzP44vqU/frzTZr8R03UE
	nfng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698668099; x=1698754499; bh=EdzvlZ7v+/E6s
	aB3Tsm6WxxNGDfx0V1FcydChnHKS3s=; b=NkEBlrmCdTUCIKF0cXJWnqnCqn54/
	fW3OGAFCuboisrC/4kLGCbEGgGTXgPv/txtib3fFcHF9eXF72V/j4h6SR8qk2CiO
	uJHFAQek7ny6/RWva0sp47bxs4JNieIYDJMUTHf/O3vx87HS/VyxQlys5hXRwyO8
	LIHEd5IoKoRbPwg2sst1M/Ur3xkqKbUweR1E8SBBtfTmhxmL1G0sKY2tw5mfa5Kb
	HdQuKOE0fvT2p1mAbA7Ebh5TKDuWHHAsxMFtdmLZfdI94nUxqCpUmNKYqsnhrZag
	VanfvxojFzt0XI/q4xvzggF9gV36lzS0EaeL8WoxGkOggdSsnBiy/hlvg==
X-ME-Sender: <xms:Q54_ZbTuA2LzntV41nEbSPSObEw35iQ2i6LUdl-P-LPfmvO4LlA92A>
    <xme:Q54_Zcx2CLI7OjLWObd456ZSkuJmaTj8fiB-v2OLntaZWcDU8lKOjusrSnkRR9_g-
    mMGTUa8JOXkrb2igA>
X-ME-Received: <xmr:Q54_ZQ01xsutpufB0TlTXNo4aPur1IEmuz3PShOQPe5WlhNrXcuonu7isW-D23PTPvGsaM3gM2rd-hJkMlVCWbHoLvysusyI8l2MIZU22uLZxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddttddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Q54_ZbCw7UkJEbRs2I3h5U2qP2W4boikqoKGGUIN0_WgqvJ8jf7VxA>
    <xmx:Q54_ZUgfdsXILIGImApQ1KcA0IsONhVWFsP8-0K1LymlXoaDOSEfVw>
    <xmx:Q54_ZfqdrPpYqCuDEJTnRVfRx5rnXR4jFJP0KyVwsdtbueaUEyYU-w>
    <xmx:Q54_ZXvN2strs6aTDmNEFQ2dQcmykVUK6ufo3jKMQb2RzJaCSjjmeQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Oct 2023 08:14:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 137b1bda (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Oct 2023 12:14:53 +0000 (UTC)
Date: Mon, 30 Oct 2023 13:14:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH v3 4/8] ci: split out logic to set up failed test artifacts
Message-ID: <5fdda7fd83f21422fb47ee86ae5372357cc4d846.1698667545.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698667545.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dZ58ZcyfTQSJXs8C"
Content-Disposition: inline
In-Reply-To: <cover.1698667545.git.ps@pks.im>


--dZ58ZcyfTQSJXs8C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We have some logic in place to create a directory with the output from
failed tests, which will then subsequently be uploaded as CI artifacts.
We're about to add support for GitLab CI, which will want to reuse the
logic.

Split the logic into a separate function so that it is reusable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index b3411afae8e..9ffdf743903 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -131,6 +131,27 @@ handle_failed_tests () {
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
@@ -171,25 +192,8 @@ then
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


--dZ58ZcyfTQSJXs8C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU/nkAACgkQVbJhu7ck
PpTMVQ//aLawq0hcGq/0XLWhxG5IThNAL6cEXVINPpVMXaA+FI+D2O4uizNsPLzZ
CaVjrkYHSuHmkmZiwMtV2Crk/5k46mYfUl2OWWH+LtP5V9JE6zKUzMjINk27ftNj
Tg8c1bxTxLpwQajxNC+jgelcmLfY/YCflgPLH9Zk1eM3vE2sM5SIIqq6Z3M+q3Di
X9AamHgthFw2Mu4VWBXhPklHNZeo9hx3cY2Al1ATYFp8rEmf7rsVpIfg7rwCngiN
4UaEipEiW77cvWHRhchDKr1LxjM80n90Z3JJPf02VlE/WGHCZQfxvxROGEnOJjRX
xmMo5Vy0jmzN1ZkRL4ZcASp0zBw/Ck5Bz8C/FtiDW2PMyeht3+NjNh8HQ7Ah0I7s
11ql+9e44QVRb9i4mOTwvBgZLxNa2PUg24Hmvg0DzvE1dutizvYDUwoP0jAbVvwA
v7BwEZtoSfGSb3po1VqkKXS1mqGZPNA0unwWTW+fFvHlkVHZPQoEDSO51M5dYSem
+vZvFq4cHfi9xhTqRYGMWVIwCjSNycBU0mEeH5erbqcLWtw9h7XlLDgTrF/cUczk
jPhtikLNG8Yc7CnV7mlmfFgOrGMc5OvtbSpodIImXrACNM/rnBkFsEzhD0lAgj9v
PbAeTmmhPB8GHS5cxIveq438pyO+yOPiYqmDydfGhZ6c/+EOf+k=
=zYsw
-----END PGP SIGNATURE-----

--dZ58ZcyfTQSJXs8C--

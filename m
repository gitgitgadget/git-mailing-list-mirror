Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7691715AF7
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b8pZHRwQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vbHtm7ZB"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD370D9
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 02:25:39 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 5624D5C0209;
	Fri, 27 Oct 2023 05:25:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 27 Oct 2023 05:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698398739; x=1698485139; bh=yF
	189vQiQbhKy02SuiENYwSx6jNPz/cGy12tty9zSyo=; b=b8pZHRwQsvIcgsQ6Ty
	dv/p8R1wWptrqQkT8/1SxLysQRoD7w2WsC45o+RVgRN+ZpbeK8Pfuj/OqibqBoLH
	zR7D/haYM1WJD30USDMHuL9ZVDPy4aNsJI1YdenvbagowWJX1U2gpk6db596bUE8
	AYVLeCmmd/XFcdl9xgncstiTk8IxDSa6FJzef+XDuaxQ13+u1VBPldQtea702Unw
	M3vAdVvAAaPaeY/2TiPrxp9Cyu8pXCrEUyGSInqMDvJvN70uUJR1J+9WH6S6R3Bd
	Q1RUlemazZO98tUwKN0EBMpHxvPwR5oNwn+Gs929CimToB7bHFSS/FiMbpE53PHe
	lz+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698398739; x=1698485139; bh=yF189vQiQbhKy
	02SuiENYwSx6jNPz/cGy12tty9zSyo=; b=vbHtm7ZBpgnR3VctGg5mi6MknHzmq
	iZXNxNehlYq2WIrofyLmMTcTrlGPhg8h8QbL20J13xSonf6ljYteNM705H6TL1FO
	vS5CmVpPSTfLDzlwCghAX/Dyl3iGBA7leb9SIW5XkwnSPmh/uNXCFOb0lOPAXTw+
	H5/psvuvY/OgTJgmwUsIFbrH7LvmvZVMQZ6t7F2sBbSNHhxtLSDwiX68xpLV/kzs
	yBDVPazpvQi5BrQDDiGlE0foqOUg6SZEVagnVI4a0PkIdyHAUKj9WMgAHghZTKcm
	tEsl+KhDO4D67JmRY7EBw5NfOlbPuSypKqq1mW8/YWUn80desfHn4RswA==
X-ME-Sender: <xms:E4I7ZSnoG3y3FPE7sfZCx5tB0fG58ZUj2lS9ou70QDdVTd_xiLdjZQ>
    <xme:E4I7ZZ3LOMaDqFcDUujFkwpPU5JCkhjgiheysrqlreS0hF7MtYFgYhM7ufYtjRebr
    MQas5FlTgqkoGdY4Q>
X-ME-Received: <xmr:E4I7ZQoYOj_Keu5Yag-hCc73NtEw7PaDbjh-q-zv2eXtgL5rGYh_Nhog8HQiOruiOibrGXTS7bHbvyqiazXaRA-iXAFuOZ1GDSrZhoOo8w5l2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeggdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:E4I7ZWmkcDeudIsp1zmgeuYG80oTJNYj5-diBk8Jt-2VQFtULgmI0Q>
    <xmx:E4I7ZQ0bvKm1wpJooIzes2eKzlF2IpKVGd8LfkDBCzd1EPKBgp9I2g>
    <xmx:E4I7ZdvOR_xtmfTojbptRd4BWD_6JQFg0oZ3gLZdWHzSN2rft4DDeA>
    <xmx:E4I7ZV9sKhNYtkMGKH1R-8Q-a7_jD9pjJcMdD2cAtJlf4gUIydyn6g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 05:25:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d5c9df19 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Oct 2023 09:25:27 +0000 (UTC)
Date: Fri, 27 Oct 2023 11:25:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH v2 4/5] ci: split out logic to set up failed test artifacts
Message-ID: <5ab11d5236d496c9100f54d7eb968b4b9f74fb25.1698398590.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698398590.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WEV0Txm1xF3WgyqV"
Content-Disposition: inline
In-Reply-To: <cover.1698398590.git.ps@pks.im>


--WEV0Txm1xF3WgyqV
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


--WEV0Txm1xF3WgyqV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU7gg8ACgkQVbJhu7ck
PpTG/Q//dl0350codvkzCmyWm5uNFsm4rVlZBAC5QziSVP92lg2jmrvDzjrund4H
YBCOeTjQxiAIEj8nvGffO0LENAgVSp1yeUB6imTyvyuJPLdwNpn4dsBKLUHQ1/Is
cKz4rEctF2S0FoC52EUhGfQCE43USNprCbfuYG878HjcRDSFpf+l6gJM82lWEvvL
WFSLylWPGk/KMDg9O5NuSled8R1yuq/XTERVFgphiQrxJQX1dtKisKOMkPziK+t4
d1CXEMl9ELV3l4AE2BHgsFR96YJLwacxHquzxGNlgnzmB9mpTBH4OmnZHUDD5UpP
CXNn+jXh1KIpxotZ3zRSHqJEU3Jz/MA1fb0GWvDI1TyPb2U6TKGA4oNshEc74/6L
AumimF6MeD9SO+pYiqljdrnJ/wakntfWWhWvMUOi5PJ5FPY4bBMNyxNca8ffJXwr
9G/rJ/CbeqMYD1K+CqxB/d/NDvcTeKOif+0K5OIqUPxiNisqMjiFGVVNpzl0NzIa
VAOiKzovCfqXaNsoPwfGkwWwzuzBZer/fxazbLlExbXABLJsigI60Yh42cDSGeh3
JmXsC/MwJogzFQ85KYlHqAX74ykAzPVZVkI6S/o1iiFLUF5yoeSNrgU8uO/lizAT
ZYXJ9KsS79UwDc72oUYAdicW8TBF5QBuFo6Ef4UjxaLs2OC4oj0=
=0pzG
-----END PGP SIGNATURE-----

--WEV0Txm1xF3WgyqV--

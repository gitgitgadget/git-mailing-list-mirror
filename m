Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uLnJhr71";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hRtSAQpj"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A10719B9
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 23:25:09 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id A37425C0207
	for <git@vger.kernel.org>; Wed, 29 Nov 2023 02:25:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 29 Nov 2023 02:25:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701242708; x=1701329108; bh=kM
	jHqLZsKZxr51e05oQ5AoedGlLN86blNcbquA8Nx44=; b=uLnJhr71CHstw8G9RF
	MLjwdk7QhjSWhLIvKmIDmYLzabdOLJLMFQ67F+DBNyjGfB2+eBD4q4pceGqqqYni
	xZwySb1oP9pls7MoBJbB5emcMdSGGjYrfRtVHEaq4LJ77XhvHUw66ifD0GyaiaGE
	vPQ+eS67KXnJoxoWD16RDbrfvSH4Sk8bb1U+SlttsBsP7BectvHekH3Mw9+KaHXo
	W4dsg7JiloGouGvloDWTgnZV+DxajHbZo91hLMP001BIKKMMvPuyNDX1zF+gme3h
	hkpRwUJOEfuRV8EPowkbOCwGC42CGqRMyxwEdaHH2nc2xcPQy4ult/5MMI8ar2Qi
	Du+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701242708; x=1701329108; bh=kMjHqLZsKZxr5
	1e05oQ5AoedGlLN86blNcbquA8Nx44=; b=hRtSAQpjd9Uj/TC8srduwD3akPjLf
	/erteuI4aN+GlN2uCq/YJRfuTKamCdaDyuGJor/pVYDDRt3Yes1opvRx5HQOzHAv
	bkMXhvWH3r854YVkHpnd8L8OEbektH0/P34D9sCSh6SZ4OqJO5JaLUPnRvGnqCST
	9DkN+LkrmKWVvshEd2tdxJOu7XtTrAthQ/9PidDhOXJOCgT3OFiLFThaeK6PGatr
	WR212sh9atZae2n3WWYRNsX1VmEbI2mUx7AYX0I9L8Z4ReSN9XL8ZSEcMJlConnn
	cINxvLUXHjGc3JEBihZEmKEcdnVKLKEBcol961Cb4Vutxy9c7nAH2hDug==
X-ME-Sender: <xms:VOdmZXwqnjN2rQZNGgzxEZ9KwdKjZkIlDZgKiyceylb_qWJ--4cVmA>
    <xme:VOdmZfSayQ7zyLKe5ZShznkaN8HE7JgCraWC_ZJxhpwCqx9puCYzYFffKqvdOQdi-
    NF7w8EA63prFAGAEQ>
X-ME-Received: <xmr:VOdmZRWKXtW8XWjeSepSv_Y5KnGLVTglAq22ZUgUVy7NX70egoNUusfYp11cKacaVia1bajSxoctpFSRzoBgrzdemRJ4R4kbhAfMhatlhMfSwP9U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeigedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:VOdmZRgVj4_jrbTEI9McatOu5-ODKESZJ-sFQguGLGKA-t8_9QhDrg>
    <xmx:VOdmZZBPQysCGCXytrsqyr5uuQ8YVAgYLEpc777BLDtz0ZoMQ5KnSw>
    <xmx:VOdmZaLcyp73M_mrvHxggh424lAx3lHgjrDmkKiy6dsBpJkjMNxuKA>
    <xmx:VOdmZU-4QoBVyDauaD9422V7WjlPxciO9JBzg-529heLJ9yBowb0wg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 29 Nov 2023 02:25:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f0566d6d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 29 Nov 2023 07:23:57 +0000 (UTC)
Date: Wed, 29 Nov 2023 08:25:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 07/10] t4013: simplify magic parsing and drop "failure"
Message-ID: <3b16c2cd7bd66c0eb56d33a6b91914500a1c24dd.1701242407.git.ps@pks.im>
References: <cover.1701242407.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3MwJ7QK2+Q6h+MG5"
Content-Disposition: inline
In-Reply-To: <cover.1701242407.git.ps@pks.im>


--3MwJ7QK2+Q6h+MG5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In t14013, we have various different tests that verify whether certain
diffs are generated as expected. As much of the logic is the same across
many of the tests we some common code in there that generates the actual
test cases for us.

As some diffs are more special than others depending on the command line
parameters passed to git-diff(1), these tests need to adapt behaviour to
the specific test case sometimes. This is done via colon-prefixed magic
commands, of which we currently know "failure" and "noellipses". The
logic to parse this magic is a bit convoluted though and hard to grasp,
also due to the rather unnecessary nesting.

Un-nest the cases so that it becomes a bit more straightfoward. The
logic is further simplified by removing support for the "failure" magic,
which is not actually used anymore.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t4013-diff-various.sh | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 5cc17c2e0d..76b8619e2e 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -178,32 +178,29 @@ process_diffs () {
 V=3D$(git version | sed -e 's/^git version //' -e 's/\./\\./g')
 while read magic cmd
 do
-	status=3Dsuccess
 	case "$magic" in
 	'' | '#'*)
 		continue ;;
-	:*)
-		magic=3D${magic#:}
+	:noellipses)
+		magic=3Dnoellipses
 		label=3D"$magic-$cmd"
-		case "$magic" in
-		noellipses) ;;
-		failure)
-			status=3Dfailure
-			magic=3D
-			label=3D"$cmd" ;;
-		*)
-			BUG "unknown magic $magic" ;;
-		esac ;;
+		;;
+	:*)
+		BUG "unknown magic $magic"
+		;;
 	*)
-		cmd=3D"$magic $cmd" magic=3D
-		label=3D"$cmd" ;;
+		cmd=3D"$magic $cmd"
+		magic=3D
+		label=3D"$cmd"
+		;;
 	esac
+
 	test=3D$(echo "$label" | sed -e 's|[/ ][/ ]*|_|g')
 	pfx=3D$(printf "%04d" $test_count)
 	expect=3D"$TEST_DIRECTORY/t4013/diff.$test"
 	actual=3D"$pfx-diff.$test"
=20
-	test_expect_$status "git $cmd # magic is ${magic:-(not used)}" '
+	test_expect_success "git $cmd # magic is ${magic:-(not used)}" '
 		{
 			echo "$ git $cmd"
 			case "$magic" in
--=20
2.43.0


--3MwJ7QK2+Q6h+MG5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVm51EACgkQVbJhu7ck
PpSSuw//RD4I0szP647mpTDOcwTkgOiKEjqj3tS5OQFz0V2vBpyBnBo/MJ4bn67l
WjRFz2TWM1obvzPjWiNnrI75zJEk0brhdxWv2R0qx5LNDMvyUSgO9ai8i8EG00f0
FmvgFAkHm6M1C9lHGs4QaRr1vuiMKCUalRy2a9oyAKtS7NvgaVjxDplHJzxY2XBx
jH5LFjDZNEhjkwTU4LlEcgYfoxiSSit9xLxu/whIKjcTHm59dfGV5x5LylkcqBNR
7zc/nWuOKawhfM1rg+synJaJp+6cY4ZKUA4Fa+1yRcVQ+RUNCTvbvrjhZORAcxC2
1owytDhbGE59cgij0Ws9GNjWGSbYkl4KtMKB5rNTm91ZsqrQMAjMIgGrkHdHA+hy
TNRU1+KLy/+ONU2OpVJdvoY3a1h1qfzExe4QZS53cc4Y7mxyi23B66CCbC4kTRct
q+pfC+vkQornvpvohXqGJOBdpAQjvF5TJnBTG8S5E/lczvOSRiPz1HIeOmoAdMu0
ar55AJUWIF/hsQtD9oeTbmSo4xI2W/XJj3oIKqL1GCCQT5zR4C2SNrShiA56CMX9
BslrQlTJpHKJ3MDPPXYFf17QJe0NKsGt2Fi6czB3FFB2jb/YAQoXkjqiW86AQDgW
5h1idAg7gAs/FDG8Jwtq6y9DU2WTJMvDwrtCOna+MiMfXkK1I4Y=
=QWwg
-----END PGP SIGNATURE-----

--3MwJ7QK2+Q6h+MG5--

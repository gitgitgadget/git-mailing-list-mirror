Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E4E134D5
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 10:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MJ7I5jME";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JMKNhIfM"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA6326306
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 02:01:25 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id D666632009A4;
	Fri, 10 Nov 2023 05:01:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 10 Nov 2023 05:01:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699610482; x=1699696882; bh=tU
	Gb48h9yIi0W+VG60IKRomj8PiRbCKVhwKoWk7G+OM=; b=MJ7I5jMEIG85FsgtO7
	yFSmsOFf11fTpc009tLDKUCESYPe4IaXgR+ce1gmEzBEaa+JxJo6OGG+z5Y8beBo
	JE/t5cvi0jyz9lMIr58orYwrtD6YP9t1cxw7KUOq/LA20nZbbbGYcuiOjuI3i++e
	CrjTPfwLyPyps4hnkJXDfEKwAo/s5N3XBg0Bs8IWL04PZpr0bo+qL2LSwMYSbzYd
	bbO1p32NtE3IfBwn9REGaNMK5L9+mtWEBEtHaNlVS6FiqZrTnC3JxfNsiqNc28al
	ESZe3BZSZb2iDaLg/Smyo4CHvYgyMmzb88ZHBB/pWMQ8asRsNev6S+SU/aPvkeNY
	sF5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699610482; x=1699696882; bh=tUGb48h9yIi0W
	+VG60IKRomj8PiRbCKVhwKoWk7G+OM=; b=JMKNhIfMxrC6PHMGqxt4mlhbr6D//
	YW989q/wdnO/ckwa715a3K4uE3UKrSy/ZIXXrJf+1aF0N+x8IK/tgdagZPT39wg7
	cE+FLTbf936PYDp89oLdf1kRdIqjGwIfjox/I+llTOMkjd5vKgZnQcTu4KoFZV8g
	kyzc3bJYlcziYZF1XS280s9aB8A+BE1J1XTMUIc2Re4PahYwGTBSFKDjygYMMvF7
	B4UWMmOw8cO1JtE9yEhIJIHC9FQnCNiUGTRzBL22f5ZTtYkXHDuirho48KOeN0zW
	uioetEVJ5U8dEAtbverRaJ//2fg7TvOUysNhA7s6Rhs6Gm1EryNSTy/PA==
X-ME-Sender: <xms:cv9NZS5tKEodm6HgCFhLmpvW_9_80kLdWHw2O_r3tHeKJSL0vnZihw>
    <xme:cv9NZb7sq7fx3yBZCPIUFKaOr_WPgCySS0BkNXVrXm2RBaJoxyDi96LRodQimaVGg
    tq_7mOOm06XJvECGA>
X-ME-Received: <xmr:cv9NZRfZbqVjjMEbS6wHmRRh0mETZkZ0TV7ubC520MHLaOpWNZma3GPiBVPfJwo4j5KdMHdy8oyxGcYqtXLvMzD_ffVPvcwSogsPgbLFbghQjUkR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvfedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:cv9NZfKEVF8bsAPgcSQsRCwrVzrT0Z2MsttCPXN4CZkqUdNioDw4jw>
    <xmx:cv9NZWLLyS3BdjGNcU-UK0N1TZ7h_gCVyxejMIJGfS_7Fujn2RQ3Ow>
    <xmx:cv9NZQxB5MYddumfC0R9iBmf3JjakFw4fn1yJwDtjRl1EQH0RokZnQ>
    <xmx:cv9NZYh8yGgxoLlNFsUMXR6v5ejYQAuPA_RKejiiQ9qn1lGOM3MHTA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Nov 2023 05:01:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id db5b6e71 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Nov 2023 10:00:52 +0000 (UTC)
Date: Fri, 10 Nov 2023 11:01:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/4] contrib/subtree: stop using `-o` to test for number
 of args
Message-ID: <977132d22366423fc0bc32af38ed027be3b1ba2c.1699609940.git.ps@pks.im>
References: <cover.1699526999.git.ps@pks.im>
 <cover.1699609940.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RH/RMbJ7tADcdca9"
Content-Disposition: inline
In-Reply-To: <cover.1699609940.git.ps@pks.im>


--RH/RMbJ7tADcdca9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Functions in git-subtree.sh all assert that they are being passed the
correct number of arguments. In cases where we accept a variable number
of arguments we assert this via a single call to `test` with `-o`, which
is discouraged by our coding guidelines.

Convert these cases to stop doing so. This requires us to decompose
assertions of the style `assert test $# =3D 2 -o $# =3D 3` into two calls
because we have no easy way to logically chain statements passed to the
assert function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/subtree/git-subtree.sh | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 43b5fec7320..8af0a81ba3f 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -373,7 +373,8 @@ try_remove_previous () {
=20
 # Usage: process_subtree_split_trailer SPLIT_HASH MAIN_HASH [REPOSITORY]
 process_subtree_split_trailer () {
-	assert test $# =3D 2 -o $# =3D 3
+	assert test $# -ge 2
+	assert test $# -le 3
 	b=3D"$1"
 	sq=3D"$2"
 	repository=3D""
@@ -402,7 +403,8 @@ process_subtree_split_trailer () {
=20
 # Usage: find_latest_squash DIR [REPOSITORY]
 find_latest_squash () {
-	assert test $# =3D 1 -o $# =3D 2
+	assert test $# -ge 1
+	assert test $# -le 2
 	dir=3D"$1"
 	repository=3D""
 	if test "$#" =3D 2
@@ -455,7 +457,8 @@ find_latest_squash () {
=20
 # Usage: find_existing_splits DIR REV [REPOSITORY]
 find_existing_splits () {
-	assert test $# =3D 2 -o $# =3D 3
+	assert test $# -ge 2
+	assert test $# -le 3
 	debug "Looking for prior splits..."
 	local indent=3D$(($indent + 1))
=20
@@ -916,7 +919,7 @@ cmd_split () {
 	if test $# -eq 0
 	then
 		rev=3D$(git rev-parse HEAD)
-	elif test $# -eq 1 -o $# -eq 2
+	elif test $# -eq 1 || test $# -eq 2
 	then
 		rev=3D$(git rev-parse -q --verify "$1^{commit}") ||
 			die "fatal: '$1' does not refer to a commit"
@@ -1006,8 +1009,11 @@ cmd_split () {
=20
 # Usage: cmd_merge REV [REPOSITORY]
 cmd_merge () {
-	test $# -eq 1 -o $# -eq 2 ||
+	if test $# -lt 1 || test $# -gt 2
+	then
 		die "fatal: you must provide exactly one revision, and optionally a repo=
sitory. Got: '$*'"
+	fi
+
 	rev=3D$(git rev-parse -q --verify "$1^{commit}") ||
 		die "fatal: '$1' does not refer to a commit"
 	repository=3D""
--=20
2.42.0


--RH/RMbJ7tADcdca9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVN/24ACgkQVbJhu7ck
PpSqEA/+O6umvVVc50EIe6F4rtqcR1o0Mjt/r+3xyEtA8x/mudaFhpK8BPKQgGXQ
HwLIFCezV/d1TESvSpqX5z8d8pXO2noRvP7AwHuAGbb8Yd5igWSmUAmPmyQzdIIO
v8WWTjf1TKPOYruQ+JtbJSF0GwxkfbtF2E1NuYmox87n+7Bu/MxJx2v/+DFcjuwX
DtPQDjZujHSSjHH2pP7SRPfYgMSHh7Nm/elFoocn7IJyrImf7w/4BL9QNybfaVBE
5A+Gpp9fGrKw+C3V+6q6YBAB8kkdjnCM12s3p7imGVnheYfwfw3oD5VpddJYmUXH
IIWF+35JrneLD34Jf3BwrQP3vW/9NkaUwnt9fiuNz5rI5Tnz4gsJLYXX9WSOjdFd
lZi7U+/r9RiaJgJNznroahXss1NMPouWYzUA+Apl2J+xvi9jPQxUvxlOat4p/HZE
kGU5s5rOlFxOo+g4uaoM8hrchpAh3xttX3h7liemLlxNk7oAK6E0t4IqFPVp+6ZJ
4bFJyqgaREOEM8tctpD3NuD2JI+PGrsefqb6xwz45rpdBju7RrE6Yp0ye01NZU9P
+Mssmg25yDRheRZIAbidKma4yd74E3O24/+ToqQp74pJkrr5jX6ptxKsCXVY6d4k
N4dFM3K9BerbFD4dDEKTesYKLOmTlt5qhRxsgRBNtKySFkliCmU=
=O2Zy
-----END PGP SIGNATURE-----

--RH/RMbJ7tADcdca9--

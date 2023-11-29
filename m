Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ies01mgT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FWDY72cm"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DA310F0
	for <git@vger.kernel.org>; Wed, 29 Nov 2023 00:14:19 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 0931D5C019A;
	Wed, 29 Nov 2023 03:14:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 29 Nov 2023 03:14:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701245659; x=1701332059; bh=4a
	ozz/LRTywzThS/k6RiZoDjKh/OUqKhbP+LK3WJKto=; b=Ies01mgTzY1XzGMtOQ
	+Bj0buSlNiw0n3HJgZ4HgGTkmvMqi1szfli1/kEeY6FVc+m6sa1IJQOpuq7/4Bu4
	X5LAy9MYPWt//jrsVKEfOD4b1wvIwgwe9VdyLF9u39ObbQhaIQTIVRRNVTJRSDuT
	RGpouqR4+U+38lP+nkreKbp0hliKEGzJcOox67mIVOviTPhf8ujus4O2iWzW5TxB
	pO9IHw1bqEo+ROtQujpWom+R0Cxzw5XMdVKTw0GqLorvnIjBAtVjidCIxlkKZc7B
	75QvhBTs0k9Fx1U9MzVHXJI2u8Dze3u0EzTPiRz22Wtm5siXuokm9eJ8x+TySoRl
	qdZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701245659; x=1701332059; bh=4aozz/LRTywzT
	hS/k6RiZoDjKh/OUqKhbP+LK3WJKto=; b=FWDY72cmKY8ZhAZe2EDc9YynNpBdZ
	U7jfCkanlTZjZRhv6IiCqjK6qLbt1hBi/HskuOvKLLbjYD3ODtTpnG988E+gOLEc
	t9Mc3aHVt+n7DOfIpJ7PyZyx7H2cgEUME5WHw2pmaYtbmOpd+K9aj3UWY8VsJGlJ
	+J4goPB9Lgk7u2SOJS0vLdXvMHEzyNBqYbbYJ5bOPyjXHrfhaa9V/Wz6RfbLvEsu
	F0wOLHfjn/0TMPtUOYGauTENcrvXKrE/oOkbcsaS5XC8gYcG7uNMIO/GNveTAqml
	yqQyhxDAVLeq/NBLGhrUbUPs87wP3TT+ezxBuGWLiF+al69AlFxrEDsXw==
X-ME-Sender: <xms:2vJmZcurfNN7r67yqBW4PNMpnbAZwOsWODM6TtEQ_CKgM4u1wCPFNg>
    <xme:2vJmZZejh79qbWFmj70uLJy_a4Ua8p1_-dFE_aHj1gBPB2vg8bQ9PblMBnwE9leWd
    pAYjYBnIqeYEU9r2A>
X-ME-Received: <xmr:2vJmZXypTiL5YiuXp5V1re4gYGKSunebYKEuXLuxLG0FbiulczpSMOjGTU51faU2Zl6LyC4qAxGEBmCbKyi_KXpv7x8fttWDvwEqBDwSF2FtJwPB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeigedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:2vJmZfP99lJ7PsMoRPehNHPVgIR85QY5TaGFW9UJ_kPEcYVSuw9YhA>
    <xmx:2vJmZc82mk3RiSXLf0P3gHTSCNuAivIOWXfQ0U1sh2UFEMgOX-yeZQ>
    <xmx:2vJmZXXsoSEDu6cLk-JffFybWQ4L4OiBHVPJek2ByTGz3TAexHkEwA>
    <xmx:2_JmZRH6oPIacXewazPL_xvykScP820BPr4UBc6h0pI-qh02KUTN5g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Nov 2023 03:14:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 81325a37 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 Nov 2023 08:13:07 +0000 (UTC)
Date: Wed, 29 Nov 2023 09:14:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: hanwenn@gmail.com
Subject: [PATCH 2/4] refs: propagate errno when reading special refs fails
Message-ID: <691552a17ec587b0c03e758437c33d58767803aa.1701243201.git.ps@pks.im>
References: <cover.1701243201.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D8sIfm2W/0Eb9xqw"
Content-Disposition: inline
In-Reply-To: <cover.1701243201.git.ps@pks.im>


--D8sIfm2W/0Eb9xqw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some refs in Git are more special than others due to reasons explained
in the next commit. These refs are read via `refs_read_special_head()`,
but this function doesn't behave the same as when we try to read a
normal ref. Most importantly, we do not propagate `failure_errno` in the
case where the reference does not exist, which is behaviour that we rely
on in many parts of Git.

Fix this bug by propagating errno when `strbuf_read_file()` fails.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c              | 6 +++++-
 t/t1403-show-ref.sh | 9 +++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index fcae5dddc6..7d4a057f36 100644
--- a/refs.c
+++ b/refs.c
@@ -1806,8 +1806,12 @@ static int refs_read_special_head(struct ref_store *=
ref_store,
 	int result =3D -1;
 	strbuf_addf(&full_path, "%s/%s", ref_store->gitdir, refname);
=20
-	if (strbuf_read_file(&content, full_path.buf, 0) < 0)
+	errno =3D 0;
+
+	if (strbuf_read_file(&content, full_path.buf, 0) < 0) {
+		*failure_errno =3D errno;
 		goto done;
+	}
=20
 	result =3D parse_loose_ref_contents(content.buf, oid, referent, type,
 					  failure_errno);
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index b50ae6fcf1..37af154d27 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -266,4 +266,13 @@ test_expect_success '--exists with directory fails wit=
h generic error' '
 	test_cmp expect err
 '
=20
+test_expect_success '--exists with non-existent special ref' '
+	test_expect_code 2 git show-ref --exists FETCH_HEAD
+'
+
+test_expect_success '--exists with existing special ref' '
+	git rev-parse HEAD >.git/FETCH_HEAD &&
+	git show-ref --exists FETCH_HEAD
+'
+
 test_done
--=20
2.43.0


--D8sIfm2W/0Eb9xqw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVm8tcACgkQVbJhu7ck
PpTq+Q/7BVg5INBWpyumoIdU2zEtbTTjk8VE8WoA9TA5J+waeUuSkA8WnGxLlq5h
WXsMejR/MgpIovAVQFjHAQ8y18AG6p/R/tVc2xsemMjP8Nkc+SDSpPMbh0XC3IHT
+peVNumtlArXTDu2lxdfjPqVzdSROgeh3djuoz5j+OwRb9bjKSfLjgQQ34TMLQ2d
DQdUxFcF8YqXSzH5b5Gv78QohxyfQ6Tk3IwmuafqtXJ5sRd1tsWDIUeHdR9IrmM1
UyCQYpBwG1phOxkF8uPsLrDNqwrHnSXynxEDL05uH9+JYzChLa4RNHdW3ADzyN2b
szC3Zv2L3pw4BIPlbmpYjd4YE+PP99tj1t64q3jczfpgfWXIqulsW5M2KHw2qo7e
AgQTifbftdCDggEZKMT1Bp8d/Tw7Xg7Fa1fKogRGpJMjBrQx2QAzDEvigGmzP2H7
lRPUA/UM1DKhO672CO0sywIiJfELtG7MUcldoqS9Atik0V7VfF4y/PxI4YcWh26g
6uqpHEEGuto3081F0BXH7/8HEIRz/2kXQ1+B1i51+pu3121/ovtKfuB52K9vl8au
5GRVOFe7uKHdwlU7RBkdXLaiwCU7+l1M9b8x7bBK/QkhpfrieVHAIhYZtTsqRnsG
AVpAHHbmWAeozjslA13i1JYSHjZ2XAlVupmgul1RRJHwtl/hbJY=
=drzy
-----END PGP SIGNATURE-----

--D8sIfm2W/0Eb9xqw--

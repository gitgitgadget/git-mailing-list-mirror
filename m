Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ABE199AF
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 10:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Na7iqCUn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QTjR4kJG"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F889D41
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 02:53:43 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id ABF585C031F;
	Thu,  9 Nov 2023 05:53:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 09 Nov 2023 05:53:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699527222; x=1699613622; bh=hb
	prfUsjMxqU4r81HY1SLgu3wF4R+Tm+SjF+3YioTEA=; b=Na7iqCUnmUcNFBsQ50
	ocBKA5XU2rwXBRw0Lk1vc1Y7O6ooxoiX+mgLV3T9OnfFQk+ebSJlv65hpuEht/1f
	lCOmDQZpdJxn79j2+G17o8gq8cXRkQGzDgsiaFdT5BymiA/hk88KxEvyQ8q/cXX3
	BfsstOqzwV7TXuPT/0PsRcNwIjmZ0fhAjSsvJ8kwSa6+P5rJq0zOmk9lSzcui2/x
	6rnvcz5JYsJS/JbYMSe1Dy5gcYJmxo8Mya74QdonTdgywPyNDedrHtgTylARp7tH
	IpAZj3con0AbIJZ2cy0Y1VU3t2VKL6nWgfE7SW4dYwMJc1AwluYHQuRqsmScE+bR
	YuGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699527222; x=1699613622; bh=hbprfUsjMxqU4
	r81HY1SLgu3wF4R+Tm+SjF+3YioTEA=; b=QTjR4kJGUgoMiobAKIM/5K00yQ8lm
	7vZiTi/NZdxvszSwA/Y60vU8GLpZm/eh04ywJ122Jt4GYd30RpP8gyzxNISW1L4j
	OzN07uRyzVBDfdZKQZ3BgEjC8ZyfZPzR+1lWWOW9TR0tgOuPSBgyzaGOCjgK6ADL
	Wy5UhXUjzU18KitVwjIa4maqrGm0NmZUuirs31wlJfmSjKrUyB8ATT+MmwtlhD46
	m0eNO1DU2dJwTbyBlxE/NpGBZX38JGkJ3HUattVZPiFk7+4cXW9o3tFJEmNFUcnh
	Faef5xVZze6B4BoSk3zSJsr72wR4qnOOmuctXnxL4RmjFA+Y1PCHLB+SQ==
X-ME-Sender: <xms:NrpMZTr-f8DWzYpId7FDrpNrs40VDsObWKFPsKZywqEfB-FnPcCLww>
    <xme:NrpMZdp2VeYCAFOo7Q7nolcl0pGGSNG0g3VGdwgPnHMSbyFafLvzalJalH_ZS1k9Y
    dPoqk2GuAjVj_sGtw>
X-ME-Received: <xmr:NrpMZQPPg2-7Nd7i3g7R012y3NWBXm2_cd8XuDcgndPRj-U4V-FsoFNFU0T1cXRCWU_27yp-yBV5106ylmd3kUTbhcgD_Z5XS1gouG3UDrvdU8al>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvuddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:NrpMZW5Cw5xRhwN-4Q906K1YGmCllvhwW0QfmAKQRMeMV52KxJV4sg>
    <xmx:NrpMZS7hfQoBzdoENNVvAuZaChWCtptXXotdWrrIPQ0dX5OodwZ_zQ>
    <xmx:NrpMZejQNovoSAvNYUHAN1pCeC5hc0rxROnmROQhqBc1dhCMCXb1cw>
    <xmx:NrpMZYTtqoJF6eWN3cDCokQYF8kKNiyY3-L0I4gORwMBNSE1tBVXXQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Nov 2023 05:53:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e9d1b987 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Nov 2023 10:53:13 +0000 (UTC)
Date: Thu, 9 Nov 2023 11:53:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] contrib/subtree: convert subtree type check to use case
 statement
Message-ID: <7c54d9070fac15b8f0504251d920d0e1fc1fb1f4.1699526999.git.ps@pks.im>
References: <cover.1699526999.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2oIdYLPgXljZo3uG"
Content-Disposition: inline
In-Reply-To: <cover.1699526999.git.ps@pks.im>


--2oIdYLPgXljZo3uG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `subtree_for_commit ()` helper function asserts that the subtree
identified by its parameters are either a commit or tree. This is done
via the `-o` parameter of test, which is discouraged.

Refactor the code to instead use a switch statement over the type.
Despite being aligned with our coding guidelines, the resulting code is
arguably also easier to read.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/subtree/git-subtree.sh | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 8af0a81ba3f..3028029ac2d 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -641,10 +641,16 @@ subtree_for_commit () {
 	while read mode type tree name
 	do
 		assert test "$name" =3D "$dir"
-		assert test "$type" =3D "tree" -o "$type" =3D "commit"
-		test "$type" =3D "commit" && continue  # ignore submodules
-		echo $tree
-		break
+
+		case "$type" in
+		commit)
+			continue;; # ignore submodules
+		tree)
+			echo $tree
+			break;;
+		*)
+			die "fatal: tree entry is of type ${type}, expected tree or commit";;
+		esac
 	done || exit $?
 }
=20
--=20
2.42.0


--2oIdYLPgXljZo3uG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVMujIACgkQVbJhu7ck
PpQ7BxAAqG1eUm9ZHLDsFf24jWNjFIQFdrvitr1fQ6Y8pgJ+v2Ks+V0jvFt9B9IC
toS2OBGgNawoZX5Ug15QdvKaoCAn/ZNP1oBePk6K5hR6HWJrfPWqZOtd+OpnbeWu
28nt917plb+AO1kxgPi7FE8htC674Ft0yUYwKQSi3BhCwg2YL0AHf8J73ppq3nP7
avbn5Xa+e54uk9bK8D/eH/X7qAxMTPHK81SamkCj2NRSIQDcthk8osdG1xbNS7R6
cUeLnNsAKnh/YqInMNEdikA1Rx9DS96J2JNrKMrGfbKC+Fh//HYS1q6vduTu3PkZ
2fvOH4Wwkd2+wi5q5YEZX+BwsgoQ5dY1x9He5Oyz6ClSLSXhNpKR8dQbtT+7iuI/
CZ9xS4iwiX17jGkwacacM9DHNvA81DQar727j1JedrnTPDRRpHMO3pjSgTTBvUQK
qjeXiaFjjwHEtM9mbCnsBK3Uph4vbmODDe/IhM9ZtNS8vwYBg/sQo4FyEeC9FDSJ
JVNkuXmn7Rr/CBOvSXOC8xACRifRoyeFEoWOrbEXsx2iN0TcLzj3MjQpLfPr+060
vofO5vYyrWP3YUTVhZNvOL2UL3Jpu3zJjr82wa5q3dDlm4KJPKMZvYUhbAk+oevM
R1dlb/P1JXFiyo6K0Z6K7t7JQbs3Qpd8BTKRC/94kRnxoCNsjn4=
=bjli
-----END PGP SIGNATURE-----

--2oIdYLPgXljZo3uG--

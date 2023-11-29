Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bKYjLzqt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ama083t1"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1440BE1
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 23:25:13 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 7AA7D5C01B9
	for <git@vger.kernel.org>; Wed, 29 Nov 2023 02:25:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 29 Nov 2023 02:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701242712; x=1701329112; bh=ST
	9eLU3dEIro+p0zfLW0kvaq9OekSOLgwRm4nuhWibI=; b=bKYjLzqtEL2pXaviqD
	wsBpjCoEA8919jdncM0J1SVCmy00bNuXekxZWaP/4sPtaLCoUILfrt488GwIhkxp
	jo5uBfMBi56HvTVj7D72fqRTkToLdEeo2kMLmekg5BbwFuv5CMKC36k00VWzcT/J
	bmslo5GahLtal/JzcN30u7PcWyrawqg5BuBQz3T0ZT2BfIL96ItJkDZaxti6qGtP
	/40VC4idI75TxEAd8ey4JW9VPyLxc86sg+LbRZ9BW43FDPeFgcyyLCT5c4zwUZON
	ir7kPE7ovXhoTR9MjCdyf6H0V1N4NdjYFtM69kxbkBM9eoHz05ahXqNQRO1Aq9bJ
	dPBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701242712; x=1701329112; bh=ST9eLU3dEIro+
	p0zfLW0kvaq9OekSOLgwRm4nuhWibI=; b=ama083t1VDGvi8jLkb0Puk4nUdKrn
	RUUPy3nX0KZRKtnl7zC0V6MhyF3mO1zxEl74A9Agw0AYv13iFhR2rIEOlPPJiiCw
	FrkOP9D9YK/5ZqLBovJzvZRdyzyxMIg+1rk8fL6UD2OxKzhaherYzuwqLurlg9KY
	OuRPj0m0W5SFTvfpC8/CcceriaS8UIFww3CJUsSHd+KmtQV89qBevLXe5pM6k+TD
	A22je8ns740hDLBxXt/ZLTgbFoYA/bdNeJfGZJhlfJLCYvh+oq4hKlwUUQ2uOBLl
	w8qHGLaO4UDNtHrCVaWmT6nEoXWQ470+DaLBfgRQ8zTmooiwj9wa1QYBg==
X-ME-Sender: <xms:WOdmZcJDkie8Ujo5QGwOOAnNZwV6uzWHj568ORpRbbUN5o80yipPDg>
    <xme:WOdmZcJB9Tw0LqSopfP1filWrv16_A5tqa9el1k3pl0tegesLL3og45Q2IRz6509a
    lAX4KEIuA6WSl4jMA>
X-ME-Received: <xmr:WOdmZcujuR-MnbjJYwkyHe9sSRTv3G37jdEQjoS7q36G-uqdD7CKGWr0-3sxojiVOtdBlopyFgjDHRDEHIV2vnL_lXXj3As36GGgAe2Yd2yGrN2l>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeigedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgfejueevjeetudehgffffeffvdejfe
    ejiedvkeffgfekuefgheevteeufeelkeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:WOdmZZaLOpkTCnbGbX311G4Scg_IYUjIdEP5uQIvfBMe9cH6gg3_Gg>
    <xmx:WOdmZTb34dXzySE-rls3gtPOTsdLvxoR6wVGjBSvMFCMu-27LEPaHA>
    <xmx:WOdmZVBi_08nIfw3Lx1-MdVOwYSO_jgzJAmECtjGRu5BiZH4C2kM-A>
    <xmx:WOdmZd0qQ57BVHDPnKXqiLKs3mc_q8TSF3prGnCSJhWOSvkd2pDXWA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 29 Nov 2023 02:25:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f7f7e95c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 29 Nov 2023 07:24:01 +0000 (UTC)
Date: Wed, 29 Nov 2023 08:25:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 08/10] t5401: speed up creation of many branches
Message-ID: <f674119c7801e355cd08a651450abd67947d7456.1701242407.git.ps@pks.im>
References: <cover.1701242407.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uT2fYw1L6nb/5PmL"
Content-Disposition: inline
In-Reply-To: <cover.1701242407.git.ps@pks.im>


--uT2fYw1L6nb/5PmL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

One of the tests in t5401 creates a bunch of branches by calling
git-branch(1) for every one of them. This is quite inefficient and takes
a comparatively long time even on Unix systems where spawning processes
is comparatively fast. Refactor it to instead use git-update-ref(1),
which leads to an almost 10-fold speedup:

```
Benchmark 1: ./t5401-update-hooks.sh (rev =3D HEAD)
  Time (mean =C2=B1 =CF=83):     983.2 ms =C2=B1  97.6 ms    [User: 328.8 m=
s, System: 679.2 ms]
  Range (min =E2=80=A6 max):   882.9 ms =E2=80=A6 1078.0 ms    3 runs

Benchmark 2: ./t5401-update-hooks.sh (rev =3D HEAD~)
  Time (mean =C2=B1 =CF=83):      9.312 s =C2=B1  0.398 s    [User: 2.766 s=
, System: 6.617 s]
  Range (min =E2=80=A6 max):    8.885 s =E2=80=A6  9.674 s    3 runs

Summary
  ./t5401-update-hooks.sh (rev =3D HEAD) ran
    9.47 =C2=B1 1.02 times faster than ./t5401-update-hooks.sh (rev =3D HEA=
D~)
```

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5401-update-hooks.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index 001b7a17ad..8b8bc47dc0 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -133,10 +133,8 @@ test_expect_success 'pre-receive hook that forgets to =
read its input' '
 	EOF
 	rm -f victim.git/hooks/update victim.git/hooks/post-update &&
=20
-	for v in $(test_seq 100 999)
-	do
-		git branch branch_$v main || return
-	done &&
+	printf "create refs/heads/branch_%d main\n" $(test_seq 100 999) >input &&
+	git update-ref --stdin <input &&
 	git push ./victim.git "+refs/heads/*:refs/heads/*"
 '
=20
--=20
2.43.0


--uT2fYw1L6nb/5PmL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVm51UACgkQVbJhu7ck
PpQguA//QWUvnkWjda98+hGC96fEHWc798f3lMKyrkT2nCFyb+RxDXpwIkXUrkdR
8H8PJY+XjIoUjkSjXWjwfs5boDTXSz1ioZIG2r8MJCu3mnrC6Zo2IvRvAxU+kEeC
5UcQbF2NxtrJGAs5z3r4Te3XSwPqYsh+SkGBc5uPK/to1hib3x8N6isrwlsDJfVs
qbIDnBjy/s1jUfwAot5WK3WrTBJYWxuGPASwb1v2VVcIk8tRSlyndWgCc6O1Wotr
n6NPmrGcKu8qsp7oaXiaCQnosDXrhnd7vgMnyiDLFwBazLTAFh/oBKRELJyMpuHQ
t2Z/9Jj6mb/qhu3IwPktSNMJCE/jyiV9PTSZL0pkwxb6qdoO/5+4g0E66IUM2jfq
9m9F6NCoZDIxxgl6CaoPgTsKfo6E+Zz2DNWAOLoNJsjEEFbj/GAEghNQ2j/XaDRC
jeQlnT66pcPExCxfW3wLjP4HUGPCWmih9fAV2lScgRmEqKyXUK9lHw0Wuz3azD/s
F3d6AGGu0lQb7uBC9UTFZ67hjZS4crM//RJeigrKBtesGdJqx53aAJtsOnPORhAe
noR/puVpTwAuzqXtb4mHLs1KeNJHYjFNnsMRrOI/v0C6We8WkG/EmxHzSNI1wRdp
+ZwrSUQELF2ERYjnRTRpAlNWn+gZY2oUUJ1nG+PoeGGx26hUPWg=
=05Y2
-----END PGP SIGNATURE-----

--uT2fYw1L6nb/5PmL--

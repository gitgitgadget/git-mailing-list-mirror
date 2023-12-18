Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5630A10964
	for <git@vger.kernel.org>; Mon, 18 Dec 2023 08:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sSjp0dS+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CFraZYa5"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id E78ED5C0115;
	Mon, 18 Dec 2023 03:06:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 18 Dec 2023 03:06:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1702886817; x=1702973217; bh=05hIOq/ZgY
	XH0o3TcV887Ml1qf4NNODiMpUd9bW/gog=; b=sSjp0dS+2D13XQktO/TVYyLB2N
	YZFuyBfCjbVjpOK88Z0WMLf2soqhhJ0Bc61UfymnJmoGFR/8stWbvW3GogqSx8aM
	fMIUEDIOYV/ok+TFSLa8A0o23B4V1s1ILNGmcDItQIwzxxU00Y1PG1PN4HkbnXLC
	UW0GrgR7xMMcGifP345HnJan6MjP6/3MLEUs6sp9/YiNDY5J6eFUSA+NWuvmso9I
	uRNZ+K0X2/upQLEuAEHaaLtlnTHhzFLNETHJDWOg5WQOfsYj3NSe6v4D+aNcXoqn
	ovmYF8oauZ87rXxjTbqttGyN2Jzq0EgsdDuLwFl9gBEL0GM9jL3hALyL8MJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1702886817; x=1702973217; bh=05hIOq/ZgYXH0o3TcV887Ml1qf4N
	NODiMpUd9bW/gog=; b=CFraZYa5LJz6AfdmpDPTE49gJ8ph5a5eeT1qb0LZVf2F
	a2ZZlVTt3zItA8fPPL+F1VX7l6DXCXv6Yx5aOUYySnrPqpoJsLc+xhPxdiOJRonJ
	+AlUoJs+o7GthQbGFySkjGbrj60rS0g6pxwmKqjPHY9XLXFLjYGD7AMNkEIf5xHx
	c6bzWuDMZSO3sXQptfnBhtSQyGq5ny/X8y8pDrABVTXnkDliNhtR+vr8SKd0Ii+d
	S4NdHJSg5n6yCvNv+SEpuBtdFZqs4OcUIyLoknffcD4lE8EaNMRpGEXExa9kYF4C
	x78MtCNvH2PSZgT8lnQuS5R35nKet14hd8MmbDMTKQ==
X-ME-Sender: <xms:of1_Zf58m4itXIzAdM-1Kkjsh-l2jkfDQR0JEvbXT9LOR__IcrM3ng>
    <xme:of1_ZU6InqJ98iByppyXuXCTeT1NEV5Ws3cQpCvVyFc-ZkBD5x-KjNeQpRoVvCmfP
    pDhalEIXvPopmjwgQ>
X-ME-Received: <xmr:of1_ZWd1Pu8HQiNeUqbdkOa6D-hj4DjLZQOdQUTBqnhNlZlPsiuUD2_7ZFjZ9NlaS6hI6DYbQeTeb0-Os2EhPcLEK3i7f_n0oA7MH_QEnLHp7z8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtjedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedt
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:of1_ZQLz6cyW6cNsRF64hegBdU_VbaI33wC8p_B8DCu18mGulDj5pA>
    <xmx:of1_ZTIIDG7F5Uy3TOywGQnoqWUGCB6XOErjZShM4UC66f8SsfgFew>
    <xmx:of1_ZZwFexVxgc7Ps4g7xcs42L_vYZ6sZsHnIHsNOVtkks0X0ptMaQ>
    <xmx:of1_ZZictzCtGSGBZBk1WKQilaWmGa-7_AsT0_G9kJhVDPe6Wln4Ug>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Dec 2023 03:06:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6c640b26 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Dec 2023 08:05:04 +0000 (UTC)
Date: Mon, 18 Dec 2023 09:06:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] doc: format.notes specify a ref under refs/notes/
 hierarchy
Message-ID: <ZX_9nRYKVq0jT0Lp@tanuki>
References: <20231215203245.3622299-1-gitster@pobox.com>
 <20231215203245.3622299-2-gitster@pobox.com>
 <0c93d426-17c3-434c-bbd0-866c31c23f9d@ramsayjones.plus.com>
 <xmqq1qbnktnl.fsf@gitster.g>
 <xmqqttojjegr.fsf@gitster.g>
 <xmqqjzpfje33.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bfq5X/x+FnRdPqXE"
Content-Disposition: inline
In-Reply-To: <xmqqjzpfje33.fsf_-_@gitster.g>


--bfq5X/x+FnRdPqXE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 02:28:00PM -0800, Junio C Hamano wrote:
> There is no 'ref/notes/' hierarchy.  '[format] notes =3D foo' uses notes
> that are found in 'refs/notes/foo'.
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  * According to my eyeballing "git grep refs/ Documentation" result,
>    this was the only remaining mention of "ref/" in Documentation/
>    hierarchy that misspells "refs/".

This made me look for additional instances where we were referring to
"ref/". Turns out it's only a very limited set, see the below diff. Take
the translation changes with a big grain of salt though, and neither am
I sure whether we want to fix up past release notes. Also, the test is
interesting because it would fail even if we didn't pass an invalid atom
to git-for-each-ref(1).

Anyway, the patch you have looks obviously correct to me. I would be
happy to turn the below diff into a proper patch, but also wouldn't mind
to let you roll them into your patch series. Please let me know your
preference.

Patrick

diff --git a/Documentation/RelNotes/2.1.1.txt b/Documentation/RelNotes/2.1.=
1.txt
index 830fc3cc6d..d46e142119 100644
--- a/Documentation/RelNotes/2.1.1.txt
+++ b/Documentation/RelNotes/2.1.1.txt
@@ -29,7 +29,7 @@ Git v2.1.1 Release Notes
  * "git add x" where x that used to be a directory has become a
    symbolic link to a directory misbehaved.
=20
- * The prompt script checked $GIT_DIR/ref/stash file to see if there
+ * The prompt script checked $GIT_DIR/refs/stash file to see if there
    is a stash, which was a no-no.
=20
  * "git checkout -m" did not switch to another branch while carrying
diff --git a/Documentation/RelNotes/2.2.0.txt b/Documentation/RelNotes/2.2.=
0.txt
index e98ecbcff6..806908ddb2 100644
--- a/Documentation/RelNotes/2.2.0.txt
+++ b/Documentation/RelNotes/2.2.0.txt
@@ -205,7 +205,7 @@ notes for details).
  * "git add x" where x used to be a directory and is now a
    symbolic link to a directory misbehaved.
=20
- * The prompt script checked the $GIT_DIR/ref/stash file to see if there
+ * The prompt script checked the $GIT_DIR/refs/stash file to see if there
    is a stash, which was a no-no.
=20
  * Pack-protocol documentation had a minor typo.
diff --git a/po/fr.po b/po/fr.po
index ee2e610ef1..744550b056 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -19773,7 +19773,7 @@ msgid ""
 "Neither worked, so we gave up. You must fully qualify the ref."
 msgstr ""
 "La destination que vous avez fournie n'est pas un nom de r=C3=A9f=C3=A9re=
nce compl=C3=A8te\n"
-"(c'est-=C3=A0-dire commen=C3=A7ant par \"ref/\"). Essai d'approximation p=
ar=C2=A0:\n"
+"(c'est-=C3=A0-dire commen=C3=A7ant par \"refs/\"). Essai d'approximation =
par=C2=A0:\n"
 "\n"
 "- Recherche d'une r=C3=A9f=C3=A9rence qui correspond =C3=A0 '%s' sur le s=
erveur distant.\n"
 "- V=C3=A9rification si la <source> en cours de pouss=C3=A9e ('%s')\n"
diff --git a/po/zh_CN.po b/po/zh_CN.po
index 86402725b2..eb47e8f9b7 100644
--- a/po/zh_CN.po
+++ b/po/zh_CN.po
@@ -13224,8 +13224,8 @@ msgid ""
 msgid_plural ""
 "Note: Some branches outside the refs/remotes/ hierarchy were not removed;=
\n"
 "to delete them, use:"
-msgstr[0] "=E6=B3=A8=E6=84=8F=EF=BC=9Aref/remotes =E5=B1=82=E7=BA=A7=E4=B9=
=8B=E5=A4=96=E7=9A=84=E4=B8=80=E4=B8=AA=E5=88=86=E6=94=AF=E6=9C=AA=E8=A2=AB=
=E7=A7=BB=E9=99=A4=E3=80=82=E8=A6=81=E5=88=A0=E9=99=A4=E5=AE=83=EF=BC=8C=E4=
=BD=BF=E7=94=A8=EF=BC=9A"
-msgstr[1] "=E6=B3=A8=E6=84=8F=EF=BC=9Aref/remotes =E5=B1=82=E7=BA=A7=E4=B9=
=8B=E5=A4=96=E7=9A=84=E4=B8=80=E4=BA=9B=E5=88=86=E6=94=AF=E6=9C=AA=E8=A2=AB=
=E7=A7=BB=E9=99=A4=E3=80=82=E8=A6=81=E5=88=A0=E9=99=A4=E5=AE=83=E4=BB=AC=EF=
=BC=8C=E4=BD=BF=E7=94=A8=EF=BC=9A"
+msgstr[0] "=E6=B3=A8=E6=84=8F=EF=BC=9Arefs/remotes =E5=B1=82=E7=BA=A7=E4=
=B9=8B=E5=A4=96=E7=9A=84=E4=B8=80=E4=B8=AA=E5=88=86=E6=94=AF=E6=9C=AA=E8=A2=
=AB=E7=A7=BB=E9=99=A4=E3=80=82=E8=A6=81=E5=88=A0=E9=99=A4=E5=AE=83=EF=BC=8C=
=E4=BD=BF=E7=94=A8=EF=BC=9A"
+msgstr[1] "=E6=B3=A8=E6=84=8F=EF=BC=9Arefs/remotes =E5=B1=82=E7=BA=A7=E4=
=B9=8B=E5=A4=96=E7=9A=84=E4=B8=80=E4=BA=9B=E5=88=86=E6=94=AF=E6=9C=AA=E8=A2=
=AB=E7=A7=BB=E9=99=A4=E3=80=82=E8=A6=81=E5=88=A0=E9=99=A4=E5=AE=83=E4=BB=AC=
=EF=BC=8C=E4=BD=BF=E7=94=A8=EF=BC=9A"
=20
 #: builtin/remote.c
 #, c-format
diff --git a/po/zh_TW.po b/po/zh_TW.po
index f777a0596f..b2a79cdd93 100644
--- a/po/zh_TW.po
+++ b/po/zh_TW.po
@@ -13109,7 +13109,7 @@ msgid ""
 msgid_plural ""
 "Note: Some branches outside the refs/remotes/ hierarchy were not removed;=
\n"
 "to delete them, use:"
-msgstr[0] "=E6=B3=A8=E6=84=8F=EF=BC=9Aref/remotes =E5=B1=A4=E7=B4=9A=E4=B9=
=8B=E5=A4=96=E7=9A=84=E4=B8=80=E5=80=8B=E5=88=86=E6=94=AF=E6=9C=AA=E8=A2=AB=
=E7=A7=BB=E9=99=A4=E3=80=82=E8=A6=81=E5=88=AA=E9=99=A4=E5=AE=83=EF=BC=8C=E4=
=BD=BF=E7=94=A8=EF=BC=9A"
+msgstr[0] "=E6=B3=A8=E6=84=8F=EF=BC=9Arefs/remotes =E5=B1=A4=E7=B4=9A=E4=
=B9=8B=E5=A4=96=E7=9A=84=E4=B8=80=E5=80=8B=E5=88=86=E6=94=AF=E6=9C=AA=E8=A2=
=AB=E7=A7=BB=E9=99=A4=E3=80=82=E8=A6=81=E5=88=AA=E9=99=A4=E5=AE=83=EF=BC=8C=
=E4=BD=BF=E7=94=A8=EF=BC=9A"
=20
 #: builtin/remote.c
 #, c-format
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 54e2281259..e68f7bec8e 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -841,7 +841,7 @@ test_expect_success 'err on bad describe atom arg' '
 		EOF
 		test_must_fail git for-each-ref \
 			--format=3D"%(describe:tags,qux=3D1,abbrev=3D14)" \
-			ref/heads/master 2>actual &&
+			refs/heads/master 2>actual &&
 		test_cmp expect actual
 	)
 '


--bfq5X/x+FnRdPqXE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV//ZcACgkQVbJhu7ck
PpSPNw//Uju53R99UNc+PnGUAKLXLYcKZqoYxDGAovpwJpGH/7K0y0jonfJvcYAF
4A3NnZWHCF4jX+TorjkvexBtYcazf8/nRftPk22B80Wvr2ZhDSZNSn9roo5tcYSZ
4ZGAlDHcJOiWqcH27jjuZsirSprTmOmtnKH3MnirwU6MFmiY6WjzuLSrI/Khk0aN
HlHnUQGoCz2QX0PVMXlyJl+jh7jzikIQHeBxVqlC8oFIZxgF6QW2nhT7HKArFUfR
AQ/rAas762aIvuYKgqX4Jn6nppxn7AmTiPF9KsHL7JidbgzChGwGcFh1A/kXLS1y
I6bG+5SZOS/jvGsfcAEdohTdHFiAclqUdiAc57QwdAvgJQmdNj4kbzUTKCo7kYqW
EhVFDsXCHGHXtJjo6SomnsWceQPdt3n1Vnn7BfHPPQp/8KjxW8LbyGgpHGKk2a3X
BDR0Cs+mac5uHmOtxXN6c20pzOclGJI0UoV5deCoOlunVtiYmtZFff11LQhbx86J
TkXTR9XPSuaDEBxvg/7HUMYu689QTFd9fVICJbR7etepXHltrnQK+NrXFEDUj5XA
RJtzAi+TBOcA9cv2vxwf67t4VReIenxoPX6/nbI1JpDA9/IW0zQuqQ97JqenVDeR
jz4HnCyj4bXl5HDsMMKnVhIqCb/FCkLBjbmy0Mh7q+U+pjRDcCs=
=CbC6
-----END PGP SIGNATURE-----

--bfq5X/x+FnRdPqXE--

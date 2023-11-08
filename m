Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DF4D528
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 07:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RWGFVlMx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lpsXVl0z"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75ED7170D
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 23:30:08 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id E734A32009FF
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 02:30:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 08 Nov 2023 02:30:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699428607; x=1699515007; bh=cd
	z5SMqW8kENbFOwiZlwZAY+siLBzuIKGJslFg4PSKY=; b=RWGFVlMx2g7Xw3thqo
	mE+gxd6YC+PUqF/0/0C6lttO3l9NfOHY8mhpFGkhJE45pIFtReSQTqq473QDtSGU
	P2uvqM+nE5hgjGyvYCiTp3lvcIMVYyOGjGJ3tRms453WHoC7mhBYipClzdkw3sRo
	lHrQNgOpwXGSOV/ycKyj2FR9Fj29fXrxONwQoUcA2xcNcwW02jAttt0lgTPUWqQd
	pMtrYLyEfz42hR9kFaiWwxUNDNhF8qmOLsYIkcsEnCeRg/w4d4Rpfdk28wR2WkmC
	BdAscdOg621klYdUlRNnRMgC1N5DymCH3V+d5qY4h0sZqih0u4e7kT2Ehe/CaseQ
	fUbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699428607; x=1699515007; bh=cdz5SMqW8kENb
	FOwiZlwZAY+siLBzuIKGJslFg4PSKY=; b=lpsXVl0zFIrmfDZRH06o3KYzouV33
	vn21S3QNq8YU0en/Zu3t1zxJfh0rRMKvuR/aFQMH5345M17arzUDh3ckx23le3jC
	ukWoYKBiixAbn+ng7llH/P8p5qDbGt2YGtfq5z9Tb1bj5TfEleFax97stdJD1Xk4
	5qZXTCWi+ie9VfQ0seJjlzIfP+yWdpqdoDW1ya3KqkiFhL2kYyM9p6oHHnWHwyiM
	dzHwj9xmUyx5SfyWiTggDEZXcu/75tQ0FbTKTNb9CB1KAnSjgu8oaPnPHFR+4c4t
	R/kx2h+gmxBOCsye80r4fDK2Bp2kqAbTnxN6BcyZ9no7WMw8GSuAN8RVw==
X-ME-Sender: <xms:_zhLZV0k6ACWz1e4iokK2ogxdbNvMxXHZzZns1Emgiqq6aPE3wM3IQ>
    <xme:_zhLZcElNWeeIcLw0AqttV_gtkLkiPbA_PLdgAuny2cVEeNeHu-jpSG9BZlcZ7wx0
    4OpGhIPx1MKS7wBVw>
X-ME-Received: <xmr:_zhLZV7R2NQ4vAUEXAXPkyKGsGt7cmvHncnjk_OUudzUupAfowWMjMj5D7Kt0M5SEKnKf9KLjRc-ovO_ilTR0zpVaRODhzxGBXxXYYaeE1l->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddukedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:_zhLZS0F9zfTMuBwuBVvGGVIBw-Qds0k9serZXZDK6gEP-uW44TfBg>
    <xmx:_zhLZYFmk8rbdUd1_aRerEbHk_cfLOE4PANImpAZ7dpbVt5Efj-S5g>
    <xmx:_zhLZT8nrYxrXEEdSDKTEkxKqgIB_ZbuQNVJJZTrKtxOU3VB093UEQ>
    <xmx:_zhLZbzv9ROUVJeeHmcgNGx7uAixZe1Mrr9QB2pEqgJ8iIGoW4Wg8A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 8 Nov 2023 02:30:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c6a8d844 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 8 Nov 2023 07:29:42 +0000 (UTC)
Date: Wed, 8 Nov 2023 08:30:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 3/3] t9164: fix inability to find basename(1) in hooks
Message-ID: <b50e625f9677469ecb33150343b88d5ac119dadd.1699428122.git.ps@pks.im>
References: <cover.1699428122.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2P82t5COjCs7He+F"
Content-Disposition: inline
In-Reply-To: <cover.1699428122.git.ps@pks.im>


--2P82t5COjCs7He+F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The post-commit hook in t9164 is executed with a default environment.
To work around this issue we already write the current `PATH` value into
the hook script. But this is done at a point where we already tried to
execute non-built-in commands, namely basename(1). While this seems to
work alright on most platforms, it fails on NixOS.

Set the `PATH` variable earlier to fix this issue. Note that we do this
via two separate heredocs. This is done because in the first one we do
want to expand variables, whereas in the second one we don't.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t9164-git-svn-dcommit-concurrent.sh | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/t/t9164-git-svn-dcommit-concurrent.sh b/t/t9164-git-svn-dcommi=
t-concurrent.sh
index c8e6c0733f4..3b64022dc57 100755
--- a/t/t9164-git-svn-dcommit-concurrent.sh
+++ b/t/t9164-git-svn-dcommit-concurrent.sh
@@ -47,9 +47,15 @@ setup_hook()
 	echo "cnt=3D$skip_revs" > "$hook_type-counter"
 	rm -f "$rawsvnrepo/hooks/"*-commit # drop previous hooks
 	hook=3D"$rawsvnrepo/hooks/$hook_type"
-	cat > "$hook" <<- 'EOF1'
+	cat >"$hook" <<-EOF
 		#!/bin/sh
 		set -e
+
+		PATH=3D\"$PATH\"
+		export PATH
+	EOF
+
+	cat >>"$hook" <<-'EOF'
 		cd "$1/.."  # "$1" is repository location
 		exec >> svn-hook.log 2>&1
 		hook=3D"$(basename "$0")"
@@ -59,11 +65,11 @@ setup_hook()
 		cnt=3D"$(($cnt - 1))"
 		echo "cnt=3D$cnt" > ./$hook-counter
 		[ "$cnt" =3D "0" ] || exit 0
-EOF1
+	EOF
+
 	if [ "$hook_type" =3D "pre-commit" ]; then
 		echo "echo 'commit disallowed' >&2; exit 1" >>"$hook"
 	else
-		echo "PATH=3D\"$PATH\"; export PATH" >>"$hook"
 		echo "svnconf=3D\"$svnconf\"" >>"$hook"
 		cat >>"$hook" <<- 'EOF2'
 			cd work-auto-commits.svn
--=20
2.42.0


--2P82t5COjCs7He+F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVLOPwACgkQVbJhu7ck
PpRiIRAAqaAfoQ7gmAYsReGFbdMcaxKcNNOEwnsttAhjFWC3MQD2GEKqRBiYSc9A
Yk7AkG4uaklL4zWEJmLb5xaqenZZf9gtLYyTSg8XTp3Zbn7athL0JCodmoM/NEz6
XRZkeBc/taVCUiqc//IkdfrpVuJk4cqwAOwUt73bCdi7y7WblLf4PEVhDrDet2Gd
o8sF4OM9CMNJO1ypLY3s+x9LiBnxlmx5cubNnZgj2vWP65CQm2Ki0+hposg9gANr
rl6hdwoP72y4479xgzni8LUgx9IXpRNEC86+1Cw1Ot5p0o2Q8u/CJ5drytZKY6Wy
KbMFHuaahYLsA3gKmJ5V2cF8ObRNokr4kOawgyQSs6XXNKs5bsuhuHxTYJDOToB0
nIhs8lnP8uKOsh5NGdrwb6dGbRmCfH3c7GA3FJV1xU+gDah+YOfeh/7TMItHx9Uq
pD00VGXhX0mUmqM8og3X7ypKxXDoWpSzI1/UU0Gk7Afq3jrk6tzw3v3BNh7rrdp7
ybXgmPibwRpnU/qr/Ge+OEAEKgCOdaY4TjQkCfowr5fjqyRyAiDt0UFyXQUs+/2Z
22yCZPmJ49LsstIS6wb74qYxIt3V/juu4Gqt76bo0xkpAq1FdsbnUeVdNLKbrhwi
WzzNFyVSf6rHx1P3o1Ms0l2hogvd7Y/4hYBshXMLDxnAu2iWxig=
=+7Gk
-----END PGP SIGNATURE-----

--2P82t5COjCs7He+F--

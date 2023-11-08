Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D346230322
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SX6zT778";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QpI8y/8G"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531611BE6
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 06:57:31 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id B052632002E2;
	Wed,  8 Nov 2023 09:57:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 08 Nov 2023 09:57:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699455450; x=1699541850; bh=ts
	PUIUGWYQ+qz9+iky9HrPEGGUUqUil8lQLcjXf4Ufg=; b=SX6zT778Xxud8cl9sG
	w3gjFyJntraI/9lzDMNulO+tvb4YKJQ30fudN6ctF0wJ1tgzF+yOzAajVoDjdsnr
	yh49w5dpMGn76mYZRssbJAndx2MTtbC72bup8HgZAzM3mhoN2QetpGHjdUeRSxa/
	yttcvL+6mbB+luHy/tNxBfaXJW7gAqOfHKZts08ZxF9M09BCPxNHxsLATmgcpE/c
	9Pe+5ipjJjKFO+rPrKANLnQlgEx0v5SDvAm6PhlNLqR3DDwlFmRT2ULt/V0pVjUr
	h4PlNbZ6p/W2hmcu1Fm7zjuPHk/1BF8YSblRQL8muPhE4K09KcvrB7Xtg3MrDKFJ
	bKkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699455450; x=1699541850; bh=tsPUIUGWYQ+qz
	9+iky9HrPEGGUUqUil8lQLcjXf4Ufg=; b=QpI8y/8G5J7LS8VlcLkyarqH4rgfu
	tiwocDRpB6EU/OMMBa4yGVBunBvLnnLqHBZo4569RcQen4wBFVohEBjyamXDmKZU
	7Zef4+4waGZKs2P63rDVdFMA0ogiW9I3lKX7X8o1Jkulr1tuVpjcJ16UGc+ca+3a
	oysIOYFcCrW4EzO1o+1mqu2tuycLqYXtUmFnn/2YdP/ClWS31wYRhODc93clDszG
	U6KLmZCngyzCavEqKXp4zL0I1fZYgmJm14tPfnnMffHgyDiHJCpdfaWEbQJ5vVLM
	MNtkVkoDHo0GByReJzJuQQgNA8MikG8GtmiZ/XOQ06dOF6t1r8KgEp20w==
X-ME-Sender: <xms:2qFLZbuxGJIlD49o2Qz_1vD1GUaezh78x9uNvgRn8j9bUkV492G-9A>
    <xme:2qFLZcfKi650K1RUw3hpBnpc0paS61fks-RBeIjhBS6quQUcCIfEPxuHF5tlhb9Lb
    Yrbhd26_VNPftu8OQ>
X-ME-Received: <xmr:2qFLZex4iGLVIdS5TbjhXEOu-6HHK52z_MRz-dF2JHStwCZSJ_cymsIBBx9oCEJ9NgFFSbiyN3QMpN-WX2QgTq9ct4NbfsDPI9P4V8oqKUP6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudduledgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:2qFLZaPwMvd5nELTuS_c0I_mS9q98pbjJPX_PUOzvqrvpNu8BfQieg>
    <xmx:2qFLZb-ranEb-eufmDqPF-UnclEcpRo9V2R2u9kogRX6EejOoWnKwg>
    <xmx:2qFLZaVWs5dZZZ26vMt-P4hm-vgMJS-r4qGWSnOHfpwlSC7Hyx0RWQ>
    <xmx:2qFLZYFHG60_MTamM7gfiYt7Vj86nhoyv1XWX9uJnSlMM5_lH1-TDg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Nov 2023 09:57:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c5e79bd6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Nov 2023 14:57:04 +0000 (UTC)
Date: Wed, 8 Nov 2023 15:57:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/3] t9164: fix inability to find basename(1) in hooks
Message-ID: <361f1bd9c88e3e6b7b135ba67b39d3bf4d70e322.1699455383.git.ps@pks.im>
References: <cover.1699428122.git.ps@pks.im>
 <cover.1699455383.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fGJ5RgKrTT0pMAax"
Content-Disposition: inline
In-Reply-To: <cover.1699455383.git.ps@pks.im>


--fGJ5RgKrTT0pMAax
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


--fGJ5RgKrTT0pMAax
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVLodcACgkQVbJhu7ck
PpTzWw//ZG3Povi27JCMxMTENKxj/x3CD7R9eVxzWmaCbogbjA7vTqqNcinp8kzz
KVRtrtVfoIZDu3xOWMjz5maN9b8kKqf5j83TXFissbnQjpp4i+eljldV6TBrUoFO
jBlM+FCaT7pQGtQbd0AF71rIa80uVR3wWcjofhB4BLrB7ylvEkaVX6XQ98YXVNph
g6Op2IJdaH9o7FiTn+zNzwynKpOdvli/vcdY8cjT5T6DTSxA42Foe9JgHblsblHa
JKo8GssFwFQ4zPWuufQm1M3OWMPi/btqRVKC/GxuKqlWrspv272zWPghH9B5EUMV
D6c2PELvn/y1d2PbjE3Y9ycajUld8FVDgs/48YehPQ2nIn1a7DrEa9mD1Ak0LGFE
kfCF60QAhm8+8Uf2tz2ZapD1TkDj/2enAIF52Qz2FlM1sOrPGmY58ZqDW/UHs5Lr
7aBwqyq4VFTe7+3dAnzdtIeudCC7E7N+yOAQu873P/XWHrod5VZIGg2PqAvaeeWn
Ou5DpEC9QtI4Ir0frSKrRz05bW84F5awSi9K/dYCG7M/00oDvMYVDoUxswBs/67V
qn9d+Rno4SkcUKCB3hj1uSaut/fJhNQGCWr0JKdCpGF3uNZjpHsAL/RGpD9jkrWS
nCVGbGC7NYNZw2jl/U+9i25U4+mnNxVXIH5PW5UzlzF9OHfgW8k=
=M1v/
-----END PGP SIGNATURE-----

--fGJ5RgKrTT0pMAax--

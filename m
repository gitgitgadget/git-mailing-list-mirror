Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4EB156C0
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 12:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pYsR0IRS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rl4z4WRZ"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354CAC6
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 05:14:48 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 67C313200944;
	Mon, 30 Oct 2023 08:14:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 30 Oct 2023 08:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698668086; x=1698754486; bh=jg
	8MgYs/3AmAdC73f9i6i0Y61AHYtzfu4EpnaSOHYPE=; b=pYsR0IRSEciDAr5Cnh
	TQVyaIAWbQWfuSCuOVaSj2A9OTaHOe9qG+KvLVhZ6R2SQnUhmKtiOgKJcLYWPy8l
	yxU/JRj36wP+htDDABLkFiw3ICtgld31CUpMox6GefQI8hKgA+Y734oW1ZBA7/0u
	S6LEMKGT78yzRXeD8WrztJqMpwmCsSkLlF7sy+GhC8IK9Eay0sNQzLjCX8r4giek
	G5LULIGl6qvGwlIvAia4KqF1M5HWc/GT7+dgpyd6KS3xwlKayuNhytUv1LmpUQgC
	xpQ4fxnxKrlKkBfgubxpU6qbsyupq6dJQjglNvHw0WpHFe7Mlhdk7aC8o3NB/CrP
	MEWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698668086; x=1698754486; bh=jg8MgYs/3AmAd
	C73f9i6i0Y61AHYtzfu4EpnaSOHYPE=; b=Rl4z4WRZlFUxTqAjBYCR3V74dslgt
	QsampYd2q3f0JvBuziL+fAOcbACtmcSntYx+QoJ/S52e3j3564ebY/Sc2KCVIfWV
	Qj2Krvh4ws6yGb4ojc4WDLKgR5C0mlosBwJaQjmqH7ZXamYtb3eTq6w3bQIwmiYn
	p0g4QA6/h/SK0N6zeXvMriQbZZiB+weQ6/FJ/QctnbMZ0F1130CSvDS56QRAC4z4
	3bUhMcYleJ0/rQnTpPMCU3AauhFuDgOdl1ZEEkO3ozbxPvmaBzAL9C43A13O1Q5G
	sXm2n3tfIymzOUczK43Otws0F7kkjzp7sQ+PqFKb3pRpoY9lnY9ldhmmg==
X-ME-Sender: <xms:Np4_ZQFUfPeeXhRwB-qwzvgqlMlbscDN2wnDHP-q1lH1aOPHTUaGvQ>
    <xme:Np4_ZZXGSqqkbLwpmAwILI0HYAfWh7IunzPYi7YAcw6eOU5cMvy4qKcaiVCH_95R8
    Xly3sdxpYb_-3nlyw>
X-ME-Received: <xmr:Np4_ZaLD_O54D0RnSVYDBivhWYZVTgc1YXLC4xihZXBx-vfhWrEq93XMBlGC0f5XnjF0uq9ERbTAGv8mNZ_PKVvvCdNxzfY7cFRhfhgIoZ5qcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddttddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Np4_ZSFEnvMCbsvXxeV0P4C8zTmH7oj5aXNafXEURw4QPBOnQeDouQ>
    <xmx:Np4_ZWVsSJRId8ftdQgOJiQIHAU59GdZPxqgfB7JJpB_2CXUR9OY9Q>
    <xmx:Np4_ZVOBOzgE3dvX_Z1HwhD94uowPpVjj3ZTGwDW-jzX5mq7G1KUbQ>
    <xmx:Np4_ZTjBDDuFtk5wYJHg4vhluyrpSbe5v9XAEAZPsV5vTH7u8dfYtA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Oct 2023 08:14:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bc932a16 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Oct 2023 12:14:40 +0000 (UTC)
Date: Mon, 30 Oct 2023 13:14:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH v3 1/8] ci: reorder definitions for grouping functions
Message-ID: <ef44ed5c3b19ec1479b3dceca8d2f64de3409a5c.1698667545.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698667545.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="B4ZZ2dWUspZVOQsT"
Content-Disposition: inline
In-Reply-To: <cover.1698667545.git.ps@pks.im>


--B4ZZ2dWUspZVOQsT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We define a set of grouping functions that are used to group together
output in our CI, where these groups then end up as collapsible sections
in the respective pipeline platform. The way these functions are defined
is not easily extensible though as we have an up front check for the CI
_not_ being GitHub Actions, where we define the non-stub logic in the
else branch.

Reorder the conditional branches such that we explicitly handle GitHub
Actions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 6fbb5bade12..eb384f4e952 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -1,16 +1,7 @@
 # Library of functions shared by all CI scripts
=20
-if test true !=3D "$GITHUB_ACTIONS"
+if test true =3D "$GITHUB_ACTIONS"
 then
-	begin_group () { :; }
-	end_group () { :; }
-
-	group () {
-		shift
-		"$@"
-	}
-	set -x
-else
 	begin_group () {
 		need_to_end_group=3Dt
 		echo "::group::$1" >&2
@@ -42,6 +33,15 @@ else
 	}
=20
 	begin_group "CI setup"
+else
+	begin_group () { :; }
+	end_group () { :; }
+
+	group () {
+		shift
+		"$@"
+	}
+	set -x
 fi
=20
 # Set 'exit on error' for all CI scripts to let the caller know that
--=20
2.42.0


--B4ZZ2dWUspZVOQsT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU/njMACgkQVbJhu7ck
PpTqKQ//ZDC3W/sXOc5VLHC5K5vU1Y0x2uXycMo4FUjw+fWbfIapTsH+Oq9vXEza
j6SLZydl4Ub2kGsc0tfvR8PRAMScY2fq5ZSHt/fecumBk69DsKHsDjGZ6zt3cmnw
ciS9VfF7VwpgZlOwa0ZE0CMsEOt/Cb2UdIgswE3RwvHwynX2DTj4yPxnj3Xe1aH0
nORFYkQ/xj6L9SPTJAfr6CdK8iS0gPbaUEGqLU2V3frkEPIOn4UBwAs3cWTzqnU1
bZhowt9IMKYP4TUZxRLo941iuSF2+Ge5+UxhadjE88MO7lT9NfJQQDWdd7lWxaSj
cFSO6693VqvO5C/LqS54TismIUmALu9ySIHAjN8kTd9QFUrM3BWkxqxlaWlIuyq9
c6SJ9esclFEQHttLJVzbD/jKrNmlkF+p3VRdPwWA8bcymeEkmbkXUYUwT9XhJMtl
Dx4qfxshVQmKh/9Y4m9r4vsiaP1GU2X6Gyoi9fYQnWohkLlWSoAqq9S6U2rUwUKQ
FnJr8q1xkDGvlr3dEhoUB1afjEvIG4N91qIw/YQzbpBxCBoF7ItGTjqLcWX9Qhyi
xxmFElptXQ1HG+br7KOOuDxGBL1k5EKCnKC3iWqtQfS9bdZzDKufMsgGbK0LQ8Dg
PP5HSv5TnzrpCrH6zqRJuvJ1R/8pBu+zzS00KoCkvbaj8PpCme4=
=3yWP
-----END PGP SIGNATURE-----

--B4ZZ2dWUspZVOQsT--

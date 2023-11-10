Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5F713FF1
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FVh00FSu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vGK/IDr1"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C5926303
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 02:01:28 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 0B18B32009A4;
	Fri, 10 Nov 2023 05:01:26 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 10 Nov 2023 05:01:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699610486; x=1699696886; bh=bB
	vCWDmr7Ynf0mpKg0vZjKVBHEDpefSPoVzZxbkfxJw=; b=FVh00FSupWWnRxn8U9
	pNsX+OTryGd/s3sdwBbs+4lPJl4wng/LBa2iNQBToL1AO+BCaPGHxDCtvRJqeMqF
	HXyBbGFQGGRqYg1XNTQWS2cnyk5Z0yc1Avmuv1UKQI+Eg48IE/y3oTMfh6p8hTeE
	X1OcKJoC0ZRtBYB40YibcbtSYw1DYqn6fCwWdlvVQdAtVuzlU8Ne/6tukAPwiQwy
	hhZytB3vxTY/ui9/8LVsiywMLapZVTtF+5UGaHmfsRngiv8T2ZS6QRYlbIflivRS
	jegyw8/yvRZDD3Hg7q0Tpuy9tSaWXfa22RJ+YtCW+7sqSXpH2UcwX9AY/cibd+f7
	IhVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699610486; x=1699696886; bh=bBvCWDmr7Ynf0
	mpKg0vZjKVBHEDpefSPoVzZxbkfxJw=; b=vGK/IDr17YEtfCOSpxrEtebSTbSm+
	gWNcXhYtLMaGJotCKtpg+Eyerbs8wahE7+XsIP8p289YDrOI1QTAR0xVDo7bd+sS
	/4deveO0MWPubaDQp2IUT0+197gOI0RVYmiz2IrW1tjOVlGYEPAEiyp5K64sMCpz
	MXGaVfO56JYtFevlEbgk095gNlEAy6U63871LS9WFUOI7ta8HesoTuWPAXGGkM/E
	ha7l0qkC/ydn3B08iFHmh+Ge/7Cl9/8It6usHjL8UrwyVkWaW0/hOD11ZVe6OT/j
	dHrDb14jloXLgACXX5brY+uMzzlyryGbbWxKLTlSMPD7sHeNUwBylAHqg==
X-ME-Sender: <xms:dv9NZTl2AnrwCxo27ubdm336p6PDYoKaAFZxaZhcC9q7kOivO-dKWA>
    <xme:dv9NZW2oxdu3APZpJbCOy17iImlOzP0e7gPdCPFKlDv4ukEvOzxMq6HnhgnS4zXWJ
    SL50_bk7UyJohnCMQ>
X-ME-Received: <xmr:dv9NZZr8VuoyKVSDpCDp0CQQy1jYiujGCELu6qW7_vGB6Ddzgcl_vyXb_uCvjtjhxk9A3AjKoaR4_9Dx8u3vKNNC0KZqm5Bpup83Q7mLsqHwP0bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvfedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:dv9NZblV15yV1tmwWH5bdCWC7sDsO3REvLY69GUgEAw10LINe006XA>
    <xmx:dv9NZR16g-_1Mnh-IAsHpRttc6qdR6nTZyxwFLQZvV1Qanmtv-QcPA>
    <xmx:dv9NZauoU1ShQMdvYL411S_IhIrSzIj5FNo6hC8lMgcn_Qp91RxYTQ>
    <xmx:dv9NZS__E1wU4PEU0bcBO6vcxSqJRAYnildK8QsASTbybyS9GYj9zw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Nov 2023 05:01:25 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 279f5469 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Nov 2023 10:00:56 +0000 (UTC)
Date: Fri, 10 Nov 2023 11:01:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/4] contrib/subtree: convert subtree type check to use
 case statement
Message-ID: <761cde1b341e22b20063ce3baa6b70d80aa05168.1699609940.git.ps@pks.im>
References: <cover.1699526999.git.ps@pks.im>
 <cover.1699609940.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7OlFVgdsvOy98xOl"
Content-Disposition: inline
In-Reply-To: <cover.1699609940.git.ps@pks.im>


--7OlFVgdsvOy98xOl
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


--7OlFVgdsvOy98xOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVN/3MACgkQVbJhu7ck
PpRzyA//VhvOoO+AtNf7LNdQg2E5RAQdQNEcLGuzSZM7goXQwGoRQkOxve5jICzO
+Cl1p7JdPc2cfCzvbQQtKgE/tR+fykdZVQbcbb8TD09b2J20PU1N/Q5SkZxsgJtG
2SJBUKo0aZEqUierqev7UKFqdwsAQa1su5jRGP/kWh7mAA8AmbEuvOaSqhCbBC9B
f56Jd3LdoU2ERxdcMygseCAkD9/SyGEHc5gQvjFK24p8U0bXsJDLYw5oa1YtUcAe
Z5mbzTmoTgnA2HZM3DKQo2swUx6z0TVpMSum14LQKyrIhjUJIO1kp0Fz2xR7Gzgn
7FAmLLxRKbYeInkKvhZ+WtTyeOd1Aj+evErbVqCev6+Azh55S/shYJ+paY6m0RL/
HtmGqGDLKHydi/+mmCB3lSi9SbjRzLF8aVvAgU5MbqC7ZF8ot3qClI5TaiIPaJAo
rP4ehGINvLXCbkNLWLLPu1cBjYlilUSl6FJLzeRqvlL2sYhXNLcESJZACbcZx7kG
A6SlJalPcbPag/WAZKqVvtI+Y+IERK+b7Y5WLm9g9u9L5vsYXHysE/5kc6oSkXUI
pMjoRlZJeRRH2fkTqPPcvoUjJ0j+DuT5fjpaIDBydVKXHcPBtXZj9AQE7gS0bp8t
iuZzg62SiMtrcW66Ri9TFfzMLEmwXEQzT94RTrJSHPCz/7EbK5s=
=M8KA
-----END PGP SIGNATURE-----

--7OlFVgdsvOy98xOl--

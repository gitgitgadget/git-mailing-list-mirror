Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED8A12B79
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 09:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B6o708lU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dHB3EIv7"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE3CB3
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 02:04:46 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 2D3A13200A06;
	Tue, 31 Oct 2023 05:04:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 31 Oct 2023 05:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698743084; x=1698829484; bh=6v
	T9Pny6vRasIsYaESvuM4GMnh4WqCUwuyRpLuXp6tU=; b=B6o708lU6Ca34fu8v9
	DZt7UI2BErPwFqcobqoIiyu3+iS7OxMGKgpmxcOSrMCqEQ5UJ32g4cxIACgHQXag
	Hy15jrmpks8l2zj9SkVAR8/dTuLoLgv0NSV9G4UxPEpGPLAKvRx3QAdsxd8uXv2O
	RDVSYQ7gS8JeO27j7EV8y6lHksFdueSSA68+ZJXaMTAZIZRXBkEDwkzR1Ryrk2tr
	vvZ6JQoIGmGLpbGbFZACzfVrtZKhZ05ebcwum9ILtM0QHY0tXDOjG++X7jxkh1YM
	qxVMg0PyJft8neuzFXI9sstG/ZhQXHoQ8UYNsfXxlJ+Usb6N0boExuJy1ZuIId6F
	5QVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698743084; x=1698829484; bh=6vT9Pny6vRasI
	sYaESvuM4GMnh4WqCUwuyRpLuXp6tU=; b=dHB3EIv7CxcSTGjwv37nbNKMqUgcO
	vgem7BvHexg/ZqdX3/ULgg6DyjhlkZZPo4DIj+bU6HF2vZg6Mg1lnO2x2p156v+A
	NwmPeSR5s4nGpJJ9x810NadhM40ajgJ9gMlTs7DLccTLFTQgBCePrIIz2cufsmjv
	OB1cIGqYDVKvornB2dKYiI7WqBHaFbAhp1hds9QQk3rH9kmDvDe2CbqoDdXyu8wJ
	UWILKXYv5ISQfOZ5hZGJj3B9708luiU0DGfDg5/eJBuVc0pr2RYXIwpKETvuE5fm
	IJN0OdAOyJABJZNxJIj1E3J6BTXKyM18XuaZLQhqEtyzPbB+Yym0QQztw==
X-ME-Sender: <xms:LMNAZSrFpn0XPQHYOoap5HPIm6wRA0RA7ZFY6gYy2m7SX-vZk_4l8A>
    <xme:LMNAZQrL08sCB7OtoFNGIUAQaVW4Q8Oo4a9fx1eyiMadlZbIS8WblkLAMdsUGrZpZ
    ij8BlKifoh_lpcuBw>
X-ME-Received: <xmr:LMNAZXPHMOI6Ft-nXMmqFjQvcY61Yq4Y2TBGr4eXcTbvHiARFuI7yr9RpatXZzJLyCnc3YY6i_KrzZvhKdQgRZ_MATqvyV2NMEvPEzwlWn-BSY6O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:LMNAZR6q3f43nZSbEVLBmIupm4HDVU6LHJTCu19o0qowOV4d1PAOMw>
    <xmx:LMNAZR4nJL-cRTiYJ8g0einySwaDgTveAGEKs937qWycnn4yAuXBlw>
    <xmx:LMNAZRg4GHK9ip4Kut5jWH7VeGFh3JZOF6zSS-4fUKifdh7E6vWb3Q>
    <xmx:LMNAZbmIFqm_cy3r0v_R188Pkp85G2quhhdLuukPl5FbuzhRfw9Umw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 05:04:43 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a6678cc8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Oct 2023 09:04:36 +0000 (UTC)
Date: Tue, 31 Oct 2023 10:04:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH v4 1/8] ci: reorder definitions for grouping functions
Message-ID: <8595fe5016ab99ac3818e132c787303e88bcef84.1698742590.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698742590.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UuL7nYrxJqzh21MR"
Content-Disposition: inline
In-Reply-To: <cover.1698742590.git.ps@pks.im>


--UuL7nYrxJqzh21MR
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


--UuL7nYrxJqzh21MR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVAwykACgkQVbJhu7ck
PpSaDBAArXGfQyx5zKZVhCNtwTOrEvExCEHly5l1OnOn2tSOJT4v7SRlcnd/e3oq
GHNbUS+TVnvmmGAJduEIRQcEpxYCNBpZfQQEaNn+O+fXczYbv411C0ExpaO2/0r1
a7cbQhG21UqIRt78ROCcBv9rpZfw+ztjMLRpm0QgqYXwffGRPuYgVg3VaqIJfV5p
KM6WcjmZUfGHddBg7VP2HjHMj327UuCxIB6y1dKqK+IFRP4T41YZcKIXe+OGtP4+
fkqOWq4dKzhmTZ7CJrCn/Z7EbZ6ckiZW51kHiX1XUzqWYBw9MKdFrV28kP1mkgUl
SyqPGnXsUTT4Y7o5LWlVudj/jp6J8yCCEv3OzNhw69gAedCMBjYtgxVwaCjh7FLI
IKAwvX1JlKxEWMq1pEwi8ill6PsIARXErjfa7dD7vYZDyK0QeFKh7BdlePNurIUs
JXhptG9VMoWQOaqqx4j4Gto9xZ54dedYUCoWER/xF9839z2k7qAimi/qwPDi8ZIF
o1S97Nmug2MKyQ7IZKOyS0Y0KCQaCZIn8eZCQKpULgxJ8uQ7hsK9qBVQBQWaiCuX
xNsZUcxfCWKKhMPLPzbobhK67kvcc6vlIOKh4xyVDGb2P9Y/N3rHIBA/7RkBVEq1
4P0aYl4jf+GbJmb8BbhcqZkedy97pJCSiuuogL9NvduqDgsSNLU=
=kFnF
-----END PGP SIGNATURE-----

--UuL7nYrxJqzh21MR--

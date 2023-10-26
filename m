Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A024F18026
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 08:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PvVL8kIB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I8teNE5o"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83108CE
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 01:00:07 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id B0D6132009DE
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 04:00:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 26 Oct 2023 04:00:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698307206; x=1698393606; bh=uh
	H5iKgsPcwLOOGQOT2mmZFbMOOYKVxy+XwteZhupG0=; b=PvVL8kIBKNRJzrQG0Z
	vKhEk/9dxa3Ie2ql+RRYiHpsW4H2vDKRtkRCMtJyesu1Beu3mjU+at7b+xH4qB7u
	Hp4u9KSgbaXne/hUfC/ZDXQAHR6adrG24TGVE66Uirgkp+5IVAK1LKTJQg5dPeAJ
	eJkoog6AXt6CWtjZavkmYnIm++Fujh9tnBT/V03hAyzoTJO8XqNeldmqnBqhc7eq
	GFZyGD+olpIRKY2PBn6LIiJ+s+rDAmVWIsN16og9lZ+r6PDDyHGXd+/gp+rLLY58
	TpVsJyN6nJGujEI7hmtZxtnV2dANLazXnk5gi/8vRNdcv/L6cFfDfIl0E1u6loZl
	rf1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698307206; x=1698393606; bh=uhH5iKgsPcwLO
	OGQOT2mmZFbMOOYKVxy+XwteZhupG0=; b=I8teNE5oStMC8apP6O58Cd8CZdhcJ
	HE/kWgQoqCJRcDcYsTUtIGXedCMujEfPyPpwT26CJva8mFgFNT5Hi+ANV5aHxjgl
	xXPzrkGM5yptUAkgPjREN1jqxLVD3oRV0C/jCCG2Ky3SdVpu8JFm9GFucZo6rd+g
	NK9xO+CAKtKI7r/1X0UvaA7187dH7lGWR1jTFkYiICG+7SUDpWuIZSMeCW1jvN2p
	qvF5m1aMfiy2ezGxUv38FXN4/e2+adlBWPqbv675J7d/rmqhmRc54EdwXou+Mpqe
	1M8LPgM/GVnFndZdWgWetmdsKHnVZjfQf9VKVqeKK4G2wAsKzXrDJ9HUg==
X-ME-Sender: <xms:hhw6ZQl7_I2T57kthwoRsgXpWSxjgnvDhqD5m14vdXJlhxJbqi3SBg>
    <xme:hhw6Zf2UTM0bZr8J2Wi-sGLTgxFyYH2Tj2qXQNftUeuvUZFybfPWh7jZarmsYRhGW
    U4sX_UL4QzeuBX2qg>
X-ME-Received: <xmr:hhw6ZeoVE-47cHTKsoDUkd8ml8psloEx2kSeop3JFTA54bXGLLlW26JV_QkODvys_stJUWc2IvBdd3-W9zRhTt2lEM1C0zbwk3wjhoA-8cdQCmU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledugdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:hhw6Zcn8a-gpD-BnEGTL8OLYOq4q4J02ibDWqd9p_9Z3LVXIp_6T0w>
    <xmx:hhw6Ze37po63hKzsklGticra5Vd9CS2q3PdujtVy0KgdTnj5LmqTcA>
    <xmx:hhw6ZTvO0ggVSKsGhgk62aBoH9_hzuY82pFQdo0pX7xqkw1yQZUW9Q>
    <xmx:hhw6ZXiKvSL17YLm3m1pDmcWJCy05Ko2XT-7p5WY4lSd-cl5RAVoog>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 26 Oct 2023 04:00:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a75e2e27 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 26 Oct 2023 07:59:57 +0000 (UTC)
Date: Thu, 26 Oct 2023 10:00:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 1/5] ci: reorder definitions for grouping functions
Message-ID: <586a8d1003b6559177d238ceda2c6ef2f16cfb8d.1698305961.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+9KR4SRowJU5J0ea"
Content-Disposition: inline
In-Reply-To: <cover.1698305961.git.ps@pks.im>


--+9KR4SRowJU5J0ea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We define a set of grouping functions that are used to group together
output in our CI, where these groups then end up as collapsible sections
in the respective pipeline platform. The way these functions are defined
is not easily extensible though as we have an up front check for the CI
_not_ being GitLab Actions, where we define the non-stub logic in the
else branch.

Reorder the definitions such that we explicitly handle GitHub Actions.

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


--+9KR4SRowJU5J0ea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU6HIMACgkQVbJhu7ck
PpRIzQ//SB2SobFezbvVwskhhLBUwiza3Jf70U/Tje9MISx72xylZN/IFB4rTQi0
9/V82JeyNuYDbnxviip+K+keFQrebVP/SNjFbTOGag62WKY7f25jmh+Oc/LMa1YI
xKcqcV6IuIIQMFC5aOzBRy5iAB2ulFbzYoi+1vXmuo2O2CuYrM8LYEMuZHtL215c
4yOMKDtqmMJsF18xoAMtPv9E9NLc0DL2T9WVDlfJwUzBYFy6ADckzXzxDS6yXx5B
k74HXzFTJDCkNPRk4LEB7FWSxRNtcMtasWX69yjkvgxykyP/HOAcwLVHwLkeE2L5
eZdRzxbSo4z6Yl2fSSzgMwJpR5S2bKlFmM7XgaYDijTMqwG3FqsXtIXNvBwJaEyt
KgAhNNwWDuxtTiTVbHrgY11jiID2znqX4CEsvsA8xVLtxfOPF2K4FXUqR257KqaR
tkXIC539X7uiBlsJUItAmMLRVvDY/R3JzWJ0BXzUG2rLzCOt0J5QvHd/N0k1rtqO
+KBGKu8T1auQnjRZ7aMQdbz/BBnWYBnNQQUKiwJlM8dp7wXHppZiMDNUS3YNjDdb
elAXP5loYCEAs+92zSGv927Hu29h0kcJtG0EMn8MR+0O6kYBMrfcqKl9XZRS0j+d
uNHWUWNYO4BHAm8dMcelWWTGE80N9TwHx5sGCQ3/cZxzw26FjyI=
=Kmni
-----END PGP SIGNATURE-----

--+9KR4SRowJU5J0ea--

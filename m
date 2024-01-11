Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5533B18A
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 13:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BVDsdtGk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RGl71S6o"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 2D3BF3200A61
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 08:47:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 11 Jan 2024 08:47:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1704980851; x=1705067251; bh=N8Cqi4kXhnLnFApt0orR0Bpndf9onKtg
	jRI/pn5j0+c=; b=BVDsdtGk79ON2eYXGTReWUoHM8/27bjR4SWLJj3IzdOQRoao
	dCX2wxbtB66d1FL/0l36sGCPc9Tx28HCyhYmeBneXqebEx++vPuhHPiTsEBwJ4+M
	sIm3lJCy0iKOklb/Gfc6UYoysD8nFjg9twe+DyYb4J4eod5i5K/ggTvH0pE5xwhI
	Hug2yc63NWyVU8nD0ARwgCsL7kPpBmHL1YGGwuA+uUbi5nvvQtQeiXP+B2f251xa
	v575HZ5qNilGjbAfg4QBQ0iBlxaILqAWDyxwDWIgofFKZrzZg2VUl4IPal7b3Jwf
	LogM13bl0TuCwIwdpVSzob6t+GyRS8ZnMGXF8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1704980851; x=1705067251; bh=N8Cqi4kXhnLnFApt0orR0Bpndf9onKtgjRI
	/pn5j0+c=; b=RGl71S6oWOwGvqStwfdkWTWqoPBVbVV3SZ85CVHZB5IjosNJIRQ
	Kf1JA/M42ZYWBMIpXraKSq+QPt+Kr7xg9kqncFaOCvEXu/Jp+3w1TZrRV59NoFkA
	af3ppA+7S22KIVGoroQJsWeuyHDHNk5yvg2AeNSckBRxSjJ2mJWebFjfwEkvIRDn
	xuqkJNKTe5tqwmHmxiaeB+hUu+RqcmYjpvv5rFpx++t+unucqIzGS+R8VFLS5zGZ
	9tSuYWlS+Nbtv3NVcucLUgSu6wm3PD71tOe3zmJcNbwY3E3BqnP2nfHyurS/UeRd
	lNgSN4vtyip2MgR89bMyHyAvu4hLvvRUsEA==
X-ME-Sender: <xms:c_GfZeUtsBTMLtfWcWshfu78E7-l2VbZZythnNZImlAFwqeA2VwKww>
    <xme:c_GfZalkUUWVSoRwQOu8pZwJ0nWZu9r54aTqeaVlxDoQudswz871iIqL70uU0Wk_N
    7ZNPk-jCiMJi18H9A>
X-ME-Received: <xmr:c_GfZSYKRPUmDqGOEyoPutTZKF6Av_YxsjpM7StEO3-rNC6gPF3-JVdAilEoRQn4FLuYnKnxBCWvauYQV9LD6x5CiVvNlDZueMz5qySpbP_QJ0YDYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeifedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:c_GfZVXiASOUIzSL1xf0osIFknhKt8wj8LXHhjuWmm33Sw9zNnQneQ>
    <xmx:c_GfZYmAxTFsDjMvu1k2EnHZVlhWMi2MMea23q5mYyIvGCZwfPXjfg>
    <xmx:c_GfZadsxW_XJMNWQ8V-xTh4y1156B2Fhl22tkXowvLeXrMioG9ISQ>
    <xmx:c_GfZaQjNHAXgUEgTfbd4vN77chfrD9B3f1_nuS-cINgwGKsZxW6UQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 11 Jan 2024 08:47:30 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 60514627 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 11 Jan 2024 13:44:47 +0000 (UTC)
Date: Thu, 11 Jan 2024 14:47:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH] git-p4: stop reaching into the refdb
Message-ID: <33d6a062ec56be33ed50a42a420be0b023f6f4cf.1704980814.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+fk/5XKt6eF2GAmo"
Content-Disposition: inline


--+fk/5XKt6eF2GAmo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The git-p4 tool creates a bunch of temporary branches that share a
common prefix "refs/git-p4-tmp/". These branches get cleaned up via
git-update-ref(1) after the import has finished. Once done, we try to
manually remove the now supposedly-empty ".git/refs/git-p4-tmp/"
directory.

This last step can fail in case there still are any temporary branches
around that we failed to delete because `os.rmdir()` refuses to delete a
non-empty directory. It can thus be seen as kind of a sanity check to
verify that we really did delete all temporary branches. Another failure
mode though is when the directory didn't exist in the first place, which
can be the case when using an alternate ref backend like the upcoming
"reftable" backend.

Convert the code to instead use git-for-each-ref(1) to verify that there
are no more temporary branches around. This works alright with alternate
ref backends while retaining the sanity check that we really did prune
all temporary branches.

This is a modification in behaviour for the "files" backend because the
empty directory does not get deleted anymore. But arguably we should not
care about such implementation details of the ref backend anyway, and
this should not cause any user-visible change in behaviour.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git-p4.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 0eb3bb4c47..3ea1c405e5 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -4251,7 +4251,8 @@ def run(self, args):
         if self.tempBranches !=3D []:
             for branch in self.tempBranches:
                 read_pipe(["git", "update-ref", "-d", branch])
-            os.rmdir(os.path.join(os.environ.get("GIT_DIR", ".git"), self.=
tempBranchLocation))
+            if len(read_pipe(["git", "for-each-ref", self.tempBranchLocati=
on])) > 0:
+                   die("There are unexpected temporary branches")
=20
         # Create a symbolic ref p4/HEAD pointing to p4/<branch> to allow
         # a convenient shortcut refname "p4".
--=20
2.43.GIT


--+fk/5XKt6eF2GAmo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWf8WoACgkQVbJhu7ck
PpQeHxAAq9/tKswmDKsZ2PNgjxHjrFFX0nIB4exsKniaq4McNQ+htwO0KgVkDbQN
eea7p5FcjiZmd7godISvPAAlQWVccf9RGy5rTLAr+gekADfiAnZb6Yv1QSXmucSr
RUiX4qZzAs1m+vdsjB1ZRjEOr1LjFrmg4ezH7BrN/9az3sE+vBCjP2G5Me0lj0qk
Ch2n20jruufo9LgnAZz7a6WHSV6RP/nZO8dFT77c/CFCENdqwJ1gkyzIqAk9C5/L
Kf3v+c1IvYZMKOw20n/EqvqhVfXm3ko3KMyjwjZo6wyjOOw09V7Ekih9sCeQ0ViT
l5kA4l0PGtF/2odHet7YlDSaNtz9MdbbjuYw+nLKayC6q1f8Mpdx6Ug9C1pv+slz
6ipT4583E83iBSBYCg8yVByFbicRnns1ji0nWJTcXYgsyF1mWm1dFre7qw0JLbGR
TBZG3sD3o9vaSmroshFIDLTGMDttFokIkmlF79fHBb2/3epR94TWkItHIMU5dYAY
u8HLdFPs9/P/7CKoJJgKjFrNBb+561i6JtbjzdPPWlvA6nZEbStzvGRB5ZbVcxmn
HU7b7BayfsE7BU8NueKvdNEVNflZ3IcYjkqNqrOPXBWZuW9e2vfoPE87Ly2TeumD
paNnT6xVgvtjJbmT9NojwIeuS1H+U1rq0CFXu/q5k4jLTN/mf6g=
=Mqzw
-----END PGP SIGNATURE-----

--+fk/5XKt6eF2GAmo--

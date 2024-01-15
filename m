Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975C72C698
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 11:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TdD0fdEs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oarm5FsY"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id AD4E55C00DD
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 06:44:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 15 Jan 2024 06:44:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705319099; x=1705405499; bh=HxU7sdx17Z
	WXgdEvTFQh2ur8rZsvfgJoOjg9krhuAMU=; b=TdD0fdEsl9fz2x/8DZEocX0t27
	vV24L1Ag4exELBrh/u5m1nsIlVOvs5InVn2Rl6d7thr9/Kyqcd91kRyWvQEl+PQJ
	suBPXBVZV+42M0/S9QIVkGQ5V4vBZd8Bb8NzDdVddWWh1JCpwMgrxGucrLCMPURo
	0wiK0G1r1/0IVXXfeM3KBR5tNkvuGj21j9RRBPkhwz1zVpYonHDFESFpjn4o5CUn
	p0FUvnPm2V4Bvq/uiQ3cxRoqCNLxJvIU5P68ykQE47XNyghATxKwkpuPZRx7SdgW
	63oNakUeM4Vx/d79BlFBw7YFiY7UAC35vO3wejVlUKnTmhc4qNi88pG+AUtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705319099; x=1705405499; bh=HxU7sdx17ZWXgdEvTFQh2ur8rZsv
	fgJoOjg9krhuAMU=; b=Oarm5FsYnQQyADmS9qGNNGXdsAFr2S5kjSidK9d3gajO
	wtaCrLBzvE3KO2tuPBVTr7STDbGG/f5Fdum7DFdK7VFBnSCxPdCQsPs1QxR1p0VL
	Xd75lvLAMfvzu6UJnvYjFuFOoLEWFDgGOUriHm6m/iuTWDDuzYy15rzgoKZWELfG
	j2zuXaTOWLFH2wM8HXyFllX+u2Vo8KPacVGg8cqxWfkcwsyRDz3SzuqettnBSmqd
	JscCgxmKCXCytBRPWJ4/fn2OTQOd/mNuOGjisOveBUSpHC8/O6wU5SYclFdNd3ud
	7J68eTlP8N11lXuelPEcqVFYVZvFTK4N67uHChiXDA==
X-ME-Sender: <xms:uxqlZRRxMQJ2fwYaL9m0SpB4y8tLGWCzSD5LlgHaaQR7diLvWSWZGw>
    <xme:uxqlZaw5CzmDInO4p2VJyttENoRREyTfAzUO-IRItlWhkxCSG1gulkAvvaADgD2Lp
    PpPLjBiXJxdgHcfjw>
X-ME-Received: <xmr:uxqlZW1uiKnGqsc1Kb-dPO4zVlciKCQ9yrIRaV1jYIHKV_YU_3ks8sqHJIb87_QYHI05TDGoi-odeV5vfRqVMBloadYknGaD-lDY1KeNDVc_Dg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejuddgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:uxqlZZBerFlGKDDn0AJMATjy3D8YtUJecSpk6V4wOY-pgcdrDyqVdA>
    <xmx:uxqlZahnXVSCL7y1FYfIWe3rJx81Br-TzvjAn8SOPck2NsnJPmVAdg>
    <xmx:uxqlZdqurJYII9vMpUP4vRgA-FMtfNLN5GXVixeS8vxqDOcAJ4f8Hg>
    <xmx:uxqlZQd25OyWQun3JseCfHAr9G4a6tofH9sSa86KG82xv_ZKzGQeng>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 15 Jan 2024 06:44:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a9e09227 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 15 Jan 2024 11:42:08 +0000 (UTC)
Date: Mon, 15 Jan 2024 12:44:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 1/3] ci: make p4 setup on macOS more robust
Message-ID: <a5d725bea7b2cc2b8f66682920dbba016e89da9e.1705318985.git.ps@pks.im>
References: <cover.1705318985.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XWHvA9MJg4jQoHRN"
Content-Disposition: inline
In-Reply-To: <cover.1705318985.git.ps@pks.im>


--XWHvA9MJg4jQoHRN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When setting up Perforce on macOS we put both `p4` and `p4d` into
"$HOME/bin". On GitHub CI this directory is indeed contained in the PATH
environment variable and thus there is no need for additional setup than
to put the binaries there. But GitLab CI does not do this, and thus our
Perforce-based tests would be skipped there even though we download the
binaries.

Refactor the setup code to become more robust by downloading binaries
into a separate directory which we then manually append to our PATH.
This matches what we do on Linux-based jobs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/install-dependencies.sh | 10 ++++------
 ci/lib.sh                  |  3 +++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 4f407530d3..b4e22de3cb 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -37,15 +37,13 @@ macos-*)
 	test -z "$BREW_INSTALL_PACKAGES" ||
 	brew install $BREW_INSTALL_PACKAGES
 	brew link --force gettext
-	mkdir -p $HOME/bin
-	(
-		cd $HOME/bin
+
+	mkdir -p "$P4_PATH"
+	pushd "$P4_PATH"
 		wget -q "$P4WHENCE/bin.macosx1015x86_64/helix-core-server.tgz" &&
 		tar -xf helix-core-server.tgz &&
 		sudo xattr -d com.apple.quarantine p4 p4d 2>/dev/null || true
-	)
-	PATH=3D"$PATH:${HOME}/bin"
-	export PATH
+	popd
=20
 	if test -n "$CC_PACKAGE"
 	then
diff --git a/ci/lib.sh b/ci/lib.sh
index c749b21366..f631206a44 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -344,6 +344,9 @@ macos-*)
 	then
 		MAKEFLAGS=3D"$MAKEFLAGS APPLE_COMMON_CRYPTO_SHA1=3DYes"
 	fi
+
+	P4_PATH=3D"$HOME/custom/p4"
+	export PATH=3D"$P4_PATH:$PATH"
 	;;
 esac
=20
--=20
2.43.GIT


--XWHvA9MJg4jQoHRN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWlGrgACgkQVbJhu7ck
PpTFyQ/8C4k3RvgHhc1839Lw+klGcf3MIcHgdh6dTaecZsgQ+tV9Dbmzs/RUijDg
/4TzOpmC8MTKW2ZVo7POWrXEfnnoHmvLr7E7xYv2rpE+xvGoxexPVH90Bnl8G9bE
Yx1Z7i5ti+gp4cnyjKIk6VpwjNr0Fz34eMBvmPYr0PG2EPeO3Kh/eIXkbA/FxIZo
6cBTT2PmIZmRHMViKOehDJG+dCALUj8HfDQoXT+PIO6/hVM/zqkTFJgpa0aGyIdi
urXaLbdQCR/HET/p3yXWT0SLt5NcDFI15OTSly4BJFYCkYqwB/y93qeNUraONHlc
xYofj4LJmeuaAmR6gQAMgONVLZl3YgiVykc8sd1pf16wfSUYSA0gX/A0YZvF5USO
1siz7alD5ybgErDT0Gih1Tt9op2su0cPrO4NT7RV8hDstoe4t3md4S8SD2im0AQ7
b3lG5FEYntkR5dt6g8DcfAHwrAgC1wz9QpUOi9jSLaN8fXDIc2nHh/e71uFj/ZRT
l+1wvTyCh9OZPN8wZ2FiinjlD7LG7br0zjPVzePcsErcgv62dWiLH3TQVkn2WiZA
Bvh9knt7gddMSh+GUQ/StzD8YejF7geNf0BT8IEg/47u6vEQ1tttIX+cNn16W6YX
MH84jkMI2t3EW2jIA2nwhMYHppWuxz80GqDkmJubi3jGsdG6OAc=
=aE4x
-----END PGP SIGNATURE-----

--XWHvA9MJg4jQoHRN--

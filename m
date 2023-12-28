Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF446FBA
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 11:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Joz3D/i0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I7BhnLLM"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 4EECB5C0061;
	Thu, 28 Dec 2023 06:02:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 28 Dec 2023 06:02:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1703761375; x=1703847775; bh=rVbjiCk9CxPW0OXnbeslZAfP4HKdZG6p
	Hxu/27LPnSc=; b=Joz3D/i0MgmXi052wOjnZn52Qu/5khmZx3Cbn1hEwQLqHg+p
	UkVLkGREmUmJK5fZsqwhP5MgXLBrNPihjK+mY2jUm4IoIJGEO8M7UEdZHtiacJhj
	/4vVeYUR0cDLD6RUvAY47fcQDSnNPes42mS+lG/PaXoP5tsvbDH/VA4rrEq8HVdy
	xoWJ4S3PwcDP3LFcQwceZnifSsIRXsH1c4RZNMSy76hj2MlaTOiV3GDUi/YjiiIL
	0bPkTtYB0+gVE/vRqez7Z2DXdmzmjjQboCgn0zEYeZhpcIZMC0HjbudyzPB4/rGq
	X0DLJqhfBK2VDHub8jMLv+NWS1Re5Oynd8uTFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1703761375; x=1703847775; bh=rVbjiCk9CxPW0OXnbeslZAfP4HKdZG6pHxu
	/27LPnSc=; b=I7BhnLLMnXLbxO0Dj1jTq6wak4ASPDGDkK3m1mxG2S2VwoI6Laa
	JGIXik241lu9NrIOPePYf3IsKzBLrDu+MZIv2OWNHfexLQvP7vOKicQ2/Ba4c4HZ
	jxTJ+prcOyRAzcIA9F2/V5BRiaWUB+nqrHJoLmVPeKsha1bdC1ufm+W+t88bo+Zn
	MU7ma2TBtWJhJjavcEI3d+0UiRAUSSE6IhQ/2qW+df9S2WdOlw3dV0Ynp37ZtA4r
	ixhsqqRtQdeUESXln5hR8vzJboOU8EnH0R5mTRlLdgQXBiC+nu/xlWgSXjP++SBP
	MmRERiQgOO3SNiGRevNhWfVIrmQNH6musrA==
X-ME-Sender: <xms:31WNZZVDrdChQIwC_UNDF7ZUxmSglpEUBS-DmWgmvO6bB2mevOQWGQ>
    <xme:31WNZZnAz09lVtplHSkD1gQDF3iKsSQEbbx3mRY1YcYd5yYuLDttoAiM1PaPo01qa
    dIhOFp4WAsK6TdRBg>
X-ME-Received: <xmr:31WNZVbP6tSN9RGBHyCT43lyf_KZuFWy7bWSnob-ozCsvOpqSekBDOSUkrTxRgnHM5nAO5BpZDzLq1wI3Q-7rBm7O30owLWG-g6lA66Wda-4jg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefuddgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfggtggusehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevhfehgeehveejfeejfeekjeejffeivefgtd
    etfeegvdefjeevieejledtgfejueenucffohhmrghinhepghhithhlrggsrdgtohhmpdhs
    hhdqrdgtihenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:31WNZcX3bJq-iiMtMY6bSlwz0k3Ztv4Wruvy-oltQqDvqTHUDLpXBQ>
    <xmx:31WNZTlB4CKNvPiI5nq0J7xTp_-0GfSrTqTcjPEiZj0Sto0E8XcJfw>
    <xmx:31WNZZeXh2N09LMyBtn2SbUn16_83mqjEO3o4KibRw5ccaawQwcNcg>
    <xmx:31WNZStBxtI0mR8FlpHDNb5Hye-V7QO_s9tEGCjB1gaWOj1WeQ316A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 06:02:54 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e31722f2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Dec 2023 11:00:38 +0000 (UTC)
Date: Thu, 28 Dec 2023 12:02:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] ci: add job performing static analysis on GitLab CI
Message-ID: <1536a5ef07ad24dafb5d685b40099882f89e6cc5.1703761005.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kkk/tqsIVYjE5Xth"
Content-Disposition: inline


--kkk/tqsIVYjE5Xth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Our GitHub Workflows definitions have a static analysis job that
runs the following tasks:

  - Coccinelle to check for suggested refactorings.

  - `make hdr-check` to check for missing includes or forward
    declarations in our header files.

  - `make check-pot` to check our translations for issues.

  - `./ci/check-directional-formatting.bash` to check whether our
    sources contain any Unicode directional formatting code points.

Add an equivalent job to our GitLab CI definitions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

This addition is inspired by my reftable patch series where I forgot to
add a "hash-ll.h" include. This would've been catched by our GitLab CI
pipeline if we already had the static-analysis job added in this patch.

These changes are part of [1], which thus also contains an example
pipeline run.

[1]: https://gitlab.com/gitlab-org/git/-/merge_requests/79

 .gitlab-ci.yml                    | 10 ++++++++++
 ci/install-docker-dependencies.sh |  7 ++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index cd98bcb18a..793243421c 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -51,3 +51,13 @@ test:
     paths:
       - t/failed-test-artifacts
     when: on_failure
+
+static-analysis:
+  image: ubuntu:22.04
+  variables:
+    jobname: StaticAnalysis
+  before_script:
+    - ./ci/install-docker-dependencies.sh
+  script:
+    - ./ci/run-static-analysis.sh
+    - ./ci/check-directional-formatting.bash
diff --git a/ci/install-docker-dependencies.sh b/ci/install-docker-dependen=
cies.sh
index 48c43f0f90..eb2c9e1eca 100755
--- a/ci/install-docker-dependencies.sh
+++ b/ci/install-docker-dependencies.sh
@@ -21,7 +21,7 @@ linux-musl)
 		apache2 apache2-http2 apache2-proxy apache2-ssl apache2-webdav apr-util-=
dbd_sqlite3 \
 		bash cvs gnupg perl-cgi perl-dbd-sqlite >/dev/null
 	;;
-linux-*)
+linux-*|StaticAnalysis)
 	# Required so that apt doesn't wait for user input on certain packages.
 	export DEBIAN_FRONTEND=3Dnoninteractive
=20
@@ -31,6 +31,11 @@ linux-*)
 		perl-modules liberror-perl libauthen-sasl-perl libemail-valid-perl \
 		libdbd-sqlite3-perl libio-socket-ssl-perl libnet-smtp-ssl-perl ${CC_PACK=
AGE:-${CC:-gcc}} \
 		apache2 cvs cvsps gnupg libcgi-pm-perl subversion
+
+	if test "$jobname" =3D StaticAnalysis
+	then
+		apt install -q -y coccinelle
+	fi
 	;;
 pedantic)
 	dnf -yq update >/dev/null &&
--=20
2.43.GIT


--kkk/tqsIVYjE5Xth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNVdkACgkQVbJhu7ck
PpQ6pRAAmVm6bpLdV28hIpFEJE6aB8sv9EI+855nCZZdS2YkgqSDi8adjVYzQJDd
CvkETo0y+uSGYM1TFWrl7MwyaE2vXbZM7J4vkpj+ndzYoHDsGEK1YnDIFe4/rVtd
NgdFOprMsIC8G90HLrs7yaXabpcuzYLnxrUhdXUqUxr/Zgr7b7lLCENIJYOtRnbz
XRD+Ev+H6/TyPBkY6JZU+TBQ8p0cE3fR9u6kDVUgG6v/3lMJ/a9Iw/EeGetz0TdP
b9vx/4zvXluGpRGfd9OWZ7DV8RhUpLZVjkWtRzqxOAqegheyulEkYNK11uerx5it
Ogb3C2Kd/K8u3sIFxSFVADouUnhnpf5KkKub37SG8OZe46ZYh1llKXDHA3QZ417P
i0glgA4IL2ZR2N5gOBMpJfqrsybPpCbzr1zlTyyrUfEl/pA1cc8oXilwBU08vz9m
Vg5Ru5rR4jYb8B/QddrRtutK3vYaLZSG4ptAZ4TC9Yl6kIGYB5yllGQrn044yoYS
n4cLuKASuGxLcoaFb4kb0TFKdDmpY8PcAXIMNPTSHqNni8o9y1GCyFkddD6knpNL
0KSXl2GmyPuvQPbXS9GS5+JCbB2pMRLps3rFxkREt++7Gs4MBp5mYoamze4Ss16+
FIePBY6/zTmX0wDyRUXqlWpAXvugKqNtdqQBLMXVs3xRokX3lC0=
=L8i8
-----END PGP SIGNATURE-----

--kkk/tqsIVYjE5Xth--

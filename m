Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6268916418
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 12:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BjU9NW+d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vkRklL3P"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23877CC
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 05:15:14 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 540A632009CB;
	Mon, 30 Oct 2023 08:15:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 30 Oct 2023 08:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698668112; x=1698754512; bh=VX
	nvvvveis5W2s+nZGJGYW822Jn/Yd7Qf9yJtrJgWAM=; b=BjU9NW+dAM7iZ4KH+8
	QJrQDQvpGyIgZsv5nA95OjrYXm0GzBQiVjwagZSajPWLvXvRXve4fAzp07e7i3e0
	SFDaGLN9oPw2g2GK3KzzwKBeI11nEnInpGmc0UCT8zVDEQjKjv70ry52uzV8N8aa
	pFAwmOLgMBc3kw5nvkh2/85VYDsFmo/H+9vosznKVGrn/2ZtWpR6n7X/208Qum7n
	MLMlCctlup0rvt9wPIjGx6hcyt4g40an6h5IvtHuspXOUNMbX5EeRvWY+lUd97c5
	YPbfuMCYwz6Z+WyQE7J285vzUOGt+0FjnVLf/i932Sg3OySxGhIHYXthc93t1O+U
	ix1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698668112; x=1698754512; bh=VXnvvvveis5W2
	s+nZGJGYW822Jn/Yd7Qf9yJtrJgWAM=; b=vkRklL3P+DlH2iHM0AAi7S6HqOPZR
	hl11xa8D8ffjqajtvg9Puoeg6HTUPQLDvOgZmRqqim/ZZuDKWISLU0RmP/HRBzdx
	AaX5Mjjl0ea1L3qtnYmZzDWT2Paq6aPXWdcnd51bmUHKUAqsiWMZvUz3Z6of5Aky
	nKbvtb3yQre+X8btrfPFpUP5IUsa2a7KTM6+pvRCmsV6ibUBDEUERrA4CuUeHzIi
	goKB5AUGFfawxKPfX+DbGu6NAvndBtN7pNDtPVSqI5DDcLl14ScP54TM9Ftb77SJ
	Ig0xseIdaLUytiqKtDHcEGkmiCvQVaZ0uEBoYL7Ey5oEeRm4R6poA0bTg==
X-ME-Sender: <xms:UJ4_ZS1lrNehEO9uzCWG16cmpghtJCVwgvNo06nzoCkyiMZqqLnt7g>
    <xme:UJ4_ZVGev0pC18jF1cNpVWuMUGHgBDd2RkRuOlH5fNDafdTOLVf65DfMIWsF-KaTZ
    8cHVaCmKZcAYsH0Ug>
X-ME-Received: <xmr:UJ4_Za6G3yOEHFeJSO8g5UNnTCVbLlL5rxQbN0iCb9i5yEApHth9OE0jqwz9J7E1G5sQd20XwBfBFQoTTOJ_g0Y7DkzYYRAZ8texzdKdPPK4QQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddttddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepvdehteeggfevueevhedtleelveeigfefieduiefgvdfffeegvdeitefgteevveeu
    necuffhomhgrihhnpehhthhtphgurdhshhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:UJ4_ZT0YeGqTqn-CsJ9K66frGm3c0wNyc_bxgocg8CHhYKhwJibdWg>
    <xmx:UJ4_ZVHkaLUX_iJI_zOL5xH9agKq16PYdPY3RwnM0hQgGchufrm32g>
    <xmx:UJ4_Zc-YXLRMElMJFF4g8FLSueXWWvr349VVrE-Vw-BUjqwFmKOFfQ>
    <xmx:UJ4_ZaTK05MVxNRJ2gw3XxTBDOAQqv_2enWxo30QenRiJs5ULi-tdA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Oct 2023 08:15:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4c0cca15 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Oct 2023 12:15:06 +0000 (UTC)
Date: Mon, 30 Oct 2023 13:15:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH v3 7/8] ci: install test dependencies for linux-musl
Message-ID: <f150d61a1ceec5dd6cf370c3f4421a3e2d9f11a3.1698667545.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698667545.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Nn4yPsPDJghkIUpR"
Content-Disposition: inline
In-Reply-To: <cover.1698667545.git.ps@pks.im>


--Nn4yPsPDJghkIUpR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The linux-musl CI job executes tests on Alpine Linux, which is based on
musl libc instead of glibc. We're missing some test dependencies though,
which causes us to skip a subset of tests.

Install these test dependencies to increase our test coverage on this
platform. There are still some missing test dependecies, but these do
not have a corresponding package in the Alpine repositories:

    - p4 and p4d, both parts of the Perforce version control system.

    - cvsps, which generates patch sets for CVS.

    - Subversion and the SVN::Core Perl library, the latter of which is
      not available in the Alpine repositories. While the tool itself is
      available, all Subversion-related tests are skipped without the
      SVN::Core Perl library anyway.

Furthermore, in order to make the Apache-based tests work, this commit
also adds the Alpine-specific modules path of it to the list of known
paths.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/install-docker-dependencies.sh | 3 ++-
 t/lib-httpd.sh                    | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/ci/install-docker-dependencies.sh b/ci/install-docker-dependen=
cies.sh
index d0bc19d3bb3..05dde5c5d40 100755
--- a/ci/install-docker-dependencies.sh
+++ b/ci/install-docker-dependencies.sh
@@ -17,7 +17,8 @@ linux32)
 	;;
 linux-musl)
 	apk add --update build-base curl-dev openssl-dev expat-dev gettext \
-		pcre2-dev python3 musl-libintl perl-utils ncurses >/dev/null
+		pcre2-dev python3 musl-libintl perl-utils ncurses \
+		apache2 bash cvs gnupg perl-cgi perl-dbd-sqlite >/dev/null
 	;;
 pedantic)
 	dnf -yq update >/dev/null &&
diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 2fb1b2ae561..9791f94b16f 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -67,7 +67,8 @@ for DEFAULT_HTTPD_MODULE_PATH in '/usr/libexec/apache2' \
 				 '/usr/lib/apache2/modules' \
 				 '/usr/lib64/httpd/modules' \
 				 '/usr/lib/httpd/modules' \
-				 '/usr/libexec/httpd'
+				 '/usr/libexec/httpd' \
+				 '/usr/lib/apache2'
 do
 	if test -d "$DEFAULT_HTTPD_MODULE_PATH"
 	then
--=20
2.42.0


--Nn4yPsPDJghkIUpR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU/nk0ACgkQVbJhu7ck
PpSP6Q//cltiB/6eo//tGqS3M+A2ApwPJnKCBq/cTtSJ1XXvbOcUS/DvfTJqz8Qx
lPyzrnFFCYn0B5hG+yv0JSz5h6gnMcMfxkfBm3NKBt17s5PVXehMwlNbRTAJ5Lrf
izJUy1TMLkjDRvkZBXybSZzvxbQ1uYJbYQrWqQgzgHLv4z8FOIXB3nXnROt5obsx
/QjTNulS9d9xF9b+v19CVE4ILiTkOjJUwgNnqDjYP5OUX3eRuR2+I8UZFRWlaIy9
NA31fn3Mr1Qwg6CmRMbxIesmPZSoXRyAqOb11KYnHVx+gmR8a2Fw0sy0kXZ/5yV4
MNeffefSIRSzi1QuV29Z/50Me1akhrqO6voEzQMAQ3zTKCoS5MKS2iDHmCp7XOqH
Ob/yJcOHGnyh/Q+pvJui6aWv7+yjF1INsoWdv9aqs1DBAgv7v7fbGdIJNXC0g58I
UVavtgc/WgVgr7NwqX4lL2fM7NivWZfhc99dtySbZKoA6rzuQDGsAVLsfXDWAOk8
yRFWGmMr06EVhCdudyBsc7rpghZcr8neisaWyfCIe06KAz6ZNAD6MoTRmVSJtPgC
gAIbOStKd4vyW9ayCqVuRq/ta1R6nvKcyRatUF8wOhA2HAVHqJhrZqyRN3tpQ83J
upXM3iMgKgM/NUQNooc4NnwlGQxs47lS280Rs9/73c5q8lTzrt0=
=WJ/O
-----END PGP SIGNATURE-----

--Nn4yPsPDJghkIUpR--

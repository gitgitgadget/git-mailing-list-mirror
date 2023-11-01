Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADF4134B4
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 13:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uyYlzwUn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vJxRei8N"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57696102
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 06:03:13 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id C48FE5C01B9;
	Wed,  1 Nov 2023 09:03:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 01 Nov 2023 09:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698843792; x=1698930192; bh=DM
	DBDZgDDCqa6rBpvIOR21fsjffbC/YoZpfGHuO8kCY=; b=uyYlzwUnvIaqGt3dD8
	WZMq3nCFYLTQRBP14+tlgRAvwqf6fzmGcuS6Sc0T7dtkLxIwFwKzrpufx3/5y4oV
	d5FBMp1P3JbUqUaTRFtwdsUf2JqK9ucwaLhkEH7B+qqmglUaJAbaikUnmkCNi/5t
	TVyMDAX56dXL6X/0fFVlHr9XeNJi1w1InEVB8TgDmqXvYwwl9COvLAOJRX9zlId+
	mTBvLNKhCagKwcrUO8a5dtRjZ9lh6jNzRQ1vm3purSf9fsNTneVbvBKkToxPRK0g
	wU4UnKZXvMOkzfF6cMvto7GSlsrh+kLctRo4Vd4mgCJ16OdZUVZvv8fXUsEpmH58
	YeDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698843792; x=1698930192; bh=DMDBDZgDDCqa6
	rBpvIOR21fsjffbC/YoZpfGHuO8kCY=; b=vJxRei8NE+kOdNb603zDzVJ/bv4tf
	4U5aTk7HnZBzzb8bZ8627Iikv4++3IoZ2mjJXoP2uEaCdMv63cQTTgAIf0aNggrl
	SAH97s3fEDA7q2nvca4AsUOPdWaXK8YLEqy50poWl6g6Zdg4iPhTaXjo3ZB/FjnY
	JgCAezdrfh1dD/a+IwXvz0vtEXtWeaN8rKjydh5kXV55/8h7Lo3NwVGQUfTFi9KS
	q69BJSk3xioweeIcxJB5ZjBb41i3ppPK65eLmuPTAvJs5S9gEptA6GB8gthHQUXI
	3fjfZwR2EW4wgfS/MxGhjsIVxhFwqCRv1rB/tHmIL5R7ZcFV5dUFH5HsA==
X-ME-Sender: <xms:kExCZQMg7HlPwa_sJVqaEYxfkCOmrDOjIHNjFvdwEjWvjd_2WzhTkQ>
    <xme:kExCZW9vBnNRTGYYfspLbAohli6d85kGPXiYvx7fxTJWaRn9FLG0gtvhg5YXT3ZhQ
    X7uYrGjOug3naVKng>
X-ME-Received: <xmr:kExCZXSEj7XFTaeMAMKgiFGsp0vcJa9W8by7o06VSmqea46TvPLyRtLdtusFRbpCE7UkMWJyCm2oSFbvsiE2TT9qc6sKsgNtYTo-qj_SiArorw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepjeetfeelieettdelfeeuudfhgefhhfevudevgeduueduvdetvdetgefhtdfhgeev
    necuffhomhgrihhnpegrlhhpihhnvghlihhnuhigrdhorhhgpdhhthhtphgurdhshhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhk
    shdrihhm
X-ME-Proxy: <xmx:kExCZYsJ7zYC7SBq2dtiOe5w8jlLY4rvoO1vAWKLZtUX-WYTuXG5NQ>
    <xmx:kExCZYe2wbiil5zbgH3Ly-ulYM1gkQHOwLHrm_w2Mi8CTyWq-da_kA>
    <xmx:kExCZc2d0otTu0Bk9KdjcGHHtWPt-vugh6TLu3pq380RN4ak8oSrXw>
    <xmx:kExCZX4JeY1_KuapMLdrA5if5b68iWc4B0bp-7UyKJqDIyHiTmYTfw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Nov 2023 09:03:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 093af6dd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Nov 2023 13:03:00 +0000 (UTC)
Date: Wed, 1 Nov 2023 14:03:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Victoria Dye <vdye@github.com>
Subject: [PATCH v5 7/8] ci: install test dependencies for linux-musl
Message-ID: <b911c005bae115f79bacebff8e5f5f2d534551b8.1698843660.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698843660.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eZV5ekMN8jH4xANR"
Content-Disposition: inline
In-Reply-To: <cover.1698843660.git.ps@pks.im>


--eZV5ekMN8jH4xANR
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

The Apache2-based tests require a bit more care though. For one, the
module path is different on Alpine Linux, which requires us to add it to
the list of known module paths to detect it. But second, the WebDAV
module on Alpine Linux is broken because it does not bundle the default
database backend [1]. We thus need to skip the WebDAV-based tests on
Alpine Linux for now.

[1]: https://gitlab.alpinelinux.org/alpine/aports/-/issues/13112

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/install-docker-dependencies.sh |  4 +++-
 t/lib-httpd.sh                    | 17 ++++++++++++++++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/ci/install-docker-dependencies.sh b/ci/install-docker-dependen=
cies.sh
index d0bc19d3bb3..6e845283680 100755
--- a/ci/install-docker-dependencies.sh
+++ b/ci/install-docker-dependencies.sh
@@ -17,7 +17,9 @@ linux32)
 	;;
 linux-musl)
 	apk add --update build-base curl-dev openssl-dev expat-dev gettext \
-		pcre2-dev python3 musl-libintl perl-utils ncurses >/dev/null
+		pcre2-dev python3 musl-libintl perl-utils ncurses \
+		apache2 apache2-http2 apache2-proxy apache2-ssl apache2-webdav apr-util-=
dbd_sqlite3 \
+		bash cvs gnupg perl-cgi perl-dbd-sqlite >/dev/null
 	;;
 pedantic)
 	dnf -yq update >/dev/null &&
diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 2fb1b2ae561..9ea74927c40 100644
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
@@ -127,6 +128,20 @@ else
 		"Could not identify web server at '$LIB_HTTPD_PATH'"
 fi
=20
+if test -n "$LIB_HTTPD_DAV" && test -f /etc/os-release
+then
+	case "$(grep "^ID=3D" /etc/os-release | cut -d=3D -f2-)" in
+	alpine)
+		# The WebDAV module in Alpine Linux is broken at least up to
+		# Alpine v3.16 as the default DBM driver is missing.
+		#
+		# https://gitlab.alpinelinux.org/alpine/aports/-/issues/13112
+		test_skip_or_die GIT_TEST_HTTPD \
+			"Apache WebDAV module does not have default DBM backend driver"
+		;;
+	esac
+fi
+
 install_script () {
 	write_script "$HTTPD_ROOT_PATH/$1" <"$TEST_PATH/$1"
 }
--=20
2.42.0


--eZV5ekMN8jH4xANR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVCTIwACgkQVbJhu7ck
PpTNqg/9Fq1PEBmazh3Qj9Z2U9Cg8R2jeocQ6Y0F5+oNAdlRjcwlzNm/an4ty0aC
hosmf/S2CeIpIVg7cNE0E7o2KlsjJVCHg4gT3TfNgF0JEKumRZKYApfuJuCUO132
sCjIZsdfl17lt4b8ja+4cGwz+kbPChgsnrB5Ihh20i8n+dYyjWjPE9TWohZ1APil
OXVPoRuyB0OOHy9ZojdqPHYMYeWYc8ZP74W4u60tIlHdxPGAUCCKTdXRQ8TU6K1F
HRHqibJkHfIi4zrF30UPMa/VsbXAM/xV//c+1jaMEWqdpMIAN0lOFedmEn8KwQh7
ef9wK2UJk+drf+bzVe/g3Qf/NjTRN6c6b+LzRkOGTAh0XrNysTanPRPN+rh3kFGF
INine3AbXC4XSb767e01/TFaYqbW9unI01MtCzWqdT7xZ04ng/qYaNxL1VdX4zsD
dWQZvZCQcpYXVPC4is5pXUfsCmtQACZRCrmhsSAIDna9yo8DBMbAJm3Z/1WRqdyD
2ZUMa9AwFJKFLLaxwWarVQ8COysgMmyxbbCe+UTi6pQEFOUdcLxHsvotnREGahND
Z83cDnMP4qFMsEY7oBDtGhBLvmNnVH6cJHROt7fSdHbDgpXTob6EDZqCUaUlhWut
AucaGML/Vf5C24V25TW0qKkQ8xpy4nRw7keRxvDNmVmfYF8yWi0=
=paDB
-----END PGP SIGNATURE-----

--eZV5ekMN8jH4xANR--

Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92E710944
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 08:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nYE9yCI5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XBut+9WN"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BEC2D4D
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 00:05:54 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id BA9EA5C00AF;
	Thu,  9 Nov 2023 03:05:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 09 Nov 2023 03:05:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699517153; x=1699603553; bh=lz
	ZZXSm/gQ8VDLhRg6NUEbaADV5iKAKQi0yaiznDr14=; b=nYE9yCI5crakBn3UmA
	uSJbnVFGGnjT2cNfAxA+Vi85EzrLTvwt6d+h5eWfnOhBGQiGbpYpZMX6akykCZYO
	OdEEBq63LHoaIxF/xesA8TBobXtn3uLeC9+U4TLUPcOI+X9mt35Ed8ymSTRNaE0m
	xAfWY3fnq/tS+fzjR7Ls/cusOuo2iyXPu4sxvRX63kQLFqf2u5oMG9nhxvUK3li5
	kU3IiW7SFgPQ+h/rAzqrF+ogpIenxR6nDlODu5ymC8D0gCKgcnfxajtTOxepqLEC
	gBFUZeNmG2OqxavTTgHvNo+bfpVcef2duIXIlXHLnfPhi+7I0ks+SbR7d9r5tA+z
	pgiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699517153; x=1699603553; bh=lzZZXSm/gQ8VD
	LhRg6NUEbaADV5iKAKQi0yaiznDr14=; b=XBut+9WNFw6b1OsT3txiEgZeyR8Wm
	T/eqTr/FH2Oj58xd0ieJGBX51Mxmy06ZghjwjRfnBaYbT/Qeul3Nn0eFX4ILh7ln
	TwgTnzIZJvSNlCH3rkSQyCREYi2XTjSalQ+q14BQfbVOWngJwunBKbNN2h+ehKZu
	cNTi3s7aOzndLXKpul24D2SoZOWMwRsU/umuIrseeYdmtm3I249W1LImcmzBex14
	27a3iKHXKfe6yz068nNaDb+Ep1YAOCBxm7+IjL/RP2fYU+XCGbRfiWnBtYT20EUA
	80e7LomnJknMjayQ3xYhqEo+7x0XCLAuZUfGWCGNjkWWBLOT7lz1hJxHg==
X-ME-Sender: <xms:4ZJMZXDME6LdmDbIMnoWpIQDxa7L5HK0iafkvjZ7ZvawAiuhiulifA>
    <xme:4ZJMZdjHUKvv11tCb8CiygVSlphfMiSDGWdLzUyRlPH-lTmxSlWZWFuZCwoN-m3sn
    F3aW3w0NzaPggDCew>
X-ME-Received: <xmr:4ZJMZSl_cQeeX-XXki5yEpiiY2FjeDTf_2lhHEJLCN52eT2oXEojqKLNrBYwVd6jMPm9iRHEdRsHrdVKFkAaQzQF5DyrQP9AU24zAQMAGGlWWYEP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvtddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeejteefleeitedtleefueduhfeghffhveduveegudeuuddvtedvteeghfdthfeg
    veenucffohhmrghinheprghlphhinhgvlhhinhhugidrohhrghdphhhtthhpugdrshhhne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehp
    khhsrdhimh
X-ME-Proxy: <xmx:4ZJMZZxmQTATUJcNCwkuhNAa9wY3X85RUIzJeihCsyUvrFbl8z60HA>
    <xmx:4ZJMZcScHGpC96I0Mf4s_uOj2MV8bhxCbip1YW4DMnq9CUPObctWcw>
    <xmx:4ZJMZcZzneBCIDZ9cIMNLAWt9J3yWMuvp9XLHBmlwqFy1_QIbSzDlA>
    <xmx:4ZJMZRLVmut5Ygy-_LAg3Bpz_O_6mI0ytDsbDt0yRynkzeuycqvYdw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Nov 2023 03:05:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 878a6abb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Nov 2023 08:05:25 +0000 (UTC)
Date: Thu, 9 Nov 2023 09:05:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Victoria Dye <vdye@github.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 7/8] ci: install test dependencies for linux-musl
Message-ID: <a060613f039f580206d59f0d42d8004350c1439e.1699514143.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1699514143.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ph4DJCTZypElz0x7"
Content-Disposition: inline
In-Reply-To: <cover.1699514143.git.ps@pks.im>


--Ph4DJCTZypElz0x7
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
index 5fe3c8ab69d..dbc99775934 100644
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


--Ph4DJCTZypElz0x7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVMkt0ACgkQVbJhu7ck
PpR3iA//a4tbLRJTeB0TEvUc2QD3H/zKpvY1ll1sRIgR6ng8oaxtPTr6wjEusRbh
wahQQig3A5Mmf9hWn5tiYMlMlvcHQsFYXYLwEj6ACfUIlU5P6blsRU8XG64o9a4a
V/G+t8Jp6FeOlWZDsvdkgpQoMBXXXUp25hxI7XIx6w3F+o4JI+IYIwccsTA/53zC
FDj8ITRUietnQaPS4IviVgY+zuP8KPKV4SxWopWVEZqFFWmbpO0DWqukAKUTQQk8
HP1IiVTXwp3nt1xISWn1SfpS8nFmEkHNUEDVb3Fjpjnc4HKoy604SVei8yBap+NZ
KTRt+J+zuoVlwNfp/mvhwtKmTFiDIEjdwyKah/FA6d8hH1knRS6zdlT3vuVlHYmd
3EfeJjEJsP2bjqRYr2kpRfWAvbXHPLLxwhzesKfBxieRQdcEecyqncEr0z9hnG5m
chYbDGhn9Z4wutrZ1rpqo4lIs7/4mYAFQ+Ouzcuf5Ad3QlHT7plMqt0+JlcaBwcM
VV8wGr8J8oxAXeKDfxK9BRzRTzjQL4Sb941CiB4MqdmuojPQVv4CO3mJpsl2ZYcs
bDKb85Qmr7M85L6E6TBInh6zMLn0O6H3Zgx0kHb/nbXsH6++vRkEfH+WTKe60cE8
3odPLzsfqObXcnd9DEzbMqPkxLIK+f6xD5PePNL4QlPsmv+0hoo=
=1zfI
-----END PGP SIGNATURE-----

--Ph4DJCTZypElz0x7--

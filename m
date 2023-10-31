Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3958F1944E
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 09:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NtQ+KbIl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T3FEv4Hz"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BE0E8
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 02:05:11 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id D171032009AB;
	Tue, 31 Oct 2023 05:05:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 31 Oct 2023 05:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698743110; x=1698829510; bh=Be
	wxoY8nghTnmOg2GZFL8ChRX032VIIVJiBpyAt6cgU=; b=NtQ+KbIlRKSo+7QYPk
	h3uRiH7V3T3wlkEOuJMEz8YPUK5DU0NtX6DQDPL0cl2z6eSXxmtePc33UwYHBHiC
	liyPK6e7Ax4B0KOzzxgVZ7qE5+zXtLsDAvQPINo4F2DC+yiuCxFIx4nd31agy85r
	maHuz4xijFzRBN6cF9TgNQOpIFZ3B+4gel7t1jtIInPZC+0VdeBpi/759R/MboR7
	eMFSxlLN9nL1Cjic7xpzUQ1e1YNPzzAB1rBx5VJEZTTTqDZQeFynHo1U8AiN/c9B
	pZbOhrDUu2jTr8NCtKUeXYcJfUMQfFBmJXuAF8fJBJW7yGy3zizFbj94xdLKM+G3
	0Y7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698743110; x=1698829510; bh=BewxoY8nghTnm
	Og2GZFL8ChRX032VIIVJiBpyAt6cgU=; b=T3FEv4HzoXqMKty78jY0qVtXFS39E
	UFASMruHxjOoO0n1sklzOrzACC3ncDwYaP98Xweyez+ykLPq6J3mMiYNwtRfRoJJ
	Edzvmn931QilM7MrfCOr6CGlUayH+kB1lNxQNX1ogO/DwTQfmYN2vp+4p3lABjjx
	Wzs/oRvAm/mXmm4CDj9PibBr0IH5kh9Hs6M4pR2CcF2i8pxoWvbajBsFRY6jqFcb
	kLenLjK5xTrdh8Cm6WBQZ2Tt4sZ2Yeo/bs0Q012zQPASxhLE5M/NgrMbLua+nEa6
	ctwD0e60cxGiM/lRccDi/h8Wk5LJ0njl5Miu4fRaEoVLv7LVxb7bmfunA==
X-ME-Sender: <xms:RsNAZdoWbW-zJh3GO1Ue7_l4sDd9oo_D27cJdH0loDZtNslFLg-9yg>
    <xme:RsNAZfqy6NgwYXv9fc4-imRWyFi6w9ml9vt0G747zH6DxbHuWq37pwKuWVGf2HoxN
    YtJ-9eujyOPx6OIzQ>
X-ME-Received: <xmr:RsNAZaMouS0NC9pklgFyvXs2uZkfm2JZJWArpHl9wKUzwznGJzHdXI-gzyC4QRri6vokgtAOr_E1Sl0acaabgwKMJ6l_sdvBc6dydtYd2gej_K3o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeejteefleeitedtleefueduhfeghffhveduveegudeuuddvtedvteeghfdthfeg
    veenucffohhmrghinheprghlphhinhgvlhhinhhugidrohhrghdphhhtthhpugdrshhhne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehp
    khhsrdhimh
X-ME-Proxy: <xmx:RsNAZY4rgOcZGW5RaZng-HZHId7XO1EqNEN73vjuqGEWy50RAUzvfQ>
    <xmx:RsNAZc7j3z8eDNLAnQBG19rOMWoYEFaYq-GFVcDGWrfZyICFYODAHA>
    <xmx:RsNAZQivzX84Q7vziVeX2KFDZ8gWmda_5SSRiLhI6i2S7tm86hdKaw>
    <xmx:RsNAZantCWNYfttU1bQkvs1Qia8ERv2GsVTVrK-tcxjSo8MM3eBQcQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 05:05:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ab49968d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Oct 2023 09:05:01 +0000 (UTC)
Date: Tue, 31 Oct 2023 10:05:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH v4 7/8] ci: install test dependencies for linux-musl
Message-ID: <9b43b0d90e30c3ec49fac29060dc19d21274139f.1698742590.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698742590.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l4Ec4ncKMN1ckAtm"
Content-Disposition: inline
In-Reply-To: <cover.1698742590.git.ps@pks.im>


--l4Ec4ncKMN1ckAtm
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


--l4Ec4ncKMN1ckAtm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVAw0IACgkQVbJhu7ck
PpRZ4w/+KTJE8Rux7cXtBamuoCceBheZ5A2TT6MnkeueOlYdQsYUnuKrvdMS/n2S
7xFv77tH2FO0y8t0ASG1M+rGpDxj3FOWa8uOGGEhCHWZrZHJiTKayCP1JQlnE+d7
2eHhsWyBDO1txfyexyzaZQ1QQhZFBpejMqqtGnP3xRcJ0iv7BGIBcKmJvvnVRQY6
43n3BM/Bql1V9sLr9PKk0aQ8w/ZfjQ/x3RFUNTLGRKxdchYJDlBq8CaHmCqJri5q
MFEvPGXis/4p52h2X7++/ZQYGf1x2tutuVykdEMM+ZJlBQbWcOWhnca7LZDCYqfN
CSP3ATTQ5g7Bqsqh86akFe8BDuMM5YyepeTuKukDJyv7ymomkNx0SvYRMQqJB74G
VYKCiNnADyP14d1Hqd/l582a1juhYClo9aihcfG4tjNkrYT+9YTgLmE1ZsNAh7pH
FR7Oq+rjgPmEwOLL0uFPz6dABLTYW1oL8cRWltYGTMvizq9glkd4D22+NcLmrBNc
MbBf1weivo3nFNOiQ8rGiVY3A4zMUSpQaxu+QgZ/9GkHtOcn8XcHJ8yiIegbPouT
LUm32hZcuZL4iYCqe1Y3qMHs8yc/ycxduU1u6g/AcxTHZarH7QvQXMYqx8R1fQBb
w+XzyDm7Br5tyZl0OFpIjzOYhy26x7RYpEJGVNTtm9ny80mVujQ=
=JGP+
-----END PGP SIGNATURE-----

--l4Ec4ncKMN1ckAtm--

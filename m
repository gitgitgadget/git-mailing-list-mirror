Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAA76FAF
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iRz4SSYw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FGKC0HdY"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96450C9
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 08:23:11 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id C1DF832009C0;
	Mon, 30 Oct 2023 11:23:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 30 Oct 2023 11:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698679390; x=1698765790; bh=1j
	nh5/Ec9Rj/N1He3vYywcy2Kcmvh0R/wS28DG7xs5Q=; b=iRz4SSYwpXhf83DMtw
	tRrQZlxBaVpGnJWioMW5gINzxlUcrlZrjJ4pViJaZyCYIaI3CEK/kOC61n/8xuXs
	m7jmy+3xKPOtFP3hry9robphOBfloRDQe0a5BAAlclAruAujJzQtVqvLBbglgxEU
	xF+wZ9ZKtJFkhmrVQncZg8rk0gKtFmbBS+kXnfTKCrx2FXOjgg4LXCohF8ldmPbx
	VVlVFcVYKKr2yj7Uxf+IwHXeNbRy0N52C5MjrotMV8OUJrVXpIYGwfGq8RRG4ALI
	jL2GdGRk5H3y22UnWs3ifDAepwaRSbNcKrD13336EuPYhm/6xNI18lrbpHHCVQvN
	ZCZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698679390; x=1698765790; bh=1jnh5/Ec9Rj/N
	1He3vYywcy2Kcmvh0R/wS28DG7xs5Q=; b=FGKC0HdYCBRjCiGqYT14drP3jB+v8
	S2wSSjtllbgpypWMs3MODjrXO14prStn+b5A8InMNtr8roodfYyqU+DxJi6wPRMh
	r/XNEhMkUsXZkgdUXXRX853Uw5Iu0wQYXxN9yO9mt4BooGGzYOVwnCqlkqRgvnFg
	Qx3PaKirhOCTdw6nitpbR0y4wMSYSBe339NN7CJBKtbJgFYwLjdGrUWjrH0fXwVR
	ELGFrkUVh4Xwm3juGGC8NcO3U82v0k9YIoTrK3xt4TOHYEj5dNPdDG1U9lcl1D47
	+IgFAOJi0K/DjbefLGtDbDnMRFXOh8ThVuMMivF7PGBAjTh0oLHr1+mxw==
X-ME-Sender: <xms:Xso_ZXjJ-JWMksnI7F8yV0AoVBk0Loy9TdtkxRlGcJELx5kguJHcvw>
    <xme:Xso_ZUC0hXLnwJ_2_21aemX2JvIwB7ExV468gpy1y4pNqO_45PJ9JKim6QmJhTGio
    83ac2kTgJF4bxRcPQ>
X-ME-Received: <xmr:Xso_ZXGXP4Xjtd5cndgKxOBrGmfYONcPbYqpnwQleprFOK_cDjKHnPSke4T6I89CRcZ1Hi4cII8-RcV2VAsWmoC7dUuKp-LGp0ddzQgsGJSfAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddttddgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepffdvheeiuedukeduueevfeevgeejtdehteelhfehjeelgfdvheetgfehhfevgfek
    necuffhomhgrihhnpehhthhtphdqphhushhhqdifvggsuggrvhdrshhhpdhhthhtphguth
    gvshhtshhithhhohhughhhthhinhhsthgrlhhlqdguohgtkhgvrhdquggvphgvnhguvghn
    tghivghsrdhshhdphhhtthhpugdrshhhpdgrlhhpihhnvghlihhnuhigrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimh
X-ME-Proxy: <xmx:Xso_ZURtMr2thHarqwjYqCeO-obJbaaRXLOKZIp64UnXJClpr--voQ>
    <xmx:Xso_ZUxil8tk1A-oOQmW1JKkVnM7UYTkzyxvCerJbykzminZhq5Dsg>
    <xmx:Xso_Za6-u7ijcx7JAHT7g13DPkZmaPvAq6YKXbFiGsx5laXR4c4BIQ>
    <xmx:Xso_Zf_sV2pkSUoLJD61UBhSqz8pMv5OOWy_AnHRvQIN__jj3Durag>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Oct 2023 11:23:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4ebbb70e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Oct 2023 15:23:02 +0000 (UTC)
Date: Mon, 30 Oct 2023 16:23:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: Re: [PATCH v3 7/8] ci: install test dependencies for linux-musl
Message-ID: <ZT_KWjxkPEIXHEeH@tanuki>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698667545.git.ps@pks.im>
 <f150d61a1ceec5dd6cf370c3f4421a3e2d9f11a3.1698667545.git.ps@pks.im>
 <ZT-l4qDDNloizjxl@tanuki>
 <d675b51b-c50b-43e4-b127-650c0e24d3d0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t1Cifv1VuZ5yy0fo"
Content-Disposition: inline
In-Reply-To: <d675b51b-c50b-43e4-b127-650c0e24d3d0@gmail.com>


--t1Cifv1VuZ5yy0fo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 03:13:35PM +0000, Phillip Wood wrote:
> Hi Patrick
>=20
> On 30/10/2023 12:47, Patrick Steinhardt wrote:
> > On Mon, Oct 30, 2023 at 01:15:10PM +0100, Patrick Steinhardt wrote:
> > But once fixed, tests do indeed start to fail:
> >=20
> > t5540-http-push-webdav.sh                        (Wstat: 256 (exited 1)=
 Tests: 20 Failed: 11)
> >    Failed tests:  5-11, 13, 15-16, 18
> >    Non-zero exit status: 1
> >=20
> > Seems like another thing to fix in a separate patch series.
>=20
> Yes, or we could just leave it - I had not realized before that it was on=
ly
> the musl job that was not running the httpd tests (I thought
> install-docker-dependencies.sh was missing the packages for ubuntu as wel=
l).
> Given that, the status quo does not seem so bad.

I of course couldn't let go. The following would fix this:

diff --git a/ci/install-docker-dependencies.sh b/ci/install-docker-dependen=
cies.sh
index 5e28adf55b6..48cb2e735b5 100755
--- a/ci/install-docker-dependencies.sh
+++ b/ci/install-docker-dependencies.sh
@@ -21,7 +21,8 @@ linux32)
 linux-musl)
        apk add --update shadow sudo build-base curl-dev openssl-dev expat-=
dev gettext \
                pcre2-dev python3 musl-libintl perl-utils ncurses \
-               apache2 bash cvs gnupg perl-cgi perl-dbd-sqlite >/dev/null
+               apache2 apache2-http2 apache2-proxy apache2-ssl apache2-web=
dav apr-util-dbd_sqlite3 \
+               bash cvs gnupg perl-cgi perl-dbd-sqlite >/dev/null
        ;;
 linux-*)
        apt update -q &&
diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 9791f94b16f..9ea74927c40 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -128,6 +128,20 @@ else
                "Could not identify web server at '$LIB_HTTPD_PATH'"
 fi

+if test -n "$LIB_HTTPD_DAV" && test -f /etc/os-release
+then
+       case "$(grep "^ID=3D" /etc/os-release | cut -d=3D -f2-)" in
+       alpine)
+               # The WebDAV module in Alpine Linux is broken at least up to
+               # Alpine v3.16 as the default DBM driver is missing.
+               #
+               # https://gitlab.alpinelinux.org/alpine/aports/-/issues/131=
12
+               test_skip_or_die GIT_TEST_HTTPD \
+                       "Apache WebDAV module does not have default DBM bac=
kend driver"
+               ;;
+       esac
+fi
+
 install_script () {
        write_script "$HTTPD_ROOT_PATH/$1" <"$TEST_PATH/$1"
 }

I might as well roll it into this patch series now. It increases test
coverage on musl libc and doesn't have any significant downsides. In
fact, it uncovers that tests on Alpine Linux don't work right now, so it
fixes real issues to have the test coverage in our pipelines.

Patrick

--t1Cifv1VuZ5yy0fo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU/ylkACgkQVbJhu7ck
PpSWMBAAkX2Fb3wIXmY6XfihSFlwGFM++XUcg60/IaWYkdxOwSFbcW+gadL5Z+ym
zsjkmpIrLa9gJccFNYwm9ojyZwGxUGJLNW5XSKibMhEqlJJOdU+PkEz+nXuVRiP0
KbxHPo1yoNv7MV+2REuB/ne9YOghkIATo7Ai7JWK9PFw0ndJv1dj7UbvpdWOucmX
obuaxRjtFyET/mJUP7Rr7QtAE2vpxKSz5X8X4VOfvlU+Gi/OQITWynKmalcqMgPb
YMRCY3Mj/a9Kv/DnqAN0ClSkktFxwdVx1Q7wdOujpfxSoPaptME+793LzyZJWB9g
ZI11JqGktygx++QJ4pIVK3zLArDxdSNslN6PWxJDRcc1dyyieqZkduBPRSBiIANL
JRRcZLxCRzODnN4ck7YC2T2g5B7W407pBAaOdOt+euY52N3hpYJG3Ur+ewBeuCXI
hYoTNkovXnqjilNPyxg5I+8FO5tPOh90XqOrFIlylUJMrZ0sL7HEMPgn/Xpabjvw
h0BbffoR77XZ0dpIYeRsonY2Kkck1Niiuhmv01djOzWh2gPGYvqddZ+nR0oynUfA
y5158IXv/iQisHwwFrQ8lN+/sEAVY37mL8N8LKETeJ0uXXlUcGGFICO6CUNv5qBo
iKa8mJMs05b19aCRfq1bcmZZ5LlmV8zIEJfRfjmiIhbyz+5FUjg=
=IBv1
-----END PGP SIGNATURE-----

--t1Cifv1VuZ5yy0fo--

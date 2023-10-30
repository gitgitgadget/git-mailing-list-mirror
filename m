Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEFDD505
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 12:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wPvw8TYE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ge51m8aG"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECA2DF
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 05:47:37 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 631AD3200924;
	Mon, 30 Oct 2023 08:47:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 30 Oct 2023 08:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698670055; x=1698756455; bh=sP
	X0Mw1QXA9vw4uL8JKObhaHU3o8j8niwZkjVvtNkCE=; b=wPvw8TYEK+RyRJrTHP
	MWuerG2XSm1+bcamAXwavkAqdu8vUl+zdRsp/9nNsk9vGfrpm7Qfip6VSo1GLFTw
	NX2saMqoJo9nd0iSj2oa/RTJb+0ofh8GKAYDuMl+G6CAeq1Sa2GqF4/KyHCdhY74
	LlmccxCQnmBbjWKuNCoBW3s07BqNlXZg9KcLbWkbTDe2ZollQ2CsxB4JEuvzxw+e
	J8yfbx/7Bz+L5Lz6GVl+bCSKFYiKn45LxR9kHYiH/vdKjChO3R8UxlZPb7/Ji6qd
	m5Ia2vu6ahZpRVMODbBYwKXxF1kjNBnUHeRilpUWuXGRrYWumS8id2e6iBeNu1NW
	+HMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698670055; x=1698756455; bh=sPX0Mw1QXA9vw
	4uL8JKObhaHU3o8j8niwZkjVvtNkCE=; b=Ge51m8aGMjcMLpnIvX0YrxTTc9BWg
	66y8gCgjRZXxz6mH6R1fo+wPTVrYlr+6qQTAXdDnFpKfDzoQACxMoQQd83lXXtDw
	pMrGmn4KkQCwN73ObrP5n0K1C7Wrz9VZnoEwuR/katdJsJbKQtqb8kyzaAXRnSEE
	ofNbXgFLRsBK9hzrgtum6011U5Kh/0uwBwRblTmAms7fLJCytnaRXGQILewpDCSU
	FljlKLzHPURfnO0D2wYgMS5dlz3LvC5L+saSbAIDjB8h2jtddgJS4/oGNGthmB8L
	tCOuSiuAw7u8n1jQQFnroKStdIqEEEGDn7qy2Y/e5TiBmelIHCCuJU34w==
X-ME-Sender: <xms:56U_ZZWeCp8Ai3BJcfdj5QSIpVQ8lnsOuv_9bsqwikAsZ2XWjHahTg>
    <xme:56U_ZZl_UfG317FmVSfXHV1uxj-B31swaOaFrExP35PwLWKtP6FSTPdQyPKHoql-j
    R3Sed_ui6bYIk7k3A>
X-ME-Received: <xmr:56U_ZVYiwz4eChvX6tgVsgVIuU67r-Ol96x8vSxSVFRUBYMMkYuDdUbK0KTpPjbfeu4cuUhC-2ILa6aNBfA-I2_KRSPk0Alxsjik3xL9maLqww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddttddggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepvdegleeuhfefveejtdekhfejudejhfevieelheekgeetjeelhffgjeegteffgfeh
    necuffhomhgrihhnpehhthhtphgurdhshhdphhhtthhpqdhpuhhshhdqfigvsggurghvrd
    hshhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehp
    shesphhkshdrihhm
X-ME-Proxy: <xmx:56U_ZcVOGor0XVz4-baeuC1ce3m2Oz09q9uD_k_BZTf9-pVjzhUDmg>
    <xmx:56U_ZTlM2B_JAfj6DNQ-BsrZLbxhGjfBo2Qv_eFQN2gbiBocgs8ppg>
    <xmx:56U_ZZdGBhd4yQQVS-lfGZWea5WMe4V_-X9cPrjJUETF9_tTK55-Hw>
    <xmx:56U_ZYxHQZruhkhd6hR6HEmpcUKEHAvNctCkRVtSIR6qMBgNDq8tHg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Oct 2023 08:47:34 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f609277d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Oct 2023 12:47:26 +0000 (UTC)
Date: Mon, 30 Oct 2023 13:47:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: Re: [PATCH v3 7/8] ci: install test dependencies for linux-musl
Message-ID: <ZT-l4qDDNloizjxl@tanuki>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698667545.git.ps@pks.im>
 <f150d61a1ceec5dd6cf370c3f4421a3e2d9f11a3.1698667545.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9gqlBVll7ye5tcO7"
Content-Disposition: inline
In-Reply-To: <f150d61a1ceec5dd6cf370c3f4421a3e2d9f11a3.1698667545.git.ps@pks.im>


--9gqlBVll7ye5tcO7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 01:15:10PM +0100, Patrick Steinhardt wrote:
> The linux-musl CI job executes tests on Alpine Linux, which is based on
> musl libc instead of glibc. We're missing some test dependencies though,
> which causes us to skip a subset of tests.
>=20
> Install these test dependencies to increase our test coverage on this
> platform. There are still some missing test dependecies, but these do
> not have a corresponding package in the Alpine repositories:
>=20
>     - p4 and p4d, both parts of the Perforce version control system.
>=20
>     - cvsps, which generates patch sets for CVS.
>=20
>     - Subversion and the SVN::Core Perl library, the latter of which is
>       not available in the Alpine repositories. While the tool itself is
>       available, all Subversion-related tests are skipped without the
>       SVN::Core Perl library anyway.
>=20
> Furthermore, in order to make the Apache-based tests work, this commit
> also adds the Alpine-specific modules path of it to the list of known
> paths.
>=20
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  ci/install-docker-dependencies.sh | 3 ++-
>  t/lib-httpd.sh                    | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/ci/install-docker-dependencies.sh b/ci/install-docker-depend=
encies.sh
> index d0bc19d3bb3..05dde5c5d40 100755
> --- a/ci/install-docker-dependencies.sh
> +++ b/ci/install-docker-dependencies.sh
> @@ -17,7 +17,8 @@ linux32)
>  	;;
>  linux-musl)
>  	apk add --update build-base curl-dev openssl-dev expat-dev gettext \
> -		pcre2-dev python3 musl-libintl perl-utils ncurses >/dev/null
> +		pcre2-dev python3 musl-libintl perl-utils ncurses \
> +		apache2 bash cvs gnupg perl-cgi perl-dbd-sqlite >/dev/null

Meh. I just noticed that I missed a few other dependencies to make
Apache2 work:

diff --git a/ci/install-docker-dependencies.sh b/ci/install-docker-dependen=
cies.sh
index 5e28adf55b..ce910e3f3c 100755
--- a/ci/install-docker-dependencies.sh
+++ b/ci/install-docker-dependencies.sh
@@ -21,7 +21,8 @@ linux32)
 linux-musl)
 	apk add --update shadow sudo build-base curl-dev openssl-dev expat-dev ge=
ttext \
 		pcre2-dev python3 musl-libintl perl-utils ncurses \
-		apache2 bash cvs gnupg perl-cgi perl-dbd-sqlite >/dev/null
+		apache2 apache2-http2 apache2-proxy apache2-ssl apache2-webdav \
+		bash cvs gnupg perl-cgi perl-dbd-sqlite >/dev/null
 	;;
 linux-*)
 	apt update -q &&

But once fixed, tests do indeed start to fail:

t5540-http-push-webdav.sh                        (Wstat: 256 (exited 1) Tes=
ts: 20 Failed: 11)
  Failed tests:  5-11, 13, 15-16, 18
  Non-zero exit status: 1

Seems like another thing to fix in a separate patch series.

Patrick

>  	;;
>  pedantic)
>  	dnf -yq update >/dev/null &&
> diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
> index 2fb1b2ae561..9791f94b16f 100644
> --- a/t/lib-httpd.sh
> +++ b/t/lib-httpd.sh
> @@ -67,7 +67,8 @@ for DEFAULT_HTTPD_MODULE_PATH in '/usr/libexec/apache2'=
 \
>  				 '/usr/lib/apache2/modules' \
>  				 '/usr/lib64/httpd/modules' \
>  				 '/usr/lib/httpd/modules' \
> -				 '/usr/libexec/httpd'
> +				 '/usr/libexec/httpd' \
> +				 '/usr/lib/apache2'
>  do
>  	if test -d "$DEFAULT_HTTPD_MODULE_PATH"
>  	then
> --=20
> 2.42.0
>=20



--9gqlBVll7ye5tcO7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU/peEACgkQVbJhu7ck
PpTdaRAAmNa3GQ6YmFUuRarpR6bKlB5kAlDc94xbsu5Tg9XwIER/P45IUEpPkd4o
JllnQpr0Bd+2KLkLdLTItcjvVJtzekV8RWxiCqjRM0FNhDXEy4ZFlsKIU54+LIzw
LSWOtLEeZ8j0BpIf7Qzcu9dhB+RKOjW9HSyf7kSMVFjJsknWGsFxkxMKVTaGblbr
Npjzvuwld9JTSGVzpkzIjI4aWwhrAqp4+T5g5hp02jGeQY10oF2HtFZ0UDo6cKSL
Vq1TD2SNYU7d4XtJ3j2yo4ZAFs3ieYKmW0TmDx6IN1BAxih8HwP9OhqKc4IhTAQO
n3bBC0cd19TEnLE7d3xlyrF5e3mj5HIRneahNBJccqrCaxEIWpbba2zsMHoFnNOv
s1HiDSLtVpjQ4TWfVj1UoRHL8Fv3apaluW5p9n/e1ZOBI3tDvOrQd/xFNZ2xPvHO
NX3rnDcuYatmrG6k6vOg6kUabWEN1VltQ3jeHKeAsIO89+OyOO9+h3Y72ptND8Ri
xrP3KRJbkQVooafK0L2U/PbFYHrPAldafVEYEGNZ/9PA1i3zRgexMiCYT66vKkXZ
cGfDvtfivXSTxD+mhKbtNrUJoLuAk4uYkRzcQXNuvfQLydys4yES9Kj4LGylwBQw
RAt2RNQxvKwmbRDfD4CltouRRXbtL/DNA/TBo9a9x9M2tT2Pv7g=
=ckl4
-----END PGP SIGNATURE-----

--9gqlBVll7ye5tcO7--

Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A00714285
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 13:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qujfykym";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C9SdBipO"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B17CA2
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 06:22:42 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 49178320092F;
	Mon, 30 Oct 2023 09:22:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 30 Oct 2023 09:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698672158; x=1698758558; bh=Lg
	ybBQa0Jgio/2/lw3AFYm8qf14bvRgzMwN6XPpYIO0=; b=qujfykymxcFHxvuOAr
	adYa4xP6Ftfrt+ICfZV6uhNh9El3jYgYW5T9HvYhvubWkwHYQIlVhWPUq0f0xU+6
	sSuvvfRlEW2LweXEpQjI1OyTZol727cPrIk33jCTlV0WD/SrXkfR5m/0Axinpzy3
	+YVFd/4VolibhFfKI6B0wN++o8OhsI7Zm/Ca0G5SmHkSPnCjALZAzpPsobktMo93
	GxuX6p0r3J+AxLgN5L11RAfeu60kr4QnixP7OiJgGvmdxiPu5zZo1OqiFxkhV+Gk
	rqvgRsuuNcVtKzOu4E80r9UhQC/fb6i6XTdf0MwNacQPGZt1L2sTUHOfoxfwJZfv
	W78Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698672158; x=1698758558; bh=LgybBQa0Jgio/
	2/lw3AFYm8qf14bvRgzMwN6XPpYIO0=; b=C9SdBipOAvZvwqSCRIuHk4nAwy9vF
	NRNTXT59KdsEdFZC2D/vKLyFyUc4qpIqL7hQxqCyopSWBGa/DUIGqhwmiUkI3O6E
	Uhjkwxxih1D96vr0lVp6+JwumTBd5cHpK0EMKTM4jfZE/OW4hjnWbp2vXiYJ2txo
	sCFv+hbS7A7/cEVDY71ZxT7jfGdmO4z15Gr9OqBftq2xgDvBlyS8xmHBVJSjoa9G
	dEEjcAvJUOAOs71vCSF0zxQh4lqome/Z1se/sNOC87pfNQFQKd4YzHGxZObCnQKv
	7F1h/rMGR3EpFlMCSMco3ldBg9JUcl3ok76LCh35ZeIIuXUK/0xFp56Lw==
X-ME-Sender: <xms:Hq4_ZQeUNWBtfBRRgDIeKIRV1Q4feTjH_-gU-UfjzahkztWpCV54mA>
    <xme:Hq4_ZSNtOOovH8oNU4IIBXXM8DdXJiA2c442OqM-N4ELj2ZrPGz4yabygHb0mQsjt
    xu6uHs44e9YOdoppw>
X-ME-Received: <xmr:Hq4_ZRhCuFmxVzdKUFoG_mxPWx5Ez64nqv61WxziPs-C1JWiIEzaVNva-y32tDTzcb83vAW-Y7kgY2aRP5hIQnyzXe4EPUqr23xPPesTP5o-aQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddttddggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepiefgjeffgeehfefhfeejfeetveeijeegfeeuudegleffkedtueelhfehieehieek
    necuffhomhgrihhnpehhthhtphgurdhshhdphhhtthhpqdhpuhhshhdqfigvsggurghvrd
    hshhdprghlphhinhgvlhhinhhugidrohhrghenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Hq4_ZV8g2cH9Eazvari5ReohRywcCQfw1hYB2XTF2awfIPou121BgA>
    <xmx:Hq4_ZcvmXxJoucdv4-ho5H3JE7RP3eI2ug1FUb4uAFzKCSKAM_R_Cg>
    <xmx:Hq4_ZcFCOkoKoU2RU0lNqGkjr7OV824_rHVMhseJ3X03M3GSlJZ0PA>
    <xmx:Hq4_ZV7i1hswAqKeqPaz9FEG9aFsRHvR1Jk1Z8N7VLf88eTRKbPkEQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Oct 2023 09:22:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 98eb22a1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Oct 2023 13:22:29 +0000 (UTC)
Date: Mon, 30 Oct 2023 14:22:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: Re: [PATCH v3 7/8] ci: install test dependencies for linux-musl
Message-ID: <ZT-uGSu-ftFRrn-X@tanuki>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698667545.git.ps@pks.im>
 <f150d61a1ceec5dd6cf370c3f4421a3e2d9f11a3.1698667545.git.ps@pks.im>
 <ZT-l4qDDNloizjxl@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SI9DfQ8B5DXhyObV"
Content-Disposition: inline
In-Reply-To: <ZT-l4qDDNloizjxl@tanuki>


--SI9DfQ8B5DXhyObV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 01:47:30PM +0100, Patrick Steinhardt wrote:
> On Mon, Oct 30, 2023 at 01:15:10PM +0100, Patrick Steinhardt wrote:
> > The linux-musl CI job executes tests on Alpine Linux, which is based on
> > musl libc instead of glibc. We're missing some test dependencies though,
> > which causes us to skip a subset of tests.
> >=20
> > Install these test dependencies to increase our test coverage on this
> > platform. There are still some missing test dependecies, but these do
> > not have a corresponding package in the Alpine repositories:
> >=20
> >     - p4 and p4d, both parts of the Perforce version control system.
> >=20
> >     - cvsps, which generates patch sets for CVS.
> >=20
> >     - Subversion and the SVN::Core Perl library, the latter of which is
> >       not available in the Alpine repositories. While the tool itself is
> >       available, all Subversion-related tests are skipped without the
> >       SVN::Core Perl library anyway.
> >=20
> > Furthermore, in order to make the Apache-based tests work, this commit
> > also adds the Alpine-specific modules path of it to the list of known
> > paths.
> >=20
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  ci/install-docker-dependencies.sh | 3 ++-
> >  t/lib-httpd.sh                    | 3 ++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/ci/install-docker-dependencies.sh b/ci/install-docker-depe=
ndencies.sh
> > index d0bc19d3bb3..05dde5c5d40 100755
> > --- a/ci/install-docker-dependencies.sh
> > +++ b/ci/install-docker-dependencies.sh
> > @@ -17,7 +17,8 @@ linux32)
> >  	;;
> >  linux-musl)
> >  	apk add --update build-base curl-dev openssl-dev expat-dev gettext \
> > -		pcre2-dev python3 musl-libintl perl-utils ncurses >/dev/null
> > +		pcre2-dev python3 musl-libintl perl-utils ncurses \
> > +		apache2 bash cvs gnupg perl-cgi perl-dbd-sqlite >/dev/null
>=20
> Meh. I just noticed that I missed a few other dependencies to make
> Apache2 work:
>=20
> diff --git a/ci/install-docker-dependencies.sh b/ci/install-docker-depend=
encies.sh
> index 5e28adf55b..ce910e3f3c 100755
> --- a/ci/install-docker-dependencies.sh
> +++ b/ci/install-docker-dependencies.sh
> @@ -21,7 +21,8 @@ linux32)
>  linux-musl)
>  	apk add --update shadow sudo build-base curl-dev openssl-dev expat-dev =
gettext \
>  		pcre2-dev python3 musl-libintl perl-utils ncurses \
> -		apache2 bash cvs gnupg perl-cgi perl-dbd-sqlite >/dev/null
> +		apache2 apache2-http2 apache2-proxy apache2-ssl apache2-webdav \
> +		bash cvs gnupg perl-cgi perl-dbd-sqlite >/dev/null
>  	;;
>  linux-*)
>  	apt update -q &&
>=20
> But once fixed, tests do indeed start to fail:
>=20
> t5540-http-push-webdav.sh                        (Wstat: 256 (exited 1) T=
ests: 20 Failed: 11)
>   Failed tests:  5-11, 13, 15-16, 18
>   Non-zero exit status: 1
>=20
> Seems like another thing to fix in a separate patch series.
>=20
> Patrick

I've been digging a bit, and the issue comes from the the DAV module
indeed:

```
[Mon Oct 30 12:36:19.776149 2023] [dav_fs:crit] [pid 275752] (20019)DSO loa=
d failed: AH00576: The DBM driver could not be loaded
[Mon Oct 30 12:36:19.776168 2023] [dav:error] [pid 275752] [client 127.0.0.=
1:51388] Could not LOCK /dumb/test_repo.git/info/refs due to a failed preco=
ndition (e.g. other locks).  [500, #0]
[Mon Oct 30 12:36:19.776174 2023] [dav:error] [pid 275752] [client 127.0.0.=
1:51388] The locks could not be queried for verification against a possible=
 "If:" header.  [500, #0]
[Mon Oct 30 12:36:19.776177 2023] [dav:error] [pid 275752] [client 127.0.0.=
1:51388] Could not open the lock database.  [500, #400]
[Mon Oct 30 12:36:19.776181 2023] [dav:error] [pid 275752] (20019)DSO load =
failed: [client 127.0.0.1:51388] Could not open property database.  [500, #=
1]
```

This seems to be a known limitation in Alpine Linux as they do not
package apr-util-dbm_db anymore due to license incompatibilities with
with Berkely DB [1], and the WebDAV module does rely on it to provide
locking.

In the best case we'd be able to detect this limitation and skip those
tests automatically so that we can at least execute all the other Apache
tests. But again, this rather feels like something we should do as a
follow up rather than as part of this series.

Patrick

[1]: https://gitlab.alpinelinux.org/alpine/aports/-/issues/12534

> >  	;;
> >  pedantic)
> >  	dnf -yq update >/dev/null &&
> > diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
> > index 2fb1b2ae561..9791f94b16f 100644
> > --- a/t/lib-httpd.sh
> > +++ b/t/lib-httpd.sh
> > @@ -67,7 +67,8 @@ for DEFAULT_HTTPD_MODULE_PATH in '/usr/libexec/apache=
2' \
> >  				 '/usr/lib/apache2/modules' \
> >  				 '/usr/lib64/httpd/modules' \
> >  				 '/usr/lib/httpd/modules' \
> > -				 '/usr/libexec/httpd'
> > +				 '/usr/libexec/httpd' \
> > +				 '/usr/lib/apache2'
> >  do
> >  	if test -d "$DEFAULT_HTTPD_MODULE_PATH"
> >  	then
> > --=20
> > 2.42.0
> >=20
>=20
>=20



--SI9DfQ8B5DXhyObV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU/rhgACgkQVbJhu7ck
PpQDXw//QoPFWvhjSX3jITJhm+vfp4GHylpit803Vfg+ZU5XtGIspSe2WnvD0QQM
xK3sl8CZTtUd1dpA4QOQfYpqGKb64zh+6jAeMJZcflHp+CDpdbgzocXbtuoUMT7L
wYplC3W3bxKzpgdalbCnHowADSnz+vAop05xcED7PLYdWpzb4m9it4h3nU2601Mv
RucFij2/WCEr/Gu1gUthme3ZpXwchSTRr88MJtWHvlxOsKhUuImfUHMs5KE12gXg
hl0vdr0vhAHuh46hJugRxE1lnR4ZF5Mb0QQjwvddnjnMWlz5Xod6Ro9XmjCK8hrr
VLnI8zry5yyX4Drto7BcxarD5f9+1zJW3pXiKCMlp1HykbDgXzSyvIYsUgdPrZhU
cig4yGEC3yHgkG+t1OyBwgrYZWtostgxxh5sYIYbM2LLoq+ka523aI3I12yIah91
pd5OD+UJqIPo1R/H8Fp+N3l1/2YjBEyMZk2tiwlzZ6wM3zIxgbEFI/eWwnU9ek62
aklScz0FT4IW+4bvrTAydD8s9TyYsk7LaoOsGJPY5yoAigvJGTrwCblRb5FvTMr+
4SdSSugB6WAFcAn2EXM5wBA1fUlxme/rNxY47s6kzRJ9zeFBGFU37wo3ohVXou2A
ANCGT/7iEf5rqmUxGaIp0/DXuV9STB0FmO+1DZZO2mG9TXPVMU8=
=3lBi
-----END PGP SIGNATURE-----

--SI9DfQ8B5DXhyObV--

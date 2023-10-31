Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7BF125D9
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 09:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jV6+Ug8j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HJjtJh89"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200F9A9
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 02:04:46 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id B905032001FC;
	Tue, 31 Oct 2023 05:04:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 31 Oct 2023 05:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698743082; x=1698829482; bh=qJ
	B9fgYSn891tkxdfvWpsg1RA7Q5O9Y7w6xUCkhRaZc=; b=jV6+Ug8jop9yoLNn58
	yhDZz5WxB6pGVqfNFFB3EOOKU1k9iZfSQ4D5T1Bme+PnqQe3dLrFfDmm0WpSUSBb
	umZ/tgHfNX95nVWlP4f0MrkoF63IoTDLvDJMAtzZ1YxfU6oPIJynWl10uydqoVGK
	+5PctUp6bRnLuPrw6hj1i2CXwKHrogCkXSVFNJQHmPWToF1j2sUFk7MzINZY6VuZ
	MFKfCcdMr9t0xkA0hHzNwqGRTEpG2/K0xCTbyAfe5Za93UDjudZflri4ubUemURg
	ObBUBMPopx767kBWQxQ6Eu1BOV5/cSLbNMiSlKt0F0lrRb4h8jme5YaSftiqFA6s
	qZoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698743082; x=1698829482; bh=qJB9fgYSn891t
	kxdfvWpsg1RA7Q5O9Y7w6xUCkhRaZc=; b=HJjtJh89EY4i/yXgfZuyCQqhacVgZ
	ESw3jcT6Y2JLeWOeOL7mmA+63N+3mDnH9sRvB04QsLnPnvj4gIpi6ABLDl0V5OL2
	Hl3qqr0/fAVX0R2PE7Z9xZS0prDb41UQZb61fdqH9iwN9Upgo4HvqMxFDScsEW3E
	51kelV4R3AMhjoKkmKtumSs/SIUFnv4f3k11SqCrf9VTpWtoj6DLIYq4vlnsJh0l
	cFZfhTS2X2wLi4kMtstBjApU5amxllBTMYcTuh/mBCmDvzy8ctbaepAx1swmO4vx
	Ja0vu5KYLkDb0xPXn28VCsncSGdwdbOrOMNXHd9tqafthEGtSUjDTR0gg==
X-ME-Sender: <xms:KsNAZTT_GwNsody3xUJroUsrGpDwqao_wdMCZ4hzs4cz44JEeLj5Bw>
    <xme:KsNAZUx9Gh7hOGAIKG63aC3avjmvzGoRoZ3ifndNKSO66s2YE4iXH4w8ESa3nbTwH
    zrnqAK9fJhrIxXeEw>
X-ME-Received: <xmr:KsNAZY35Sf9nxIYYtISdeiXxUnHEf59jsBHBbjq5zNJLio1AfwrCDlUSSgR99M7X-xw277umHnnNKcs1RI7Jp46iDZpQnfmzhWdanIcsVpD0i8U->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeffkedtvdeghedviedttdehgeehhfefkeekveehgfekleeuvdevueegleejteei
    heenucffohhmrghinhephhhtthhpugdrshhhpdhlihgsrdhshhdprghlphhinhgvlhhinh
    hugidrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:KsNAZTBbk8GsvHN84n0akhWPKdAwUXN3zowi5Gb7U4iHWhPoK7vOvg>
    <xmx:KsNAZci3LrxYYyQwiPmEXk8-YLnXoiMJndc9KJCaBCkcwMOzmaQvxg>
    <xmx:KsNAZXqMSHZFtrhgqplMMIvM8xgPUjvZyr62tIWTBuC3MCKcddcf2g>
    <xmx:KsNAZVtH5EckK51v-arXTTBgUxNa-YM0wOBQplQL7svj_GNqwXO_dQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 05:04:41 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 967bee9e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Oct 2023 09:04:31 +0000 (UTC)
Date: Tue, 31 Oct 2023 10:04:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH v4 0/8] ci: add GitLab CI definition
Message-ID: <cover.1698742590.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jOtXQdVyDJdXFRHh"
Content-Disposition: inline
In-Reply-To: <cover.1698305961.git.ps@pks.im>


--jOtXQdVyDJdXFRHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the fourth version of my patch series that introduces support
for GitLab CI.

Changes compared to v3:

    - Stopped using nproc(1) to figure out the number of builds jobs for
      GitHub Actions and Azure Pipelines. Instead, we now continue to
      use the hardcoded 10 jobs there, whereas on GitLab CI we now use
      nproc. We can adapt GitHub/Azure at a later point as required, but
      I don't feel comfortable doing changes there.

    - Improved the linux-musl job. Namely, we now also install all
      required Apache modules, which makes the Apache-based test setup
      work. There is a packaging issue with the WebDAV module though, so
      we now skip tests that depend on it on Alpine Linux.

I still didn't move `.gitlab-ci.yml` to `contrib/`. As Taylor argued
(and I don't disagree), moving it to `contrib/` would convey the spirit
that this is _not_ an authoritative CI pipeline setup. But I wanted to
hear other opinions first before moving it into `contrib/`.

Patrick

Patrick Steinhardt (8):
  ci: reorder definitions for grouping functions
  ci: make grouping setup more generic
  ci: group installation of Docker dependencies
  ci: split out logic to set up failed test artifacts
  ci: unify setup of some environment variables
  ci: squelch warnings when testing with unusable Git repo
  ci: install test dependencies for linux-musl
  ci: add support for GitLab CI

 .gitlab-ci.yml                    |  53 +++++++++
 ci/install-docker-dependencies.sh |  23 +++-
 ci/lib.sh                         | 190 +++++++++++++++++++++---------
 ci/print-test-failures.sh         |   6 +
 t/lib-httpd.sh                    |  17 ++-
 5 files changed, 233 insertions(+), 56 deletions(-)
 create mode 100644 .gitlab-ci.yml

Range-diff against v3:
1:  ef44ed5c3b1 =3D 1:  8595fe5016a ci: reorder definitions for grouping fu=
nctions
2:  77798fa7a7a =3D 2:  7358a943392 ci: make grouping setup more generic
3:  4542bd38dc2 =3D 3:  6d842592c6f ci: group installation of Docker depend=
encies
4:  5fdda7fd83f =3D 4:  e15651b3f5d ci: split out logic to set up failed te=
st artifacts
5:  6af0075fd87 ! 5:  a64799b6e25 ci: unify setup of some environment varia=
bles
    @@ Commit message
         parts are separated. While at it, we also perform some additional =
small
         improvements:
    =20
    -        - We use nproc instead of a hardcoded count of jobs for make a=
nd
    -          prove. This ensures that the number of concurrent processes =
adapts
    -          to the host automatically.
    -
             - We now always pass `--state=3Dfailed,slow,save` via GIT_PROV=
E_OPTS.
               It doesn't hurt on platforms where we don't persist the stat=
e, so
               this further reduces boilerplate.
    @@ ci/lib.sh: then
      	exit 1
      fi
     =20
    -+MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D$(nproc)"
    -+GIT_PROVE_OPTS=3D"--timer --jobs $(nproc) --state=3Dfailed,slow,save"
    ++MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D10"
    ++GIT_PROVE_OPTS=3D"--timer --jobs 10 --state=3Dfailed,slow,save"
     +
     +GIT_TEST_OPTS=3D"$GIT_TEST_OPTS --verbose-log -x"
     +if test windows =3D "$CI_OS_NAME"
6:  78d863bf24e =3D 6:  f7d2a8666fe ci: squelch warnings when testing with =
unusable Git repo
7:  f150d61a1ce ! 7:  9b43b0d90e3 ci: install test dependencies for linux-m=
usl
    @@ Commit message
               available, all Subversion-related tests are skipped without =
the
               SVN::Core Perl library anyway.
    =20
    -    Furthermore, in order to make the Apache-based tests work, this co=
mmit
    -    also adds the Alpine-specific modules path of it to the list of kn=
own
    -    paths.
    +    The Apache2-based tests require a bit more care though. For one, t=
he
    +    module path is different on Alpine Linux, which requires us to add=
 it to
    +    the list of known module paths to detect it. But second, the WebDAV
    +    module on Alpine Linux is broken because it does not bundle the de=
fault
    +    database backend [1]. We thus need to skip the WebDAV-based tests =
on
    +    Alpine Linux for now.
    +
    +    [1]: https://gitlab.alpinelinux.org/alpine/aports/-/issues/13112
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    @@ ci/install-docker-dependencies.sh: linux32)
      	apk add --update build-base curl-dev openssl-dev expat-dev gettext \
     -		pcre2-dev python3 musl-libintl perl-utils ncurses >/dev/null
     +		pcre2-dev python3 musl-libintl perl-utils ncurses \
    -+		apache2 bash cvs gnupg perl-cgi perl-dbd-sqlite >/dev/null
    ++		apache2 apache2-http2 apache2-proxy apache2-ssl apache2-webdav apr-=
util-dbd_sqlite3 \
    ++		bash cvs gnupg perl-cgi perl-dbd-sqlite >/dev/null
      	;;
      pedantic)
      	dnf -yq update >/dev/null &&
    @@ t/lib-httpd.sh: for DEFAULT_HTTPD_MODULE_PATH in '/usr/libexec/apach=
e2' \
      do
      	if test -d "$DEFAULT_HTTPD_MODULE_PATH"
      	then
    +@@ t/lib-httpd.sh: else
    + 		"Could not identify web server at '$LIB_HTTPD_PATH'"
    + fi
    +=20
    ++if test -n "$LIB_HTTPD_DAV" && test -f /etc/os-release
    ++then
    ++	case "$(grep "^ID=3D" /etc/os-release | cut -d=3D -f2-)" in
    ++	alpine)
    ++		# The WebDAV module in Alpine Linux is broken at least up to
    ++		# Alpine v3.16 as the default DBM driver is missing.
    ++		#
    ++		# https://gitlab.alpinelinux.org/alpine/aports/-/issues/13112
    ++		test_skip_or_die GIT_TEST_HTTPD \
    ++			"Apache WebDAV module does not have default DBM backend driver"
    ++		;;
    ++	esac
    ++fi
    ++
    + install_script () {
    + 	write_script "$HTTPD_ROOT_PATH/$1" <"$TEST_PATH/$1"
    + }
8:  5272d66d9f1 ! 8:  f3f2c98a0dc ci: add support for GitLab CI
    @@ ci/install-docker-dependencies.sh: linux32)
     -	apk add --update build-base curl-dev openssl-dev expat-dev gettext \
     +	apk add --update shadow sudo build-base curl-dev openssl-dev expat-d=
ev gettext \
      		pcre2-dev python3 musl-libintl perl-utils ncurses \
    - 		apache2 bash cvs gnupg perl-cgi perl-dbd-sqlite >/dev/null
    + 		apache2 apache2-http2 apache2-proxy apache2-ssl apache2-webdav apr-=
util-dbd_sqlite3 \
    + 		bash cvs gnupg perl-cgi perl-dbd-sqlite >/dev/null
      	;;
     +linux-*)
     +	apt update -q &&
    @@ ci/lib.sh: then
      else
      	begin_group () { :; }
      	end_group () { :; }
    +@@ ci/lib.sh: then
    + 	cache_dir=3D"$HOME/test-cache/$SYSTEM_PHASENAME"
    +=20
    + 	GIT_TEST_OPTS=3D"--write-junit-xml"
    ++	JOBS=3D10
    + elif test true =3D "$GITHUB_ACTIONS"
    + then
    + 	CI_TYPE=3Dgithub-actions
     @@ ci/lib.sh: then
      	cache_dir=3D"$HOME/none"
     =20
      	GIT_TEST_OPTS=3D"--github-workflow-markup"
    ++	JOBS=3D10
     +elif test true =3D "$GITLAB_CI"
     +then
     +	CI_TYPE=3Dgitlab-ci
    @@ ci/lib.sh: then
     +	cache_dir=3D"$HOME/none"
     +
     +	runs_on_pool=3D$(echo "$CI_JOB_IMAGE" | tr : -)
    ++	JOBS=3D$(nproc)
      else
      	echo "Could not identify CI type" >&2
      	env >&2
    + 	exit 1
    + fi
    +=20
    +-MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D10"
    +-GIT_PROVE_OPTS=3D"--timer --jobs 10 --state=3Dfailed,slow,save"
    ++MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D${JOBS}"
    ++GIT_PROVE_OPTS=3D"--timer --jobs ${JOBS} --state=3Dfailed,slow,save"
    +=20
    + GIT_TEST_OPTS=3D"$GIT_TEST_OPTS --verbose-log -x"
    + if test windows =3D "$CI_OS_NAME"
    =20
      ## ci/print-test-failures.sh ##
     @@ ci/print-test-failures.sh: do
--=20
2.42.0


--jOtXQdVyDJdXFRHh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVAwyQACgkQVbJhu7ck
PpQiBw//eAMgxvUKuDgzHVS4HrrzVC2KGX3PphlnpoQ9xRnu23yWy0cHNMA2KA7O
SwAN7YlULPJ/WBHCAUj9V9xBgGvjmjffpfiuekVQEJvHuYe3UTPrK8UpnQnWOrJf
macyDDJF58/VrGDP6WK9s+QzBX9JGkMAiSiyS63m/Fr7Q+qEHfbt78/vHZg2FWEI
A0J0wFSqA7xqd+7ThMxpjQOMx7YWm23uRRVKiHdBHRvKepmU9HClKU1pfz5awZZB
JuE0Gm5LOwWYwZjSB1wcb4YA5IfCh7IjlSdCmy7Lh6jZsivns63rNnEsdMYevPQu
snMF8tf4t03NQiHaIAjT2G0AlbyzpghLLdjrH+I3+zVxMEKC8WyTXht2Hoe/kMRB
7OqvLoJ6qpswBbJyF8Ck/o7nS9ZvXDr7EBXlYmbkCL3c+EAsP/FYCOF3EDLdR55t
H9wN25sGtkd4Gg1aGpAuz8qBXXjpKVKCXXdDruTFTIIZSsHcchNWlumt8jI331A6
KAa/JD0TpUMAWkDdkWTzc/tf5aKLlGI7SRvK+QfuKag+1rxCc6hXyGxQTggJFH9p
5WnaCpbAHm37sTB7H9kGxHSy01qVNfGfGg3/rf1bXiPQyU/aagQGiSnSmaUrlOJr
V941JKZHfpw+8RzDsXrKvzJPUBJu9tDgMMep9Qy63oAWPZF6zTY=
=8JFi
-----END PGP SIGNATURE-----

--jOtXQdVyDJdXFRHh--

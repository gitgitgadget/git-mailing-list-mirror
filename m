Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C49182C0
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="floz312X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EQLUwXtZ"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1E19C
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 04:19:42 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 8D1E35C01AE;
	Fri, 27 Oct 2023 07:19:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 27 Oct 2023 07:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698405581; x=1698491981; bh=9z
	pg+fyeI1aRWrRghICIVjKwTpFFhXoAUtF5xjRzdCQ=; b=floz312XBJqjW30wvS
	MnfAiDkKhATPCnubXVMbLr83zDJQf0a6SnGtzv5oTEx+T2RkoXE2tz+ygriGXk0h
	vwCiF73NsSX8i7fRRjMokvYaMsCbelyo/i0m20TlrZjpbAjmu2G55b6Atie0fMsO
	xq9fZs2TtxqyVE+Ouv8DuEEKYmIJ4ioaHA/UAnVwbC9mORPpMt/+WEJkyo5xXMWr
	zCDC83bsIfKoWQiB4+d/f73IYXmxYh4PmdLn2BnkN3jjoLvpgWzxy7TnZP7L+eBl
	86PDgEpAtFmOO+sBOMgwFR9MfRvZZbSsDkT3ukdU/0xpSfliMuUG2H+Ll1GmIE78
	qWGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698405581; x=1698491981; bh=9zpg+fyeI1aRW
	rRghICIVjKwTpFFhXoAUtF5xjRzdCQ=; b=EQLUwXtZkfsD2wWhg+vZHX7oaXCLY
	bbsNTUvWHMSJQMC6vAhoFLDVP4qqBY573+SpO93fBGM2Txz9ABhSdplkAKwSarHz
	zcmaMctbG3+tfj2sRnF9uDpDimmKat9+Y7oARXZwsKvBPlFsylTbRMrOGdGfwwFr
	DW54Lvphm8OLfDc/KHhL7iN8rnnu4OHXltte1JGfIFJe3vS3rLIPrN7N3LjhochK
	wtr94qINi4kFmow9KtvcWLAhRidSUKkPnTmwSqxigtWoSB8Buxd73EwvusVACC+W
	OFIMZzghfgIF7ZHak6T5UZJZ2F5x97xofEkTVNQ6g5YuFwZdA88M0KwbQ==
X-ME-Sender: <xms:yZw7ZVECpsefhErZyEsMeVZ6kbjxLU99PEqAkHOpEouABL3KRsmKMw>
    <xme:yZw7ZaXeZdCQHPjUAZid4AweKQc9pSukC3jAtFdRVa66r_HZLbc1vNNwGT91brwBO
    HM9R1Fw2ZiRa_EP2g>
X-ME-Received: <xmr:yZw7ZXJi5I5R1kU3b6LC_Tf4o5YMr7xIkDoN2GgmcLjvQ61lpAZvxrYb8pZPMzSqHcSEC7wQGcqlytyQam8CaqizcWLsKctYZVpMAxsUMaraUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeggdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeegheevgfevtddtfeduiefgvefhiefhhefghfdukeevtddtvedtledtvefhhfejgfen
    ucffohhmrghinhepghhithhlrggsrdgtohhmpdhhthhtphgurghrvghnohifshhkihhpph
    gvuggrshhthhgvhihrvghfuhhsvghtohhruhhnrghsrhhoohhtrdgtihdprhhunhdqugho
    tghkvghrqdgsuhhilhgurdhshhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:yZw7ZbHCq-n1yRWI13fRrEId0UlMEH_QA7R9fPgbicuwfDw8JhoHaQ>
    <xmx:yZw7ZbWvfATUEfWoHdBcwssVH-97FcLfQTrIA-oMX0egF1tJLJIUOg>
    <xmx:yZw7ZWMKtmAqIzeXjQ8PppJ47I32rzNOSmAxi-XHsu6QpXy2rKejxQ>
    <xmx:zZw7ZScT_Po1NURxgNfHNEilHeioqOnO3RAVeO35JTc_-vlPLv9O8w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 07:19:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4e275eb1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Oct 2023 11:19:25 +0000 (UTC)
Date: Fri, 27 Oct 2023 13:19:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: Re: [PATCH v2 5/5] ci: add support for GitLab CI
Message-ID: <ZTucxlBR1VrJPuSK@tanuki>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698398590.git.ps@pks.im>
 <37a507e9b255dd40c0536438dfe3fa05b067f08f.1698398590.git.ps@pks.im>
 <0d889da1-7fd8-4e21-965f-6222e4433ecf@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T6QpYSicFpM+K5rq"
Content-Disposition: inline
In-Reply-To: <0d889da1-7fd8-4e21-965f-6222e4433ecf@gmail.com>


--T6QpYSicFpM+K5rq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 11:19:04AM +0100, Phillip Wood wrote:
> On 27/10/2023 10:25, Patrick Steinhardt wrote:
> > We already support Azure Pipelines and GitHub Workflows in the Git
> > project, but until now we do not have support for GitLab CI. While it is
> > arguably not in the interest of the Git project to maintain a ton of
> > different CI platforms, GitLab has recently ramped up its efforts and
> > tries to contribute to the Git project more regularly.
>=20
> I agree we don't want to support too many CI platforms but I think adding
> support for GitLab is good as it helps to stop us being too tied to GitHub
> Actions (which should make it easier if we ever need to transition to a
> different platform in the future) and provides an alternative for
> contributors who want to use a different platform.
>=20
> > Part of a problem we hit at GitLab rather frequently is that our own,
> > custom CI setup we have is so different to the setup that the Git
> > project has. More esoteric jobs like "linux-TEST-vars" that also set a
> > couple of environment variables do not exist in GitLab's custom CI
> > setup, and maintaining them to keep up with what Git does feels like
> > wasted time. The result is that we regularly send patch series upstream
> > that fail to compile or pass tests in GitHub Workflows. We would thus
> > like to integrate the GitLab CI configuration into the Git project to
> > help us send better patch series upstream and thus reduce overhead for
> > the maintainer.
> >=20
> > The integration does not necessarily have to be a first-class citizen,
> > which would in practice only add to the fallout that pipeline failures
> > have for the maintainer. That being said, we are happy to maintain this
> > alternative CI setup for the Git project and will make test results
> > available as part of our own mirror of the Git project at [1].
>=20
> Having someone committed to on-going maintenance is great.
>=20
> > This commit introduces the integration into our regular CI scripts so
> > that most of the setup continues to be shared across all of the CI
> > solutions.
> >=20
> > [1]: https://gitlab.com/gitlab-org/git
> >=20
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >   .gitlab-ci.yml                    | 51 +++++++++++++++++++++++++++++++
> >   ci/install-docker-dependencies.sh |  9 +++++-
> >   ci/lib.sh                         | 49 +++++++++++++++++++++++++++++
> >   ci/print-test-failures.sh         |  6 ++++
> >   4 files changed, 114 insertions(+), 1 deletion(-)
> >   create mode 100644 .gitlab-ci.yml
> >=20
> > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > new file mode 100644
> > index 00000000000..43d3a961fa0
> > --- /dev/null
> > +++ b/.gitlab-ci.yml
> > @@ -0,0 +1,51 @@
> > +default:
> > +  timeout: 2h
> > +
> > +workflow:
> > +  rules:
> > +    - if: $CI_PIPELINE_SOURCE =3D=3D "merge_request_event"
> > +    - if: $CI_COMMIT_TAG
> > +    - if: $CI_COMMIT_REF_PROTECTED =3D=3D "true"
> > +
> > +test:
> > +  image: $image
> > +  before_script:
> > +    - ./ci/install-docker-dependencies.sh
> > +  script:
> > +    - useradd builder --home-dir "${CI_PROJECT_DIR}"
> > +    - chown -R builder "${CI_PROJECT_DIR}"
> > +    - sudo --preserve-env --set-home --user=3Dbuilder ./ci/run-build-a=
nd-tests.sh
>=20
> It's really good that you're running the tests as an unprivileged user. T=
his
> is something we used to do when we were using Travis that got lost in the
> transition to Azure Pipelines which means some tests that rely on httpd a=
re
> now skipped as they refuse to run as root. ci/run-docker-build.sh is
> currently bit-rotting, I wonder if it is possible to update it so that we
> can run the dockerized tests in the same way on all CI platforms.
>=20
> > +  after_script:
> > +    - |
> > +      if test "$CI_JOB_STATUS" !=3D 'success'
> > +      then
> > +        sudo --preserve-env --set-home --user=3Dbuilder ./ci/print-tes=
t-failures.sh
> > +      fi
> > +  parallel:
> > +    matrix:
> > +      - jobname: linux-sha256
> > +        image: ubuntu:latest
> > +        CC: clang
> > +      - jobname: linux-gcc
> > +        image: ubuntu:20.04
> > +        CC: gcc
> > +        CC_PACKAGE: gcc-8
> > +      - jobname: linux-TEST-vars
> > +        image: ubuntu:20.04
> > +        CC: gcc
> > +        CC_PACKAGE: gcc-8
> > +      - jobname: linux-gcc-default
> > +        image: ubuntu:latest
> > +        CC: gcc
> > +      - jobname: linux-leaks
> > +        image: ubuntu:latest
> > +        CC: gcc
> > +      - jobname: linux-asan-ubsan
> > +        image: ubuntu:latest
> > +        CC: clang
> > +      - jobname: linux-musl
> > +        image: alpine:latest
> > +  artifacts:
> > +    paths:
> > +      - t/failed-test-artifacts
> > +    when: on_failure
>=20
> This file is pleasingly small.
>=20
> > diff --git a/ci/install-docker-dependencies.sh b/ci/install-docker-depe=
ndencies.sh
> > index d0bc19d3bb3..1cd92db1876 100755
> > --- a/ci/install-docker-dependencies.sh
> > +++ b/ci/install-docker-dependencies.sh
> > @@ -7,6 +7,9 @@
> >   begin_group "Install dependencies"
> > +# Required so that apt doesn't wait for user input on certain packages.
> > +export DEBIAN_FRONTEND=3Dnoninteractive
> > +
> >   case "$jobname" in
> >   linux32)
> >   	linux32 --32bit i386 sh -c '
> > @@ -16,9 +19,13 @@ linux32)
> >   	'
> >   	;;
> >   linux-musl)
> > -	apk add --update build-base curl-dev openssl-dev expat-dev gettext \
> > +	apk add --update git shadow sudo build-base curl-dev openssl-dev expa=
t-dev gettext \
> >   		pcre2-dev python3 musl-libintl perl-utils ncurses >/dev/null
>=20
> It would be helpful to explain the new dependencies in the commit message=
=2E I
> can see why you're adding sudo, but how were we getting away without
> installing the other packages for GitHub Actions?

True, that part is missing.

- Both sudo and shadow are now required because of `useradd` that we use
  to set up the unprivileged build.

- Git has been required all along, I think. `save_good_tree ()` is used
  in our CI scripts, and Toon (fellow GitLabber from my team) has
  noticed that the CI job warned about missing Git. The warning was
  mostly benign as it seems, but still, doesn't hurt to fix it while at
  it.

I'll have a look at whether I can add another patch on top that adjusts
`ci/run-docker-build.sh` to do rootless builds, which would also make it
more obvious why we now need to install sudo and shadow. And I'll make
sure to document why we now need to have Git around.

> >   	;;
> > +linux-*)
> > +	apt update -q &&
> > +	apt install -q -y sudo git make language-pack-is libsvn-perl apache2 =
libssl-dev libcurl4-openssl-dev libexpat-dev tcl tk gettext zlib1g-dev perl=
-modules liberror-perl libauthen-sasl-perl libemail-valid-perl libio-socket=
-ssl-perl libnet-smtp-ssl-perl ${CC_PACKAGE:-${CC:-gcc}}
> > +	;;
> >   pedantic)
> >   	dnf -yq update >/dev/null &&
> >   	dnf -yq install make gcc findutils diffutils perl python3 gettext zl=
ib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
> > diff --git a/ci/lib.sh b/ci/lib.sh
> > index 9ffdf743903..f518df7e2cb 100755
> > --- a/ci/lib.sh
> > +++ b/ci/lib.sh
> > @@ -14,6 +14,22 @@ then
> >   		need_to_end_group=3D
> >   		echo '::endgroup::' >&2
> >   	}
> > +elif test true =3D "$GITLAB_CI"
> > +then
> > +	begin_group () {
> > +		need_to_end_group=3Dt
> > +		echo -e "\e[0Ksection_start:$(date +%s):$(echo "$1" | tr ' ' _)\r\e[=
0K$1"
> > +		trap "end_group '$1'" EXIT
> > +		set -x
> > +	}
> > +
> > +	end_group () {
> > +		test -n "$need_to_end_group" || return 0
> > +		set +x
> > +		need_to_end_group=3D
> > +		echo -e "\e[0Ksection_end:$(date +%s):$(echo "$1" | tr ' ' _)\r\e[0K"
> > +		trap - EXIT
> > +	}
> >   else
> >   	begin_group () { :; }
> >   	end_group () { :; }
> > @@ -203,6 +219,39 @@ then
> >   	MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D10"
> >   	test windows !=3D "$CI_OS_NAME" ||
> >   	GIT_TEST_OPTS=3D"--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
> > +elif test true =3D "$GITLAB_CI"
> > +then
> > +	CI_TYPE=3Dgitlab-ci
> > +	CI_BRANCH=3D"$CI_COMMIT_REF_NAME"
> > +	CI_COMMIT=3D"$CI_COMMIT_SHA"
> > +	case "$CI_JOB_IMAGE" in
> > +	macos-*)
> > +		CI_OS_NAME=3Dosx;;
> > +	alpine:*|ubuntu:*)
> > +		CI_OS_NAME=3Dlinux;;
> > +	*)
> > +		echo "Could not identify OS image" >&2
> > +		env >&2
> > +		exit 1
> > +		;;
> > +	esac
> > +	CI_REPO_SLUG=3D"$CI_PROJECT_PATH"
> > +	CI_JOB_ID=3D"$CI_JOB_ID"
>=20
> I guess making this explicit is helpful, otherwise someone may wonder why
> CI_JOB_ID is not being set.
>=20
> > +	CC=3D"${CC_PACKAGE:-${CC:-gcc}}"
> > +	DONT_SKIP_TAGS=3Dt
> > +	handle_failed_tests () {
> > +		create_failed_test_artifacts
> > +	}
> > +
> > +	cache_dir=3D"$HOME/none"
> > +
> > +	runs_on_pool=3D$(echo "$CI_JOB_IMAGE" | tr : -)
> > +
> > +	export GIT_PROVE_OPTS=3D"--timer --jobs $(nproc)"
> > +	export GIT_TEST_OPTS=3D"--verbose-log -x"
> > +	MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D$(nproc)"
> > +	test windows !=3D "$CI_OS_NAME" ||
> > +	GIT_TEST_OPTS=3D"--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
>=20
> This last paragraph feels like it should be common to all the CI provider=
s.
> There are some small differences but if we're going to support several
> providers it would be nice to set the common options centrally. I'm pretty
> sure the --jobs=3D10 we use for the GitHub and Azure is not optimal, using
> $(nproc) is nice so long as it is supported on all the images we use.

True enough, I can have a go at it. I'm rather cautious around updating
the build infra as I cannot easily verify that things continue to work
for GitHub. But this part here might be a good candidate for deduping.

> I had a quick glance through the previous patches and they all look like
> nice cleanups that make our ci support less dependent on a single provide=
r.
> This series looks like a nice addition to our CI support.
>=20
> Best Wishes
>=20
> Phillip

Thanks!

Patrick

>=20
> >   else
> >   	echo "Could not identify CI type" >&2
> >   	env >&2
> > diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
> > index 57277eefcd0..c33ad4e3a22 100755
> > --- a/ci/print-test-failures.sh
> > +++ b/ci/print-test-failures.sh
> > @@ -51,6 +51,12 @@ do
> >   			tar czf failed-test-artifacts/"$test_name".trash.tar.gz "$trash_di=
r"
> >   			continue
> >   			;;
> > +		gitlab-ci)
> > +			mkdir -p failed-test-artifacts
> > +			cp "${TEST_EXIT%.exit}.out" failed-test-artifacts/
> > +			tar czf failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
> > +			continue
> > +			;;
> >   		*)
> >   			echo "Unhandled CI type: $CI_TYPE" >&2
> >   			exit 1
>=20

--T6QpYSicFpM+K5rq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU7nMUACgkQVbJhu7ck
PpQf1RAApSwuBKW2NZxGxSNs3YMRkWjXkNGQWD/swTWO2V2tFVSbhP2BPiiClvsM
zip6S9F8BiAPu/1AYVy6FD4lJEgRP/Eq1/c4e/YfyjkLicZEHZ41VSoaCMEgqpk5
fdJzjNst+vym1B9dntCIwmBI+X4Ovag1dVp0kZWQkzIAQSDg/ql0bKMKBGBs1fCf
4jANsqJyTxp94qUyJDyKLlA/nvLb6xWa9DqdOYAD36lWh00tp0XeWrxgV/bR4SKk
hnhgwoHLNXhQpOR434NpEgcawBWHO3kmjB+jjwIyk9Bq6w34RkqFBNMumtCN4cM7
lm2F7rfkwANz2bB5hxsnLILQUc077taPo3Zmrvf8xqU4r0rt91IIydLfomJJODAV
SK4ZCdmnLSPD4n8ZY3fSADkLOqCa/ZpWYg4oeGzUYZCoICbQnPs1K0lzDW05a1vx
SFqjL4MD9S2/prKpGAw09aqpBSg87ewmW9n33q2YBN+ieOj8m56sYhw3g+WFz244
6DFNYjAKKtWzGLRLx+w0LfyLNHRQnJpQzLRNSpXo47DqMKVVOB2e2zddsSFugFDi
8sUzLSDKcQQuX2cVmjhhbs9VJG7oT8YDQVC9BG/c1bNCHrVT5Wg5xpuuw2vv0qCM
KoAojWV1A6INf8CdXDUwUVKCki8W04aktB41deI865emYxJDIc0=
=Cj2h
-----END PGP SIGNATURE-----

--T6QpYSicFpM+K5rq--

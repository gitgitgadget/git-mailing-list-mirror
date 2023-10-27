Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C09A15AC4
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 09:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SWRowzyX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d7qC+O7+"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A7F1A5
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 02:25:28 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 5A7035C0209;
	Fri, 27 Oct 2023 05:25:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 27 Oct 2023 05:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698398725; x=1698485125; bh=fN
	oQLPOCfr+5OQD2/+LzKHaO1957j2SGzSRtP20zq6g=; b=SWRowzyXOeNIpzoY+4
	AAArat2gspVm4nSDBmYikZ6uUX0Fl8IgH9izd2+HhmG9AQknzLTRhd8pHCaix3Xh
	eshPv8+D9UPUqFUul6g6x1SgniRz/42xFnu9u3IJGB9nLyIazTvfwZ7tp1gSRYkn
	aGnGPxjMAuqlSkR5/wZYZRlA2ed2DCpCWEHW8xQNS4pgfq1kVoa10AcTouJFBDu0
	zoudIEYPz8ftDtV1nuSaFSqkDjmQibF4r73InmB6v326r9zbvIjbJBYsiGI8PCAa
	nzLWLFSkJBVdPuh9Fr6T9xELTlJraZIj0y6BblXeJqZRwk7qAclk5yU3z+jDxWS9
	Jdiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698398725; x=1698485125; bh=fNoQLPOCfr+5O
	QD2/+LzKHaO1957j2SGzSRtP20zq6g=; b=d7qC+O7+WY7O+KSrotRvV1Ogrmn+X
	4nImsXuEvWEXEKeDcEKXeR7DvIxVYS7evHYofhdkr2ji/2zTvTVHFywWhZ/Lv44I
	+WD07NFL1tkcKKBUcPJiFc06TxEer/o29Q64CjNXbFMnytSqPvMQI6NMh2ToM1HZ
	x32jERlz2gPb+IkMaClmkDxglQAa9zfmGzx+6iibqj9CwRBahor/aL18IF76tqa9
	8Nf4zOB+sMOx6iNA50nybDNsT0bbNeWYUZVJ3CRpNHW6B7agvXPc5XweWTLkk7dH
	7OPUDGLVFsj3Y4jjItq+bSx59cVnBSWF4CUM6nookEI+A/02FZNLaK7rQ==
X-ME-Sender: <xms:BYI7ZVLGYfsFBcKgtX7zcLbCe8sEfkHE7hGl--LcROSsDIgbYzCqDg>
    <xme:BYI7ZRI5XRiQIUaiv9O_1h652SrUOguhvtIe-qQ2niaU4K1KMoTMzO9I_Kpqa5hoj
    FfxOXOsrMFEoNj31Q>
X-ME-Received: <xmr:BYI7ZdvQ71C4DzJ3O5yaARV6f9EpDWnM1vgBj7QysT6NIxHeWoP0VPWZjHSVXu6JwT2-1IA05mEjdZcaC9YsOa_Z2mdgSjoBMAYxjs_IvFSsqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeggdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedtieetveevudekkeehieeuvedtiefggfethfekleegvedtjeeuleelffetueeiueen
    ucffohhmrghinhepphhkshdrihhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:BYI7ZWYbiKTRbU-qLpTLzycEzv26TOupJ4gZHFonkfoiVvPUK-8cDw>
    <xmx:BYI7ZcYS3UjtpjlRcxHKpVbuRU6-jAG6xR9UCItxoDSfNf3rFvgWiA>
    <xmx:BYI7ZaB-bSglRHUeixw8Zj0CnaNVXuHq1151mhYnrPnexV9b5w0ZWA>
    <xmx:BYI7ZVAOlr6QwfRTtluEG1xP_lUXwoQODtHmGVTChfxLbGDY5jN5FQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 05:25:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6715a8e5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Oct 2023 09:25:11 +0000 (UTC)
Date: Fri, 27 Oct 2023 11:25:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH v2 0/5] ci: add GitLab CI definition
Message-ID: <cover.1698398590.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Kstn952qmNfwdRwE"
Content-Disposition: inline
In-Reply-To: <cover.1698305961.git.ps@pks.im>


--Kstn952qmNfwdRwE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of this patch series that adds GitLab CI
definitions to the Git project. Please refer to the cover letter for v1
of this series [1] for the motivation and intent -- I won't repeat it
here as it's a bit on the longer side.

Changes compared to v1:

    - Improved commit messages.

    - The `group ()` function is now generic across all the different CI
      solutions to reduce duplication.

This should hopefully address the feedback from Oswald -- thanks again!

Patrick

[1]: <cover.1698305961.git.ps@pks.im>


Patrick Steinhardt (5):
  ci: reorder definitions for grouping functions
  ci: make grouping setup more generic
  ci: group installation of Docker dependencies
  ci: split out logic to set up failed test artifacts
  ci: add support for GitLab CI

 .gitlab-ci.yml                    |  51 +++++++++++
 ci/install-docker-dependencies.sh |  15 +++-
 ci/lib.sh                         | 139 ++++++++++++++++++++----------
 ci/print-test-failures.sh         |   6 ++
 4 files changed, 166 insertions(+), 45 deletions(-)
 create mode 100644 .gitlab-ci.yml

Range-diff against v1:
1:  586a8d1003b ! 1:  4eb9cfc816b ci: reorder definitions for grouping func=
tions
    @@ Commit message
         output in our CI, where these groups then end up as collapsible se=
ctions
         in the respective pipeline platform. The way these functions are d=
efined
         is not easily extensible though as we have an up front check for t=
he CI
    -    _not_ being GitLab Actions, where we define the non-stub logic in =
the
    +    _not_ being GitHub Actions, where we define the non-stub logic in =
the
         else branch.
    =20
    -    Reorder the definitions such that we explicitly handle GitHub Acti=
ons.
    +    Reorder the conditional branches such that we explicitly handle Gi=
tHub
    +    Actions.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
2:  ec390354f15 ! 2:  85617ef8577 ci: make grouping setup more generic
    @@ Commit message
         or not. This ensures we can more readily add support for additiona=
l CI
         platforms.
    =20
    -    Second, this commit changes `end_group ()` to also accept a parame=
ter
    -    that indicates _which_ group should end. This will be required by a
    -    later commit that introduces support for GitLab CI.
    +    Furthermore, the `group ()` function is made generic so that it is=
 the
    +    same for both GitHub Actions and for other platforms. There is a
    +    semantic conflict here though: GitHub Actions used to call `set +x=
` in
    +    `group ()` whereas the non-GitHub case unconditionally uses `set -=
x`.
    +    The latter would get overriden if we kept the `set +x` in the gene=
ric
    +    version of `group ()`. To resolve this conflict, we simply drop th=
e `set
    +    +x` in the generic variant of this function. As `begin_group ()` c=
alls
    +    `set -x` anyway this is not much of a change though, as the only
    +    commands that aren't printed anymore now are the ones between the
    +    beginning of `group ()` and the end of `begin_group ()`.
    +
    +    Last, this commit changes `end_group ()` to also accept a paramete=
r that
    +    indicates _which_ group should end. This will be required by a lat=
er
    +    commit that introduces support for GitLab CI.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    @@ ci/lib.sh: then
      		echo '::endgroup::' >&2
      	}
     -	trap end_group EXIT
    -=20
    - 	group () {
    - 		set +x
    +-
    +-	group () {
    +-		set +x
     -		begin_group "$1"
    -+
    -+		group=3D"$1"
    - 		shift
    -+		begin_group "$group"
    -+
    - 		# work around `dash` not supporting `set -o pipefail`
    - 		(
    - 			"$@" 2>&1
    -@@ ci/lib.sh: then
    - 		sed 's/^\(\([^ ]*\):\([0-9]*\):\([0-9]*:\) \)\(error\|warning\): /:=
:\5 file=3D\2,line=3D\3::\1/'
    - 		res=3D$(cat exit.status)
    - 		rm exit.status
    +-		shift
    +-		# work around `dash` not supporting `set -o pipefail`
    +-		(
    +-			"$@" 2>&1
    +-			echo $? >exit.status
    +-		) |
    +-		sed 's/^\(\([^ ]*\):\([0-9]*\):\([0-9]*:\) \)\(error\|warning\): /:=
:\5 file=3D\2,line=3D\3::\1/'
    +-		res=3D$(cat exit.status)
    +-		rm exit.status
     -		end_group
    -+
    -+		end_group "$group"
    - 		return $res
    - 	}
    +-		return $res
    +-	}
     -
     -	begin_group "CI setup"
      else
      	begin_group () { :; }
      	end_group () { :; }
    -@@ ci/lib.sh: else
    +=20
    +-	group () {
    +-		shift
    +-		"$@"
    +-	}
      	set -x
      fi
     =20
    ++group () {
    ++	group=3D"$1"
    ++	shift
    ++	begin_group "$group"
    ++
    ++	# work around `dash` not supporting `set -o pipefail`
    ++	(
    ++		"$@" 2>&1
    ++		echo $? >exit.status
    ++	) |
    ++	sed 's/^\(\([^ ]*\):\([0-9]*\):\([0-9]*:\) \)\(error\|warning\): /::=
\5 file=3D\2,line=3D\3::\1/'
    ++	res=3D$(cat exit.status)
    ++	rm exit.status
    ++
    ++	end_group "$group"
    ++	return $res
    ++}
    ++
     +begin_group "CI setup"
     +trap "end_group 'CI setup'" EXIT
     +
3:  a65d235dd3c ! 3:  57bbc50e3dc ci: group installation of Docker dependen=
cies
    @@ Metadata
      ## Commit message ##
         ci: group installation of Docker dependencies
    =20
    -    Pull in "lib.sh" into "install-docker-dependencies.sh" such that w=
e can
    -    set up proper groups for those dependencise. This allows the reade=
r to
    -    collapse sections in the CI output on GitHub Actions (and later on=
 on
    -    GitLab CI).
    +    The output of CI jobs tends to be quite long-winded and hard to di=
gest.
    +    To help with this, many CI systems provide the ability to group ou=
tput
    +    into collapsible sections, and we're also doing this in some of our
    +    scripts.
    +
    +    One notable omission is the script to install Docker dependencies.
    +    Address it to bring more structure to the output for Docker-based =
jobs.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
4:  4a864a1d174 ! 4:  5ab11d5236d ci: split out logic to set up failed test=
 artifacts
    @@ Commit message
         ci: split out logic to set up failed test artifacts
    =20
         We have some logic in place to create a directory with the output =
=66rom
    -    failed tests, which will then subsequently be uploaded as CI artif=
act.
    +    failed tests, which will then subsequently be uploaded as CI artif=
acts.
         We're about to add support for GitLab CI, which will want to reuse=
 the
         logic.
    =20
5:  35b07e5378d ! 5:  37a507e9b25 ci: add support for GitLab CI
    @@ Commit message
    =20
         Part of a problem we hit at GitLab rather frequently is that our o=
wn,
         custom CI setup we have is so different to the setup that the Git
    -    project has. More esoteric jobs like "linux-TEST-vars" that also s=
ets a
    +    project has. More esoteric jobs like "linux-TEST-vars" that also s=
et a
         couple of environment variables do not exist in GitLab's custom CI
         setup, and maintaining them to keep up with what Git does feels li=
ke
         wasted time. The result is that we regularly send patch series ups=
tream
    -    that would otherwise fail to compile or pass tests in GitHub Workf=
lows.
    -    We would thus like to integrate the GitLab CI configuration into t=
he Git
    -    project to help us ensure to send better patch series upstream and=
 thus
    -    reduce overhead for the maintainer.
    +    that fail to compile or pass tests in GitHub Workflows. We would t=
hus
    +    like to integrate the GitLab CI configuration into the Git project=
 to
    +    help us send better patch series upstream and thus reduce overhead=
 for
    +    the maintainer.
    =20
         The integration does not necessarily have to be a first-class citi=
zen,
         which would in practice only add to the fallout that pipeline fail=
ures
    @@ ci/install-docker-dependencies.sh: linux32)
    =20
      ## ci/lib.sh ##
     @@ ci/lib.sh: then
    + 		need_to_end_group=3D
      		echo '::endgroup::' >&2
      	}
    -=20
    -+	group () {
    -+		set +x
    -+
    -+		group=3D"$1"
    -+		shift
    -+		begin_group "$group"
    -+
    -+		# work around `dash` not supporting `set -o pipefail`
    -+		(
    -+			"$@" 2>&1
    -+			echo $? >exit.status
    -+		) |
    -+		sed 's/^\(\([^ ]*\):\([0-9]*\):\([0-9]*:\) \)\(error\|warning\): /:=
:\5 file=3D\2,line=3D\3::\1/'
    -+		res=3D$(cat exit.status)
    -+		rm exit.status
    -+
    -+		end_group "$group"
    -+		return $res
    -+	}
     +elif test true =3D "$GITLAB_CI"
     +then
     +	begin_group () {
    @@ ci/lib.sh: then
     +		echo -e "\e[0Ksection_end:$(date +%s):$(echo "$1" | tr ' ' _)\r\e[0=
K"
     +		trap - EXIT
     +	}
    -+
    - 	group () {
    - 		set +x
    -=20
    + else
    + 	begin_group () { :; }
    + 	end_group () { :; }
     @@ ci/lib.sh: then
      	MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D10"
      	test windows !=3D "$CI_OS_NAME" ||
--=20
2.42.0


--Kstn952qmNfwdRwE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU7gf8ACgkQVbJhu7ck
PpSBvA/8D5olFFt4027inz6H4fRysUeUHFPDBTaOeMjUTvxSZfieHAVwI2JwkQBa
S2IQNCV9gM/cKDAHM8Q0fSafFAYl67NsuDkxht6AoFGD+tFwYYDrSqEpOLjnsOEj
aGZ2okpWc+2j1IOITtyotdMbb48yBia8hjPHT+a0GCkoJYzaXiRCTQ9JvAkWaL/F
n1I+jkJEND+lB/zn8LJDQrxnzyS4HFIb12gfXYsMaKD7ewEGTb4HFAxBIBmrDGEP
h1SgAZVfttk2O1ntNABU8q8l/qj42i10AbgREEmsFC5Q0AbDjYiuxpN9Pi0KpDrR
eR3Nw4kGOkWUsd/ABvGt1S1wkrMi4TuvQAgAcKkvdNWq1wLEO72ggAIfdsu+Gssq
HqwTwZt+h8D+HoR2qMiao3ocH3uxpRpo4scK9v1Fcf4/CuTj+JSXl2oY8HNddAWA
7bwH2OjoCd42LqJALclLEMiYqbUh4ZphBCaXlGSxMyxhoHh7sDtMgdu/bfwG8YMj
iQmMIuBOjJPEbMTTLUiR7OL08wUQmwc0mA+SzLomzzVn9+FRPyREPiCbfeuhUo0I
9oPuKFkjFb5FjuLCoYkLkCevQ68D+1oQd3gwUuoOGtndhprbd7gKEtB1oR19oY7D
7RiJ25QPDFQ7CzLs8ifJO49H9/gpiL6z2Q7dPUW1H9Tvc4BuAHI=
=3x8r
-----END PGP SIGNATURE-----

--Kstn952qmNfwdRwE--

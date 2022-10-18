Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A31C4332F
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 14:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiJROsr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 10:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiJROsm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 10:48:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1750D8EE5
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 07:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666104505;
        bh=bKaSDsVB9D4+A2+GPEPTga3o5GepqXO4Q5db1++AnP0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=b1JCbZ/oT01vhLW7j1BrRpQdt9tXg2CHn4EOhCee5YL8kmQAinhzKwYyd63gH1YpW
         2IDjsQvgJIL+ubW44DHdJVDHD3cn8czU0iGcC+/H1pHbLmGaNHw3tzCqf7T3nZGOXf
         5wH3OtFHLw22GogKHcIWoMORoE59cM17RuHurGg4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.67.214] ([213.196.212.100]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1My36N-1p38De14Fr-00zZsA; Tue, 18
 Oct 2022 16:48:25 +0200
Date:   Tue, 18 Oct 2022 16:03:04 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 4/5] cmake: avoid editing t/test-lib.sh
In-Reply-To: <220908.86a67al3c1.gmgdl@evledraar.gmail.com>
Message-ID: <851094n0-2o53-77n8-41o6-773q479q5sqq@tzk.qr>
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com> <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com> <22473d6b8f3d4e4c482c27a4fb3b58705d4c93ca.1661243463.git.gitgitgadget@gmail.com> <220908.86a67al3c1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-721605642-1666080486=:174"
Content-ID: <p0179no8-44no-014s-rn90-n3rrr3084o84@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:7PRJ+XeE6Vkj/CHtJ4wHlt8QzgUZoN6aW8ama6wAB6nakMudayE
 7sP4TuLEitS72lqQu25FT5sQA0I3+Y3Q7guK/lgSUZKAns8xcIid6U4ppDGADujJ+5sMTi3
 FnvJtAKD8gpoYic24ak34/UbMaGciuY6CJdI5vJ168+UPDtDsRS/dlwTtPPT+Aux+daNRTm
 Wo/IxRFJJOZoESU+3nVmg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vkYPoJMtbYk=:dT9+ts/fkJ9F0kJVRqUj81
 rWYVgXFZVqbCoTV+CYW0UcFz0k430wKZl4sLBDcC7/Sz0y0KQZhOBYU3rTtJ3/M3Q1x0O33Bo
 RkEAHEhoBtgcCeFN88hlJ0QuzTM0vj7xPKNSBP5EGcT0f46WMCAtwn7+aQyNob5XgX2OARu1h
 ph7af0SVIXDK2n3Dk9XBZHxdcrr4HJJG44lq6RYLDgvg1D8Ze9Kz6IkAcisPSmED4VZhKAgD1
 p7A7S36p6VdOLkeUStU9uJcH2RG2MOTeylvwbR865VXTb6vQu3YMvAtWpQbgJANewawM52Tgi
 IMDDmJcvGUcT75pnU2mpzI2ghyaYQFo8Y8GmSEU76MVoa/V3kUrmJDXbQqxF4zzoM179cO/ug
 Sy9M0FqO+ASpRBTzeRj60Qe7pyoqYFyTU/uR1Cc8iUiGw+A9YWE3SkMphg4fTxFZYECgUoBp4
 2hPfC6bMYUJ3aoyZI+8+XvuwKQI5beoeWrXmnphMIywNlu2VjamKShFBXkwKxLEyLF+HV8lQg
 mIcfFdDvxVCGRYOHiGONRhy+pFCeSeCvWw9XPfeDr7Ncrs2GiBy4df5Hvjt9P46cTeznhc4pt
 OEd09aTkCYzJMbpTKDY/nhdQPtJq3xS/CuE7YZrB1FtjVHEp/VYGK9xklGSqNmunL2/3xvIt3
 JIiualbLiGGonpi3Ne93xqIOhgmehN1jbSq7nPRz+PTnlnyR2GDJ+BTp1/Gcowa2rbfoir/Ou
 l3+fNlR7MDzHCjJhRmKwO2Qvcjj6ALILa8U3vjQfJxqBHOXZ4dzuOB127+FQUZdrua5tCxO6f
 rQrC4QPeNrJ6IOpYAkoKp9c6Sc9gJ3eXzLldRUFUY8pyg6rY6l23Z+9zHY51anl+G5b9/RhPy
 BvRKZK+tjjVI1YmwtIJbvZFVgkmDlN6xlxQ4o8Jb9JzoEp3SnbhPWU5OVqHfiz1UzdMJXyBjk
 EX02HMfWmgXVHJKx0Gw/88SH6K9V8gVRICtfXzD88lD5hLwNzBDBF+kMjLFeKc/RTylPCyP8l
 L0CzNv/Z1xi3whkDs1vdJwADd+y/2pgsdlGF2qy5xjC7PN9FO38hsJ9v2Q0zteMS4Vv08+6cQ
 q1VG03WMqhWkSKbMNzlg0VuixOIkMLNMaU47TwQ6dCHChp+ENjvDNq1sunorXrFjDpgmYYIHP
 XMX3l92AJRCJvRtGolL9HTXIjyrp0mUolvo9esUtP1NsINdlDRmwwKBAAWObmaETKMtAPyZrO
 AWa8LloQg2jR93IcR1WOtXrpSchILQZ1V2yrOe/HWitx9pjaOvpGRYNoQfgbYKtOtoQibkZpw
 XnOdpIvV/tu41xq3iEizofZqR2of7AuHYQMCIxmpClFLZR6NqW7OEARwVgusLyaunT32sdk6p
 zVJcdBUIhkvaLxSVaabWN87+f5qxsG3KnTHDrpLkKTmQ/rTzmAjr62BDPmMfhS1beseicED7C
 Y4I5P/OH9w8tsfRN/QlxQoJiXwBG1qihJFdsGz+K1e+uw+zZGQrG+5yYBv5mAqGkHsBg+zIqN
 Z40GHYK9ICfB6MQ43XX6RnBwo5ByiqapsuuC9RdlLbFtLcOL6D1WDpLY98u7jReNbHQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-721605642-1666080486=:174
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <3so00q52-0s5q-7456-q440-pp2p0p5108pp@tvgsbejvaqbjf.bet>

Hi =C3=86var,

On Thu, 8 Sep 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Tue, Aug 23 2022, Johannes Schindelin via GitGitGadget wrote:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > In 7f5397a07c6c (cmake: support for testing git when building out of t=
he
> > source tree, 2020-06-26), we implemented support for running Git's tes=
t
> > scripts even after building Git in a different directory than the sour=
ce
> > directory.
> >
> > The way we did this was to edit the file `t/test-lib.sh` to override
> > `GIT_BUILD_DIR` to point somewhere else than the parent of the `t/`
> > directory.
> >
> > This is unideal because it always leaves a tracked file marked as
> > modified, and it is all too easy to commit that change by mistake.
> >
> > Let's change the strategy by teaching `t/test-lib.sh` to detect the
> > presence of a file called `GIT-BUILD-DIR` in the source directory. If =
it
> > exists, the contents are interpreted as the location to the _actual_
> > build directory. We then write this file as part of the CTest
> > definition.
> >
> > To support building Git via a regular `make` invocation after building
> > it using CMake, we ensure that the `GIT-BUILD-DIR` file is deleted (fo=
r
> > convenience, this is done as part of the Makefile rule that is already
> > run with every `make` invocation to ensure that `GIT-BUILD-OPTIONS` is
> > up to date).
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  .gitignore                          |  1 +
> >  Makefile                            |  1 +
> >  contrib/buildsystems/CMakeLists.txt |  7 +------
> >  t/test-lib.sh                       | 11 ++++++++++-
> >  4 files changed, 13 insertions(+), 7 deletions(-)
> >
> > diff --git a/.gitignore b/.gitignore
> > index a4522157641..b72ddf09346 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -2,6 +2,7 @@
> >  /fuzz_corpora
> >  /fuzz-pack-headers
> >  /fuzz-pack-idx
> > +/GIT-BUILD-DIR
> >  /GIT-BUILD-OPTIONS
> >  /GIT-CFLAGS
> >  /GIT-LDFLAGS
> > diff --git a/Makefile b/Makefile
> > index 04d0fd1fe60..9347ed90da7 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -3028,6 +3028,7 @@ else
> >  	@echo RUNTIME_PREFIX=3D\'false\' >>$@+
> >  endif
> >  	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
> > +	@if test -f GIT-BUILD-DIR; then rm GIT-BUILD-DIR; fi
> >
> >  ### Detect Python interpreter path changes
> >  ifndef NO_PYTHON
> > diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystem=
s/CMakeLists.txt
> > index fe606c179f7..29d7e236ae1 100644
> > --- a/contrib/buildsystems/CMakeLists.txt
> > +++ b/contrib/buildsystems/CMakeLists.txt
> > @@ -1067,14 +1067,9 @@ endif()
> >  #Make the tests work when building out of the source tree
> >  get_filename_component(CACHE_PATH ${CMAKE_CURRENT_LIST_DIR}/../../CMa=
keCache.txt ABSOLUTE)
> >  if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
> > -	file(RELATIVE_PATH BUILD_DIR_RELATIVE ${CMAKE_SOURCE_DIR} ${CMAKE_BI=
NARY_DIR}/CMakeCache.txt)
> > -	string(REPLACE "/CMakeCache.txt" "" BUILD_DIR_RELATIVE ${BUILD_DIR_R=
ELATIVE})
> >  	#Setting the build directory in test-lib.sh before running tests
> >  	file(WRITE ${CMAKE_BINARY_DIR}/CTestCustom.cmake
> > -		"file(STRINGS ${CMAKE_SOURCE_DIR}/t/test-lib.sh GIT_BUILD_DIR_REPL =
REGEX \"GIT_BUILD_DIR=3D(.*)\")\n"
> > -		"file(STRINGS ${CMAKE_SOURCE_DIR}/t/test-lib.sh content NEWLINE_CON=
SUME)\n"
> > -		"string(REPLACE \"\${GIT_BUILD_DIR_REPL}\" \"GIT_BUILD_DIR=3D\\\"$T=
EST_DIRECTORY/../${BUILD_DIR_RELATIVE}\\\"\" content \"\${content}\")\n"
> > -		"file(WRITE ${CMAKE_SOURCE_DIR}/t/test-lib.sh \${content})")
> > +		"file(WRITE ${CMAKE_SOURCE_DIR}/GIT-BUILD-DIR \"${CMAKE_BINARY_DIR}=
\")")
> >  	#misc copies
> >  	file(COPY ${CMAKE_SOURCE_DIR}/t/chainlint.sed DESTINATION ${CMAKE_BI=
NARY_DIR}/t/)
> >  	file(COPY ${CMAKE_SOURCE_DIR}/po/is.po DESTINATION ${CMAKE_BINARY_DI=
R}/po/)
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index 55857af601b..4468ac51f25 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -42,7 +42,16 @@ then
> >  	TEST_OUTPUT_DIRECTORY=3D$TEST_DIRECTORY
> >  fi
> >  GIT_BUILD_DIR=3D"${TEST_DIRECTORY%/t}"
> > -if test "$TEST_DIRECTORY" =3D "$GIT_BUILD_DIR"
> > +if test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
> > +then
> > +	GIT_BUILD_DIR=3D"$(cat "$GIT_BUILD_DIR/GIT-BUILD-DIR")" || exit 1
> > +	# On Windows, we must convert Windows paths lest they contain a colo=
n
> > +	case "$(uname -s)" in
> > +	*MINGW*)
> > +		GIT_BUILD_DIR=3D"$(cygpath -au "$GIT_BUILD_DIR")"
> > +		;;
> > +	esac
> > +elif test "$TEST_DIRECTORY" =3D "$GIT_BUILD_DIR"
> >  then
> >  	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?"=
 >&2
> >  	exit 1
>
> As pointed out in the v1 this breaks the cmake<->make interaction in
> some scenarios, but from some brief testing there seemed to be an easy
> workaround which didn't suffer from that problem:
> https://lore.kernel.org/git/220811.86sfm3ov5z.gmgdl@evledraar.gmail.com/

I do not think that the CMake <-> make interaction will come up in any
other scenario than your and my tests in the context of this mailing list
thread.

Therefore, I am certain that we need not cater to that scenario at all.

Ciao,
Johannes

--8323328-721605642-1666080486=:174--

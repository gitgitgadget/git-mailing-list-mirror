Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F97EC433F5
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 17:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348279AbhLBRll (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 12:41:41 -0500
Received: from mout.gmx.net ([212.227.15.18]:33609 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348225AbhLBRlk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 12:41:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638466685;
        bh=ABmu4ioovTnBxy7YyzDU0YKxDHgQpQm3v4BIUQofEww=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CAGi7ei8gwDptGK+4tldY4+zfTmJgFCXv956JZLpsp4RQs1wrTsZE3DCL81KD6+yI
         cx6wt0bXS99Zn4wMvXZTwGm2PaD7W+d5dbPJ3MyS9DQUpgbVlUPL6zNgW0/bXJuTwG
         knGuPFLhyncrHvI7X0hfYOHtbQ7PxecRbBvEVzgA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.223]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MK3Rs-1n9xhr0vtO-00LW0K; Thu, 02
 Dec 2021 18:38:05 +0100
Date:   Thu, 2 Dec 2021 18:38:03 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v3 1/1] git-compat-util: add a test balloon for C99
 support
In-Reply-To: <20211201014050.38002-2-sandals@crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2112021836170.63@tvgsbejvaqbjf.bet>
References: <20211114212437.1466695-1-sandals@crustytoothpaste.net> <20211201014050.38002-1-sandals@crustytoothpaste.net> <20211201014050.38002-2-sandals@crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ysHmXb0z2UovulgmRLaNHBa6T3HgqNY0FCAPX89p2Jo4MbPNnD9
 9qSRrceOa0FCe9b6A+2SUJdTB1lRQ7PWABoEIhC8Uby6yn9mN2IZXW+OpagXqD8Rdf2OT0f
 zLqGVKOJqWZpgNEKS9YoLAZ85FdJvEj855Ht6PLo1uGDcEdVPhXS9iosEoT7argl6VitxQe
 OXBWsPLEimfvHN0MjT63w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3L3Yn0q0iwk=:pxzUg8OLsXNgwWyllazF8Z
 vd4HjjGIA35rgpiDoQ8103/stOXpt6qvnDkGM/+cPWknT6Bh398V+njcdlGkB4lirf4yFrY97
 w33vszHGRIXPNAaQ6qAced774MKlgY+0es7f7IEa7LEaXa032Ojg7d/9oiZIUbtIa+DUOztFX
 s1F2pkj+DrrnLoa0F+b/d2bq0/nqg836qJxrVEdBt3kCXWmXg0doQlDS6YvGNA9uoL9kj4z31
 rK3s418oE7mePsg8SVNo/5iRE8O2rWT+2TJblsW6Lk3B3zyAMsnel7zzKRoJVStETFCLishOv
 Ve28dTwK2UqR1dTgZ2sVnTjPhi0avVp6pICdbCmiz1502ReSCTcJHnVNIDMcejGq3hj7toGWg
 PT7Kwns4VcJgIrOLq2dkXQXEQJJqSpoVWmmU8c+2Vj0aGNS3ZaM1VbPbPnGgr3jpkHFIqZu5a
 h3aJ7yp5gF+3oGb2Su+VTD9CJM4qktCzO7Zzxu8mtmFuEzGsC9wOxbKrx2MX6p6wV546HXY5E
 dqr8PYG2T/3IYU2UCaLgaGv5WMPWuFic8ptdPQoYPp/Pc48sVRNO3K+FecDhGJxrOE3HCjqAS
 H9RIZtzHtuHdj65v8LKa2vTLGGwpGWWHj2IUanf1oSkujlsRktcCtqNufRarvFUqcGCHHUnuK
 Dn19qk4dpTNP/aroOpqTtUH8a2qi8GleXFR9wfq6yZFgQS+5iXBSEz6LN15H6YspmJyjlzpJJ
 pqViNbN7LlOs8+07miI9rxxIG1oePPf2j/p20ILDZ3nFgmINOO/2L7qEhMoS4x6gCW2HUhGEj
 DmhikUNsVTGFwv2EqVvs3p6c37hq7+nMGGdIrRLbZo4GMosWgnrUTbHGBXziNaMFaklKZmFmH
 IPrDsMmP8BBOBPWNtxOMo7fUYAjsSquGhQf/6cXp1/l6ejnvz6YYO32Tiv9gf+LUJo1AZwcfl
 1qguhCYBCzVQ74QIPHSTazhqXuUiPuO2BrlN3Y1RagdKLirYf28W4PzPTHTYFQUjVeeYblQ/U
 fTHs/n5DN08s/JRU4iHNH2ApWxvNBuSPcUw9c1Psp9JMXj7hnSzCwT20w3onN9mBhA7F3W1Ns
 CYNxRcImQfBkaI=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Wed, 1 Dec 2021, brian m. carlson wrote:

> The C99 standard was released in January 1999, now 22 years ago.  It
> provides a variety of useful features, including variadic arguments for
> macros, declarations after statements, designated initializers, and a
> wide variety of other useful features, many of which we already use.
>
> We'd like to take advantage of these features, but we want to be
> cautious.  As far as we know, all major compilers now support C99 or a
> later C standard, such as C11 or C17.  POSIX has required C99 support as
> a requirement for the 2001 revision, so we can safely assume any POSIX
> system which we are interested in supporting has C99.
>
> Even MSVC, long a holdout against modern C, now supports both C11 and
> C17 with an appropriate update.  Moreover, even if people are using an
> older version of MSVC on these systems, they will generally need some
> implementation of the standard Unix utilities for the testsuite, and GNU
> coreutils, the most common option, has required C99 since 2009.
> Therefore, we can safely assume that a suitable version of GCC or clang
> is available to users even if their version of MSVC is not sufficiently
> capable.
>
> Let's add a test balloon to git-compat-util.h to see if anyone is using
> an older compiler.  We'll add a comment telling people how to enable
> this functionality on GCC and Clang, even though modern versions of both
> will automatically do the right thing, and ask people still experiencing
> a problem to report that to us on the list.
>
> Note that C89 compilers don't provide the __STDC_VERSION__ macro, so we
> use a well-known hack of using "- 0".  On compilers with this macro, it
> doesn't change the value, and on C89 compilers, the macro will be
> replaced with nothing, and our value will be 0.
>
> For sparse, we explicitly request the gnu99 style because we've
> traditionally taken advantage of some GCC- and clang-specific extensions
> when available and we'd like to retain the ability to do that.  sparse
> also defaults to C89 without it, so things will fail for us if we don't.

I agree with this revision of the patch entirely, especially with this
paragraph.

If there should crop up any Windows-specific issues, I will be glad to
have a look at them.

Thank you,
Dscho

>
> Update the cmake configuration to require C11 for MSVC.  We do this
> because this will make MSVC to use C11, since it does not explicitly
> support C99.  We do this with a compiler options because setting the
> C_STANDARD option does not work in our CI on MSVC and at the moment, we
> don't want to require C11 for Unix compilers.
>
> In the Makefile, don't set any compiler flags for the compiler itself,
> since on some systems, such as FreeBSD, we actually need C11, and asking
> for C99 causes things to fail to compile.  The error message should make
> it obvious what's going wrong and allow a user to set the appropriate
> option when building in the event they're using a Unix compiler that
> doesn't support it by default.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  Makefile                            |  2 +-
>  contrib/buildsystems/CMakeLists.txt |  2 +-
>  git-compat-util.h                   | 13 +++++++++++++
>  3 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 12be39ac49..3d0ce6ddf6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1215,7 +1215,7 @@ ARFLAGS =3D rcs
>  PTHREAD_CFLAGS =3D
>
>  # For the 'sparse' target
> -SPARSE_FLAGS ?=3D
> +SPARSE_FLAGS ?=3D -std=3Dgnu99
>  SP_EXTRA_FLAGS =3D -Wno-universal-initializer
>
>  # For informing GIT-BUILD-OPTIONS of the SANITIZE=3Dleak target
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/=
CMakeLists.txt
> index fd1399c440..07b6c5494b 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -208,7 +208,7 @@ endif()
>  if(CMAKE_C_COMPILER_ID STREQUAL "MSVC")
>  	set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR})
>  	set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR})
> -	add_compile_options(/MP)
> +	add_compile_options(/MP /std:c11)
>  endif()
>
>  #default behaviour
> diff --git a/git-compat-util.h b/git-compat-util.h
> index d70ce14286..ffe70b570f 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1,6 +1,19 @@
>  #ifndef GIT_COMPAT_UTIL_H
>  #define GIT_COMPAT_UTIL_H
>
> +#if __STDC_VERSION__ - 0 < 199901L
> +/*
> + * Git is in a testing period for mandatory C99 support in the compiler=
.  If
> + * your compiler is reasonably recent, you can try to enable C99 suppor=
t (or,
> + * for MSVC, C11 support).  If you encounter a problem and can't enable=
 C99
> + * support with your compiler (such as with "-std=3Dgnu99") and don't h=
ave access
> + * to one with this support, such as GCC or Clang, you can remove this =
#if
> + * directive, but please report the details of your system to
> + * git@vger.kernel.org.
> + */
> +#error "Required C99 support is in a test phase.  Please see git-compat=
-util.h for more details."
> +#endif
> +
>  #ifdef USE_MSVC_CRTDBG
>  /*
>   * For these to work they must appear very early in each
>

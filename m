Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA10C433FE
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 10:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6432263217
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 10:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbhKPKd3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 05:33:29 -0500
Received: from mout.gmx.net ([212.227.15.18]:47429 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234119AbhKPKd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 05:33:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637058610;
        bh=IXJJg8hYkLDGiblqsOAgdodnaOusys9+p7YFD48Bmq8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TKnwwTli9Etqv/vf9a1kT1Si/BhKIh/7iltSlBXcD+6aEmPHyqfZELogkGH7KrJyh
         Ms3GRCgS9E6s/8rfktqL55WqDbDf1WwdV3vesnCNHjhORtpXwEL22imWxzx1YevbHm
         RnBKCkd7VASMU6IAs7HiBNgYJP0Wvb9zbVcuD4rc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.166.205] ([89.1.213.220]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MybGh-1mTu0N23en-00yv7U; Tue, 16
 Nov 2021 11:30:10 +0100
Date:   Tue, 16 Nov 2021 11:30:08 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] git-compat-util: add a test balloon for C99
 support
In-Reply-To: <20211114211622.1465981-2-sandals@crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2111161129120.21127@tvgsbejvaqbjf.bet>
References: <20211114211622.1465981-1-sandals@crustytoothpaste.net> <20211114211622.1465981-2-sandals@crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:so+CbTRb1V4u+dNbyXhgiBCoB1NGfcNUanfWsEqpjre4lAl/XBs
 BQ6pErPBU2N49tIzdBK9REBtve0inetneRAp2xbT0Oe9IMyGcZ3kmSFkkALk1JyI9WTVfnQ
 gxyY6ZtgPpYVJWkKQqrfl/dQ/bLLocKSwWGdQ3T/JhqDAUECYcW6Y2nShl6oph7xNrdXPSI
 E0Sn0ChTmBZVBcRWHAc4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Op2JZUiOg5s=:7bLIQB4jnEkpluMEAKYxvZ
 KrCxTXgKwivoJXPosbnr/kBYF/cZWg0bedgmWF6rcauCPhy7QuILfBFx1qaKYyJQCkdkkEtuE
 Xx3t/YwADLyaBGcEJd0DAYa6lzcLGcem6B0N3rYNya8SwxaMkj9WdosuQQQL46mLDXSeSSlgg
 Iv8XhBZyO31dOqywPs7BKbpEEuZpKZV9mgMJqMOQm2kxPjMY0cycQyU4XE7jg5tR0yNcf/D//
 rbHqNzi1XtxVzV6TFo2oTNkVXFefuHb1Q6cNBvKjb2DJd4uV1UlfxqiRrZednif/bflspbW55
 EgqxI9He60p8RsN4z3Zc9jWJqgojYs819b/ppLUCIdOFCjXMs4XNFhZy3kbOG7fwauIAU+xP8
 2CKygGj1XwITD+xb3aRCzTkjzGWSRV5LeCP0KGBmytSrJlqpuQgozHCaqoLNu0FB+reMwxLOb
 xR8NJVr2AqmguyuDXyoKI7FgKXBKwIwRfdVJc7xq3nYHdjFyWSFeXItva5pP5ZvW17c2dGSVX
 RJAa6KCrjRYY0HzkP150/MWjIgoLc+OJjgwRNEiB2BntIflPVqf//SmOrOpAPbGSgxi7PPbxY
 eiPH8rtVBmikp3nzcT60lmngH2wIRCCWPG97bDWYKsi1WIsDve8lLdKvRpzdHRdMj7kbf59M2
 JGtaYOUQMTz0e3zs9kzBu9yclXr5j8zsq6cHNje7vFPCCOtDCZOzA2Ba6LM06HA/uWS32lRAX
 gCMbTj7CO6GC6/CCDfLcvjSkhTTVL85J3lbzs6oNkn7GVNLc+i/G46hxTnr8ixIsldNMR+aJ0
 unjOkhryXzRUijwO7aXobkgzYqekuWZOh1IdKZRnYKJ5DCxFVDWmKdFZOBjFbJvuGY/t9oIcN
 XtieOG4EYp/9N+cJ+1G+t36rRiysuOK7mM65UObH55aE48CBK1KRRXMTUjp4U3m9/SJ1c6xl7
 U4vTVIMW6kHaEtvPn4UmN5SMG5P+u/KoHfJ/jV2OYqOp4glEJmhqtetFdSusHGQfFLEqSfl3W
 5bJ5LwST3tM3DJW5AE8i7FBcx0wOpJqFMlohlZca98uYhEbR2p/5qvasnoSuW4uSNjDjfVCUl
 iMXAP7qq6zxEGY=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Sun, 14 Nov 2021, brian m. carlson wrote:

> The C99 standard was released in January 1999, now 22 years ago.  It
> provides a variety of useful features, including variadic arguments for
> macros, declarations after statements, variable length arrays, and a
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
> Sparse is also updated with a reference to the gnu99 standard, without
> which it defaults to C89.
>
> Update the cmake configuration to require C11 for MSVC.  We do this
> because this will make MSVC to use C11, since it does not explicitly
> support C99.  We do this with a compiler options because setting the
> C_STANDARD option does not work in our CI on MSVC and at the moment, we
> don't want to require C11 for Unix compilers.

I am all in favor of this patch!

Thank you,
Dscho

>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  Makefile                            |  4 ++--
>  contrib/buildsystems/CMakeLists.txt |  3 +--
>  git-compat-util.h                   | 12 ++++++++++++
>  3 files changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 12be39ac49..22d9e67542 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1204,7 +1204,7 @@ endif
>  # Set CFLAGS, LDFLAGS and other *FLAGS variables. These might be
>  # tweaked by config.* below as well as the command-line, both of
>  # which'll override these defaults.
> -CFLAGS =3D -g -O2 -Wall
> +CFLAGS =3D -g -O2 -Wall -std=3Dgnu99
>  LDFLAGS =3D
>  CC_LD_DYNPATH =3D -Wl,-rpath,
>  BASIC_CFLAGS =3D -I.
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
> index fd1399c440..91e8525fa9 100644
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
> @@ -600,7 +600,6 @@ endif()
>  list(REMOVE_DUPLICATES excluded_progs)
>  list(REMOVE_DUPLICATES PROGRAMS_BUILT)
>
> -
>  foreach(p ${excluded_progs})
>  	list(APPEND EXCLUSION_PROGS --exclude-program ${p} )
>  endforeach()
> diff --git a/git-compat-util.h b/git-compat-util.h
> index d70ce14286..6d995bdc0f 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1,6 +1,18 @@
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
> + * support with your compiler and don't have access to one with this su=
pport,
> + * such as GCC or Clang, you can remove this #if directive, but please =
report
> + * the details of your system to git@vger.kernel.org.
> + */
> +#error "Required C99 support is in a test phase.  Please see git-compat=
-util.h for more details."
> +#endif
> +
>  #ifdef USE_MSVC_CRTDBG
>  /*
>   * For these to work they must appear very early in each
>

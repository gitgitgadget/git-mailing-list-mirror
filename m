Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BDDC433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 13:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE4FD6140A
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 13:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbhKRNgE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 08:36:04 -0500
Received: from mout.gmx.net ([212.227.15.19]:56499 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229914AbhKRNgD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 08:36:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637242373;
        bh=n3aZOP8Kx7ZYZHJZsr1DAPNJ26hii0IzpoyKIQ4pXBo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=K1bejXJP9utAFxAphJp3Dh8I7uePkHe3csbwjl0jMXgysCB5VP4PEwWDBqCeHMYWI
         iBUe21uBlby9jUyDLnpGM8jc5O/tjkNZHJ/IlORsyGajbs0z7eKm0pxsrvXzXQ38cV
         530mf73t2Aw34jnYnAoyFD+ULXNaefuRi9kfbkDQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.166.205] ([89.1.213.220]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6DWs-1mlUc90qwy-006ir0; Thu, 18
 Nov 2021 14:32:53 +0100
Date:   Thu, 18 Nov 2021 14:32:51 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Matt Rogers <mattr94@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v7 05/17] cmake: optionally build `scalar`, too
In-Reply-To: <CAOjrSZstAHwWxW_m0jSeDN9wgKC3p7oGJYDYRPL27q67GS7Y+g@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111181422230.11028@tvgsbejvaqbjf.bet>
References: <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com> <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com> <dbaad4753c156487e91b766ebd3c9a39d68c1b12.1637158762.git.gitgitgadget@gmail.com>
 <CAOjrSZstAHwWxW_m0jSeDN9wgKC3p7oGJYDYRPL27q67GS7Y+g@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:OBfJ8Vvt1YuarbjhUb++XLhuKDWfaNbx/PkSBiLanhKlLYMHR3v
 YqHkIB//L082E72uDIJ5p2DPAv8IbQtyjAK4xuGWx4w6OU8lubw6j+VmkPs7zFp4uocw/HR
 4trpng6sqXacS52oCV6W2v7jJp/bwqg4tvhFbnejcn/FqBDZQ9Add251IZybv8KL1+99MX9
 e6j50shlf7HCIAlHKD+7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jeqoNsXlLAU=:yXvhA6GD2AS45MSdRtKpzR
 s2cXiN0AjehrHDEqshgmWqT8v5IEbh5knkv5nSkCZP17dSl0cynp3ypyA+dHAhntCldSVAM2F
 +W0894d/UkCbBWl+P3hgeTUGjDIfVgNRIHt3+D96rLJkwWLYo7IS5K0pjXsTMi2GYPBSHFY1p
 O8OIF8VY0irNxnk71ljqD381NUT8C8FNmm+F1gMOa6YxHk6E7CQlwmKf42drjG+xHTgUWcihO
 HAybTB7VteSHg9uXGTiSCOEPPKVCiXegjZ5zp+SOGdc7VLyWhqehC4Q7ANpVZqVOqzbWqTHaG
 r8kzGM5DqxBgi+zMrvFTiCfMLpwKldUWYJx524Q5J6ZIjxDNGGx5pjWnb+VykCpsocS23kHGQ
 +s8maNp9+3Jfp4hkaOUIz7uZvqq5lXdSsnLHpQkZqoNTYfML2E3D4/JcHrOaBxrL9ZjursKBq
 GCD/yL7dXAmoFi6dljnRgGlVjPPcAJZ8VefSLIwqcOR+rXuHIeg3oAyZwH6kmaKXIYrFheRXD
 syW+NiIm5PqEXs1VeQMHtpaJEYpaTIlajhU0WQvwZ3R/PhZ2Iubncv/Lw34W1h6kLiEWzflwT
 a/j8OGluxQDKiGMIBrgcEdO5t2p7zy8vLI35Kgn7jzzWDB+qwJdx6F9cNnnwtdO3inCZW9uE7
 N3pdTUp9XkfxFyyVsmYQxF/KuLZhto8CWbR5nT2V+GgS0ny/8bsPGDfiTe/9tj24Cc0zhDis0
 Rq5q7Iyep6hnXRmjW0RV1E79s3C2qJ8hqQ25h5Q0JdDzMwyW7z7eue05yL2rm5Smg60onEL9O
 0edZx5rl+25OPPuw6fqmNJYjL1lItQ8yWpuRTcoxKVLaSFCf5FArtvs2OGTCMWfD9fh4gBXjb
 ap4BU/QDSBsXaEA80NOx9C6gmmM15OZq9j3OGW628/SFuz92dRaoI/zKHx8LkPOSVKV7Q7bGV
 psqjS/BrtgAgj1t1jYgRFnItpMRfFgOjeDEZjFe7M57rvvIOUk4Qe+gNXnuv+cYBphUs1XVB4
 siK/87sRE5rnLIRoLAJkbU/n4ZPUIarW9tVAha4+hGINEvjuA3K6AA778H9un4ci2XHIshRVr
 e2sHhT5dO+frIY=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matt,

On Wed, 17 Nov 2021, Matt Rogers wrote:

> On Wed, Nov 17, 2021 at 9:49 AM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The CMake configuration unfortunately does not let us encapsulate all
> > (or at least the vast majority) of Scalar's build definition in the
> > `contrib/scalar/` subdirectory.
>
> I believe that this isn't fully correct in that you could call
> add_subdirectory() with a directory that isn't a subdirectory so long as
> you provide it an explicit binary directory which is part of what we're
> doing here anyways. (at least it works fine for me with cmake version
> 3.21)

You are of course correct, you _could_ put things into a subdirectory with
CMake. However, please note that `scalar` wants to link to `libgit.a` (and
also link in `common-main.o`), therefore the subdirectory _still_ has to
have some sort of connection to the top-level configuration.

I shall clarify that in the commit message in the next iteration.

> > To alleviate that somewhat, we guard the inclusion of Scalar via the
> > `INCLUDE_SCALAR` environment variable.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  contrib/buildsystems/CMakeLists.txt | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystem=
s/CMakeLists.txt
> > index fd1399c440f..dd7496b0322 100644
> > --- a/contrib/buildsystems/CMakeLists.txt
> > +++ b/contrib/buildsystems/CMakeLists.txt
> > @@ -729,6 +729,13 @@ if(CURL_FOUND)
> >         endif()
> >  endif()
> >
> > +if(DEFINED ENV{INCLUDE_SCALAR} AND NOT ENV{INCLUDE_SCALAR} STREQUAL "=
")
> > +       add_executable(scalar ${CMAKE_SOURCE_DIR}/contrib/scalar/scala=
r.c)
> > +       target_link_libraries(scalar common-main)
> > +       set_target_properties(scalar PROPERTIES RUNTIME_OUTPUT_DIRECTO=
RY_DEBUG ${CMAKE_BINARY_DIR}/contrib/scalar)
> > +       set_target_properties(scalar PROPERTIES RUNTIME_OUTPUT_DIRECTO=
RY_RELEASE ${CMAKE_BINARY_DIR}/contrib/scalar)
> > +endif()
>
> Would it make sense to just mark this with EXCLUDE_FROM_ALL so that way
> you don't have to have the INCLUDE_SCALAR environment variable just for
> this?  This way people who don't want to build scalar can still run
> `cmake --build .` and not have scalar built and people who do want it
> built can just run `cmake --build . --target scalar`, alternatively you
> could also do something like
>
> if(DEFINED ENV{INCLUDE_SCALAR} AND NOT ENV{INCLUDE_SCALAR} STREQUAL "")
>     add_executable(scalar ${CMAKE_SOURCE_DIR}/contrib/scalar/scalar.c)
> else()
>     add_executable(scalar EXCLUDE_FROM_ALL
> ${CMAKE_SOURCE_DIR}/contrib/scalar/scalar.c)
> endif()

The entire point of pulling this patch from a much later patch series to
the first Scalar patch series is to allow for easy testing in the CI
build. To that end, what you propose would complexify the setup too much
for my liking.

Since the end game seems to be for Scalar to become a top-level command
(at least that's how I read Junio's favorable reply at
https://lore.kernel.org/git/xmqq7ddnz115.fsf@gitster.g/), I suspect that
it might not matter whether we stay with `INCLUDE_SCALAR` or change it to
an idempotent alternative, anyway.

Ciao,
Dscho

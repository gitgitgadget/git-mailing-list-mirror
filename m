Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C21C4727C
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 15:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD76820759
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 15:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Wm4fOF42"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbgI3PZX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 11:25:23 -0400
Received: from mout.gmx.net ([212.227.17.21]:44197 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbgI3PZU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 11:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601479517;
        bh=3/3Sx7gGFXqmPSvf0eHo9esHXgn/crPGR2ag5TcuAQ8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Wm4fOF42O7BXT/HJpUExYqNVD0vnyICI88gGxzhU7qSyggqqOGNmDuqEhYT0lb3DP
         T+x0OZCU4YbTjwxvBeq2xYap4D1//rmjqzVs37NUIa36YIfO/3DElNNxOe8RFMMm8B
         CT/mi/l7XWnC5Y9BVJu7kXVU8dWBayKKWqz3amZQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.113.174] ([213.196.213.65]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7b2T-1kKeES2XZl-0084om; Wed, 30
 Sep 2020 17:25:17 +0200
Date:   Wed, 30 Sep 2020 17:25:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 08/10] cmake (Windows): initialize vcpkg/build dependencies
 automatically
In-Reply-To: <CAKiG+9W71vEd3bUOEq=vtgcaHuWsjmzGqAdg-rszMANrskQDzg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2009301722500.50@tvgsbejvaqbjf.bet>
References: <pull.738.git.1601044118.gitgitgadget@gmail.com> <3a07bd4916c3949eadaa10fde142fba0acaa974b.1601044118.git.gitgitgadget@gmail.com> <CAKiG+9W71vEd3bUOEq=vtgcaHuWsjmzGqAdg-rszMANrskQDzg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:0KPXxxgOFx2xNnRp3hXZ8uaycjkmcDFuVRAaqWcfhuAoFunbtjv
 Zj9Jz9CzzCn+ZHAeCS+7ILJgkM6BgggjHvw6CKofRLfxElbDsvTxloaaIgBaiz3zch+W3Qx
 XOOrUoSyHt51dgitY5AEzMe05FpJ+5NY4uKfabp8SjkjA9L+wsiysRonwuUmJILnijD0CdA
 nq1Tq357Y5mQw56yrBbNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mb4RHiMMvKI=:6jkG9CKH/RKIMuofoD1pn8
 O1il+FgEFNz1/rfzXl2Rw/9yFp8CcliQcyc8FBA3xYn6px+wPZaSN5b3hSwGGFRBTteVc9Ycm
 UxwQGRuY/3nUp3qOY7sJyv2tAA884cpbExyhWfp+q5t9IZV0Xw7dn/y5xMpfFcYAS6FmfpINJ
 +4QKTq4DDr+TJSLLAXwYT3rd/hS+T79XUMmLBsV08wgMz/OimLOsYnIC46+Vc31QPZfuD89QY
 zmxvPmsuQvCByPC9aVMa/kXytX+KctLWyjLaTWV8Bigumg53RT+060TnKXk9QaO4QWvTfkh1b
 jGSrHTZ7YdKpccWXHBd4sRe4oYMaWlgiyNxHIruhHWFdH9LKzVoS1WykL8qcALLBffn7WMOs5
 2jBRwU9ZzRLO8Bhg0WqmO6bsOZDb83rW2HnZJS9FLFJyJdzYE0LJ7NfcGqdUcUTfshQlKSyOQ
 rW1nIA2/yT++EFJt+ZWg2KaKyuFONYaiBQ9NTLGfVrAezVIJcpgkCI4JgLs9PhRsqIe1+7fh9
 saEdn0640j0fRECInZFEs3sQRfhTuqwQVGNuGkAtg5XhIdOibST3y9a0UhutJRnu5n7AipKo6
 0yyfkdhyYyWK5ayOuOwD+TfGe8J4G7Bru29rwstFXHr+YJRdLHd9iG/yCSaGsR5UoqJpFyN3F
 JVtQ9BblkhiWuBuDn9KfSNVWsuaWVCoiP6LjXq376wjS6lFbl/P1K0zC5uBYU0z8Okt8whStw
 frz1S03fIKhTQRBKi88OijGqy+NVbo1pz7gCRI49B0gXkYSpBSUYWFhBrxyriUnxSEgg83sz3
 v17ADEhnX/xOdKQH3Yp8/Xl2OokCEtfE8JsmgFh7PDb0KEY8NTyjXxD+m87/U6AD+Uz+3xk2A
 iSAhF02eelYSevg9Ed7EarW1ETtJoLxGAOm/DhxYaQlFSN3TkG+oXfqTCxiw7xI+33VLc/2HA
 bR81TYkyiHlSh1+58KGJjCe4RAPYUXqN3E+XWUnL3Emn2+cUgWrmqJ33iQkH2y5aYvNwPKkIc
 OZwGCsqFeTvShbkwshLN3c94kmb113c4R3qnLzWP2QlG5iL/cYOiLc95ls+BWL/sAg8QhjoWf
 V1tC0MUC0ibgzDUlC67s9pa730GWp7S014SZaS9uexm/FE3QofjoN5ZYr3QCOJ5V+mw+di3BG
 7EpHiFSnXt6JgjXG8hX0Qe8YU0Svog2rY0heFMBhR6fWK/cfkC/1EGaSf1A+d6ks/fn5ZLSoE
 NGZdj5eHhw8UBi0L1L+4mTZxbFiuCDqpM1dWx2A==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sibi,

On Wed, 30 Sep 2020, Sibi Siddharthan wrote:

> On Fri, Sep 25, 2020 at 7:58 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The idea of having CMake support in Git's source tree is to enable
> > contributors on Windows to start contributing with little effort. To
> > that end, we just added some sensible defaults that will let users ope=
n
> > the worktree in Visual Studio and start building.
> >
> > This expects the dependencies (such as zlib) to be available already,
> > though. If they are not available, we expect the user to run
> > `compat/vcbuild/vcpkg_install.bat`.
> >
> > Rather than requiring this step to be manual, detect the situation and
> > run it as part of the CMake configuration step.
> >
> > This concludes our journey to make it as effortless as possible to sta=
rt
> > developing Git in Visual Studio: all the developer needs to do is to
> > clone Git's repository, open the worktree via `File>Open>Folder...` an=
d
> > wait for CMake to finish configuring.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  contrib/buildsystems/CMakeLists.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystem=
s/CMakeLists.txt
> > index d21849b730..1eaeb8b8e0 100644
> > --- a/contrib/buildsystems/CMakeLists.txt
> > +++ b/contrib/buildsystems/CMakeLists.txt
> > @@ -42,6 +42,10 @@ cmake_minimum_required(VERSION 3.14)
> >  set(CMAKE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../..)
> >  if(WIN32)
> >         set(VCPKG_DIR "${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg")
> > +       if(NOT EXISTS ${VCPKG_DIR})
> > +               message("Initializinge vcpkg and building the Git's de=
pendencies (this will take a while...)")
> > +               execute_process(COMMAND ${CMAKE_SOURCE_DIR}/compat/vcb=
uild/vcpkg_install.bat)
> > +       endif()
> >         list(APPEND CMAKE_PREFIX_PATH "${VCPKG_DIR}/installed/x64-wind=
ows")
> >
> >         # In the vcpkg edition, we need this to be able to link to lib=
curl
> > --
> > gitgitgadget
> >
>
> After reading the patch series I seem to get to feeling that people on
> Windows are being nudged to use Visual Studio and vcpkg.
> Although they are great tools, when I want to specify my own libraries
> I don't see an option here.
> I think we need to define a variable, which this conditional block
> uses, which is set to true if we are using a Visual Studio Generator.
> We also need a way to override this option if needed.
> If this variable(explained above) is not set or false or OFF, we defer
> building vcpkg libraries. This can also save time in the case
> when we already have the dependencies(libraries) and just want to
> point to them instead of building with vcpkg.
> I also see that people who use gcc(MinGW) are left out. I think we
> also need to set the supported compiler(s) here before executing
> vcpkg_install.bat. People who use gcc would need to point to their own
> libraries with CMAKE_PREFIX_PATH.

Good points, even if our current CMake push really tries to cater only to
Visual Studio (or at least, MS Visual C) users.

I added a further guard to the conditional: `MSVC` needs to be true. This
makes sense, as our current support for MSVC/Visual Studio hinges on
having vcpkg build the dependencies, we simply do not support anything
else. (And it would be easy enough for a proficient Visual Studio user to
_still_ override the vcpkg system with their own libraries, if they
really want to make that work.)

Thanks,
Dscho

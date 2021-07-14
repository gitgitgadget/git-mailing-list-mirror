Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE65C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 08:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A1CF6127C
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 08:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238522AbhGNIyZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 04:54:25 -0400
Received: from mout.gmx.net ([212.227.17.20]:40615 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238432AbhGNIyY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 04:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626252691;
        bh=tqLw2EHhJWimiHKl0s34fpnCTA5g6I0MVu4zrA3EgrU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dg8pm6LhdEZ5JnczMc+tHL/3I6PZxzUfkfZhzxAlvz4nnYIRggWi7Ik7J7sBEGUqN
         xknbfJbQ4j33GlJWRY0N9HFFcUexH0QaRDDXtT5/qZ/NT/vOYiaVOuFQtzfT2C7gAl
         YpbW1GksUe0F2XNebuHTPDXmYtTWY6ioE72RQx5g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.219.153] ([89.1.215.141]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuDbx-1l9hbr3EVh-00uWhr; Wed, 14
 Jul 2021 10:51:30 +0200
Date:   Wed, 14 Jul 2021 10:51:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philip Oakley <philipoakley@iee.email>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Dennis Ameling via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Dennis Ameling <dennis@dennisameling.com>
Subject: Re: [PATCH 5/6] ci(vs-build): build with NO_GETTEXT
In-Reply-To: <32d1ae55-669a-c71f-95f9-345fcd42eb87@iee.email>
Message-ID: <nycvar.QRO.7.76.6.2107141049420.76@tvgsbejvaqbjf.bet>
References: <pull.878.git.1624461857.gitgitgadget@gmail.com> <a5084795ab039f6e7b9ab97cced3d7567e709327.1624461857.git.gitgitgadget@gmail.com> <87bl7i8ou8.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.2107131403040.76@tvgsbejvaqbjf.bet>
 <32d1ae55-669a-c71f-95f9-345fcd42eb87@iee.email>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-652047188-1626252690=:76"
X-Provags-ID: V03:K1:VAO0oiFjdllGj1OEjbmi6RhQ+cJ5WO1kHpWSrtO5mS3Ni/SHDSM
 OfqUcnJg4f62+w8/P86dQ1yHoSO8w2ejYaJL/HbzIZqgkrgzuWAFo/2FK5HmaXB4ngIHecv
 tN+1fYWbkATzuQc+syjxqN4RH22GrJBqyrdiycmKNrNEIA8b4TQoletRWm5c+urLL5i+sNr
 DzAar6CrQaZTcL08kqgHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VXM6WVF3VwI=:/4Yr+pLVyqMRAdoU5GIgyk
 P+gVMV8iGozCT/U1vBAygVF1tuA5iZPqr11f4rXitfYmUTLTgmyRI+QpJIgimJmetLXNR5Gs1
 ao1mlS29OxNpUF/jDqnJ+LRXwkuPuxh+WPrSYKdOb63O5H4xWjb60p+FVhi1IL8TFN7dDs/hR
 mq+bSfFvLkXaRufwM2w36OvhCSCIwLaFBH1eFsRuWiJidMpHbJlZE6ezrgz2UIDJqyLGm6FJJ
 DnEDeKdzqN7RngRjfNoSjXQV+MZSVJQcsQXX/PuYSom4PuYxqZ49gv/1vDsC5uInfeQQjimBw
 ZBFEUAUnqrxDH6qrAyGvQoG4I8MgfaWUUj5aKduWY2RCUE47ZyRf3mDx/OlYdNlHSsMnC8gGZ
 ulpu00jQa4dj6jcRrJyynUfxUwOcq25vvqgyilWtRHR8a9T8DAd8YWzvLf7aNW7QSPbxU7b1H
 M4Mk4HRUCc4scSKZa/DAr6Qwt4gzScmCsuaGAkxNea9ZSiySGDVQEDQ9C8I0++ESiYBB/9sm+
 vqEZI7ghtCNYFSov4Whq+rAntLrWxEf1gNKNqG1Yn8xohlbvfEizJR9Xt9SYrj6RoUEpiwCM3
 oQABvAIttNeyiwTuBnANNjNT+B1V8vSVYc9z6AogtOzLXrq2WvURMS9qfsgHx7ydAzaGCeAsQ
 AdoKD33w9GFWpoadaLsbpK1xwvNJOJJetrnta/AeygkL+P3B70+kvS96gnMhgY1tbK3PqTn5C
 GTGnjX8+CSNYoGQDeY9tOLbLd6jMTVzh4HuJpqScxiXQM7V42tI4Sg1QIAxUzELPtvkAtmMIa
 AUL9rnVyi8wvVSf8cT3a1rKZm1EXm3/tLRNTfERAfWE1tPb+3vjXg1iw16EFkTfDlmup9GIAC
 rxcxieECLiR1fU8cCXMJlPMRdJEKrDY5Jo2yOcpY9tQvbc24MwyGLgcmKRKbggmDLSQNGrM11
 r7lRLJzVceOurmE6/p8Y6MhgUkRBzbs7Lsag/9WoC6bnEGKgB2hN6/dGcCYyKbak2vf5MIMMF
 BJ1wTke2zgc6RvHsQwbZ95hKIli4suyMQynrhgc1ytyVfa/P5uxWJb4WkDTbXtnCvQP0Hj2hH
 YJHxUzWYopGJpdXfuZGzpp2MMiii1mOOatDQ5iJVyrb1oIqdiEbZQha+g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-652047188-1626252690=:76
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Philip,

On Tue, 13 Jul 2021, Philip Oakley wrote:

> On 13/07/2021 13:19, Johannes Schindelin wrote:
> >
> > On Sun, 4 Jul 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >
> >> On Wed, Jun 23 2021, Dennis Ameling via GitGitGadget wrote:
> >>
> >>> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> >>> index 0f7516c9ef..3b40c677ab 100644
> >>> --- a/.github/workflows/main.yml
> >>> +++ b/.github/workflows/main.yml
> >>> @@ -159,7 +159,7 @@ jobs:
> >>>        shell: bash
> >>>        run: |
> >>>          cmake `pwd`/contrib/buildsystems/ -DCMAKE_PREFIX_PATH=3D`pw=
d`/compat/vcbuild/vcpkg/installed/x64-windows \
> >>> -        -DMSGFMT_EXE=3DC:/git-sdk-64-minimal/mingw64/bin/msgfmt.exe=
 -DPERL_TESTS=3DOFF -DPYTHON_TESTS=3DOFF -DCURL_NO_CURL_CMAKE=3DON
> >>> +        -DNO_GETTEXT=3DYesPlease -DPERL_TESTS=3DOFF -DPYTHON_TESTS=
=3DOFF -DCURL_NO_CURL_CMAKE=3DON
> >>>      - name: MSBuild
> >>>        run: msbuild git.sln -property:Configuration=3DRelease -prope=
rty:Platform=3Dx64 -maxCpuCount:4 -property:PlatformToolset=3Dv142
> >>>      - name: bundle artifact tar
> >> To a first approximation isn't the point of CI to test a diversity of
> >> setups?
> > No, the point of CI is to find breakages.
>
> This problem (vcpkg/VS/CI build breakage for the tar artifact) has also
> just come up for me on
> https://github.com/git-for-windows/git/pull/3306#issuecomment-879093798
> "[RFC] making Git for Windows start buildins in modern Visual Studio
> #3306" which is a similar build situation.
>
> Hopefully we can chose a suitable solution regarding what, if any, extra
> checks this part of the CI build ought to do with the (unused in this
> build) `.mo` files.

You will be happy to hear that the fix was in v2 of this patch series (you
responded to v1).

Ciao,
Dscho

--8323328-652047188-1626252690=:76--

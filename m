Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98176C433F5
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 12:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 751196103D
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 12:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhJTM3z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 08:29:55 -0400
Received: from mout.gmx.net ([212.227.15.18]:52797 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhJTM3z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 08:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634732851;
        bh=hKWp9ZaCIRBEkusQogl0lUrAr+ECXXdWuulwLSn/HhA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KQtIu6mz6dtmL+so785BxCtHm3sZMim7oV8dJQW5/tXU5P8zfq8B35TIeV5f1T1LZ
         YHR5Wc1kKhgK3cjCC7gvFh7oGoo2tz+WzNhQum58RxnjI21JTBUribI7VBkw24i3y2
         pTmAjJmn5VKr33LSHyEcF+QohkQYJ+08nHdcb92Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.7.163] ([89.1.213.179]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N79uI-1ml7ol0FmW-017Xfn; Wed, 20
 Oct 2021 14:27:31 +0200
Date:   Wed, 20 Oct 2021 14:27:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2021, #02; Wed, 6)
In-Reply-To: <YWC49+xCh+zum8Ms@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2110201416390.56@tvgsbejvaqbjf.bet>
References: <xmqqfstdr8b5.fsf@gitster.g> <YV5aaD418SyZqS/1@coredump.intra.peff.net> <YV5dmkkuCqAY2qqG@coredump.intra.peff.net> <YV5yi+AejPGO9qOi@nand.local> <YV/BMkZrj4xQyvUL@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2110080946060.395@tvgsbejvaqbjf.bet>
 <YWC49+xCh+zum8Ms@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SyJ1fl/9LUcljOBhXRFDrYVFA2g7ERrNjAbLsue6izUK1mkfDVi
 RGk6FoSjrWrYDjsYm2VyzMBR5T2d+XArR9PiWVYaJKBYYfiOQlfiny1OcmDHrGlFEuWOwnn
 PFYSK1ThtLtBCL2CmHsEi6yBXIDV8Wc1ozLb0bBDlnoJzqDPB/8h+LVKsFIyq0B2ddvvuXH
 FTyAeEmN7ij+euQhNo4Sg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+ikBCRnMa7w=:T4b6ekKc7lgaq1mnnoj4r6
 fZl0NVJx1RG8HHUQ/awahndMCJVDn8RrM9XfhC7lvj3E+DZlOwCDYNEXlx4GeNB+mUiUL/PCO
 3hrmw4fjJuR2nbebVNrwLfpUC9JI9j+2wH3cTIfSu6pPuuoghA0+B6aO4GGvfi3sA7kkiRqut
 5KKaMDqs3enM0FYtnmge5PKzrSTk62aCx/lizEO2h2Me3gz5COh99P7yt+bkE0EQ79ZgKxUr3
 Q1F/426rKr2qM0mn3r8IN61jUW3JRM4VxZPNZzvphn1KzLyFSyQ/CuVfgql9cqq2mhkRpcEdX
 sWgbrtrQyafMJqYoyBL1i1CdYBOKmG84spxopjxP8GSxEVEVRFeYMOoi1yc2YK7JbGZjJ7NfC
 YwcPM0S0MMKY5kcbJnfUiHp11hpGW/Fv2yIwvY01XLAEGPfBN5aGx0rruJ4x8Hw5EiYkcFF9y
 iO8tt0PCytDo5SKmGrs7QzA02CvvoZJoPXO5UC4wv2p0rAhypvfAqL0LJSt+cgodvWSNsPAKW
 MUGiST+n12AMTWlHI6iOdrS5jNy20DN+nN/aH8waZntUhYcOw/CT7xXHoWn4YP4MBx1h0L1eZ
 DaHRwzVO1odlKyHNAI0PXce+5DoJskQK2fHKixvZivv5aLQDRia+zaiqSuc63Z9E40Vv7y4X0
 mLjdJsXICCg0JOHJgXWcEwsRrP+rTJSWIK+Q2DNpgOjcTyXoKV1H19oPbvXXIQWptjsq8nOG8
 eqnQJneeV7sITimKCcZbuuekdasdvzkmkraIAjbpA2HHMyRTLBu2I0c163wje/QYgWW2UDPZD
 6CKFN1bPB980qMNHRtk5/2TnmWFzLvagJPbNd8J+XEwqOqOX00XzGohjuSWqKvhqlMwbDZhQ6
 ePMYyGHWzzWGdPfdT7KzXuAP3o1ghrpTKlsjR+SgukZU95nHhJ3Y7kr+qwKyAfPSA/n8mT2FI
 tP7dVvEAS8hGz6y8HvetZSjK++iiz1umOFhbTwjyTDU2TT0OjlmmAbNxkuXAdTzdrFdiKTVXH
 EG1OikFecQZz7vV81QOF7x9/b9Hzp1Co9QzREy6ZD8o/qZpqUPrIPm9PoLXFmP9yQVpqOO7G2
 7ZaJnH+wGukla4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 8 Oct 2021, Jeff King wrote:

> On Fri, Oct 08, 2021 at 09:51:33AM +0200, Johannes Schindelin wrote:
>
> > FWIW I have set up an Azure Pipeline to keep Git for Windows' `main`
> > branch covered by Coverity:
> >
> > https://dev.azure.com/git-for-windows/git/_build?definitionId=3D35
> >
> > It essentially calls into this scripted code:
> > https://github.com/git-for-windows/build-extra/blob/4676f286a1ec830a50=
38b32400808a353dc6c48d/please.sh#L1820-L1915
>
> Do you have any objection to adding something like the Action I showed
> eariler? It would do nothing in git-for-windows/git unless you set up
> the right environment, so there shouldn't be any downside.

No objection. I'd just ask to use `${{github.repository}}` instead of
hard-coding `peff/git`, and to really not run the workflow unless
configured. So something like this:

name: coverity-scan
on:
  push:
    - master
    - next
    - seen

jobs:
  coverity:
    runs-on: ubuntu-latest
    env:
      COVERITY_SCAN_TOKEN: ${{ secrets.COVERITY_SCAN_TOKEN }}
      COVERITY_SCAN_EMAIL: ${{ secrets.COVERITY_SCAN_EMAIL }}
    if: env.COVERITY_SCAN_TOKEN !=3D '' && env.COVERITY_SCAN_EMAIL !=3D ''
    steps:
      - uses: actions/checkout@v2
      - run: ci/install-dependencies.sh
      - name: Download Coverity Build Tool
        run: |
          wget -q https://scan.coverity.com/download/linux64 --post-data "=
token=3D$COVERITY_SCAN_TOKEN&project=3D$GITHUB_REPOSITORY" -O cov-analysis=
-linux64.tar.gz
          mkdir cov-analysis-linux64
          tar xzf cov-analysis-linux64.tar.gz --strip 1 -C cov-analysis-li=
nux64
      - name: Build with cov-build
        run: |
          export PATH=3D$(pwd)/cov-analysis-linux64/bin:$PATH
          cov-build --dir cov-int make
      - name: Submit the result to Coverity Scan
        run: |
          tar czvf git.tgz cov-int
          curl \
            --form project=3D$GITHUB_REPOSITORY \
            --form token=3D$COVERITY_SCAN_TOKEN \
            --form email=3D$COVERITY_SCAN_EMAIL \
            --form file=3D@git.tgz \
            --form version=3D$(git rev-parse HEAD) \
            --form description=3D"$(./git version)" \
            https://scan.coverity.com/builds?project=3D$GITHUB_REPOSITORY

Note the `jobs.coverity.if` attribute. This is what will let the entire
job be skipped unless the secrets are set up.

I am very much in favor of having this in git/git. Do you want to provide
the commit message, or do you want me to shepher this?

> I admit I was not really planning to try to suppress the false positives
> as you've done here; my plan was to just keep an eye on the "new"
> entries (having already gone through the existing ones years ago).

I think we will _have_ to suppress the false positives at some point, as
something like 9 out of 10 new reports I receive are about these, and it
takes time to analyze & dismiss them. In general, I have no trouble
finding more fun things to do with my time.

Ciao,
Dscho

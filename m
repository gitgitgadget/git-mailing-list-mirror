Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1ACBC433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 08:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbiKHISd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 03:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbiKHIS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 03:18:29 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AF22DCA
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 00:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1667895502; bh=SAwxCt/vxyCPSKLCLqvGXBSOvUfMJfYwvmehyzXM+GA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=nhnZAsZMtxK6Hk3KTWUBwnCcXDC5g3KP1HalaNUAAMO/ZFk7KqNru5bBl46arRKjd
         H0v4FRcdt4500MRJ74/dUrn0gTI8gXgCg871niVOku/SIsYrLtmG/zxZXESlCrrn9W
         +qT8K+J8S9x/6Pyr9FsejXphHRTSiLv19qzvCj3ar0DfZed57bWdlUNdJUGfUhEDc1
         yDyKq0tRMIv/6InXVz7Utdd8tE0mbKa6S4qfatqZ6dPC4CyE41G3wIAjNYWmPL12LP
         4WuHBEEJ0vIA84+3J/dDY+zC0GDs5RhwFsGOyVSu7Uc+kkGmsApR7XfjPNQ0YEQScM
         +tj4V9Y9b7rmw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.27.219.74] ([213.196.213.188]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N95e9-1p6ZaL24f9-0168u0; Tue, 08
 Nov 2022 09:18:22 +0100
Date:   Tue, 8 Nov 2022 09:18:21 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Taylor Blau <me@ttaylorr.com>
cc:     Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: avoid unnecessary builds
In-Reply-To: <Y2mKY+rE6X/Lu4pb@nand.local>
Message-ID: <75ono097-16nr-nno4-rqoq-rrn79spps249@tzk.qr>
References: <pull.1404.git.1667482458622.gitgitgadget@gmail.com> <f975f57e-71e2-3227-8039-14dff82f04db@github.com> <Y2liOzOFLyz4uzd0@nand.local> <85b30a45-e00e-44b5-ae4a-b09542a9fb19@github.com> <221107.865yfqv58k.gmgdl@evledraar.gmail.com>
 <114d4a72-1a75-71f3-8af6-6e82cd4fd54b@github.com> <Y2mKY+rE6X/Lu4pb@nand.local>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-933969287-1667895502=:208"
X-Provags-ID: V03:K1:CUtnTVvqu/jS7SrRPmf3uHkfcfdcJ9xBuKhZu6/fzXTp0RcU7fI
 jUjcHivKrWS7ZVnSgwzi7P0YlgOTUVOXCj1LGIXcoj12Wht/OiJy0eM3un6BGUAzfLr2YGK
 NqhSftTAYMULVtCWeGZeTdv4HLrECnBBrTydOUTvOLsXEe6T9Mx7p2/QQJZnPrF700QPYXS
 /jd2JE5CNhnvqfRB9s2zQ==
UI-OutboundReport: notjunk:1;M01:P0:RZ5+n+PxGrQ=;4eSfY7PO/8FK2kHjv6rejncbPdO
 BvzuuUgTRE+/XJTP1Pa297XzrfuVULPivF4cyEdXhxDnVII4N1HOa8TEpsG29s+6YPWygujwJ
 yrpCMN6QjvIzEiWE3mgQxaiwkvHS7zYqmLqCY0wym+cLXrIyjxvBLruWfo1Img6EMAqk13FGt
 pzyx6zFkCMB6DEN8/v15tqq0UL87SL8Ae/uFJ7nN1xqqQtKd7OCtDfOyRF3FGlf+D6svFvtii
 59vkNd8gHnlSinySf3ziUqRXLQ7bnH1D7MKDO3PIsr2iyL/6GdmcBMX8dBsEZCdpha04jll6g
 biQWXtO8t4UFhfR+CEGfvPIB69XKD3Oe4Pdh2VfI/7PsfVf/0l8hjpFQrpY3k9Z+A70TC3wUH
 L0pUmEppzn2frPf4NSj/D63YkdjiQiQBwIwQtdPMMf8zSzMF2Exbbj+yNyfT5z6jpehUE1R+f
 B0GMP8mXiwXIdsxNuBjywJPDdcS/vUaCAp59S6MViivsT8bbw1jaxycxPWFyXyVB9sJ699fJz
 d/Qbx/QV3W7MZO9v6sfIzOKp9JS/KhlsLARdb4RK8xrtaTrBV/2ECa9hN0mtzauv3GN1qxmvP
 tPz0RjTRy3+NfueUSOdi+lfUb7xPz5QZ1FZH5MsBLrwO6QpP8TPJPqFUzpOkTHG6uWHWIkkdT
 axY0QIxut2aUTEO5dSzX/HkqnCG4I51TIfz4g8kU5SkzNHpv4eyZI3i3Th+Jkyiw+DOzvtaVH
 TwMr3B2ngmo4onDSHmmAtQ0T3XphJH1ILT108BfUEoGf1Bo68wx522ZAhEHpKUWbWyoOkhAQs
 7HLI4SRD0JAf7UZFPsppEcje+KhDxbYV1GI3zwBlgJOqcW+S4Y82kvqCw2JQpEbDA5lsqI/Nw
 GZyBq5bZ18WzlxL0bMcJqM8/hQnwI8PDedhxRoTOZkFZ8Fefs4lnNO81LFpZMGLGcHRCeuiw6
 3sYb5GfWETjQH9VMdZoToyswq7k=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-933969287-1667895502=:208
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Taylor,

On Mon, 7 Nov 2022, Taylor Blau wrote:

> I'm more concerned with the expense of running a job which counts
> double-digit minutes against your available Actions runtime.

Me, too. The fact that we used up 50.000 build minutes before we were able
to finalize v2.38.1 is quite concerning.

> I played around with the following, but I can't quite get Actions to
> like it. The error message I get (ref[1]) is something like:
>
>     The workflow is not valid. .github/workflows/main.yml (Line: 96, Col=
:
>     27): Unexpected value 'needs.ci-config.outputs.skip_concurrent =3D=
=3D 'yes''
>     .github/workflows/main.yml (Line: 123, Col: 27): Unexpected value
>     'needs.ci-config.outputs.skip_concurrent =3D=3D 'yes''

The reason is that what you are trying to do simply cannot work.

The `concurrency` setting is evaluated _before_ running the build. Yet you
want to make it contingent on the output of a job that only runs _as part_
of the build. Catch-22.

Reading through the thread, my assessment is that the original patch is
still the best we can do.

I also want to point out that the strategy described by =C3=86var to push =
every
hour and see a "breadcrumb trail" of green builds is quite wasteful. Just
because somebody else pays for it does not mean that it is free of cost.
It very much looks like wasting resources unnecessarily to me, and I do
not condone this, and I believe that the Git project should neither
encourage nor support this.

If you _must_ have concurrent builds of your branch (i.e. if you want to
use that many resources despite the planet literally burning already from
wasteful use of resources), you can always start your branch with a patch
that comments out the `cancel-in-progress` line, without forcing the
complexity of a more generic support for this behavior into Git's code
base.

Ciao,
Dscho

--8323328-933969287-1667895502=:208--

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209F9C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 10:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02498610A3
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 10:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbhIIKZ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 06:25:28 -0400
Received: from mout.gmx.net ([212.227.15.19]:44147 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229980AbhIIKZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 06:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631183049;
        bh=qd0R+JcVGw1t18fxLM/Xoawl6nBkErzDSFWD0FCT0sA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=d/bRf4q6JI7gJbb4PQuXfIwOrtxsABM6mmM6nALZMFufbNbO6Q/dzHI9hn/XXtp7n
         kneGyHwG+qaxJnij2ylJfIlxweUBhTbbT74/Fm1bfTMeNHlRJZifJ+RuwVtnVQcyuU
         52P97WzX2h49HthPqqdyouubAw6yxofTeTz/hgNY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.174] ([213.196.213.44]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4JqV-1mO0F60HeD-000I0y; Thu, 09
 Sep 2021 12:24:09 +0200
Date:   Thu, 9 Sep 2021 12:24:07 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] gc: remove unused launchctl_get_uid() call
In-Reply-To: <patch-1.1-93adb856b0c-20210909T012244Z-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109091222260.59@tvgsbejvaqbjf.bet>
References: <b0d6bb0b07f29e68f5bcdf4c69d3d726d77882c0.1629819840.git.gitgitgadget@gmail.com> <patch-1.1-93adb856b0c-20210909T012244Z-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1400499668-1631183050=:59"
X-Provags-ID: V03:K1:hAb0ig0khD9FzorAgN0hMuyBhoxdnMMdjT0UpULC89YefPHzXes
 rFsaVAo21rpO317tlXt2g0Mx88yaFRLC2mZ+s0Owg8S8TxMqOVSzzgUsu5RJxZ2HP9d3L8e
 ENZCPwrGWmFEDGkzEGLXG4KuBOrEw6N8dA9EK9fq9lNZhD4FFvDDdBKxN28NIC25RY6z5Pp
 ON96G1mBRgG+60WrVNypw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8D26BjrqIrw=:2mxUWc6y0Z2t/eBbzNTQsI
 sDqJpqjP3EbNyEsIEp6MYf7Gf86gDc23rj6guMVCU0p51PprJ/McYyk4NvG/4U4mNALeChcyx
 Xv3Y7v3rrAA+DMdwIdwRB2FqNlRSysdC8u8v+ej9M5apEgKq+kkbySVK4LuxWEyL4ea0XytgY
 RynKEULjerCIpYY/A+0mb6mCz1e79KeRkgmdWpbMwHaRU2POmse1IXFlB9cMD2zfa039QqYYX
 zdqPRipWip3yql6Zel7B2zZ+uY4neAr61svPOkVZbICdBzxi0aF7Gqqkn6iBx2imrghExyZ/d
 y1/wpGE9vsN1AYf2mPRLxYSPEYUbyqdttRw6GvE5xU0R1CAhhP+PUkgpniX3JFYLLQb0zCEGw
 miQOI2Etp7ly51BxPUmGPC/gHkXLMTQw8iL+g96iPcnWS5qt+1FyQWwz0OZGzomk2jlPsTkCs
 ErqLLNMA3mkmEkhq4nYDKsLvfU4/hBjYj9bekA4/RstJ/EGI4d6ZtXc/hUmcpGoh7QSqsaTEv
 YvTG4Gl3bpyZ3Ux2spEkBHBidk0aopwyrC957y+YevcTLLrRAIZDB9VOaMJegZwIdXxEWdCfy
 DA7RqA9B9qmfQFHCHKbSUCcpnP6vJIbjHFMF3r+30vbCzUv+zLcclX1auJ42BYQNBPiYQyGar
 5uBmMvbtP0sMG1UskAcY6NXBnkoUBPKswGgz0tq7euP9c+43zNT1LOJddPXLwqSTDVwqbLcPX
 dmVV8iXm/1BqAvvhyQbIPC6MHXia9M00Dq3f3ubNGT/K5GG87Vz94Brga1m28DhWK9D6/cgif
 qEqXrlRU2UYRp5YXCECF5kxtYsV+bI2/kZp6eswjAi0CuW1ssGsy1TluI3hD6ck1TdDbMDurV
 LB31SQX5pO858o78BuqH0tQEJ8T5jvGp/LBvP3GbuFU7OLzvOjEwX/rFTX86DXZT+LHvEQm29
 X08UT/g/JRymg6v/thOOt3xGsfXfsPawzfnUdP6btiE/qQ1zNu4dwcgTbgrbWdqq42K+tVvbn
 j00zI+ybUBnFHyFLPsgYZ4oIe9iJl7JYww6Vt15zpG/DEPUfXeqleBvuLJe7LTe05qII/kfBT
 z84RvnXHEEa3IY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1400499668-1631183050=:59
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Thu, 9 Sep 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> When the launchctl_boot_plist() function was added in
> a16eb6b1ff3 (maintenance: skip bootout/bootstrap when plist is
> registered, 2021-08-24), an unused call to launchctl_get_uid() was
> added along with it. That call appears to have been copy/pasted from
> launchctl_boot_plist().
>
> Since we can remove that, we can also get rid of the "result"
> variable, whose only purpose was allow for the free() between its
> assignment and the return. That pattern also appears to have been
> copy/pasted from launchctl_boot_plist().

I don't find the most crucial information in that commit message: what is
the fall-out of the removal of this call?

Such an analysis (_with_ a summary of it in the commit message) is
definitely required. And it should not be left as an exercise for the
reader.

Ciao,
Johannes

--8323328-1400499668-1631183050=:59--

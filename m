Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DA3C433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 22:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 800D322CBE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 22:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgLDWPD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 17:15:03 -0500
Received: from mout.gmx.net ([212.227.17.20]:39991 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgLDWPD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 17:15:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607119980;
        bh=SELL+VJ4C+8lb3iNbvcuhOGjA7tmasWTx06M7xzDUf0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=F8E/Cjmi0zY11aAyo5fm3/FRpWqAxmrHWqvY2YDNMM9OTLWwEmvrIiVC1UiFB+ci+
         86erOijCxx/8FWEvowJm5Vk4RpapbVWYLgFjUt5xEihqPvIsX8jvWLSXMv4Mu0MSmY
         3169PjXb9BDOr3lQFF9NdNsdVpCG/FY3LlOGTo34=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.88.62] ([89.1.212.111]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4hvb-1k42Bv1CmV-011i6w; Fri, 04
 Dec 2020 23:13:00 +0100
Date:   Fri, 4 Dec 2020 23:12:57 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Dennis Ameling <dennis@dennisameling.com>
Subject: Re: [PATCH] ci(vs-build): stop passing the iconv library location
 explicitly
In-Reply-To: <xmqqv9dhe3wi.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2012041612300.25979@tvgsbejvaqbjf.bet>
References: <pull.805.git.1607091741254.gitgitgadget@gmail.com> <xmqqv9dhe3wi.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VpHtvDjaiUF6yUa26YjPxydvgYW66sxTGmOUl21i/leTeFlZjNw
 ziG43d3eXX7533KP8uwTtu/B2JcOplt+6+y/tFMG/WqwlUVuXR5luP3qyXJV5SGHP0Rrs8j
 2PHIKq3l4VYKCHu5mBcu5nFZeY9CInvB/LQfSI1y8Q4a0hhwD2aNlck1DRxO/VQ+n9ME+DW
 h6cYfokKCAD8IfekTpSBw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r45dm4U3QeI=:VsfLwDH5GfwtCOcITL9T4t
 AdczpSBDoGwAfEqLdoXZIGt57h83EVNgMTeFWldWffxPsSoYqLXEZ6+p/e7JfjIyS/uPXmvY9
 /jkLIBh57VLepuxEaAsl51axNmdDueY6hgyD+Z8QFYo1h+e9iQR+VQriUn5zXjLOV1ocfCrFE
 jQn0B6IWEejFe4PLvwq2CItziZ/GK/Xb6/08R6wuQl+qoBAGWPJGHl1+TcCOIjjhrJ6xfo5mZ
 V5Qh9LIBYnmrItv8MRaKxcI2KMYZudfkfqlmdmmSSTG+Aj5V8dgGx13vVbuTf6okdwUV45+e0
 ytXxpu26tQb8KbsXeHO83aCC9LubrYe2ENeoV3tso1tSofQkWefRcMg9X7+E7RWir6pgcotp/
 4KNSSAC7obfI6WandkAQ0lJ/DJa25abdTP654sVirUhRqJgCchjmXZyM1Z+/tkzh3JWpkaK95
 F6U81Sou/4Ri2S7rUI9BFf8i8zbW1BMY/kXYVLW5qvzYzOtkwiOsMh+S3uR0ZNlLCpIWohyfr
 NhDs8QT7ZQ47cbs8SdCL7O60onocibjyyveOqeSmtDEDqlR6iSTjb2/JMxvzGNjmIM+iSmBvY
 PJDeodEBoEyJN2PtGCaTuj6MUQ2Lk0nkuAlKjQRBTgD4G+3VeANvuwAu2zFq3GTd8V+Fh7MuK
 jHwSYOhYPH+3r38IQ+DZ6MibBSkuqFoB6CK2A9o7IX6xMTcdLhkkiDRUJaYgAF66YtIjusP1R
 6wW4e4qzgw53Ji82rPKVfPXC1Fp0U8CXH5gVTMaw1bsUslLSgr120LHecGop6WpqIteZbvrH8
 ltBjlsQ1Dpqnlw9D0PPJnH6JeimqbmYSHbOkr4k6zVNa9E0rX3j4KGGw3iTR1AIf2HNLdzT3s
 OEGHbWek7OMdbneUgd/d+fa/BRBLqw/BOQQNIpZNQ=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 4 Dec 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Dennis Ameling <dennis@dennisameling.com>
> >
> > Something changed in `vcpkg` (which we use in our Visual C++ build to
> > provide the dependencies such as libcurl) and our `vs-build` job start=
ed
> > failing in CI. The reason is that we had a work-around in place to hel=
p
> > CMake find iconv, and this work-around is neither needed nor does it
> > work anymore.
> >
> > For the full discussion with the vcpkg project, see this comment:
> > https://github.com/microsoft/vcpkg/issues/14780#issuecomment-735368280
> >
> > Signed-off-by: Dennis Ameling <dennis@dennisameling.com>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >     ci: fix the vs-build job so that CI builds pass again
> >
> >     This was noticed first in a Git for Windows PR.
>
> This is probably the same breakage I've been seeing, e.g.
> https://github.com/git/git/runs/1494253517

Yes.

> I guess we should just apply directly to 'master' (or 'maint' and
> merge up), but I can queue it just like all other topics and have it
> traverse through 'seen'->'next'->'master'.

Whatever is easier for you.

Thanks,
Dscho

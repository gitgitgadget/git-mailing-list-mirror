Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADB941F731
	for <e@80x24.org>; Wed, 31 Jul 2019 13:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbfGaNSQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 09:18:16 -0400
Received: from mout.gmx.net ([212.227.15.18]:40313 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbfGaNSP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 09:18:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564579078;
        bh=7ftKZfCqzjNI1ZWgouMuz84Jc/sCPVXtF84BuG6DCO0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ksyf8BdhvQ2ZQHqje2IG3LL5fxaOlPtxVU8O9xZ/Shgn9Ijo2tul2jJeMeHtBigKD
         99CdXUDln1Z5wxY/RhoEkBJZqRAhWH1meqPzaWDAutBHADUjzE25X8qqYM/RMYne9/
         3pxDEQ7IbJj7BwF0OWkddCJDC/CShdgFQ3WMM6E8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LuOYx-1iKY9h2d5b-011gHt; Wed, 31
 Jul 2019 15:17:58 +0200
Date:   Wed, 31 Jul 2019 15:17:59 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jnareb@gmail.com,
        pclouds@gmail.com, carenas@gmail.com, avarab@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 2/5] repo-settings: add feature.manyCommits setting
In-Reply-To: <xmqqh873s0jy.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1907311515210.21907@tvgsbejvaqbjf.bet>
References: <pull.292.v2.git.gitgitgadget@gmail.com>        <pull.292.v3.git.gitgitgadget@gmail.com>        <c0129066a02b39535110ae592c16ca0e5d6d6c24.1564515324.git.gitgitgadget@gmail.com> <xmqqh873s0jy.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:uVN+RzEgK2tlZYA2k26m8H/Vfxwrj6MDGFUXtXFztH6ASu2jMuw
 y8lgJ0rRuctiq/6oTBPXksrmKZdNQgAJLttrAFGt7ix8o0HE39N1p5PYOMPBpds5m0RyiUV
 uwy0iTI4C/BRtDwNHI9A4IAVRI3XrI2atHpe1J6s+mbuRXiwN6XjtETzmb3Wg+z+iCp8g7e
 MMTm44G3JC2BmF7m9/lcw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tZ5wa45PRO4=:spPPsXbkOcNHUrvwWBBYo0
 3eO3QPyPw/n/m9480Qi1fP5UGsZgzfOz0uRLNVccVQJkgVSeyirgfaWNgIIuKT0xc3ZI8gpc6
 SyO9m0hyDPCNXP5rFrCZh1phFqbUDZiE14vD87QdiYu2NyMLqTxGAcmixk5rMnBrVDQsM3xmh
 3nYPGHot8XR0XrbM4HLpJoWPf+rrmXJPCvknNEr2TgBGrUUfJ2E6XEEF2KU9P8a6HOyVJr1IG
 qtG/6TnAG/duVYr6InmSvrkb7DVJVltci6YRwq3/FiU/8BhPDuvtk4MIHXveOQ8fePm6F1BSM
 OpM55hE0d1EpHGooGsFAlmDpQ6Lzl3ynacdMDmoXxevZGDLH1NOl03VwTJKNo8/ITTk19d0pt
 RoyLfri79G6IFw0hBeX+AKoMUSYlnPPKTvqrqFULd8rGX1HGspzZCC0hKWiMRZhiusGeb/v3e
 NIpuNn7kBliHxHdZbunV86nxo2ssoU8v9XyL7C27mCGLDCNT1VgGfGYxo924Eu7kCFh6UFSy2
 UMjO5NGj+K5LO9QOqyhaa3psoVs+6Bt9ZpaiGuKWatL+TB08FL6h+Qa/YUrYagno6XbZj9bPj
 izRhv+hYtFvpcz9Z7xlqAubq9nM9cDOmc0DSZ+lSvSnRCB5pAR3f67r/a5MEB7sElCAiHEkqE
 BLY98p7Kp72mlB2Va5VfWkwCint6rQO0HeQxTTWLSvTtb1A0HIRWnEn4gzIREG6C/KFKXC20i
 2MboBqsjazcI05GsPF0Cg/xxtZnfLfiAEpDj/B57gBJ/guibVeuGAUm/iLgpaGVhv7tGWIKFQ
 K3WSOJVFSvEFN191cMSYxF5HI4+jqayF+T0S74o0toBa4ADhsClLiDlXk/BIIKimHYJr5zIoL
 OPfxT52MdrZAgGIEbA0YM0l8upf3shuBFPM0mJEOEJHe4HhSaeN4YfTYYFHF/yq31NoqfJifk
 sAhc9mPD6+US4y6UjdBp+lo/QeqBSbieWaDIYTbZ6F9dmljq7cP9MQqxbTR7oolImwEOgNeLP
 z3G/UN8H4YUgdjdn/TydDbA1Cf3A54mGIU2vksZjUgFlvfomRPNMVybtW3yWvySOZD+xPFazC
 DUcKZbkiQuy6/WCrRHmN2pnWhUV7YeHge5P
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 30 Jul 2019, Junio C Hamano wrote:

> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +#define UPDATE_DEFAULT(s,v) do { if (s =3D=3D -1) { s =3D v; } } whil=
e(0)
>
> [...]
>  3. When we learn to set default values for variables that are not
>     boolean in the future, we will regret that we did not name it
>     UPDATE_DEFAULT_BOOL(slot, value).

On the other hand, as we never promised any kind of API (and this is not
even an internal API to begin with), it will be _easy_ to rename it in
the unlikely event that we would ever introduce non-boolean defaults to
override, wouldn't you agree?

We have plenty of precedent where patch series start by refactoring,
whether it is to rename functions or variables or files or extracting
functions. Preparing for a future that might never come strikes me as
premature optimization.

Ciao,
Dscho

Return-Path: <SRS0=BZy3=CN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5829C43461
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 15:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96E9C20770
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 15:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="XoC4kuvC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbgIDPVT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:21:19 -0400
Received: from mout.gmx.net ([212.227.17.22]:40383 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729942AbgIDPVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Sep 2020 11:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599232859;
        bh=FB84HSr9XCaI5W45rXFjiGsmM7ezzfLEBozezkfpMDE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XoC4kuvCT7SxbgcT4nh3V3b+27yx5u34ontICxYxAIJUMQCgBcsFWIwYuf8SzocUu
         m4DLjTHLLpehVyemmrBTlsL5jICbfTflLwrex+wX+WxoVITZvmVJF8IvNEclFBRgJT
         XgZcAx72cjEqCm1Kxeh1asbPOCIvEXuePAevCoYY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.169.176] ([89.1.212.11]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsYqp-1kXnXM2BNT-00u4rX; Fri, 04
 Sep 2020 17:20:59 +0200
Date:   Fri, 4 Sep 2020 08:56:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood123@gmail.com>
cc:     "Raymond E. Pasco" <ray@ameretat.dev>, phillip.wood@dunelm.org.uk,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Sullivan <tom@msbit.com.au>, git@vger.kernel.org
Subject: Re: git add intent-to-add then git add patch no longer allows edit
In-Reply-To: <1071d841-a030-30c2-e50e-6d97eb494fea@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2009040831570.56@tvgsbejvaqbjf.bet>
References: <C55J4YTSBL48.171K3FSJLUQOA@ziyou.local> <1071d841-a030-30c2-e50e-6d97eb494fea@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Bu9uiX/S+sBuZLyH7m6pDvw5gP4m5Fc0vbTSDfnN67Lmac1slDt
 qmUexcWnRzw/+QqtggabLbXNeWRSxGK7JrT4260UMuSWe9nY+ElRGpRJ0C7MsjCHbA7rb5N
 U+tFEfiuwH33XankXWeiM/W4bevmK3FO2mPVpSXJ0LkEDOliyxEmS7CWfo7oxuXJ7Y2rnhr
 kRYaOLcE8rqdYIjRPVwyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l6M6sAFeNV0=:s5hoR22tBIDShHGlZpMkO1
 +2aZYMyOZYTfnDSIWXQOUo4utHOjEZQenaTsP+AoTHHlWGxaBvxZNs3FyKwiexb1HxTPEFeYP
 E+QiriWeQCTbqmhXxg0SEc2n7qmnu8S14cafBkVAEo362n53l3u6aqRttT4kJ97p+BRhSGDrx
 3gfUvvTKBTp7DtpzncWal+EvLju/Rwm1HCW1Qr2OgwhyIuPoqRiWz1MEu8neuPNFfYa2olYzC
 BvMpXylsvhSW24iIqLv9AWQRhZM7JV4+vqgm/LXJ+74ALmjDJIoS2KAtAjV9cD04s2N4zglTI
 v/19FBfPtNzpxeKl0F2p1EB065bOOj77AptN8PrBfLXUmEXfyVMFxmH770LpepVBw4oswR9Fv
 Iix/kLFrf9sNZiwtiDwHrnn8HDRwlsctOvTEVwmDmMtjezos+Bvq79glJ0tLAOkK8XE7Q+JJw
 91Z7q2qky49ux7Zevf8yniiUlgg6k/SUkCEU7r/HEfMEIYUTFhmluolY4dVPqQjgb+tLklVV1
 nRXhbRTLG52TfDE7Ryhjciuq9JE8rdlLi+baCvbG2bMR1hV/1qg+uz55Ztsvjl5/9ex81UGOA
 X0+0sL59a0/GLUsEYN/QmFNHPC6BwpVPCIP9MJbPZstJV2JsdTN3xOFwvOi85uknbt+JWf5+u
 tFjaloY1w6sexm2v3MhjARrldlZf2h9FyMmUzQlYP3sRjxIZ5pnX0yC0wCo1te/S4mB73jukU
 kBAIDUWnHgRDujoE0Pj/CkzeZQFQ3y3hydJsywSHrFHUqmhlmYsJmExNeoJzqydHzG11DcC5z
 wcOGOPAP9sSjh8iHwZb7eCMxUcjIO0hkdU3skFpm03QkRjjeasIIkFeGZEukYqH4/pbCRakWj
 /eKbXno1THUmXQbhkbriRdFmtEF8bmiFhLtFk68dq0Hh+/SAWkOa+hx4oiBQ8n3QXaOUrPb6r
 X7ylwXuSbxKwYMo6cy1BlwWNS7/cDAV1F6jQW+qsU6ZQTvrniGxXQGaP3pGwxfYDf6X23zJhu
 WXYidNFda/KniCXASZ6l/nY3lpHKpKLDOA6OYw9nrNX13IQIHK1aDIZl5+/zIVYpZBJ1OtcLp
 8Lp/YyufWmkU60I0nU6xIuWh/dvRna5IMRdqmxFeomHX3XEjniHobfMkHj4tCRSP09fYfLRJM
 pFbLj6+mulUW6poWj2IbGfLwJ746qRv20rldNOP6L8XGJrK0/+NEbTQRZ0okQjgFmnCh1FA68
 IHVX/5fPLji1P3eIL+tkdiUp6CmSUO938N9iFFw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Fri, 4 Sep 2020, Phillip Wood wrote:

> [...] I haven't looked at fixing the perl version yet - dscho what are
> your plans for switching over to the C version?

Thanks for reminding me, I did not really think about it anymore. The
built-in `git add -i`/`git add -p` has been available since v2.25.0. Since
v2.26.0, we also respect that flag in the `-p` modes of `checkout`,
`stash`, etc

And from the way at least _I_ read the commit log, it seems that the code
has been pretty stable (except for that bug fix where `e` was allowed by
mistake).

The next step will be to invert the default (which is `false` right now)
for `add.interactive.useBuiltin`, I guess.

Ciao,
Dscho

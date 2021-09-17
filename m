Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88EEC433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 11:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B862A611C8
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 11:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343874AbhIQLVu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 07:21:50 -0400
Received: from gourmet.spamgourmet.com ([216.75.62.102]:37537 "EHLO
        gourmet8.spamgourmet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S243123AbhIQLVo (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Sep 2021 07:21:44 -0400
Received: from spamgourmet by gourmet7.spamgourmet.com with local (Exim 4.94.2)
        (envelope-from <gitmailinglist.bentolor@xoxy.net>)
        id 1mRBuo-0006xK-HP
        for git@vger.kernel.org; Fri, 17 Sep 2021 11:20:22 +0000
Received: from mout.gmx.net ([212.227.15.18])
        by gourmet7.spamgourmet.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gitmailinglist.bentolor@xoxy.net>)
        id 1mRBun-0006wm-U8
        for git@vger.kernel.org; Fri, 17 Sep 2021 11:20:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631877620;
        bh=LDP697TbG3fNscG9mvvL1LIycg37WMfOR5xE2gmkhSc=;
        h=X-UI-Sender-Class:Reply-To:To:From:Subject:Date;
        b=L8zGc1Ok7uzGEOwbCz0I5cboLE3Rcqd0chKIygJy4oZVR5RpFA4uc+oejLngtEwOf
         Ecy02b0I0/kww5e2dOrugZb0OWiqBseqqNPNN7MrTpxmIZyJWMBbqUfsbg8iAMVnSf
         lENTqVamA2BvP0fnMqBAL3kiqKYVeLzek6BBleaM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.8.8] ([92.117.161.117]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAwbz-1mcQBR0QJd-00BKGc; Fri, 17
 Sep 2021 13:20:20 +0200
Reply-To:  gitmailinglist.bentolor@xoxy.net
To:     git@vger.kernel.org
From:   gitmailinglist.bentolor@xoxy.net
Subject: Should `@` be really a valid git tag name?
Message-ID: <0c68d628-e093-1cbd-e3bd-38a827545418@gmx.net>
Date:   Fri, 17 Sep 2021 13:20:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:cTGKSy9OstkUAGeBbNo4EXrvKGTor8gvmq5BS4Os2iO6hIEfJSh
 BzH5LiehMVrCw64jXC9ys1jM60M/V9nPDHkt/grcoD3jG6lQrIFC9ff3PmdHEkHcbCoa5wx
 /9bcxMVVUB73tK6tvfGIB5U3XSmFzDqKh5oY2ghttRyDac6x2I2J7zND9S6JpGMj5DYrK26
 /4RiU61qAHvKCZAWnoMFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FGokVQxG1/4=:z5j4cuQkMNWWmsL/OlvHS1
 hKYafSAcegeUvRJ3TcLWkHok8w+gjsgxnUxV6q4mY6cEQXJog3TuaXN2YJqmdROIU+jqdESr3
 pm1ZiExCuEusQlrpNSplP/TgqCTHAA40wEU2dDkMc2KbKXbu53gSrxBsGIAI0sas5ypoJI+fx
 z5sDLwED0A1B+WaGfDBSJf1REIDQV6oYb0pdedM+/P7anFbH3mFgFINc1Qz//mCpsuNjS4lN1
 Sk3sVNpWzhgra/T8PmOzDSe7lkzW80OLNFMxg/EmsIfFpOwRgd69piOwyXb433pBzDU9u4A+H
 pq0sbl6i5BNM2W6H/6M24UIQM2d+CFsaEl4vcPCYkb6MZ919m2qgJjvIWv148WP8Z8Vpmip2u
 yCscJUwmuGhtckVsRHrddpgpZaR3OrMLA8nl+8Codx//przHgewbYS47cZVGexZe8XQKU1g34
 +LSD0uALg+kTWhUmrkQBy+RTtbDP9PTvrqYkbas6Ai4kLSw8lvIKA9xKZXpEeoBgR6MecwV6S
 LweL39Rbm4ceU3U+pYWCcd7EpO9YTYZGaKG67nOIKty30VAHyi2x2bKVIvy3Yq+zwSdL/hM/O
 1eF7KJ7KIzThWyW4kl1VOEF3cTfkp4KGzUMchgXryaPi3a65OOnMsnhfwk02/WQkLu8RRXfoj
 99XxjK/qxTfn1gH+pFeYFUDYpTueqSjpgd3DCV8N2iwpuPTLrsLm1ATHKrhGGed1jOjEFCPN8
 Kk8uWyESp2VsF+kJgz0km0u8YsHeYIewQ/C6e31XMtSz9WC1eJDbnEIJL10XVTBGJXZgPBOBJ
 cX4ypV+L/5nC5/ENmjeYUvGlmJVY/XN4q7fI2MywUMMuhglMckePDauBMyNYsr+883t4N20W7
 oEq9WD33FvhTZnyuNzTkXBiJ98TaTv3yRcga/aihkVbKgpscL2e5E0h6BksdFdjjUFS5AEbD6
 iPu8+YRYfq76O7e8DA1mAfrTc6KzFDtzg0xYauGB7vghgXerQvAfFeyl9Yc5WwuX/kSSeTIeT
 GANbdmoe0PmOf+6PfqYvf2IA1BwjStNRWTya7RjnRehsCutLIeiPfcxw864mkFoizUht/+B+y
 dXAM9tjJcnzxOo=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git-Community,

by accident I did:

    git tag -a -s @
    git push --tags

in v2.25.1 and pushed the tag named `@` to Github and had some minutes
of fun to get rid of it again (see: https://stackoverflow.com/a/69211383)

A SO commenter pointed out, that git-check-ref-format forbids @ and
maybe I should report this as potential bug. Is it?


Best,
Benjamin

P.S.: I'm not subscribed, so please CC me.


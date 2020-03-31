Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D951BC43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 23:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A823220757
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 23:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="fxn33wgr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731544AbgCaXVi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 19:21:38 -0400
Received: from mout.web.de ([212.227.17.11]:56097 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731259AbgCaXVi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 19:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1585696890;
        bh=7t8vsxO4AzqZ0zuijCP+BllXEYe+86HNlSc+7qK712I=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fxn33wgr7XoVs0gCwLLRz9JqIMouJpHJlH3HY87XuGZ3DMbGxr2ZfQL36sJsFZY0Z
         P2EAD9rng7t/9oNNUQfaP/Q0EKcUa1Y2qprPaKXJIvGYREM3qkwTpTJnGxGguy0Kwr
         9OC+Z53Yz+34aMqLy5LYD+juszAuRJRXELuFze+o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.21.89]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MCZtW-1jRhv62vQ2-009Mti; Wed, 01
 Apr 2020 01:21:30 +0200
Subject: Re: [PATCH 2/1] pull: remove --update-head-ok from documentation
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, =?UTF-8?B?5aSp5Yeg?= <muzimuzhi@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Dongcan Jiang <dongcan.jiang@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <CAEg0tHTMHD1+3QaSe3Z+ymRKvOkbHnVqv-Xp2xhOT56SoHTmwA@mail.gmail.com>
 <a406c273-9a2c-72ed-c5e3-4c19848f0f94@web.de>
 <c94f8c43-625c-8e99-fa04-aafb0c7cdd78@web.de>
 <20200331214851.GB95875@syl.local>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <82876e28-ede5-ad1b-856e-e2267268e7c7@web.de>
Date:   Wed, 1 Apr 2020 01:21:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200331214851.GB95875@syl.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IqEj0CRi7Bv1VgyPa8lTjvwB+lArjUWj2//RbGvGByA48ZBGEKo
 JE2HZmvgiVAHumdK7mdY+/qypBORa2jNrm2zKEIYC+EYsFovyGDfz+hYb7aawONOzGHiRCz
 eCan+kSPFtTbu1TfNe7WTBBFLkqDda2J4NyxQKWDMvITa7CBouU0yX+7zr3ndrSxMeGxkr4
 WJpx95bi2uB2Uc6HBP91A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kcha3u7s3Sw=:gAVogrcc/+SarLiGa1vjFQ
 HeLXJ8GrYvPRDwO8H/jBTTB1hFiwmLQn+SPzCCoJ/t+40KX7vvxR4jCFPpSWANvbQpd4f6QpL
 D/FP155zynb3DEerYdSOI9A3ZnEh3KEBTfsAEVpFdnfNy+wfsfBpKDCRnED3P3/jm/mNd1tKj
 auxthQt4Yg/jo16fZ10LT1LwLLiKxiIXZySKLJga2F4WviykCu5YVXDTC3ZgOoEP/L7FnyrUu
 q0NsfmjSRnYYH86FMFC5Qq73zYbXQeoBujO2sBsiW0IG128j/5O+gfk7g0xX7aiRmmZj1XmgF
 FEv9wZho4Ko3dPt9zcgJzns8oaVgY22O6Qbo1JVxQcyh7slRRUuQvv9pytYhd5/eahasHosjH
 iEX7xjTaarrBr0TdrWH7GEQ5qoLVbKnx6yPU5cSuidh+NOVAxUpsboqIlBGzjTwlDPppiApuS
 348YBMoISdvU5VrJ50SYzzgWDAoZyjZTghCg4b6QGQeiD2nRpDJEZHtWJf+ccBii+5nVC6Loc
 7b5vg/XgyLwxwJEl8jeY0hGZouYQiwF/UBt9YD/TwndhJvGa7uoAWmVeqsTvSWaS4st56sJ6W
 0O+6H/42+leAukl2I4vulblzCdVi9ehQTqKCI4bsYDal8Ik+EGR1VMew/TNCf4h7gnlYNFT2J
 RzY8GTOAEz60BZxRfYWEwLdP9XhiDED/9J88xkCMXccZHSba6mZV1FxjYTYOu/Hbb6fUWLnwX
 ZAZZBQiDBljSgYfo/FY23DFbOrx6nDxf6sCm+DmYoi3CNAWPDdiXV2xtT0RfrBPRVgY8VMUkN
 DSmeuCq7IQKs+A2Q1u27GervinLVQfgTdy6nKuV1cusSGs/u9k9yXdFikqf/1ut9LMVt6DERl
 D1L+CuWartb5QVZdCvupMWOPx4YohC5gQwHSpfXUvoMH7DR8gcN8g3hHkHDfJeJKGllGrFvXV
 cmHmq+jCahMcfUUS8JltaHxEygFYrGP6EtPdGVtI5j+L1m5wPAL9USDZBZWin2qETuPo0sz06
 Tsg3hwZuuMcZcZmhl+UyUzNDpqqW1GiZB3URDZgqajYhFsE908cuHMmLjViqFawzLDB9boMx6
 CR/O6h0ku6TBViWQzDfEaq6Z0niBqXEhCQcQpEz7efuRz/tq/LhFYPdV7fFfQuHjJqRaiFWOQ
 U/K+ZCjweKeWS898zKLt9ZtNIZLP4mLDSFCi11Q5QZHkRytqh4sb4XPkwjRYYJmpcBPM8rdXi
 6loO6raRYTnd8AcgB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 31.03.20 um 23:48 schrieb Taylor Blau:
> This patch (and the other one attached to this thread) both look good.
> However, the numbering on this patch is a little weird, (2/1? 3/1?). Is
> there a third patch missing, and/or are your subject lines mangled?
>
> Please share if there is more, or if I should be interpreting this
> series differently. Otherwise this patch makes sense.

The first patch was
https://lore.kernel.org/git/a406c273-9a2c-72ed-c5e3-4c19848f0f94@web.de/
and I meant to only send that one.  A few weeks later I couldn't help
but follow up with two more patches.  I don't plan to continue the
series any further.

Ren=C3=A9

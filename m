Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240DCECAAD4
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 21:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiH3VMb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 17:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiH3VM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 17:12:29 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8283B85ABE
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 14:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661893943;
        bh=mAttJhrIf7MQ5ruiUl4F3CBcdV3P3EVaH7xYcFiq3zU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jVnizuVUAkQb+qktNbnxi98PGrW3pyza4D/ycnOgYhtmgIfwlec8IT9wEJF9cqMni
         FEHCIqC1zGJ3UCrnFf+/IeHQr+5syhN4aMmvODcGuWe+KHFBso7dwwu+tSTytRZ+fw
         LjokuajCbc4GSkPZbPyeC5N6rcnt7mW/MN0rXqFg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([89.1.212.11]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDhhN-1oaWVk2glj-00AjH3; Tue, 30
 Aug 2022 23:12:23 +0200
Date:   Tue, 30 Aug 2022 23:12:24 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     phillip.wood@dunelm.org.uk
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: validating signed/unsigned comparisons with Coccinelle, was Re:
 [PATCH 0/3] A couple of CI fixes regarding the built-in add --patch
In-Reply-To: <dc48ce59-530e-da74-93ad-9eb4a17e391c@gmail.com>
Message-ID: <73spp934-1q41-1123-41no-q2337954op92@tzk.qr>
References: <pull.1340.git.1661867664.gitgitgadget@gmail.com> <p9p431r8-nq64-02sq-3049-n10rrn1o89o7@tzk.qr> <dc48ce59-530e-da74-93ad-9eb4a17e391c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yTiXyOTsxv0uExpqnQJKqppmylthhDt5VBcWp55PQ0qX2X+ZXFN
 yID5oBYmIBcruMeIpqly85oxNzsGWLydbf8n2NQezIWwKq69tmJkrasaJcdCbyWo8RhqXjp
 0ujaqmbFOBuaigI2lgehBW4za1V0NH7gHC+D3T9YgegeGO0VB0e/MzoXjOFeQYR/Z1NuQop
 79Tne7b1sW8X8VEYlYuCw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Uy5IRTpilYA=:f0T441swB6YC4UqEALkRXt
 BbF+Nab4tBQWgwqFZdPE8E0RKtllzDCT++sb73IuTt1pM09PAkqemht8Jhpz3siAn+U4+tOAH
 CQjMVClBWy09Sm4CLTYD88Q/C3QZOSszuN/uuQHYUCAasisMYWN2e/h9Do0YlUldWCQrnoFNC
 X/wdQ5MmVUN3rUii1aJaU0Rjk78ZvuB2jBWPWm7Q+aCrfgTwHYxk/ny5lKsPnZvNP9Taq8lgm
 ytOVoceygFaDY9UG+BL92sb15rAF7otTh7Xq6mINgtZAi4cY2WbXbf6gc6pC2XZoTPbtO0nKN
 IGl+N1lUAaE6+znD4W0xk4ojQ+DjDcDw/dHtFV87/gkBUWz5S3y8ZVkiSsQdilrHqV76eEUYj
 3TgAAIqmUbjyjAA8hXqVaAnHBOCRr9B2XvhfXUfLj194F43mZqShKFmM3XD8XRBr8iZzS4jLr
 Bp0z/WkFDXSAb9z8XiAE9F4yUh7MUwqXIJf8r6k4KWDDX+SWJBVUI2vhefN9N6jBH2fmLa9Uz
 fCkwojiXEwsjR7qiXfikK2rfwS3kyim/5IZxHT1trOhZcoFcLm9eT4GZmsTzdembJGJQt+7xV
 51NklVzc7aTFEPoMz0VMxL1a0Hsp8Pfn+i03LfK8QaGMcXCDEZrub+njzFt4a41acUxcpVLnv
 dL5DmDNGjn+FnEMVHXWO3wUt4XrxcC4R7FioVolW/RCR5XpRGV3gTYNkEvzSUyrVv5VWOerFS
 gIKYncGFRd8LFsKqBjovYWVJqapH0di/udNprbGZOGt+pY1zoU6zz+CQxsIU2CYjCHfIYPwIG
 wnCMF1NHfHcMZCdqybV2sxzj7UK0vlnbe16MaHSZy/kNYNanIjAfIbM7B49WGu/9cg75C5X8+
 b+ZcKWOW+nD0libVbcymzD0P+TJNCA4v7UYzn5ZVzvrUHUn/u/60D/YYnnBOWUejgPxArpvpo
 ifxhu+d0hxqL9AuRqiV/NLodaZq1w+Ia6g2UbMI4r9lyAf3yKWItRXupt1Fi4a5uLuR/owZo5
 oqad9NRmLyE4794DjToqh+MS6gtKvZDKUGMi71f9Lbx3vXKqAtiQ8/Aw5XObjAStpQsYvvD4Y
 fd0Lnz9we4k4+eWxpMBgOKJJW7mABrTFskdVB0IWl0AATywmqcy0AEvfmrHeHEaLa82du23r3
 zh24Xgt+3M0Gtf7bPelngp7SxV
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Tue, 30 Aug 2022, Phillip Wood wrote:

> I wonder if they would be interested in fixing the parsing bug we found
> with Peff's UNUSED() series.

Could you point me to the relevant mail? I am sure that I can come up with
an MCVE that will help them pinpoint the bug and fix it as quickly as they
did with this here bug.

Still amazed at the turn-around time,
Dscho

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AF1C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 22:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 215A06018A
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 22:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhHBWPX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 18:15:23 -0400
Received: from mout.gmx.net ([212.227.15.19]:44461 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231875AbhHBWPV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 18:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627942508;
        bh=2epQdxq67IHs2Dbjq+E5J6B1PPIc1EcZ+Ah6OJbfBGQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FQWoF2cRE77JSAsHX7dB6nW4z4NcZwcXBNMQ3MlyyZcjZJad30K6QODtyG6p5yf3e
         jwGoP3UA6+g50rpUHbs8ZBOYhqy/bn2MC6iVKgB2tZlJfEWg049iCeExGWLhjCjynL
         Dd2pC1cizJ9v1mU6B9kVb4A797gLyA3obYdsOW9c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.101.220] ([89.1.212.168]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVeMA-1mc4Q33vEq-00Rd8O; Tue, 03
 Aug 2021 00:15:08 +0200
Date:   Tue, 3 Aug 2021 00:15:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ben Boeckel <mathstuf@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 0/4] advice: remove usage of `advice_*` global
 variables
In-Reply-To: <20210731022504.1912702-1-mathstuf@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108030009330.55@tvgsbejvaqbjf.bet>
References: <20210731022504.1912702-1-mathstuf@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BvtJUEzy7dihjiu4ModB5RzntiXHooT0/nw+FHEGAZ3T2CHmMYP
 yJk7Wr77Oea8bVHHbsucLtCM29/vNVh/TJHFnY6iriE9ZsrxKdnUQ+M3L0GJirQbhawyB7l
 TMsm6o1l9bF+/uRsSITUMHTl5tMjtm7aBzfaGZQ3kfrKspfDmHeyWpACo81ib/CxoQcclvG
 E5NvcealeMTu15r0bypew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cLGHVr5c1bk=:l67wW27tcUhZnIVENLSAhP
 BKGoqi2sXn0u2yc9sy7QTILC8EnRaWhPgZKxYJ6TF3TV9+h7Lg1i5XVXn3/Zwix9mgQduBWw/
 wxR7keORfJ8RLiUFIMkKgLOVX+Q9/YCPX48an8unlhPNxa99JyhYmF4VnM8uT+TZ1FCvuHSys
 yVoOHGRVivtC2gcvZC5ZIBab5AUT2PEOmam3HgKspXZd2h6eWDzTTHSeQwkerHLnxMWzLcU+R
 /Hp/7+YQMuqE+4x0E2gJwzZCfEZsR53k8B80fzIMdZo+8GVHNNpIS7klCYejR5ijXqBfUw4KH
 VH1mEMoCk4SAN2qUjXQpKYQdtQN9YEjYM5xc5JTPoNyU9vdGFezbrnzepjci8UV0w04VyQnxm
 5YkElzM9NlT3qlpXok9lSs67B5vx2ocBgPdNIVe30kAAFzRa7+OWO/aPJ20rFI8sedTMGw0pg
 MnDTbwTLRNrBD+hyIOLyTRGY5kMqwqWhScn0RaDkBrDLF6OdBmR++Qvt5trxai1FsHey6//Z7
 oI/RyrlrRMf2JbVYZ1OP4ua6op+aVk305E653MU7M4nK0hP7CcK2YLgx4peUOa84cugbjXjti
 S+12zz6T93AHHt1vPDzSSmDY1kq+vM7hGua88lYjNVfBodB57qCOvs7Ch47vWAACIj/uaCCig
 JjlNXjItDAA47SZqxAa1VI/0zszbfhBLF5o/o6M9gGWE8UoFfLeJLBGtqO2AxgeWXnti+6gqN
 N2gmFHpG26/qrz1ZmTQ707lJis2jcgO3muE1cFL/jEjh5LpOemOUlSEKsW0CCABImJ/A2jl51
 wUTjK8B8vTdhq2DWBvW0vB9zS5dO+MIhdNN3rP2pcLHegxgQjBB+lSFOk1aAOv3G8n0prxbfj
 aYiZERJzbMRKfBDvWDRikP/fiPhMWvozC8K8P/Bi2sbQF5nvSvfZiHAOhlOPITO/eYVxnSxBE
 bKiPtg+GY5zD3tCz3vtlvxlA5Ba1ONAfXTnyGhGPwfJN9QDEOoWQS9ccpVgvDV9k5pjPmk8O6
 rdSyGJ1XUEYAwqnsORpW28l1eAOuZKNodLsvntGmjyfLrTQLYZ6XN2GFuHD7r+kMxYtfuCPNZ
 SGv0SkXWVeG58SOUCmXVMcWBK4sD9wG1XuGP0tPy/oTsB1EKSDgevEFGg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben,

On Fri, 30 Jul 2021, Ben Boeckel wrote:

> When looking at global variable usage for my `branch.default*` settings,
> I found the `advice_` variables which were simple enough to resolve.

Even better, it concludes the journey started in c4a09cc9ccb (Merge branch
'hw/advise-ng', 2020-03-25).

I reviewed the entire series and left a few comments I believe to be
constructive.

Since patch 2/4 resolves a problem introduced by merging divergent changes
(one adding `advice_settings`, the other adding two entries to
`advice_config`), an obvious concern with this patch series is: How can we
guarantee that we're not introducing a similar problem when removing
`advice_config`? A future branch could easily add entries to that array,
and a merge of this here topic could potentially forget to add those
entries to `advice_settings`.

However, such a future merge would always cause merge (add/remove)
conflicts in the `advice_config` array, i.e. it will be much easier to
notice such a divergence, and hence it will be much more likely that the
`advice_setting` array will be adjusted accordingly in such a hypothetical
merge.

Ciao,
Dscho

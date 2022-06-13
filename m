Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DB7C433EF
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 21:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351884AbiFMVU4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 17:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351757AbiFMVUh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 17:20:37 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86190496A5
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 14:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655154205;
        bh=EDIHD5c+ZoKBEeZuSENmiXrekkwAsRbVHoL8IHyx/n8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=I6AEzyePuMzT8pasWxEpKehpbc+PJRqOULhObnnBQ6otg+HT8IHui+QTFcIwQ26Kk
         l7itke4cEr2gjBXsaHC4OqxEfqjOP49CPmCbKeSG+J8iYM1D/we/fw17/B98EYYiVM
         fwW1+c3BrJoq1ThC6gmQNzfHng1xmL6KbVYDheyo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.123.239] ([89.1.215.185]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MA7Ka-1ntgDn0mcs-00Bg2a; Mon, 13
 Jun 2022 23:03:25 +0200
Date:   Mon, 13 Jun 2022 23:03:23 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 0/2] Integrate Scalar into the CI builds
In-Reply-To: <pull.1129.git.1654160735.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2206132246010.353@tvgsbejvaqbjf.bet>
References: <pull.1129.git.1654160735.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zLAwxZ9gGxEfJ+xvGDLR1ZXKm4ZvhhcIgpxFwj0emp9SVWqJFiD
 ZdMchlNJxT5hDvfU0VEGTCcUtZ9KVQpZkfTBJaNtsbn3nNaMhkmboPbRVPolGvu9oU7IrT3
 +ExvRk9OSQ0cHscavQ4dZy7353bUHdvB/EG3kIyGnQnbl7OZQk+oapKM0t70DnbYjDbnMq+
 l28nuCE2BuviycF3vg5Fw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jFrfq4SsC9s=:hjrAowinK0U3EWEYjmr4Us
 Fm+WswbHFk43QCmamf/bvg3SM5kcztK14K61B87kwJDhjaceopq1c3aCHfHv+l8U2N9O8o6rb
 pk5k44opQDRrELij0gtNBJb+n7eA7U+0KwZqdk23rbR44LLy6FFQHuVo4Tdy1lPHcQOsZ0dbK
 plquQdBin7rhcnuaWyaICDU/fkUGJ747Rokuy9tvxm0y4GQuNlp7yNCTuX+/E/rAlWGkMbeyG
 /eT5X6N6HnIVjZiu/5cQmFV5NsMFZb/ADVQDZvcDK4wn9teIs9+FFx4v0MbW4vKyGAYhViNbc
 dHHi0F5L9Dh2odKMBgSvRAQrq4+yskAXlHcJkeS27t6sN6+ZY/gzt3B/mJ477jMQEH/8X2iGs
 1Oogxu8gwhrbtXNwiY8o+Sdm5B4UMp2HHPkOeCDrXmamHyx53V0Sqc5+lbfUQOaeY50Z3jFfV
 tJPCEyn9AzDyHEYbZ5XRTyeF9RI8ho7M5jl2Z6C9ieIHipx6FEHqdKgofnAoiFD3KUJgDeQr2
 zFqlFqrdrKqT/Yugl0Uqx5tNtoaQu0MdmOpKr20NAzwm34Ewd5CD2eX3bMUs2PcDk97tHdCEz
 uEFF1fIxyRc3aFoEEqcZxRT3Te1U/3Tx0Losf1uTvIjymaF8aV5i0XgPIuFjHsnhfR0VmpJpq
 kTRUyRnwju81gvVAUuFUVMLA9w5XyhUIJ+CNiKhxQxYe8ZiohedPZGhdjE2/UDMbTiP1xwE42
 9CCK4EEhaRo4flBz30TO2dHfxsbUh0zFEwi7YAzZ68TiGFBYxmhR5P8ap4AFvQC1O2yMuKZEL
 DnLlGBYABthP4g911Rg0gC6CUWWwAUK7nA1VyAiJTZEAAFhlMqHlqp8Jpn/qRLf52CkrjG6WT
 tscJ53F0rKmWoXXtF5CKyRP4xFairv4DtP+UXYZtFWoJwmPWRgivJWsQMO4guKNm6B3JgDGAj
 RhWm0xYZ1YXgyF0tg+8E4kni5/GeioGZpFDGfi73y1O76m/NZxiPWElx37MLof3uHDiEDyT2f
 k2Lxks+3H0+k0EbO10Gs7KJlWmInEAT2piTW79MVmZE7Lw+EpxA0WLjE1AQQxsu05S5eQlBrd
 g0p/8cE4cAK+69UAvjRliPCVJV+pvLmoDM2L3Gn9yH5ntT/q9ui19wXrg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 2 Jun 2022, Johannes Schindelin via GitGitGadget wrote:

> During the review of the initial Scalar patch series, it was suggested t=
o
> include Scalar in Git's CI builds. Due to some conflicts, this was postp=
oned
> to a later patch series: This patch series.
>
> Note that the changes to the GitHub workflow are somewhat transient in
> nature: Based on the feedback I received on the Git mailing list, I see =
some
> appetite for turning Scalar into a full-fledged top-level command in Git=
,
> similar to gitk. Therefore my current plan is to do exactly that in the =
end
> (and I already have patches lined up to that end). This will essentially
> revert the ci/run-build-and-tests.sh change in this patch series.
>
> This patch series is based on js/scalar-diagnose.
>
> Johannes Schindelin (2):
>   cmake: optionally build `scalar`, too
>   ci: also run the `scalar` tests

Upon further reflection, I would like to retract these patches for now.
They do seem a poor fit within the Scalar story arc: in the end, they
won't be needed anyway (after moving Scalar out of `contrib/`).

I talked to Victoria and she kindly agreed to drive the Scalar upstreaming
from here (after v2.37.0, I imagine).

Thanks,
Dscho

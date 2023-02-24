Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF44C61DA4
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 14:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjBXODP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 09:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjBXODO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 09:03:14 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEA02CC71
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 06:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1677247388; i=johannes.schindelin@gmx.de;
        bh=EMAVfSZGA5qchwfg8B2E0voeigl51nn7s6SUyZ72mNQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=iVpSYsecuyJt4jElRwEvr72ys1hZEx8vg63jDAv07HWeSD74RkDw387IJZEnHb9pq
         FAxXX9pIkkgmMu70HW5DKTcPv4wMwt0wPPB8JybiEf/SxuvuCwQdVycdMKoNck6Xxe
         x2MIcKtje5aOR7amAqOHsSNwkswza+E87iqJFjmu5vxLrIo5W8s7WLK+x60HLgRiSZ
         DLS7Tuv8vBuMZnHVJFta7v2T598gd2TA4jl/t0jr8e55g7dKpQMPDgFTFXSxJUdVJN
         NVROcD4tAjq96JvGgf3Vyf4cmh26QCKxlPtCHYBCncxlxMvzw4tiS4/1dAB8kcgD2b
         acg6s6r1ExCZg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.30.113.48] ([213.196.212.111]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAfYm-1pKbNU02XY-00B5fu; Fri, 24
 Feb 2023 15:03:08 +0100
Date:   Fri, 24 Feb 2023 15:03:06 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 00/17] Header cleanups
In-Reply-To: <pull.1485.v2.git.1677197376.gitgitgadget@gmail.com>
Message-ID: <2e357002-fc59-e7dd-97f5-9d77de6480af@gmx.de>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com> <pull.1485.v2.git.1677197376.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/fzKbn1a7HQZPdyolkMgDGiYTfepX8VMd3EOzP8nJkG6OKMvOfG
 Aqt/jJnZRcO3qTds98jsjVP2f+pTpBpSUHYBx2z1ZyU0T10fR7BaHlIEnuXm0UGMh2QkICW
 CAQIQYdprjuHEfJLSWUr8dzg7nhvBskMF/Vafn9OKhYuli0Te+jgGMWru0olJcVpCm55yXS
 McsCbbsAJ2YkmK/3aYPtg==
UI-OutboundReport: notjunk:1;M01:P0:ar948vOg6+M=;q4m9BUmBrvs4EnsWCGhS/QJ6WqV
 BCgPAFvOYn7YsH2GQzuigFWrX772x9qJEsH9KqYbKHogaGL6Cv+gt+ANUYTbJZCV3wyv5+4ER
 a/ebUVrVxjkVvNoGPnaZtynxoxUtSKb83YGAagGAfq41b24Kf26VSRpQQmTKI3ljEtAMsWQ02
 rdwKSCHyoO5tA3vcul6aPxHiCn9VaSPZgyqJ9yaCc6Pl9lMmp/n3zJgdw/yDw4eov/uQmQeMM
 YUiAYXYJz/fQLOkyMco8KGhTG5ZCtWIe8S1D9skpn3ddUb9RoLhAS5oZc3UVbtg5BhcW6AsTX
 wYh8dLBffcQZMshlfkw8eX+AYVuP/Ue0vCcGRNn+LgMPOme0g4H82OURMDZeiZLzAXNrAjdvM
 U+F9BEnexDWjU0n9IFaN1HU08FZBUbBmzPbUjILrdWG3TRmQ92S7cMURetGhQmSYm+fS2YkXn
 fRq//8xG5HxhBOBwteve09GVOtJw++ZJLtUGwHFLjQvBrv33e9jsM6F53TYROckFw7dSal7T0
 16NRN4yPEIALSo6n0ZdfQyqM18NUvbA4gvII6T8jD/NwN+AgzIL3rrkOAFO5yKORAvEDA8H29
 y1LZaB12BAyU2s1XpHpYwVRFfVII9HmdZwlHAwhVL199H1woO7r/NFs69Dzy9C95bAfXprLlc
 UY6dEh0eY6T7/SyNAYYAR1zqonJa6LGyCb6fqmVBocd59kDlXelQSpFxKXSwfXogQQeRB2N+W
 niVYNkRAEsdzs1WKc7CFaSSPKmgnKlmtFz/Mm03MidsKj6E2YeUD9Mxpiozo1IG6vB9El0EYU
 E5nDualiHVXCG3iQRvKxtmAF1gRL2KeIr7e7UhRdCge4hw321CLNRvCuSiPIFTkboLDiqe710
 aamfo3hqRJ7FqShwAfN8Qgs+EN/n9SI1XimACjjzQScT/a1aZq7L/Cty0Tj7jEqJlER23zL95
 veVT3Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Fri, 24 Feb 2023, Elijah Newren via GitGitGadget wrote:

>  * Big props to Dscho for gitgitgadget; being able to test on a bunch of
>    platforms with a variety of configurations easily is a big win in general
>    but especially for series like this one.

Thank you so much! It is gratifying to see my hard work bring benefit to
this project and its contributors.

Ciao,
Johannes

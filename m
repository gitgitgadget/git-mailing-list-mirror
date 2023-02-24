Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF592C61DA4
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 14:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjBXODG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 09:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjBXODF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 09:03:05 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C16D83D0
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 06:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1677247333; i=johannes.schindelin@gmx.de;
        bh=u4egKLlmvXWgu7hZeEPy3vI3kCRG62d4hUWp+sb4jY4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FwxtTbnkEmRJFoHY35wKj2wtYBYDO7KfW/F4V3VIYHPwnxdm2HN1ORROsMC22Pq1X
         Y+bd3j5yJ7pW2alaOoYm0yETjc4KWFVSiGrImKipoRCDnjY3iWOTOUL6hxMFKcsWC0
         rwu4p3Fy2Tb68qNi3qKXpAwMcmsnrboJks/FQnlG/+8V+UQtGBTzNmYjBmamWo/I+U
         Cq7ZX6x+gfMiW8VBPI0uYATarA7H94smyjvbcTVx/HUOnF6ULhunrDEHcDF2oWc4Ly
         JZFifp+NWyYKnc4v9IogVLNvlnJSs0Fw2Rqz3Z8lP0Y5j2hRKkQmtxdkMtnJx5KykF
         ZyLNec94Zg1ig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.30.113.48] ([213.196.212.111]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtfNf-1oeI2c04ul-00v8sx; Fri, 24
 Feb 2023 15:02:13 +0100
Date:   Fri, 24 Feb 2023 15:02:11 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 0/2] sequencer parsing fixes
In-Reply-To: <pull.1486.git.1677185701.gitgitgadget@gmail.com>
Message-ID: <7fd72747-e076-3741-adb4-954bd4c7e9e5@gmx.de>
References: <pull.1486.git.1677185701.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yUw6xRDRpgqv9etOEmD1kNCTUvjD8zyRMbJ+jVk8Bj1F2Ts/9RY
 Vktkd9otooi0gAfr1bwxdWwFftf77RiiCsEjwzPDqn3tiPnHmapaLEJDk7rXJJSwBJh1P3B
 AcoCRCUwL2LmhyrV/q5sL+5xe09Xz4sbsAbBHj5NGoPzphJ5+yLx4cXLRnXvtF47gImPB6t
 Tv1kLELeRWUTJPRmVgOgA==
UI-OutboundReport: notjunk:1;M01:P0:9Qt6jqZ98R8=;FoSliPuUsUxBxRN74bOjg6yGg8K
 G7fJE6WYY5NP6FR9XbXfr+SzKhva1fB5WGafFoNOtKMmqKyEyYsEoJ1IL9nchtZ3hKab20S3J
 tQfEVAPd7oMLInEZcbM7VyG/HoBO9d0aUeswgkH4A7tLoZW8ApNURh0Esc55d4AYrMAP5hpDd
 mpcBwiOSuCfbHrtX4yiMJ/OLKQ55ZXGPWwXitDoWxpntjWtPNiYGrmx+McZPns0CB8cJRUfyC
 9iSdQAnOQobfRMXyUNYWqO1lnK928b38nRnJJ049UZR8ZjpD/rpofm8ot9YPW2mTUvIvxtks9
 pTH0W3DPiNo3Sjuuidt5EJH9y5n5hlKN9ueDtloQWdjLbQmx934VhYLhZVLI4i7xXqptC4lJi
 P0CgRpqp2L2m7tYm8bVd2z7cTS1mTWkoMzd9FB50FeaqrsBEVy50r8CIafVrCKdxKTPuz8Tj5
 +vBQSVG9+U3FPuJxrwihx0iKEwj22F/ZEuQjJQzo4xdNAFlsc8fE76qW40+stGjRW+8R1Q5Bv
 bkigzp7uavsiLiOTM6MaLb1CCb9g/GppQEKHd4hpQT6VTbn9tkrvsfEGelIuEyT4+/ZJBskSX
 tVHCGHH9i0RCJMowV7DKMAPqO2SHFeYvyEAl14D3b/nAUdxQCxFEweLLAuHus6bVyInMRRPoq
 //WI9yIqpAxBxM4TJ8pSnypHrsK+/ieBJimL58/0TTsxCLQSlV6m3iKxdlCnX6wjPyVCSUrhV
 6V+0cJuVIM9ID4nInX1Re2vRv6Zse5MPtsHF5Y7bwFuLKhszvG8CpGlE126LQGTrCGFD3o8+T
 0U73Mjn3n0D/moFBKuDH5owm4hTqNyPxbg8zoC3j5UKakPcsKVr1aYfq/pRbjvnI9vt9jK/zG
 YztEW6666fNAzVkTQrgsjAk7SkTH3ozq5GwoGE6mYRs8nl0U9SnjFQLrxQIGCOYAsnXytyXH4
 S1uv350fkCCO96OfXEErxj8/TDA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, 23 Feb 2023, Phillip Wood via GitGitGadget wrote:

> Fix a couple of small bugs in the parsing of todo lists

Thank you, those fixes look quite good to me.

Ciao,
Johannes

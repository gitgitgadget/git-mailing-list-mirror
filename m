Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 934B01F404
	for <e@80x24.org>; Sun, 18 Mar 2018 18:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754026AbeCRS4z (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 14:56:55 -0400
Received: from avasout01.plus.net ([84.93.230.227]:58217 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbeCRS4x (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 14:56:53 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id xdUBePc7dMLyGxdUCezFUA; Sun, 18 Mar 2018 18:56:52 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=HInt6Llv c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=V6HVuTh8x5wzoi1PcHkA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] Makefile: detect compiler and enable more warnings in
 DEVELOPER=1
To:     Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20180317160832.GB15772@sigill.intra.peff.net>
 <20180318081834.16081-1-pclouds@gmail.com>
 <CACsJy8BOCpHiMxJ0K=_-WPf9b4yh0W0i3m9sAo5-Sk5fY9x1+A@mail.gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <d30d131e-1cfe-fedb-4a45-7628615a7876@ramsayjones.plus.com>
Date:   Sun, 18 Mar 2018 18:56:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8BOCpHiMxJ0K=_-WPf9b4yh0W0i3m9sAo5-Sk5fY9x1+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfA63EAcZ2gaCef2IRrb90oEX7xzDr2+wljpaOcOw2touK2CP7S/Pyp3I1d70q5MvafE2xg5KywHIBqwy4a2tU9FjoqAB+ePIVo4GNYzY6AY5vka6Qq7M
 8NfrLpo2dEuUbxcAbAdenkaaaVbhKeBrlrtnZeYyhZ75NB9LbRlkN5lCykiXhaWbQ/Lxj0rqpxB6FA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 18/03/18 15:55, Duy Nguyen wrote:
> On Sun, Mar 18, 2018 at 9:18 AM, Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
>> +ifneq ($(or $(filter gcc6,$(COMPILER_FEATURES)),$(filter clang4,$(COMPILER_FEATURES))),)
>> +CFLAGS += -Wextra
> 
> Another thing we can add here is -Og instead of standard -O2 (or -O0
> in my build), which is supported since gcc 4.8. clang seems to support
> it too (mapped to -O1 at least for clang5) but I don't know what
> version added that flag.

I've been doing a lot of compiling recently, using 10 'different'
versions of clang and gcc ('different' if you count 64-bit and 32-bit
compilers with the same version number as different!)

However, I can tell you that clang version 3.4 and 3.8.0 don't
support -Og, but clang version 5.0.1 does.

ATB,
Ramsay Jones



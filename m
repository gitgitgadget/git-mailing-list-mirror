Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CF621F404
	for <e@80x24.org>; Fri,  9 Feb 2018 19:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751055AbeBITxe (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 14:53:34 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:51617 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeBITxd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 14:53:33 -0500
Received: by mail-wm0-f51.google.com with SMTP id r71so17457540wmd.1
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 11:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EYzHtcKoe+XQO7UpllP8AnilbPTrDCUQjBS/hKc8U5I=;
        b=DH9N4hL7Mi4q7Q/hxh7yLU+smgB9Be2wH95epb63R1e8TmfpHMYWYjA+F7eBfn9uRz
         F3oFnDtPCzX5iWf2S34vTnsQTAxTLTOgNMZ9l8cgPoytC3XtOFTrjJgrK0+kOSVs/f3b
         N/roy/nlNyBujr/SyIRn8DgHbCLB2dnIx2DkYD/GcKQc3DEIfbUyq5R0kUIjRqOfT8Pu
         qnk7aaCB9dLf7fRkHynalYfX6Q4EW84siNoM6WYUqRTZbtPz/zw2ZMDYZFkACN6/5PJB
         or18yqwUyIJ+AJBpFe1T0ZeuErIVa8FTlrU455K2LyD6kpr99WFCECIMVKpUSN2IYR7Q
         QbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EYzHtcKoe+XQO7UpllP8AnilbPTrDCUQjBS/hKc8U5I=;
        b=R14Nxd18t6xeckCjGpBeBuUc0aBsxQsxKwwwgylEVSB7G0FYwQ/MzZspo7IrtNOzbc
         8R1GECmP/stUCW1d0Qt7NVCYYA8csvVo46JmjwYSszQupT0RUFrBbAeF/8YXBQA5yOjw
         thMDgCfUz61m4Kl9+EKIrEShke+QAgwF8Q4KPRnfqi/lDZEiETX4PSa32fL/ws3Cxdx9
         +2plez/t3JiVsru4XutOx0a1N8jeqbF6cOrjv4UiaXRLBVO1P3b4yKVfIQU8jAB9Sfnw
         Zhq5SS6w1cLeK2cIss92RJ1D02C/zFEFuJw0+0bmZxhz8bEgBb6B1ZTvCJu9W835SuG+
         feQA==
X-Gm-Message-State: APf1xPAmDvzBcXvob3jWLmMS/hQhzP0OxDUwgJwE0KjsfdldYVzwYz+R
        Wv8nKKcJfaROp8uQHE/KZ5g=
X-Google-Smtp-Source: AH8x225X2VoO6gV5SoOHPxbdBh66xmDNz6LRkqD+Lkv5teAJCnmIQzZGThDRCtP46wGl6+/2dWC7CQ==
X-Received: by 10.28.114.6 with SMTP id n6mr2713171wmc.87.1518205671503;
        Fri, 09 Feb 2018 11:47:51 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5C3C.dip0.t-ipconnect.de. [93.219.92.60])
        by smtp.gmail.com with ESMTPSA id x127sm2555380wmb.36.2018.02.09.11.47.50
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Feb 2018 11:47:50 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v6 4/7] utf8: add function to detect a missing UTF-16/32 BOM
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqshaavu6i.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 9 Feb 2018 20:47:49 +0100
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        git <git@vger.kernel.org>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>, ramsay@ramsayjones.plus.com,
        Johannes.Schindelin@gmx.de
Content-Transfer-Encoding: 7bit
Message-Id: <7EB198C5-7647-4E37-9FA3-035A48E2357B@gmail.com>
References: <20180209132830.55385-1-lars.schneider@autodesk.com> <20180209132830.55385-5-lars.schneider@autodesk.com> <xmqqshaavu6i.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 09 Feb 2018, at 20:28, Junio C Hamano <gitster@pobox.com> wrote:
> 
> lars.schneider@autodesk.com writes:
> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> If the endianness is not defined in the encoding name, then let's
>> ...
>> [3] https://encoding.spec.whatwg.org/#utf-16le
>> 
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> 
>> utf
>> ---
> 
> Huh?

That is garbage, sorry! :-(

Can you remove it for me?

Thanks,
Lars

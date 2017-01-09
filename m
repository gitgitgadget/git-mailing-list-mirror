Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5424D20756
	for <e@80x24.org>; Mon,  9 Jan 2017 10:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935301AbdAIKLF (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 05:11:05 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:34341 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935286AbdAIKK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 05:10:58 -0500
Received: by mail-it0-f68.google.com with SMTP id q186so8779899itb.1
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 02:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=K9XkeQPBmUFKAei2KBwNCgo26DvwIIQoRWMDP5OFjx8=;
        b=bQ+UGo+nPzddItovjn98POJbQjtihX6vS2XYM1jlUUvB6Yh6u9M4mO1vcY7cb4vBLe
         0Z0mepy4EyswW1o563oj6Z9HZZQB7gZ8kJsJqcK82yigEwmxPCrw+1u/kwuTZeUVgALE
         vF24ni9miECWN0WctWdExOZAnB6Jwt82acRNwsrFSOZHXkeEqsL6bsaN1AdTVIPUZLWM
         IvD8VIm5S4PNvRudiC6/dorTOjZeNLamTKO0XXLJFsCF5HlC/FFF89mHweCx6ANrl4hW
         2XtTPjmAx3Ex11TmWMqePhVWfHxZglBTwEi1+5z2BT3jgD6X2TRgRs3kAjarxJlZa2vE
         et7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=K9XkeQPBmUFKAei2KBwNCgo26DvwIIQoRWMDP5OFjx8=;
        b=BUKp0sOihqLZhmy93cPAGgZJHNnWLDay89outXO84rXibKJ2E0KmS2IOzgnQm+PPMs
         H0+NHUVHCf+N2/OjvWzmh8fIDjdrYsZwai2DA6ClbQDsg1LSlXCrcRAYujSzU9iSMJnk
         4LoeTS+Ex35A3MIOz6PLWPLYlEFnsWpBeMZHHK8oEjr4aT0W+m3jlUzZyY+lgu17tydO
         UkRGWh/es2NFybQf6IQ15qMYiiJwppREqv27b2v3GOOOr52Qwap+efyJcRng5ElugqTt
         CravRHlBI3Z73XplcdlDMGLG3PkXJudFYYxGine5ThnPoNLh9FFiVnzcsBqkt06e1rN0
         lO+w==
X-Gm-Message-State: AIkVDXI38/z5u2ZZXpa7spjVaxUefQilNBv7mhD3Eq4Xt35HfYzjplxLawz2KhIF4xC4PNm0zWCB9FtNn0WwUg==
X-Received: by 10.36.184.194 with SMTP id m185mr8166771ite.3.1483956657804;
 Mon, 09 Jan 2017 02:10:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Mon, 9 Jan 2017 02:10:27 -0800 (PST)
In-Reply-To: <20170109053446.2vg3y37ck5ahhyxg@sigill.intra.peff.net>
References: <xmqqzijjd34j.fsf@gitster.mtv.corp.google.com> <20170108101333.26221-1-pclouds@gmail.com>
 <20170109053446.2vg3y37ck5ahhyxg@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 9 Jan 2017 17:10:27 +0700
Message-ID: <CACsJy8BifECbq2K0W2B0-pAxCiWpVgzTdhVLKv01YDSLgcmi_A@mail.gmail.com>
Subject: Re: [PATCH v3] log --graph: customize the graph lines with config log.graphColors
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 9, 2017 at 12:34 PM, Jeff King <peff@peff.net> wrote:
>> +test_expect_success 'log --graph with merge with log.graphColors' '
>> +     test_config log.graphColors " blue , cyan , red " &&
>
> This funny syntax isn't required, right? It should work with the more
> natural:
>
>     test_config log.graphColors "blue, cyan, red"

Yeah spaces are optional. I just wanted to put extra spaces there
because I hit a bug with them.
-- 
Duy

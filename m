Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF93E1F406
	for <e@80x24.org>; Sun,  7 Jan 2018 02:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751366AbeAGCwL (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jan 2018 21:52:11 -0500
Received: from mail-ot0-f173.google.com ([74.125.82.173]:39602 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbeAGCwK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jan 2018 21:52:10 -0500
Received: by mail-ot0-f173.google.com with SMTP id 37so6832946otv.6
        for <git@vger.kernel.org>; Sat, 06 Jan 2018 18:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=u9GB05nc7qkmeRry628wbNH+fUp0EeB9Dqf7wCRtXl4=;
        b=XXuyY/JLn6Y5E5rjk+DNd9TzgNXTe+YvEDkcZw8cKeGBGH/zuPfag9gKMz0otoQruv
         dVLgVNmPO29NogWrQ+rmFViMBTUl4xvS2XPYh0jpOy7nznkVYVlZeinzwaAsgpxj0Aif
         qaO2x9Ng/2ct7m3FhqTOIF52mOwe6LGQF+XSN8OSoKeWRkFPX0YfZRftnc5d6nl1F9pj
         C5YELYyYBfgdM7rzbfUVcW9p8Ia7SxVDGIfJcSExy8XqMJBRrvQ3lwh4r+S9/cMncjKD
         3wEJYnAjVdvOmpPKogStjQY6u6aK4ekduuayFt91Q3CVUUw0w1ySdoZJC2pvmG8XUGFc
         b3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=u9GB05nc7qkmeRry628wbNH+fUp0EeB9Dqf7wCRtXl4=;
        b=SVfeZUhq9OMMJPuyF6hbdG7+Zs2gyFnCUsQaL3xx6YnHymR1VgZGO7VA/JrpU0cJSP
         qzlGCwxbd86CyJiV+PQJ4aqBONEHigXClP53zV0eNOEu0emkRaHEaDNM/UI6494+jE5Q
         w/zjEYNhd6DprWypeH0estwhd7r+DWSLZyLouQzKppLOPXeyXg6UJgolxI1BM5EIt1bx
         EUHmVIwyvLG/j6ocHw6oLTfBdcrlx5J1qP3hEHiKL1DtamE5Ym4CEoJiGNfJWZ+eopzR
         DA53DtIGztLZ9TdhGZFcaVK+ChUGRuIk/Hpsth1sRP4x8MwLoNArAXBFo1NH8QGubFxu
         R/Rg==
X-Gm-Message-State: AKwxytd+DCxAS53NCjlMbyF1NiOww3k7kq3xJmXD1uAne+UpqudL80Rd
        mXacDURz4KBO+z4wT1vOFAW8pyRXG6cNf6PuxyM=
X-Google-Smtp-Source: ACJfBotJltyg+OHie4D3Rri4rosDADt2af1fMSQ+Thr1aRZhbKe3xcU8a51kf5Vz2kptgXyb9fBVwjTZr66y4YZVobI=
X-Received: by 10.157.45.198 with SMTP id g64mr149542otb.226.1515293530083;
 Sat, 06 Jan 2018 18:52:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Sat, 6 Jan 2018 18:51:39 -0800 (PST)
In-Reply-To: <nycvar.QRO.7.76.6.1801061337020.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1801052133380.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
 <20180105221222.28867-1-avarab@gmail.com> <xmqqzi5raogu.fsf@gitster.mtv.corp.google.com>
 <nycvar.QRO.7.76.6.1801061337020.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 7 Jan 2018 09:51:39 +0700
Message-ID: <CACsJy8CDz57RR+VHpaPb5YMhKG5kUgb9rt5TWKL8n+e7Xart3g@mail.gmail.com>
Subject: Re: [PATCH v4 8/7] wildmatch test: skip file creation tests on
 Windows proper
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Anthony Ramine <n.oxyde@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Adam Dinwoodie <adam@dinwoodie.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 6, 2018 at 7:51 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Nobody likes to run tests that take too
> long. And look at this:
>
>         ...
>         ok 1511 - ipathmatch: match 'Z' '[Z-y]'
>         ok 1512 - ipathmatch(ls): match '[Z-y]' 'Z'
>         # still have 84 known breakage(s)
>         # failed 52 among remaining 1428 test(s)
>         1..1512
>
>         real    5m51.432s
>         user    0m33.986s
>         sys     2m13.162s
>
> Yep. It takes *over eight minutes*.

I suppose this is because the sheer number of test cases adds a lot of
shell overhead on Windows. I wonder if it's better to rewrite this
test in C instead. We start to do some more unit testing here and
there and kind of abuse the sh-based test framework for this. Having a
proper unit test framework would be good anyway since it's sometimes
hard to create a specific scenario with high level commands.
-- 
Duy

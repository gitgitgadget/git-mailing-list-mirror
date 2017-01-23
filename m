Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0A1D20A17
	for <e@80x24.org>; Mon, 23 Jan 2017 22:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751822AbdAWWdy (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 17:33:54 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37300 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751677AbdAWWdg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 17:33:36 -0500
Received: by mail-wm0-f45.google.com with SMTP id c206so180170937wme.0
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 14:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dsen88hgce46iHN34f9KR3w4gAH4tnlMO6+tcbdS80U=;
        b=UqY5tMUkw/yfHKNUUyyXlRW8VK2LP9qkCdH51TssncnZJDCr1y9SnFyWSBGnT6X5+T
         w8C15FyPa417FUpSo8LpLQVI62nqeLEky19vwn4Ac6YnWiutDOq+bTPOdGn3+h7UJT8d
         kRRZjgJATLBJ3YCpWG7KyVFuqAeBfk5rfFni2VWtnh7afKW30XA8JnMvhnzwF3XwHMQl
         ngw6CwJxBvkSplTkB89e4sEELagURPaUcgCqcXGQTSehMirX4Zv0Oc4NQCEz1soXIv50
         9WqY/TMfgWWSTqy3rPM1PiwRGpgM/yvPW5DPF6n4v1EpvvVVrZrMQ5uQlU0DUoJRaByn
         huoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dsen88hgce46iHN34f9KR3w4gAH4tnlMO6+tcbdS80U=;
        b=DjFZNW9xsrnBvrQXFJEhnTqcAQRTuM6XzDfghYxiYcanlYA3necRo7GYF8O7iYRTJB
         rzLfRNp/IO+os9TRJnW4DTDZmenO4hg83BgI8eok1R3udX47UGysmBJ8iHoAag7Bf92b
         NcXGLTYT4n+/pHwd6l+Scge23KSujcAppnZAsJGNF/T0Y5OGB4grHzeWc5qHFFZC7GLh
         X1a4UJkKOobohlpJNBMFmlV560gw1gUL28A6xoFMgjthtW3FJmhFaDEQtHLMzh1gRvbj
         gPfX2emgTFL6tBPuzpcmYV7OrG8t/PiQmmlEkjuH8dvQLuIE9Wn8+GVK8GbPtwZJy4jo
         uUgw==
X-Gm-Message-State: AIkVDXLA+u++F0mVeDtF298rnkzFWcNyQwyEhWk1xZr5zws5pI8fAGCi0yE8i9m1l2RlnvJonv8p8NT33QaKcg==
X-Received: by 10.223.166.80 with SMTP id k74mr25266219wrc.171.1485210807596;
 Mon, 23 Jan 2017 14:33:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.145.193 with HTTP; Mon, 23 Jan 2017 14:33:07 -0800 (PST)
In-Reply-To: <xmqqfuk9r0zw.fsf@gitster.mtv.corp.google.com>
References: <20170121131629.16326-1-giuseppe.bilotta@gmail.com>
 <xmqqpojeu14h.fsf@gitster.mtv.corp.google.com> <CAOxFTczut_CGGxmbrVFzhn_o4=StTOY6N1mEAw75Ro2Q4tzWgQ@mail.gmail.com>
 <xmqqd1fdtzgv.fsf@gitster.mtv.corp.google.com> <CAOxFTcxRjWS-=wyGBVOtg-tfCHrqqAr9rVOcvkyxXwJHonN_Tg@mail.gmail.com>
 <xmqqfuk9r0zw.fsf@gitster.mtv.corp.google.com>
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Date:   Mon, 23 Jan 2017 23:33:07 +0100
Message-ID: <CAOxFTcybikUwqn8kTTkuKPo3B7KiYJvneoDrr=m2fpN5RefbGQ@mail.gmail.com>
Subject: Re: [RFC PATCH] Option to allow cherry-pick to skip empty commits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 23, 2017 at 9:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> ... I still don't see how to force a complete reread of the index
>> after running a git reset (which I need for the --skip command), ...
>
> Do you mean discard_index() or discard_cache() followed by
> read_index() or read_cache(), or do you mean something more
> elaborate?

Apparently discard_cache() followed by read_cache() is exactly what I
needed. New patchset incoming 8-)




-- 
Giuseppe "Oblomov" Bilotta

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A71951F667
	for <e@80x24.org>; Sun, 13 Aug 2017 19:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751119AbdHMTEI (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Aug 2017 15:04:08 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38027 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbdHMTEH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Aug 2017 15:04:07 -0400
Received: by mail-wm0-f48.google.com with SMTP id f15so28550277wmg.1
        for <git@vger.kernel.org>; Sun, 13 Aug 2017 12:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KOZtZMT37MKpftTvDbHiG8PhO9C8dA9MTuz5JFQum1E=;
        b=ePFUS0FPPRCBHikB+iYiroQbd15G1Yvr12YokBbZ1KDFPjDkuc0xKzAyUKGguXynLE
         B/Y7VvEA2HICCf+4Q43ghaw/EQlgmsU0Xfl0DEH+drCAEGakzPmw5tMSYhQetyGsRBgt
         y8toebwW4T8MQ1P0SaK3+xWqTnChsH16e5MHh2tZU4M1a4x1Ddn539csKm91p4b2xKc8
         lOEjJRl7Ie1ojBCP+jpDkOS74l6QwKtz0zYFDDUYBEv4wIpZ5hKfOjTTngzANpG/QDPV
         qdWvS9ZafCLGlF3SRY+t+QQVrT/CsK82HAzieWiq6/3q1kBAwRrl6/NnxqKghg8q1YUL
         g9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KOZtZMT37MKpftTvDbHiG8PhO9C8dA9MTuz5JFQum1E=;
        b=RnkE+rriWPw0KNzPdJcdD0nJwY9pq9j8YmolFx/qGKYWrIyMI9sVCma4S923V8uQQ8
         2KZNzjclyCRrVFpfuL/GNNRqA9WPnXSaklaip/tEyvJpkk+zAioRYHiydg+pKHvveN9i
         V2rIC5X1Jo04/QFZTZuMMWqnXKsUc0xUFqft/k7G2WAycjLQKC3VKBD2EgW85Ssenzda
         v82EJx78PZruk5Q30P25ybNOUpsM9yrQFJAxNRLrQNbKWslivzm2zvuYvLMgQrZM2G8/
         05IlLPBTYOBMTeV0wG0D38oK/dvdIV80Fyw9TfiJENCNrkUDJRKT6apYC2UP7yA6xzhO
         fH/w==
X-Gm-Message-State: AHYfb5j5d+5LLOyLU+YFHkcHvUPl2kdiHXHxK/KSYJlr1QV5qqv/AyV9
        n+sZuvQQ8Zi7lnAboU8PpUk5c1ydCg==
X-Received: by 10.80.137.61 with SMTP id e58mr22693714ede.67.1502651046504;
 Sun, 13 Aug 2017 12:04:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.134.38 with HTTP; Sun, 13 Aug 2017 12:03:45 -0700 (PDT)
In-Reply-To: <xmqqd1834645.fsf@gitster.mtv.corp.google.com>
References: <20170809122147.g44nwaitzctbadzm@sigill.intra.peff.net>
 <xmqq60dw7j5u.fsf@gitster.mtv.corp.google.com> <CA+P7+xoifkJyH34Q0NJdE_=UzWK1SA+2gwyXrHpF7Sv2PBHATQ@mail.gmail.com>
 <20170810072822.rj6y6zcqhyfz4yi7@sigill.intra.peff.net> <xmqqd1834645.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 13 Aug 2017 12:03:45 -0700
Message-ID: <CA+P7+xoLNzVE4ogw+TEij=DtZM4648Jz3JvxdMBQnUb9t+Ez5A@mail.gmail.com>
Subject: Re: [PATCH 0/5] make interpret-trailers useful for parsing
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2017 at 11:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>>> > The above example made me wonder if we also want a format specifier
>>> > to do the above without piping, but it turns out that we already
>>> > have "log --format=%(trailers)", so we are good ;-)
>>>
>>> I was going to say, I thought we had a way to get trailers for a
>>> commit via the pretty format, since that is what i used in the past.
>>
>> I do like that you could get the trailers for many commits in a single
>> invocation. That doesn't matter for my current use-case, but obviously
>> piping through O(n) interpret-trailers invocations is a bad idea.
>> But there are a few difficulties with using %(trailers) for this,...
>
> I think it is clear to you, but it may not be clear to others, that
> I did not mean to say "because 'log --format' already knows about
> it, this change to interpret-trailers is unnecessary".
>
>> For (1) I think many callers would prefer to see the original
>> formatting. Maybe we'd need a %(trailers:normalize) or something.
>
> Thanks; that is exactly the line of thought I had in the back of my
> head without even realizing when I brought up %(trailers) format
> element.

I'll add that I also think this patch series is good, it's useful to
have a separate command.

Thanks,
Jake

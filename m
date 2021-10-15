Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248FDC433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 03:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE97E60F4A
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 03:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbhJODYu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 23:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbhJODYu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 23:24:50 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43352C061570
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 20:22:44 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id g184so7345440pgc.6
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 20:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=t6KMNOwSt/4ohiifiJGHh0dTqd2rWeTy/Gi7EykZyS4=;
        b=BdVzk31oZIhkuMJib8NA/yu35NIFlHZvRCtJYnS6E1WJ5+9+JU2r4YF0IBBPXH3yfU
         4yZV7TAJLI21QFJ1qaAzFSinHbjY7Nc4XvyD6xn0D6pkhVAoshCuf3tZZgaoXnQ3sPq6
         B4sncVHpGRGcpzE4APvYaTknxzhF9d5rXsxGhyrVhWFfBK0WXy1ZDnMIHrBO8kS6d0LQ
         7/+9K4Rx8FAV4QqPRVEhhdiT7Jk8FXGqxuwNTiEujbprR9jUW88Ai8NGGCZvzeplyIh3
         Iumv2hZE2UTNmfseFsIcj3d1fWgd4A7vQ71w7W2oeUnu4wM+b2ioUItXvxB4FrksCndV
         WCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t6KMNOwSt/4ohiifiJGHh0dTqd2rWeTy/Gi7EykZyS4=;
        b=U2qXNzRHrUBBmmnSicYth/3v7earuH1zkHVWdG+ludxBOfwYhFjLDw9mXk23jpawh3
         gwHKt72XfoUv58qmdTf4wDTfAR99JbrhG/xPOt1Wstam6GSE4Pjyt2S+houd7BkHphl4
         Eq8TQLBZ7S7ZnvXIEumi0ul/55w0/4xlGsiyXG/M3h/Hs/RX8INuPzXZg4IC/0rI5sE7
         OLHMdX+Ob0MHGPvOb+6hhVQ3+Q9p+YsN5DoeJlbtwJ44sZp19/nAsPwpwqW6HoAHjpdi
         wB7l/OEsQxGy24hYmVitEPBdwQrnHOgPeqywpmCbN5NrBum7/+Qh/iOqVKOTeuPyizBr
         vFOA==
X-Gm-Message-State: AOAM531fM91GtPhS/M3sDzAxfMmG5Zu3RrU2se/a/nFvt3LrCUNTd/4H
        zSXICMkWivPsW0O3gQQqgMM=
X-Google-Smtp-Source: ABdhPJy2jTVNInd+1BGCHLoN0YODIpnksIPh01So/XYJML5ciQ9Ff+RXELGf6FPi7IvGmyqFNSQhaQ==
X-Received: by 2002:a63:af4b:: with SMTP id s11mr7153783pgo.185.1634268163789;
        Thu, 14 Oct 2021 20:22:43 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-85.three.co.id. [180.214.233.85])
        by smtp.gmail.com with ESMTPSA id h4sm3601657pgn.6.2021.10.14.20.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 20:22:43 -0700 (PDT)
Message-ID: <8e99fbef-32d0-9f19-4e57-1f28108c70cb@gmail.com>
Date:   Fri, 15 Oct 2021 10:22:39 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH RESEND] archive: rewrite description for compression level
 option
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, vagabon.xyz@gmail.com,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20211014120233.7834-1-bagasdotme@gmail.com>
 <xmqqh7djczxr.fsf@gitster.g>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <xmqqh7djczxr.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/10/21 23.51, Junio C Hamano wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> 
>> Currently, the description of compression level option (`-<number>` or
>> `-#`) only specifies two level (`-0` and `-9`), giving the impression
>> that only both levels are accepted, although other level number can be
>> specified. Rewrite the description.
> 
> While I find that the updated description is more detailed [*], I am
> not sure if the change to the heading is an improvement for readers,
> as I do not think of a case where users would choose to use anything
> other than to use (1) no compression level option, (2) '-0' for
> speed, or (3) '-9' for size, and explicitly singling out `-0` and
> `-9` like the current text does would help those who wonder what the
> option, used in a script written by somebody else that they are
> given to maintain, mean, better than the updated text that does not
> even allow /-9 in their pager to look for the description, if you
> only had `-<number>` or `-#`.
> 
> Also, unless we take `-47`, I do not think it is a good idea to
> spell it as `-<number>`.  Perhaps `-<digit>` is OK, but it shares
> exactly the same issue as `-<number>` I mentioned above.

Maybe we can say `-0 ... -9` to indicate the syntax, while both the 
endpoints are common but special case.

Also, we don't mention default compression level (`-6`?).

-- 
An old man doll... just what I always wanted! - Clara

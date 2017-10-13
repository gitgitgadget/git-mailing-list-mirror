Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E7A91FF32
	for <e@80x24.org>; Fri, 13 Oct 2017 10:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758024AbdJMKoz (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 06:44:55 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:54844 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757349AbdJMKoy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 06:44:54 -0400
Received: by mail-it0-f46.google.com with SMTP id 72so10084034itk.3
        for <git@vger.kernel.org>; Fri, 13 Oct 2017 03:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bMb9sUseo4TdJbKsIh9ujtGMTbvWOFB1oz4RUokWMoU=;
        b=J/ahQvm30F+G/D08Dqb57E6FX2MeBJVQtf/buqAS2TYLf5oOgH2RmqqPbL/X+ZVczH
         iX8dRe6v7LvfDzGOwodwglSd5esiN8Cj32O6d4nbsKVHaqH4UR1ItWPef7Hel1uPxSGA
         Iq2rBNkqbg995BN/JEEco7EGeqcCzxh0Bwv963Uk+DOZD839pWlhT5oGWUJY82NR/FT2
         yIvMTUfwazfHgw4LvkBchw7Rk/GOJF9lYxuJuw7a2yt0AllPnEgxs84cDtC/rUcVDmbO
         ySNt7fg+SqTmJ7AUKgpMuePJsEzl0wZrpoNA5lyf2JzUzQeNwjd1IG3UEzevn+NaF3iy
         XLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bMb9sUseo4TdJbKsIh9ujtGMTbvWOFB1oz4RUokWMoU=;
        b=XZd/pcVb03AGucDY/tnjsH+NDTTg3TXS40TtrZkYbIdQjEogQUyqwNNwlNJ8JhOV1M
         28EkZNlxVJaNjDa2L/jfdmLs6REzfepLdLTon+mrhgjuEoSRi6KRLFV49hF+qt7IW3/e
         dRX+2iVya/DpsI3NuCFDyiwvtg/idNDmjBCqwLxREjIU22H9Mrxdb34Bk2avFLUN13Cr
         frHXv9ljSZ+83/ZN+6el6ZSN4JtYp60j/QgFDBVfxWs7ECLagHO43XylA0weAQ5x/MQg
         jH2TfCNxf3BmEhbSgP0sSQwXmyfJZqd+x+nL0BoEz48oZ5XW1YeLnGHvWFwdOKrP7kjr
         ojEg==
X-Gm-Message-State: AMCzsaUGDE8oFVvnKYvmixW0iwqIgdy2erJSJ0x7h0cdxzQGywoXoNL6
        pJfHGWk0DNxlRAi4jMhTwsJqq2YEnZbXvKqa4jo=
X-Google-Smtp-Source: ABhQp+S3YKEPFxDlMIX4pSbGXCF8A5lGpnCJcXOIXmBiSI6vYYwNC1kGFdyAyTQ9LhdPC0aDe6pbtaRHvNo1DBAa4jE=
X-Received: by 10.36.11.197 with SMTP id 188mr1539708itd.42.1507891493496;
 Fri, 13 Oct 2017 03:44:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.7.10 with HTTP; Fri, 13 Oct 2017 03:44:52 -0700 (PDT)
In-Reply-To: <20171013103722.rvr7536mu2hoo4wb@glandium.org>
References: <515b1400-4053-70b0-18e2-1f61ebc3b2d7@yandex.ru>
 <20171013100603.5eed26sjjigph2il@glandium.org> <CAP8UFD1KuBdUCo=x_q4__s1kW15CWMH1jJkKzXqmf3=T3jcrng@mail.gmail.com>
 <20171013103722.rvr7536mu2hoo4wb@glandium.org>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 13 Oct 2017 12:44:52 +0200
Message-ID: <CAP8UFD3vniWZQ9Wb1oMo-bbj8n7CTjTHUNhBRwg6jN9x0+ApAQ@mail.gmail.com>
Subject: Re: git-clone causes out of memory
To:     Mike Hommey <mh@glandium.org>
Cc:     Constantine <hi-angel@yandex.ru>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 13, 2017 at 12:37 PM, Mike Hommey <mh@glandium.org> wrote:
> On Fri, Oct 13, 2017 at 12:26:46PM +0200, Christian Couder wrote:
>>
>> After cloning it with -n, there is the following "funny" situation:
>>
>> $ time git rev-list HEAD
>> 7af99c9e7d4768fa681f4fe4ff61259794cf719b
>> 18ed56cbc5012117e24a603e7c072cf65d36d469
>> 45546f17e5801791d4bc5968b91253a2f4b0db72
>>
>> real    0m0.004s
>> user    0m0.000s
>> sys     0m0.004s
>> $ time git rev-list HEAD -- d0/d0/d0/d0/d0/d0/d0/d0/d0/d0/f0
>>
>> real    0m0.004s
>> user    0m0.000s
>> sys     0m0.000s
>> $ time git rev-list HEAD -- d0/d0/d0/d0/d0/d0/d0/d0/d0/d0
>>
>> real    0m0.004s
>> user    0m0.000s
>> sys     0m0.000s
>> $ time git rev-list HEAD -- d0/d0/d0/d0/d0/d0/d0/d0/
>> 45546f17e5801791d4bc5968b91253a2f4b0db72
>>
>> real    0m0.005s
>> user    0m0.008s
>> sys     0m0.000s
>> $ time git rev-list HEAD -- d0/d0/d0/d0/d0/
>> 45546f17e5801791d4bc5968b91253a2f4b0db72
>>
>> real    0m0.203s
>> user    0m0.112s
>> sys     0m0.088s
>> $ time git rev-list HEAD -- d0/d0/d0/d0/
>> 45546f17e5801791d4bc5968b91253a2f4b0db72
>>
>> real    0m1.305s
>> user    0m0.720s
>> sys     0m0.580s
>> $ time git rev-list HEAD -- d0/d0/d0/
>> 45546f17e5801791d4bc5968b91253a2f4b0db72
>>
>> real    0m12.135s
>> user    0m6.700s
>> sys     0m5.412s
>>
>> So `git rev-list` becomes exponentially more expensive when you run it
>> on a shorter directory path, though it is fast if you run it without a
>> path.
>
> That's because there are 10^7 files under d0/d0/d0, 10^6 under
> d0/d0/d0/d0/, 10^5 under d0/d0/d0/d0/d0/ etc.
>
> So really, this is all about things being slower when there's a crazy
> number of files. Picture me surprised.
>
> What makes it kind of special is that the repository contains a lot of
> paths/files, but very few objects, because it's duplicating everything.
>
> All the 10^10 blobs have the same content, all the 10^9 trees that point
> to them have the same content, all the 10^8 trees that point to those
> trees have the same content, etc.
>
> If git wasn't effectively deduplicating identical content, the repository
> would be multiple gigabytes large.

Yeah, but perhaps Git could be smarter when rev-listing too and avoid
processing files or directories it has already seen?

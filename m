Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B17EF20437
	for <e@80x24.org>; Fri, 13 Oct 2017 13:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753436AbdJMNzT (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 09:55:19 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:47159 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753231AbdJMNzS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 09:55:18 -0400
Received: by mail-qt0-f180.google.com with SMTP id z50so19689077qtj.4
        for <git@vger.kernel.org>; Fri, 13 Oct 2017 06:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=9zvmLuQfX3adtTLeMIZ1+6kimMrKVn/87JzH77UijP4=;
        b=TXjXr595B2BBo2ac49a9iG9JCTm3bYJVbI0bp5bApdCHIr2pHkX/fvQA2szRY9vPcw
         lW+l/8QLyZqwH6C3LQoUJYRoQRWpeg1mv9N+ueHxUkSxawoFRcfTKY5U2uAeZjZXBAwM
         Nv5NuSsjMwj6dg8GKd9yqA2f6GxoPCwc5cfyndRlPOpl9BaZIW+bduNbAdlE37sZ6CTk
         1x2gKpvI9ACdca1K2EayH7oQ4LtDWmqr4Hfp4TzBzZoW4BijuRh/AJwTQng+Z9Jj1Y2n
         JCC92/lSuSRtupqA4fMy7a5DeGQbzHM6SudaZ7a1XSmN0OhRMLHfxw/+v1sDOxSI1NHq
         VSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9zvmLuQfX3adtTLeMIZ1+6kimMrKVn/87JzH77UijP4=;
        b=jujozqVZ0XEXoDhPKLndocY5XzLAARQOMDu87aeT1yx6E92/8QGCWYSjY6To/cD8kk
         2+elAy3YmS7DywTOjaaKBPN4p7UOoEnJr/aGI2tZwpBm1QEkoNPYhd1xD/nTkHvuTvke
         UJAiItXUBM4zObnlcM8rssMdDu4Z4nnHJRq2qlRs4ya8LmaAPCsUkoJtOLfRoZjYDBSD
         ztpbRh48Xz056H+Hm39qW8G8McMCkey9BdxAn58gT8KikVhEM/114kywOwChoBerCkkU
         K2fuWXhQ3m0DVr7r/GPU1SNZ+ljfzK6wNP2wO1ta6hUHqCIp5AmKg5cJ46ATKa6xinze
         iaAQ==
X-Gm-Message-State: AMCzsaUxvDsWyRFOJqnKURGfwetOAYpqctUEnjXNMpEhZJ/WKWdaWKj/
        BobptRKkkKFIj4UlH9vSGdXuyMl8
X-Google-Smtp-Source: ABhQp+TkARNo/1UCdva7F3MIenvjHhqs5ocS/F3esPgOWRarUq4clerI7HHuivo5Dn4UsF3MC9yL7g==
X-Received: by 10.237.53.212 with SMTP id d20mr2161443qte.10.1507902917217;
        Fri, 13 Oct 2017 06:55:17 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010::7cc])
        by smtp.gmail.com with ESMTPSA id k2sm591140qth.83.2017.10.13.06.55.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Oct 2017 06:55:16 -0700 (PDT)
Subject: Re: git-clone causes out of memory
To:     Jeff King <peff@peff.net>
Cc:     Constantine <hi-angel@yandex.ru>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Mike Hommey <mh@glandium.org>, git <git@vger.kernel.org>
References: <515b1400-4053-70b0-18e2-1f61ebc3b2d7@yandex.ru>
 <20171013100603.5eed26sjjigph2il@glandium.org>
 <CAP8UFD1KuBdUCo=x_q4__s1kW15CWMH1jJkKzXqmf3=T3jcrng@mail.gmail.com>
 <20171013103722.rvr7536mu2hoo4wb@glandium.org>
 <CAP8UFD3vniWZQ9Wb1oMo-bbj8n7CTjTHUNhBRwg6jN9x0+ApAQ@mail.gmail.com>
 <xmqqr2u7uuc8.fsf@gitster.mtv.corp.google.com>
 <2f9b8856-dacc-768d-32c2-985f5f145ba7@yandex.ru>
 <20171013124456.qsbaol7txdgdb6wq@sigill.intra.peff.net>
 <f35d03b5-a525-87b3-a426-bd892edf0c36@gmail.com>
 <a4ebf552-35d4-d55f-6f08-731afa2cd2de@gmail.com>
 <20171013135058.q7vhufdtin42ddic@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <53f98311-3c5f-9863-5f6c-bc4f25fad317@gmail.com>
Date:   Fri, 13 Oct 2017 09:55:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171013135058.q7vhufdtin42ddic@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/13/2017 9:50 AM, Jeff King wrote:
> On Fri, Oct 13, 2017 at 09:39:14AM -0400, Derrick Stolee wrote:
>
>> Since I don't understand enough about the consumers to diff_tree_oid() (and
>> the fact that the recursive behavior may be wanted in some cases), I think
>> we can fix this in builtin/rev-list.c with this simple diff:
>>
>> ---
>>
>> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
>> index ded1577424..b2e8e02cc8 100644
>> --- a/builtin/rev-list.c
>> +++ b/builtin/rev-list.c
>> @@ -285,6 +285,9 @@ int cmd_rev_list(int argc, const char **argv, const char
>> *prefix)
>>
>>          git_config(git_default_config, NULL);
>>          init_revisions(&revs, prefix);
>> +
>> +       revs.pruning.flags = revs.pruning.flags & ~DIFF_OPT_RECURSIVE;
>> +

(Note: I'm running tests now and see that this breaks behavior. 
Definitely not the solution we want.)

> Hmm, this feels wrong, because we _do_ want to recurse down and follow
> the pathspec to see if there are real changes.
>
> We should be comparing an empty tree and d0/d0/d0/d0 (or however deep
> your pathspec goes). We should be able to see immediately that the entry
> is not present between the two and not bother descending. After all,
> we've set the QUICK flag in init_revisions(). So the real question is
> why QUICK is not kicking in.
>
> -Peff

I'm struggling to understand your meaning. We want to walk from root to 
d0/d0/d0/d0, but there is no reason to walk beyond that tree. But maybe 
that's what the QUICK flag is supposed to do.

Thanks,
-Stolee

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32FED1F406
	for <e@80x24.org>; Mon, 14 May 2018 12:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753275AbeENMuH (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 08:50:07 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:37970 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752179AbeENMuF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 08:50:05 -0400
Received: by mail-qk0-f178.google.com with SMTP id b39-v6so9821685qkb.5
        for <git@vger.kernel.org>; Mon, 14 May 2018 05:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=61Yf30R8UPU0K2BaX7e2mJC7OUqdgi5ObPxIfrwXp8A=;
        b=uQnzP4EV8K3P7gXInzcYlwqwMXYPJASgmHW72DAYaZ17v/Nun+FuAzc7lsn5U2GzUy
         8gzAT1tHCAX4rqDqWkPyt9xuGNuRiASzpdCs8LAIBUlTZGRwEbLwgXpbSBby8FkSzR6R
         dgFeG/wC/W/4ykMSWxdJt0pH5cmUYJPF2yYbuvekblqzxW8UzB9pYwVgZJaN2qqlAxCm
         LQ5Zt35ycshAfrnGtY5b/J82F+PLWXMY1MgYO5oB8l3qNy4PjYA3MHaB3+UCeuE4i8+z
         YGGYWn/QURfO09roisjfbJb9uwuPN78k8ZuHKheunARuCiWsvTg540Q/I2Jv7LpCHPaL
         mUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=61Yf30R8UPU0K2BaX7e2mJC7OUqdgi5ObPxIfrwXp8A=;
        b=SoQK0y46g9Bdqp0VCavYgIAbur0Ph8BsK/JbqhwayMzSBvD5tSw+eMYmIkP5OYJK+q
         1UBc6dlEfW9v1JJXpmrmRF3aGhH1hpm6v+BCphLx6qyp2l4mC41NE7OH3HY9R5J2gtmU
         EC48q4QWjeUJZSRHNUDq82H32yOXE7+pBJqKlSJ1L/byHNTDRvrVtuDqJjchzMTjR92w
         Cc1DtdT2KSjdF+kr95iIDGYp3ETq1PXrN+Tb1yZ9UtHAqtMnwR6AvND/Ir2k9nAJX5Oe
         B9uE25ZjydB8VfJXa3EPIRxnVce1zGUgWsQhzbpEkBb29Ki/4AzRh+o1lObRIQuywMAI
         Ssyg==
X-Gm-Message-State: ALKqPwc4OYYR8sIHgLaDhT7bLWxCxCNsl/G/kHJQcHY7kkULd6tbIP6m
        B6EuFovOJ4OjS/yc40TMZDXh1X2U
X-Google-Smtp-Source: AB8JxZpC0//8VgFfr+FEov4HU/1JLEx2AcSKalCiFCWdFqGOh82Q/XwMvfg64iUxy1/r8sc15kZL5w==
X-Received: by 2002:a37:c081:: with SMTP id v1-v6mr7707176qkv.176.1526302205284;
        Mon, 14 May 2018 05:50:05 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id l1-v6sm7421640qki.32.2018.05.14.05.50.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 May 2018 05:50:04 -0700 (PDT)
Subject: Re: [PATCH 0/4] a few mark_parents_uninteresting cleanups
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20180511180029.GA11290@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <db32fff6-b6f0-a420-bf3e-30b17154bf70@gmail.com>
Date:   Mon, 14 May 2018 08:50:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180511180029.GA11290@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/11/2018 2:00 PM, Jeff King wrote:
> This is a follow-up to the discussion from February:
>
>    https://public-inbox.org/git/1519522496-73090-1-git-send-email-dstolee@microsoft.com/
>
> There I theorized that some of these extra has_object_file() checks were
> unnecessary. After poking around a bit, I've convinced myself that this
> is the case, so here are some patches.
>
> After Stolee's fix in ebbed3ba04 (revision.c: reduce object database
> queries, 2018-02-24), I doubt this will provide any noticeable speedup.
> IMHO the value is just in simplifying the logic.
>
> The first two patches are the actual has_object_file simplifications.
> The second two are an attempt to fix some head-scratching I had while
> reading mark_parents_uninteresting(). I hope the result is easier to
> follow, but I may have just shuffled one confusion for another. :)
>
>    [1/4]: mark_tree_contents_uninteresting(): drop missing object check
>    [2/4]: mark_parents_uninteresting(): drop missing object check
>    [3/4]: mark_parents_uninteresting(): replace list with stack
>    [4/4]: mark_parents_uninteresting(): avoid most allocation
>
>   revision.c | 90 ++++++++++++++++++++++++++++++------------------------
>   1 file changed, 50 insertions(+), 40 deletions(-)
>
> -Peff

This series looks good to me. I found Patch 3 hard to read in the diff, 
so I just looked at the final result and the new arrangement is very 
clear about how it should behave.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

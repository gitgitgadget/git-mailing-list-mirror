Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D5EA1F453
	for <e@80x24.org>; Wed, 24 Oct 2018 13:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbeJXVrX (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 17:47:23 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:37065 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbeJXVrX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 17:47:23 -0400
Received: by mail-ua1-f68.google.com with SMTP id y5so1842343uap.4
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 06:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=LBZt+MbD9SZ/Nza9w8IfeknirSBCXoiiyC3d8pzZsdc=;
        b=PRBGcHkfOVvqnY2G5T0QBld8cCA/ADKrkVxcEiWBSRzQunW2gdFPp1azEvwWxg/pHr
         lyz1KdCnq7K6F8gBQbqPuxh0Q1gm1r5C96YrG3IjILeZgbsZ+Qt1KOfT1rUORPU4jkah
         Q9NO2RXb1cPl58dGoAw9PzLjvGMS1PxHBQwqMVavVJpq7LbpMDgQWMBKdOGGk62u0ICK
         wcm6k6IR3+pZHor3Zys+7R/ETZFu+TyaMyAby+xEGdq8zSyM89/J2cATJiLioL6EEFVY
         WftQtNngONYoyq7Mwhax5mm6TM4S17pmTHwjDLazP8YumIy+P2pEIkGt3wLBNq+i0EgY
         vfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=LBZt+MbD9SZ/Nza9w8IfeknirSBCXoiiyC3d8pzZsdc=;
        b=AuPGogtsGMj7NjmdU4FL5z/K4ktXOqwI1vSO8tjuh1PfpNdBcqhCs5CBv+JtcmQkZi
         szO3ixV70/hSedqHL1bGcYZgEPkqOhx1LEjoq+msXINsI1qIYuqfa4/XACMka3vlpfIE
         DzcgWKPJH7/2S0pbb3W9SEZ1ldHLODkkXfwij8lGqdp+X6n3GAvwVanVj3YkdV7j7n+Y
         4XfiGcHL8iaUrPU6aiX1/aDNlcpEvy332WkSx4Vkhq7Npuv0Y9av39ksfIUcuPjzkmgL
         t/7oTeWKy6uCgQZSa7TMxG1hit4MKilE7swgyCcR+U2j7ThvfFtgUhGVOqBO+JUsglPv
         xYFg==
X-Gm-Message-State: AGRZ1gLtUgDWnEQSHtaTQlTE1pa+ZoERtFF/kHZBTf94BG07M34qp66l
        d6/lwyLgFHTXDaOaFLyF2dY=
X-Google-Smtp-Source: AJdET5fpZnr2Eh8u26blgnid2GT6MJ9zfv5vzU1S5Zk3y1cbqxpWczVbGut/jV1QHitcFtbZC4dypA==
X-Received: by 2002:a9f:2c81:: with SMTP id w1mr1145681uaj.116.1540387156036;
        Wed, 24 Oct 2018 06:19:16 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:3c92:d38f:3214:6b65? ([2001:4898:8010:0:25c8:d38f:3214:6b65])
        by smtp.gmail.com with ESMTPSA id p67sm844610vsd.27.2018.10.24.06.19.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 06:19:15 -0700 (PDT)
Subject: Re: [PATCH] commit-reach: fix sorting commits by generation
To:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
References: <20181022211037.22719-1-t.gummerer@gmail.com>
 <13bdda53-b751-182b-4aa8-d9a5c03f422d@web.de>
 <20181023203237.GF4883@hank.intra.tgummerer.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e2e1bfd8-bb43-0567-0eb7-770ae16da7e2@gmail.com>
Date:   Wed, 24 Oct 2018 09:19:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:63.0) Gecko/20100101
 Thunderbird/63.0
MIME-Version: 1.0
In-Reply-To: <20181023203237.GF4883@hank.intra.tgummerer.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/23/2018 4:32 PM, Thomas Gummerer wrote:
> On 10/22, René Scharfe wrote:
>> Am 22.10.2018 um 23:10 schrieb Thomas Gummerer:
>>
>> Anyway, your implied question was discussed back then.  Derrick wrote:
>>
>>     The reason to sort is to hopefully minimize the amount we walk by
>>     exploring the "lower" commits first. This is a performance-only thing,
>>     not a correctness issue (which is why the bug exists). Even then, it is
>>     just a heuristic.
> Thanks for pointing that out!
>
>> Does b6723e4671 in pu (commit-reach: fix first-parent heuristic) change
>> that picture?  Did a quick test and found no performance difference with
>> and without the fix on top, i.e. proper sorting didn't seem to matter.
> I just gave 'test-tool reach can_all_from_reach' a try and got the
> same results, with or without the fix the times are very similar.  I
> haven't had time to follow the commit-graph series though, so I'm not
> sure I used it correctly.

Thanks for your attention here. I've been thinking a lot about this 
heuristic and have concluded the following two things are true:

(1) When we return 1, the order that we explore the 'from' commits does 
not change the explored set of commits.

(2) When we return 0, the order that we explore the 'to' commits will 
change the explored set, but it is difficult to say that the heuristic 
helps more than it hurts.

Item (1) is contrary to what I had thought when I first created the 
heuristic.

The details are tricky, but essentially each DFS starting at a 'from' 
commit may be short-circuited due to a prior walk, but swapping the 
order of those two 'from' commits would lead to the same set of commits 
to be explored (with the short-circuit happening in the other commit). 
The only change is that we can terminate early if we fully explore a 
'from' commit and do not find a commit marked with 'with_flag'. In this 
sense, it would be best to explore the commits that are "closest" to the 
generation number cutoff first, as we can maybe find a negative answer 
earlier in the search.

In this sense, we could remove the sort entirely and probably not have 
much performance hit. But since the set of 'from' commits is probably 
much smaller than the set of commits to explore, the sort is likely 
inexpensive.

In conclusion: I cannot say that this sort is super-important. As for 
the potential benefits in (2), I'll leave that to people who run git as 
a server who may have telemetry around fetch negotiation. How often do 
we actually say we need more rounds of negotiation? What kinds of data 
shapes matter there?

Thanks,
-Stolee

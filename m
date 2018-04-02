Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EE111F404
	for <e@80x24.org>; Mon,  2 Apr 2018 15:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751315AbeDBPCN (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 11:02:13 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33372 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbeDBPCM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 11:02:12 -0400
Received: by mail-qt0-f194.google.com with SMTP id d50so8390820qtc.0
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 08:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/AH4G7MV/RO8RRRe4Z1HBGQOcMBSclXNsguwLO64Has=;
        b=jeq7h1mGfPhQyg/tQosL5L7SbjjYctjd+pPfVKPIVAnmoNTMt2Cg4QMWLePqUF7O0N
         85faBPRmpwofeLq45nXpfB7yZXspQUGWwuIPfSgA3BZoxYmLbueXMyT4NhtoYg+JfsHl
         3BzEFX3xcXq12EFq37DluMApeDs4rymMkgya10JYkxaRQyQrZtzuurJzYmd8pr5Wy22d
         ULTEiW24/u9lkbzWBz+jhE6CFotflb8iQUKTohofz0KoqMIcMpL8ZeHQHs3129WCFmUr
         mCXmA1zUFXtl9gYcpKUcw+lyNYroIfsgHsua2bT+DKJFQbQMR7WqUqvZGynAGkFksCYg
         iMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/AH4G7MV/RO8RRRe4Z1HBGQOcMBSclXNsguwLO64Has=;
        b=sJ5e0G3xNGx0bi0A0+VwhNDceBVXgpUFgf19jAHQq9x/7qSFYBUBdQBgBMnkmCs8pX
         2R3Bbcm38AbtuvIgeWj9bCEf5oLT79TRTCjz8Mc1pu4gxwNzIaRHBDYgYTtBap3HAZ2u
         sBeEnjHH59VjefWqHPTRWUg2aztnhkopdbOrb/qDUz8+Mpc52HSWPhjozATuFc83xT54
         SXoGZuPTGB+L8OFW30pPMz4FT94ZR7Z+JXVakfRxyEQCm4vdgtqFmp5qiJKi9XgU12I+
         YneHh5ZYe/iOGl/AUJ9IXKRFEj6bWqzfBsgozZvpY/2hvC0gMAWp0uwDcCbaJDXJi8c1
         lVoA==
X-Gm-Message-State: ALQs6tAiMyJCRjZhoqADkPyREW49hvxbRZ/5zULwdm+JdkL7IIxyEkOc
        iHVk82GMLXSDDs3fdC08KW0=
X-Google-Smtp-Source: AIpwx48jx6qFL6qUc54hMhCHA3sMg60P1fnr2EGSABm3phdtOAvB/YMEp1PX3DRZ3/fFIbNZXYzJ2A==
X-Received: by 10.237.55.42 with SMTP id i39mr14788167qtb.15.1522681331399;
        Mon, 02 Apr 2018 08:02:11 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id b10sm422669qtg.78.2018.04.02.08.02.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Apr 2018 08:02:10 -0700 (PDT)
Subject: Re: [PATCH v4 00/13] Serialized Git Commit Graph
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, peff@peff.net,
        jonathantanmy@google.com, szeder.dev@gmail.com, sbeller@google.com,
        gitster@pobox.com, Derrick Stolee <dstolee@microsoft.com>
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
 <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
 <867eptkeeq.fsf@gmail.com> <f5d8934e-afc2-39d4-b7d5-e5ba5e5021a1@gmail.com>
 <861sfxekeo.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d3060103-7fab-3b6c-e968-cb49f3f23acb@gmail.com>
Date:   Mon, 2 Apr 2018 11:02:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <861sfxekeo.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/2/2018 10:46 AM, Jakub Narebski wrote:
> Derrick Stolee <stolee@gmail.com> writes:
[...]
>> At one point, I was investigating these reachability indexes (I read
>> "SCARAB: Scaling Reachability Computation on Large Graphs" by Jihn,
>> Ruan, Dey, and Xu [2]) but find the question that these indexes target
>> to be lacking for most of the Git uses. That is, they ask the boolean
>> question "Can X reach Y?". More often, Git needs to answer "What is
>> the set of commits reachable from X but not from Y" or "Topologically
>> sort commits reachable from X" or "How many commits are in each part
>> of the symmetric difference between reachable from X or reachable from
>> Y?"
> In the "Reachability Queries in Very Large Graphs..." by Veloso, Cerf,
> Meira and Zaki FELINE-index work, authors mention SCARAB as something
> that can be used in addition to FELINE-index, as a complementary data
> (FELINE-SCARAB in the work, section 4.4).
>
> I see the FELINE-index as a stronger form of generation numbers (called
> also level of the vertex / node), in that it allows to negative-cut even
> more, pruning paths that are known to be unreachable (or marking nodes
> known to be unreachable in the "calculate difference" scenario).
>
> Also, FELINE-index uses two integer numbers (coordinates in 2d space);
> one of those indices can be the topological numbering (topological
> sorting order) of nodes in the commit graph.  That would help to answer
> even more Git questions.

This two-dimensional generation number is helpful for non-reachability 
queries, but is something that needs the "full" commit graph in order to 
define the value for a single commit (hence the O(N lg N) performance 
mentioned below). Generation numbers are effective while being easy to 
compute and immutable.

I wonder if FELINE was compared directly to a one-dimensional index (I 
apologize that I have not read the paper in detail, so I don't 
understand the indexes they compare against). It also appears the graphs 
they use for their tests are not commit graphs, which have a different 
shape than many of the digraphs studies by that work.

This is all to say: I would love to see an interesting study in this 
direction, specifically comparing this series' definition of generation 
numbers to the 2-dimensional system in FELINE, and on a large sample of 
commit graphs available in open-source data sets (Linux kernel, Git, 
etc.) and possibly on interesting closed-source data sets.

>
>> The case for "Can X reach Y?" is mostly for commands like 'git branch
>> --contains', when 'git fetch' checks for forced-updates of branches,
>> or when the server decides enough negotiation has occurred during a
>> 'git fetch'. While these may be worth investigating, they also benefit
>> greatly from the accelerated graph walk introduced in the current
>> format.
>>
>> I would be happy to review any effort to extend the commit-graph
>> format to include such indexes, as long as the performance benefits
>> outweigh the complexity to create them.
>>
>> [2] http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.719.8396&rep=rep1&type=pdf
> The complexity of calculating FELINE index is O(|V| log(|V|) + |E|), the
> storage complexity is 2*|V|.
>

This would be very easy to add as an optional chunk, since it can use 
one row per commit.

Thanks,
-Stolee

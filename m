Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D06901F453
	for <e@80x24.org>; Mon, 29 Oct 2018 20:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbeJ3E5N (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 00:57:13 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44658 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbeJ3E5N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 00:57:13 -0400
Received: by mail-qk1-f196.google.com with SMTP id n12so5776388qkh.11
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 13:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=myl6o/UYAtoIrnq8dbxExz8M5+R9o+/vsQMQY/eaITw=;
        b=bIbaNZ4IFlq2AutWcptq7NS7K7YZTtenDr6Fm6qDBpysLxjGBNOiq4opPp8r4j2pfD
         0YI+gpw0DIUnBKo7ivxgSANlOVFmPTGOtFViu0y5w5K0GapazO0zhYcQG8khyqx41Vms
         99LZdpRj0C/+21dTu70a35w6qIOyFUIY6L/pUg6IxAyZowMZ/e/393bjACFKZsvdJF+C
         SLeO5KmWzfnFXCgU7Fbu4/arSDiQv/VAcOt7pkzbbECbG2eQ4o5mt/fV2aiZ7RhBpix1
         dfHJeStKPQ1aSs+LsFEvfUfemz04gytka135Kd94b+Tgc3Z/uSICi+5WBvel2osebkMD
         V8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=myl6o/UYAtoIrnq8dbxExz8M5+R9o+/vsQMQY/eaITw=;
        b=cwLUKvShr9aLsONP3ZSJgFr5MEj1MylfW/8d120zTERQzo5oO3tXGaVjNJwNcDxM8u
         +HpM+YYD31bG2siV9s7BV0SJilulrF9Xqb0RCeuUiZIKdJZlzIcKKfeIsLO8IjjciWKD
         YBWpqhB7HniZJ25+W63ndvfvs0d4bWurkdAN5a9SP1qpEmjU+lbQcpLvRncC9U23yVOR
         lKDOVTrOtHxQuIKmhljscvIVqyFomkJDMzdJDp/WYVGnVWYYEy6IieQHsDn+7B7ZaDMI
         DqgvCO9JI+KOFgDAOcZfDCK5sMZfXd0g73+BR4snDpnHCOQMW5k6BQD34GUg3KYEyFFr
         p4nA==
X-Gm-Message-State: AGRZ1gKVtnTkAq3XoFhAIKtyKgTT+YfeLpnH5uCPSJhrszxfcqcKwscJ
        1Dl8EbnVXU06Ox3kPMqECOw=
X-Google-Smtp-Source: AJdET5ctZNpHsDiLiuJDnB1tetCr4zbW7F+Svr2hyhbu4lgb3tbaFjCwgiACBs7m9uCnxKgq+u23aw==
X-Received: by 2002:a37:4d89:: with SMTP id a131-v6mr13596142qkb.181.1540843619911;
        Mon, 29 Oct 2018 13:06:59 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:59a3:5b1:9f9a:d149? ([2001:4898:8010:0:42d9:5b1:9f9a:d149])
        by smtp.gmail.com with ESMTPSA id q38-v6sm16290187qtc.9.2018.10.29.13.06.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 13:06:59 -0700 (PDT)
Subject: Re: [RFC] Generation Number v2
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <6367e30a-1b3a-4fe9-611b-d931f51effef@gmail.com>
 <CAGZ79ka-FTqaXdrMixjUp2THJ3L0YvEnkKxs3XFgB3WEEy2-Tg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <78882b71-09b2-cb4a-4285-5aa7b61907fe@gmail.com>
Date:   Mon, 29 Oct 2018 16:06:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79ka-FTqaXdrMixjUp2THJ3L0YvEnkKxs3XFgB3WEEy2-Tg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/29/2018 3:22 PM, Stefan Beller wrote:
>> Based on the performance results alone, we should remove minimum
>> generation numbers, (epoch, date) pairs, and FELINE index from
>> consideration. There are enough examples of these indexes performing
>> poorly.
>>
>> In contrast, maximum generation numbers and corrected commit
>> dates both performed quite well. They are frequently the top
>> two performing indexes, and rarely significantly different.
>>
>> The trade-off here now seems to be: which _property_ is more important,
>> locally-computable or backwards-compatible?
>>
>> * Maximum generation number is backwards-compatible but not
>>     locally-computable or immutable.
> These maximum generation numbers sound like the reverse of
> the generation numbers as they are currently implemented, i.e.
> we count all commits between the commit A and all heads.
> How would this impact creation of a commit?

The indexes listed here would be computed at the same time as a 
commit-graph (and only change on commit-graph writes).

This idea of having something depend on the "global state" isn't ideal 
(in my opinion) but it certainly works for the tests specified below.

> The current generation numbers can be lazily updated or not
> updated at all. In my understanding of the maximum generation
> numbers, a new commit would make these maximum generation
> numbers invalid (i.e. they have to be recomputed).

New commits would change the value you would get by the definition (on 
rewrite of the commit-graph) but don't violate the reachability index 
property (maxgen(A) < maxgen(B) =>
A can't reach B). So that doesn't effect their usefulness.

> Are there ways out by deferring the computation of maximum
> generation numbers while still being able to work with some
> commits that are un-accounted for?

Creating a commit that doesn't exist in the commit-graph file results in 
a commit with generation number INFINITY. The new commits can't be 
reached by commits with finite generation number.

> When recomputing these numbers, the current generation number
> (V0) has the property that already existing numbers can be re-used
> as-is. We only need to compute the numbers for new commits,
> and then insert this to the appropriate data structures (which is
> a separate problem, one could imagine a split generation
> numbers file like the split index)
>
> For the V2 maximum generation numbers, would we need to
> rewrite the numbers for all commits once we recompute them?
> Assuming that is true, it sounds like the benchmark doesn't
> cover the whole costs associated with V2, which is why the
> exceptional performance can be explained.
You're right, we need to recompute the entire list of maximum generation 
number values. However, you are a bit hung up on "maxgen" being a fixed 
function that is correct at all times. We could compute the "maxgen" for 
the set of commits that are written to the "split" commit-graph while 
leaving the base the same. There is one tricky part here: we need to 
initialize the values starting at "num commits in the combined 
commit-graph" (commits in the base and split portion). The minimum 
possible value in the split portion will be larger than the maximum 
possible value in the base portion. Since the (future) implementation of 
split commit-graphs would have all commit-parent edges pointing down 
into the base and not from the base into the split, this will continue 
to satisfy our reachability index property.

As for the cost: we need to do a topo-order walk and then a quick 
minimum-value check across all parents. This is O(N), and the constant 
is small. This may be a cost worth paying.

> (Note: The table as read in
> https://public-inbox.org/git/6367e30a-1b3a-4fe9-611b-d931f51effef@gmail.com/
> seems line broken, using gmails web interface is not good
> for ASCII art and patches, git-send-email would fare better)

Sorry for that. I copy-pasted into Thunderbird. Hopefully most users can 
redirect to the GitHub-rendered markdown if they have trouble.

>
>> * Corrected commit-date is locally-computable and immutable,
>>     but not backwards-compatible.
> How are these dates not backwards incompatible?
> We don't have to expose these dates to the user, but
> - just like generation numbers - could store them and use them
> but not tell the user about it.
>
> We would need to be really careful to not expose them at all
> as they look like the real dates, so that could make for an
> awkward bug report.

By "backwards-compatible" I mean that we could store them in the 
commit-graph file without breaking existing clients (or by introducing 
extra data).

We could easily add these corrected commit dates as an optional chunk, 
but that adds 8 bytes per commit, and we already use 8 bytes for the 
(generation, date) pairs.

The solution I made in my prototype is to replace the generation number 
with an offset for how much to add to the commit-date to get the 
corrected commit-date. However, an old client would interpret these 
offsets as generations and have incorrect output.

A potential way to get around this is to consider the pair (offset, 
date) and define the offset(C) to be the minimum of min { offset(P), 
date(P) - date(C) }. This would satisfy the requirements for the V0 
reachability index. I'm making a note to implement _this_ version and 
give it a test.

>
> The approach of "corrected commit date" sounds like we could
> have a very lazy approach, i.e. no extra data structures needed
> for many commits (as the corrected date equals the real date)
> and only need to store the corrections for some commits.
> Such an approach however would not make it easy to know
> if we operate on corrected dates, or if we even checked them
> for correctness before.
>
> So if we'd have an additional row in the generation numbers file
> telling the corrected date, then we should be able to be backwards
> compatible?
Yeah, an optional chunk with the corrected date would work, but be wasteful.

Thanks,
-Stolee

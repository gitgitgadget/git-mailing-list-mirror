Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8933520A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 12:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbeLKMpG (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 07:45:06 -0500
Received: from mail-yw1-f54.google.com ([209.85.161.54]:36893 "EHLO
        mail-yw1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbeLKMpG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 07:45:06 -0500
Received: by mail-yw1-f54.google.com with SMTP id h193so5360739ywc.4
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 04:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=n1taopOmKfw7nHf9VenwSyNkNtsjZ/q/7Aw0aBn+7oA=;
        b=R0oZtzulcSE6MnCShnfuG2gRpgueAo+HSQPF2bL/+GX0voExXu+09Cfv0LQE94V0nB
         9yx0VAqp0MBBL+Cxj/MlmKUCWwm3qvE8akhCDlaV6vC5dMmRV+34oebU/GWz+Z434l+g
         hAZ0c8+iHHhl5e69XuRxeCphJsOErGTMi/g9p4g66loqdUq2Ne93Ci59X31jiOSW+j4s
         MiHh0cb/Sea4VlmXWALbCg3RCmVUjU+AF1+1hziEwJiwGqH+vzvmDkEQFYHHawYCORRV
         7RBYKVHYy6Um+OwHBJF8IeXr0OiUxLOMWHc2hGFJ3ECvNkQvt4jbBYtm+JkRRBeyCD8x
         bvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=n1taopOmKfw7nHf9VenwSyNkNtsjZ/q/7Aw0aBn+7oA=;
        b=n2O1iqhK0qJntgp+c47dxeif4WWeWL75aT9DhAX1x9IzOGdnPeM/edxzAg79R6Hb//
         SDbRGLt+8M1KVHIYvk9LDL5xAXjJIBqEZj7kzGZB9Rf8NoLzPA4Ip6ktu+QPrxSjJy5j
         qbDoHZTlcYESHUvNdeyqtl/1PnXaUoZdjrGQ+IfP5VkmlaMS9WA1qg1Eq5M7j4mzBjHk
         FlVT5tuKeS9j/r01rX1MZuA42ZgxOZAHmc0hYTLGjtZypnrJcQvi2+czz5VrqOyAHlB9
         PghLCpxiYh1zJKIaHrKccVBJY1unCaE7SSqxqydCde9+67DkSjDLhHTXNHPTaKce0UF/
         wF4A==
X-Gm-Message-State: AA+aEWahO3r+xNjNj6rHiA0Qa93YhgzXuU90aMwrfzgtcPsfH3lsJqOx
        K2+/FZPZTuMnH1uMKSQ9qhk=
X-Google-Smtp-Source: AFSGD/UG1uN+/3N9Jv9HPAJhWJBclIWpwc/8o6ZUiVK38K1xkF9lk2mb7R76qbIjDnUGZpY1elcJyg==
X-Received: by 2002:a81:3093:: with SMTP id w141mr16450488yww.24.1544532303457;
        Tue, 11 Dec 2018 04:45:03 -0800 (PST)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id z37sm4333781ywj.3.2018.12.11.04.45.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 04:45:03 -0800 (PST)
Subject: Re: [PATCH 4/5] multi-pack-index: prepare 'repack' verb
To:     Stefan Beller <sbeller@google.com>, gitgitgadget@gmail.com
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.92.git.gitgitgadget@gmail.com>
 <72b213959171af3bfe4d849b925920ddbfb3d4b7.1544465177.git.gitgitgadget@gmail.com>
 <CAGZ79kaNJ8=iCunkeeHnMcOwFik9D-V4g9o7SuvLnnM0vvfBnA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <931d481e-8b9f-0f1f-e455-10111ec7b0dc@gmail.com>
Date:   Tue, 11 Dec 2018 07:45:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kaNJ8=iCunkeeHnMcOwFik9D-V4g9o7SuvLnnM0vvfBnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/10/2018 8:54 PM, Stefan Beller wrote:
> On Mon, Dec 10, 2018 at 10:06 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> In an environment where the multi-pack-index is useful, it is due
>> to many pack-files and an inability to repack the object store
>> into a single pack-file. However, it is likely that many of these
>> pack-files are rather small, and could be repacked into a slightly
>> larger pack-file without too much effort. It may also be important
>> to ensure the object store is highly available and the repack
>> operation does not interrupt concurrent git commands.
>>
>> Introduce a 'repack' verb to 'git multi-pack-index' that takes a
>> '--batch-size' option. The verb will inspect the multi-pack-index
>> for referenced pack-files whose size is smaller than the batch
>> size, until collecting a list of pack-files whose sizes sum to
>> larger than the batch size. Then, a new pack-file will be created
>> containing the objects from those pack-files that are referenced
>> by the multi-pack-index. The resulting pack is likely to actually
>> be smaller than the batch size due to compression and the fact
>> that there may be objects in the pack-files that have duplicate
>> copies in other pack-files.
> This highlights an optimization problem: How do we pick the
> batches optimally?
> Ideally we'd pick packs that have an overlap of many
> same objects to dedup them completely, next best would
> be to have objects that are very similar, such that they delta
> very well.
> (Assuming that the sum of the resulting pack sizes is a metric
> we'd want to optimize for eventually)
>
> For now it seems we just take a random cut of "small" packs.
>
>> The current change introduces the command-line arguments, and we
>> add a test that ensures we parse these options properly. Since
>> we specify a small batch size, we will guarantee that future
>> implementations do not change the list of pack-files.
> This is another clever trick that makes the test correct
> despite no implementation yet. :-)
>
>> +repack::
>> +       When given as the verb, collect a batch of pack-files whose
>> +       size are all at most the size given by --batch-size,
> okay.
>
>>   but
>> +       whose sizes sum to larger than --batch-size.
> or less if there are not enough packs.

If there are not enough packs to reach the batch size, then we do nothing.

> Now it would be interesting if we can specify an upper bound
> (e.g. my laptop has 8GB of ram, can I use this incremental
> repacking optimally by telling git to make batches of at most
> 7.5G), the answer seems to follow...

Well, this gets us to the "unsigned long" problem and how it pervades 
the OPT_MAGNITUDE() code and things that use that kind of parameter. 
This means that Windows users can specify a maximum of (1 << 32) - 1. 
This size is intended to be large enough to make a reasonable change in 
the pack organization without rewriting the entire repo (e.g. 1GB). If 
there is another word than "repack" that means "collect objects from a 
subset of pack-files and place them into a new pack-file, doing a small 
amount of redeltification in the process" then I am open to suggestions.

I tried (briefly) to fix this dependence, but it got too large for me to 
handle at the same time as this change. I'll consider revisiting it 
again later.

>>    The batch is
>> +       selected by greedily adding small pack-files starting with
>> +       the oldest pack-files that fit the size. Create a new pack-
>> +       file containing the objects the multi-pack-index indexes
>> +       into thos pack-files, and rewrite the multi-pack-index to
> those
>
>> +       contain that pack-file. A later run of 'git multi-pack-index
>> +       expire' will delete the pack-files that were part of this
>> +       batch.
> ... but the optimization seems to be rather about getting rid
> of the oldest packs first instead of getting as close to the batch
> size. (e.g. another way to look at this is to "find the permutation
> of all packs that (each are smaller than batch size), but in sum
> are the smallest threshold above the batch size).

You are describing the subset-sum problem, with an additional 
optimization component. While there are dynamic programming approaches 
that are usually effective (if the sum is small), this problem is 
NP-complete, and hence could lead to complications.

> I guess that the strategy of picking the oldest is just easiest
> to implement and should be sufficient for now, but memory
> bounds might be interesting to keep in mind, just as the
> optimal packing from above.

It is easy to implement, and fast. Further, we do have a heuristic that 
the pack modified time correlates with the time the objects were 
introduced to the repository and hence may compress well when placed 
together.

Thanks,

-Stolee


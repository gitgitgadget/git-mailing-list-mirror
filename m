Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DBAD1F597
	for <e@80x24.org>; Fri, 20 Jul 2018 16:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388025AbeGTReW (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 13:34:22 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:39826 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387805AbeGTReW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 13:34:22 -0400
Received: by mail-qk0-f193.google.com with SMTP id b5-v6so6559328qkg.6
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 09:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Ug7qeqA05XO9D/WsHwCN3oqjH6AxL37vIBO6OZpZ22Q=;
        b=feW9xMJNE5OlvkLGX26uxHWImyclNWgSNo/VYj3aOdhwCTjtPpPRtROPvgDNjsJ4CI
         C7Yf9DB8SJV2UtoCtSP2BmL864Gfx7Y1OY39/kTwSpkbtC9pyJpmpua60/ucAncNA4Tr
         PJy2xe61saMRPmJAq19TTc2usYkwxKugWT70XolSTyVXQJNEe4hTxjEaMD44Bd84Mdxx
         n+3UXhFh+jwEPsP28Udde6NBxuImzKFreHj6Wcki1h1ALzRSF3z5DqmmI1JYyodWZrwD
         flA0aqbIHL+eago6HrKfmvdr+KD6ZkOmYzgKyoIg5GIrpbXl5NhLoJMAp6vCpGXDgeZG
         B2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Ug7qeqA05XO9D/WsHwCN3oqjH6AxL37vIBO6OZpZ22Q=;
        b=ik168yIdVTez4PQB18uAr/l42aF2GpxPWnEYfYMyfLYKN4FJGeH9sQboTzdHguGjjx
         hubInAy48Ns/rkjxx/fOAItpVGeLKdbb97HUV09tDJZrk0y3j/B4FCD6jUFTpHHRihfe
         AM+bGk0byti2NHROpT2OE7jfxzRMLuKYHp/vC4SI3OIPWBS3VMX7KjKY7tJPMSMSDk2N
         1AJw60eBRMENKCPkMXRFv5ddyanEFdPQhLU8o8jtnnWRvXSGGNJAJSDil4Ol+SsI5tNO
         8Y57DNTxmcIhVLS1bVkZ1484kGSXq4Cy02ldp7hQTt8yoOFcORiqUlXiEcV5rP2Dnwjv
         jbKQ==
X-Gm-Message-State: AOUpUlGHuODsACVu/DpCEevFeGll+mLs1e1dRfCIqIKhQdENDjhB3t6l
        9sJ9jPSo4c7Blo4ne/xG/Og=
X-Google-Smtp-Source: AAOMgpcn6yyxPxoiXnerrzTd54+phjik1kKuR164/5R7+H2qfpAxGJGAEpeEi3UHVmyS6D9fdO5n2g==
X-Received: by 2002:a37:30d5:: with SMTP id w204-v6mr2540108qkw.317.1532105115582;
        Fri, 20 Jul 2018 09:45:15 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id 17-v6sm1973848qtm.18.2018.07.20.09.45.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 09:45:15 -0700 (PDT)
Subject: Re: [PATCH 5/8] commit-graph: not compatible with replace objects
From:   Derrick Stolee <stolee@gmail.com>
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jnareb@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.11.git.gitgitgadget@gmail.com>
 <7f596c1718d35539f02828edbf933c8e660f123b.1531926932.git.gitgitgadget@gmail.com>
 <20180718194657.GC7778@sigill.intra.peff.net>
 <f5d2f06d-1736-57e4-edbd-aa638ae34238@gmail.com>
Message-ID: <a3640919-95cf-cca4-d552-4715a031dd7f@gmail.com>
Date:   Fri, 20 Jul 2018 12:45:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <f5d2f06d-1736-57e4-edbd-aa638ae34238@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/18/2018 3:52 PM, Derrick Stolee wrote:
> On 7/18/2018 3:46 PM, Jeff King wrote:
>> On Wed, Jul 18, 2018 at 08:15:41AM -0700, Derrick Stolee via 
>> GitGitGadget wrote:
>>
>>> From: Derrick Stolee <dstolee@microsoft.com>
>>>
>>> Create new method commit_graph_compatible(r) to check if a given
>>> repository r is compatible with the commit-graph feature. Fill the
>>> method with a check to see if replace-objects exist. Test this
>>> interaction succeeds, including ignoring an existing commit-graph and
>>> failing to write a new commit-graph.
>> I think this approach is sensible. These are optimizations, and it's not
>> a big deal to just punt no cases we can't handle.
>>
>> I do have one complaint about the implementation, though:
>>
>>> +static int commit_graph_compatible(struct repository *r)
>>> +{
>>> +    prepare_replace_object(r);
>>> +    if (hashmap_get_size(&r->objects->replace_map->map))
>>> +        return 0;
>>> +
>>> +    return 1;
>>> +}
>> If I'm reading the code correctly, this will predicate the decision
>> entirely on the presence of refs in refs/replace/. But you may have a
>> situation where those refs exist, but you are not respecting them in
>> this run.
>>
>> For instance, imagine[1] a server that hosts arbitrary repositories, but
>> wants to use commit graphs to speed up server-side operations (e.g.,
>> serving fetches, but also perhaps a web interface doing --contains,
>> etc). If it runs all of the server-side commands with
>> GIT_NO_REPLACE_OBJECTS=1, then there should be no problem. But if a user
>> pushes anything to refs/replace (because they _do_ use replace refs
>> locally, and want to share them with other clients), that would disable
>> graphs on the server.
>>
>> So I think this should at least be loosened to:
>>
>>    if (check_replace_refs) {
>>     prepare_replace_object(r);
>>     if (...)
>>    }
>>
>> which would make this case work. I'd even go so far as to say that for
>> writing, we should just always ignore replace refs and generate the full
>> graph (just like pack-objects does so when writing a pack). Then the
>> resulting graph can be used selectively by disabling replace refs for
>> particular commands. But for the scenario I described above, the
>> distinction is mostly academic, as replacements would be disabled anyway
>> during the write command anyway.
>>
>> -Peff
>>
>> [1] You can probably guess that this is how GitHub handles replace refs.
>>      We ran into this long ago because replacements and grafts mess up
>>      any other caches external to Git that rely on the immutability of
>>      the hash.
>>
>>      We do it with a config option, though, which requires a trivial
>>      patch. I'll post that momentarily.
>
> Thanks for the details! I never considered that someone would have 
> these refs around, but would ignore them most of the time.
>
> The biggest reason I wanted to punt here was that it is easy to toggle 
> between using replace refs and not using them. Writing and reading as 
> long as we are ignoring those refs is a good idea, and I'll use that 
> approach in v2.


Thanks, Peff, for improving the check_replace_refs interaction [1].

Since this series now has two dependencies (including Stefan's ref-store 
fix [2] that I had included in my v1), I'll let those topics settle 
before I send a new v2.

If there are more comments about how I'm handling these cases, then 
please jump in and tell me. I'll revisit this topic in a few weeks.

Thanks,

-Stolee

[1] 
https://public-inbox.org/git/20180718204449.GA31816@sigill.intra.peff.net/T/#u

      [PATCH 1/3] check_replace_refs: fix outdated comment

[2] 
https://public-inbox.org/git/20180717224935.96397-1-sbeller@google.com/T/#u

     [PATCH 0/2] RFC ref store to repository migration


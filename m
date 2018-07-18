Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0D6D1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 19:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbeGRUcW (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 16:32:22 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:46291 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbeGRUcW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 16:32:22 -0400
Received: by mail-qt0-f170.google.com with SMTP id d4-v6so5166980qtn.13
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 12:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4tfhu7PJsDrvGON+uvO/oJfB5kX6sEJ9fDMl2GPjZHk=;
        b=D0bIAAO1CTKzvTutTWjfztYtJWq50/zUKh7pft7mwj1tePhsZ0gZUnmuX06ek7UZa1
         uiOn4B3wsn7knecq0LkSuvu+NyxRAJTIbm/wuKgQrL0GiVCcCDkJgRJuHrhMCiHnnQxz
         S9TLG6V3+oPHnf2HNrswvlVBxBgIRw+MAtkl+VrEjQCsJAOt/dYQS9o12RW44squpRWl
         t2sYG0hEkQ5rRDRjh5NVRzBZtY79vSj7qX8ZcaNrFxVeXhIOQ6KkEUD/5lgPeQW3da3O
         TuFo9nsnXbTHZlFjHFsfnqH3c2yVq0Er8rmSNJOpiQE4SYoFr9P5/UvvHhN3BQev5FhA
         mcng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4tfhu7PJsDrvGON+uvO/oJfB5kX6sEJ9fDMl2GPjZHk=;
        b=g9j4MKWeO+2PEBvDG0xBErWPiNy4LzuEF5a8cxknBGuqc5lAHqGLCcxbu5JWczxl+k
         9RQGlTdsVRDy3wS6COPadc/73fhXRlaifPhU/ThzAGHNp5Lk4tbVSZlYJFOISfIpjaB6
         HyA71gsyePJkwXl5Hu4PoSbVehYvWC6zhaXUs7s5xkG+5ruYpAGIsy/GkQrfv7puqnAr
         V2NAiWk58k7i/pB15CxTCUQL3XFX9w1KxGTAGohId7lT4BrewQcEM21AwTHGcH78u94i
         ROyTSq/KXfJiQfY3g86LGIKhE8b/g7UB8Zbnbo2U/FtsFrZTbXy6JGQyg9sz+EDA67kT
         KuOA==
X-Gm-Message-State: AOUpUlG6kMVHIZx1Pop01dyVmCX4OdjMOzGFuDkzqnX4RJ9ZVIv920mU
        9oEdsdw/ItTbqoVbv12kND4=
X-Google-Smtp-Source: AAOMgpdIWb6Pznlk39AgwI0zrFuJCNv1szTPd73rvFboSif7apRlp+9Qdhwz6MvunAXY9fwag58z9A==
X-Received: by 2002:a0c:df91:: with SMTP id w17-v6mr8034527qvl.39.1531943576998;
        Wed, 18 Jul 2018 12:52:56 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:68c3:1c3b:990:6a4f? ([2001:4898:8010:0:51f9:1c3b:990:6a4f])
        by smtp.gmail.com with ESMTPSA id n36-v6sm3713045qtb.39.2018.07.18.12.52.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 12:52:56 -0700 (PDT)
Subject: Re: [PATCH 5/8] commit-graph: not compatible with replace objects
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jnareb@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.11.git.gitgitgadget@gmail.com>
 <7f596c1718d35539f02828edbf933c8e660f123b.1531926932.git.gitgitgadget@gmail.com>
 <20180718194657.GC7778@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f5d2f06d-1736-57e4-edbd-aa638ae34238@gmail.com>
Date:   Wed, 18 Jul 2018 15:52:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180718194657.GC7778@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/18/2018 3:46 PM, Jeff King wrote:
> On Wed, Jul 18, 2018 at 08:15:41AM -0700, Derrick Stolee via GitGitGadget wrote:
>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> Create new method commit_graph_compatible(r) to check if a given
>> repository r is compatible with the commit-graph feature. Fill the
>> method with a check to see if replace-objects exist. Test this
>> interaction succeeds, including ignoring an existing commit-graph and
>> failing to write a new commit-graph.
> I think this approach is sensible. These are optimizations, and it's not
> a big deal to just punt no cases we can't handle.
>
> I do have one complaint about the implementation, though:
>
>> +static int commit_graph_compatible(struct repository *r)
>> +{
>> +	prepare_replace_object(r);
>> +	if (hashmap_get_size(&r->objects->replace_map->map))
>> +		return 0;
>> +
>> +	return 1;
>> +}
> If I'm reading the code correctly, this will predicate the decision
> entirely on the presence of refs in refs/replace/. But you may have a
> situation where those refs exist, but you are not respecting them in
> this run.
>
> For instance, imagine[1] a server that hosts arbitrary repositories, but
> wants to use commit graphs to speed up server-side operations (e.g.,
> serving fetches, but also perhaps a web interface doing --contains,
> etc). If it runs all of the server-side commands with
> GIT_NO_REPLACE_OBJECTS=1, then there should be no problem. But if a user
> pushes anything to refs/replace (because they _do_ use replace refs
> locally, and want to share them with other clients), that would disable
> graphs on the server.
>
> So I think this should at least be loosened to:
>
>    if (check_replace_refs) {
> 	prepare_replace_object(r);
> 	if (...)
>    }
>
> which would make this case work. I'd even go so far as to say that for
> writing, we should just always ignore replace refs and generate the full
> graph (just like pack-objects does so when writing a pack). Then the
> resulting graph can be used selectively by disabling replace refs for
> particular commands. But for the scenario I described above, the
> distinction is mostly academic, as replacements would be disabled anyway
> during the write command anyway.
>
> -Peff
>
> [1] You can probably guess that this is how GitHub handles replace refs.
>      We ran into this long ago because replacements and grafts mess up
>      any other caches external to Git that rely on the immutability of
>      the hash.
>
>      We do it with a config option, though, which requires a trivial
>      patch. I'll post that momentarily.

Thanks for the details! I never considered that someone would have these 
refs around, but would ignore them most of the time.

The biggest reason I wanted to punt here was that it is easy to toggle 
between using replace refs and not using them. Writing and reading as 
long as we are ignoring those refs is a good idea, and I'll use that 
approach in v2.

Thanks,

-Stolee


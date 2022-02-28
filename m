Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF97AC433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 13:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236736AbiB1NpZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 08:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236775AbiB1NpX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 08:45:23 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B30E41995
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 05:44:43 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id i6-20020a4ac506000000b0031c5ac6c078so18782713ooq.6
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 05:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ugnrxh+9IYemUYlJvQa3tqi/0IgsH3bzjqysILZCkiQ=;
        b=JCPHjd5nRXg9UdDE9fY21tmRdEtAl6EUtFlY+KHsOmcMrmrZbZSc2DR8Hmeb1UhoA9
         ztli1lsLkSqnFF+Ppwh2VE6hWDtuTkgHLq8a9pfOka4smwiQB+B7TT66xYtf0IWDSlox
         3X0D5CFfphGAMW+A+N+xGIJT00UkYu4/I9QxnLtVLhpohFS9tGE9Phmh49lkc2lI3foo
         RxM5qp4gp/1gnEvl1RV/aohD4EckKSVukeeVLQMzmIE/E/f3wQiTVQVYhUrSBV4c2pSn
         bXGAICdWrnE4S/XjXSbkcz73QqUbpZ+PoNR9ddoMWveyLUgTKu6Yo9dhVOUeHWOnKKyD
         I7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ugnrxh+9IYemUYlJvQa3tqi/0IgsH3bzjqysILZCkiQ=;
        b=ZNcliYnvZRPh5jduo5aKA0T0b1bRAaOr6BijS0KP19ZVjzyiMVzNLkFpNTmSgcmm1t
         YVQ4QA74u528z6ioEALKkkNgapfQkUkor1hsf/fDsPT0KRgR5CHYWpqHtPJVgiEROPD2
         uvRHGgDMGjfUh6VBQ+btQK04ZPbhE7CQ3Bskag8mJk7VmZNw79T3UuPhwpu9HjlZeJzA
         nDTvjA7TtMvIq53P+g+nzZSCx8eENlmOtORBf4DlnUbhsYyyfAx0AgwT7VE2OzBmb5fs
         dI6Jj+CKW6BsvIPCgo00wuwcReJHNsumRcwhHcnmocpoNavFGZoiVnkDpmphGG5d8VVI
         KedQ==
X-Gm-Message-State: AOAM5322GGRX2gdugc023McZZj1Allrn79d74QfkvqTpN0ZS5puwUw1N
        qDGJJCSuglZH0t/hFMf+QaB8wddaw4C2
X-Google-Smtp-Source: ABdhPJz/EoaJnZBe7ZRKQ32Po6AcHGyKXCpdkf3+Q8M2VbXrr8AjY7hNhlHV6HycSM14BAx93YcCnA==
X-Received: by 2002:a05:6870:3742:b0:d1:4cc7:67b5 with SMTP id a2-20020a056870374200b000d14cc767b5mr8093454oak.153.1646055882313;
        Mon, 28 Feb 2022 05:44:42 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id x25-20020a056830409900b005af164235b4sm5036134ott.2.2022.02.28.05.44.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 05:44:41 -0800 (PST)
Message-ID: <d19f5ee8-af92-805f-7ea2-8285862c1123@github.com>
Date:   Mon, 28 Feb 2022 08:44:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 5/7] commit-graph: document file format v2
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        abhishekkumar8222@gmail.com
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
 <7f9b65bd22551fd7fd5d2f0bf18aee8c25f1db99.1645735117.git.gitgitgadget@gmail.com>
 <220225.86a6ee7eid.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220225.86a6ee7eid.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/25/2022 5:31 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Feb 24 2022, Derrick Stolee via GitGitGadget wrote:
> 
...
>>    Generation Data (ID: {'G', 'D', 'A', 'T' }) (N * 4 bytes) [Optional]
>>      * This list of 4-byte values store corrected commit date offsets for the
>> @@ -103,6 +112,9 @@ CHUNK DATA:
>>      * Generation Data chunk is present only when commit-graph file is written
>>        by compatible versions of Git and in case of split commit-graph chains,
>>        the topmost layer also has Generation Data chunk.
>> +    * This chunk does not exist if the commit-graph file format version is 2,
>> +      because the corrected commit date offset data is stored in the Commit
>> +      Data chunk.
>>  
>>    Generation Data Overflow (ID: {'G', 'D', 'O', 'V' }) [Optional]
>>      * This list of 8-byte values stores the corrected commit date offsets
> 
> We talked a while ago now about how we do commit-graph format changes
> and this is partially echoing those earlier questions[1] from 2019.
> 
> I fully understand why we're writing this amended CDAT chunk in a
> different layout. By not having the GDAT side-chunk to look up in the
> data is more local, that part of the file is more compact etc.
> 
> What I don't understand is why getting those performance improvements
> requires the breaking version change & the writing of the incompatible
> version number.
> 
> I.e. couldn't the differently formatted CDAT chunk be written instead to a new
> chunk name (say "2DAT") instead? Per [1] we'd pay a small fixed cost for
> a possibly empty chunk (I didn't re-do those numbers), but surely the
> performance improvements will be about the same for that miniscule
> overhead.

CDAT is a required chunk. It is part of the v1 spec that CDAT exists
and is correct. All other Git clients will error out when reading a
"v1" graph without such a chunk, and in a way that is less helpful to
users. Instead of clearly indicating "file version is too new" it will
say "commit-graph is missing the Commit Data chunk" which is not
helpful.

> It will give you something you can't have here, which is optional
> compatibility with older clients by writing both versions. That'll be a
> ~2x as large file on disk, but with the page cache & each client version
> skipping to the data it needs caching characteristics & data locality
> should work out to about the same thing.

Writing both is the only way that this could work without incrementing
the graph version number, but I'd rather just update the number and
avoid wasting the effort to write that extra data.

It seems you are hyper-focused on "we don't _need_ to update the version
number" and you are willing to recommend wasteful approaches in order to
support that stance.

So: you're right. We don't _need_ to update the version number. But this
is the best choice among the options available.

> Or maybe they won't. I just found it surprising when reviewing this to
> not find an answer to why that approach wasn't
> considered.

The point is to create a new format that can be chosen when deployed
in an environment where older Git versions will not exist (such as
a Git server). The new version is not chosen by default and instead
is opt-in through the commitGraph.generationVersion config option.

Perhaps in a year or two we would consider making this the new
default, but there is no rush to do so.

Thanks,
-Stolee

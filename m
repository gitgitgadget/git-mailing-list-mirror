Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D81C21F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 14:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbeJHWKv (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 18:10:51 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40622 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbeJHWKv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Oct 2018 18:10:51 -0400
Received: by mail-wm1-f66.google.com with SMTP id z204-v6so8640596wmc.5
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 07:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=JlSCCBu9CWr1LMMD9nLPcWisgiziejDGfc5z9JX4hFA=;
        b=NPpLG+fJp5btoDEvFlpEB0roKxZj1kILusxZ3IGy1XqXNJHd9lk6OgOSmX1GIIFo7k
         7Aa947v4dIPRhxEEmgGqDSlbbBeJnHG9kkB8qmz6BpoFHzmBUYPdUswQBUfIJG09AQZB
         TCluazNtDE6mPkIXhAMt4DqYtvkrJYvo+NIMW8DcJk2uPpLPLoVGgY47yu7mkfMfDhCm
         h4YgFqfdhQJaokQbrYdR78j4kPluo61KLASKexk5McW++m3V1cggqgzanhW6FbGipcKf
         VtcdMKDIDBhy60gXmhx7COGDJbjnvY4+K0Q4nvmCK5bZhmdQj/glTtLNa4nN1fTVs+lf
         oGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=JlSCCBu9CWr1LMMD9nLPcWisgiziejDGfc5z9JX4hFA=;
        b=pYzdKqRV1z6rQk0H3ZfnPfBvSHS//gN/zqA4iqARwteSOX5cHfA0GqF/xMPl20m6cb
         U5sCJ25o8CTOW0nQcEVDK0EIMX79JCPavGAd7QrkUHI13HHQ8MbIVHe8AZPXzgvX2htF
         wvK4Y1P7/J74sQgZhjT2dcOUr+zTSMEeJQFH7oKhmwzRmmVkq2+Nm2e4o72p5N27YPNh
         jgHck9HrE1JEBc9Y0ns0rrIfB1miCGPR/jWRC+GvQJwIQUiQo8ze9NcGgPjLQXW/ESbd
         3kw/PFT5SrcWOdK2WJ4pVI55I8F1Vo8+3ALm3M8YlRwZ/IkbtSjE1OImDAR5xpGbTLJn
         chWg==
X-Gm-Message-State: ABuFfogNKCNeMJ49AEM4z9zR30Aw7nh9TfEtELuwRlW5vUlEhEHByW8k
        DBCFrICHnOYdwblqy1Y/oRWdTbjL
X-Google-Smtp-Source: ACcGV60e2doL16Rzu3RzRDnWSBYnok7hCrppHRTZPmJO3RuHPjAbQMLDEEk13LkHJiRuWIxKqCS55Q==
X-Received: by 2002:a1c:a1c6:: with SMTP id k189-v6mr16522432wme.0.1539010721154;
        Mon, 08 Oct 2018 07:58:41 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id l125-v6sm16756263wmb.1.2018.10.08.07.58.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 07:58:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sbeller@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] commit-graph: define GIT_TEST_COMMIT_GRAPH
References: <pull.26.git.gitgitgadget@gmail.com> <85d02ac8d8c9a8950ce1a9760a541ff506945de0.1535488400.git.gitgitgadget@gmail.com> <87bm84a70p.fsf@evledraar.gmail.com> <a2299be9-0840-da69-ebeb-f64ebe66db5a@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <a2299be9-0840-da69-ebeb-f64ebe66db5a@gmail.com>
Date:   Mon, 08 Oct 2018 16:58:39 +0200
Message-ID: <877eisa3j4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 08 2018, Derrick Stolee wrote:

> On 10/8/2018 9:43 AM, Ævar Arnfjörð Bjarmason wrote:
>> On Tue, Aug 28 2018, Derrick Stolee via GitGitGadget wrote:
>>
>>> From: Derrick Stolee <dstolee@microsoft.com>
>>>
>>> The commit-graph feature is tested in isolation by
>>> t5318-commit-graph.sh and t6600-test-reach.sh, but there are many
>>> more interesting scenarios involving commit walks. Many of these
>>> scenarios are covered by the existing test suite, but we need to
>>> maintain coverage when the optional commit-graph structure is not
>>> present.
>>>
>>> To allow running the full test suite with the commit-graph present,
>>> add a new test environment variable, GIT_TEST_COMMIT_GRAPH. Similar
>>> to GIT_TEST_SPLIT_INDEX, this variable makes every Git command try
>>> to load the commit-graph when parsing commits, and writes the
>>> commit-graph file after every 'git commit' command.
>>>
>>> There are a few tests that rely on commits not existing in
>>> pack-files to trigger important events, so manually set
>>> GIT_TEST_COMMIT_GRAPH to false for the necessary commands.
>>>
>>> There is one test in t6024-recursive-merge.sh that relies on the
>>> merge-base algorithm picking one of two ambiguous merge-bases, and
>>> the commit-graph feature changes which merge-base is picked.
>>>
>> The test feature itself seems fine, but this consistently fails ever
>> since it got introduced (a reset --hard on the commit merged to msater
>> in git.git):
>>
>>      GIT_TEST_COMMIT_GRAPH=true prove -j$(parallel --number-of-cores) t5500-fetch-pack.sh t6001-rev-list-graft.sh t6050-replace.sh
>>      Test Summary Report
>>      -------------------
>>      t6001-rev-list-graft.sh (Wstat: 256 Tests: 14 Failed: 6)
>>        Failed tests:  3, 5, 7, 9, 11, 13
>>        Non-zero exit status: 1
>>      t6050-replace.sh       (Wstat: 256 Tests: 35 Failed: 9)
>>        Failed tests:  12-16, 24-25, 30, 35
>>        Non-zero exit status: 1
>>      t5500-fetch-pack.sh    (Wstat: 256 Tests: 357 Failed: 1)
>>        Failed test:  351
>>        Non-zero exit status: 1
>>
>> This is on Linux/Debian 4.17.0-1-amd64. Can you reproduce this? If not I
>> can provide more info (-x output etc..).
> I see these failures, too, but I believe they are due to
> ds/commit-graph-with-grafts not being merged to 'next' yet. The
> purpose of that branch is to fix these test breaks. The environment
> variable got merged a lot faster.
>
> I just built & tested the 'jch' branch at 515d82d9 with
> GIT_TEST_COMMIT_GRAPH=1 and they all passed.

I should have tested "pu" first. These failures are indeed fixed
there. Thanks, and sorry about the noise.

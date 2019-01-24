Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1C2D1F453
	for <e@80x24.org>; Thu, 24 Jan 2019 14:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbfAXOeo (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 09:34:44 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40814 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbfAXOeo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 09:34:44 -0500
Received: by mail-qt1-f196.google.com with SMTP id k12so6713193qtf.7
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 06:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=7F5y+IHpzTJfIkWSckDcuuBnjI5u37UQMEigfTwL5pM=;
        b=KpprF5uZdV7XFelaO6Nc6haOJwel1Z82zfIZKObyYJTlNSlbviY6/XkGs2tdgPCYdA
         +ZpbbSlLxIq15QYRjv1jRZldg2nC3uW0Z4g5pgmyde4N1HsWfu+AQsfVxhPth2kHrovR
         UedKj4MR8DgXjMvMhg+Nk6lZ8MA2bBGkcukfD6EgweD8h0cSHp16edYylSUFBlGKqkck
         klQrTD99mn5keAw0bLJQgcGohOQUgWMq2AqCduouJiml08uYEY2DklmSbVzYGdRqtcQK
         RNMZo0tAe6R+zMDWBY0G5HgiWl70i51hF1JfCUw9eO14GXIDfZ1ZNp5GVjwfEDQON8ns
         w/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7F5y+IHpzTJfIkWSckDcuuBnjI5u37UQMEigfTwL5pM=;
        b=XLqTQULDXvTSgW+/PhPetQfFef8Zsuz0Ms5zTeUrJBR+veTSnkKpg9nygbR0Gl6koi
         267AzVs/ULipvgFjnxWhVGwYSi74k8UFPGBHob/rMKyoGgtytJTnFqaZGp9ZxpF4OhxF
         1qZIQBNRkVRBCzVW+chF5ykfMzV5EVszztiwf6HdYJsEjrWiAT9f1W/DHBhUmGlSy6tl
         nkPC7zhG+tToAq0bL1I1gZrD3fH8ETaychAbmgYPJfj30iekghH9EJ/jl4Gsa232fNwL
         ZtEzf9XD3SaqQMcIxp5+U6eN9wzAJ002g1QOiXzmcmB4gC2e1NqMy6jBXLszmcD22CSZ
         uJqQ==
X-Gm-Message-State: AJcUukdiw9ZJZuyItELNjuonDDIimaUQsqhj/IeYC+DIVXGpMi0Xj+e9
        qYWeMMTmCxxci0WQAgI6ZLs=
X-Google-Smtp-Source: ALg8bN6I6pu8urxfI4dTtli9xW3vNe4+JPjEDZYn+dJ48nqSc71DzgItjQwVho5YVC7KdKYHv7FQCw==
X-Received: by 2002:aed:384a:: with SMTP id j68mr6862681qte.171.1548340482602;
        Thu, 24 Jan 2019 06:34:42 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:a010:321f:4bbb:82c4? ([2001:4898:8010:2:8944:321f:4bbb:82c4])
        by smtp.gmail.com with ESMTPSA id x57sm78288635qtx.96.2019.01.24.06.34.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 06:34:41 -0800 (PST)
Subject: Re: [PATCH 5/6] commit-graph: implement file format version 2
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.112.git.gitgitgadget@gmail.com>
 <c55e0a738c79c30affcf2cb68564c01c36c66dff.1548280753.git.gitgitgadget@gmail.com>
 <878sza4cna.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <cd07c73f-e839-844c-9652-1bdf95724f5a@gmail.com>
Date:   Thu, 24 Jan 2019 09:34:40 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <878sza4cna.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/24/2019 4:40 AM, Ævar Arnfjörð Bjarmason wrote:
> On Wed, Jan 23 2019, Derrick Stolee via GitGitGadget wrote:
>
>> The new format modifies the header of the commit-graph to solve
>> these problems. We use the 4-byte hash format id, freeing up a byte
>> in our 32-bit alignment to introduce a reachability index version.
>> We can also fail to read the commit-graph if the eighth byte is
>> non-zero.
> I haven't tested, but it looks from the patch like we can transparently
> read existing v1 data and then will write v2 the next time. Would be
> helpful for reviewers if this was noted explicitly in the commit
> message.

Can do.

>
> Should there be a GIT_TEST_COMMIT_GRAPH_VERSION=[12] going forward to
> test the non-default version, or do you feel confident the tests added
> here test the upgrade path & old code well enough?

You're right that we should have an explicit "upgrade" test:

  1. Write a v1 commit-graph
  2. Add a commit
  3. Write a v2 commit-graph

As for a new GIT_TEST_ variable, we should only need to continue relying 
on GIT_TEST_COMMIT_GRAPH to test v2. I can add a 'graph_git_behavior' 
call on an explicitly v1 commit-graph file to get most of the coverage 
we need.

>> The 'git commit-graph read' subcommand needs updating to show the
>> new data.
> Let's say "The ... subcommand has been updated to show the new
> data". This sounds like a later patch is going to do that, but in fact
> it's done here.

Will clean up.

>> Set the default file format version to 2, and adjust the tests to
>> expect the new 'git commit-graph read' output.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   .../technical/commit-graph-format.txt         | 26 +++++++++-
>>   builtin/commit-graph.c                        |  9 ++++
>>   commit-graph.c                                | 47 ++++++++++++++++---
>>   commit-graph.h                                |  1 +
>>   t/t5318-commit-graph.sh                       |  9 +++-
>>   5 files changed, 83 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
>> index 16452a0504..e367aa94b1 100644
>> --- a/Documentation/technical/commit-graph-format.txt
>> +++ b/Documentation/technical/commit-graph-format.txt
>> @@ -31,13 +31,22 @@ and hash type.
>>
>>   All 4-byte numbers are in network order.
>>
>> +There are two versions available, 1 and 2. These currently differ only in
>> +the header.
> Shouldn't this be s/currently/ / ? Won't we add a version 3 if we make
> new changes?

When we add a new reachability index version, then the content of the 
data chunk will change. Since we have a separate byte for versioning 
that data, we do not need a v3 for the file format as a whole. A similar 
statement applies to the unused byte reserved for the incremental file 
format: we won't need to increase the file format version as we will 
make that number non-zero and add a chunk with extra data.

Thanks,
-Stolee

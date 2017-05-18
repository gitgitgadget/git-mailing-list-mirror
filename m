Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F166201CF
	for <e@80x24.org>; Thu, 18 May 2017 16:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934078AbdERQ6k (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 12:58:40 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34923 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934068AbdERQ6M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 12:58:12 -0400
Received: by mail-qt0-f193.google.com with SMTP id r58so6477170qtb.2
        for <git@vger.kernel.org>; Thu, 18 May 2017 09:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=zcVI1uX43mnYypix61DVN32yRSJrerk+n0YzQzcKYqw=;
        b=HCXytzSLl3faXUyWm3xJ9/aNVA8aqF9xpz9Tg6Eayh+KVu3mmshcPYU3oBXGSY0qLJ
         jzUSSgeouqWM0d4TLRVukFNnOLacc/jtzKcqLWSNcHRNMsx8AZQU76+ZA+HXIiwsfF52
         ZdsF2kAfOSdsvUac6KMhgxe5b4GbNx3IYSN7Ue1TlPE3KUDKNdP6dSE8zMPJSqb3h7cG
         QhpA/4FEl+xcQ65yOIyBbZOlemzUFyQqIGljnBd4ZVee862fQnXMblKNgEGnhLX+saRc
         j0uX2JiVvNNARRs1WsLZgaEggdw1SwK3GwSd+4UNBtiWUXL+J52BFbs1nyU8o90nIrAG
         Vq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=zcVI1uX43mnYypix61DVN32yRSJrerk+n0YzQzcKYqw=;
        b=FxMID9M57fFsdfhw01GxZXzkgF0JHB1n7qmYdP8JA7pF/C9wkqbzkSlYEUmGKanoAg
         S6ZBona+HlCSd0Ao3kApRkYGhJ9LKyRlMG8PgQGfNu48DgqHseFIXIp0MgdSu9C9tvQg
         LMXl9Bhq5240AT0/sIaXIVtjYEWUMKmJ+tAhuKfc+vUpO5bofolDaH4EPAHX6IVahkq1
         1XlaS3QKyWDGPDnxc5p9YbPzYdiLiHFONqDYQ0X+LAk+dDCgD7tHU6ArYQKWMPhTRO8M
         L1Vl2kNzaAF6pJvi0QHCVHfJMcG5hrfROmc7reEEEk9bCSDAMBBkf5WW0dFeR70WkA16
         y27A==
X-Gm-Message-State: AODbwcCdMBlIxHcq0cpPH26PTCMK0HfB7yY+LTh/uyRQDhA5amTEBQHL
        WDCBlUYailYJrNazZoY=
X-Received: by 10.237.34.154 with SMTP id p26mr4804265qtc.47.1495126691850;
        Thu, 18 May 2017 09:58:11 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id x44sm3996065qtc.68.2017.05.18.09.58.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 May 2017 09:58:11 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 0/1] Preserve the untracked cache across checkout, reset
 --hard, etc
To:     Junio C Hamano <gitster@pobox.com>,
        David Turner <David.Turner@twosigma.com>
References: <cover.1494236457.git.johannes.schindelin@gmx.de>
 <CAP8UFD3qoeQE5ZbFHGLE-_B4rOr3X2m-WPB7rb8QAbZA6zMRxg@mail.gmail.com>
 <2c0be7c0a8ce4f5ea49dfaf3f8511bc0@exmbdft7.ad.twosigma.com>
 <xmqqy3u639n4.fsf@gitster.mtv.corp.google.com>
 <1e21e5c4-3440-a82f-b6c5-1a3e00439054@gmail.com>
Cc:     'Christian Couder' <christian.couder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Ben Peart <benpeart@microsoft.com>
Message-ID: <f497712e-0608-704f-6fbb-06124ab8a9b7@gmail.com>
Date:   Thu, 18 May 2017 12:58:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1e21e5c4-3440-a82f-b6c5-1a3e00439054@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/9/2017 8:51 AM, Ben Peart wrote:
>
> On 5/9/2017 1:02 AM, Junio C Hamano wrote:
>> David Turner <David.Turner@twosigma.com> writes:
>>
>>> Can you actually keep the email address as my Twopensource one?  I
>>> want to make sure that Twitter, my employer at the time, gets credit
>>> for this work (just as I want to make sure that my current employer,
>>> Two Sigma, gets credit for my current work).
>>>
>>> Please feel free to add Signed-off-by: David Turner
>>> <dturner@twosigma.com> in case that makes tracking easier.
>>>
>>> Thanks.
>>>
>>> WRT the actual patch, I want to note that past me did not do a
>>> great job here.  The tests do not correctly check that the
>>> post-checkout untracked cache is still valid after a checkout.
>>> For example, let's say that previously, the directory foo was
>>> entirely untracked (but it contained a file bar), but after the
>>> checkout, there is a file foo/baz.  Does the untracked cache need
>>> to get updated?
>>>
>>> Unfortunately, the untracked cache is very unlikely to make it to
>>> the top of my priority list any time soon, so I won't be able to
>>> correct this test (and, if necessary, correct the code).  But I
>>> would strongly suggest that the test be improved before this code
>>> is merged.
>>>
>>> Thanks for CCing me.
>> I will try to find time to tweak what was sent to the list here to
>> reflect your affiliations better, but marked with DONTMERGE waiting
>> for the necessary updates you mentioned above, so that this change
>> is not forgotten.  It may turn out to be that copying from src to
>> dst like the patch does is all that is needed, or the cache may need
>> further invalidation when the copying happens, and I haven't got a
>> good feeling that anybody who are familiar with the codepath vetted
>> the correctness from seeing the discussion from sidelines (yet).
>>
>> Thanks.
>
> I've been looking into similar issues with the cache associated with
> using a file system monitor (aka Watchman)
> (https://github.com/git-for-windows/git/compare/master...benpeart:fsmonitor)
> to speed updating the index to reflect changes in the working directory.
>
> I can take a look and see if this patch results in valid results and
> reply to the thread or resubmit as needed.
>
> Ben

TLDR: the patch looks good from my perspective but I'd like the experts 
to weigh in as well.

After digging into the untracked cache code and thinking about whether 
it is reasonable to copy the cache from the old index to the new index 
in unpack_trees() I believe the answer is "yes."  I'm not the expert in 
this code so I'll outline my reasoning here and hopefully the real 
experts can review it and see if I've missed something.

The interesting part of the untracked cache for this discussion is the 
list of untracked_cache_dir structures.  Because each directory cache 
entry contains stat_data (esp ctime and mtime) for that directory - the 
existing logic will detect if that directory has had any changes made in 
it since the cache entry was saved.  It doesn't really care when, why, 
or how the change was made, just if one has happened.

I then tried to think of ways that this logic could be broken (like 
David's example above) but was unsuccessful in coming up with any.  This 
makes sense because the untracked cache obviously has to correctly 
detect _any_ change so really doesn't care whether it's cached state was 
initially saved before or after a call to unpack_trees().

Even scenarios of creating files in sub-directories of sub-directories 
works because eventually, either is a directory or file is created in a 
cached directory entry which will change the mtime of that directory and 
invalidate that part of the cache.

Ultimately, it is this behavior of saving the mtime of each cached 
directory that makes this all work as each entry can be 
validated/invalidated separately from all the rest and independently 
from the index from which they came.


Once I did the code examination and thinking exercise, I wanted to test 
it out and see if the theory held up.  I started out with some manual 
testing (esp of the scenario David mentioned) and then wrote a couple of 
additional tests all of which passed.

I then ran all existing git tests with the patch applied and they all 
passed.  This only really tells us that it didn't break anything because 
untracked cache is turned off by default but it does show us that it 
still passes the untracked cache specific test cases (as they obviously 
turn it on).

I then modified the test_create_repo() function in test-lib-functions.sh 
to turn on the untracked cache feature after creating the test repo and 
ran all the tests again twice - the first time without the patch and 
again with the patch).  This run is more interesting because it is 
testing that having the untracked cache turned (with and without the 
patch) on doesn't break anything.

There were two test scripts that had failures:

t7063-status-untracked-cache.sh failed the test "not ok 1 - 
core.untrackedCache is unset"  This is actually a positive result 
because it is showing that I successfully turned on the untracked cache 
feature.

t1700-split-index.sh failed several tests in both runs (with and without 
patch) and upon examining the tests and their failures they are to be 
expected and do not indicate any bug.  Specifically, the failures were 
caused because the tests check the sha of the index against a hard coded 
value in the test script.  Because the untracked cache is turned on, the 
sha of the index does not match that hard coded value.  I edited several 
of the tests to update the sha they are checking against to match the 
sha actually generated and the tests pass.

In the end, both my code examination and all the testing I was able to 
do give me some confidence that the patch will produce valid results. 
However, I'm not the expert in this area so I'd like the experts to 
weigh in on any potential issues this patch may cause that I've missed.

Thanks,

Ben

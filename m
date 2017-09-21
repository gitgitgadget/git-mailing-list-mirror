Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 208B920281
	for <e@80x24.org>; Thu, 21 Sep 2017 00:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbdIUACW (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 20:02:22 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38882 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751663AbdIUACT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 20:02:19 -0400
Received: by mail-qt0-f195.google.com with SMTP id o3so2195261qte.5
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 17:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=twaYsFVk97gRmXhGArZaxLxcXNLfLE7rZ2bCM7jIl4Y=;
        b=C/+yg8GsZsf5nsjXT+mfYHDiHcBZSoL+WdPZjn1DTNkCpYtQS09SGWU3KaKrELwiXy
         fZQdMgDyOF8Ya+yMD4K5zh/nLfJQUuY2JfJ41RYTX/xR07DqdtkObU8u7DQKpqCNHjkg
         VZWNhKz2j/S2RRjz0p+Npf43ukT5gNFD52PR+szA3IUFsl4SsOY/m1wY4k1ZwJLmh28/
         xgYKIemeESzTYa/5Yoj6ChDwg8fC4zXHf+8WKEdgF4f9WCWF4QWAR2qIObZtcROXOelr
         h1XGMhCccF5sFZnJ66iTSE+wwCm/7JjU/qQAZUKTFhUnYXBnXfF4DM/atDDEFydJJ2bn
         AnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=twaYsFVk97gRmXhGArZaxLxcXNLfLE7rZ2bCM7jIl4Y=;
        b=DeNHAQV+pGZ7HxVcHoOhJLd/0lmjTX5ZVzs54SBIVZHFoWCzqjhEw+Nvz4WW2+No4O
         3JgvKNGOl3UHyrkeBD3TdqPtnkdTFB8EZ/0ovk8XxbAkkTSXlDg2y2Qlijvxs1U/6Ffn
         b8hmQuK1p6HNclVDtNJb2ssIOUyv/epowFFgW+tAlBN29EMe8aA0c0S9zkWgm44zga9O
         3Acjdg3vdq8X+llgdCQC8akdeVcuv71Zu2qUnLAXvio+t95Pudui+mRMgH/w4qjaZC58
         DUdK0eFIeB7kLa5VRoXuAp+k/zPLUFpHJ3thAi2M+VrlVs3uBNa/Gt2V7yvtJwAd19dK
         M4ZQ==
X-Gm-Message-State: AHPjjUg3rcsMnQVEtrM0oIyNw8ahjYCiESqczaQgvir/EOtbYfPhTmJJ
        gjUuAEdj+QguSfFRPaeSank=
X-Google-Smtp-Source: AOwi7QD9dCCiRsObLCmw8GNo8vr3IQkZEPEAGOtaVmyQTrVXaJIBazi8nj9krVnbJZxUzJ1vcOQuoQ==
X-Received: by 10.200.48.185 with SMTP id v54mr598854qta.245.1505952138565;
        Wed, 20 Sep 2017 17:02:18 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id s2sm104027qti.40.2017.09.20.17.02.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Sep 2017 17:02:17 -0700 (PDT)
Subject: Re: [PATCH v7 02/12] preload-index: add override to enable testing
 preload-index
To:     Stefan Beller <sbeller@google.com>,
        Ben Peart <benpeart@microsoft.com>
Cc:     David Turner <David.Turner@twosigma.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
References: <20170915192043.4516-1-benpeart@microsoft.com>
 <20170919192744.19224-1-benpeart@microsoft.com>
 <20170919192744.19224-3-benpeart@microsoft.com>
 <CAGZ79kaJWDWGgqRGTdgc+RjVxAb52CpUCk2DCotSksni4cH1Ww@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <0bc0b797-fb82-2300-6df1-dc5380e64c85@gmail.com>
Date:   Wed, 20 Sep 2017 20:02:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kaJWDWGgqRGTdgc+RjVxAb52CpUCk2DCotSksni4cH1Ww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/20/2017 6:06 PM, Stefan Beller wrote:
> On Tue, Sep 19, 2017 at 12:27 PM, Ben Peart <benpeart@microsoft.com> wrote:
>> Preload index doesn't run unless it has a minimum number of 1000 files.
>> To enable running tests with fewer files, add an environment variable
>> (GIT_FORCE_PRELOAD_TEST) which will override that minimum and set it to 2.
> 
> 'it' being the number of threads ('it' was not mentioned before,
> so reading the commit message confused me initially)
> 
>>
>> Signed-off-by: Ben Peart <benpeart@microsoft.com>
>> ---
>>   preload-index.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/preload-index.c b/preload-index.c
>> index 70a4c80878..75564c497a 100644
>> --- a/preload-index.c
>> +++ b/preload-index.c
>> @@ -79,6 +79,8 @@ static void preload_index(struct index_state *index,
>>                  return;
>>
>>          threads = index->cache_nr / THREAD_COST;
>> +       if ((index->cache_nr > 1) && (threads < 2) && getenv("GIT_FORCE_PRELOAD_TEST"))
>> +               threads = 2;
> 
> Adding these lines is just a bandaid to trick
> 
>>          if (threads < 2)
>>                  return;
> 
> to not return early as the commit message does not discuss why
> we set it to 2.
> 

To execute the preload code path, we need a minimum of 2 cache entries 
and 2 threads so that each thread actually has work to do.  Otherwise 
the logic below that divides the work up would need to be updated as 
well.  The additional complexity didn't seem worth it just to enable the 
code path to execute with a single thread on a single cache entry.

> Do we need threads at all for these tests, or would a patch like
> 
> -    if (threads < 2)
> +    if (threads < 2 && !GIT_FORCE_PRELOAD_TEST)
>           return;
> 
> work as well?

That would require a larger patch that would update the work division 
and thread creation logic for little to no gain.

> 
> That way tests can use any number of threads, though
> they currently have no way of overriding the heuristic, yet.
> 
> With this alternative patch, it sounds to me as if the
> issues kept more orthogonal. (specifically "Do we use preload?"
> and "How many threads?". One could imagine that we later
> want to introduce GIT_PRELOAD_THREADS for $reasons
> and that would go over well in combination with
> GIT_FORCE_PRELOAD_TEST)
> 

I'm not sure why someone would want to test varying numbers of threads 
as that isn't a case that can ever actually happen with the existing 
code/feature.

I was just enabling testing of the code path with fewer than 1000 files 
as when I made my changes, I discovered that 1) there were no test cases 
for the core.preloadindex feature at all and 2) there was no way to run 
the existing tests with core.preloadindex as they don't have the minimum 
number of files.  This patch allows you to run the existing test suite 
with preload_index turned on for any test case that has 2 or more files 
(it passes by the way :)).

> It seems to be only an internal test variable, such that we do
> not need documentation. (Is that worth mentioning in the
> commit message?)

Correct.  That is the reason I used the magic GIT_***_TEST naming 
pattern as that is the only way to ensure the environment variable is 
preserved when running the tests.

> 
> The test to make use of this new variable is found
> in another patch I presume?
> 

There are no new tests that take advantage of this new environment 
variable.  Instead you can run the entire git test suite with it by running:

GIT_FORCE_PRELOAD_TEXT=1 prove -j12 --state=all ./t[0-9]*.sh

I can add that to the commit message to make it more obvious if desired.

> Stefan
> 

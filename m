Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7B441F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 21:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730951AbeKTHb4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 02:31:56 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46629 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730844AbeKTHb4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 02:31:56 -0500
Received: by mail-qk1-f193.google.com with SMTP id q1so51059837qkf.13
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 13:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=MQ4G62Vo2sKIJVZm/59SnZ/sYIpQOHcVfTQIMOTfttY=;
        b=a+NBnEbhkfHXcDtcuTO1nKAskAIhafuf+owhA4eiMKamWUsmwMGi4xQq3bQilLRAvJ
         DPC1hkKr3pGGybIbglxmx2lhidDBMl3AAdRnTU1T5fxs78nKdokDg28JKdRReqC7YXLp
         qlqspLnrTOFOxAFGShS83hU8FAoSwPtV049bPBDg+Ej2kxHltb3wGFpzyV5ljVp2tJTp
         NPZ2lv9+wbeSwFpMiFCmJKBTS2D4PUAHi6PrcJWtJ797iKHOrJNqoAST4zObpA4e/0rI
         Sd5w3hQNHpINrSpV4woHiIFidUP1YCX6gtuzROGFqvmXsLqQle9OjMpCXGvf6p71GaVD
         SGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MQ4G62Vo2sKIJVZm/59SnZ/sYIpQOHcVfTQIMOTfttY=;
        b=YTHWrekeGuA1YSOwF2pm8jWIEFnE2cqkbjcBeSq88fV5DsOdgt+4dy9cjR4YcRJ1oB
         hKPW2aK5R38ozpfUc3UuhgsyHxFol6o9GJTwb78ff70UyJCStfZIfUwpsvWwVGOEczPG
         9minB/2M5qd1PSIagB8pFX/nDid0ual+CnwFraoc/VXBDsgnIIn/Q/dSEmNKmljfyQwn
         /+5Mx74M66s91HTyQmXZlHjsmiKNcoltIf8BNsaxysaTYfa8e2XpWIXD0a56kJdYkm4y
         2YZIa74CII3NgZueuYYthln6GpAjxlwjn1MUFDfOeDerqve0HM0qMzG5M8nWS9MaVrt1
         UFbg==
X-Gm-Message-State: AGRZ1gK2MqgiEzEN9fSWoKeNKnFUQ1C9nBrwvZU+In0DKl9+9Bmx5ZCt
        1EC/7z7k2weA3j/6zgZpm5s=
X-Google-Smtp-Source: AJdET5dcDiATIA0ZjD5O+Z6e4Tur3390b+DgznNURyZKw4pfqeJ+YwbfzjZ2v3ssm+fWr8bKrzBS6Q==
X-Received: by 2002:a0c:c927:: with SMTP id r36mr23753331qvj.51.1542661587799;
        Mon, 19 Nov 2018 13:06:27 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:9842:9c91:9414:a691? ([2001:4898:8010:0:8178:9c91:9414:a691])
        by smtp.gmail.com with ESMTPSA id f189sm8116538qkb.4.2018.11.19.13.06.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 13:06:27 -0800 (PST)
Subject: Re: Git Test Coverage Report (v2.20.0-rc0)
To:     Ben Peart <peartben@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= =?UTF-8?Q?_Duy?= 
        <pclouds@gmail.com>, Ben Peart <benpeart@microsoft.com>
References: <9e293b1b-1845-1772-409b-031c0bf4d17b@gmail.com>
 <6f532502-d4b6-17f6-0ec7-01079077ac90@gmail.com>
 <d39320e2-0614-569b-4e82-7f7541589aea@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d7cbe4d1-36ee-2a3c-7ca5-d2e59a8a750f@gmail.com>
Date:   Mon, 19 Nov 2018 16:06:25 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <d39320e2-0614-569b-4e82-7f7541589aea@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/19/2018 2:00 PM, Ben Peart wrote:
>
>
> On 11/19/2018 10:40 AM, Derrick Stolee wrote:
>>
>> There are a lot of lines introduced by the IEOT extension in these 
>> commits:
>>
>>  > Ben Peart      3255089ad: ieot: add Index Entry Offset Table 
>> (IEOT) extension
>>  > Ben Peart      3b1d9e045: eoie: add End of Index Entry (EOIE) 
>> extension
>>  > Ben Peart      77ff1127a: read-cache: load cache entries on worker 
>> threads
>>  > Ben Peart      abb4bb838: read-cache: load cache extensions on a 
>> worker thread
>>  > Ben Peart      c780b9cfe: config: add new index.threads config 
>> setting
>>  > Ben Peart      d1664e73a: add: speed up cmd_add() by utilizing 
>> read_cache_preload()
>>  > Ben Peart      fa655d841: checkout: optimize "git checkout -b 
>> <new_branch>"
>>
>
> These should be hit if you run the test suite with 
> GIT_TEST_INDEX_THREADS=2.  Without that, the indexes for the various 
> tests are too small to trigger multi-threaded index reads/writes.
>
> From t/README:
>
> GIT_TEST_INDEX_THREADS=<n> enables exercising the multi-threaded loading
> of the index for the whole test suite by bypassing the default number of
> cache entries and thread minimums. Setting this to 1 will make the
> index loading single threaded.

I updated my build to add GIT_TEST_INDEX_THREADS=2 and I still see lots 
of uncovered stuff, including that load_cache_entries_threaded() is 
never run.

I added the following diff to my repo and ran the test suite manually 
with GIT_TEST_INDEX_THREADS=2 and it didn't fail:

diff --git a/read-cache.c b/read-cache.c
index 4ca81286c0..36502586a2 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2057,6 +2057,9 @@ static unsigned long 
load_cache_entries_threaded(struct index_state *istate, con
         struct load_cache_entries_thread_data *data;
         unsigned long consumed = 0;

+       fprintf(stderr, "load_cache_entries_threaded\n");
+       exit(1);
+
         /* a little sanity checking */
         if (istate->name_hash_initialized)
                 BUG("the name hash isn't thread safe");

Am I missing something? Is there another variable I should add?

When I look for where the GIT_TEST_INDEX_THREADS variable is checked, I 
see that the calls to git_config_get_index_threads() are followed by a 
check for NO_PTHREADS (setting the number of threads to 1 again). Is it 
possible that my compiler environment is not allowing me to even compile 
with threads?

Thanks,
-Stolee




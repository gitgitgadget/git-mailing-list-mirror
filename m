Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA0161F453
	for <e@80x24.org>; Fri, 28 Sep 2018 18:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbeI2BEC (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 21:04:02 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46881 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbeI2BEC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 21:04:02 -0400
Received: by mail-qt1-f193.google.com with SMTP id h22-v6so7668816qtr.13
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 11:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bJ8w/Fir+3A8NAyilZ7tp8ZLpLGXbENWoZOg1DZwaaM=;
        b=MFLUF9J42YtvfU3Cah6jdGzMLqi72CRwwPOWa0gV00x7olfE/0eNuCuYFcrJi+2I3D
         hrHXhWW7OwgujQ3YLEN7ufXWuLnewSJaLNJkm1CQQ0+Mjn405ufeiyXS7MOdOBH3fS5T
         tVzsI2/EH6KkzoqoWwwQ7+8I1IjCZmgg6OkCiLbzJLevQ8Z+ZsywqXsRE7J5ppW/nBcB
         ZuSQHOcHLGGOI1DWXIJogZoA1lMVyQYppoGcdThwaaFDTZUhke+IZELFNi1bkjRMWajb
         vHxe3crKhKXj042sRUfNDyxI/yCY0/AkKVZpWzwLst6Hxv3vU2a1RYarCScYWK5IV+Qy
         ha/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bJ8w/Fir+3A8NAyilZ7tp8ZLpLGXbENWoZOg1DZwaaM=;
        b=OARZ4cIPs9KD5o1cJMWfrh8C5AcwvaI8UGQDkbuOJO4KtP9A/ubDGlKxNJKUTtx8v+
         lMR653oLU6A2AvHXmsrqa8ppyLhkNKQcM+/o5NtBD7z93R8kVjLvWpGw7RLF+M4sKivW
         J5CnKl5d6gHpHVFnDdSUPfPCPtgHWouiBCXXWThxIHljpUxeKwrWdiq0RR0tc3LTAeuc
         25ykoomV33Ym+3yLOqXQfk9lG4LX7wtGh5c0hBCh6l5dXrtXk3AOyM7zOvFWoZ4FNZFk
         ibSgXxUIk1xtvba6KeJ6bFn3Jv/kJIMZqNX06o+11OTT8XMU0aYjqh6l8EuMjiIJDj/z
         C3cw==
X-Gm-Message-State: ABuFfog7JIdp5PCtx3K+sbf6sVbWOb1cAZEPLQS2Zdaw4inZXW0VXAxG
        Fo24BdPgRn+ds4Ju+/8qSRsC38Q+MnE=
X-Google-Smtp-Source: ACcGV61EX6nat+Ix82bBoU2lwZxQj3F/W0lNFbs8DfllFA6skaoZMCi0V8eB9hkKjUrRI7jXZDpz2w==
X-Received: by 2002:a0c:b3d6:: with SMTP id b22-v6mr2241390qvf.203.1538159938169;
        Fri, 28 Sep 2018 11:38:58 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id p7-v6sm1156001qkp.73.2018.09.28.11.38.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 11:38:57 -0700 (PDT)
Subject: Re: [PATCH v6 3/7] eoie: add End of Index Entry (EOIE) extension
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180926195442.1380-1-benpeart@microsoft.com>
 <20180926195442.1380-4-benpeart@microsoft.com>
 <20180928001929.GN27036@localhost>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <8a12adb1-74f2-b824-b2c7-c82e0f36ad94@gmail.com>
Date:   Fri, 28 Sep 2018 14:38:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180928001929.GN27036@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/27/2018 8:19 PM, SZEDER Gábor wrote:
> On Wed, Sep 26, 2018 at 03:54:38PM -0400, Ben Peart wrote:
>> The End of Index Entry (EOIE) is used to locate the end of the variable
> 
> Nit: perhaps start with:
> 
>    The End of Index Entry (EOIE) optional extension can be used to ...
> 
> to make it clearer for those who don't immediately realize the
> significance of the upper case 'E' in the extension's signature.
> 
>> length index entries and the beginning of the extensions. Code can take
>> advantage of this to quickly locate the index extensions without having
>> to parse through all of the index entries.
>>
>> Because it must be able to be loaded before the variable length cache
>> entries and other index extensions, this extension must be written last.
>> The signature for this extension is { 'E', 'O', 'I', 'E' }.
>>
>> The extension consists of:
>>
>> - 32-bit offset to the end of the index entries
>>
>> - 160-bit SHA-1 over the extension types and their sizes (but not
>> their contents).  E.g. if we have "TREE" extension that is N-bytes
>> long, "REUC" extension that is M-bytes long, followed by "EOIE",
>> then the hash would be:
>>
>> SHA-1("TREE" + <binary representation of N> +
>> 	"REUC" + <binary representation of M>)
>>
>> Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
>> ---
>>   Documentation/technical/index-format.txt |  23 ++++
>>   read-cache.c                             | 151 +++++++++++++++++++++--
>>   t/README                                 |   5 +
>>   t/t1700-split-index.sh                   |   1 +
>>   4 files changed, 172 insertions(+), 8 deletions(-)
>>
> 
>> diff --git a/t/README b/t/README
>> index 3ea6c85460..aa33ac4f26 100644
>> --- a/t/README
>> +++ b/t/README
>> @@ -327,6 +327,11 @@ GIT_TEST_COMMIT_GRAPH=<boolean>, when true, forces the commit-graph to
>>   be written after every 'git commit' command, and overrides the
>>   'core.commitGraph' setting to true.
>>   
>> +GIT_TEST_DISABLE_EOIE=<boolean> disables writing the EOIE extension.
>> +This is used to allow tests 1, 4-9 in t1700-split-index.sh to succeed
>> +as they currently hard code SHA values for the index which are no longer
>> +valid due to the addition of the EOIE extension.
> 
> Is this extension enabled by default?  The commit message doesn't
> explicitly say so, but I don't see any way to turn it on or off, while
> there is this new GIT_TEST environment variable to disable it for one
> particular test, so it seems so.  If that's indeed the case, then
> wouldn't it be better to update those hard-coded SHA1 values in t1700
> instead?
> 

Yes, it is enabled by default and the only way to disable it is the 
GIT_TEST_DISABLE_EOIE environment variable.

The tests in t1700-split-index.sh assume that there are no extensions in 
the index file so anything that adds an extension, will break one or 
more of the tests.

First in 'enable split index', they hard code SHA values assuming there 
are no extensions. If some option adds an extension, these hard coded 
values no longer match and the test fails.

Later in 'disable split index' they save off the SHA of the index with 
split-index turned off and then in later tests, compare it to the SHA of 
the shared index.  Because extensions are stripped when the shared index 
is written out this only works if there were not extensions in the 
original index.

I'll document this behavior and reasoning in the test directly.

This did cause me to reexamine how EOIE and IEOT behave when split index 
is turned on.  These two extensions help most with a large index.  When 
split index is turned on, the large index is actually the shared index 
as the index is now the smaller set of deltas.

Currently, the extensions are stripped out of the shared index which 
means they are not available when they are needed to quickly load the 
shared index.  I'll see if I can update the patch so that these 
extensions are still written out and available in the shared index to 
speed up when it is loaded.

Thanks!

>>   Naming Tests
>>   ------------
>>   
>> diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
>> index be22398a85..1f168378c8 100755
>> --- a/t/t1700-split-index.sh
>> +++ b/t/t1700-split-index.sh
>> @@ -7,6 +7,7 @@ test_description='split index mode tests'
>>   # We need total control of index splitting here
>>   sane_unset GIT_TEST_SPLIT_INDEX
>>   sane_unset GIT_FSMONITOR_TEST
>> +GIT_TEST_DISABLE_EOIE=true; export GIT_TEST_DISABLE_EOIE
>>   
>>   test_expect_success 'enable split index' '
>>   	git config splitIndex.maxPercentChange 100 &&
>> -- 
>> 2.18.0.windows.1
>>

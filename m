Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7A3C433EF
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 15:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242809AbiCNP6R (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 11:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242807AbiCNP5z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 11:57:55 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328DC33E3C
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 08:56:45 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id q13so13894368plk.12
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 08:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=wN7UgwKKIne6m9mWST/gduPDGMSj4cFC9y/B1Ko4mls=;
        b=HluYmcPelTkMl6yNjXVzP5U3xIjIb+YoS05YcWjG/LbA+ElY7Z05/bapgspNhlQCfZ
         j4Efd9j+K8wqxeKMyOGVqWQgCFUFKvQspkeEUeJ2YknqCDl58UKAZZeviGCxN7H9XXiT
         V12NCNQnzGAo4VHkmtjYLoh0hk/I3YfrGgtK8x3poVzQNj7LW20wAj87wmyD77KFmj4H
         Dg0S+XQAMONdUKMHjX7w/5EUHcKgkX6bB3MZ6QUptiXa9H/xb3thzR/lWUnZw4v4eu2V
         zOaqhc913RtBRVp8RPzs/sEHMrSpZIa7WVKj8SOEGSwI6dMRDj0JYOZKXsBgM3dNaQJ8
         g1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wN7UgwKKIne6m9mWST/gduPDGMSj4cFC9y/B1Ko4mls=;
        b=cLGXPB1A7a8RolALCl0LJBCdEp+DiT0nnPaG3FDj8qn1WLwDEvsXwe8IN6SfMvpqQa
         qP/r/UzDMU0OB7R96x6GjNkH3H/dpyHUFnJ5HMvX75lKdhZCqzPG/uXzLx5X/+EiuSDn
         6z2IbCIn+bgvXuqNDW9MgTb+p3BKmacHEZgkpnELoQUk9Q4WJ51jsRuvU4zWoarQ72t3
         PMfzHp6nVEy5FN+Yz0pNBmOy59Hp/MFKRTqFI0tGeqNg1gAUWEuYKM5HUfDqubgQ4sQY
         +SBDQj07xRnf7kLq8rMhJrPbQliIGwZV8E6G7wVLs0whqx57v8OrD+m81eRxLowkwu/D
         HaNg==
X-Gm-Message-State: AOAM5334o8msOoI3HstSc7AO72E8/GYBr6iRvxwEacO4VSZojx/utau0
        dZWwJdViamDowVJXHLzZrmCs
X-Google-Smtp-Source: ABdhPJxLlz8djsD/Unb/kbiro7VToN+vsd/cGIUlWn2aipe24KRYVh6rbHA2/cxQi973Ew+2DVssFA==
X-Received: by 2002:a17:90a:8d85:b0:1b8:a215:e3e4 with SMTP id d5-20020a17090a8d8500b001b8a215e3e4mr36563731pjo.175.1647273404730;
        Mon, 14 Mar 2022 08:56:44 -0700 (PDT)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id o15-20020a17090a168f00b001bf66741097sm18070313pja.16.2022.03.14.08.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 08:56:44 -0700 (PDT)
Message-ID: <53967755-a8c4-d9d7-dd7b-d08782ab88ee@github.com>
Date:   Mon, 14 Mar 2022 08:56:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.2
Subject: Re: [PATCH 5/5] stash: make internal resets quiet and refresh index
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1170.git.1647043729.gitgitgadget@gmail.com>
 <052499bbc93cb6a60a3b7f7861de78dd4075fd7f.1647043729.git.gitgitgadget@gmail.com>
 <41db12c3-029f-2e44-703c-90cb45ed9875@github.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <41db12c3-029f-2e44-703c-90cb45ed9875@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:
> On 3/11/2022 7:08 PM, Victoria Dye via GitGitGadget wrote:
>> From: Victoria Dye <vdye@github.com>
>>
>> Add the options '-q' and '--refresh' to the 'git reset' executed in
>> 'reset_head()', and '--refresh' to the 'git reset -q' executed in
>> 'do_push_stash(...)'.
> 
>> diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
>> index 5e68180f3b2..f2076545133 100755
>> --- a/t/t7102-reset.sh
>> +++ b/t/t7102-reset.sh
>> @@ -482,7 +482,7 @@ test_index_refreshed () {
>>  	git rm --cached file2 &&
>>  
>>  	# Step 2
>> -	git reset $1 --mixed HEAD &&
>> +	git reset $@ --mixed HEAD &&
> 
> I see you change this from "$1" to "$@", which won't help with
> the "-c key=value" issues from earlier.
> 
>>  
>>  	# Step 3
>>  	git read-tree -m HEAD~1
>> @@ -491,48 +491,66 @@ test_index_refreshed () {
>>  test_expect_success '--mixed refreshes the index' '
>>  	# Verify default behavior (with no config settings or command line
>>  	# options)
>> -	test_index_refreshed &&
>> +	test_index_refreshed
> 
> Ah, I see you fixed this here, probably just a rebase issue, then.
> 

That's exactly what happened, and it will be fixed (and triple-checked) in
V2. :)

>>  test_expect_success '--mixed --[no-]quiet sets default refresh behavior' '
>>  	# Verify that --[no-]quiet and `reset.quiet` (without --[no-]refresh)
>>  	# determine refresh behavior
>>  
>> -	# Config setting
>> -	test_must_fail test_index_refreshed -c reset.quiet=true &&
>> -	test_index_refreshed -c reset.quiet=true &&
>> -
> 
> Ah, and the -c changes are removed here. You could still test them
> using the trick I mention in reply to patch 2.
> 
>>  	# Command line option
>> -	test_must_fail test_index_refreshed --quiet &&
>> +	! test_index_refreshed --quiet &&
>>  	test_index_refreshed --no-quiet &&
>>  
>> -	# Command line option overrides config setting
>> -	test_must_fail test_index_refreshed -c reset.quiet=false --quiet &&
>> -	test_index_refreshed -c reset.refresh=true --no-quiet
>> +	# Config: reset.quiet=false
>> +	test_config reset.quiet false &&
>> +	(
>> +		test_index_refreshed &&
>> +		! test_index_refreshed --quiet
>> +	) &&
>> +
>> +	# Config: reset.quiet=true
>> +	test_config reset.quiet true &&
>> +	(
>> +		! test_index_refreshed &&
>> +		test_index_refreshed --no-quiet
>> +	)
> 
> I'm not sure why you need sub-shells here. The test_config is
> not scoped to the shell. These lines could be avoided with the
> -c trick, which should make it a bit simpler to show what you
> intend to be testing here.
> 

This was mostly organizational, but I'll remove them entirely in favor of
the line config option in V2.

> Thanks,
> -Stolee


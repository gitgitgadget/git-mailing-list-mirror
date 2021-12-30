Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B40BC433F5
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 16:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241254AbhL3QZB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 11:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239850AbhL3QZA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 11:25:00 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51582C061574
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 08:25:00 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id l3so27860305iol.10
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 08:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cKOP4flNiZBhXSZsY2JBaxMvUGlHCVwPGnZGwTrVAO8=;
        b=ZcpiwF2eaZvOu+desjGGZlOKfkOMzwnYmbPXvxZhf5tQTsCIPoYCGKFkbmJJbRoRsu
         5UqdRPeZzwKvR6soTCpO6L8sRrNTTWB3hisgUJiqka6yqe0VXyqNjA2rRuCyw6CKoeFS
         To8kc4HA9P7UN7XjCI2bII7Bs17K7H6tZfM1x8IC3OifwfbM4rt1lfZUODxQk+63ebdX
         WRveF+9DuPiwRPlkNQ20+8vRVO86z9uzb3Q79+JgY5vGlSyYKG+K7hlPFvew4jSYw5YC
         I3MsfKd1jyUp+CE34HWZmVIPc5CNwXF9p678vByrIdBrQjbb8egRYwJ8DHmMsildBV9P
         9AEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cKOP4flNiZBhXSZsY2JBaxMvUGlHCVwPGnZGwTrVAO8=;
        b=czf3cHcmmfuvpYp86TJLqdNuxlto6hVfpG6scmortJozt0VerqJx3OIc5SgIcDYOH+
         N1prJXzpZvjaKovRo0ZzLEhvIPyvGw1ek0R8Oqr1rDguEWrI2VQ5PNQuSPfZwkZH0qH6
         x0ogFeF49E5+3OY0wq25TnuQnhs/CkLWABicBPCMNSL0ZZ12HbUmxMHDIiIV+8HMn0me
         yQPhUyLM7UEuwj9n1Y11dhBmphANLO4NylNtIxTnWG6XugCGB+frNIaO0c9LkX2yFECV
         JpAm4/MM/dE0V2G5OOShQd3CnRXNtOFCqzGUpf/rYBQqtMRkOvzrJE1D1wnflKx2H19/
         rM/g==
X-Gm-Message-State: AOAM532v9BefvdwLfl4fChu80qIVIjuoOvpBVGCDJM7hIUAUp9oIZ+GO
        KHFVnmrWfLW2veIE+KAZu2uwXj2f0W5UGbFn
X-Google-Smtp-Source: ABdhPJxuAHPb4a1M6Ye6pKYlrPq3MyQvA03ChSo8p9XjHQ7KvP4W6UtnoyFHb5R0Py9FasqZeufCig==
X-Received: by 2002:a05:6638:258a:: with SMTP id s10mr14267431jat.65.1640881499662;
        Thu, 30 Dec 2021 08:24:59 -0800 (PST)
Received: from [192.168.86.121] (097-087-102-211.res.spectrum.com. [97.87.102.211])
        by smtp.gmail.com with ESMTPSA id g20sm18150716iov.35.2021.12.30.08.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Dec 2021 08:24:59 -0800 (PST)
Message-ID: <8032da64-64da-56be-f9d1-2a833a7768d3@gmail.com>
Date:   Thu, 30 Dec 2021 10:24:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH 2/2] sparse-checkout: custom tab completion
Content-Language: en-US
To:     Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmail.com
References: <pull.1108.git.1640824351.gitgitgadget@gmail.com>
 <ab51236d18ce10ada89e8cde85f678130a0ab1fd.1640824351.git.gitgitgadget@gmail.com>
 <c79ccf4a-4da9-1c60-32eb-124d3fa94400@gmail.com>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <c79ccf4a-4da9-1c60-32eb-124d3fa94400@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/30/21 7:50 AM, Derrick Stolee wrote:
>> +__git_sparse_checkout_init_opts="--cone --sparse-index --no-sparse-index"
>> +
>>   _git_sparse_checkout ()
>>   {
>> -	local subcommands="list init set disable"
>> +	local subcommands="list init set disable add reapply"
>>   	local subcommand="$(__git_find_on_cmdline "$subcommands")"
>> +
>>   	if [ -z "$subcommand" ]; then
>> -		__gitcomp "$subcommands"
>> -		return
>> +		case "$cur" in
>> +			--*)
>> +				__gitcomp "--help"
>> +				;;
>> +			*)
>> +				__gitcomp "$subcommands"
>> +				;;
>> +		esac
> 
> This part fixes the --<tab> completion. I suppose if someone
> did "-<tab>" then nothing would show up?
> 
It actually shows a list of files that contain -- (if any exist).
>>   	fi
>>   
>> -	case "$subcommand,$cur" in
>> -	init,--*)
>> -		__gitcomp "--cone"
>> -		;;
>> -	set,--*)
>> -		__gitcomp "--stdin"
>> -		;;
>> -	*)
>> -		;;
>> +	case "$prev" in
>> +		init)
>> +			__gitcomp "$__git_sparse_checkout_init_opts"
>> +			;;
>> +		add|set)
>> +			__gitcomp "--stdin"
>> +			__gitcomp "$(git ls-tree -d -r HEAD --name-only)"> +			;;
> 
> With the thinking of rebasing onto en/sparse-checkout-set, this
> could possibly be rearranged so the add|set) cases pass-through
> into the init) and reapply) cases (skip the ;; between) to save
> some duplication. Or, it is possible that doesn't work, but it
> might be worth a try.
> 
Thanks, I'll give this a go!
> Also, since you are using 'git ls-tree' and not 'git ls-files',
> the sparse index will not have an effect on the performance.
> There will be some corner cases where a directory exists in one
> of HEAD or the index but not the other. That's probably still
> the right way to go since 'git ls-files' doesn't have a way to
> only list directories. It just means that you probably don't
> need to explicitly disable the sparse index in your test.
> 
Will correct in v2.

-Lessley

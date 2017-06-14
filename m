Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E0FD20282
	for <e@80x24.org>; Wed, 14 Jun 2017 14:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751688AbdFNOMq (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 10:12:46 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35255 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750717AbdFNOMp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 10:12:45 -0400
Received: by mail-qt0-f194.google.com with SMTP id x58so213789qtc.2
        for <git@vger.kernel.org>; Wed, 14 Jun 2017 07:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C+wvm1oz9+cyOgt68zmIqX9MfIJ0EwaLHHAfaN/xwyI=;
        b=u40epTIPbDSeVsD/9SQfATJN3gSeTh+7lm2/FylQDMnAucRGT+arPYutNIgl9T86KR
         RoBFGa18Ikm5ptjk0uN4dnZ4lcg6C/eNSPJoGz0rlPbkr//Dg+vMhsTCY3vTNS/0+/Bn
         JkhLxV6x1aW7nXwmyCAv71aqCUJEz+MUbGOEFCy8ERdGel9rl5de16aFwH6ZwTQE4/N9
         QejgASetg3qAMb2BUXu6DnvyTK1q40edxvCnsz2cxRMLCV8NgB8Gl0ZOMglt9sLElcJC
         uI/SJlLhO5G45egIeg0OEsFBGJfc8ktrmOhWY3gdMaYIDa/H/d5yjZFjeCWGzzx/aIqE
         Dz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C+wvm1oz9+cyOgt68zmIqX9MfIJ0EwaLHHAfaN/xwyI=;
        b=XWjTG4S44U2mHP4djdGmaRaej558Iya8kOwZejoFSPETGgXF9+1ee6ONEdq3m6FHn4
         0eYotPC42ox3T3JMyhMUhBUyVAmZkLPgSV6srRREKlbnpAgdvVURQDbuYekSO4ZzXCZX
         qtV90xzUIR4V08HI27KgLRzkEpRJu1Gez2vziGZR/rVfQ9c9MZq5PFAHzLVN3bZdDxLE
         EBaIyHBDXmMxH8uU+3zihZVgZPoxy4t6fxqt7QAhhGNJJoxtwNvLctUCLZ+1Ilmz2Py8
         eb+aMo2x4yFkaBKVpPF5YHgUdaxoA8dfp576RJOpV1wLTb5wydji6pZegCzZGY2GMf2r
         g9fw==
X-Gm-Message-State: AKS2vOwDdpa1D1CRTB2+hiDHg4WupQwOtwDecl2foToq6XLWq37FxFIA
        58ZE84cd7q6zJw==
X-Received: by 10.200.51.244 with SMTP id d49mr313791qtb.151.1497449564511;
        Wed, 14 Jun 2017 07:12:44 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id m3sm53694qkd.58.2017.06.14.07.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Jun 2017 07:12:43 -0700 (PDT)
Subject: Re: [PATCH v5 7/7] fsmonitor: add a performance test
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net, christian.couder@gmail.com, avarab@gmail.com
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170610134026.104552-8-benpeart@microsoft.com>
 <xmqqo9tsn9qg.fsf@gitster.mtv.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <9c1ed8d4-6bdb-e709-758d-4b010525e9e3@gmail.com>
Date:   Wed, 14 Jun 2017 10:12:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqo9tsn9qg.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/12/2017 6:04 PM, Junio C Hamano wrote:
> Ben Peart <peartben@gmail.com> writes:
> 
>> diff --git a/t/helper/test-drop-caches.c b/t/helper/test-drop-caches.c
>> new file mode 100644
>> index 0000000000..80830d920b
>> --- /dev/null
>> +++ b/t/helper/test-drop-caches.c
>> @@ -0,0 +1,107 @@
>> +#include "git-compat-util.h"
>> +#include <stdio.h>
> 
> I thought compat-util should already include stdio?
> 
>> +
>> +typedef DWORD NTSTATUS;
> 
> Is this safe to have outside "#ifdef GIT_WINDOWS_NATIVE"?

I think it's safe but it isn't required.  I remove it to be sure.

> 
>> +
>> +#ifdef GIT_WINDOWS_NATIVE
>> +#include <tchar.h>
>> +
>> +#define STATUS_SUCCESS			(0x00000000L)
>> +#define STATUS_PRIVILEGE_NOT_HELD	(0xC0000061L)
>> +
>> +typedef enum _SYSTEM_INFORMATION_CLASS {
>> +	SystemMemoryListInformation = 80, // 80, q: SYSTEM_MEMORY_LIST_INFORMATION; s: SYSTEM_MEMORY_LIST_COMMAND (requires SeProfileSingleProcessPrivilege)
> 
> I would have said "Please avoid // comment in this codebase unless
> we know we only use the compilers that grok it".  This particular
> one may be OK, as it is inside GIT_WINDOWS_NATIVE and I assume
> everybody on that platform uses recent GCC (or VStudio groks it I
> guess)?
> 

I'll remove them to be sure.

>> +} SYSTEM_INFORMATION_CLASS;
>> +
>> +// private
>> +typedef enum _SYSTEM_MEMORY_LIST_COMMAND
>> +{
> 
> Style: '{' comes at the end of the previous line, with a single SP
> immediately before it, unless it is the beginning of the function body.
> 

Old habits. :) Started writing Windows code and adopted their coding 
style without even thinking about it.  I'll 'gitify' the style as much 
as possible.  This should address the various style comments below.

> What you did for _SYSTEM_INFORMATION_CLASS above is correct.
> 
>> +	MemoryCaptureAccessedBits,
>> +	MemoryCaptureAndResetAccessedBits,
>> +	MemoryEmptyWorkingSets,
>> +	MemoryFlushModifiedList,
>> +	MemoryPurgeStandbyList,
>> +	MemoryPurgeLowPriorityStandbyList,
>> +	MemoryCommandMax
> 
> Style: avoid CamelCase.
> 
> 
> So status is initialized to 1 and anybody without GIT_WINDOWS_NATIVE
> unconditionally get exit(1)?
> 
> Given that 'status' is the return value of this function that
> returns 'int', I wonder if we need NTSTATUS type here.
> 
> Having said all that, I think you are using this ONLY on windows;
> perhaps it is better to drop #ifdef GIT_WINDOWS_NATIVE from all of
> the above and arrange Makefile to build test-drop-cache only on that
> platform, or something?
> 

I didn't find any other examples of Windows only tools.  I'll update the 
#ifdef to properly dump the file system cache on Linux as well and only 
error out on other platforms.

> 
>> diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
>> new file mode 100755
>> index 0000000000..e41905cb9b
>> --- /dev/null
>> +++ b/t/perf/p7519-fsmonitor.sh
>> @@ -0,0 +1,161 @@
>> +#!/bin/sh
>> +
>> +test_description="Test core.fsmonitor"
>> +
>> +. ./perf-lib.sh
>> +
>> +# This has to be run with GIT_PERF_REPEAT_COUNT=1 to generate valid results.
>> +# Otherwise the caching that happens for the nth run will negate the validity
>> +# of the comparisons.
>> +if [ "$GIT_PERF_REPEAT_COUNT" -ne 1 ]
>> +then
> 
> Style:
> 
> 	if test "$GIT_PERF_REPEAT_COUNT" -ne 1
> 	then
> 	
>> + ...
>> +test_expect_success "setup" '
>> +...
>> +	# Hook scaffolding
>> +	mkdir .git/hooks &&
>> +	cp ../../../templates/hooks--query-fsmonitor.sample .git/hooks/query-fsmonitor &&
> 
> Does this assume $TRASH_DIRECTORY must be in $TEST_DIRECTORY/perf/?
> Shouldn't t/perf/p[0-9][0-9][0-9][0-9]-*.sh scripts be capable of
> running with the --root=<ramdisk> option?  Perhaps take the copy
> relative to $TEST_DIRECTORY?
> 

I'll copy it relative to $TEST_DIRECTORY in the next iteration.


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7877F1F406
	for <e@80x24.org>; Thu, 10 May 2018 12:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965051AbeEJMxA (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 08:53:00 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:45504 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965002AbeEJMw6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 08:52:58 -0400
Received: by mail-qt0-f173.google.com with SMTP id j42-v6so2317226qtj.12
        for <git@vger.kernel.org>; Thu, 10 May 2018 05:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=PfgTO5Fbk/IaJB+7K4EB4NX3W33LjAc868pMNG4Aln4=;
        b=CjAewepGLVVCITYNMGfhTRf8RuSWEBbYh0t9NnZ27VMG8eStWP3dh7rfVTEdE6rzdM
         eiS6Mg3kVhZ02r25jqCda87HA6B7zb8m6ZrifTtBE/fTUV+Uks30wq/8JYmGKR+Shl0A
         ezZ5UuCwX6mU2H/HzGzNZVKcF+F9W/S9AXo3swiyv8poEX62yobotNb8+qaRuwN5F0JM
         GKgMq5nj8MrnrQkMqfhqXKWSeiRMNNiXPH/xqyia+VPPkg15Rh8vSG8hU9i5nlYtQ9Gh
         6h9u0vpEHhb7KHf8ydfN87gtY5Nhd2NDrSM/fLqU1jDVDy6dnxux3x4mjyqeFVimOK5D
         3utg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PfgTO5Fbk/IaJB+7K4EB4NX3W33LjAc868pMNG4Aln4=;
        b=PgjoonA3cAwOAmCIKYXFuxbMjz0wpPGtAepwOzSNGIcZQEo8OzFEdD2VQsql92oDn8
         SstUhEcUnigDVOenu3tpxJr6+Tyk0jt+AI+E4e2vTaE6RcFy2vXGMF4483pDnL+VagbH
         NTfBNeZ7W9WAB4vuuKChP+KxQHZySnH6+SjsS120Q1SL4BLHBVrvH3p0/q678Zw+lQQN
         AqCvgX37ETCt8rrK3tblsir2tbp2f8TmH4x4kRGYl34waqf3cEFBqQONglju8SLAJQWC
         1Ea+jKY3CulUwAsiGRcRNJOBDFK4M+5pHjHy3YUedy+WMgmgmLSOTQwSf3mkFBiESCHf
         hcxQ==
X-Gm-Message-State: ALKqPwcrZ4QBgRdOXeof9lHI0scBtJOt+Du2JV7n7UHrbAmr1GLicY3K
        tc05Sq4FTCH0UxX5a/8UGBck77u3ci4=
X-Google-Smtp-Source: AB8JxZrdmJea3/vQz8HmzURG2UGWyjXQlrjUsrXC/x6caPGTA2+fDhLAntz7TInsQe8QCFDmU6HRMA==
X-Received: by 2002:a0c:bf8f:: with SMTP id s15-v6mr1069804qvj.222.1525956777388;
        Thu, 10 May 2018 05:52:57 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id n66-v6sm478737qkd.7.2018.05.10.05.52.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 May 2018 05:52:56 -0700 (PDT)
Subject: Re: [PATCH 0/1] Fix UX issue with commit-graph.lock
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <20180509141523.89896-1-dstolee@microsoft.com>
 <xmqqfu30j8q7.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3b8005c4-a43d-bd46-c7d9-d6490d500114@gmail.com>
Date:   Thu, 10 May 2018 08:52:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqfu30j8q7.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/10/2018 3:00 AM, Junio C Hamano wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> We use the lockfile API to avoid multiple Git processes from writing to
>> the commit-graph file in the .git/objects/info directory. In some cases,
>> this directory may not exist, so we check for its existence.
>>
>> The existing code does the following when acquiring the lock:
>>
>> 1. Try to acquire the lock.
>> 2. If it fails, try to create the .git/object/info directory.
>> 3. Try to acquire the lock, failing if necessary.
>>
>> The problem is that if the lockfile exists, then the mkdir fails, giving
>> an error that doesn't help the user:
>>
>>    "fatal: cannot mkdir .git/objects/info: File exists"
> Isn't a better immediate fix to make the second step pay attention
> to errno?  If mkdir() failed due to EEXIST, then we know we tried to
> aquire the lock already, so we can die with an appropriate message.
>
> That way, we can keep the "optimize for the normal case" that the
> approach to assume object/info/ directory is already there, instead
> of always checking its existence which is almost always true
> beforehand.

This "optimize for the normal case" is why the existing code is 
organized the way it is.

Since this code is only for writing a commit-graph file, this "check the 
directory first" option is a very small portion of the full time to 
write the file, so the "optimization" has very little effect, 
relatively. My personal opinion is to make the code cleaner when the 
performance difference is negligible.

I'm willing to concede this point and use the steps you suggest below, 
if we think this is the best way forward.

> Also, can't we tell why we failed to acquire the lock at step #1?
> Do we only get a NULL that says "I am not telling you why, but we
> failed to lock"?

To tell why we failed to acquire the lock, we could inspect "errno". 
However, this requires whitebox knowledge of both the lockfile API and 
the tempfile API to know that the last system call to set errno was an 
open() or adjust_shared_perm(). To cleanly make decisions based on the 
reason the lock failed to acquire, I think we would need to modify the 
lockfile and tempfile APIs to return a failure reason. This could be 
done by passing an `int *reason`, but the extra noise in these APIs is 
likely not worth the change.


> What I am getting at is that the ideal sequence
> would be more like:
>      1. Try to acquire the lock.
>      2-a. if #1 succeeds, we are happy. ignore the rest and return
>           the lock.
>      2-b. if #1 failed because object/info/ did not exist,
>           mkdir() it, and die if we cannot, saying "cannot mkdir".
> 	 if mkdir() succeeds, jump t 3.
>      2-c. if #1 failed but that is not due to missing object/info/,
> 	 die saying "cannot lock".
>      3. Try to acquire the lock.
>      4-a. if #3 succeeds, we are happy.ignore the rest and return
>           the lock.
>      4-b. die saying "cannot lock".
>

Thanks,
-Stolee

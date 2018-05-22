Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 725901F51C
	for <e@80x24.org>; Tue, 22 May 2018 12:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbeEVMsJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 08:48:09 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:41730 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751036AbeEVMsI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 08:48:08 -0400
Received: by mail-qt0-f172.google.com with SMTP id g13-v6so23168174qth.8
        for <git@vger.kernel.org>; Tue, 22 May 2018 05:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=iUmhrmBsaOoosMiGNxhOUXeDwSk1FgI60OiJOMVpQ44=;
        b=mST185D943XU0QfL8at71N8Kl5c31T8kEDygiFhnabhZ0wndBv2Qys7NzdWy7JU35G
         OtSOVGUPOCXBTS7iAJ/dzLCl+L/YCkELDvAdJikKbuLHo+zqDkpYmmyPrOHhRBPJr1GG
         1XB/7rwxwoTPcdN8VtjIFHYDC1vvLcjVlEhduYr65mdTggKollNTzYNpOPWUlGHHSeT8
         EChkA14KDHQf5mD+TXidg45HuqIINrD1NCw3GnFTY0ztaoLs5UNAphyooX0UX4ydAP9x
         YHFIg5rZTgv7tYQiMGj37ifb+w2smn99cfQF1KeksDIKUtQyj9jfsighaRdGsUM3MR0W
         pjbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=iUmhrmBsaOoosMiGNxhOUXeDwSk1FgI60OiJOMVpQ44=;
        b=A1uuRKI/X1pLCtcd3ZByECXuF00tzTgl8hW85GPN4XdMHavirnsAWR3HdWs1hTtZmF
         hrsbRHqoocZRM9adPYiq3uqpJc/a7iLB9R2qUUq5XrmidYF7mtJYM1gJXIpMr+0ntcO5
         6gCyXgYlpMkaYQsS5eBGTHGtYFoH9+Ld0sa2ahGKBicmaS0DplddhdYmvGd9wh7QOOwS
         lr9t9ErYsCZ8GYJ04lra4Dss5OUdTYpx8EzuIGkbH3OXNZGPkdQ/m+XQO2J6uiVABHy7
         NKLpVYr1lX0PLys2wLr4SF+ZuIqyMTEuvDki7XPh0Hd0ufoVl7fc1w8Lz71oQTWICWkJ
         F5DA==
X-Gm-Message-State: ALKqPwcZLcJIUP8hvKM2Pv3MV1CLxcqBLLe7KSF08nHjPXgQnWMwcNH+
        TbQTjqs+PXLyhfag05WMeXs=
X-Google-Smtp-Source: AB8JxZq/jZTPWTEgKhjF0H7t9Zie/VXEXPLaOHTWa3pEmnKL5RQndwYjx5OmM+IDx7kz9sNtpjpwZw==
X-Received: by 2002:ac8:120c:: with SMTP id x12-v6mr23259692qti.134.1526993287164;
        Tue, 22 May 2018 05:48:07 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id b3-v6sm10607957qkd.37.2018.05.22.05.48.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 May 2018 05:48:06 -0700 (PDT)
Subject: Re: commit-graph: change in "best" merge-base when ambiguous
To:     Michael Haggerty <mhagger@alum.mit.edu>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>
References: <e78a115a-a5ea-3c0a-5437-51ba0bcc56e1@gmail.com>
 <3705af00-00b7-b620-cc77-eef8f0a73bc1@alum.mit.edu>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8b480e9e-1fd3-35ff-2974-653fadd49fa7@gmail.com>
Date:   Tue, 22 May 2018 08:48:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <3705af00-00b7-b620-cc77-eef8f0a73bc1@alum.mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/22/2018 1:39 AM, Michael Haggerty wrote:
> On 05/21/2018 08:10 PM, Derrick Stolee wrote:
>> [...]
>> In the Discussion section of the `git merge-base` docs [1], we have the
>> following:
>>
>>      When the history involves criss-cross merges, there can be more than
>> one best common ancestor for two commits. For example, with this topology:
>>
>>      ---1---o---A
>>          \ /
>>           X
>>          / \
>>      ---2---o---o---B
>>
>>      both 1 and 2 are merge-bases of A and B. Neither one is better than
>> the other (both are best merge bases). When the --all option is not
>> given,     it is unspecified which best one is output.
>>
>> This means our official documentation mentions that we do not have a
>> concrete way to differentiate between these choices. This makes me think
>> that this change in behavior is not a bug, but it _is_ a change in
>> behavior. It's worth mentioning, but I don't think there is any value in
>> making sure `git merge-base` returns the same output.
>>
>> Does anyone disagree? Is this something we should solidify so we always
>> have a "definitive" merge-base?
>> [...]
> This may be beyond the scope of what you are working on, but there are
> significant advantages to selecting a "best" merge base from among the
> candidates. Long ago [1] I proposed that the "best" merge base is the
> merge base candidate that minimizes the number of non-merge commits that
> are in
>
>      git rev-list $candidate..$branch
>
> that are already in master:
>
>      git rev-list $master
>
> (assuming merging branch into master), which is equivalent to choosing
> the merge base that minimizes
>
>      git rev-list --count $candidate..$branch
>
> In fact, this criterion is symmetric if you exchange branch ↔ master,
> which is a nice property, and indeed generalizes pretty simply to
> computing the merge base of more than two commits.
>
> In that email I also included some data showing that the "best" merge
> base almost always results in either the same or a shorter diff than the
> more or less arbitrary algorithm that we currently use. Sometimes the
> difference in diff length is dramatic.
>
> To me it feels like the best *deterministic* merge base would be based
> on the above criterion, maybe with first-parent reachability, commit
> times, and SHA-1s used (in that order) to break ties.

Thanks, everyone, for your perspective on this. I'm walking away with 
these conclusions:

1. While this is a change in behavior, it is not a regression. We do not 
need to act immediately to preserve old behavior in these ambiguous cases.

2. We should (eventually) define tie-breaking conditions. I like 
Michael's suggestion above.

Thanks,
-Stolee

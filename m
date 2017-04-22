Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66650207D6
	for <e@80x24.org>; Sat, 22 Apr 2017 05:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1041370AbdDVFkg (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Apr 2017 01:40:36 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:35099 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1040590AbdDVFke (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2017 01:40:34 -0400
Received: by mail-io0-f194.google.com with SMTP id d203so36139826iof.2
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 22:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smkent.net; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8iF5CegFj8Ez3qnbw+LeUdReUUVYI5wb6r0UxSYbCAI=;
        b=bG24fNIZdVfQfGUrR3blbJygxpOuJe3LcF0Ziy6RmE2TZjSkbX8ZhQaf9sGK1/WrlM
         LHqPeYC9+OPcN1H0FrXyVW07/ZUWYa0Q2aYpr4bnd4JaM+VDp1sZSv2/T64F2hxtNrgs
         4ncRXtH7UV8MRB077jEf5qYEkCAO9D6jpCi4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8iF5CegFj8Ez3qnbw+LeUdReUUVYI5wb6r0UxSYbCAI=;
        b=t7RCcFqSYruZqjZZpOKL91j3PEr4pWBP5hrG7u+AZ2zQlOANLWp9IeW/F43uR1VSkx
         TbFEmTf2JOWjEHQK/H3NPhxEMAvPvryGgyGucBi+4zBWO9xSyLo9gff34ukjpomEDGcX
         Li3jUXyEi92+BgSYvC+MzT5nQRDHbpFf4YXW4YHpIPJtCTd1Kx4hhUWrvxeQFDXy46F+
         GPgKrprkWnyzRrz+Yx10cYs9r0IUFNvbStahJXfgn9NVGK6DKlGa+XRdQktCh7O2NLte
         NMpyH0oMmYMB+ChiWYnNFW/zfOYCOAV7zdIgcZRmwrx3CzR5auSTtAZODyj6/YHegygN
         hYsQ==
X-Gm-Message-State: AN3rC/5ASmjdnQ1SGBrQfegU3W5e56FRSWRMncD094KdUY/wQe82nof/
        S+N7brf7DzLnUQ==
X-Received: by 10.98.130.10 with SMTP id w10mr15286754pfd.12.1492839633447;
        Fri, 21 Apr 2017 22:40:33 -0700 (PDT)
Received: from localhost (c-73-53-29-115.hsd1.wa.comcast.net. [73.53.29.115])
        by smtp.gmail.com with ESMTPSA id u23sm19037931pgo.58.2017.04.21.22.40.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Apr 2017 22:40:32 -0700 (PDT)
Date:   Fri, 21 Apr 2017 22:40:30 -0700
From:   Stephen Kent <smkent@smkent.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add color slots for branch names in "git status --short
 --branch"
Message-ID: <201704235826023.e27fbbda3fdd0930bd9ff5eaaba99@localhost>
References: <201704556286334.8b7dc718029e6dd189dadb3703bfa@localhost>
 <xmqqzifb8ubt.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqzifb8ubt.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff and Junio,

I've updated the commit message and updated one of the existing unit 
tests for this feature. Patch version 2 will follow shortly after this 
email.

Responses to both of your comments:

> I wondered if this "short-format" was accurate. But indeed, we do not 
> seem to color the local/remote branch specially in long-format mode, 
> so it really is only the short format that is affected.

Right, the hardcoded red and green colors only seem to be used for the 
branch and remote tracking branch names (and commit counts) in the 
status short-format.

There is an existing color slot "color.status.branch" for the branch 
name in the default (long) status format which is different than the new 
color config slots this patch adds.

I'm wondering if it makes sense to also use color.status.branch for the 
local branch color in short-format. On the other hand, I have configured 
different colors in the short and long status format for the local 
branch name and I find it useful for them to be separate color slots.

> Normally we match config names in the code as all lowercase, since the 
> key names we get from the config parser will be normalized. Here it 
> works with your mixed-case because you're using strcasecmp(). 
> Obviously that was picked up from the surrounding code, but I think 
> those existing strcasecmp() calls could (and perhaps should) just be 
> strcmp().

> I don't know if it's worth converting them or not. If we leave them 
> all as strcasecmp(), I don't mind your camelCase names, for 
> readability.

I chose the localBranch and remoteBranch camel case names for 
consistency with the existing "color.decorate.remoteBranch" color config 
slot in log-tree.c. The documentation for color.decorate.remoteBranch 
uses that camel case name, but the config option is case-insensitive. 

I'm happy to use whatever names are best for the short status branch 
name color slots. Let me know if I should change them and what I should 
replace them with.

> I know we do not test color.status.<slot> at all (other than t4026 
> that makes sure a configuration from future version of Git that 
> specifies a slot that is not yet known to our version of Git is safely 
> ignored without triggering an error), but perhaps we would want a new 
> test or two at the end of t7508?

I see the existing tests for git status in t7508. The unit tests set up 
some mock repository modifications to test git status output, so I've 
modified one of the tests to include a custom color for the local branch 
in git status -sb.

t7508 doesn't seem to contain any tests that include an ahead or behind 
commit count, so I didn't make any test changes for the remote tracking 
branch color. What's the best course of action here?

Thanks!

Stephen



On Wed, Apr 19, 2017 at 23:30, Junio C Hamano wrote:
> Stephen Kent <smkent@smkent.net> writes:
>
>> Subject: Re: [PATCH] Add color slots for branch names in "git status 
>> --short --branch"
>
> We spell one-liner title of our commits as "<area>: <summary>" 
> typically.  In this case, this is about the output from the status 
> command, so
>
> 	status: make the color used "--shrot --branch" output configurable
>
> or something, perhaps?
>
>> Signed-off-by: Stephen Kent <smkent@smkent.net>
>> ---
>>  Documentation/config.txt               | 5 ++++-
>>  builtin/commit.c                       | 4 ++++ 
>>  contrib/completion/git-completion.bash | 2 ++
>>  3 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt 
>> index 475e874..96e9cf8 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -1137,7 +1137,10 @@ color.status.<slot>::
>>  	`untracked` (files which are not tracked by Git),
>>  	`branch` (the current branch),
>>  	`nobranch` (the color the 'no branch' warning is shown in, 
>>  	defaulting -	to red), or
>> +	to red),
>> +	`localBranch` or `remoteBranch` (the local and remote branch
>> names, +	respectively, when branch and tracking information is 
>> displayed in the +	status short-format), or
>>  	`unmerged` (files which have unmerged changes).
>
> OK.
>
>>  color.ui::
>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index 4e288bc..43846d5 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -1263,6 +1263,10 @@ static int parse_status_slot(const char *slot) 
>> return WT_STATUS_NOBRANCH;
>>  	if (!strcasecmp(slot, "unmerged"))
>>  		return WT_STATUS_UNMERGED;
>> +	if (!strcasecmp(slot, "localBranch"))
>> +		return WT_STATUS_LOCAL_BRANCH;
>> +	if (!strcasecmp(slot, "remoteBranch"))
>> +		return WT_STATUS_REMOTE_BRANCH;
>>  	return -1;
>>  }
>
> OK.
>
> I know we do not test color.status.<slot> at all (other than t4026 
> that makes sure a configuration from future version of Git that 
> specifies a slot that is not yet known to our version of Git is
> safely ignored without triggering an error), but perhaps we would
> want a new test or two at the end of t7508?
>
> Thanks.

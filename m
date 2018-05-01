Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05A9621841
	for <e@80x24.org>; Tue,  1 May 2018 12:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754814AbeEAMAy (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 08:00:54 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36331 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754283AbeEAMAx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 08:00:53 -0400
Received: by mail-qt0-f193.google.com with SMTP id q6-v6so14305409qtn.3
        for <git@vger.kernel.org>; Tue, 01 May 2018 05:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=YWXNhV7SH1r2JZsesVcbJ4s5MG35Q1JfQfjJhORHj+M=;
        b=ovZtWOoG8sYRvZvcpxEStKxkBrMJpw1FcwDTDemGBHEnnzFoG+ZOJQpduTPtOoTElP
         AVHzECR16TnJv57CrifyrY298rzB6Q5ldUWfcJoR5UGLbEH0W9M6xRFHCklE3TRCE+vt
         6w3QQVlyJfz5ge4X0FkgRvOjEEMisOJxIjGg9CcYmXsLM4XjV93kZ7nuxtW6zGlSn9pm
         IWHS5hFUyAU4b0CbBTBTfw8rmXhFMwhQ6jHhfhfGZqIucnnHVeMr85jGAvrPpB/FB6It
         B1cXqsuY20O1EtUeXBQpO3TAimCaYjx6hKHw4uUlKmTqYrK4ANc4DkEGLpVD47MCJtOR
         6TsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YWXNhV7SH1r2JZsesVcbJ4s5MG35Q1JfQfjJhORHj+M=;
        b=TIWmK8vqQqCzepqyzY+Jn2ivdcAToilfjmdGr2huhcMhHrXPeTKs8cJFrRqoRtRUSw
         a/pscvPg4MwuWqtEOxA/xjqftS9IXN3juqevMjc+5izypexuJmhIKBIeGqAVhM5F+jIt
         GoSvptoW9aeWHAMJK5g/r9qrrfrYW6FkHm6i2xD1UgDUCu21cxfP37KAjSNU3FCj0eAK
         q7yAATHD66MgCAQcpSQs+8tf895btuUg51tSHPnr3Y3lR6WpFrg2D3+LNcbLsCgX2v0A
         Q3rGx9D07LmP0M7MFFy6uCEeZN6LkUXl174nQCsWWlmLdT+cSgSSIj+X1nVBHadzWdoF
         GSzQ==
X-Gm-Message-State: ALQs6tD73HOwiSzPz0zds3rYrgFDQWDwXl+c/E9h8Bcx+F4fLZc2ZP1N
        A65t6k4HtkHxDPo8GSorUl8=
X-Google-Smtp-Source: AB8JxZpnDo0+UAKD4fH0u/1htGPcW4h567ouYQKFyu6nlbijCDEGruOHPj+06OvySmMrDws9sDIcsQ==
X-Received: by 2002:ac8:35e9:: with SMTP id l38-v6mr13374895qtb.290.1525176052468;
        Tue, 01 May 2018 05:00:52 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id p63sm7173717qkd.92.2018.05.01.05.00.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 05:00:51 -0700 (PDT)
Subject: Re: [PATCH v4 10/10] commit-graph.txt: update design document
To:     Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20180417170001.138464-1-dstolee@microsoft.com>
 <20180425143735.240183-1-dstolee@microsoft.com>
 <20180425143735.240183-11-dstolee@microsoft.com> <86d0ygfext.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2ea2c1d0-e2ad-2051-ba98-1584fcb51a46@gmail.com>
Date:   Tue, 1 May 2018 08:00:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <86d0ygfext.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/30/2018 7:32 PM, Jakub Narebski wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> We now calculate generation numbers in the commit-graph file and use
>> them in paint_down_to_common().
>>
>> Expand the section on generation numbers to discuss how the three
>> special generation numbers GENERATION_NUMBER_INFINITY, _ZERO, and
>> _MAX interact with other generation numbers.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> Looks good.
>
>> ---
>>   Documentation/technical/commit-graph.txt | 30 +++++++++++++++++++-----
>>   1 file changed, 24 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
>> index 0550c6d0dc..d9f2713efa 100644
>> --- a/Documentation/technical/commit-graph.txt
>> +++ b/Documentation/technical/commit-graph.txt
>> @@ -77,6 +77,29 @@ in the commit graph. We can treat these commits as having "infinite"
>>   generation number and walk until reaching commits with known generation
>>   number.
>>   
>> +We use the macro GENERATION_NUMBER_INFINITY = 0xFFFFFFFF to mark commits not
>> +in the commit-graph file. If a commit-graph file was written by a version
>> +of Git that did not compute generation numbers, then those commits will
>> +have generation number represented by the macro GENERATION_NUMBER_ZERO = 0.
>> +
>> +Since the commit-graph file is closed under reachability, we can guarantee
>> +the following weaker condition on all commits:
>> +
>> +    If A and B are commits with generation numbers N amd M, respectively,
>> +    and N < M, then A cannot reach B.
>> +
>> +Note how the strict inequality differs from the inequality when we have
>> +fully-computed generation numbers. Using strict inequality may result in
>> +walking a few extra commits,
> The linux kernel commit graph has maximum of 513 commits sharing the
> same generation number, but is is 5.43 commits sharing the same
> generation number on average, with standard deviation 10.70; median is
> even lower: it is 2, with 5.35 median absolute deviation (MAD).
>
> So on average it would be a few extra commits.  Right.
>
>>                                but the simplicity in dealing with commits
>> +with generation number *_INFINITY or *_ZERO is valuable.
> As I wrote before, handling those corner cases in more complicated, but
> not that complicated.  We could simply use stronger condition if both
> generation numbers are ordinary generation numbers, and weaker condition
> when at least one generation number has one of those special values.
>
>> +
>> +We use the macro GENERATION_NUMBER_MAX = 0x3FFFFFFF to for commits whose
>> +generation numbers are computed to be at least this value. We limit at
>> +this value since it is the largest value that can be stored in the
>> +commit-graph file using the 30 bits available to generation numbers. This
>> +presents another case where a commit can have generation number equal to
>> +that of a parent.
> Ordinary generation numbers, where stronger condition holds, are those
> between GENERATION_NUMBER_ZERO < gen(C) < GENERATION_NUMBER_MAX.
>
>> +
>>   Design Details
>>   --------------
>>   
>> @@ -98,17 +121,12 @@ Future Work
>>   - The 'commit-graph' subcommand does not have a "verify" mode that is
>>     necessary for integration with fsck.
>>   
>> -- The file format includes room for precomputed generation numbers. These
>> -  are not currently computed, so all generation numbers will be marked as
>> -  0 (or "uncomputed"). A later patch will include this calculation.
>> -
> Good.
>
>>   - After computing and storing generation numbers, we must make graph
>>     walks aware of generation numbers to gain the performance benefits they
>>     enable. This will mostly be accomplished by swapping a commit-date-ordered
>>     priority queue with one ordered by generation number. The following
>> -  operations are important candidates:
>> +  operation is an important candidate:
>>   
>> -    - paint_down_to_common()
>>       - 'log --topo-order'
> Another possible candidates:
>
>         - remove_redundant() - see comment in previous patch
>         - still_interesting() - where Git uses date slop to stop walking
>           too far

remove_redundant() will be included in v5, thanks.

Instead of "still_interesting()" I'll add "git tag --merged" as the 
candidate to consider, as discussed in [1].

[1] https://public-inbox.org/git/87fu3g67ry.fsf@lant.ki.iif.hu/t/#u
     "branch --contains / tag --merged inconsistency"

>
>>   
>>   - Currently, parse_commit_gently() requires filling in the root tree
> One important issue left is handling features that change view of
> project history, and their interaction with commit-graph feature.
>
> What would happen, if we turn on commit-graph feature, generate commit
> graph file, and then:
>
>    * use graft file or remove graft entries to cut history, or remove cut
>      or join two [independent] histories.
>    * use git-replace mechanims to do the same
>    * in shallow clone, deepen or shorten the clone
>
> What would happen if without re-generating commit-graph file (assuming
> tha Git wouldn't do it for us), we run some feature that makes use of
> commit-graph data:
>
>    - git branch --contains
>    - git tag --contains
>    - git rev-list A..B
>

The commit-graph is not supported in these scenarios (yet). grafts are 
specifically mentioned in the future work section.

I'm not particularly interested in supporting these features, so they 
are good venues for other contributors to get involved in the 
commit-graph feature. Eventually, they will be blockers to making the 
commit-graph feature a "default" feature. That is when I will pay 
attention to these situations. For now, a user must opt-in to having a 
commit-graph file (and that same user has possibly opted in to these 
history modifying features).

Thanks,
-Stolee

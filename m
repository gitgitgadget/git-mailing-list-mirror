Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6ADC1F453
	for <e@80x24.org>; Wed, 31 Oct 2018 12:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbeJaV2U (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 17:28:20 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33487 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbeJaV2T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 17:28:19 -0400
Received: by mail-qk1-f195.google.com with SMTP id o89so9351918qko.0
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 05:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=f5s8/IDalnyEbdBYFtre1dX8Wlv3lw8C0zwI6elW0NU=;
        b=Mfp8cJ51t4i4QBwig70IWqhkmf7xVQK++QofEXVpvCe6q5vJ5TOejuQnj6LkEQ4Ihe
         DoSvQfnh7DMlA0nS1Xi2OMEeUnyc+o3IKf9dSYxAceJ6tO6+xOhr+gMnmz1ZeOqauzRF
         cOK1iJ9137llRYCo8QH6g+9xtqh+SbYHARdCDodRPJ61T9CXUo3sMRl5a/1ZNEclCHPW
         gVwXtkrWjB+RI3A6P5P+rqC1sODDq9Q0WSqW3QOs7YnXZFIOSZFBJ/GHq2pfcMfANYOu
         dnzE43OqFOc/l4ml+il76lKkCalmSybPJmBLHcNHweEAcgU+2Ps0sEGNKFmdD9neLGB4
         tchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=f5s8/IDalnyEbdBYFtre1dX8Wlv3lw8C0zwI6elW0NU=;
        b=IgAUccEzYWm33z4/KId23WSOtEvQeMAQp4BwHwfR2I7ReJzAjNIrWeoEs5O/3YKImF
         s8nB/vlwHe1350kMM8DeI4QauDWuyX+hwdPasRRgUc9EJNiA0n1kRPXnyL98qaUkj5Jo
         P8KQ6JIXWi8MwOD1GU6QHaSWO1o+sj/WuJuSSvE6fkN1h8FeoeliJkztLL8Upyh1uGSG
         mJU33V5MEwyBG56CyWDj+sO4NEIrjmmTfcMMYCCLEXLc1rHnPUhMG5/+ALfev1HH6nGM
         VCkZr1cc2JrPAXsae1XzcyhSEYO80jt9YNYWIlA9nV3A677B6ZuSVRP3bLjA8PR3pCvU
         JX+Q==
X-Gm-Message-State: AGRZ1gL86OtPLg2/iswUm5leYti1JtZb+6eX9s0k5HP9LtmXP8fLC3eV
        ZNlbGPkkikNyWexl5pL+vkE=
X-Google-Smtp-Source: AJdET5d05S7QmH0nXzqGnSv4bhm4bnlB4Jbl+MMI10T+9r/YUnnQHifxskG+3oA80lIej7iv8ajTzQ==
X-Received: by 2002:a37:6c01:: with SMTP id h1-v6mr2334820qkc.67.1540989029417;
        Wed, 31 Oct 2018 05:30:29 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:1547:f48:38e6:a522? ([2001:4898:8010:0:fe7c:f48:38e6:a522])
        by smtp.gmail.com with ESMTPSA id b11-v6sm19721482qta.88.2018.10.31.05.30.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 05:30:28 -0700 (PDT)
Subject: Re: [RFC] Generation Number v2
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <6367e30a-1b3a-4fe9-611b-d931f51effef@gmail.com>
 <xmqqy3ag13us.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <61a829ce-0d29-81c9-880e-7aef1bec916e@gmail.com>
Date:   Wed, 31 Oct 2018 08:30:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <xmqqy3ag13us.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/29/2018 11:59 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
>> **V3: Corrected Commit Date.**
>> For a commit C, let its _corrected commit date_ (denoted by cdate(C))
>> be the maximum of the commit date of C and the commit dates of its
>> parents.
> "maximum of the commit date of C and the corrected commit dates of
> its parents"?

That's what I mean. Thanks.

>
> We've talked about exactly this one in the past (long before any of
> Microsoft folks other than Dscho came to the scene) but without an
> implementation, or detailed design and analysis.  I am very happy to
> see the idea among other possibilities to be considered again.  This
> time around, we may finally come up with something better than the
> "commit dates with SLOP" thing ;-).
>
>> Essentially, the felineY order is selected with the goal of swapping
>> positions of topologically-independent commits relative to the felinX
>> ordering. The resulting reachability index is as follows:
>>
>>     If felineX(A) < felineY(B), then A cannot reach B.
>>     If felineY(A) < felineY(B), then A cannot reach B.
> I presume that the first line is a typo and you compare the same X index?

Yes, sorry for the typos. I fixed them in the report on GitHub.

>
>> * **Compatible?** In our test implementation, we use a previously unused
>>    byte of data in the commit-graph format to indicate which reachability
>>    index version we are using. Existing clients ignore this value, so we
>>    will want to consider if these new indexes are _backwards compatible_.
>>    That is, will they still report correct values if they ignore this byte
>>    and use the generation number column from the commit-graph file assuming
>>    the values are minimum generation numbers?
> I personally consider that the current commit-graph with generation
> numbers experimental, so I am not sure how much we care about this.
>
> Having said that.
>
> By the above definition, any new index that is wider than the
> current generation number cannot be compatible (can we even tell the
> existing clients how wide each elements in the ix array is?)
>
> In any case, perhaps the first thing to do is to update the clients
> so that they stop ignoring the version number field, and instead
> work without generation number when there is no version of reach.ix
> available in the file?  That way, a better reachablility index can
> be chosen freely without having to worry about the compatibility.

I can work on that. It should be as simple as setting commit->generation to
GENERATION_NUMBER_ZERO in fill_commit_in_graph when the graph
has a different version.

>
>> * **Immutable?** Git objects are _immutable_. If you change an object you
>>    actually create a new object with a new object ID. Are the values we
>> store
>>    for these reachability indexes also immutable?
> Even if we do not embed the reachability ix in commit objects,
> having an immutable value is probably a must if we want to make them
> incrementally computable, so this is a very good property to have.
> Unless there is a clever idea to incrementally compute a mutable
> reach.ix, my gut instinct says that this property is a must.
>
> Another thing, perhaps related to "local" below, is if exactly the
> same reach.ix is computed by anybody, given an identical commit
> history graph (perhaps "reproducibility"?).  I think most of the
> candidates you listed are reproducible without a fixed tie-breaker,
> but I am not sure about felineY() thing.
>
>> * **Local?** Are these values **locally computable**? That is, do we only
>>    need to look at the parents of a commit (assuming those parents have
>>    computed values) in order to determine the value at that commit?
> A subset of non-local reachability ix, for example, the ones that
> need to know what each commit's children are, cannot be immutable,
> as adding new objects to the graph (either with locally committing,
> or transferring objects from other repositories) would affect the
> ix; is this true for all non-local reachability ix, I wonder?

As a thought experiment, we could define a function size(C) to be the
numberof commits reachable from C. This is not locally-computable
from the size values at C's parents due to the inclusion-exclusion
principle. We would need to compute it by walking the reachable set
and counting (resulting in quadratic performance overall) but is
immutable. Since the performance cost is so expensive (unlike the
linear costs in the other non-local versions) I didn't include it
in my comparison.

>
>> We focused on three types of performance tests that test the indexes
>> in different ways. Each test lists the `git` command that is used,
>> and the table lists which repository is used and which inputs.
>>
>> ### Test 1: `git log --topo-order -N`
>>
>> This test focuses on the number of commits that are parsed during
>> a `git log --topo-order` before writing `N` commits to output.
> A devil's advocate comment.  Your patches seem to be very focused on
> this "unlimited" case for the past few weeks, but I am not so sure
> if that is a case worth optimizing for.  If "git log --topo-order -N
> HEAD~M.." (for some number M) gives us a similar result as unlimited
> case but with much less effort, wouldn't it be good enough that lets
> us concentrate on other use cases instead?

I mostly included these statistics to make sure we didn't add a 
regression in
this case. Note that I didn't report the OLD values in this table, 
because that
would be an unfair comparison.

>> Based on the performance results alone, we should remove minimum
>> generation numbers, (epoch, date) pairs, and FELINE index from
>> consideration. There are enough examples of these indexes performing
>> poorly.
> OK.
>
>> In contrast, maximum generation numbers and corrected commit
>> dates both performed quite well. They are frequently the top
>> two performing indexes, and rarely significantly different.
>>
>> The trade-off here now seems to be: which _property_ is more important,
>> locally-computable or backwards-compatible?
> Nice summary.
>
> As I already said, I personally do not think being compatible with
> currently deployed clients is important at all (primarily because I
> still consider the whole thing experimental), and there is a clear
> way forward once we correct the mistake of not having a version
> number in the file format that tells the updated clients to ignore
> the generation numbers.  For longer term viability, we should pick
> something that is immutable, reproducible, computable with minimum
> input---all of which would lead to being incrementally computable, I
> would think.

This is good reasoning. The "reproducible" property is also important for
support reasons, too! Sounds like the corrected commit date is the best
way forward.

Aside: I spent some time thinking about making the corrected commit dates
backward compatible by ensuring the offsets are monotonic in the commit
history (so we could store the offset as commit->generation and the existing
generation comparisons would still work). However, it performs poorly on the
Linux repository 'git merge-base v4.8 v4.9' example.

Thanks,
-Stolee

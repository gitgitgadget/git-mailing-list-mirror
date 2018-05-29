Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B8791F42D
	for <e@80x24.org>; Tue, 29 May 2018 22:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967529AbeE2WNB (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 18:13:01 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:36158 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966322AbeE2WM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 18:12:59 -0400
Received: by mail-yw0-f180.google.com with SMTP id v68-v6so5360661ywd.3
        for <git@vger.kernel.org>; Tue, 29 May 2018 15:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6qpuHArkh08CFdFNOm+DnSFNb1QHf/6gw8EPV44z+Ls=;
        b=Mf04QGyEZmbB7VSHHogGrgwXgp6YUT0cGnRaAmDX1Fp6IoeDMp2GxzmyXdfHspqilP
         lEtK7K/J/9iKHgpOt+Tmy5rZOAs3KEfwVNXJm2mTPpn1x18r0UgylRPdTZalPjtLZm1n
         1Z7hMzG/ve7EUHmz5LxCeadpFWh3ExRWHdoGRwhEpZDonEVYUn7GMLDNtt1w2yil5b0U
         lydvLgAgXVO0V1kBD7KtdHKi4QOjABEAadNDY/+a7x8e9sw05E/69+aJdaftlVAX+Dte
         n/wHhkp2a1m6SJwWZFGsKVw+XQA4Zo+KFmpavo6kwpEpsUUR8DhJ60h8X/2ajiHBKYhr
         tDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6qpuHArkh08CFdFNOm+DnSFNb1QHf/6gw8EPV44z+Ls=;
        b=XW0u7Z4eXfuMZjtAGN6aNa+pOcpOkIk/GUaEV5NGuJU6P79F7EZddIHnpE6/aVMnBE
         E4y6ltTZYp8a2vknvDkDsBqsZGE2t7ThCDImFjUB2Etb7R3vVeN3+tBfWVoVNLGAMr+U
         Oi4JABAy2E/0bC2asOVlwsJ59rNN/UrG8xsZU5Yqyn7AVhv3f6NlHcDVEiprSxL3+M1C
         tjW8LpjMU8mAMFaS6HZUu15HyKYHiv8Zthg617elep0X4eT3E4wEk/k7Q6Gs/Z0WNpOs
         7ASqCVU8GBRlVVlgKNzZjeRZiJzw5s2FdWcaAo2JdifcbaifxAGFeksh4ji++NlwgW5A
         qIZg==
X-Gm-Message-State: ALKqPwcVkikKUlFXblw21PoyD/nBYcFFLsIHYNMmVUSFvaRuQPlZPa09
        yapDaQ2AKpRSXkGNtpOejS1/rwqb1Kd8Qe88Bf3PpA==
X-Google-Smtp-Source: ADUXVKKmL9lX1SKjAu+hgQbHqNLNgKDdgZEISa3hlA88DvaJX9CNpyywsXNan0xZ2JUH+vB1Vjw9IOAPUrKhDvjX1tU=
X-Received: by 2002:a81:9447:: with SMTP id l68-v6mr103344ywg.345.1527631978800;
 Tue, 29 May 2018 15:12:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Tue, 29 May 2018 15:12:58 -0700 (PDT)
In-Reply-To: <CABPp-BH1BBH7aBpoSaJE5J7okdfrDzpbu5rH-w-FSG2RM0hU1g@mail.gmail.com>
References: <CABPp-BFQJZHfCJZ1qvhvVcMd-_sOfi0Fkm5PexEwzzN+Zw2akw@mail.gmail.com>
 <CAGZ79ka39xbbm_koyFeEizggoDBqKuwgmGwRBZJnBc13aOWZag@mail.gmail.com> <CABPp-BH1BBH7aBpoSaJE5J7okdfrDzpbu5rH-w-FSG2RM0hU1g@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 29 May 2018 15:12:58 -0700
Message-ID: <CAGZ79kYGTaFg7NnfxzdXQYTNddvqbUD3hfWEiq1RBETjYk=3gQ@mail.gmail.com>
Subject: Re: RFC: Merge-related plans
To:     Elijah Newren <newren@gmail.com>, Thomas Rast <tr@thomasrast.ch>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

context: https://public-inbox.org/git/CABPp-BFQJZHfCJZ1qvhvVcMd-_sOfi0Fkm5PexEwzzN+Zw2akw@mail.gmail.com/

Hi Elijah,

>> Most items forward-reference "Depends on (<later letter>) up to here;
>> (H) seems independent, but might be a good first start.
>> (G) [8] is queued as origin/en/merge-recursive-tests, or do you mean
>> to expand (G) into a mini-framework of merge-testing? i.e. run the
>> mini test framework multiple times, each using a different
>> merge strategy, similar to submodule tests, e.g. see
>> t/lib-submodule-update.sh and one of its users, t1013.
>
> Sorry, I should have been more clear about G.
>
> In more detail...
>
> [...]

Yeah that is what I had in mind when talking about a mini test frame work
above, such that you can run the same test on any merge strategy easily.
Sorry for being confusing there.

>> (B) sounds like an independent feature, which could go in parallel?
>
> B may sound like an independent feature, but it needs a merge
> algorithm that doesn't mess with the working tree

I agree on that,

> so it depends pretty strongly on E.

.. but not quite on the conclusion:
You could also make the current merge algorithm working
tree independent. Thomas Rast (cc'd) did so IIUC in
https://public-inbox.org/git/cover.1409860234.git.tr@thomasrast.ch/
(search the archive for "--remerge" if interested in this prior work)
which did not land upstream.

>>>   * Should I post RFC questions on A and C earlier?
>>
>> I would think so, it is easier to give feedback on code, I would think.
>
> If the idea is to give feedback on *code* rather than just
> ideas/tradeoffs/pinpointing-buggy-lines, then it sounds like you're
> actually suggesting posting the RFC later rather than earlier?

Some people have complained that they don't get feedback on
ideas/tradeoffs/pinpointing-buggy-lines, but did so after sending
RFC code. So I'd think a sure way to get feedback is to send actual
code as an RFC even if it misses some parts.

> Also, the bigger question for me wasn't so much "should I ask the list
> about these changes?" before making them, but rather: Do folks want me
> to bring these things up before I work on D & E -- even if I end up
> not getting back to incorporating their answers for months until D & E
> are completed and merged?

I'd think A + C are worth asking early nevertheless, even if D & E are
away for some month; having these niche cases covered (in code and
tests) as well as a new UI/UX for user communication sound exciting
(The latter could result in some bike shedding, and then having enough
time before you spend time to do it one way or another in D&E sounds
favorable)

>>>   * Should I split D and G?  (Current plan was to keep D together, but
>>>     split G into five short slightly inter-dependent topics)
>>
>> I would have expected to have tests (G) as a companion of (A) or (C)
>> rather than (D), as performance improvements would keep the test suite
>> unchanged?
>
> Let me re-phrase: D and G are completely independent series, both of
> which happen to be divisible.  Should either of them be split?

Sorry for my confusion. This clears it up

>
> More background: D is only a handful of commits, so far; the main
> reason to split it is to allow some of it to go first (maybe even
> before G or H).  The downside is introducing extra churn and risk in
> merge-recursive, when I'm planning to rewrite it soon anyway.  I was
> trying to minimize merge-recursive changes, other than trying to make
> sure that the new merge strategy and merge-recursive will give
> identical results (modulo maybe fixing a few extra corner cases and
> running faster).  Basically, I wanted it to be really easy to compare
> old and new strategies, but otherwise wanted to leave merge-recursive
> mostly alone.  It's not entirely clear how quickly I'll find time to
> work on all of this, though, so maybe just-wait-for-the-rewrite is not
> the right prioritization.

My experience is that smaller patch series are reviewed faster,
so if the cost of splitting them up is not prohibitive, I'd strongly
consider doing that.

>>>   * E is kind of big.  Are there any specific things folks would like to see
>>>     with how that is handled?
>>
>> How much abstraction can be done ahead of time such that there is an
>> interface/API where you just plug in a new merge strategy and do not
>> need to duplicate a lot of code/tests?
>
> For avoiding duplicate tests, my plan was to use a variable (like
> GIT_TEST_SPLIT_INDEX or GIT_FSMONITOR_TEST), which, when set, would
> change the default merge strategy from "recursive" to the new one, and
> also replace explicit requests for the "recursive" merge strategy with
> the new one.

So your long term plan is to *replace* the whole merge recursive strategy
giving the same results [analogous to implementing refstable as a new refs
back end, that behaves the same except faster and easier code for corner
cases] and not offer a *new* strategy [analog here: different (merge/)diff
strategies, such as Myers vs minimal vs patience] that yields user visible
difference and it is unclear whether the user prefers one or the other?
That wasn't clear to me, thanks for clarifying.

My original reply was assuming a new "mode" of merge strategy which
would be a user visible knob to turn. The environment variable you mentioned
sounds like that is an implementation detail, that is just for a
smooth transition
period, but the current code would be deprecated and deleted eventually.

> For avoiding duplicate code...well, Junio's suggestion was "[to
> rewrite] without using much from the existing code in
> merge-recursive.c at all" because he has "written off that code as
> mostly unsalvageable"[4].
>
> There are some functions that I think are worth leaving intact (e.g.
> helpers like output(), the directory rename detection stuff, or the
> merge_submodule code that you recently moved).  That stuff I was
> planning to put in a "/* COPIED FROM merge-recursive.c VERBATIM */"
> section.  And eventually, the idea would be to delete the old
> merge-recursive and just use the replacement, making the duplication
> concerns eventually go away.

This clears up even more, thanks for clarifying!

> ...or is your question more about how to abstract things so that
> others can also write new merge strategies in the future and allow as
> much code and test re-use as possible?

That was my original question as I thought an API would help with
doing that as it would help to not fiddle around with the rest of the
code base.

>>> [4] https://public-inbox.org/git/xmqqk1ydkbx0.fsf@gitster.mtv.corp.google.com/

Did you mean:
https://public-inbox.org/git/xmqqd147kpdm.fsf@gitster.mtv.corp.google.com/

So in that case my reply above ("..so it depends pretty strongly on E.."
I have a different conclusion) is void, as that *is* the new strategy?

Thanks,
Stefan

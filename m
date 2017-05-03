Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4ECA71F829
	for <e@80x24.org>; Wed,  3 May 2017 17:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753290AbdECRO7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 13:14:59 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:35716 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752586AbdECRO5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 13:14:57 -0400
Received: by mail-pg0-f48.google.com with SMTP id o3so76257388pgn.2
        for <git@vger.kernel.org>; Wed, 03 May 2017 10:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ugXvvRcEi7D85gyWjzYhSaA/u/X3g1Jbilwo++HfGR8=;
        b=rWxpNkAisW9HYiUockh0GHzMywZDcGU41kconB47RhDPqigLgbw43UVcF2qP/DkhZX
         g+uDi/wwcYHpx76kAUAI/fFY5jo+Qi5uEZba3UNwkiQnCx5tGUdwIkyfpNWmM632u2kQ
         xy0xw8tlVrxVvSDAQW54EOGUpPV8+wxweuVz1USFichtbTd9K0vcnW1ER3EHYo6pSK7q
         DIEOSI+HlTwKtMEuvXEGrAIcRHS0jp72XGtAsaNVmm+Ut8C/gmbmfw1hqdVAbxW4sJ7D
         D4yRFWwZC0FgGAjIz2nOn1pSeSIEvDthQVAbp6W/41v6XGF1359JSKZlr9WeM1JT8HgL
         hHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ugXvvRcEi7D85gyWjzYhSaA/u/X3g1Jbilwo++HfGR8=;
        b=kRPWwLHu9BdikiIwQ6AjoZsVBARyRNDDGm3qf1/IYsotZG4rIIM3gqST6rcmHWlG/0
         4DVywAglPlLqh9hEDGmmJL5DTrdLTr0uS7fUDed1kfU1ijudBxg7q66m+HN8eH3HDqN5
         euViyU64WuoerB4f8INpUu4Lt4VoD9TQP0gSGYQPeVdy0gP+3dCkf4y9siQ9uNy0rVHg
         OOq57AUL4YDxG/pNyCql1TmU6MFS5hZDOux6P6uu5xa84j+NubN0udBDsCKCnnC+mueu
         tgSCXVNHIVnUpqwEslNbx65PuPO0FtNFTN9KV8KaIm75QJNFsTRmsj4F+lx38ZKsc/ky
         0yug==
X-Gm-Message-State: AN3rC/4ihfBp5CNCSt4/XvfS70oAG5DHktyifMJ56fxv5BtbxIRls1dj
        li6RQ4cWlEqcOqwqPkoZ90nxWfGq4DjM
X-Received: by 10.99.126.92 with SMTP id o28mr9985227pgn.63.1493831696274;
 Wed, 03 May 2017 10:14:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Wed, 3 May 2017 10:14:55 -0700 (PDT)
In-Reply-To: <CAJZjrdWF4NLPty81wmPsgUoVz1FddYhTGdjrNuB1LcME5qrwDQ@mail.gmail.com>
References: <20170501190719.10669-1-sbeller@google.com> <xmqq7f20f3a8.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZkssTEdNyzYh1YYv89szvig=rn2j3DJcHxsbzdADRw-w@mail.gmail.com>
 <b2d1d2fe-1b9b-4afa-192f-267bbb5df487@jeffhostetler.com> <CAJZjrdWF4NLPty81wmPsgUoVz1FddYhTGdjrNuB1LcME5qrwDQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 3 May 2017 10:14:55 -0700
Message-ID: <CAGZ79kZs8q2cn7wJr-2ZFGZEwSsy8K2RZ_xBXfUuZBiGM0Gjog@mail.gmail.com>
Subject: Re: [PATCH 0/5] Start of a journey: drop NO_THE_INDEX_COMPATIBILITY_MACROS
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 3, 2017 at 4:31 AM, Samuel Lijin <sxlijin@gmail.com> wrote:
> On Tue, May 2, 2017 at 9:05 AM, Jeff Hostetler <git@jeffhostetler.com> wrote:
>>
>>
>> On 5/2/2017 12:17 AM, Stefan Beller wrote:
>>>
>>> On Mon, May 1, 2017 at 6:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>>
>>>> Stefan Beller <sbeller@google.com> writes:
>>>>
>>>>> This applies to origin/master.
>>>>>
>>>>> For better readability and understandability for newcomers it is a good
>>>>> idea
>>>>> to not offer 2 APIs doing the same thing with on being the #define of
>>>>> the other.
>>>>>
>>>>> In the long run we may want to drop the macros guarded by
>>>>> NO_THE_INDEX_COMPATIBILITY_MACROS. This converts a couple of them.
>>
>>
>> Thank you for bringing this up and making this proposal.
>> I started a similar effort internally last fall, but
>> stopped because of the footprint size.
>>
>>>>
>>>> Why?  Why should we keep typing &the_index, when most of the time we
>>>> are given _the_ index and working on it?
>>>
>>>
>>> As someone knowledgeable with the code base you know that the cache_*
>>> and index_* functions only differ by an index argument. A newcomer may not
>>> know this, so they wonder why we have (A) so many functions [and which is
>>> the
>>> right function to use]; it is an issue of ease of use of the code base.
>>>
>>> Anything you do In submodule land today needs to spawn new processes in
>>> the submodule. This is cumbersome and not performant. So in the far future
>>> we may want to have an abstraction of a repo (B), i.e. all repository
>>> state in
>>> one struct/class. That way we can open a submodule in-process and perform
>>> the required actions without spawning a process.
>>>
>>> The road to (B) is a long road, but we have to art somewhere. And this
>>> seemed
>>> like a good place by introducing a dedicated argument for the
>>> repository. In a follow
>>> up in the future we may want to replace &the_index by
>>> "the_main_repo.its_index"
>>> and then could also run the commands on other (submodule) indexes. But
>>> more
>>> importantly, all these commands would operate on a repository object.
>>>
>>> In such a far future we would have functions like the cmd_* functions
>>> that would take a repository object instead of doing its setup discovery
>>> on their own.
>>>
>>> Another reason may be its current velocity (or absence of it) w.r.t. to
>>> these
>>> functions, such that fewer merge conflicts may arise.
>>
>>
>> In addition to (eventually) allowing multiple repos be open at
>> the same time for submodules, it would also help with various
>> multi-threading efforts.  For example, we have loops that do a
>> "for (k = 0, k < active_nr; k++) {...}"  There is no visual clue
>> in that code that it references "the_index" and therefore should
>> be subject to the same locking.  Granted, this is a trivial example,
>> but goes to the argument that the code has lots of subtle global
>> variables and macros that make it difficult to reason about the
>> code.
>
> Just to throw out an example, I'm relatively new to the codebase (I've
> been lurking on the mailing list for a few months now) and for a
> recent project (I'm an undergrad wrapping up my senior year, and one
> of my classes' final projects was to do something that involved
> concurrency) I took a shot at parallelizing the estimate_similarity()
> calls in diffcore_rename(). The only way I was able to get it to work
> was by dropping global mutexes in one or two files (the code for those
> mutexes still makes me cringe), because of concurrent writes to global
> data structures.

That sounds like a challenge. As we have many globals, we need to be
very careful about threading.

Also an interesting discussion about threading:
https://public-inbox.org/git/9e4733910708111412t48c1beaahfbaa2c68a02f64f1@mail.gmail.com/

Are the patches available for discussion?

Thanks,
Stefan

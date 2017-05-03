Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCEB7207D6
	for <e@80x24.org>; Wed,  3 May 2017 11:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752050AbdECLca (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 07:32:30 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34123 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751556AbdECLc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 07:32:29 -0400
Received: by mail-io0-f193.google.com with SMTP id h41so34796787ioi.1
        for <git@vger.kernel.org>; Wed, 03 May 2017 04:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sH7PljIzka4brWQFKcmRBoLAi/LtY1RyJ9+QF4Y5BKw=;
        b=H9rCI5sCUHEBdTobD3qhg4Ticl+IsdkBq0/v+dl7YnKeziRpPVqAb4FRImVkVpeTTw
         HLgafajNt+6JnNvNGNPjMOQzNKqXsPWvS2r8HHIxC39wJN26ZFfRrdRD89nDs87OFD7b
         NyQDmH02PGLjOxe0LjVjnZZ4ukU0xXZpVshcaX0J5n9F3Mk0kmcbuHIxkg4P4wrxmxR/
         lkSDD611ipgTfMjiIth8X9SYmJu/HvxKRl/Yt+2T4KIXQhKCM/LmdOHeA/IJLOmjuYMM
         cyYt3yxOE9UWWnkWSS5Zf1o5pK9zNQLmecYoIRgczCIK5IaKvVNCFH/BK9YOSRJ3fJOS
         yrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sH7PljIzka4brWQFKcmRBoLAi/LtY1RyJ9+QF4Y5BKw=;
        b=RBfwb2FeSc5icqmiyoIPBQyJIsHS4PbiOB3plvt04flN8TqaFyXZ19OYjVWIYzDqA2
         01YbGiS0z+DN+fApxFa0+rVTLzt57AukKgdNyT9s1YFhjf4PfkV4Jdhxh1xe5mk0dGyC
         fGeSj5nB42rLMWPTX1ioLNwOr7K0hKe3w40qfp3hfO04qk8bTkPDgnuA3DPtW6NLcZKH
         MxJm24Ca8aPdpnH55O6ebvC58pYQIU+A14RRzC2BQH53l3/EZiGgw6BSX05CX5BHVMT/
         j1gVzFWyku5oLPNC911wY+WKyRP6MQ6IFfFA6psvE+Bvo42z9/0fF0YegHO1YssHPTIB
         87Nw==
X-Gm-Message-State: AN3rC/7ELxEOweTnn1xLPSaI0clugvvMXkjqnlIvlRI4ZdouOBqPQRfL
        3eyrFzR4kkpQCeZBY7gkzqPeHUrbhIA8
X-Received: by 10.107.11.89 with SMTP id v86mr39105630ioi.85.1493811148503;
 Wed, 03 May 2017 04:32:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.150.90 with HTTP; Wed, 3 May 2017 04:31:48 -0700 (PDT)
In-Reply-To: <b2d1d2fe-1b9b-4afa-192f-267bbb5df487@jeffhostetler.com>
References: <20170501190719.10669-1-sbeller@google.com> <xmqq7f20f3a8.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZkssTEdNyzYh1YYv89szvig=rn2j3DJcHxsbzdADRw-w@mail.gmail.com> <b2d1d2fe-1b9b-4afa-192f-267bbb5df487@jeffhostetler.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Wed, 3 May 2017 06:31:48 -0500
Message-ID: <CAJZjrdWF4NLPty81wmPsgUoVz1FddYhTGdjrNuB1LcME5qrwDQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Start of a journey: drop NO_THE_INDEX_COMPATIBILITY_MACROS
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 2, 2017 at 9:05 AM, Jeff Hostetler <git@jeffhostetler.com> wrote:
>
>
> On 5/2/2017 12:17 AM, Stefan Beller wrote:
>>
>> On Mon, May 1, 2017 at 6:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> Stefan Beller <sbeller@google.com> writes:
>>>
>>>> This applies to origin/master.
>>>>
>>>> For better readability and understandability for newcomers it is a good
>>>> idea
>>>> to not offer 2 APIs doing the same thing with on being the #define of
>>>> the other.
>>>>
>>>> In the long run we may want to drop the macros guarded by
>>>> NO_THE_INDEX_COMPATIBILITY_MACROS. This converts a couple of them.
>
>
> Thank you for bringing this up and making this proposal.
> I started a similar effort internally last fall, but
> stopped because of the footprint size.
>
>>>
>>> Why?  Why should we keep typing &the_index, when most of the time we
>>> are given _the_ index and working on it?
>>
>>
>> As someone knowledgeable with the code base you know that the cache_*
>> and index_* functions only differ by an index argument. A newcomer may not
>> know this, so they wonder why we have (A) so many functions [and which is
>> the
>> right function to use]; it is an issue of ease of use of the code base.
>>
>> Anything you do In submodule land today needs to spawn new processes in
>> the submodule. This is cumbersome and not performant. So in the far future
>> we may want to have an abstraction of a repo (B), i.e. all repository
>> state in
>> one struct/class. That way we can open a submodule in-process and perform
>> the required actions without spawning a process.
>>
>> The road to (B) is a long road, but we have to art somewhere. And this
>> seemed
>> like a good place by introducing a dedicated argument for the
>> repository. In a follow
>> up in the future we may want to replace &the_index by
>> "the_main_repo.its_index"
>> and then could also run the commands on other (submodule) indexes. But
>> more
>> importantly, all these commands would operate on a repository object.
>>
>> In such a far future we would have functions like the cmd_* functions
>> that would take a repository object instead of doing its setup discovery
>> on their own.
>>
>> Another reason may be its current velocity (or absence of it) w.r.t. to
>> these
>> functions, such that fewer merge conflicts may arise.
>
>
> In addition to (eventually) allowing multiple repos be open at
> the same time for submodules, it would also help with various
> multi-threading efforts.  For example, we have loops that do a
> "for (k = 0, k < active_nr; k++) {...}"  There is no visual clue
> in that code that it references "the_index" and therefore should
> be subject to the same locking.  Granted, this is a trivial example,
> but goes to the argument that the code has lots of subtle global
> variables and macros that make it difficult to reason about the
> code.

Just to throw out an example, I'm relatively new to the codebase (I've
been lurking on the mailing list for a few months now) and for a
recent project (I'm an undergrad wrapping up my senior year, and one
of my classes' final projects was to do something that involved
concurrency) I took a shot at parallelizing the estimate_similarity()
calls in diffcore_rename(). The only way I was able to get it to work
was by dropping global mutexes in one or two files (the code for those
mutexes still makes me cringe), because of concurrent writes to global
data structures.

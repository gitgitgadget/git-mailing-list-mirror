Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF38F1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 22:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753206AbeBIW4Z (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 17:56:25 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:50193 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753124AbeBIW4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 17:56:24 -0500
Received: by mail-wm0-f49.google.com with SMTP id f71so206571wmf.0
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 14:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=8JXuoISPPD0ftyPm/qZ0f4LAVa4lkdkY3BdRvsHsjs0=;
        b=Ybeoc9kRExKY17PGm8CjxHu0JtGfSOJ3QMiiic6kPOQULapqnCTbnxaVxQFOh4favK
         x8pKpETMsxdL6RHRdACGLhbYPfnYe8eLWFXWRNrnbIiYvqO5+pLPBEufOMhHgzxKgkdS
         Gy12G6nDDaW39mSMxNY3h5AlsBxqWOUdANn+xCEAhAcumhVhpxjynllpKLsNH6m1WeRv
         Z+D1i/ZPE0AiXatfAuNRj12ATHAdW5HsathI+Oj78HQ6vD0wiL2VtNBONJeDyy/feSr1
         cnNtuoHQZDBDjiP1cehuthpG6IP1NunceQ28zs3nlJdcCKvO0lVKehlSIVDcaVZ2fx84
         HEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=8JXuoISPPD0ftyPm/qZ0f4LAVa4lkdkY3BdRvsHsjs0=;
        b=SEe7pMF6etVPfyxvdwOs5AuUU4JlwY7u3sw21pFL1JTswuCAW8LJAc/wIM4gQJhXUj
         0oTI9d3nCgJf5QDIttvx8qI357FEg5jl+bOpItOXA85O0wLyHoKVyBKsyAlNKN0fib/R
         5FvrK8imdbY+aNObVj9ZkEKVmrYIqww3u460+8JiaY2LSxfDSQX1P+aZMLDHEOjqaV6o
         aEl0OYPmLSxpESD+IlBY8rO9MjprtCN7RpAVGUYZUZRgya4WJQ6kmqzH/3dj3/A6ORIA
         Y9UkuojZAr5ORzB5YCRLcLxS589+Fg1W8EKrGkEUA9m3MyfBzPN/XSjYMmVftHwDfRxZ
         2iKg==
X-Gm-Message-State: APf1xPCwNa957NjR8WDSCu0+LQMRsOzRNP/WMiLPz1InaOvfytp25wdo
        Vajzx4HIAA03fZRO8rKkQNM=
X-Google-Smtp-Source: AH8x22793yFn4O/Zc1aPHD3mr/bt++CuP2Q0f3ZqdQdDNBGugoKizbBJCzcpVbfnypH7kSkkx/JI6Q==
X-Received: by 10.80.192.72 with SMTP id u8mr5639240edd.109.1518216983616;
        Fri, 09 Feb 2018 14:56:23 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id h9sm1557826edi.79.2018.02.09.14.56.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Feb 2018 14:56:22 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Leo Gaspard <leo@gaspard.io>
Cc:     Joey Hess <id@joeyh.name>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>
Subject: Re: Fetch-hooks
References: <5898be69-4211-d441-494d-93477179cf0e@gaspard.io> <87inb8mn0w.fsf@evledraar.gmail.com> <c8d1eb4d-c3d2-5834-a46b-931e825315aa@gaspard.io> <20180208153040.GA5180@kitenet.net> <871af155-a159-2a29-2e48-74e7a98b60d4@gaspard.io> <87bmgzmbsk.fsf@evledraar.gmail.com> <fa470be4-75fb-76ed-ed93-5c10fcfb8842@gaspard.io> <87po5dbz1a.fsf@evledraar.gmail.com> <25bd770c-6a48-5b5d-04cc-6d02784ea3e7@gaspard.io>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <25bd770c-6a48-5b5d-04cc-6d02784ea3e7@gaspard.io>
Date:   Fri, 09 Feb 2018 23:56:21 +0100
Message-ID: <87lgg1bwmi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 09 2018, Leo Gaspard jotted:

> On 02/09/2018 11:04 PM, Ævar Arnfjörð Bjarmason wrote:>>> You could also
> have some intermediate step between these two, where
>>>> e.g. your refspec for "origin" is
>>>> "+refs/heads/*:refs/remotes/origin-untrusted/*" instead of the default
>>>> "+refs/heads/*:refs/remotes/origin/*", you fetch all refs to that
>>>> location, then you move them (with some alias/hook) to
>>>> "refs/remotes/origin/*" once they're seen to be "OK".
>>>
>>> That is indeed another possibility, but then the idea is to make things
>>> as transparent as possible for the end-user, not to completely change
>>> their git workflow. As such, considering only signed commits to be part
>>> of the upstream seems to make sense to me?
>>
>> I mean this would be something that would be part of a post-fetch hook,
>> so it would be as transparent as what you're doing to the user, with the
>> difference that it doesn't need to involve changes to what you slurp
>> down from the server.
>>
>> I.e. we'd just fetch into refs/remotes/origin-untrusted/, then we run
>> your post-fetch hook and you go over the new refs, and copy what you
>> like (usually everything) to refs/remotes/origin/*.
>
> Hmm... but that would then require a post-fetch hook, wouldn't it? And
> about a post-fetch hook, if I understood correctly, Junio in [1] had a
> quite nice argument against it:
>
>     Although I do not deeply care between such a "trigger to only
>     notify, no touching" hook and a full-blown "allow hook writers to
>     easily lie about what happened in the fetch" hook, I was hoping that
>     we would get this right and useful if we were spending our brain
>     bandwidth on it. I am not very fond of an easier "trigger to only
>     notify" hook because people are bound to misuse the interface and
>     try updating the refs anyway, making it easy to introduce
>     inconsistencies between refs and FETCH_HEAD that will confuse the
>     later "merge" step.
>
> Otherwise, if it doesn't require a post-fetch hook, then it would
> require the end-user to first fetch, then run the
> `copy-trusted-refs-over` script, which would add stuff to the user's
> workflow.
>
> Did I miss another possibility?

Yes, the assumption is that there would be a post-fetch hook of some
sort to ferry the refs over from the quarantine.

My reading of that thread is not that Junio's outright against such a
facility (and also it was 2011 and the discussion can be re-visited),
but rather that there's specific concerns that need to be kept in mind
so reliable things involving the ref store don't become brittle as a
result of unstable user hooks, or us offering an interface that's easily
misused.

>> [...]
>>
>> One thing that's not discussed yet, and I know just enough about for it
>> to tingle my spidey sense, but not enough to say for sure (CC'd Jeff &
>> Brandon who know more) is that this feature once shipped might cause
>> higher load on git hosting providers.
>>
>> This is because people will inevitably use it in popular projects for
>> some custom filtering, and because you're continually re-fetching and
>> inspecting stuff what used to be a really cheap no-op "pull" most of the
>> time is a more expensive negotiation every time before the client
>> rejects the refs again, and worse for hosting providers because you have
>> bespoke ref fetching strategies you have less odds of being able to
>> cache both the negotiation and the pack you serve.
>>
>> I.e. you want this for some security feature where 99.99% of the time
>> you accept all refs, but most people will probably use this to implement
>> dynamic Turing-complete refspecs.
>>
>> Maybe that's worrying about nothing, but worth thinking about.
>
> Well... First, I must say I didn't really understand your last paragraph
> about Turing-complete refspecs.
>
> But my understanding of how the fetch-hook patchset I sent this evening
> works is that it first receives all the objects from the hosting
> provider, then locally moves the refs, but never actually discards the
> downloaded objects (well, until a `git gc` I guess).
>
> So I don't think the network traffic with the provider would be any
> different wrt. what it is now, even if a tweak-fetch hook rejects some
> commits? Then again I don't know git's internals enough to be have even
> a bit of certainty about what I'm saying right now, so...
>
>
> [1] https://marc.info/?l=git&m=132480559712592&w=2

As Jeff notes in the side-thread in
<20180209223011.GA24578@sigill.intra.peff.net> when you do a "fetch" the
protocol is not negotiating on the basis of what loose unreferenced
(because you threw away the ref!) objects you have already, but what
the ref commonality is between you and the server (and this is just on
a best-effort basis).

So for example, let's say you only accept the "master" branch and have a
hook that's refusing updates to the "dev" branch, fetch is going to be
re-negotiating fetching the difference between the two over the wire
every time, only to have the hook say "no thanks" and throw away the
result.

I.e. as an extreme example, if the dev branch is adding a 1GB file
divergent from master, you are going to be re-downloading that 1GB every
time you fetch, even though you have that blob locally, the remote can't
know that, and because you have no ref pointing to it you can't mention
it during the negotiation.

Which is way less efficient than the case where your refspec only
fetches "master", since then we won't try at all, or the case where you
fetch both master & dev, but into some quarantine area and are just
deciding to update a local ref or not.

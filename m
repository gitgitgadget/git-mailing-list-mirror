Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C57E1F45F
	for <e@80x24.org>; Mon,  6 May 2019 09:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfEFJoN (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 05:44:13 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34290 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfEFJoN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 05:44:13 -0400
Received: by mail-ed1-f66.google.com with SMTP id w35so12961981edd.1
        for <git@vger.kernel.org>; Mon, 06 May 2019 02:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=lWFycCqpq98sPeSI10ZuBVjIRVJ+St9t+0DTR03Atv0=;
        b=UnOZLoYGEhah35AhhmfmDLKM6o65LFuWpM8XFDmwSXobpnz8OR12Xlc6uMw9H06/Yd
         Yl6EjrTbOzLODvpeqD7aKGILIXOwp7ubc0dPyxEmIHmVemYd6MoxvW+XT9PGuY6GF+2e
         JPvsNoQP44kgDIREdDVVdGuQHPEMC5teMYehmdA3JctRb6yXvBVZ1j/uHAX/2kgKnZZC
         RHIptj1afS2IMqhHKax9nFXjR4ct0H9ACf58/qtKPfnNYtcWYVLvYlbmqCinJmVPbcsH
         klAXrL87nqmBIpF1AITQ7x2gJVMkVGxdkq/Mpgc6bIRgfLWAwb2d6zijnKy1QrRZy+XN
         Yprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=lWFycCqpq98sPeSI10ZuBVjIRVJ+St9t+0DTR03Atv0=;
        b=hgcWnjWpvizHnt6af3Af6RuCEnyh2tRvCoR2FnqKmKMynADJqo2huPkSC0ZJLhx6hX
         lZMTawXpAiDDmsuv7IkVp5xFTTvU1T4Hde7ZH9XnrR9oeHhetfZ2jJfvx6qXLMU9ATof
         kzt+p4Eb5UW3zXcOZ5UwKzwK/LXhMHPnOBCAgXIaAhieznqXZ2z7jHN408pS1JkuGM0o
         LbHXGv0H+VuAYpg/1cIdjcIwyERQMo9yf7HNxKor7WFAK8x3/xlWZfjz/k2dkRXFct9I
         So5p1DScTqEMo2zRCDiL3pK76fMAQ+pNXA9SfeMhaX2Emx6bywBNLGdgGCMPC4w6nZUW
         lhcg==
X-Gm-Message-State: APjAAAXkpJwErCeGMq5MfOhyPeWX354RZGlre/jX1jHO5nC7HiSsJisl
        k0c83RQJC8wMQ33TUaNWcEbjoV0A
X-Google-Smtp-Source: APXvYqwqefdFAwYt/jJrK1n62QltnvwuhLwIdM4fT7f/dYL+bzHgc1FMU1cvcIHybomUhGlG9zg15Q==
X-Received: by 2002:a50:991d:: with SMTP id k29mr23980026edb.29.1557135851162;
        Mon, 06 May 2019 02:44:11 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id l6sm1512560eja.91.2019.05.06.02.44.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 02:44:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: [PATCH 0/4] gc docs: modernize and fix the documentation
References: <20190318161502.7979-1-avarab@gmail.com> <20190318215107.GH29661@sigill.intra.peff.net> <87ftrjer8s.fsf@evledraar.gmail.com> <20190319001829.GL29661@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190319001829.GL29661@sigill.intra.peff.net>
Date:   Mon, 06 May 2019 11:44:06 +0200
Message-ID: <878svjj4t5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 19 2019, Jeff King wrote:

> On Mon, Mar 18, 2019 at 11:45:39PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > I don't think the quarantine stuff should impact contention at all. It=
's
>> > only quarantining the objects, which are the least contentious part of
>> > Git (because object content is idempotent, so we don't do any locking
>> > there, and with two racing processes, one will just "win").
>>
>> Without the quarantine, isn't there the race that the NOTES section
>> talks about (unless I've misread it).
>
> Ah, OK, I wasn't quite sure which documentation you were talking about.
> I see the discussion now in the "NOTES" section of git-gc(1).
>
>> I.e. we have some loose object "ABCD" not referrred to by anything for
>> the last 2 weeks, as we're gc-ing a ref update comes in that makes it
>> referenced again. We then delete "ABCD" (not used!) at the same time the
>> ref update happens, and get corruption.
>>
>> Whereas the quarantine might work around since the client will have sent
>> ABCD with no reference pointing to it to the server in the temp pack,
>> which we then rename in-place and then update the ref, so we don't care
>> if "ABCD" goes away.
>
> tl;dr I don't think quarantine impacts this, but if you really want gory
> details, read on.
>
> This is a problem with or without the quarantine. It's fundamentally a
> race because we do not atomically say "is anybody using X? If not, we
> can delete it" and some other process saying "I'd like to use X".
>
> Pushes are actually better off than most operations, because we only
> advertise what's reachable, and the client is expected to send
> everything else. So with just a normal update-ref call, we could race
> like this:
>
>   1. ABCD is ancient.
>
>   2. Process 1 (update-ref) wants to reference ABCD. It sees that we
>      have it.
>
>   3. Process 2 (gc/prune) sees that nobody references it. It deletes
>      ABCD.
>
>   4. Process 1 writes out the reference.
>
> That doesn't happen with a push, because the server never would have
> told the client that it has ABCD in the first place (so process 1 here
> is the client). That is true with or without quarantine.
>
> But pushes aren't foolproof either. You said "loose object ABCD not
> referred t oby anything for the last 2 weeks". But that's not exactly
> how it works. It's "object with an mtime of more than 2 weeks which is
> not currently referenced". So imagine a sequence like:
>
>   1. ABCD is ancient.
>
>   2. refs/heads/foo points to ABCD.
>
>   3. Server receive-pack advertises foo pointing to ABCD.
>
>   4. Simultaneous process on the server deletes refs/heads/foo (or
>      perhaps somebody force-pushes over it).
>
>   5. Client prepares and sends pack without ABCD.
>
>   6. Server receive-pack checks that yes, we still have ABCD (i.e., the
>      usual connectivity check).
>
>   7. Server gc drops ABCD, which is now unreachable (reflogs can help
>      here, if you've enabled them; but we do delete reflogs when the
>      branch is deleted).
>
>   8. Server receive-pack writes corrupt repo mentioning ABCD.
>
> That's a lot more steps, though they might not be as implausible as you
> think (e.g., consider moving "refs/heads/foo" to "refs/heads/bar" in a
> single push; that's actually a delete and an update, which is all you
> need to race with a simultaneous gc).
>
> I have no idea how often this happens in practice. My subjective
> recollection is that most of the race corruptions I've seen were from
> local operations on the server. E.g., we compute a tentative merge for
> somebody's pull request which shares objects with an older tentative
> merge. They click the "merge" button and we reference that commit, which
> is recent, but unbeknownst to us, while we were creating our new
> tentative merge, a "gc" was deleting the old one.
>
> We're sometimes saved by the "transitive freshness" rules in d3038d22f9
> (prune: keep objects reachable from recent objects, 2014-10-15).  But
> they're far from perfect:
>
>  - some operations (like the push rename example) aren't writing new
>    objects, so the ref write _is_ the moment that gc would find out
>    something is reachable
>
>  - the "is it reachable?" and "no, then delete it" steps aren't atomic.
>    Unless you want a whole-repo stop-the-world lock, somebody can
>    reference the object in between. And since it may take many seconds
>    to compute reachability, stop-the-world is not great.
>
> I think there are probably ways to make it better. Perhaps some kind of
> lockless delete-but-be-able-to-rollback scheme (but keep in mind this
> has to be implemented no top of POSIX filesystem semantics). Or even
> just a "compute reachability, mark for deletion, and then hold a
> stop-the-world lock briefly to double-check that our reachability is
> still up to date".
>
> At least those seem plausible to me. I've never worked out the details,
> and our solution was to just stop deleting objects during routine
> maintenance (using "repack -adk"). We do still occasionally prune
> manually (e.g., when somebody writes to support to remove a confidential
> mistake).
>
> Anyway, that was more than you probably wanted to know. The short of it
> is that I don't think quarantines help (they may even make things worse
> by slightly increasing the length of the race window, though in practice
> I doubt it).
>
>> Unless that interacts racily with the receive.unpackLimit, but then I
>> have no idea that section is trying to say...
>
> No, I don't think unpackLimit really affects it much either way.
>
>> Also, surely the part where "NOTES" says something to the effect of "you
>> are subject to races unless gc.auto=3D0" is wrong. To the extent that
>> there's races it won't matter that you invoke "git gc" or "git gc
>> --auto", it's the concurrency that matters. So if there's still races we
>> should be saying the repo needs to be locked for writes for the duration
>> of the "gc".
>
> Correct. It's the very act of pruning that is problematic. I think the
> point is that if you are manually running "git gc", you'd presumably do
> it at a time when the repository is not otherwise active.

Thanks for that E-Mail. I'm hoping to get around to another set of "gc
doc" updates and will hopefully be able to steal liberally from it.

Maybe there's some case I haven't thought of that makes this stupid, but
I wonder if something like a "gc quarantine" might be a fix fo both of
the the issues you noted above.

I.e. it seems to me that the main issue is that we conflate "mtime 2
weeks old because it's unreferenced for 2 weeks" v.s. "mtime 2 weeks old
because we haven't gotten around to a 'gc'".

So in such a "gc quarantine" mode when we discover an object/pack that's
unreachable/purely made up of unreachable objects we'd move the relevant
loose object/"loose" pack to such a quarantine, which would just be
.git/unreferenced-objects/{??,pack}/ or whatever.

AFAICT both cases you mentioned above would be mitigated by this because
we'd no longer conflate "haven't gc'd this yet and it's 2 weeks old"
v.s. "hasn't been referenced in 2 weeks".

I started looking at this initially because I was wondering if the
--keep-unreachable mode you modified in e26a8c4721 ("repack: extend
--keep-unreachable to loose objects", 2016-06-13) could be made to write
out such "unreferenced" objects into their *own* pack, so we could
delete them all at once as a batch, and wouldn't create the "ref
explosions" mentioned in [1].

But of course without an accompanying quarantine described above doing
that would just make this race condition worse.

1. https://public-inbox.org/git/87fu6bmr0j.fsf@evledraar.gmail.com/

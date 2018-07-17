Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E0D01F597
	for <e@80x24.org>; Tue, 17 Jul 2018 15:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbeGQP6D (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 11:58:03 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:47039 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbeGQP6D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 11:58:03 -0400
Received: by mail-ed1-f65.google.com with SMTP id o8-v6so1534957edt.13
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 08:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=YOsxsI8YVgxtYylW+VPR6Nusq6/Mmwt6iVrFhuJa12M=;
        b=eIXV7Be3UNIbtvEeE+U05KaOGYQadyuoxK1B13arpnPImEWwCwtjGLwtrE+uJOwiYX
         0Thi6auXuwvcoIhzDxz98xHYChnDlFGqUqQlMJz99+uCgFzkMBp+9+BgQdfse68R8/Ro
         oZ2IxHItv9q/wdGyTHohZ8GJkXEYnVNThaN34xdURnFify1He/9oKy1Z3STpRAxUQRI/
         Z4YXElE5t7+nrYOsEYJZfsGWCYN5wn2dqs/yPOp9OqUtX3E+1z9A48gg/aGFPVQ8Bkpv
         9DsNLBVgenrwnKpfNvgL3WBLWxOiorC6+qOiCpMKEgj+K2olEUPrutI5u4mGJfs8HZaJ
         apyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=YOsxsI8YVgxtYylW+VPR6Nusq6/Mmwt6iVrFhuJa12M=;
        b=GMGYc/waVe1bbLn9kc6fItGTNBEf8bK3DN5TEnmhYMIq6R5CWzTaanCuT5HoMvQ1ev
         WtCctqGgicn9VUWurETRteCQ1RRnk4EbgNUfC6NIlkAhWuthQYEybfVEQfPOE2X9DPhx
         aeqYMDHaPOwmr2HK26qpl4N1rdKy4X876Vx5bZnc27p9MbmJ2YyK6WN9RubsSRzDF874
         PAWaOphyljF0QUCMnS7M2tdKA0Li+/BRFybUPWjbEA4MDScmvcU77G7GsEPZJ+7Bfz68
         0UjsqXGqH7aF/1Ou+/RNlNShWVmB5CHXwxxsd++UDAHvOfvwW1Y+GNwg9MysGd9dQMvy
         FppQ==
X-Gm-Message-State: AOUpUlGukJcxMkhsBXvyTEXLvnEM25IYybvwDVUCqTdxyMUjMQpWjW3v
        NFpu1vQf97k8+P/7liJyT1s=
X-Google-Smtp-Source: AAOMgpfFMFMk4qr5ziB3NZfSKZQmgDNOeHVF7jB4Q2s2akcTq+YcSML5QIZO20RsFe4YP5wXpYbsXA==
X-Received: by 2002:aa7:c2c1:: with SMTP id m1-v6mr3057818edp.249.1531841092625;
        Tue, 17 Jul 2018 08:24:52 -0700 (PDT)
Received: from evledraar ([5.57.21.50])
        by smtp.gmail.com with ESMTPSA id 8-v6sm507429edv.77.2018.07.17.08.24.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 08:24:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>,
        git@vger.kernel.org, Andrii Dehtiarov <adehtiarov@google.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] gc: do not warn about too many loose objects
References: <20180716203753.GE11513@aiede.svl.corp.google.com>
        <20180716210938.GF25189@sigill.intra.peff.net>
        <20180716214003.GH11513@aiede.svl.corp.google.com>
        <20180716214539.GL25189@sigill.intra.peff.net>
        <20180716220306.GI11513@aiede.svl.corp.google.com>
        <20180716224337.GB12482@sigill.intra.peff.net>
        <20180716225639.GK11513@aiede.svl.corp.google.com>
        <20180716232603.GB13570@sigill.intra.peff.net>
        <20180717015339.GL11513@aiede.svl.corp.google.com>
        <87d0vmck55.fsf@evledraar.gmail.com>
        <20180717140336.GA229988@aiede.svl.corp.google.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180717140336.GA229988@aiede.svl.corp.google.com>
Date:   Tue, 17 Jul 2018 17:24:50 +0200
Message-ID: <878t69dgvx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 17 2018, Jonathan Nieder wrote:

> Hi Ævar,
>
> Ævar Arnfjörð Bjarmason wrote:
>> On Tue, Jul 17 2018, Jonathan Nieder wrote:
>
>>> That suggests a possible improvement.  If all callers should be
>>> ignoring the exit code, can we make the exit code in daemonize mode
>>> unconditionally zero in this kind of case?
>>
>> That doesn't make sense to me. Just because git itself is happily
>> ignoring the exit code I don't think that should mean there shouldn't be
>> a meaningful exit code. Why don't you just ignore the exit code in the
>> repo tool as well?
>
> I don't maintain the repo tool.  I am just trying to improve git to
> make some users' lives better.
>
> repo worked fine for years, until gc's daemonized mode broke it.  I
> don't think it makes sense for us to declare that it has been holding
> git gc wrong for all that time before then.

Before the sequence of commits noted at the bottom of my
https://public-inbox.org/git/87inc89j38.fsf@evledraar.gmail.com/ plus
a831c06a2b ("gc: ignore old gc.log files", 2017-02-10) we wouldn't do
that, that's true.

We'd just happily run GC again pointlessly even though it wasn't going
to accomplish anything, in cases where you really did have ~>6700 loose
objects that weren't going to be pruned.

I don't think it makes sense to revert those patches and go back to the
much more naïve (and user waiting there twiddling his thumbs while it
runs) method, but I also don't think making no distinction between the
following states:

 1. gc --auto has nothing to do
 2. gc --auto has something to do, will fork and try to do it
 3. gc --auto has something to do, but notices that gc has been failing
    before and can't do anything now.

I think #3 should exit with non-zero.

Yes, before this whole backgrounding etc. we wouldn't have exited with
non-zero either, we'd just print a thing to STDERR.

But with backgrounding we implicitly introduced a new state, which is we
won't do *any* maintenance at all, including consolidating packfiles
(very important for servers), so I think it makes sense to exit with
non-zero since gc can't run at all.

>> Now e.g. automation I have to see if git-gc ---auto is having issues
>> can't just be 'git gc --auto || echo fail @ {hostname}' across a fleet
>> of servers, but will need to start caring if stderr was emitted to.
>
> Thanks for bringing this up.  The thing is, the current exit code is
> not useful for that purpose.  It doesn't report a failure until the
> *next* `git gc --auto` run, when it is too late to be useful.
>
> See the commit message on the proposed patch
> https://public-inbox.org/git/20180717065740.GD177907@aiede.svl.corp.google.com/
> for more on that subject.

Right. I know. What I mean is now I can (and do) use it to run 'git gc
--auto' across our server fleet and see whether I have any of #3, or
whether it's all #1 or #2. If there's nothing to do in #1 that's fine,
and it just so happens that I'll run gc due to #2 that's also fine, but
I'd like to see if gc really is stuck.

This of course relies on them having other users / scripts doing normal
git commands which would trigger previous 'git gc --auto' runs.

>> I don't care if we e.g. have a 'git gc --auto --exit-code' similar to
>> what git-diff does, but it doesn't make sense to me that we *know* we
>> can't background the gc due to a previous error and then always return
>> 0. Having to parse STDERR to see if it *really* failed is un-unixy,
>> let's use exit codes. That's what they're for.
>
> Do you know of anyone trying to use the exit code from gc --auto in
> this way?
>
> It sounds to me like for what you're proposing, a separate
>
> 	git gc --auto --last-run-failed
>
> command that a tool could use to check the outcome from the previous
> gc --auto run without triggering a new one would be best.

Yeah this is admittedly a bit of a poweruser thing I'm doing, so I don't
mind if it's hidden behind something like that in principle, but it
seems wrong to exit with zero in this (#3) case:

    $ git gc --auto; echo $?
    Auto packing the repository in background for optimum performance.
    See "git help gc" for manual housekeeping.
    error: The last gc run reported the following. Please correct the root cause
    and remove .git/gc.log.
    Automatic cleanup will not be performed until the file is removed.

    warning: There are too many unreachable loose objects; run 'git prune' to remove them.

    255

As a previous (good) patch in this series notes that shouldn't be 255,
let's fix that, but I don't see how emitting an "error" and "warning"
saying we're broken and can't gc at all here in conjunction with exiting
with zero makes sense.

> [...]
>> I think you're conflating two things here in a way that (if I'm reading
>> this correctly) produces a pretty bad regression for users.
>
> The patch doesn't touch the "ratelimiting" behavior at all, so I'm not
> sure what I'm doing to regress users.

Sorry about being unclear again, this is not a comment on this patch,
but your paragraph beginning with "To solve[...]", i.e. "this patch
doesn't do X, but in the future maybe we'll...". I'm pointing out
potential caveats with that, I realize you have not posted an
implementation of that yet.

> [...]
>>> To solve (3), we could
>>> introduce a gc.lastrun file that is touched whenever "gc --auto" runs
>>> successfully and make "gc --auto" a no-op for a while after each run.
>>
>> This would work around my concern with b) above in most cases by
>> introducing a purely time-based rate limit, but I'm uneasy about this
>> change in git-gc semantics.
> [..]
>> With these proposed semantics we'd skip a needed GC (potentially for
>> days, depending on the default) just because we recently ran one.
>>
>> In many environments, such as on busy servers, we could have tens of
>> thousands of packs by this point, since this facility would (presumably)
>> bypass both gc.autoPackLimit and gc.auto in favor of only running gc at
>> a maximum of every N minutes, similarly in a local checkout I could have
>> a crapload of loose objects because I ran a big rebase or a
>> filter-branch on one of my branches.
>
> I think we all agree that getting rid of the hack that 'explodes'
> unreachable objects into loose objects is the best way forward, long
> term.
>
> Even in that future, some ratelimiting may be useful, though.  I also
> suspect that we're never going to achieve a perfect set of defaults
> that works well for both humans and servers, though we can try.

Having read this whole thing over again, and with some time to reflect
on it, I think the best way forward for now, in lieu of the bigger
solution of consolidating loose objects into a pack, is to split up this
special case of warning due to too many loose objects at the end, and
any other errors we may print during GC.

As noted above if our policy for gc.auto is legitimately exceeded, we
deal with that badly by stopping all gc, includin gc that would just run
due to too_many_packs().

Instead we should note that we had an error due to too many loose
objects last time, but still try to run if the too_many_packs()
condition is satisfied.

Now we're throwing the baby out with the bathwater and not consolidating
packs (for a default period of 2 weeks!) just because some operation
produced a lot of loose objects, and not writing bitmaps, commit graph
etc.

It would also be nice to expose via an exit code "do we need to gc?" and
"is gc failing here?" separately from the (currently working) "run gc or
report last error + code" mode we have with "gc --auto".

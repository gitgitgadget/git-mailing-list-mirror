Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 100C11F453
	for <e@80x24.org>; Mon, 29 Oct 2018 19:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbeJ3E0S (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 00:26:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41735 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeJ3E0S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 00:26:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id x12-v6so9998560wrw.8
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 12:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=X4IFkKL+mm+coDTdduKR35/Ifsv098b0SqZModA8pGw=;
        b=HoMlsFZjlPbEfOj2TJ6u0uqTl4hJ7CnyVx2BZauycedejwC4sG9qeGbNI7q1ai+4Os
         7wHKXyJecmhj1zLU3uQvfWx63Wz255HrADQpYcfUUZgRS9NQ6w0+z0S5EFuQ++E57N/m
         XemM7HSwctOZ5nZke+J47qvSfubWzu5Z+GeWgmXLxvi/I4s6lfGHJMNGpxbGxBLZFg6p
         /Ys9fSpHyfaEonLta75VDebCuY7vYk+7AGtVOl2Good6UB5Sb6saJ5uWCTxVGp9Bu8aa
         +OkIxYnyjbqCTDLHpZQdMCnDWfuE41FyyMCpYD9vjLZasRl+McI2cmtchnU5ykBXw9Tg
         xcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=X4IFkKL+mm+coDTdduKR35/Ifsv098b0SqZModA8pGw=;
        b=tfyuXP3Zg5Takkh+OCqlFU20rkiQYitDyvr+SDxOLy9PdOb8dazNwUvr3ujDOMfnuY
         ujNscKpiDvBmtWSMuNx92R3Y6hMw8m46WllghY9TeDNi0jv+MH/HPHWu1edtSZJ+Atsv
         wzAUeyYa9gP5XGD0IGhayooAu0R/2mNJRXchjyM1GctmCbKXhif1QugkuzMSoqo7Wfgf
         TohNNZocXNAIO2ifOnP4EkTwDHeUfdvNzwjKuSYGDdvUKmcSjr/MvpbVRia7XWlfTUV+
         PNCPtl/gGUV36j1YxkvnuPHRmyY3emksAIb/NUYeOi7a5/O31B9DeNjg7ySKFMTDEPtN
         MK2w==
X-Gm-Message-State: AGRZ1gIaeuo3PwYLxPzcatsQzYd2ewwnQOTMsYq1AtQE7IYwrGODzyFi
        mWV0cmQismh5TIr/XL0wNtc=
X-Google-Smtp-Source: AJdET5dXK8jb8U0tZPk8Oe1kE1JEgrFcl5LF9PkHicu9S3MwbsdbaDK01U1iBvF7apnJQbPBdUxWAw==
X-Received: by 2002:a5d:46ce:: with SMTP id g14-v6mr15456489wrs.263.1540841770646;
        Mon, 29 Oct 2018 12:36:10 -0700 (PDT)
Received: from evledraar ([2a02:a450:3911:1:fd59:dbfe:7c38:41f0])
        by smtp.gmail.com with ESMTPSA id l4-v6sm33362309wrb.92.2018.10.29.12.36.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 12:36:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Jansen\, Geert" <gerardu@amazon.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] index-pack: improve performance on NFS
References: <ED25E182-C296-4D08-8170-340567D8964A@amazon.com>
        <xmqqk1m5ftgj.fsf@gitster-ct.c.googlers.com>
        <87o9bgl9yl.fsf@evledraar.gmail.com>
        <xmqq1s8bc0jp.fsf@gitster-ct.c.googlers.com>
        <20181027093300.GA23974@sigill.intra.peff.net>
        <87lg6jljmf.fsf@evledraar.gmail.com>
        <20181029150453.GH17668@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181029150453.GH17668@sigill.intra.peff.net>
Date:   Mon, 29 Oct 2018 20:36:07 +0100
Message-ID: <87bm7clf4o.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 29 2018, Jeff King wrote:

> On Sat, Oct 27, 2018 at 01:22:16PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
>> > Taking one step back, the root problem in this thread is that stat() on
>> > non-existing files is slow (which makes has_sha1_file slow).
>> >
>> > One solution there is to cache the results of looking in .git/objects
>> > (or any alternate object store) for loose files. And indeed, this whole
>> > scheme is just a specialized form of that: it's a flag to say "hey, we
>> > do not have any objects yet, so do not bother looking".
>> >
>> > Could we implement that in a more direct and central way? And could we
>> > implement it in a way that catches more cases? E.g., if I have _one_
>> > object, that defeats this specialized optimization, but it is probably
>> > still beneficial to cache that knowledge (and the reasonable cutoff is
>> > probably not 1, but some value of N loose objects).
>> [...]
>>
>> The assumption with making it exactly 0 objects and not any value of >0
>> is that we can safely assume that a "clone" or initial "fetch"[1] is
>> special in ways that a clone isn't. I.e. we're starting out with nothing
>> and doing the initial population, that's probably not as true in an
>> existing repo that's getting concurrent fetches, commits, rebases etc.
>
> I assume you mean s/that a clone isn't/that a fetch isn't/.

Yes, sorry.

> I agree there are cases where you might be able to go further if you
> assume a full "0". But my point is that "clone" is an ambiguous concept,
> and it doesn't map completely to what's actually slow here. So if you
> only look at "are we cloning", then:
>
>   - you have a bunch of cases which are "clones", but aren't actually
>     starting from scratch
>
>   - you get zero benefit in the non-clone cases, when we could be
>     scaling the benefit smoothly

Indeed. It's not special in principle, but I think in practice the
biggest wins are in the clone case, and unlike "fetch" we can safely
assume we're free of race conditions. More on that below.

>> But in the spirit of taking a step back, maybe we should take two steps
>> back and consider why we're doing this at all.
>
> OK, I think it's worth discussing, and I'll do that below. But first I
> want to say...
>
>> Three of our tests fail if we compile git like this, and cloning is much
>> faster (especially on NFS):
>>
>>     diff --git a/builtin/index-pack.c b/builtin/index-pack.c
>>     index 2004e25da2..0c2d008ee0 100644
>>     --- a/builtin/index-pack.c
>>     +++ b/builtin/index-pack.c
>>     @@ -796,3 +796,3 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
>>
>>     -       if (startup_info->have_repository) {
>>     +       if (0) {
>>                     read_lock();
>>
>> Even on a local disk I'm doing 262759 lstat() calls cloning git.git and
>> spending 5% of my time on that.
>
> With the caching patch I posted earlier, I see roughly the same speedup
> on an index-pack of git.git as I do with disabling the collision check
> entirely (I did see about a 1% difference in favor of what you wrote
> above, which was within the noise, but may well be valid due to slightly
> reduced lock contention).
>
> TBH I'm not sure if any of this is actually worth caring about on a
> normal Linux system, though. There stat() is fast. It might be much more
> interesting on macOS or Windows, or on a Linux system on NFS.

It matters a *lot* on NFS as my performance numbers in
https://public-inbox.org/git/87d0rslhkl.fsf@evledraar.gmail.com/ show.

>> But why do we have this in the first place? It's because of 8685da4256
>> ("don't ever allow SHA1 collisions to exist by fetching a pack",
>> 2007-03-20) and your 51054177b3 ("index-pack: detect local corruption in
>> collision check", 2017-04-01).
>>
>> I.e. we are worried about (and those tests check for):
>>
>>  a) A malicious user trying to give us repository where they have
>>     created an object with the same SHA-1 that's different, as in the
>>     SHAttered attack.
>>
>>     I remember (but have not dug up) an old E-Mail from Linus saying
>>     that this was an important security aspect of git, i.e. even if
>>     SHA-1 was broken you couldn't easily propagate bad objects.
>
> Yeah, especially given recent advances in SHA-1 attacks, I'm not super
> comfortable with the idea of disabling the duplicate-object check at
> this point.

I'd be comfortable with it in my setup since it's been limited to
collision attacks that are computationally prohibitive, and there being
no sign of preimage attacks, which is the case we really need to worry
about.

>>  b) Cases where we've ended up with different content for a SHA-1 due to
>>     e.g. a local FS corruption. Which is the subject of your commit in
>>     2017.
>
> Sort of. We actually detected it before my patch, but we just gave a
> really crappy error message. ;)
>
>>  c) Are there cases where fetch.fsckObjects is off and we just flip a
>>     bit on the wire and don't notice? I think not because we always
>>     check the pack checksum (don't we), but I'm not 100% sure.
>
> We'd detect bit-blips on the wire due to the pack checksum. But what's
> more interesting are bit-flips on the disk of the sender, which would
> then put the bogus data into the pack checksum they generate on the fly.
>
> However, we do detect such a bit-flip, even without fsckObjects, because
> the sender does not tell us the expected sha-1 of each object. It gives
> us a stream of objects, and the receiver computes the sha-1's
> themselves. So a bit flip manifests in the connectivity-check when we
> say "hey, the other side should have sent us object X but did not" (we
> do not say "gee, what is this object Y they sent?" because after not
> seeing X, we do not know which objects would have been reachable, so we
> have a whole bunch of such Y's).
>
> fetch.fsckObjects is purely about doing semantic object-quality checks.
> They're not even that expensive to do. The main reason they're disabled
> is that there are many historical objects floating around that fail
> them (I think it would be a useful exercise to sort the existing checks
> by priority, downgrading many of them to warnings, and then setting the
> default for fetch.fsckObjects to "reject anything above warning").

Thanks, that's really informative & useful.

>> Even if someone wants to make the argument that this is behavior that we
>> absolutely *MUST* keep and not make configurable, there's still much
>> smarter ways to do it.
>
> I don't have any real object to a configuration like this, if people
> want to experiment with it. But in contrast, the patch I showed earlier:
>
>   - is safe enough to just turn on all the time, without the user having
>     to configure anything nor make a safety tradeoff

I think it's a useful patch to carry forward, and agree that it should
be turned on by default.

It does introduce a race condition where you can introduce a colliding
object to the repository by doing two concurrent pushes, but as you note
in
https://public-inbox.org/git/20181029151842.GJ17668@sigill.intra.peff.net/
this already applies to packs, so you can trigger that with the right
sized push (depending on transfer.unpackLimit), and we also have this in
existing forms for other stuff.

I do think it's amazingly paranoid to be worried about SHA-1 collisions
in the first place, and a bit odd to leave the door open on these race
conditions. I.e. it's hard to imagine a state-level[1] actor with
sufficient motivation to exploit this who wouldn't find some way to make
the race condition work as an escape hatch.

I admit just leaving that race condition does close a lot of doors
entirely. I.e. you could sometimes trigger a collision but wouldn't have
the right conditions to exploit the race condition.

>   - speeds up all the other spots that use OBJECT_INFO_QUICK (like
>     fetch's tag-following, or what appears to be the exact same
>     optimization done manually inside mark_complete_and_common-ref()).

We also pay a constant cost of doing an opendir() / readdir() on however
many loose objects we have for every push on the server-side. While it's
not as bad as stat() in a loop that's also quite slow on NFS.

In a busy repo that gets a lot of branches / branch deletions (so not
quite as extreme as [2], but close) and the default expiry policy you
can easily have 20-100K loose objects (something near the lower bound of
that is the current live state of one server I'm looking at).

A recursive opendir()/readdir() on that on local disk is really fast if
it's in cache, but can easily be 1-5 seconds on NFS. So for a push we'd
now pay up to 5s just populating a cache we'll bearly use to accept some
tiny push with just a few objects.

I also found when writing "index-pack: add ability to disable SHA-1
collision check" that it's really handy to recover from some forms of
repo corruption, so I've documented that. So aside from the performance
case it's a useful knob to have.

So what I'll do is:

 * Re-roll my 4 patch series to include the patch you have in
   <20181027093300.GA23974@sigill.intra.peff.net>

 * Turn that behavior on by default, but have some knob to toggle it
   off, because as noted above on some performance sensitive NFS cases
   I'd really like to not have the cache *AND* not have the collision
   check, performance will suffer with the cache.

>> We could e.g. just unconditionally write out the packfile into a
>> quarantine environment (see 720dae5a19 ("config doc: elaborate on
>> fetch.fsckObjects security", 2018-07-27)), *then* loop over the loose
>> objects and packs we have and see if any of those exist in the new pack,
>> if they do, do the current assertion, and if not (and fetch.fsckObjects
>> passes) move it out of the quarantine.
>
> Yes, I agree that would work, though it's a bigger architecture change.

1. "state-level" because even though Google's collision cost ~$100k
   we're talking about a *much* harder problem in practice of doing
   something useful. E.g. replacing git.c with an actual exploit, not
   just two cute specially crafted PDFs.

2. https://public-inbox.org/git/87fu6bmr0j.fsf@evledraar.gmail.com/

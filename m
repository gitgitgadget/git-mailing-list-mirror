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
	by dcvr.yhbt.net (Postfix) with ESMTP id B530020248
	for <e@80x24.org>; Wed, 27 Mar 2019 15:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfC0Pjz (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 11:39:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38423 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbfC0Pjy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 11:39:54 -0400
Received: by mail-wm1-f65.google.com with SMTP id w15so563445wmc.3
        for <git@vger.kernel.org>; Wed, 27 Mar 2019 08:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=sk+MBAdl7feS96ZuS+GBTdHjW6ept9H6Wwu2yKJ7HjA=;
        b=e7TcwQAOEhgS6HoD0A6297uw7iU7jTCdUBFA/df3xwwjFm+GPAmhTEpGUvwT0H6Z5Y
         G2JTlpWeNC7Hbv0o7KPfqkeKkf7/1XVlaKRNz/EPabj50ruddOWw/q0tbXmDj+p0Aeme
         JzP2DiurlsXrrZlxKHK3VaMk3F1/p4k7TxQZVzvwZ9KRlARUYV4ZiKvfwWipgnIwgND+
         yVDOlITOd26azkilNM5AgdI1iR9MNplsDSXnYWDRlZVVhuChUOZcApmOmURRgF5KpJeS
         Wweohb9NmMN5UW5W8gjZAM2Kv0rGZjjAQ5jPBDS69uS2HKLnPw9s5TydLMru9DJeKbln
         7chg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=sk+MBAdl7feS96ZuS+GBTdHjW6ept9H6Wwu2yKJ7HjA=;
        b=ZTMCJ1WJnhFagx07r0v6H/78AY3G7JKmglkZBg0tS7kUxg2auWctheG/24pWjj1omb
         qKgrgLMJ1cayAUs/IMhWBADmfXhhEdNT+HfR94SFuKLEX0s5YYbkjpP429oWVMEFPZEc
         H0SIm9CpUusYTWBdN7krbUe7DWj0W4cpzPNSJUe+JjhRmgyBwrOfmvNFgyTs8ZSAD5tS
         WEc7r+GYJL2jpZ3Mzw3t03QghzBqkXWb8nvRfxse8L1+UhFWwsc5Tcr0oX8+wEz3Fjx2
         UkKzMmo3Cd/qyk9FO01PtrN/kkIhg5XAE12gGeyB3DuIlcQvp+3c92Zn/uYGdgaTJt/y
         zeZg==
X-Gm-Message-State: APjAAAUeOEku/acjcnDwYMOT20jeB04apV+dLaJC/LnZ5IogHbRTJsKm
        HoR3dc4wqf8rHLw99UhReEM=
X-Google-Smtp-Source: APXvYqxwgbVH9/tNH7+GQzdIIG6Xuh9RV+OSV+KIKieg8//yTQD0ay+eZfvrs2Sb6sHLuHsGR4wxNg==
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr18564448wmk.114.1553701191888;
        Wed, 27 Mar 2019 08:39:51 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id p6sm6104025wrt.4.2019.03.27.08.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 08:39:51 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] rebase: learn --keep-base
References: <cover.1553354374.git.liu.denton@gmail.com> <87bm1xbt55.fsf@evledraar.gmail.com> <20190326175052.GA14922@dev-l> <878sx1bcgr.fsf@evledraar.gmail.com> <20190326213031.GA21504@dev-l>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190326213031.GA21504@dev-l>
Date:   Wed, 27 Mar 2019 16:39:50 +0100
Message-ID: <871s2sba2h.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 26 2019, Denton Liu wrote:

> Hi =C3=86var,
>
> On Tue, Mar 26, 2019 at 09:35:48PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>
>> On Tue, Mar 26 2019, Denton Liu wrote:
>>
>> > Hi =C3=86var,
>> >
>> > On Tue, Mar 26, 2019 at 03:35:34PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>> >>
>> >> On Sat, Mar 23 2019, Denton Liu wrote:
>> >>
>> >> > This series teaches rebase the --keep-base option.
>> >> >
>> >> > 'git rebase --keep-base <upstream>' is equivalent to
>> >> > 'git rebase --onto <upstream>... <upstream>' or
>> >> > 'git rebase --onto $(git merge-base <upstream> HEAD) <upstream>' .
>> >> >
>> >> > This seems to be a common case that people (including myself!) run =
into; I was
>> >> > able to find these StackOverflow posts about this use case:
>> >> >
>> >> > * https://stackoverflow.com/questions/53234798/can-i-rebase-on-a-br=
anchs-fork-point-without-explicitly-specifying-the-parent
>> >> > * https://stackoverflow.com/questions/41529128/how-do-you-rebase-on=
ly-changes-between-two-branches-into-another-branch
>> >> > * https://stackoverflow.com/a/4207357
>> >>
>> >> Like with another series of yours I think this would be best squashed
>> >> into one patch.
>> >
>> > Will do.
>> >
>> >>
>> >> Maybe I've misunderstood this but isn't this like --fork-point except
>> >> with just plain "git merge-base" instead of "git merge-base
>> >> --fork-point", but then again 2/3 shows multiple base aren't supporte=
d,
>> >> but merge-base supports that.
>> >>
>> >
>> > --fork-point gets used to determine the _set of_ commits which are to =
be
>> > rebased, whereas --keep-base (and --onto) determine the base where that
>> > set of commits will be spliced. As a result, these two options cover
>> > orthogonal use-cases.
>>
>> Right. After playing with this a bit more though --fork-point is mostly
>> there, it it does find the same fork point, as evidenced all your tests
>> (that aren't asserting incompatibility with other options) passing with
>> this:
>>
>>     diff --git a/t/t3416-rebase-onto-threedots.sh b/t/t3416-rebase-onto-=
threedots.sh
>>     index 9c2548423b..ab2d50e69a 100755
>>     --- a/t/t3416-rebase-onto-threedots.sh
>>     +++ b/t/t3416-rebase-onto-threedots.sh
>>     @@ -116,7 +116,7 @@ test_expect_success 'rebase --keep-base master f=
rom topic' '
>>             git checkout topic &&
>>             git reset --hard G &&
>>
>>     -       git rebase --keep-base master &&
>>     +       git rebase $(git merge-base --fork-point master HEAD) &&
>>             git rev-parse C >base.expect &&
>>             git merge-base master HEAD >base.actual &&
>>             test_cmp base.expect base.actual &&
>>     @@ -140,7 +140,7 @@ test_expect_success 'rebase -i --keep-base maste=
r from topic' '
>>             git reset --hard G &&
>>
>>             set_fake_editor &&
>>     -       EXPECT_COUNT=3D2 git rebase -i --keep-base master &&
>>     +       EXPECT_COUNT=3D2 git rebase -i $(git merge-base --fork-point=
 master HEAD) &&
>>             git rev-parse C >base.expect &&
>>             git merge-base master HEAD >base.actual &&
>>             test_cmp base.expect base.actual &&
>>
>> I've poked at some of this recently in
>> https://public-inbox.org/git/20190221214059.9195-3-avarab@gmail.com/ as
>> noted in the feedback there (I haven't gotten around to v2 yet) it's
>> entirely possible that I haven't understood this at all :)
>>
>> But it seems to me that this patch/implementation conflates two
>> unrelated things.
>>
>> Once is that we use --fork-point to mean that we're going to find the
>> divergence point with "merge-base --fork-point". This gets you halfway
>> to where you want to be, i.e. AFAICT the --keep-base and --fork-point
>> will always find the same commit for "git rebase" and "git rebase
>> --keep-base". See the "options.restrict_revision =3D get_fork_point(...)"
>> part of the code.
>
> I don't think this is true. The code that --keep-base uses to find the
> merge base is get_oid_mb, see the relevant snippet
>
> 	if (strstr(options.onto_name, "...")) {
> 		if (get_oid_mb(options.onto_name, &merge_base) < 0)
>
> whereas the --fork-point code uses get_fork_point, as you mentioned
> above. As a result, they don't necessarily refer to the same commit in
> the case where upstream is rewound.
>
>>
>> The other, which you want to disable, is that --fork-point *also* says
>> "OK, once we've found the divergence point, let's then rebase it on the
>> latest upstream. Or in the example above the "master" part of "git
>> merge-base --fork-point master HEAD".
>
> Correct, I guess in essence this is what I'm doing.
>
>>
>> Shouldn't --keep-base just be implemented in terms of skipping *that*
>> part, i.e. we find the fork point using the upstream info, but then
>> don't rebase *on* upstream.
>>
>> The reason the distinction matters is because with your patch these two
>> act differently:
>>
>>     git rebase --keep-base
>>     git rebase $(git merge-base @{u} HEAD)
>>
>> The latter will skip work ("Current branch master is up to date"), but
>> --keep-base will always re-rebase things. There's some cases where
>> --fork-point does that, which I was trying to address with my linked WIP
>> patch above.
>
> I believe this is desired behaviour. Suppose we have this (modified)
> graph from the git-merge-base docs, where B3 was formerly part of
> origin/master but it was then rewound:
>
>            ---o---o---B2--o---o---o---B (origin/master)
>                    \
>                     B3
>                      \
>                       Derived (local master)
>
> If we run "git rebase --keep-base", we'll get the following graph:
>
>            ---o---o---B2--o---o---o---B (origin/master)
>                    \
>                     Derived (local master)
>
> which I believe is the desired behaviour (we're abandoning B3 since
> upstream abandoned it).
>
> I hope I'm understanding you correctly. Please let me know if I've
> misinterpreted anything you've said or if anything I've said is unclear.

Yeah. I'm still confused, but mainly because I haven't allocated enough
brainpower to try to understand it :)

So yeah, I can believe it's subtly different, would be great to have a
v2 whose docs/tests cover those subtleties, right now (as seen in my
discussion upthread) the tests that are there can identically use the
fork point.

I also wonder if we can holistically think about this UI / how we can
expose different things. E.g. for the times I've needed this and have
manually dug up the fork point I haven't wanted to handle the case of
upstream rewinding, just re-rebase-i on some old base, while still
having upstream tracking info, and for rebase to exit early if there's
nothing to do (similar to if I feed it the fork point as a rev).

>>
>> Whereas the thing you actually want to work is:
>>
>>     git rebase -i --keep-base
>>     git rebase -i $(git merge-base @{u} HEAD)
>>
>> I.e. to have both of those allow you to re-arrange/fixup whatever and
>> still rebase on the same divergence point with @{u}, and won't run
>> rebase when there's no work to do unless you give it --force-rebase.
>>
>> > reason that --onto already disallows multiple bases. If we have multip=
le
>> > bases, how do we determine which one is the "true base" to use? It mak=
es
>> > more sense to error out and let the user manually specify it.
>>
>> Ah, makes sense.
>>
>> >> I'd find something like the "DISCUSSION ON FORK-POINT MODE" in
>> >> git-merge-base helpful with examples of what we'd pick in the various
>> >> scenarios, and also if whatever commit this picks was something you
>> >> could have "git merge-base" spew out, so you could get what rebase wo=
uld
>> >> do here from other tooling (which maybe is possible, but I'm confused=
 by
>> >> the "no multiple bases"...).
>> >
>> > If I'm understanding you correctly then yes, this could be done with
>> > other tooling. See the 0/3 for equivalent commands.
>> >
>> > Perhaps I should update the rebase documentation to mention that
>> > --fork-point and --keep-base are orthogonal because it's unclear for
>> > you, it's probably unclear for other users as well.
>> >
>> > Thanks,
>> >
>> > Denton

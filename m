Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90DAC1F462
	for <e@80x24.org>; Thu, 25 Apr 2019 12:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfDYMOt (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 08:14:49 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46104 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfDYMOs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 08:14:48 -0400
Received: by mail-ed1-f67.google.com with SMTP id d1so18913612edd.13
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 05:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=6KepVC311qKrauxfjJQdLHUP/9XX2YkLOwGyHehG4UA=;
        b=dwe1JOxtvrr2c84RUgxWMorWPb+a7xaXbxrWWQa04af0iGVlGTQP2x1yN3X/ROIdCJ
         CzBoTh/7lmIag/vYqfjs+gdOCupdBnWPr7ajFShSoeWQYxG33kGInrSx6uTOESm5hx5v
         zFiqjHo3K5vzVWdZYULXn0CAIokF5312eXorNbY+SJXavCW5WWQpLTiapwU+8b+PijaQ
         PnnaNm6X9Gqugk7rVSUbEtzMZX70/Gh/gz/jkMbLg/1tM6gAW2bZZcWisonWP8cQnBJw
         4XA3XC2lpg88yboCNFMT720u/5BR0Qe3/OraTZLkVNrloNNVsaKVjgZPAIzb+S/cw3kw
         HuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=6KepVC311qKrauxfjJQdLHUP/9XX2YkLOwGyHehG4UA=;
        b=kzegw79fIXs+0b8yQjeGMpmh83vYGObUVtPezmWP3pqz3HbqwzS314Pzb7GEO6Hsq0
         1aLG1G98bY3C8AoU73yUuVSbuOZfh8+TTzJx1x+VXPziZYxpyNNLr6IvB/r1KkWisD68
         fwxc85R5gHW4HabcqHyDrCWwSUH6Av4/Dc/2aCJ04zn4UtLIjQiu8g9V64jK40ogEwxx
         8Pvcq0Xk+5axvUkLeU9acBP6Ev5xZw9d39JuSvfr/HbLMARWiCthHl3vP4vM46BJRo2w
         dwwvOtQqjBwAFKuMHnz0TY0GcuxLXeD64+eyIdHsX0fRrNdQcCVy7lrB6RiBx564WzcV
         pBmQ==
X-Gm-Message-State: APjAAAV1WbfQvOCUAZQxH27nqiULHmem9nI/Sd4LzmCIrvf2FS5Ciw5Y
        cjZYH4c3MmlxdllUD3qbDUg=
X-Google-Smtp-Source: APXvYqw8HB3AQsl1g8bjp4m/Js1F5vjERbbkI93QPS6+3Igd2grAXBlooKHgrbDN/96tTkI351ZBeA==
X-Received: by 2002:a17:906:1811:: with SMTP id v17mr19243791eje.109.1556194486235;
        Thu, 25 Apr 2019 05:14:46 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id q5sm4005088ejm.63.2019.04.25.05.14.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 05:14:44 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eugeniu Rosca <roscaeugeniu@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Julia Lawall <julia.lawall@lip6.fr>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH 2/2] diffcore-pickaxe: add --pickaxe-raw-diff for use with -G
References: <87o94vs9cp.fsf@evledraar.gmail.com> <20190424224539.GA23849@vmlxhi-102.adit-jv.com> <87mukfrnp3.fsf@evledraar.gmail.com> <20190425005448.GA6466@x230>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190425005448.GA6466@x230>
Date:   Thu, 25 Apr 2019 14:14:42 +0200
Message-ID: <87h8ams2ml.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 25 2019, Eugeniu Rosca wrote:

> On Thu, Apr 25, 2019 at 01:24:56AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>
>> On Thu, Apr 25 2019, Eugeniu Rosca wrote:
>>
>> > Hi =C3=86var,
>> >
>> > Thanks for the amazingly fast reply and for the useful feature (yay!).
>> >
>> > On Wed, Apr 24, 2019 at 05:37:10PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>> >>
>> >> On Wed, Apr 24 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> >>
>> >> > Add the ability for the -G<regex> pickaxe to search only through ad=
ded
>> >> > or removed lines in the diff, or even through an arbitrary amount of
>> >> > context lines when combined with -U<n>.
>> >> >
>> >> > This has been requested[1][2] a few times in the past, and isn't
>> >> > currently possible. Instead users need to do -G<regex> and then wri=
te
>> >> > their own post-parsing script to see if the <regex> matched added or
>> >> > removed lines, or both. There was no way to match the adjacent cont=
ext
>> >> > lines other than running and grepping the equivalent of a "log -p -=
U<n>".
>> >> >
>> >> > 1. https://public-inbox.org/git/xmqqwoqrr8y2.fsf@gitster-ct.c.googl=
ers.com/
>> >> > 2. https://public-inbox.org/git/20190424102609.GA19697@vmlxhi-102.a=
dit-jv.com/
>> >>
>> >> I see now once I actually read Eugeniu Rosca's E-Mail upthread instead
>> >> of just knee-jerk sending out patches that this doesn't actually solve
>> >> his particular problem fully.
>> >>
>> >> I.e. if you want some AND/OR matching support this --pickaxe-raw-diff
>> >> won't give you that, but it *does* make it much easier to script up s=
uch
>> >> an option. Run it twice with -G"\+<regex>" and -G"-<regex>", "sort |
>> >> uniq -c" the commit list, and see which things occur once or twice.
>> >>
>> >> Of course that doesn't give you more complex nested and/or cases, but=
 if
>> >> git-log grew support for that like git-grep has the -G option could u=
se
>> >> that, although at that point we'd probably want to spend effort on
>> >> making the underlying machinery smarter to avoid duplicate work.
>> >
>> > Purely from user's standpoint, I feel more comfortable with `git grep`
>> > and `git log --grep` particularly b/c they support '--all-match' [2],
>> > allowing more flexible multi-line searches. Based on your feedback, it
>> > looks to me that `git log -G/-S` did not have a chance to develop their
>> > features to the same level.
>> >
>> >>
>> >> Furthermore, and quoting Eugeniu upthread:
>> >>
>> >>     In the context of [1], I would like to find all Linux commits whi=
ch
>> >>     replaced:
>> >>     	'devm_request_threaded_irq(* IRQF_SHARED *)'
>> >>     by:
>> >>     	'devm_request_threaded_irq(* IRQF_ONESHOT *)'
>> >>
>> >> Such AND/OR machinery would give you what you wanted *most* of the ti=
me,
>> >> but it would also find removed/added pairs that were "unrelated" as w=
ell
>> >> as "related". Solving *that* problem is more complex, but something t=
he
>> >> diff machinery could in principle expose.
>> >
>> > I expect some false positives, since git is agnostic on the language
>> > used to write the versioned files (the latter sounds like a research
>> > topic to me - I hope there is somebody willing to experiment with that
>> > in future).
>>
>> I was thinking of something where the added/removed could be filtered to
>> cases that occur in the same diff hunk.
>>
>> >>
>> >> But the "-G<regex> --pickaxe-raw-diff" feature I have as-is is very
>> >> useful,
>> >
>> > I agree. I am a bit bothered by the fact that
>> > `git log --oneline -Ux -G<regex> --pickaxe-raw-diff` outputs the
>> > contents/patch of a commit. My expectation is that we have the
>> > `log -p` knob for that?
>>
>> This is unrelated to --pickaxe-raw-diff, -U<n> just implies -p in
>> general. See e.g. "git log -U1".
>
> Oops. Since I use `-U<n>` mostly with `git show`, I missed the
> implication. You are right. Then, my question is how users are
> going to (quote from commit description):
>
>> >> > [..] search [..] through an arbitrary amount of
>> >> > context lines when combined with -U<n>.
>
> and achieve a `git log --oneline` report, given that -U<n> unfolds
> the commits?
>
> FTR, based on my quick experiments, --pickaxe-raw-diff does process
> several lines of context by default (it appears to default to -U3).

Yeah I should document this explicitly. We use the default diff context
so if you just -G'foo.*bar' you'll find things in the 6x lines of
context (3 before / 3 after), not just the "-" and "+" lines.

It's a "feature", but we should be really clear about it, i.e. you need
to anchor with "^[+-]" if you want the same thing that -G does for you
now.

I *do* find the default semantics really useful. Sometimes you can use
-L, but I've often done manual greps with -U<n> for "let's find code
changes anywhere in the project near places where we use some API",
maybe we should pick -U0 with --pickaxe-raw-diff by default to avoid
*that* particular surprise by default, but I think that would be even
more confusing...

>>
>> >> I've had at least two people off-list ask me about a problem
>> >> that would be solved by it just in the last 1/2 year (unrelated to th=
em
>> >> having seen the WIP patch I sent last October).
>> >>
>> >> It's more general than Junio's suggested --pickaxe-ignore-{add,del}
>> >
>> > As a user, I would be happier to freely grep in the raw commit contents
>> > rather than learning a dozen of new options which provide small subsets
>> > of the same functionality. So, I personally vote for the approach taken
>> > by --pickaxe-raw-diff. This would also reduce the complexity of my
>> > current git aliases and/or allow dropping some of them altogether.
>> >
>> > Quite off topic, but I also needed to come up with a solution to get
>> > the C functions modified/touched by a git commit [3]. It is my
>> > understanding that --pickaxe-raw-diff can't help here and I still have
>> > to rely on parsing the output of `git log -p`?
>>
>> Yeah, it doesn't help with that. When it runs we haven't generated the
>> context line or the "@@" line yet, that's later. You can breakpoint on
>> xdl_format_hunk_hdr and diffgrep_consume to see it in action.
>>
>> It's a waste of CPU to generate that for all possible hunks, most of
>> which we won't show at all.
>>
>> But it's of course possible to do so by running the full diff machinery
>> over every commit and matching on the result, the current pickaxe is
>> just taking shortcuts and not doing that.
>>
>> >> options[1], but those could be implemented in terms of this underlying
>> >> code if anyone cared to have those as aliases. You'd just take the
>> >> -G<regex> and prefix the <regex> with "^\+" or "^-" as appropriate and
>> >> turn on the DIFF_PICKAXE_G_RAW_DIFF flag.
>> >>
>> >> 1. https://public-inbox.org/git/xmqqwoqrr8y2.fsf@gitster-ct.c.googler=
s.com/
>> >
>> > Thanks!
>> >
>> > [2] https://gitster.livejournal.com/30195.html
>> > [3] https://stackoverflow.com/questions/50707171/how-to-get-all-c-func=
tions-modified-by-a-git-commit

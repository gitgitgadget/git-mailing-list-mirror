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
	by dcvr.yhbt.net (Postfix) with ESMTP id 623751F453
	for <e@80x24.org>; Wed, 24 Apr 2019 23:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbfDXXZC (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 19:25:02 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45915 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728155AbfDXXZC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 19:25:02 -0400
Received: by mail-ed1-f66.google.com with SMTP id k92so17496019edc.12
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 16:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=MQsXJRSBmrSlMe1V8fntsH0GUnlEAuqI6qHgA3sQwTk=;
        b=omsQ3+sW8PiIWiNGHAbo/zisxnJDbV7YC8YfsCXBfDOjmetIp5siRpD7M4oQzk3ELu
         ON4dWaW0vKZcQjwVNzHOPGsnBa/g71A/YCX41Fd2TezGsh2DWgLiKVQqtTSaaP/oYtn+
         xBK9vMdI3MFVpXo6vqwvjOoylZ0O3tGTYC5TyMsLz2rPQuv2a9o6SeXGqYB9jb/L5Jqr
         lc9OxkyV9Uj/ylaljsCLRlI4J511afSEqM+YQmnYl7ZDSGzyfAx1I71UUpKGa2RVYc3z
         Yg2lDgRRgtOgdQUTtT2srJi4ZIQnvRMS6K+wuae14nT60PQ+4siTFGJOND6kewMMSUUz
         ho7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=MQsXJRSBmrSlMe1V8fntsH0GUnlEAuqI6qHgA3sQwTk=;
        b=fVZS7dh+Geg8Fi/KK+FtPfBT0lBzJ6P8dilWyDDmOtW8dQ5xsKgSaq5A2NQHE636/z
         UNTaBunytQLSpmfzfqiHsrmPX1EwncoBhx4oCMk2F2hAQwJ2m2AcP180abMJmzHm+6B/
         aOllJBZdEgqEeNcrXCDKYKeCwQnORCHNYvgXYzb1FFa/8S3bCXpnzF/mTEGHzGniN/R0
         2SjHoEnrQ+LCvjccC/aZj2IPt/j2XR5XC1MkZcwa2fUwKM2WSsmYfHhRSj28CNXfLp9b
         z6xumTQtvu9i8TQYBg6ymat33XxdXa8Z7WYg+Lezvu6aJQR3Lssu8WxQGAdYGXR5T5tK
         J32Q==
X-Gm-Message-State: APjAAAWnUSqFYU3diR9uE87H4HugHuz53NF7p4cBUzSgsXrKxKWuub2v
        QwHPJWYwuOp7dJGuuRz+m0Fw0/a3SiI=
X-Google-Smtp-Source: APXvYqxU4Jm4VN6CpK+vOIx5vJrwb0dr/paYKtdEM32abABCiWeHKUtIV3wD2Tfdin3i8VxG/HoakA==
X-Received: by 2002:a17:906:4c92:: with SMTP id q18mr17833256eju.16.1556148300149;
        Wed, 24 Apr 2019 16:25:00 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id p1sm3800846ejf.40.2019.04.24.16.24.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 16:24:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Julia Lawall <julia.lawall@lip6.fr>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH 2/2] diffcore-pickaxe: add --pickaxe-raw-diff for use with -G
References: <87o94vs9cp.fsf@evledraar.gmail.com> <20190424224539.GA23849@vmlxhi-102.adit-jv.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190424224539.GA23849@vmlxhi-102.adit-jv.com>
Date:   Thu, 25 Apr 2019 01:24:56 +0200
Message-ID: <87mukfrnp3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 25 2019, Eugeniu Rosca wrote:

> Hi =C3=86var,
>
> Thanks for the amazingly fast reply and for the useful feature (yay!).
>
> On Wed, Apr 24, 2019 at 05:37:10PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>
>> On Wed, Apr 24 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> > Add the ability for the -G<regex> pickaxe to search only through added
>> > or removed lines in the diff, or even through an arbitrary amount of
>> > context lines when combined with -U<n>.
>> >
>> > This has been requested[1][2] a few times in the past, and isn't
>> > currently possible. Instead users need to do -G<regex> and then write
>> > their own post-parsing script to see if the <regex> matched added or
>> > removed lines, or both. There was no way to match the adjacent context
>> > lines other than running and grepping the equivalent of a "log -p -U<n=
>".
>> >
>> > 1. https://public-inbox.org/git/xmqqwoqrr8y2.fsf@gitster-ct.c.googlers=
.com/
>> > 2. https://public-inbox.org/git/20190424102609.GA19697@vmlxhi-102.adit=
-jv.com/
>>
>> I see now once I actually read Eugeniu Rosca's E-Mail upthread instead
>> of just knee-jerk sending out patches that this doesn't actually solve
>> his particular problem fully.
>>
>> I.e. if you want some AND/OR matching support this --pickaxe-raw-diff
>> won't give you that, but it *does* make it much easier to script up such
>> an option. Run it twice with -G"\+<regex>" and -G"-<regex>", "sort |
>> uniq -c" the commit list, and see which things occur once or twice.
>>
>> Of course that doesn't give you more complex nested and/or cases, but if
>> git-log grew support for that like git-grep has the -G option could use
>> that, although at that point we'd probably want to spend effort on
>> making the underlying machinery smarter to avoid duplicate work.
>
> Purely from user's standpoint, I feel more comfortable with `git grep`
> and `git log --grep` particularly b/c they support '--all-match' [2],
> allowing more flexible multi-line searches. Based on your feedback, it
> looks to me that `git log -G/-S` did not have a chance to develop their
> features to the same level.
>
>>
>> Furthermore, and quoting Eugeniu upthread:
>>
>>     In the context of [1], I would like to find all Linux commits which
>>     replaced:
>>     	'devm_request_threaded_irq(* IRQF_SHARED *)'
>>     by:
>>     	'devm_request_threaded_irq(* IRQF_ONESHOT *)'
>>
>> Such AND/OR machinery would give you what you wanted *most* of the time,
>> but it would also find removed/added pairs that were "unrelated" as well
>> as "related". Solving *that* problem is more complex, but something the
>> diff machinery could in principle expose.
>
> I expect some false positives, since git is agnostic on the language
> used to write the versioned files (the latter sounds like a research
> topic to me - I hope there is somebody willing to experiment with that
> in future).

I was thinking of something where the added/removed could be filtered to
cases that occur in the same diff hunk.

>>
>> But the "-G<regex> --pickaxe-raw-diff" feature I have as-is is very
>> useful,
>
> I agree. I am a bit bothered by the fact that
> `git log --oneline -Ux -G<regex> --pickaxe-raw-diff` outputs the
> contents/patch of a commit. My expectation is that we have the
> `log -p` knob for that?

This is unrelated to --pickaxe-raw-diff, -U<n> just implies -p in
general. See e.g. "git log -U1".

>> I've had at least two people off-list ask me about a problem
>> that would be solved by it just in the last 1/2 year (unrelated to them
>> having seen the WIP patch I sent last October).
>>
>> It's more general than Junio's suggested --pickaxe-ignore-{add,del}
>
> As a user, I would be happier to freely grep in the raw commit contents
> rather than learning a dozen of new options which provide small subsets
> of the same functionality. So, I personally vote for the approach taken
> by --pickaxe-raw-diff. This would also reduce the complexity of my
> current git aliases and/or allow dropping some of them altogether.
>
> Quite off topic, but I also needed to come up with a solution to get
> the C functions modified/touched by a git commit [3]. It is my
> understanding that --pickaxe-raw-diff can't help here and I still have
> to rely on parsing the output of `git log -p`?

Yeah, it doesn't help with that. When it runs we haven't generated the
context line or the "@@" line yet, that's later. You can breakpoint on
xdl_format_hunk_hdr and diffgrep_consume to see it in action.

It's a waste of CPU to generate that for all possible hunks, most of
which we won't show at all.

But it's of course possible to do so by running the full diff machinery
over every commit and matching on the result, the current pickaxe is
just taking shortcuts and not doing that.

>> options[1], but those could be implemented in terms of this underlying
>> code if anyone cared to have those as aliases. You'd just take the
>> -G<regex> and prefix the <regex> with "^\+" or "^-" as appropriate and
>> turn on the DIFF_PICKAXE_G_RAW_DIFF flag.
>>
>> 1. https://public-inbox.org/git/xmqqwoqrr8y2.fsf@gitster-ct.c.googlers.c=
om/
>
> Thanks!
>
> [2] https://gitster.livejournal.com/30195.html
> [3] https://stackoverflow.com/questions/50707171/how-to-get-all-c-functio=
ns-modified-by-a-git-commit

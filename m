Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D00E1F42D
	for <e@80x24.org>; Tue, 29 May 2018 21:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966914AbeE2VDc (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 17:03:32 -0400
Received: from mail-ua0-f172.google.com ([209.85.217.172]:37569 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966767AbeE2VD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 17:03:29 -0400
Received: by mail-ua0-f172.google.com with SMTP id i3-v6so10998598uad.4
        for <git@vger.kernel.org>; Tue, 29 May 2018 14:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zJgOm/sS8INIm2CM78883H3Xtx/lfrqqISBhXN1gwJ0=;
        b=AhW7WF246S5f2A2jd0opNGoxf53rYWY2ZNi6kYobnvvbogvo2zok66rA+3gT9dJV2R
         Xpq3ZJcaXgxJ+AKpn9l/b+tAoS9Abftwt0ILaE04T3q67V+Y3ANr2kDphJYPgMio8usb
         M2U8ipYgX5PKFY3CL6/rjzyWCJX3AXvoMFVzkG1LJUYtc+8Dbj5vqosxaFw8SoXoFWUs
         QrJcDZeHlrJNaBO5+RemsTdWnbbcULQS9NKqPo05yCHMkgVUWMEXmxs7DjUky39Spcxz
         a+vr6+Rldpcq3NQmChflwJOqIoa+mkqXvIzM2IUMnXHTe9ueiRtvuk36xwSKQ2FHn/wX
         /Elw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zJgOm/sS8INIm2CM78883H3Xtx/lfrqqISBhXN1gwJ0=;
        b=pAJqpEDXh1LsAUmdZXvgTKM9ukmlQRH1c0wSkbDiM3GIn+Tdo20EOXx/wwQg/8LF33
         SXmLlRcRkB+7kaNtzw/2MWtHbYruwF60p7cyT/kFkB+CozyfN/qVU/mJRyTZ9tdrg4c7
         dv1brFeuQcRM4TuuJdDfw1YKnChJ+KEhBUnLQHgoLt/1PwJiZ7BjvlrDAZqgDz20JjsC
         F7zvwEb2Rl1NtPSaO/tyOgbFNdTqhBNqLzUDztOBVLbNJbznTNIsXx3p6XOL9YNbYDSI
         Pmj1DnSvWT1nefqjYwpdnHvVNwEPSL8EcYBBAiaB+RIvw1/+mmPBwPxVqCzdHulp+Wxb
         UzHg==
X-Gm-Message-State: ALKqPwdPO4fxszKu5Lupv3DjTb1bMU00Y4U6+mISNHWihjDn733GuU0C
        sjtrCctyS+ydcLEDFcWJFuP3y37n19tvodQNmmYBxQ==
X-Google-Smtp-Source: ADUXVKIxTTwhoRmaXJhxIlAVewED+jte6xKiCEmKjv766m7e6RtDOfijtbSn//UJYzjwbQ8fK7QUYMlsmt+DgR94rkQ=
X-Received: by 2002:a9f:380f:: with SMTP id p15-v6mr35437uad.112.1527627808106;
 Tue, 29 May 2018 14:03:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Tue, 29 May 2018 14:03:27
 -0700 (PDT)
In-Reply-To: <CAGZ79ka39xbbm_koyFeEizggoDBqKuwgmGwRBZJnBc13aOWZag@mail.gmail.com>
References: <CABPp-BFQJZHfCJZ1qvhvVcMd-_sOfi0Fkm5PexEwzzN+Zw2akw@mail.gmail.com>
 <CAGZ79ka39xbbm_koyFeEizggoDBqKuwgmGwRBZJnBc13aOWZag@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 29 May 2018 14:03:27 -0700
Message-ID: <CABPp-BH1BBH7aBpoSaJE5J7okdfrDzpbu5rH-w-FSG2RM0hU1g@mail.gmail.com>
Subject: Re: RFC: Merge-related plans
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Tue, May 29, 2018 at 11:19 AM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, May 28, 2018 at 1:48 PM, Elijah Newren <newren@gmail.com> wrote:
>> Currently, I would like to:
>>
>> A) Fix cases where directory rename detection does not work with
>>    rebase/am due to how they call merge-recursive.
>>
>>    Notes: Could just wait for D & E to land before fixing.
>>    Alternatively, email RFC to list now explaining issues and how the
>>    fix has performance implications; poll for opinions on whether to
>>    fix before or after D.
>>
>> B) Implement a remerge-diff ability (compare a merge commit to what an
>>    "automatic merge" would look like)[1].
>>
>>    Notes: Possibly for cherry-picks and reverts too.  Depends on C &
>>    E.
>>
>> C) Modify/extend how path-based and mode-based conflicts are
>>    communicated to the user.
>>
>>    Notes: Particularly important as a mechanism for handling
>>    challenges[2] with implementing the remerge-diff ability.  Need to
>>    send RFC to list with ideas to get feedback.
>>
>> D) Improve merge performance.
>>
>>    Notes: Includes 4-5 specific optimizations[5], some of which I
>>    expect to be somewhat invasive and thus may make more sense to just
>>    make part of the new merge strategy implemented in E.  Biggest
>>    optimization depends on F.
>>
>> E) Write a new merge strategy meant to replace merge-recursive.
>>
>>    Notes: Suggested by Junio[3][4].  Depends on F & G.
>>
>> F) Make file collision conflict types more consistent.
>>
>>    Notes: Specifically, make rename/rename(2to1) & rename/add
>>    conflicts behave more like add/add[6][7].  Depends on part of G.
>>    Would prefer H to be accepted first.
>>
>> G) Improve merge-related portion of testsuite.
>>
>>    Notes: Intended to help test new merge strategy with more
>>    confidence.  Will include approximately a dozen edge and corner
>>    cases where merge-recursive currently falls short.  Started at [8];
>>    see also [9].
>
> Most items forward-reference "Depends on (<later letter>) up to here;
> (H) seems independent, but might be a good first start.
> (G) [8] is queued as origin/en/merge-recursive-tests, or do you mean
> to expand (G) into a mini-framework of merge-testing? i.e. run the
> mini test framework multiple times, each using a different
> merge strategy, similar to submodule tests, e.g. see
> t/lib-submodule-update.sh and one of its users, t1013.

Sorry, I should have been more clear about G.
en/merge-recursive-tests is not G, it's just a preparation topic for
it (or, alternatively, the first of a few topics for G).  In short,
the idea for G was missing coverage of existing functionality for
merge-recursive.

In more detail...

The idea for G was that, if possible, I wanted to avoid a repeat of
the problems directory rename detection caused Junio where he had to
revert it from master and worried about mis-merges.  That could have
been avoided if we had additional tests in the testsuite covering the
already-up-to-date check, making me wonder if there were other
important cases where merge-recursive lacked coverage.  Rather than
finding untested cases which merge-recursive handles correctly, my
investigation mostly yielded additional testcases where
merge-recursive falls down, including:
  * about 3 different rename cases (non-recursive), one of which was
reported previously but isn't in the testsuite
  * about 4 different issues with submodules (non-recursive) that I
don't think are represented in the testsuite (a couple of which I
mentioned in an email to you on the list last year but never created
testcases for)
  * about 6 different issues with special types and/or mode conflicts
(recursive only)
  * a few additional tests, commentary, and an alternate idea for
improving directory/file conflict handling

>> H) Miscellaneous code cleanups irritating me while working on other
>>    changes[10].
>>
>>
>> My current plan was to work roughly in reverse, from H to A.  Some questions:
>>
>>   * Does any of this look objectionable?
>
> Going in order A-H seems slightly out-of-order to me, I'd think (H) and (G)
> would go first;
>
> (B) sounds like an independent feature, which could go in parallel?

B may sound like an independent feature, but it needs a merge
algorithm that doesn't mess with the working tree so it depends pretty
strongly on E.

>>   * Should I post RFC questions on A and C earlier?
>
> I would think so, it is easier to give feedback on code, I would think.

If the idea is to give feedback on *code* rather than just
ideas/tradeoffs/pinpointing-buggy-lines, then it sounds like you're
actually suggesting posting the RFC later rather than earlier?

Also, the bigger question for me wasn't so much "should I ask the list
about these changes?" before making them, but rather: Do folks want me
to bring these things up before I work on D & E -- even if I end up
not getting back to incorporating their answers for months until D & E
are completed and merged?

>>   * Should I split D and G?  (Current plan was to keep D together, but
>>     split G into five short slightly inter-dependent topics)
>
> I would have expected to have tests (G) as a companion of (A) or (C)
> rather than (D), as performance improvements would keep the test suite
> unchanged?

Let me re-phrase: D and G are completely independent series, both of
which happen to be divisible.  Should either of them be split?

More background: D is only a handful of commits, so far; the main
reason to split it is to allow some of it to go first (maybe even
before G or H).  The downside is introducing extra churn and risk in
merge-recursive, when I'm planning to rewrite it soon anyway.  I was
trying to minimize merge-recursive changes, other than trying to make
sure that the new merge strategy and merge-recursive will give
identical results (modulo maybe fixing a few extra corner cases and
running faster).  Basically, I wanted it to be really easy to compare
old and new strategies, but otherwise wanted to leave merge-recursive
mostly alone.  It's not entirely clear how quickly I'll find time to
work on all of this, though, so maybe just-wait-for-the-rewrite is not
the right prioritization.

(And yes, A & C deserve tests, but they're not of the
missing-coverage-for-merge-recursive variety that I was thinking of
for G.)

>>   * E is kind of big.  Are there any specific things folks would like to see
>>     with how that is handled?
>
> How much abstraction can be done ahead of time such that there is an
> interface/API where you just plug in a new merge strategy and do not
> need to duplicate a lot of code/tests?

For avoiding duplicate tests, my plan was to use a variable (like
GIT_TEST_SPLIT_INDEX or GIT_FSMONITOR_TEST), which, when set, would
change the default merge strategy from "recursive" to the new one, and
also replace explicit requests for the "recursive" merge strategy with
the new one.

For avoiding duplicate code...well, Junio's suggestion was "[to
rewrite] without using much from the existing code in
merge-recursive.c at all" because he has "written off that code as
mostly unsalvageable"[4].

There are some functions that I think are worth leaving intact (e.g.
helpers like output(), the directory rename detection stuff, or the
merge_submodule code that you recently moved).  That stuff I was
planning to put in a "/* COPIED FROM merge-recursive.c VERBATIM */"
section.  And eventually, the idea would be to delete the old
merge-recursive and just use the replacement, making the duplication
concerns eventually go away.

...or is your question more about how to abstract things so that
others can also write new merge strategies in the future and allow as
much code and test re-use as possible?


>> [4] https://public-inbox.org/git/xmqqk1ydkbx0.fsf@gitster.mtv.corp.google.com/
>>    [New strategy]


Thanks for taking a look!

Elijah

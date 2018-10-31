Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 292B71F453
	for <e@80x24.org>; Wed, 31 Oct 2018 17:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbeKAClG (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 22:41:06 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:38625 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729908AbeKAClG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 22:41:06 -0400
Received: by mail-ed1-f52.google.com with SMTP id c1-v6so14371554ede.5
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 10:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XduUr4mXodm76r2X/gES/nPmWIe3PlqSjxOweRZO9Uc=;
        b=i8+VDlAddyi4HDAPf4FAmbyt4CVoqWI7dVVhKIddLrx08iZ8nborRtseyGEqTHVlvV
         3TPW17R/mBfPfNP79dbURxp89HtLYNFFuly5NjAZYiCblcqICiAFmUHu16kZs6RluQJP
         W8DMSrYetgXUyUcH+19TVDsP4j/LrGZck5IRtV2olZjWhlCC0zLRuhsXa2RK0wzLzVs+
         SUIE0Z7o/TK3fgZ8QRUd6W1gDw4yEfwm8BZrClXvRTHMpq7OF1hhTcnrXE1tBM/ewbEm
         Co/oHpRh41ejWs/dZIR0c1GQbWZYFFOXvddtk4Qz21XYZeIwQDFpm8wngzoPhTc0n09d
         a2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XduUr4mXodm76r2X/gES/nPmWIe3PlqSjxOweRZO9Uc=;
        b=l8oz0b2VBb4YBX1D3k058yPnDceVZ0NkpjhVRia9OE9Lbgu/YV/+qTeEQonHj62cTW
         mXC3VvZfXPHsRZC9+LQrd11S0v+TowGWVwMS05mCiu4PVOtFFscRW2lGiqtP1P5OcxtS
         RUbI1Lv6lmKz4nXI/to5eFQlV/TkLnjAPSCIdV2ckgcnCO/Imsg0ATO5TAVESnQFiOsF
         iJDVd0m+hhrYYrxndEIxXjiZnicEMQqgBhOf8KtL1lkTEt89g7qUYrvpaNUj3AcsT/X6
         mLWjQwf3HhXy5DUuNhLcEdduacwcXN+H3giRfx9oRxWqBGIwK+f/ihZOgqaw1jMP70YA
         rwWQ==
X-Gm-Message-State: AGRZ1gJjhyriU8oN7laxBwF7x2y7RVDtbP/qsD+pO+yzKrJ2zi15Jx6u
        qQrZNLEWG3uLHH9FrmrthxVoGtRKskkUIfTU2c5ETA==
X-Google-Smtp-Source: AJdET5ejVeY8JsdTCib4yrh9rG1RCcZTfsSEBNopZx3QvM2tLBalXblO3e1Skk1S7w1WP7p688aiVzPUusXob4m4KZ8=
X-Received: by 2002:aa7:df12:: with SMTP id c18-v6mr2926643edy.85.1541007723877;
 Wed, 31 Oct 2018 10:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <CA+X5Wn76N34oBhRZvXKOwP0L_pF=LYbT6ugTgtPYSvnHg=MZVw@mail.gmail.com>
In-Reply-To: <CA+X5Wn76N34oBhRZvXKOwP0L_pF=LYbT6ugTgtPYSvnHg=MZVw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 31 Oct 2018 10:41:52 -0700
Message-ID: <CAGZ79kZ6LxRevLy2mZd1Ag=oO_NtDdmRSuadswR_n=RGpO=rGQ@mail.gmail.com>
Subject: Re: Using --word-diff breaks --color-moved
To:     jamespharvey20@gmail.com
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 30, 2018 at 7:06 PM james harvey <jamespharvey20@gmail.com> wrote:
>
> If you use both "--word-diff" and "--color-moved", regardless of the
> order of arguments, "--word-diff" takes precedence and "--color-moved"
> isn't allowed to do anything.

The order of arguments doesn't matter here, as these just set internal
flags at parse time, which determine what later stages do.

Git uses the xdiff library internally for producing diffs[1].
To produce a diff, we have to feed two "streams of symbols"
to the library which then figures out the diff.
Usually a symbol is a whole line. Once we have the diff
we need to make it look nice again (i.e. put file names,
context markers and lines around the diff), which happens
in diff.c.

But when --word-diff is given, each line is broken up
into words and those are used as symbols for the finding
the diff[2]. See the function fn_out_consume() [3],
for example 'ecbdata->diff_words' is set on '--word-diff'.

When it is not set we fall down to the switch case that
will call emit_{add, del, context}_line(), which in turn
emits the lines.
The --color-moved step is performed after all diffing
(and nicing up) is done already and solely works on
the add/del lines. The word diff is piecing together lines
for output, which are completely ignored for move
detection.

[1] see the xdiff/ dir in your copy of git. We have some
    substantial changes compared to unmaintained upstream
    http://www.xmailserver.org/xdiff-lib.html
    http://www.xmailserver.org/xdiff.html

[2] https://github.com/git/git/blob/master/diff.c#L1872

[3] https://github.com/git/git/blob/master/diff.c#L2259

> I think "--color-moved" should have precedence over "--word-diff".

I agree for precedence as in "work well together". Now we'd need
to figure out what that means. In its current form, the move
detection can detect moved lines across diff hunks or file
boundaries.

Should that also be the case for word diffing?
I think word diffing is mostly used for free text, which has different
properties compared to code, that the color-moved was originally
intended for.

For example in code we often have few characters on a line
such as "<TAB> }" which is found often in gits code base.
We added some heuristics that lines showing up often with
few characters would not be detected on their own as a moved
block [4]. I would expect we'd have to figure out a similar heuristic
for word diffing, if we go down that route.

But that is a detail; we'd first have to figure out how to make the
words work with the move detection.

[4] https://github.com/git/git/commit/f0b8fb6e591b50b72b921f2c4cf120ebd284f510


>   I
> cannot think of a scenario where a user would supply both options, and
> actually want "--word-diff" to take precedence.  If I'm not thinking
> of a scenario where this wouldn't be desired, perhaps whichever is
> first as an argument could take precedence.

word diffing and move detection are completely orthogonal at the moment.
Instead of option order, I'd rather introduce a new option that tells us
how to resolve some corner case. Or in the short term we might just
want to raise an error?

> (The same behavior happens if 4+ lines are moved and
> "--color-moved{default=zebra}" is used, but below
> "--color-moved=plain" is used to be a smaller testcase.)
>
> [...]

This sounds like you are asking for two things:
(1) make color-moved work with words (somehow)
(2) allow the user to fine tune the heuristics for a block,
    such that default=zebra would still work.

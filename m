Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38C9A208DB
	for <e@80x24.org>; Fri, 25 Aug 2017 21:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756425AbdHYVGE (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 17:06:04 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:36745 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758720AbdHYVGE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 17:06:04 -0400
Received: by mail-yw0-f175.google.com with SMTP id h127so5288299ywf.3
        for <git@vger.kernel.org>; Fri, 25 Aug 2017 14:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SnCsMAj6/FmnDBMu1X0sYaNpayrjH5CGypeSaJqOe68=;
        b=lfllalPkDvcbYolBOUgpic3g1jSPCclNhXS/LeNMA4AUs31qQ7NsDfYVUhDIb+S0tE
         aPKt18SK2bgBQEG1TcWO4QFc4jRQA72Qw681Glun/HO0flBDoB9f1e1pq+ccYQqDe7hy
         mDtEmMnjnnm13kPNiwnCmR/k4yZrBqo8YI3axdYElLq8mYLjiKO4Roybn9DVHdsQVAka
         uos6x6estFZabJqe5KjHZihqKzv0eaK+xjTi97aR7vF2Ep00vLF7eNy2/0Rp1K1TmIp/
         E1tbdI38lY+4+oBa/ZTVQHc3SFoeIXb3xR9/7BjoGVOgY5daAKEPrC+7JilbqLVCoopo
         vR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SnCsMAj6/FmnDBMu1X0sYaNpayrjH5CGypeSaJqOe68=;
        b=MeZhQlnfKBlFJzkjXSWK8pvGM/KfeSpG/u92mCAJq8PfgzoJg9ul2QT53AT3cXxLtl
         mWXhP38D9V5rzT0EQszPpnKyLQZhwuCkcCg5aoMV6A/qhcKV8TVzC9LpBNb4X0wX75ND
         EQ2vE47C3ELE8NcMBYq4ghDlBpuJxdwyR5X7PUbSu2l8ZabrCZY4Mj/VgOj6gSAi2jI3
         NDoBi3KM76jxE4tmOfGF6ObDCnIzAatlIz4V6Z8Xcy/CiDIrP6qSSOomdwfWIcgk+yri
         IK/H8qamLvz3/FObKgLRLvlvVXFGtVL9sij3Ppi5FF/HN8+3LMS+9tSWQiE9Xo2TipMg
         qVXQ==
X-Gm-Message-State: AHYfb5hGPQwGXsBwMW3HZ2+5IZUUlls4TvTOq4CYcFvXHFpSZCe26oNC
        7rYh+iJ5AEEOJ0f5Ntbl43etQdAHnVX93jtRJA==
X-Google-Smtp-Source: ADKCNb4+o6QvYkSmjiQfD3TtfNRDiRXKz0uhK+MbfX796Zp058SxKIgLaR0VqqFdQ/Nm6xiqTpx4qhJPxu7TdtzKjvs=
X-Received: by 10.13.206.132 with SMTP id q126mr8809005ywd.337.1503695162677;
 Fri, 25 Aug 2017 14:06:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.248.26 with HTTP; Fri, 25 Aug 2017 14:06:02 -0700 (PDT)
In-Reply-To: <xmqqh8wvs89e.fsf@gitster.mtv.corp.google.com>
References: <xmqqy3q7sge2.fsf@gitster.mtv.corp.google.com/>
 <20170825192813.15697-1-sbeller@google.com> <xmqqh8wvs89e.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 25 Aug 2017 14:06:02 -0700
Message-ID: <CAGZ79kY6-R4Tt45BfnncH7tE46K8FG7RBDk+qb-tCU97CVQHvA@mail.gmail.com>
Subject: Re: [PATCH] usage_with_options: omit double new line on empty option list
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 25, 2017 at 1:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Currently the worktree command gives its usage, when no subcommand is
>> given. However there are no general options, all options are related to
>> the subcommands itself, such that:
>>
>>  #    $ git worktree
>>  #    usage: git worktree add [<options>] <path> [<branch>]
>>  #       or: git worktree list [<options>]
>>  #       or: git worktree lock [<options>] <path>
>>  #       or: git worktree prune [<options>]
>>  #       or: git worktree unlock <path>
>>  #
>>  #
>>  #    $
>>
>> Note the two empty lines at the end of the usage string. This is because
>> the toplevel usage is printed with an empty options list.
>>
>> Only print a new line after the option list if it is not empty.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>>> I have this feeling that this patch may not be sufficient.
>>>
>>> The reason for the first blank line is because we unconditionally
>>> emit one, expecting that we would have a list of options to show and
>>> want to separate the usage from that list, and the fix in this patch
>>> is correct---it is the right way to suppress it.
>>>
>>> But why do we need the second blank line in this case?  There is a
>>> similar unconditional LF near the end of this function.  Is somebody
>>> else (other than usage_with_options() which will exit immeidately)
>>> calls this function and expects to say something more after what
>>> this function said, and is this extra blank line at the end is to
>>> prepare for that caller?
>>
>> Good point, parse_options[_step] also makes use of the
>> usage_with_options_internal, such that the regular options
>> need to work, with a potentially interesting arrangement of OPTION_GROUPs.
>>
>> I think this one is cleaner, as it omits the correct LF.
>
> Sorry, but now I am utterly confused, as I do not think I've made a
> "good point", and I do not see how your "this one is cleaner than
> the previous" can follow from what I said.
>
> The first fputc('\n', outfile) touched in the previous version but
> not this one is shown after the usage string.  I think the intention
> of that is "We have finished giving the usage; now we are going to
> list options, and we need a separator blank line in between", and
> the reason why it is not conditional on "do we even have any option
> in the list?" is probably those who helped parse-options evolve
> never saw a user of parse-options API that actually does not have
> any option.  So from that point of view, it is understandable why we
> didn't check with OPTION_END and checking OPTION_END there and
> omitting the blank makes sense---I understand what the previous
> patch did, in other words, and agree with what it did.
>
> By the way, it checked OPTION_GROUP and that is also
> understandable.  In the loop, there will be a blank berfore each
> option group to visually separate things across groups; if we know
> the first entry in the options list is such an entry, then we do not
> want a blank, as the blank (meant as a separator between usage and
> option list) will be followed by another blank (meant as a separator
> between groups) and we waste one blank line.

Ah, yes. I did not want to mess with that pattern for option groups
in this patch, but rather omit the "correct" LF, which is the one after
the option listing instead of before the option listing.


> The other fputc('\n', outfile) that this version of the patch
> touches is what I had trouble with, and I still do.  There must be a
> similar rationale like the previous one, i.e. "We have finished
> giving the usage, and we have finished showing all the options.  Now
> we are about to further show X, so let's have a blank line here so
> that what we have wrote will be separated from it", but I cannot
> tell what that X is.

Oh. I assumed that this X is the the next command in the users
terminal, but I checked other commands and that is not the case
at all (at least ls, vi, tar)

Upon closer inspection, I have the impression that f389c808b6
(Rework make_usage to print the usage message immediately,
2007-10-14) introduced the extra new line without giving a rationale.
(I could not find relevant review/discussion of that patch in the archive)

> In other words, what I suspect the _right_ solution is, is to have
> the previous patch that omits the first LF when the type of the
> first element in the options array is either END or GROUP, plus
> unconditional removal of the second LF.

This unconditional removal that you hint at seems to fix the bug
that I suspect introduced at the given commit. And tightening
the condition of the first LF seems to fix the itch that I was having
then.

> If some caller of this
> helper function has "now we are going to also show X and we want a
> separator", I think that code should be showing the LF as needed.
> usage_with_options(), the caller you showed its behaviour in your
> proposed log message, does *not* want either of these two LFs, I
> would think.
>

I can follow that.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 979821F406
	for <e@80x24.org>; Tue,  9 Jan 2018 19:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754696AbeAITvJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 14:51:09 -0500
Received: from mail-qt0-f169.google.com ([209.85.216.169]:42973 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751603AbeAITvI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 14:51:08 -0500
Received: by mail-qt0-f169.google.com with SMTP id c2so356975qtn.9
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 11:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0ryK++oLtTPzZFSieeogmMcDJl9de15ZI9uvLEmclXU=;
        b=eo6tRlqOKnXuKZbdXeltDvXZV1JTOce+DtzVM2PPq8c1Msfkmq8J9wOdsmwnu/TaF1
         GewHoxWgT9mu80fh7dwhxdFLxImdVkdSPohSQ1Vt9Rbtz4Yx7RvrVipWcYLpcVy+MBwI
         CaauE/vjwuHyrB7otF2x16gykJ8uL8jTm4I+c/u+tZEHr+l2I0f6DWFrZjBLmIi3z/fU
         SmOThhcu3QyerzTUx7B/yxmu5jJebByjQlY4at7Kzji5IKNhp6qwGMTtdVfJOn5RN8iB
         uuadEeKu89LzpbKs3ilzZ+32gxOD8kdHu/LIT3nU98T87c/C+24sBb0oaEgqQIr0EetM
         XbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0ryK++oLtTPzZFSieeogmMcDJl9de15ZI9uvLEmclXU=;
        b=USGmFvy5ph6HaDqkf2RGOHdvcuavmTtB+2VBqDH+/LIiOta/flmY9fM0Wnq9er9Tkg
         I17nRtexG0g2i4pguoBURN4lmZJSqjOqlhC2qqmk9wuiZf17I8E/ZK6j9g0NbdjXksTB
         /3UebXPxTZRbwPU3E8t4qLU2OVp1iwUO1hc2h33p5IxlhZxOFt7JNTZJoCWu5pnhhqNE
         VnKkMfhpSp6sClXik7TI7NAnTttAvU139MHBCwxC/8/l6acY994pjqus9MnElXEfQ1JH
         h9ijzqHtog8wTQcUAHRRApa3WXIHLqpD4rBOOAMUt/vqPhSJg5tIh4Blg23DVuxiO2HT
         A9Yg==
X-Gm-Message-State: AKwxytcrL+FuFiOWI3oe9jlNCCSNeH4Qj2jwhbMXsFj1aUnhD1EDdGEI
        aouTHacFiwkybAj8CXLqH8m3LnuMhIfvOTCpH2Zcdg==
X-Google-Smtp-Source: ACJfBosYxKEJzjQSVWvVz+BKaoy0rS1E0B1ga9OLi7qOeCObhZ3FgSCsNxwusIsNjl5/SIWzZ3GxtFZgmC5mrk2ppsk=
X-Received: by 10.237.38.35 with SMTP id z32mr23366878qtc.180.1515527466903;
 Tue, 09 Jan 2018 11:51:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Tue, 9 Jan 2018 11:51:06 -0800 (PST)
In-Reply-To: <nycvar.QRO.7.76.6.1801091357560.37@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180107181459.222909-1-dstolee@microsoft.com>
 <87k1wtb8a4.fsf@evledraar.gmail.com> <c08416f1-bbec-2037-34a6-f454d85de439@gmail.com>
 <20180108102029.GA21232@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1801081438470.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <20180109065018.GA32257@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1801091357560.37@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 9 Jan 2018 11:51:06 -0800
Message-ID: <CAGZ79kYdgD2h7QjjJe0aA4eMATCGkH62XYvziUNvAPsBJDXOCA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/18] Multi-pack index (MIDX)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 9, 2018 at 5:05 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Peff,
>
> On Tue, 9 Jan 2018, Jeff King wrote:
>
>> On Mon, Jan 08, 2018 at 02:43:00PM +0100, Johannes Schindelin wrote:
>>
>> > Take the interactive rebase for example. It generates todo lists with
>> > abbreviated commit names, for readability (and it is *really* important to
>> > keep this readable). As we expect new objects to be introduced by the
>> > interactive rebase, we convert that todo list to unabbreviated commit
>> > names before executing the interactive rebase.
>> >
>> > Your idea (to not care about unambiguous abbreviations) would break that.
>>
>> I think that could be easily worked around for rebase by asking git to
>> check ambiguity during the conversion.
>
> Sure.
>
> It also points to a flaw in your reasoning, and you should take my example
> further: previously, we guaranteed unique abbreviations, and who is to say
> that there is no script out there relying on that guarantee? You?
>
>> But I agree it's a potential problem for other scripts that we might not
>> have control over. I hadn't really intended this to be the default
>> behavior (my patch was just trying to show the direction). But it does
>> make for a pretty awful interface if callers have to opt into it
>> manually ("git log --oneline --no-really-go-fast").
>
> Exactly.
>
>> I am a bit curious if there's a bounded probability that people would
>> find acceptable for Git to give an ambiguous abbreviation. We already
>> accept 1 in 2^160, of course. But would, e.g., one in a million be OK?
>
> What is that going to solve?
>
> I think a better alternative would be to introduce a new abbreviation mode
> that is *intended* to stop caring about unique abbreviations.
>
> In web interfaces, for example, it makes tons of sense to show, say, 8
> digits in link texts and have the full name in the actual link URL.
>
> Currently, we have no way to tell Git: look, I want to have a short label
> for this, but I do not really care that this is unambiguous, I just want
> something to talk about.
>
> (And you are correct, of course, that the uniqueness of abbreviations will
> no longer be guaranteed for partial clones, and it is already not
> guaranteed for shallow clones, and it will only be possible to guarantee
> this, ever, for one particular repository at a particular time.)
>
> I am just hesitant to change things that would break existing setups.
>
> Just to throw this out there: --abbrev=8! would be one possible convention
> to state "I want exactly 8 hex digits, don't bother checking for
> uniqueness".
>
> Not sure how urgent such a feature is.

You seem to have spent some time on rebase, including lamenting on the
in-expressiveness of the instruction sheet (c.f. "rebase a mergy history sucks")

And in that light, I'd like to propose a new naming scheme:

(a) assume that we "tag" HEAD at the start of the rebase
(b) any abbreviation must be given as committish anchored to said ref:

pick REBASE_HEAD~1 commit subject
pick REBASE_HEAD~2 distak the gostim
pick REBASE_HEAD~3 Document foo
pick REBASE_HEAD~4 Testing the star-gazer

And as we have the full descriptiveness of the committishs there,
each commit can be described in a unique way using the graph relationship.
I am just throwing the name REBASE_HEAD out there to trigger some associations
("similar to FETCH_HEAD"), but I dislike the name.

(c) this would not solve the problem of mergy history, yet. For that we'd need
    to introduce more keywords, that allow us to move around in the DAG,
    such that we can reset to a specific revision or name revisions on the fly.
    So maybe all we need is "reset", "name" (== short lived tag),
    "merge" (rewrite parents of HEAD) to be expressive enough, but still keep
    the line oriented interface?

Stefan

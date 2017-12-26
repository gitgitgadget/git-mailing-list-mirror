Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E08C11F406
	for <e@80x24.org>; Tue, 26 Dec 2017 01:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750814AbdLZB2c (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Dec 2017 20:28:32 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:41968 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbdLZB2c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Dec 2017 20:28:32 -0500
Received: by mail-wm0-f42.google.com with SMTP id g75so33445240wme.0
        for <git@vger.kernel.org>; Mon, 25 Dec 2017 17:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2qBkZHZ+Q1Ii4W5IwJV3GQyA5CWyXP42eDy52HUg+40=;
        b=bc2HKKZqyBmTfc6VP6HmKuWv/hMLiNhgU04RyXtTaYPr62FHvvNxv38oPWxq+j/PI6
         DkLhesQ0d+TwzhGDciTPXOL2zwL7vddh7FEupz+NhzSD2BBSB6c4P8nNWcnKjaNy+eqX
         kKk//2TKYs9rwm6x+R9RPo0xBIsOzcT3bSHoEn4hxoorySrkC9tNWJZRjSp8LfYy8fwm
         R1inKMJ5OlwlaPbAOhESO332aQBySukke38lOOeKXuU6z5ircfTpZ9uH9HpTvW8Hd/nx
         MABk2y1XZP9oyhiokih5TL0BJP39RC4mPjM66CLMiFuGfGx9WSx/pzc4oy4RVYr0z9+s
         Od9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2qBkZHZ+Q1Ii4W5IwJV3GQyA5CWyXP42eDy52HUg+40=;
        b=cVkaBqIDM3EOOFkU97dQCYeGQtdk/4BLDbtp5qUVwGHVetilzdJAYv0YzcWZzYigH0
         fju2lpQwd3a7hemBZWh6o269VkHf597HCiHcEGwS7komGT/Yl8Sgr5LraWfHE3WSPKlE
         at//SIn79MicWJcyo5k1FxQ/9OKsQSXFfPDL7t+SrfEau1efDQQt5TRTU3q9hud2U0T6
         uE+WeTB/c7A0Bzx8jdcwJm+T++uXBF8Zd483VAWfyKcsyKPwxHj+eF+tQHCuXpdskrCm
         0geYM2S37z4wm0zgM04TGE4OI7bcysF1sFHnc5FQJysCuMscoxj47ielj4VNMOkIbR7z
         g7Rw==
X-Gm-Message-State: AKGB3mIAFeybYgiC2O8WG8a1mAEq3ymcQu64s32efovgQ3VvCBexx/T9
        9Vmb7d7VuPYE3NmZgr+ltzglr8pQFlYUgzGdlONl11Hi
X-Google-Smtp-Source: ACJfBov/zEnjRmnSiMh0t0+NM8M8i8hapbopVZhcEt/WiceJ1S9PSLOdrKedvj1QcBd/7+2KotS7/2+T8ac10x9AoJg=
X-Received: by 10.80.149.152 with SMTP id w24mr29385516eda.76.1514251710626;
 Mon, 25 Dec 2017 17:28:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.174.252 with HTTP; Mon, 25 Dec 2017 17:28:10 -0800 (PST)
In-Reply-To: <20171226001622.GA16219@Carl-MBP.ecbaldwin.net>
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com>
 <877etds220.fsf@evledraar.gmail.com> <20171223210141.GA24715@hpz.ecbaldwin.net>
 <87608xrt8o.fsf@evledraar.gmail.com> <20171226001622.GA16219@Carl-MBP.ecbaldwin.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 25 Dec 2017 17:28:10 -0800
Message-ID: <CA+P7+xp9v8adrbF7JUYa3X+PvurHiW1QNTnodJt6-vyB3_dWAQ@mail.gmail.com>
Subject: Re: Bring together merge and rebase
To:     Carl Baldwin <carl@ecbaldwin.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 25, 2017 at 4:16 PM, Carl Baldwin <carl@ecbaldwin.net> wrote:
> On Sat, Dec 23, 2017 at 11:09:59PM +0100, =C4=98var Arnfj=C3=B6r=C5=A1 Bj=
armason wrote:
>> >> But I don't see why you think this needs a new "replaces" parent
>> >> pointer orthagonal to parent pointers, i.e. something that would
>> >> need to be a new field in the commit object (I may have misread the
>> >> proposal, it's not heavy on technical details).
>> >
>> > Just to clarify, I am proposing a new "replaces" pointer in the commit
>> > object. Imagine starting with rebase exactly as it works today. This n=
ew
>> > field would be inserted into any new commit created by a rebase comman=
d
>> > to reference the original commit on which it was based. Though, I'm no=
t
>> > sure if it would be better to change the behavior of the existing reba=
se
>> > command, provide a switch or config option to turn it on, or provide a
>> > new command entirely (e.g. git replay or git replace) to avoid
>> > compatibility issues with the existing rebase.
>>
>> Yeah that sounds fine, I thought you meant that this "replaces" field
>> would replace the "parent" field, which would require some rather deep
>> incompatible changes to all git clients.
>>
>> But then I don't get why you think fetch/pull/gc would need to be
>> altered, if it's because you thought that adding arbitrary *new* fields
>> to the commit object would require changes to those that's not the case.
>
> Thank you again for your reply. Following is the kind of commit that I
> would like to create.
>
>     tree fcce2f309177c7da9c795448a3e392a137434cf1
>     parent b3758d9223b63ebbfbc16c9b23205e42272cd4b9
>     replaces e8aa79baf6aef573da930a385e4db915187d5187
>     author Carl Baldwin <carl@ecbaldwin.net> 1514057225 -0700
>     committer Carl Baldwin <carl@ecbaldwin.net> 1514058444 -0700
>
> What will happen if I create this today? I assumed git would just choke
> on it but I'm not certain. It has been a long time since I attempted to
> get into the internals of git.
>
> Even if core git code does not simply choke on it, I would like push and
> pull to follow these pointers and transfer the history behind them. I
> assumed that git would not do this today. I would also like gc to
> preserve e8aa79baf6 as if it were referenced by a parent pointer so that
> it doesn't purge it from the history.
>
> I'm currently thinking of an example of the workflow that I'm after in
> response to Theodore Ts'o's message from yesterday. Stay tuned, I hope
> it makes it clearer why I want it this way.
>
> [snip]
>
>> Instead, if I understand what you're actually trying to do, it could
>> also be done as:
>>
>>  1) Just add a new replaces <sha1> field to new commit objects
>>
>>  2) Make git-rebase know how to write those, e.g. add two of those
>>     pointing to A & B when it squashes them into AB.
>>
>>  3) Write a history traversal mechanism similar to --full-history
>>     that'll ignore any commits on branches that yield no changes, or
>>     only those whose commits are referenced by this "replaces" field.
>>
>> You'd then end up with:
>>
>>  A) A way to "stash" these commits in the permanent history
>>
>>  B) ... that wouldn't be visble in "git log" by default
>>
>>  C) Would require no underlying changes to the commit model, i.e. it
>>     would work with all past & future git clients, if they didn't know
>>     about the "replaces" field they'd just show more verbose history.
>
> I get this point. I don't underestimate how difficult making such a
> change to the core model is. I know there are older clients which cannot
> simply be updated. There are also alternate implementations (e.g. jgit)
> that also need to be considered. This is the thing I worry about the
> most. I think at the very least, this new feature will have to be an
> opt-in feature for teams who can easily ensure a minimum version of git
> will be used. Maybe the core.repositoryformatversion config or something
> like that would have to play into it. There may also be some minimal
> amount that could be backported to older clients to at least avoid
> choking on new repos (I know this doesn't guarantee older clients will
> be updated). Just throwing a few ideas out.
>
> I want to be sure that the implications have been explored before giving
> up and doing something external to git.
>
> Carl

What about some way to take the reflog and turn it into a commit-based
linkage and export that? Rather than tying it into the individual
commit history, keep track of it outside the commit, possibly via
something like notes, or some other mechanism.

This also ties into work done by Josh Triplett on git series [1] and
some previous mail discussions that I remember. He had some mechanism
for tracking series history which works ok, but can cause problems you
mentioned when simply adding a second parent commit.

I tend to think some mechanism to store both patch/commit history and
review based comments would be a very useful thing to integrate so
that multiple platforms had a more generic way of sharing things such
as line-based commentary, and so on. It could even be some sort of
unformatted method to at least get the mechanism of "how to share this
among clients" to be stable across tools, even if each review tool
made its own format (thus we don't lock the *type* of review comments
in stone).

I definitely think that storing just the history of commits isn't as
valuable without storing the comments made in the review process.

-Jake

[1] https://github.com/git-series/git-series

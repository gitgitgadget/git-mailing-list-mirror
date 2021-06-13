Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2AFC48BCF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 08:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A3AB6100A
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 08:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhFMINz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 04:13:55 -0400
Received: from mail-ej1-f43.google.com ([209.85.218.43]:33719 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhFMINy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 04:13:54 -0400
Received: by mail-ej1-f43.google.com with SMTP id g20so11293773ejt.0
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 01:11:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=adxVQiyRh1F8cs6GhH9NSrmBkIBeOi7F/JuZchSxYUg=;
        b=FgdjiMJn/4JKYo2DCvjCdR9UWtliAQCH1tysH8WduOtPiKAqL5ddo5q1XEavC1YZcy
         Oczn3NqBbMqmeKPkvs11rDphcGdYXehie5xkQmtrbIB3/WClrDSjzwvyBSZR3N/oHSUh
         L/wWouF3SfzZh+dGrtnnjV+ggbG4kCJigcc3o/dsMmH0NWa1G13ySPjbyf6mHgBM8XFW
         awTpTj3y6ZNo8syHBVVqCffnDtMMsfcJmQRzAPdvKMObmzRMtYqliuT7AJsxg4JsPobJ
         jHDSeL5BXOGYMhPjuv4eBa5C6GV1qx7NEDag8t6X4f86oWk5f8a3nsW5a7m0ZS+79igG
         2fJQ==
X-Gm-Message-State: AOAM531Xcw7hhFMipLyVOe13W3qntP++UEfEx2XiFoWxdquJZ/ZOsQof
        fWw2xzQ7uZkEFHps6LH+17PpPqQopXwleInE090=
X-Google-Smtp-Source: ABdhPJzxHxKSdk0Dj+lO194Gn8/F73KIgAJgGJDLCUsOQGbvZE15hvUqg3YUyBnAzqX8BDkVYN0KN5jWL81/Z3ID4DA=
X-Received: by 2002:a17:906:a458:: with SMTP id cb24mr10724072ejb.482.1623571912966;
 Sun, 13 Jun 2021 01:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210613004434.10278-1-felipe.contreras@gmail.com>
 <CAPig+cSE2h7A52drhELfZJLDEgQ1z+nEXoXhYMUSA00Z+S=OUA@mail.gmail.com> <60c588d452750_3d86c2085c@natae.notmuch>
In-Reply-To: <60c588d452750_3d86c2085c@natae.notmuch>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 13 Jun 2021 04:11:42 -0400
Message-ID: <CAPig+cQhve3pTdrm8ZeJ8-YPJj4gWrk=BB9rLqRojXgYJrAi2Q@mail.gmail.com>
Subject: Re: [PATCH] doc: revisions: improve single range explanation
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 13, 2021 at 12:26 AM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Eric Sunshine wrote:
> > For what it's worth, as a person who is far from expert at revision
> > ranges, I had to read this revised text five or six times and think
> > about it quite a bit to understand what it is saying,
>
> Can you explain why?

Probably not to a degree which will satisfy you. And I'm not being
flippant by saying that. I mean only that it is more than a little
difficult to explain why one thing "clicks" easily in the brain while
something else doesn't. I can only relate (to some extent) what I
experienced while reading your revised text.

> This is the context: commands don't generally take two ranges:
>
>  1. Unless otherwise noted, all git commands that operate on a set of
>     commits work on a single revision range.
>
>  2. Doing A..F will retrieve 5 commits, and doing B..E will retrieve 3
>     commits, but doing A..F B..E will not retrieve two revision ranges
>     totalling 8 commits.
>
> At this point what isn't clear? Isn't it clear that `A..F B..E` aren't
> two revision ranges?

The documentation stating explicitly that `A..F B..E` is not two
ranges is fine. What was difficult to understand was your explanation
of _why_ those are not two ranges. In contrast, I had no difficulty
understanding Junio's explanation of why that is not two ranges.

>  3. Instead the starting point A gets overridden by B, and the ending
>     point of E by F, effectively becoming B..F, a single revision range.
>
> What isn't clear about that? A gets superseded by B because it's higher
> in the graph. And if you do `git log D E F` it's clear that doing
> `git log F` will get you the same thing, isn't it?

One of the reasons I had to re-read your text so many times was
because it was difficult to build a mental model of what you were
saying, and to follow along with all the "this replaces that" and
"this other thing replaces that other thing". While doing so, I
repeatedly had to glance back at the original `A..F B..E` to make sure
the mental model I was building was correct or still made sense. The
word "overridden" didn't help because I couldn't tell if, by
"overridden", you meant that something got replaced by something else
or if something was merely ignored. (Or maybe those are the same thing
in this case, but how will a newcomer -- who is trying to learn this
from scratch -- know which it is?)

However, an even bigger problem I experienced while reading your
revised text is that it felt like it was trying to express some rule
which the reader should internalize ("replace this with that, and
replace this other thing too") with no proper explanation of _why_ the
rule works that way. Worse, the rule (whatever it is) never actually
materialized or solidified in a way which I could understand and thus
apply to in other situations. Junio's explanation, on the other hand,
was simple and to the point, and (for whatever reason) clicked easily
in my brain, such that I came away feeling that I could apply the
knowledge immediately to other situations. On the other hand, after
reading your proposed text, I did not feel as if I had gained any
knowledge, and even had I picked up the rule which seems to be in
there, I likely still wouldn't have understood _why_ that rule works
or is needed; it would just have been some black box.

> > Also, if this explanation is aimed at newcomers, then saying only
> > "doing A..F will retrieve 5 commits" without actually saying _which_
> > commits those are is perhaps not so helpful.
>
> It doesn't matter which specific commits are retrieved, the only thing
> that matters is that `X op Y` is not additive.

The very first question which popped into my head upon reading "Doing
A..F will retrieve 5 commits" was "which five commits?". Not being
told the answer by the text did not help me feel confident that I knew
the correct five commits. Had the text stated explicitly "the five
commits B, C, D, E, F", then there would be no question and no feeling
of uncertainty about it. So, whatever precision your above statement
might have, it is likely to be lost on the general newcomer who is
simply trying to learn about and understand Git revisions.

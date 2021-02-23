Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65821C433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 00:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0859164E4A
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 00:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhBWA4X convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 22 Feb 2021 19:56:23 -0500
Received: from mail-ej1-f45.google.com ([209.85.218.45]:37363 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhBWA4V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 19:56:21 -0500
Received: by mail-ej1-f45.google.com with SMTP id d8so32136178ejc.4
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 16:56:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mdCp2Ni4xyUKKEzXgyz79C31FfZyOxV12E4xdJHWwCI=;
        b=CUUlw8pJ7ykUq0zi39UFmFZRKIkfjpkaZEv8JZonBQj58jj1rzu5IItN3otmbDtyG7
         wrfjL0AKz2gCN8PViHz/LmIQJPjNhBClDGx6HQurqUyMkMofxZtGKrcxjWdpmbWwUxEt
         Fj0HOszov4foL24D2GDAolMH50ZgXA4mtgXDw5LAQwJBUdy7cCQLHeWDCncDXQ9O7eMB
         Nuppp6cEfbMifIUPu1G4lSNMbaFK5TEWeuzYxXUs4ZAMVN9rK0s8CbmyQGljB/NeL1UV
         amDIwdHfIV7Etgu4RP6Pycqz/906IB8HBKjbGmuekh5kOlz0BTp+852t+13Klx+v8AM2
         YOqA==
X-Gm-Message-State: AOAM532WjeJOkh6Vgg2hXbfvn3HfV/jSAqI4ugZ1I1Lhylibheg8qW/W
        p0p6OlylJCijBUVhfnLsTjStzNRG2sa4OYfwb6E=
X-Google-Smtp-Source: ABdhPJwPpollkIHZg9vIjqNlN1s6AorFgvsbscayQO2Ebk9yPGB56HH1bWM3H59c8ZrzDX8wZR+mm6Kuq0mTqt+1Rvs=
X-Received: by 2002:a17:906:a1c2:: with SMTP id bx2mr23928726ejb.138.1614041739263;
 Mon, 22 Feb 2021 16:55:39 -0800 (PST)
MIME-Version: 1.0
References: <jwvwnwqrqwd.fsf-monnier+gmane.comp.version-control.git@gnu.org>
 <CABPp-BE1QXA0ohB9D-tqKpzDTok0BMsGQjotmcqMxfs9AL5noA@mail.gmail.com>
 <CAPig+cRzXd+zd+xVisaW+HToSaGzAE28acGmxwRxNU4bczHXbw@mail.gmail.com>
 <87wnv688u4.fsf@evledraar.gmail.com> <CAPig+cQ9oqMWjBkyRt-SQFuyfAGkMu1J-U6ZCCJqeL0a_3ynkw@mail.gmail.com>
 <87ft1o8mi0.fsf@evledraar.gmail.com> <CAPig+cSkL+5otKUWwm=CLaRR+j71wW61U7LWtmuUHO+7bZaY_g@mail.gmail.com>
 <87czwr8wou.fsf@evledraar.gmail.com>
In-Reply-To: <87czwr8wou.fsf@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 22 Feb 2021 19:55:28 -0500
Message-ID: <CAPig+cQxYtw5z_bRQbS6MLgHQM2OTs5oRfpvKSOwZo8GcuwpTg@mail.gmail.com>
Subject: Re: New orphan worktree?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Stefan Monnier <monnier@iro.umontreal.ca>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 22, 2021 at 7:17 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Tue, Feb 23 2021, Eric Sunshine wrote:
> > I'm not sure I follow. In git-switch, --orphan does not imply -c even
> > though --orphan also creates a new branch (thus seems to work similar
> > to -c); it is nevertheless mutually-exclusive with -c and -C. The same
> > goes for --orphan in git-branch.
>
> I think we're on the same page with regards to what I meant. I.e. I
> don't see how it makes sense to conflate the type of branch we want
> (orphan or not orphan) with whether we want to clobber that branch or
> not (switch -c or -C, or worktree -b or -B)

I see where you're coming from in viewing --orphan as a modifier of
branch creation rather than as a branch-creation option itself.
However, as far as UI is concerned, that ship sailed a long time ago,
I suppose.

> > As far as combining --orphan and -C (or -c), I'm not sure how we would
> > arrange that using the existing parse_options() mechanism. It seems
> > too magical and has potential for weird corner cases.
>
> Isn't it just having --orphan be an OPTION_STRING with
> PARSE_OPT_LASTARG_DEFAULT. I.e. to support:
>
>     git switch -b branch --orphan
>     git switch -B branch --orphan
>     git switch --orphan branch
>
> And:
>
>     git worktree add -b branch --orphan
>     git worktree add -B branch --orphan
>
> I didn't test it, just skimmed the code.

I haven't dived into this stuff in a long time, but I'm having trouble
convincing myself that it would work out as intended. If I'm reading
PARSE_OPT_LASTARG_DEFAULT correctly, `git switch -b <branch> --orphan`
would not be the same as `git switch --orphan -b <branch>`, and I
don't think it would work at all for git-worktree-add which has
additional <path> and <commitish> arguments (i.e. `git worktree add -b
<branch> --orphan <path> [<commitish>]`).

Anyhow, as I responded elsewhere to Junio, my present leaning is
toward -b, -B, --orphan all being mutually-exclusive branch-creation
options, each taking a <branch> argument -- just like they are in
git-checkout and git-switch (-c/-C, in this case) -- and allowing
--force to overwrite an existing branch (in which case, -B can be
viewed as shorthand for `--force -b`).

> > Since git-worktree doesn't yet support --orphan, we certainly have
> > more leeway and could go with your proposal of having --orphan be
> > boolean and always requiring it to be used in conjunction with -b/-B.
> > However, I'm quite hesitant to take that approach since it breaks with
> > existing precedent in git-branch and git-switch, in which case
> > --orphan takes its own argument (<branch>) and is mutually-exclusive
> > with -b/-B/-c/-C.
>
> In git-branch? Isn't it only git [checkout|switch] that takes --orphan?

Um, yes, I meant git-checkout everywhere I wrote git-branch. Sorry for
the confusion.

> I think not having a -B or -C equivalent at all would be preferrable to
> having a --force special-case just to work around the lack of it for
> --orphan.

I'm having trouble wrapping my brain around this statement.

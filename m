Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35980C3525A
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 01:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbiAZBiv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 20:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbiAZBiv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 20:38:51 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8112C06161C
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 17:38:50 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ka4so34980785ejc.11
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 17:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ce2rYcF1EYI2RXdJ7+1dUZ+A2uZEB0/QXltnm1O0pSo=;
        b=AlChzV1Rf++u43qO3Z3FrowzflGyn9UjtRqJqhvTOnSjqCEM3fljRbmM8BPADg+9EL
         Gv2yasLrUe8S/jlxDoBNVRW/PO6p9VZPsvQo/aNMpZTdTI9EBTTujbQIY/TBUf6w+2op
         V3cgu1lKKbqEygtXd58MEf/OC6Hakh0/oQEkku1ODmzOQm3kGELc9aBRXw7cfGkNdpdO
         bas9v1gziclq4stXiwajNp21l7WIrZeCueMK6rcgY5Mo/V1JPBbZvDw2/Y9+jDQuEhIz
         11eVVttIin1nqMeVotjPhX+jtQk50qBmjxdxYTrDmvKifQ16hlzlPilusK1P8v58Z5qq
         4u3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ce2rYcF1EYI2RXdJ7+1dUZ+A2uZEB0/QXltnm1O0pSo=;
        b=TjAmFD0Ed5fFIxSlDXKm88Mkq+ZvWUrHepc2Qsz5jkmyKAxbMEyBfL6CFC9nJk89sk
         KcSzhcXP6Ywfe7SGeN6OdIMJxM3R0gjC+bdwwsrBRHROFAbXceWakZVxUgnFE8HLVRzE
         YR8/uTmSusEtDMJ10Q4gG5prSDStUOdeLVDLzhTHQ2t5aBZizWJPxfB6ECWjV5Xldj64
         lapBd3YC1tOxZb0CTvIqjCfTlNZj003XjPWTSTHkBzJxJsFFncMnQyIo3Y9aasEyfo8I
         WYQm/ETztXzNrxu02aAglPWMXwjXhrrKKIoaSVvSL1ZapWQooFd5QC77GZrRjoBtr7cc
         CduQ==
X-Gm-Message-State: AOAM530DiB2YHkVJ1LyZgwdaQG9Wn4yjMyIaVNV0bxVJRSu/UcZNYonF
        jFDwtY00PbfeXRtQMAoBAHBofDZIn0hLZJLlSxc=
X-Google-Smtp-Source: ABdhPJxWHcFcJltFRkCLBVJASnqkhwgkXEJ0SCh2Hv4cOzgo8vBip9ZZ3bZYEitJ8wCSXtoHt0gg6X+lx7o+5JqikCE=
X-Received: by 2002:a17:907:8687:: with SMTP id qa7mr3038104ejc.328.1643161129271;
 Tue, 25 Jan 2022 17:38:49 -0800 (PST)
MIME-Version: 1.0
References: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
 <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com> <f8efb7446c33f14631b088ac043aca8a403a3250.1638340854.git.gitgitgadget@gmail.com>
 <kl6lilu71rzl.fsf@chooglen-macbookpro.roam.corp.google.com>
 <CABPp-BFdD=f82QvQfokD346YT6aCQ=WwZ09S-a=BPXXj5_LZkg@mail.gmail.com>
 <CAPig+cT3Zqa2BLsZ3ZVPCj4-bW5eb35sWXV-mYLqA-dvzC8XJg@mail.gmail.com>
 <CAPig+cRCzUinKr0iQkDMK0Af4=47xKZJKphcuTRxt4BaxrYwfA@mail.gmail.com>
 <CABPp-BG2__OLFkOcJnH-V8SC3hrRRrB1zv+KEOiNfoQYB9Ehpw@mail.gmail.com> <kl6l7dan1enb.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6l7dan1enb.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 25 Jan 2022 17:38:38 -0800
Message-ID: <CABPp-BHwRLER2yWAwU88Fu6sw7ObMOr-HRN-jngo881+47WzYg@mail.gmail.com>
Subject: Re: [Bug] Rebase from worktree subdir is broken (was Re: [PATCH v5
 07/11] rebase: do not attempt to remove startup_info->original_cwd)
To:     Glen Choo <chooglen@google.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 25, 2022 at 5:15 PM Glen Choo <chooglen@google.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Tue, Jan 25, 2022 at 4:39 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> >>
> >> On Tue, Jan 25, 2022 at 7:32 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> >> > On Tue, Jan 25, 2022 at 6:59 PM Elijah Newren <newren@gmail.com> wrote:
> >> > > On Tue, Jan 25, 2022 at 12:27 PM Glen Choo <chooglen@google.com> wrote:
> >> > > > +test_expect_success 'rebase when inside worktree subdirectory' '
> >> > > > +       git init main-wt &&
> >> > > > +       (
> >> > > > +               cd main-wt &&
> >> > > > +               git commit --allow-empty -m "initial" &&
> >> > > > +               # create commit with foo/bar/baz
> >> > > > +               mkdir -p foo/bar &&
> >> > > > +               touch foo/bar/baz &&
> >> > > > +               git add foo/bar/baz &&
> >> > > > +               git commit -m "add foo/bar/baz" &&
> >> > > > +               # create commit with a/b/c
> >> > > > +               mkdir -p a/b &&
> >> > > > +               touch a/b/c &&
> >> > > > +               git add a/b/c &&
> >> > > > +               git commit -m "add a/b/c" &&
> >> >
> >> > This is entirely minor, but all the inner subshells in this test are
> >> > superfluous. [...]
> >>
> >> One other minor comment: If the file's timestamp has no significance
> >> to the test, then our style is to create the file with `>` rather than
> >> `touch`, so:
> >>
> >>     ... &&
> >>     >foo/bar/baz &&
> >>     ...
> >>     >a/b/c &&
> >>     ...
> >
> > Ah, good point.  And while at it, we can replace the touch/add/commit
> > sequence with a simple test_commit call.
>
> Yes, thanks for pointing that out - I had copied my reproduction script
> into the test case without paying enough attention.

To be honest, it's the kind of thing others have reminded me of dozens
of times.  In fact, although I read your testcase, it didn't even
occur to me until Eric brought up ">" instead of "touch" (which was
something else I had been reminded of dozens of times before
learning).

To me, it's all small potatoes compared to coming up with a good
reproducible testcase; that was the hard work, and you did that.  You
even found a fix and called out the right things in the review for
others to look at.  So, it's all good.

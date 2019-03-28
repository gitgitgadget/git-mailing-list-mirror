Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AB1920248
	for <e@80x24.org>; Thu, 28 Mar 2019 17:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfC1RkA (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 13:40:00 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34154 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfC1Rj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 13:39:59 -0400
Received: by mail-vs1-f66.google.com with SMTP id t78so12658733vsc.1
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 10:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cmwlkW88pO7J/chDjet5wH+66tXo0Dm7SXZShbxnS0Q=;
        b=TuYc+Fnmuevj8Yj+cpfVOY/T21wBV4u8OTei9bc3IHw2ATJCr+d0J8mPK761dUIING
         4QPKFuM5cGAaZE0JJr9QtYELCGzU2CLZZIqOHUiZw4UzcdW3kQ7RYVwDTFtO/Se65QVY
         OZuGILj6ts07AvAPY5jzxQF8IZd9ZctXcmEbhICka0oSKpU+EXUpc/h5NRbLvopLwSuC
         c545qe0mlCgFnkq9sjSS4LprtxeSfl0cAFey8tkfbWsk86T/iihtQZjbaHXyngL95RU9
         3KX2jvMKpTGl5+KDEaYIWLDe8VINb2j2gkWvkKxwZI+2WcA2ahet9CbJsoLya7Ywz8zS
         bKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cmwlkW88pO7J/chDjet5wH+66tXo0Dm7SXZShbxnS0Q=;
        b=KsgBcVc3rHzIWHxxXm+It4g8kvEOJSAHJ6QJSXoQTxdcaJHWa6YOFF+kfU0QcUHTBb
         YOYtkWqAdd5iHYt7v0NdTtS8H3sCybQi/8UeHn8vAR+lu3rFUb/VQjipKyVEwwJWOxcG
         RTxJm/XFOAOvQl5XGp3Hk5VE58nW0xqY+RR8G6LTrW3NdH0WxleaOXvxopdJz7cRt8Li
         FVZZq8EZIKqn0Ke8pIGXhGeUp3rcVzpTYWEbtZy/rkOk2zrUbeO4DWsiZeW8LQj6m1GC
         HR7fCnVqdHAmbhrtmUMe0rT/MfItsjGXmhkrAjCowBZ9fLy0s0+eLMq7E5GH6/hynYo+
         aARg==
X-Gm-Message-State: APjAAAVh5KdAbf8ErAHhRrWY3ssdFK8e3Xz7J9feFDXq6bSC7zbBHUkY
        wWxa7fOJ5NY4NEAHJofzOpGaFvB7yWWO1uQK4Ac=
X-Google-Smtp-Source: APXvYqxNmMiCSlQUVyEKSpjdJMWc8CQYHeCibL6Jp/5C7M0Bd3I8WSw7vsHLJcdC+hPunxm8fATU3ReQL3vKnVzBaPE=
X-Received: by 2002:a67:ad0a:: with SMTP id t10mr27260710vsl.117.1553794798150;
 Thu, 28 Mar 2019 10:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com> <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
 <CACsJy8Axa5WsLSjiscjnxVK6jQHkfs-gH959=YtUvQkWriAk5w@mail.gmail.com>
 <CABPp-BEksf4SuD57YsUO3YKhU12CAwFTy6pA1tETFrHB1DAz9w@mail.gmail.com>
 <CACsJy8DPDEvNDeE5MpqcGZk9jRmT9g=ix+MOhkv+50J3Egef7A@mail.gmail.com>
 <CABPp-BFTyALWmnJ=dT1xNivjcQhtKak15ydfkYjEsEC-j4BD9w@mail.gmail.com>
 <0dc8820c-c6b0-c4ca-2107-84061fdc5333@gmail.com> <CACsJy8AmgDh1Z4CKTzSAVrywo0q-CFKbpuyqdtRm9m7pkUweSw@mail.gmail.com>
 <a68ce0b4-81c5-e889-fc90-ed8b17a10d4a@gmail.com>
In-Reply-To: <a68ce0b4-81c5-e889-fc90-ed8b17a10d4a@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 28 Mar 2019 10:39:45 -0700
Message-ID: <CABPp-BHsD=o=3jPKH6gH+XbEdNVqzhr18BSfupbaSNpxAgaqdw@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, Mar 28, 2019 at 9:23 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> On 28/03/2019 11:04, Duy Nguyen wrote:
> > On Wed, Mar 27, 2019 at 5:24 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
> >> On 26/03/2019 15:48, Elijah Newren wrote:
> >>> On Tue, Mar 26, 2019 at 8:24 AM Duy Nguyen <pclouds@gmail.com> wrote:
> >>>> On Tue, Mar 26, 2019 at 10:01 PM Elijah Newren <newren@gmail.com> wrote:

> >>> Yes, and in the middle of a cherry-pick with a range you've added some
> >>> commits to one branch and some to another.  In the middle of a revert
> >>> you're doing similar.  It sounds like crazytown to me (and maybe we
> >>> shouldn't provide the --ignore-in-process flag unless users clamor for
> >>> it
> >
> > I missed this part in my last reading. I think if we could safely
> > switch away and get back to resume, then --ignore-in-process could
> > still be useful.
>
> If we can get back safely then that makes sense, I'm not sure about
> switching while there are conflicts or staged changes though, it feels
> like there's more potential for things to go wrong there.

I really like that way of putting it; I think that makes it much
clearer.  Note, though that staged changes and conflicts could happen
with any of rebase, merge, cherry-pick, or revert, so this problem is
not limited to a subset of those operations.

> > I sometimes switch to another commit to check out
> > stuff then back. For interactive rebase with "edit" command for
> > example, it's quite safe to do so. (yes the other option is "git
> > worktree add", but that could be a heavy hammer sometimes)
>
> >> I think that could be the way to go for merges and cherry-picks, or
> >
> > Just so we're clear, what is your "the way" to go? to remove
> > CHERRY_HEAD_PICK and MERGE_HEAD (and other MERGE_* as well) if
> > --ignore-in-process is specified? Or to leave MERGE_* and
> > CHERRY_PICK_HEAD alone and delete other stuff?
>
> I was agreeing with Elijah about dropping --ignore-in-progress unless
> there's a demand for it or at least restricting it so that it requires
> --discard-changes and aborts in-progress merges and single in-progress
> cherry-picks/reverts. (I'm worried about people switching branches when
> cherry-picking more than one commit, though as you say it can make sense
> during a rebase.)

I understand the desire to prevent mis-uses, and I agree that if there
are staged changes or conflicts it's really likely things will go
sideways.  But I think we should instead check for those situations
rather than use e.g. rebase vs. merge as a proxy for whether those
problems could be present.  I am especially concerned with the idea of
having something like "git switch --ignore-in-progress
--discard-changes" being used to quit merges or cherry-picks or
reverts or even rebases.  In my opinion, doing so is creating flags to
combine uncommon pairs of git commands (git <operation> --quit + git
switch) in a way that is far less clear.  I think that's a bad route
to go down, and we should keep the commands orthogonal (if I could
start all over, I'd also make reset and checkout and everything else
stop modifying any in-progress state).

Instead, I would either:

  * Drop `--ignore-in-progress` for now.  (Although Duy had a
meaningful usecase)

OR

  * Make `git switch --ignore-in-progress <branch>` leave all process
state in place and switch branches, if we would otherwise be able to
switch branches (i.e. there isn't dirty or conflicted changes in the
way).  BUT, make sure to also:
  * Make '--ignore-in-progress' incompatible with both '-m' and
'--discard-changes'; if folks try to use either of those additional
options with --ignore-in-progress, tell people to use `<operation>
--quit` first.  Do NOT provide an override. (Alternatively, refer to
`<operation> --quit` as the override, since it is).


Elijah

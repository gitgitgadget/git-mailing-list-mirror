Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A631420248
	for <e@80x24.org>; Thu, 28 Mar 2019 15:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfC1PFl (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 11:05:41 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:40128 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfC1PFl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 11:05:41 -0400
Received: by mail-vk1-f194.google.com with SMTP id l17so4589259vke.7
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 08:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uEYAZmyOe7YoT4pw7bw5sqjs3hwBngfyUBScYzTEP6k=;
        b=HUTToib4Kug1L68pi9IrT+Ihm8+EqH3mIt/JvSrmpSEMwoIsndLrFZcQ0dDJLCgCQA
         TkeIDLtgcgqWHdAa5H4AjNKBLZdhh7U6LENcMjNewvHiUjl69wLJQ+btLT2kdPbDHZ62
         XxZAF5Un8C7eXkX0auICre0bhZ2dVidvUGX6phh3x+pocvd+pa6bSVXfg2+h0434SFmO
         QL4rcj5aIN6fdgpSek4ZWo4mOnRfuhgB+tVjTNdTgBtBw/NmF/xPRAJd5y8f8DJuJ37x
         9175kT71N97InsU5TvQbb36JpzmhBvBAbWdNeYBfsTLINgrkX5ZsLf/3WsHH2TuwP2HP
         /+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uEYAZmyOe7YoT4pw7bw5sqjs3hwBngfyUBScYzTEP6k=;
        b=VCIdssxj/XgkL45Lgev7DsJUoSchn1MqAGj/uni/8cU9BIxt8MFH5AS9VHy7UPloEW
         JzyJG6RnLDQr2ok+/4SnsikMkjV2+TNsHAlW+/i2wMncjZMhKJrz5rcy9KitsC/8spMK
         7CCJYQPD23Ft7TE+a+FHFXP7/o2yD3hwFQbq0liZkcDDXfbOV++/oDdqdjwotO1uw62k
         wNYu00A8dURrE5tC3S7EdHeWzFbhm83TZdW731NYRdGtfYb3mde1lw9WppP1ygFLH6aS
         1kwbkfUpJ4awDn/mVo1LJBR/KHzFZxIwmFZH4wgiyPzB1xyBw5JKUcv2YyegTQ1+qBST
         1Uqg==
X-Gm-Message-State: APjAAAUaPlwbabuMCTDgme4sTo6QaQXlE2n4ZPC//iEU6fxQ6PbixTvc
        48JzNoMSEHRLama4JjkgqIq4EWZK4X3vwDEPWSk=
X-Google-Smtp-Source: APXvYqyEY8p1eikymgfz1rJ8Q8qPk0utx9Bbu2l0LXtfu4XFKhV/xKhUC6ZbJrKJBlmnaHhNqNCE1t0OR70VxjpJNxI=
X-Received: by 2002:a1f:2acb:: with SMTP id q194mr24886529vkq.92.1553785539717;
 Thu, 28 Mar 2019 08:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com> <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
 <CACsJy8Axa5WsLSjiscjnxVK6jQHkfs-gH959=YtUvQkWriAk5w@mail.gmail.com>
 <CABPp-BEksf4SuD57YsUO3YKhU12CAwFTy6pA1tETFrHB1DAz9w@mail.gmail.com>
 <CACsJy8DPDEvNDeE5MpqcGZk9jRmT9g=ix+MOhkv+50J3Egef7A@mail.gmail.com>
 <CABPp-BFTyALWmnJ=dT1xNivjcQhtKak15ydfkYjEsEC-j4BD9w@mail.gmail.com>
 <0dc8820c-c6b0-c4ca-2107-84061fdc5333@gmail.com> <CACsJy8AmgDh1Z4CKTzSAVrywo0q-CFKbpuyqdtRm9m7pkUweSw@mail.gmail.com>
In-Reply-To: <CACsJy8AmgDh1Z4CKTzSAVrywo0q-CFKbpuyqdtRm9m7pkUweSw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 28 Mar 2019 08:05:27 -0700
Message-ID: <CABPp-BHQCy4zUEhFvLpjs8vMFq7vTaHzbe6BoJxCShxYtk7K9w@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
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

On Thu, Mar 28, 2019 at 4:04 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Wed, Mar 27, 2019 at 5:24 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
> >
> > On 26/03/2019 15:48, Elijah Newren wrote:
> > > On Tue, Mar 26, 2019 at 8:24 AM Duy Nguyen <pclouds@gmail.com> wrote:
> > >> On Tue, Mar 26, 2019 at 10:01 PM Elijah Newren <newren@gmail.com> wrote:
> > >
> > >> Yeah.. --ignore-in-process does not necessarily mean aborting
> > >> something when you just want to get out to examine some other commit.
> > >> And I agree doing nothing seems like the best (or least
> > >> confusing/surprising) option.
> > >>
> > >> There will be some funny thing. Like if you commit after switching
> > >> away and MERGE_HEAD is there, I think you will be creating a merge
> > >> commit.
> > >
> > > Yes, and in the middle of a cherry-pick with a range you've added some
> > > commits to one branch and some to another.  In the middle of a revert
> > > you're doing similar.  It sounds like crazytown to me (and maybe we
> > > shouldn't provide the --ignore-in-process flag unless users clamor for
> > > it
>
> I missed this part in my last reading. I think if we could safely
> switch away and get back to resume, then --ignore-in-process could
> still be useful. I sometimes switch to another commit to check out
> stuff then back. For interactive rebase with "edit" command for
> example, it's quite safe to do so. (yes the other option is "git
> worktree add", but that could be a heavy hammer sometimes)

Ah, switching not for the purpose of continuing the operation
elsewhere, but just to check things out with the intent of coming back
before continuing.  That does make sense.  Please do add a warning
when users do it, though.

> > I think that could be the way to go for merges and cherry-picks, or
>
> Just so we're clear, what is your "the way" to go? to remove
> CHERRY_HEAD_PICK and MERGE_HEAD (and other MERGE_* as well) if
> --ignore-in-process is specified? Or to leave MERGE_* and
> CHERRY_PICK_HEAD alone and delete other stuff?

Personally, I don't think `switch` should modify in-process state of
other operations ever.  Not merge state, not cherry-pick state, not
rebase state, not bisect state, etc.  And default should be for it to
error out if any such state exists.  In-process state should be
updated almost exclusively by `<operation>
--(continue|abort|skip|quit)` (or in bisect's case, the
bad/good/skip/reset commands).  They only reason I put the 'almost'
qualifier in there is that I'm not opposed to the _reset_ command
continuing to do some things with state because of backward
compatibility (and I might begrudgingly admit the same for other
commands if they touch it though I'm tempted to say any command other
than reset and the operation itself that touches in-process state
represents a bug that should be fixed).  However, I very much want to
steer users away from using reset (or other commands) to change state
and guide them to instead use `<operation>
--(continue|abort|skip|quit)`.  I think we make things confusing and
do users a disservice by not having in-process state be a totally
orthogonal thing that is only updated by that process's subcommand.

If people use --ignore-in-process, I think the state should remain and
we should give a big warning to the user about how the operation is
still in progress and likely to give very confusing results and
suggest either switching back to the current commit or running
`<operation> --quit` for them to clear it.

Also, if --ignore-in-process still fails because they need
--discard-changes too, then we could give a really obnoxious warning
about how they should probably consider --quit first if they really
want to switch.

> > possibly require --discard-changes as well. The only time I use checkout
> > like this is during a rebase if I want to rewind it - I edit the todo
> > list with the output of 'git log --pretty="pick %h %s" --reverse' and do
> > 'git checkout' followed by 'git rebase --continue' Though these days I
> > could add a 'reset' line to the todo list and skip the checkout.

I think Phillip's usecase is entirely consistent with the
don't-have-switch-touch-process-state view.


Hope that helps,
Elijah

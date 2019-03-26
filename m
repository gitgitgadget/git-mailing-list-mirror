Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7185820248
	for <e@80x24.org>; Tue, 26 Mar 2019 15:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731560AbfCZPYn (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 11:24:43 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:52665 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731475AbfCZPYm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 11:24:42 -0400
Received: by mail-it1-f193.google.com with SMTP id g17so20178508ita.2
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 08:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dnA1ug67f0WazhU9g8SmfboPmqCZU1SEsN6ghlzhTe0=;
        b=tFpzPeAuJR134QNnBdYKhd6YK0/BUeB9x0V9oJcQ8xuys3T/a7Ny+/CyiZSh+hHY0B
         LUHJ9N52a4GXUmw9PaSSr5jh02K3vWwxK7MYShGWTNMtmOiBOfUkLxB3AOeqd/+uu86I
         47iVmnwqA6IrbYAVAh9t1HBviWRIA6ZV7HiqQGT12VRpZruMqmKeBcuefRtJCBwsa7ol
         bU2RfTe60o8TEgIgimKC1vHqD1glxGHs6QIzGokxYm2YY1DlURnimud6yCy3LxcstPaO
         e7JxIh5e94mWV9VrG/eWMlB62zsy1Pk8mVscPoelz6U1Xdenv12y74Cb6c0A0y9PcfzW
         Ic7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dnA1ug67f0WazhU9g8SmfboPmqCZU1SEsN6ghlzhTe0=;
        b=MVFVwcCl3rtrRoNRKmWcjFDcIPrN4VqZryGX51r16ql/rVMLhsC05yEcDC78eyU0/I
         1RxHVOFyJt07JmV0vU6WKs2G+oVFcvegh8qJDVEqv6WH++amddFAFyHKbfFItncWvaM5
         72soVsAyBCoREZf5KloTYWK/FVN17UBPnMtxWM02aKoEsPSPgFA50meyk25PSwBTHSW4
         dTM5JfPsQJMw/BgIxOu9i3Xv4n5KidnJRLWlViC/X1DD7noe6lMysN3qjPunH/n2CODT
         D/krFxegKbCXzM19unrd2YGz/BG1SIuX/uRAi69scAqL3zco4SVeayWpqrrUUu4kdgaV
         ofcA==
X-Gm-Message-State: APjAAAWEvdmsC89xeU+DIah1Fc2QcnLXHWcC1FWAyqtni/rEVikUaxDm
        aC9AS0yGTLWxV/agjKbZ/v+WKjbfAACGKf+raq8=
X-Google-Smtp-Source: APXvYqxqGlG18md8daLTdqpFhIxPkeonHL2MYUoaibGY6w4MpRklnYH6ZuSmvnxzQq2VgN0MF/llA76c+IcPLZ4xVOQ=
X-Received: by 2002:a24:ccc5:: with SMTP id x188mr646002itf.123.1553613881416;
 Tue, 26 Mar 2019 08:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com> <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
 <CACsJy8Axa5WsLSjiscjnxVK6jQHkfs-gH959=YtUvQkWriAk5w@mail.gmail.com> <CABPp-BEksf4SuD57YsUO3YKhU12CAwFTy6pA1tETFrHB1DAz9w@mail.gmail.com>
In-Reply-To: <CABPp-BEksf4SuD57YsUO3YKhU12CAwFTy6pA1tETFrHB1DAz9w@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 26 Mar 2019 22:24:14 +0700
Message-ID: <CACsJy8DPDEvNDeE5MpqcGZk9jRmT9g=ix+MOhkv+50J3Egef7A@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
To:     Elijah Newren <newren@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 26, 2019 at 10:01 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Tue, Mar 26, 2019 at 5:50 AM Duy Nguyen <pclouds@gmail.com> wrote:
> > On Mon, Mar 11, 2019 at 6:16 PM Phillip Wood <phillip.wood123@gmail.com=
> wrote:
> > > On 08/03/2019 09:57, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> > > > "git checkout" doing too many things is a source of confusion for m=
any
> > > > users (and it even bites old timers sometimes). To remedy that, the
> > > > command will be split into two new ones: switch and
> > > > something-to-checkout-paths.
> > >
> > > I think this is a good idea, thanks for working on it. I wonder if it
> > > would be a good idea to have the new command refuse to checkout a new
> > > branch if there is a cherry-pick/revert/merge/rebase in progress (wit=
h
> > > an option to override the check) as switching branches in the middle =
of
> > > one of those is likely to be confusing to users (if I do it it is
> > > normally because I've forgotten that I've not run 'git whatever
> > > --continue').
> >
> > Guys, I'm sorry for bringing this up again. Apparently I'm not quite
> > done with 'git switch' yet (not sure if I will ever be).
> >
> > There is an interesting behavior in git-checkout (and of couse
> > git-switch). When you do a successful switch, CHERRY_PICK_HEAD,
> > REVERT_HEAD, MERGE_HEAD, MERGE_RR, MERGE_MSG, MERGE_MODE and
> > SQUAHS_MSG, if exists, will be removed.
> >
> > This basically means that if you switch away, any cherry-pick, merge
> > or revert in progress is destroyed (in the sense of "--quit" not
> > "--abort" of course). All of this, I believe, involves merge conflicts
> > so you can't easily switch away unless you allow to destroy unmerged
> > entries. So it's still quite safe.
> >
> > However, it leaves me a funny feeling because some "work-in-progress"
> > operations are destroyed, but some others (bisect, rebase) are not.
> > This is git-checkout behavior and I will not change that. But do we
> > want the same behavior in git-switch? Or do we want
> > no-destroy-in-progress-whatsoever? Or
> > destroy-all-commands-in-progress?
>
> I thought we already decided that we'd abort the switch if there was
> any operation-in-progress state?  Or are you asking what should we do
> if the user explicitly overrides this error with e.g.
> --ignore-in-progress?  In that case, I'd say that the reasonable thing
> to do would be to leave all the state files alone.  If we make it
> clear out the state, we're simply combining uncommon commands for the
> user (<operation> --quit + git switch), which seems like a bad UI path
> to go down.  Allowing them to switch to some other branch while
> keeping all state files is something they can't do with any other
> command, and while I hope people wouldn't want to do that much,
> switching while keeping state files is something that can't be done
> with combining other commands and thus at least makes sense as
> something to consider providing.

Yeah.. --ignore-in-process does not necessarily mean aborting
something when you just want to get out to examine some other commit.
And I agree doing nothing seems like the best (or least
confusing/surprising) option.

There will be some funny thing. Like if you commit after switching
away and MERGE_HEAD is there, I think you will be creating a merge
commit.

But I guess if you choose --ignore-in-progress, you're pretty much on
your own. We could improve "git commit" and friends to realize that
the current state is unlikely safe to resume whatever in-progress
operations. But that's separate and I don't want to dig another hole
to bury myself in while there's still 'git restore' to take care of.

Or maybe I'll just suggest "git <verb> --quit" when the switch is
successful with --ignore-in-progress.

Will wait a while for people to comment (and work on that 'git switch
--recurse-submodules', which seems also needs some work) before
resubmitting.

> > It may also be a good idea to attempt to describe the behavior we want
> > in git-switch.txt. I think if the description gets too complicated,
> > we're heading a wrong way. The current behavior so far could still be
> > described as "work-in-progress operations related to merge conflicts
> > are destroyed", or something along that line. But I'm not quite
> > convinced it's easily understood.
> >
> > PS. git-reset shares the same behavior, but it's in a different boat,
> > I think. Or maybe I should scrap/replace that one as well.
>
> reset has traditionally been the home of
> how-to-clear-in-progress-state.  e.g. aborting a merge or cherry-pick
> or revert was 'reset --hard' (or later 'reset --merge'), skipping a
> become-empty cherry-pick or rebase is still 'reset', etc.  So it's not
> that surprising to me that it clears out state.
> ...

Yeah but it was surprising to me that this is not even mentioned
anywhere in git-reset.txt. You learn by examples basically, or by
experience. But I digress.
--=20
Duy

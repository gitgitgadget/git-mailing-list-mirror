Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3208A1F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 17:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfDVRu7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 13:50:59 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42107 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfDVRu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 13:50:58 -0400
Received: by mail-lf1-f67.google.com with SMTP id w23so9570133lfc.9
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 10:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2WcTgN6VmJ0Cw9FoPMvQdqZUZ2DVXDCLKGv24MR+9Ss=;
        b=u6Dj8Q+Tnz1gvKsYb+J1rW1CLbydJ3bCc7+t+hHICcUt33tGtrGvUt/UOz/zKWhn02
         uVfexKyIyJK8vVOG09vJ7MAANNo1jUDLgCr4YdgMuz50KdS/yRZ6J6QjHM+pcFE27+ng
         /0aMNG6ch3iO+tsc8kOcFkn/zR80pEm/+ABwcfJ47rlBHkCtpMVArUFtvgFDZad0AEKg
         4iKQsilY8Mm1c/2j85kNsXcYG5JWp0KZ+AoBWj62Kgz9d+9fZbZANtXcBaGj4iSSK/qT
         LV/EnZCwjAwiNRy6ZZ0zC4ael2yaU092TvtMsMH6jkWcr2K0sfFQOkDBGtxKotFexKh8
         Gv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2WcTgN6VmJ0Cw9FoPMvQdqZUZ2DVXDCLKGv24MR+9Ss=;
        b=HQN6VA4KVX0ckvqqb2poo5VodBhbVUot00xr8dFlSNjosQpUEtXccM8xBFP/AMYIss
         pTE3pwNa4fW3piVlxjoJ5Vkwm35pvPiL14N2bRJeMWj5MLRrj1WLNAvzwqBebpjAFUVF
         lmd6h+UdYldfLaMLCK4uzFocldH9o9kp0Nj1a3LgfF5DSQSlD34xp7PiHis743ppA0Jd
         mIeW3mYApL1psrNMqeHx9oHMsq5kbcPZEe37L2kAYEwRGLagsFTxj1vzpRWnZYREa2+q
         cbJp9P7TATmWT1GDhMf/aKx/k7d5iJgc5/PHWS3kpI12Wm/9LTapzSLwjTZ9CC64uyty
         gBbQ==
X-Gm-Message-State: APjAAAXvEXrkjpgACyZg6if7JcC58tUus3AM0I8WzlA6FjoV06VjHj27
        XfF8QUXj+6GyXyQtq3iGRdTOyw4k6fNQJHoTrCQ=
X-Google-Smtp-Source: APXvYqwBTEk72DWwZYuYsgocXnLq+enDlrDRh0oLvDni25WZjRi530owgrr9udfFkyJFmbDNttCXV6tSZSJ2rkAJDIs=
X-Received: by 2002:ac2:51ba:: with SMTP id f26mr11595663lfk.126.1555955456099;
 Mon, 22 Apr 2019 10:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190422000712.13584-1-phil.hord@gmail.com> <xmqqk1fm9712.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqk1fm9712.fsf@gitster-ct.c.googlers.com>
From:   Phil Hord <phil.hord@gmail.com>
Date:   Mon, 22 Apr 2019 10:50:44 -0700
Message-ID: <CABURp0oViG2VFOU2TbXuM3Q7omUFAtBZACH8teuQgPjBwRPL2A@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/2] rebase: add switches to control todo-list setup
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>, Denton Liu <liu.denton@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 21, 2019 at 6:13 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Phil Hord <phil.hord@gmail.com> writes:
>
> > Currently it supports these switches:
> >
> >     usage: git rebase [-i] [options] [--exec <cmd>] ...
> >        :
> >     --break <revision>    stop before the mentioned ref
> >     --drop <revision>     drop the mentioned ref from the todo list
> >     --edit <revision>     edit the mentioned ref instead of picking it
> >     --reword <revision>   reword the mentioned ref instead of picking it
> >
> > I have plans to add these, but I don't like how their "onto" will be
> > controlled. More thinking is needed here.
> >
> >     --fixup <revision>    fixup the mentioned ref instead of picking it
> >     --squash <revision>   squash the mentioned ref instead of picking it
> >     --pick <revision>     pick the mentioned ref onto the start of the list
>
> Yeah, I can see that it may be very useful to shorten the sequence
> to (1) learn what commits there are and think what you want to do
> with each of them by looking at "git log --oneline master.." output
> and then to (2) look at and edit todo in "git rebase -i master".
>
> I personally would be fine without the step (1), as what "rebase -i"
> gives me in step (2) essentially is "log --oneline master..".

My example of "drop" is probably the worst one for simplification, but
it nicely reduces the operation to one step if --interactive is not
given.  More commonly I discover something I want to improve in commit
message or in the code so I use --edit or --reword to fix it up before
I submit it for review.

> So I
> am not quite getting in what way these command line options would be
> more useful than without them, though, especially since I do not see
> how well an option to reorder commits would fit with the way you
> structured your UI.

I thought I might have "--pick-onto foo bar" but that requires two
arguments to one switch, which I think is confusing and unprecedented.
My current thinking is that --pick could pick some commit onto the
beginning of the todo list, thereby picking it onto 'upstream'.  If
the same commit appears later in the todo-list, I am inclined to drop
it; but I might want to pick it anyway and let it evaporate as an
empty commit, giving me the opportunity to split a commit in two
places.  But this is still more exotic and confusing.

I tried to have --fixup and --squash simply do their actions in-place,
but that seems useless.  So I thought I might treat the same as pick,
picking them onto upstream. But it's meaningless to fixup or squash on
the first step in the todo, so it would have to be on the first child
of the upstream.  This still feels forced and useless.

A compromise that feels nice in practice is to do the fixup and squash
in-place and then to use --interactive to open the editor.  Since I
have syntax highlighting, the fixup and squash lines stand out boldly
and I find it easier to move these into the right place as needed. But
I think this mode could be confusing for users trying to understand
the utility of these switches.

> Having already said that, if I were to get in the habit of looking
> at "log" first to decide and then running "rebase -i" after I made
> up my mind, using a tweaked "log --oneline" output that looks
> perhaps like this:
>
>         $ git log --oneline master.. | tac | cat -n
>         1 xxxxxx prelim cleanly
>         2 xxxxxx implement the feature
>         3 xxxxxx document and test the feature
>         4 xxxxxx the final step
>         5 xxxxxx fixup! implement the feature
>
> I think I may appreciate such a feature in "rebase -i" even more, if
> the UI were done a bit differently, e.g.
>
>         $ git rebase -i --edit="1 3 2 b f5 b r4" master..
>
> to mean "pick the first (i.e. bottommost) one, pick the third one
> for testing, pick the second one, then break so that I can test,
> fixup the fifth one, break to test, and finally pick the fourth
> one but reword its log message", to come up with:
>
>         pick xxxxxx prelim cleanly
>         pick xxxxxx document and test the feature
>         pick xxxxxx implement the feature
>         break
>         fixup xxxxxx oops, the second one needs fixing
>         break
>         reword xxxxxx the final step

This kind of gui brings more power and flexibility. I don't think I
would use it since reordering in the editor feels right to me.  Maybe
that's the real problem with reordering at all with these switches,
and I should leave fixup/squash/pick out for good.

> I am guessing that the way you did it, the above would be impossible
> (as it requires reordering) but given that you would leave most of
> the 'pick's intact and only tweak them in-place into drop, edit,
> reword, etc., that may not be too bad, but I suspect that it would
> become very verbose.
>
>         $ git rebase -i \
>                 --pick HEAD~4 --pick HEAD~3 --break --fixup HEAD \
>                 ...
>
> The --edit alternative I threw in in the above would make it
> necessary for the user to spell out all the picks, and that would be
> more cumbersome given our assumption that most picks will be left
> intact, but then we could do something like
>
>         --edit="1-4 5e 6 8-" master..
>
> to say "pick 1 thru 4, edit 5, pick 6, drop 7 and pick 8 thru the
> end".

My own itch is to help the case when I am leaving most of the lines as
picks.  That is, I don't really want to rebase to some new upstream
commit; I don't want to enumerate all the changes that
rebase--interactive helpfully chooses for me; I only want to fix one
or two warts.

As a trivial example, I can say

        $ git commit --amend

to reword my HEAD commit.  But I have no easy way to say that for
HEAD^.  With this change I can.

        $ git rebase --edit HEAD^ HEAD^^

Ideally I wouldn't need to specify HEAD^^.  I'm thinking of a switch
to say "use the mergebase of my mentioned edits", but that's still a
wip.

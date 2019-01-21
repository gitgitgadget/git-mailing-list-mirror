Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E9E81F453
	for <e@80x24.org>; Mon, 21 Jan 2019 17:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfAURuj (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 12:50:39 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:37586 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfAURuj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 12:50:39 -0500
Received: by mail-vk1-f196.google.com with SMTP id 197so4768780vkf.4
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 09:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WokUlL+GRKgqWWMhXMiuGBkfwMsO1UKDxaiMCaNUt7Y=;
        b=reLLU4+1Xz3Sqd4eny03e3xeG8JzLcEf1MlJjyePtixQAxw7MjuSjTwFINWLO4av9h
         Ue8wCX53tX6atShoWodYk+XLOikhde8M/Oui43nXin8BzIVBz/y1BlBWzJBXqtAYLKVE
         4ni6S0sebQkXV3636EZhENIuioYo1UmWy+uP5Vc/sh4CGK+iLMTL5hLWnRp/yRalNVV4
         svj0mk6mcH5LhkLeYjW0RqXcXxBTlJLBAE8i3AKVAhrGmPZRhap7iCEeljuYeIiixi02
         sOJn35BgwUtorjJWQtJteoEel0Ih+/vUte5aVQ1ZS3DdfJBsNVNa4FsQRCZYXNC6Jp+w
         Jqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WokUlL+GRKgqWWMhXMiuGBkfwMsO1UKDxaiMCaNUt7Y=;
        b=Tw+MzON22Ul7mroqqCmogm9i/eD0K69WrY1Evs8YGCL20L3k1+yvoeGC6jeo4sNCOP
         1OS4rccov7j9ZBp3dMY+XrnLvKH+ifwAjSaq/L0fYf3gpF0006Zgb4xzeJ9eTaZG8Kvt
         Ji+ueOCXUyO3C3F0LiLFmnyIVd7vR6r6tdp6nyUrgCdGLEqfFcMQYPBtK7IShdGve99D
         Yk9eJfAVQXZiVum6prhthzHJHekmPNzph/ixUF2VhPvL2pkiYuKca6XpNapyucClbWHW
         /R3tHvTA3muOKI/viupz3mA0VpKwFr5f0yIZJXaG3Sn6PTmqWg0aXU8PE6sZI1BEowiu
         EY0w==
X-Gm-Message-State: AJcUukeKDRuOhKA9AbddSVlDnBZ0evl47FZ7T1W+AwMpUYo9MjiCrBzn
        j5qmGUcm2hzayLuiEDisZV4aGXzJC3LdNU6pPkM=
X-Google-Smtp-Source: ALg8bN4/H28y6lIY+TzIGFuUZoRZlf+1CUbP0l/xPkvF3ERHMY5Clc1TYsQ8yLTZYl0XfR0eDICwj65oHd6qYHv/Stk=
X-Received: by 2002:a1f:a147:: with SMTP id k68mr11832055vke.1.1548093038022;
 Mon, 21 Jan 2019 09:50:38 -0800 (PST)
MIME-Version: 1.0
References: <20181122044841.20993-1-newren@gmail.com> <20181211161139.31686-1-newren@gmail.com>
 <20181211161139.31686-6-newren@gmail.com> <nycvar.QRO.7.76.6.1901211709090.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1901211709090.41@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 21 Jan 2019 09:50:25 -0800
Message-ID: <CABPp-BFrgjW-c8NKGYKs1VaH--Oc8yUu0enQMSp1pQVUwBOBwA@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] git-rebase, sequencer: extend --quiet option for
 the interactive machinery
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Mon, Jan 21, 2019 at 8:10 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Tue, 11 Dec 2018, Elijah Newren wrote:
>
> > While 'quiet' and 'interactive' may sound like antonyms, the interactive
> > machinery actually has logic that implements several
> > interactive_rebase=implied cases (--exec, --keep-empty, --rebase-merges)
> > which won't pop up an editor.  The rewrite of interactive rebase in C
> > added a quiet option, though it only turns stats off.  Since we want to
> > make the interactive machinery also take over for git-rebase--merge, it
> > should fully implement the --quiet option.
> >
> > git-rebase--interactive was already somewhat quieter than
> > git-rebase--merge and git-rebase--am, possibly because cherry-pick has
> > just traditionally been quieter.  As such, we only drop a few
> > informational messages -- "Rebasing (n/m)" and "Successfully rebased..."
> >
> > Also, for simplicity, remove the differences in how quiet and verbose
> > options were recorded.  Having one be signalled by the presence of a
> > "verbose" file in the state_dir, while the other was signalled by the
> > contents of a "quiet" file was just weirdly inconsistent.  (This
> > inconsistency pre-dated the rewrite into C.)  Make them consistent by
> > having them both key off the presence of the file.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
>
> This is convincing. I would like to point out, though...
>
> > ---
> >  builtin/rebase.c      |  5 +----
> >  git-legacy-rebase.sh  |  2 +-
> >  git-rebase--common.sh |  2 +-
> >  sequencer.c           | 23 +++++++++++++----------
> >  sequencer.h           |  1 +
> >  5 files changed, 17 insertions(+), 16 deletions(-)
> >
> > diff --git a/builtin/rebase.c b/builtin/rebase.c
> > index 78e982298f..ec2e5fbf23 100644
> > --- a/builtin/rebase.c
> > +++ b/builtin/rebase.c
> > @@ -185,10 +185,7 @@ static int read_basic_state(struct rebase_options *opts)
> >       if (get_oid(buf.buf, &opts->orig_head))
> >               return error(_("invalid orig-head: '%s'"), buf.buf);
> >
> > -     strbuf_reset(&buf);
> > -     if (read_one(state_dir_path("quiet", opts), &buf))
> > -             return -1;
> > -     if (buf.len)
> > +     if (file_exists(state_dir_path("quiet", opts)))
>
> This changes the behavior. AFAIR the `quiet` file was always written, but
> contained `t` in quiet mode. I have to interrupt my review here, and will
> continue later, but maybe you will beat me to looking into that.
>
> Ciao,
> Dscho

You are certainly consistent; you commented on this exact same issue
in both v1 and v2 (you didn't have time to review v3). In v2, your
comment was[1]:

"
I am slightly concerned that some creative power user could have written
scripts that rely on this behavior.

But only *slightly* concerned.

The patch looks correct.
"

Also, I have a fuzzy memory of discussing a very similar case with
some rebase-oriented option and its on-disk representation, where the
concern was more about users upgrading git versions during an
incomplete rebase rather than power users looking at internal file
contents.  And I think either Phillip or Junio made some statement
about considering these internal details and that they felt the worry
about upgrade mid-rebase was overly worrying.  But I can't find the
emails right now, and it's been so long (at least half a year) that I
might be imagining things.

But from first principles, in this case even if you're worried about
power users reaching into internal files of rebase or about users
upgrade mid-rebase, at *worst* people will get or lose a few fluffy
progress-update messages.  To me, that's an innocuous level of change
that's certainly worth the risk to allow us to get rid of the annoying
differences in implementation of handling of different options.  But,
if you strongly feel that's too big a risk, we can remove the part of
the patch making verbose and quiet be handled consistently; it's not
critical to the rest of the series.  I just thought it was a good
cleanup while I was touching the area.

Elijah

[1] https://public-inbox.org/git/nycvar.QRO.7.76.6.1811121610350.39@tvgsbejvaqbjf.bet/

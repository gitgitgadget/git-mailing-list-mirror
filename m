Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0078E1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 17:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbeIQW6N (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 18:58:13 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41998 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbeIQW6N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 18:58:13 -0400
Received: by mail-io1-f66.google.com with SMTP id n18-v6so12136626ioa.9
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 10:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gbqdcd643xS5XVILcZxKpMIE0fTnOLmdmxyyhqdp7RM=;
        b=o/IPv3sjX9zHRjaLRDkqsCLZAwN7XjQKxOJLIR955w4Ub8hCfwi0Teox3imNeDMTTW
         jIc+y8DGsfyy5Zug/6u/CqwEb4fWUUfpn3mT8lg8ZcVjSZQuG1Y5xFWIXPW7769ftQfB
         NMpVjXzBqK2ninypcWX0GidYWsEF9Fj2+xeeAmBwpk9K10MtAYY0sWjX8HnyBzARyeqc
         ivdwQzl1fdtYyF7u8+7dVzVHkoYebqMTIRdniDJYWpZLv9+5qcAIvmGwu4pcA8TkNrix
         3Lssu1p5ZaDjzuKcKtpk9oEnBiu/zt6lr/1RvsfvO+o7fp9XpAdhJOyqh+UvuNnAXQSr
         /tQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gbqdcd643xS5XVILcZxKpMIE0fTnOLmdmxyyhqdp7RM=;
        b=lcBUtZQFWDSGrzEFGkOIpoYbrm2aUu0TQHoKes4yUU3EYpjdFLRJO31nPMrKGKWz+U
         wS8FbAoB6KofiUecyEVMk+Ot+adh971D612kxrRjGfmw/G2cGJpL0YY//PfjHVKWiwU+
         K55Fs4azqSK4fpUyss1qOl/bRfPmvbTeq4QWS2//MD+rOw1Hy+QeUJuCyjzth3oRTzg7
         INcN4ct7koRpGJ12d6q3SwB2aSbfWdZMvQHj27WCy9RcX2Am/8725GgVWRvgyR367zPA
         J6XOvkLixX0X/9m7LQ08/hSpLrVdjM6rYbd1TenSExYl/uAFeyuA0kii6TpDyulfxtVP
         PIXQ==
X-Gm-Message-State: APzg51CzsJ98mMhPaNOxPzlUfMAyJNRpSqZyVzXTPtZgYTEucEwJ0n57
        FlZktX9AfowulPUL2kKpDTESWkCe/B+EioVFOky9Hoe5
X-Google-Smtp-Source: ANB0VdYZAInwTyYywLiGy1d2WSsHmbtoytCpwDZgCKCBdUp1ax67pt+SGfn8XlEQCYWDet0VCc9WRKNd1hBX8pqWDjg=
X-Received: by 2002:a6b:8fd0:: with SMTP id r199-v6mr21822674iod.118.1537205393158;
 Mon, 17 Sep 2018 10:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180820154120.19297-1-pclouds@gmail.com> <20180916063146.9850-1-pclouds@gmail.com>
 <xmqq1s9s82zx.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq1s9s82zx.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 17 Sep 2018 19:29:26 +0200
Message-ID: <CACsJy8C5QOLvg4pzy_pThQoyGh9ohdeVHXsuYwQHQypn3oBxkw@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] Make 'git commit' not accidentally lose staged content
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 17, 2018 at 7:09 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
> > This is about mixing "git add -p" and "git commit -a" (or "git commit
> > <path>") where you may accidentally lose staged changes. After the
> > discussion with Jonathan, I'm going with a bit different approach than
> > v1, this behavior now becomes default, and if the user wants the old
> > behavior back, they can use --clobber-index.
> >
> > Another change is "git commit <path>" is covered as well, as pointed
> > out by Jacob.
> >
> > I will need to add some test cases of course, if this direction is
> > still promising. One thing I'm not sure about is whether want to
> > deliberately clobber the index often, then perhaps we should add a
> > config key to bring the old behavior back.
>
> It usually is safer (simply because you do not have to think about
> it) to start a behaviour change like this as a strict opt-in to gain
> confidence.

Heh. The RFC was opt-in. Jonathan suggested changing default behavior
and I went along just to see how far I could push it :)

> As I often see myself futzing with the same file, adding changes to
> it incrementally, so that I can view progress in "diff --cached" and
> "diff" output, it would be a serious usability regression if the
> last step in the following sequence is rejected by default:
>
>         edit X
>         git add X
>         git diff --cached X
>         git diff X
>         ... repeat the above number of times ...
>         git commit X ;# or "git commit -a" to finally conclude

But yes if there's a valid use case where this behavior change becomes
a problem, then opt-in makes more sense.

> On the other hand, if I am keeping some change that should never be
> in a commit in the working tree file, and building the contents in
> the index using "add -p" to incrementally, it would be the same
> disaster as you are trying to prevent if I by mistake did a whole
> path 'add', even if I catch myself doing so before running 'commit'
> i.e.
>
>         edit X
>         git add -p X
>         git diff --cached X
>         git diff X
>         ... repeat the above number of times ...
>         git add X ;# OOPS!
>         git add . ;# OOPS! even worse!
>
> Even though this does not involve "git commit -a" or "git commit X",
> an unrecoverable damage that requires redoing the manual work is
> already done.

I don't see a good way to get to recover this situation. I could go
back to the "index log" idea, where we keep a log of index changes (or
just "interesting" changes). That way there's no behavior change at
all. The user who accidentally updates/deletes something can always
retrieve the old content back (assuming that they realize quickly
since we can't keep very long log).

I've been thinking about allowing to undo worktree changes too (e.g.
accidental "git reset --hard") and this log can cover it as well.

The only downside is we need a new command for the UI (or perhaps I
can just add "git add --log" or something like that).

Should I just drop this patch and go that direction instead? More
work, but maybe better end result.

> How should this new check intract with paths added with "add -N", by
> the way?

Good point. The check here is basically "git diff --cached". I would
need to turn it to "git diff --cached --ita-invisible-in-index" to
make ita entries disappear.
--=20
Duy

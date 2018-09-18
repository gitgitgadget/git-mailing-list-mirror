Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D0331F453
	for <e@80x24.org>; Tue, 18 Sep 2018 19:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbeISBKX (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 21:10:23 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35316 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbeISBKX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 21:10:23 -0400
Received: by mail-ed1-f68.google.com with SMTP id y20-v6so2928426edq.2
        for <git@vger.kernel.org>; Tue, 18 Sep 2018 12:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/0hY5xpIfIKKM4Cw31RrxIINIENgZi1qM3AhZ++3d/s=;
        b=IxKitKQsvG1ZM+nE4A3qt+fmW24I3Hmd3LuQg3WRyZFu5iXIqRruWgi5d+tZEu/Ix0
         2WUfmIEO53XRxQxf8hDFgcZ9EZrYe6bjWPZXYBK71mfyPnudzVu4+LtmFMRGM3heKOrI
         dZ7KPAAEW7xGj6yNj8A6Sagasuam3CY0QCz6fhQd+JtH2u8xVOKZ2IGiaOekWzJkJXIi
         XfZR4SscVlS6tEnQMyiJDnnVJ+FVaxrayVjycXlLq6/T//WJqCcHtiibUQRxZXq+WI4F
         yU+ZNcs3q7F8SrD6e5+1gBpO9XiznIXnfFPp4PlpIB3IH3F8Lp6/ekLrsjrTf9CX2Lbo
         rnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/0hY5xpIfIKKM4Cw31RrxIINIENgZi1qM3AhZ++3d/s=;
        b=YX3ghrynqCh3dgXggwTAEaKxipe/XSONYgdGaXSfninaPGcgZ3cONspvEFiuLVx0RZ
         uwl1yrENqEnp/5XcnOn55ueWS6oCF/BJ94rE5H2ci1i/qvhKQSWShF6CtNr1cEXzfd7B
         q6WJqBaDXVcrsR8wTM2BdPv4dHjT7S1HIA0iX7hz5Q2ASzhZO2lLwqk9Sdt4GuSXJtMb
         MsG/BHl1j5jyG25xLabpM1etkym6yU7HJ8ACX3TmgAy/kHS86dqdZ7q49sSg7VLmWfRX
         AZ7IK3B5x97JVFGrkx21lnRe7CjQ6Rw9f1J3f3IBZ7jHP94rhIE+n0UxXh3KRQFY0QmA
         B1CQ==
X-Gm-Message-State: APzg51AyV0abziuqqSL8J/khtW6/WPc/0Hp9juG+P0jWFVhNRONT3Tbz
        sC6xsO2BnmT9d95Ir60YpKpDl0DM+dTjntghx4I=
X-Google-Smtp-Source: ANB0VdYN0QhETX2CcPCb5X5B14bArXTYxVp8c1EG9ix4gpXs6OCAvtZsueUlr9BQ3kAkfTKt6Cxi/rykbUwlBSNHkWA=
X-Received: by 2002:a50:8843:: with SMTP id c3-v6mr51408002edc.146.1537299378089;
 Tue, 18 Sep 2018 12:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180820154120.19297-1-pclouds@gmail.com> <20180916063146.9850-1-pclouds@gmail.com>
 <xmqq1s9s82zx.fsf@gitster-ct.c.googlers.com> <CACsJy8C5QOLvg4pzy_pThQoyGh9ohdeVHXsuYwQHQypn3oBxkw@mail.gmail.com>
 <20180917181511.GA3894@sigill.intra.peff.net>
In-Reply-To: <20180917181511.GA3894@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 18 Sep 2018 12:36:06 -0700
Message-ID: <CA+P7+xqzN5M6VgQqCNAAsmwYRmnoSVsAvdES7aK2fKf9P-f4fg@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] Make 'git commit' not accidentally lose staged content
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 17, 2018 at 11:15 AM Jeff King <peff@peff.net> wrote:
>
> On Mon, Sep 17, 2018 at 07:29:26PM +0200, Duy Nguyen wrote:
>
> > > On the other hand, if I am keeping some change that should never be
> > > in a commit in the working tree file, and building the contents in
> > > the index using "add -p" to incrementally, it would be the same
> > > disaster as you are trying to prevent if I by mistake did a whole
> > > path 'add', even if I catch myself doing so before running 'commit'
> > > i.e.
> > >
> > >         edit X
> > >         git add -p X
> > >         git diff --cached X
> > >         git diff X
> > >         ... repeat the above number of times ...
> > >         git add X ;# OOPS!
> > >         git add . ;# OOPS! even worse!
> > >
> > > Even though this does not involve "git commit -a" or "git commit X",
> > > an unrecoverable damage that requires redoing the manual work is
> > > already done.
> >
> > I don't see a good way to get to recover this situation. I could go
> > back to the "index log" idea, where we keep a log of index changes (or
> > just "interesting" changes). That way there's no behavior change at
> > all. The user who accidentally updates/deletes something can always
> > retrieve the old content back (assuming that they realize quickly
> > since we can't keep very long log).
>
> FWIW, I like that approach much better, since:
>
>   1. It does not bother or restrict anybody in their workflow; instead,
>      they pay the complexity price only when they know they have made a
>      mistake.
>
>   2. It covers many more cases (e.g., just doing the wrong thing via
>      "add -p").
>

I also think this is a better approach for the same reasons.

> A naive index log would be pretty cheap in CPU, at least for POSIX-ish
> systems. You could just hard link "index" to "index.N" before renaming
> "index.lock" over "index". But I guess if you have a gigantic index,
> that's less appealing. So maybe storing the equivalent of a "--raw" diff
> between the two index states would make more sense (and after all, you
> don't really need the stat-cache or cache-tree). It would cost more to
> reconstruct the index on the fly, but then the point is that you would
> create these logs a lot more than you access them.
>
> > I've been thinking about allowing to undo worktree changes too (e.g.
> > accidental "git reset --hard") and this log can cover it as well.
>
> I like that, too. It's a little more costly just because it may involve
> object-db writes, but I think in most cases it would be fine. I almost
> always "git stash" away discarded changes these days instead of "git
> reset --hard", because it effectively provides this kind of log.
>

Obviously we do eventually turn the index into a tree, which is used
by the commit. Would it be possible to simply somehow store these
trees, and have commands which blow the tree away simply instead, save
it? I'm not sure how costly that is.

Thanks,
Jake

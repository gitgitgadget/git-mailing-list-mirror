Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 514401F45F
	for <e@80x24.org>; Wed,  8 May 2019 10:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfEHKUr (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 06:20:47 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40222 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfEHKUr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 06:20:47 -0400
Received: by mail-io1-f68.google.com with SMTP id s20so6993479ioj.7
        for <git@vger.kernel.org>; Wed, 08 May 2019 03:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4I5VidBrWpYjXTGCZVxOI9K5VC8/Et7xS4QR1M4jz3U=;
        b=CPANGDvi4rd+RCWhzSEfZnRHluuZxe2Tul7FRjo3uEa/tVWrFPXrj8Gr4t5zQOBMmf
         3wJYnTPA7sf2FiIvLy139bxkE1isFUcuvzAWW7aET3UTsBmVQQGcmEzYthj3hH6gEclD
         YJpGGpJqmS5E2Mz3QvdCkBOG+xfSNon1bRv+QTHJlmXoRo2ArdAETPZs75t7jBHq4K0K
         ivss0d5wPmmF1B2nt0e9J/+P7rQSC6R/9F1UcxfVEGHuUc/opKQXE/FliyGZzqUGsm5K
         FppZwcxfnHETxGhuiPYNpvx+vq5oQVZYkkqV7+5x3EeVgGJdUZypXqhKyXLkaP94jdLy
         Li9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4I5VidBrWpYjXTGCZVxOI9K5VC8/Et7xS4QR1M4jz3U=;
        b=IptqXKrrMI/owek3+eGNodT5rvNUTLQ0eflQNUye47Qk0f0qa5pGB98vRvdmNNR7A2
         caRMvsPMuzoujkBkAMa1nZZvXsjJbZILQYoAevLR1xJKp3GNMIeHpIBMttYExxQERBId
         AtoYzqAMVcM5DcdhlF2VOYzCyl/bVrNhroiWskuvTUmIXiKhaewgmr5bjCDyWIDlEhUw
         9rOv2CBx5P7O7BKoxQfMXeDUPWapKZUbcpxcwdxDkr5jANh6qZ5LOWKsALr5OwW1Ak1D
         fYcZviPOv3nJG/AMHieFT2FeTlI5ul4EKMaEilExKcAnHaJ2tXWcD55lKfriaeaXvcDI
         399A==
X-Gm-Message-State: APjAAAVxRrPIK5oW1ED2B/qu4TwyDVSKtVmd7bqjL2cchxAc+FXQhfdS
        FYVbbCOxf6jZDSBCQxUECDNrCanrlXjuvmDePHolFQ==
X-Google-Smtp-Source: APXvYqxXIKNrUQ/7dD2JkjVr6hoIWdCu4QbtBAl4G1UR95MuZ5s0VEjauC2PsHEoRCpFlGQ5u+IErWeN1ypzbVKlbcM=
X-Received: by 2002:a6b:ef12:: with SMTP id k18mr14592697ioh.236.1557310846376;
 Wed, 08 May 2019 03:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190411131218.19195-1-pclouds@gmail.com> <20190425094600.15673-1-pclouds@gmail.com>
 <20190507022127.GA220818@google.com> <CACsJy8DSVJuwNWfEcA1pv1vdoCn=EKTmhBncRtKLZedQiEj0AA@mail.gmail.com>
 <20190507183104.GB220818@google.com>
In-Reply-To: <20190507183104.GB220818@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 8 May 2019 17:20:20 +0700
Message-ID: <CACsJy8Axv6WeDQaU_Gm-oX7gSHRB0QWJz=gYh+GAgfo7gUYWcQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/16] Add new command 'restore'
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 8, 2019 at 1:31 AM Emily Shaffer <emilyshaffer@google.com> wrote:
> > > I found myself in a situation where I had accidentally
> > > staged all my changes to tracked files (I think resulting from a stash
> > > pop which generated a merge conflict?) and didn't see a good way to
> > > unstage everything using restore.
> > >
> > > I tried out `git restore --staged *` and it tried to restore every build
> > > artifact in my working tree, all of which should be ignored, made a lot of
> > > noisy errors, and left me with my changes still staged.
> >
> > For the record, "git restore --staged :/" should do the trick and it
> > is documented as an example (but without --staged).
>
> Yeah, this worked, and today I also noted `git restore --staged .`
> works, as does Junio's suggestion on the other mail (`git restore
> --staged revision.\*`), and quoting the * (`git restore --staged '*'`).
> So maybe I didn't think outside the box enough before mailing :)

No it's good. It actually got me thinking. Actually I take that back.
It's bad, I'm quite stuck at thinking here :D

> > Either way. I think you raise a good point about "*" (or patterns
> > matching more than expected in general). I need to sleep on it and see
> > if the old way of handling pattern matching failure is still a good
> > way to go.
>
> I think it's worth considering, especially as `git reset HEAD *` and
> `git reset HEAD` both work. (`git restore --staged` complains that it
> hasn't got any paths, but reset seems to figure you just mean
> everything.) It was a surprising failure to me coming away from years of
> using reset.

Yeah I agree that doing it the "git reset" way makes sense for
--staged because shell expansion is tied to worktree files, and
--staged is completely disconnected from worktree. Shell expansion
cannot get this case right, no point punishing the user because of it.

My problem is "what about the other two cases, --worktree alone or
--worktree with --staged (iow do we care about consistency)? what
about git-checkout? does the old way even make sense for git-checkout?
any better way to do if the reason behind is still valid?". I
obviously haven't worked it all out yet.
-- 
Duy

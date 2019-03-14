Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE80820248
	for <e@80x24.org>; Thu, 14 Mar 2019 05:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfCNF7d (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 01:59:33 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34977 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfCNF7d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 01:59:33 -0400
Received: by mail-vs1-f65.google.com with SMTP id e1so1537844vsp.2
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 22:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vVkinNw6ipZmUxPLyVbO7IgGh+jCWHH+m1k/CUi7rh8=;
        b=pHfxJdouVCSOlw6HONqvS5XpnH1P0uIA8VZOrdqUOucbh4O1LBFxubsplIpXIUirv7
         BPD2wmqIH9gREVRnR2ZraA7TaGnxUAxyLFzMUOPpi237ewINrUrNY4CkhUPL/CzSiec3
         dz5IlUX5qBpJTYlmmv1FwaKA0w3I2j9InyI9Z4ODteg4c6Kj/niACV6vINAnGfdRzUNA
         FF4+4zGKW5C/5KdyfCgprMFgerCECLMr4BMooJrm4U+n5EfHLQ6Vd5U6M3UL1HnQUBiI
         01+0qDe+8aBgfKrMHtISgu7ca2esmUO1fH4SFqVnMN0ITFY92civQa4T2WkGAHqWFDOE
         p8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vVkinNw6ipZmUxPLyVbO7IgGh+jCWHH+m1k/CUi7rh8=;
        b=W0FDcCML4f393kdq7bEeaB36v3QhJTvZLZ3j75zyIRwb+DS1EC64FwId12r0B6X3k0
         HAM6QTMdLeAWg5Mtncx8z8XNBlKt1DNq1PRQO3m3CFdmh87ivj910nCFamN9S23lnC9f
         pmjESqJoBR5BDoywXIEr3yxjQmCQNImrkUFFGBs+wTcCOAQlzojJBlnDorW4ofLQhX5M
         B/bgPF/qHcHzPNSuE1kjduxGjuqVDLrielZzf9w4yLFdztsCE+zE7OeBkXvK9RrZg42V
         DUGLwinPST0M+YRQR3Ytiy0RiZnMsuzv7cPUDC+vLNK25oC4/iWIZZpfdVJi3TlA7/NU
         XFFw==
X-Gm-Message-State: APjAAAVIxP7jFozqjvU7Y37r6ik8sylA/E8/Pub4aV50K1xbYqu+wRqe
        riE+TqsT/FhQDzqEzUaRayhmaP3QH51rJAH1UxI=
X-Google-Smtp-Source: APXvYqynJ+BaZUFirqOUPLYvSVQHcUxTuRVdEqYiVI12vGt0YCQHlOPjXbYHvEA43wz7Ct4/aUpjDwXk7G/Zi+QNJAA=
X-Received: by 2002:a67:f8cc:: with SMTP id c12mr2321435vsp.136.1552543171753;
 Wed, 13 Mar 2019 22:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com> <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
 <CACsJy8CuNQR7javX7KTC7txivH1OkejCbVJdHGD+XJ-0ftT3ag@mail.gmail.com>
In-Reply-To: <CACsJy8CuNQR7javX7KTC7txivH1OkejCbVJdHGD+XJ-0ftT3ag@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 13 Mar 2019 22:59:20 -0700
Message-ID: <CABPp-BHB3c0XqS57Do8=YFtbVyBEe26kbJtgDxWAaWAMzsgdoA@mail.gmail.com>
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

On Wed, Mar 13, 2019 at 8:29 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Mon, Mar 11, 2019 at 6:16 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
> > > +-m::
> > > +--merge::
> > > +     If you have local modifications to one or more files that are
> > > +     different between the current branch and the branch to which
> > > +     you are switching, the command refuses to switch branches in
> > > +     order to preserve your modifications in context.  However,
> > > +     with this option, a three-way merge between the current
> > > +     branch, your working tree contents, and the new branch is
> > > +     done, and you will be on the new branch.
> >
> > I was wondering what people felt about making this the default for the
> > new command. If I'm carrying changes over to the new branch then I want
> > them to be merged in, it's annoying to have them carried over most of
> > the time but then sometimes have the checkout fail without specifying
> > --merge.
>
> If my worktree has local changes and I accidentally switch to a
> different branch, I could switch back without losing any local changes
> and the tree I have is exactly what I had before the switch. Is this
> still true if -m is made default?
>
> I think sometimes a 3-way merge creates marker conflicts in file, and
> this does not look easy to reverse when switching back. If it's true
> and we can detect it, we can still abort this case (i.e. requiring -m

You cannot yet do this with merge_recursive; it writes conflicts to
the worktree as it goes and doesn't tell you whether the merge was
successful or had conflicts until its done.  So this would be very
dangerous.  We'd first need a way to do an in-memory merge that
doesn't touch the working tree or index and which gives you the
opportunity to check whether that worked before proceeding to write
out any updates.  That is work I plan to do (for other reasons), but
not in progress currently.

> to continue) while allowing succesful 3-way merges by default. But are
> successful 3-way merges reversible?

Hmm, interesting.  So, switching from branch A to B, you start with
local changes on top of A that could represent a virtual commit C.
So, you three-way merge C & B using A as the base.  It's clean, so we
have a new endpoint, call it D.  Switching back to A with the --merge
flag would mean a three-way merge of D & A using B as the base.

But it might be easier if I re-labelled all of these with different
terms. Let's say we squash all changes from A to B into a single
commit on top of A that we call commit B.  Check out C (a commit
representing your local changes on top of A), and cherry-pick B; that
will three-way merge C & B using A as the base.  It's clean, so we
have a new commit, call it D.  Now we tell git to revert B, which will
do a three-way merge of D (current HEAD) & A (parent of B), using B as
the base.  So, essentially, your question about reversibility boils
down to: if you can cleanly cherry-pick a commit to your current
branch, can you then immediately revert that same commit on top to
return to where you were before?

(Off the cuff, I _think_ the answer to that is yes due to the
assumption that the cherry-pick was without conflicts, but I'm not
immediately sure.)

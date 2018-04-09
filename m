Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFA1A1F404
	for <e@80x24.org>; Mon,  9 Apr 2018 19:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753720AbeDITaK (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 15:30:10 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38924 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753690AbeDITaE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 15:30:04 -0400
Received: by mail-wm0-f65.google.com with SMTP id f125so18842634wme.4
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 12:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jHUYozQRFWEumpJGd0MGBtBE8WSz9PZecVjnW/9kE8g=;
        b=j3L4wvfGyny2tEmSyJ6G+sOYi4Iq+5RoJqI54hUSFz8mAx4ZIQOaUcLrhTAOf2HOlq
         AEdHiccFDAU0drXc0JuGykSUN8G68RjSdWKhikx/czKFbMCLz3ViNoRD/ngaaTOt1ykN
         2mr2iMjl7qeB4Rh6I5EMjaDlAYth06NT71ZKiyRfIXUagH5/8nyNDMM9yEWzR3UVvVyZ
         e6QHRnOTbFJTu8qOHPili8MjeNyFWGXgx40uRcE0/xt5INqiLDTt3uQM3DAL10FC8gau
         92KdqzeA0yVhSzkENgTj6qTcVe3w9vAj4g+9eN5cmGbyKY5X1ZLvsH4OGKGwAnCK/D9q
         G3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jHUYozQRFWEumpJGd0MGBtBE8WSz9PZecVjnW/9kE8g=;
        b=N3yJT2udmVinMXB0rLdF9vYucXo6x/oyA//+A5Aj5cm2OzgflAldIAUebYkWQuic/R
         EUZhtcJp8Rcb+h5HIHFQWZFOehuR0qFHuu2Z7cDp31F8FBd0ETvm02NawhRaj/GyFKEZ
         5TGMBbVB6IekJW7yid0AC/v5Gbxnlg2NIB37IctBeb4iL5eQ6h0r0BuUw/fkq+JUA4Ua
         TCCzWtDVLloSGir8Z5RHser9g80QgNu1pvo/QeRJCDd72AZNRkj5Y5ISAijgUeNctGCM
         JkxIwtGzw48Ce8X0qrLUwtclqHJTT3DhcCTiF1+Xa+T5AcokWd0cbAKQ7JHgxextdmwJ
         bU9Q==
X-Gm-Message-State: ALQs6tDS1/fK5dthHIwsYvE3z9m8+ub07rPZWBCrOu9DdyPvvUK8OB8V
        1heQGvWhtiORX/UAcyfOgnY=
X-Google-Smtp-Source: AIpwx4/Iz5XcSVxGD0jPHmg3WRmxs+mNnhhkDiLW+6kxWs+ct1zl++s8zGqmVvmPvdrJfCvfMajsJQ==
X-Received: by 10.28.26.73 with SMTP id a70mr801886wma.30.1523302203429;
        Mon, 09 Apr 2018 12:30:03 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id q14sm1537348wre.10.2018.04.09.12.30.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Apr 2018 12:30:02 -0700 (PDT)
Date:   Mon, 9 Apr 2018 20:30:07 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/6] worktree: teach "add" to check out existing
 branches
Message-ID: <20180409193007.GL2629@hank>
References: <20180325134947.25828-1-t.gummerer@gmail.com>
 <20180331151804.30380-1-t.gummerer@gmail.com>
 <CAPig+cQ8VzDycUMo-QOexNDBgQGEGj2BPmPa-Y0vhGCt_brbhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cQ8VzDycUMo-QOexNDBgQGEGj2BPmPa-Y0vhGCt_brbhg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/08, Eric Sunshine wrote:
> On Sat, Mar 31, 2018 at 11:17 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > This round should fix all the UI issues Eric found in the last round.
> > The changes I made in a bit more detail:
> >
> > - added a new commit introducing a new hidden --show-new-head-line
> >   flag in 'git reset'.  This is used to suppress the "HEAD is now at
> >   ..."  line that 'git reset --hard' usually prints, so we can replace
> >   it with our own "New worktree HEAD is now at ..." line instead,
> >   while keeping the progress indicator for larger repositories.
> 
> As with Junio, I'm fine with this hidden option (for now), however, I
> think you can take this a step further. Rather than having a (hidden)
> git-reset option which suppresses "HEAD is now at...", instead have a
> (hidden) option which augments the message. For example,
> --new-head-desc="New worktree" would make it output "New worktree HEAD
> is now at...". Changes to builtin/reset.c to support this would hardly
> be larger than the changes you already made.

Something else I just noticed that may make this a worse solution is
that this breaks the sentence in two pieces for translators.  I guess
we could somehow get the "New worktree" part of the option translated,
but that still means that if some language would require to move parts
of the sentence around that would be less than ideal for translation.

Duy pointed this out to me in an earlier patch series, and I think we
should probably not make life harder (or impossible) for translators
if we can avoid it.

Would factoring out what we have in 'print_new_head_line()' into some
common code, maybe in 'pretty.c', and still doing the printing from
here be a reasonable tradeoff?

I think this could potentially even be re-used in other places,
although again I'd like to keep that for a followup series to avoid
scope creep in this one.

> The major benefit is that patch 3/6 no longer has to duplicate the
> code from builtin/reset.c:print_new_head_line() just to print its own
> "New worktree HEAD is now at..." message. (As for the argument that
> "git worktree add" must duplicate that code because it wants the
> message on stderr, whereas git-reset prints it to stdout, I don't see
> why git-worktree puts those messages to stderr in the first place. As
> far as I can tell, it would be equally valid to print them to stdout.)
> 
> > Some examples of the new UI behaviour here for reference:
> >
> >  - guess-remote mode
> >
> >     $ git worktree add --guess-remote ../next
> >     Creating branch 'next'
> >     Branch 'next' set up to track remote branch 'next' from 'origin'.
> >     New worktree HEAD is now at caa68db14 Merge branch 'sb/packfiles-in-repository' into next
> >
> >  - original dwim (create a branch based on the current HEAD)
> >
> >     $ git worktree add ../test
> >     Creating branch 'test'
> >     New worktree HEAD is now at c2a499e6c Merge branch 'jh/partial-clone'
> >
> >  - new dwim (check out existing branch)
> >
> >     $ git worktree add ../test
> >     Checking out branch 'test'
> >     New worktree HEAD is now at c2a499e6c Merge branch 'jh/partial-clone'
> >
> >  - no new branch created
> >
> >     $ git worktree add ../test2 origin/master
> >     New worktree HEAD is now at c2a499e6c Merge branch 'jh/partial-clone'
> 
> I like the "creating" or "checking out" messages we now get for all
> the DWIM cases. I wonder if it would make sense to print "Checkout out
> blah..." for this case too. It's certainly not necessary since the
> user specified <commit-ish> explicitly, but it would make the UI even
> more consistent, and address your subsequent comment about missing
> context above the "Checking out files: ...%" line for this case.
> Thoughts?
> 
> > Compare this to the old UI (new dwim omitted, as there's no old
> > version of that):
> 
> Thanks for contrasting the new with the old. The new output is nicer
> and more helpful.
> 
> > The one thing we are loosing is a context line before "Checking out
> > files:", if no new branch is created.  Personally I feel like that's
> > acceptable, as the user just used the 'git worktree add' command, so
> > it should be intuitive where those files are being checked out.

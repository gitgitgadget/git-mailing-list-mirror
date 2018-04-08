Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19DEA1F404
	for <e@80x24.org>; Sun,  8 Apr 2018 14:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751587AbeDHOYR (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 10:24:17 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:35440 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbeDHOYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 10:24:16 -0400
Received: by mail-wr0-f174.google.com with SMTP id 80so5885132wrb.2
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 07:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kz65BKVSfX4+fZtu5E3bqBu8bDv13NQkbQ88PNMzqF4=;
        b=llE1A+MPKXdQcbxWHci8uPe68h+dUIL8LsJCSbPc21urLFzTxnfjqrTSOXlxOSZ/VZ
         Cgdd8TaZKRhc8SiIxQYIv0VRXvtauJKsXDoqvgxOUaIoLxbtGdel/4RCgu/C/qc7VGaO
         Jb0HDc9iw+HfKVkC0kLTel2l41EUh6KbS3j/kW9/IFIkZMAgA1e6xRHg8Cg0hB4DZ5Eh
         nUEgtRdmVORP2dks6SMaUYsU7BdisNrQk6YHVkBNgHvVTHHSCn1oJhDco/8GZfMI04wn
         /ZPC7l1MXFbcUHSiMtjwMEGZ0qZN7WYutsoH71YRl17Y2Sh9E94SSLJhRPnbnM7JfHXB
         ilvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kz65BKVSfX4+fZtu5E3bqBu8bDv13NQkbQ88PNMzqF4=;
        b=Ux9mb0DwQN67UH3DoFb+fY6HPH0hWsE3xae+2I5obCuSP96PaREpahRirMNXAAgzSk
         3KxoW9vihFFBGevGbRXIqkAdrGT0B+uH8WLqfkI2Q+sqRDIE7GMeIIFzcL5YInXV/HTy
         3wnUb45SIaqI6lkIdKTibhAQFhxAC+taIx38S8HuZjGuGF8I8qPLimpafPMzGLhIeWYv
         jKFE9ApMBPrMArI95goQMirtrHTjrTaScaf5/56Jypqw3PgCdQsbF2GiWyH89x7Gq1FS
         gc19Iqe8Sui/cs/X4YIIB0VJXgsTsRkXuZivKc0aJPOxmuMeEjRTh92aiBnNXlT1m8Np
         UB3g==
X-Gm-Message-State: AElRT7GRmEph/whmSnWOs6L56jTdx47nvUs1gGh5H6VAMI/sAQzAV8AK
        r0mLrEkal5QtP+I6eym3t2k=
X-Google-Smtp-Source: AIpwx4/DAHowHgu/wihqODbbJkUX8isaSLXA7o2gCWl19FZtudiQG4SPoZWqKCpZ1vWIep1GJO/YsQ==
X-Received: by 10.223.149.68 with SMTP id 62mr21720003wrs.201.1523197455365;
        Sun, 08 Apr 2018 07:24:15 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id y191sm29239579wme.14.2018.04.08.07.24.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Apr 2018 07:24:14 -0700 (PDT)
Date:   Sun, 8 Apr 2018 15:24:17 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/6] worktree: teach "add" to check out existing
 branches
Message-ID: <20180408142417.GJ2629@hank>
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
> 
> The major benefit is that patch 3/6 no longer has to duplicate the
> code from builtin/reset.c:print_new_head_line() just to print its own
> "New worktree HEAD is now at..." message. (As for the argument that
> "git worktree add" must duplicate that code because it wants the
> message on stderr, whereas git-reset prints it to stdout, I don't see
> why git-worktree puts those messages to stderr in the first place. As
> far as I can tell, it would be equally valid to print them to stdout.)

I didn't think of that, but I think that's nicer indeed.  Will change.
This will also be nicer when we're in a position to remove the hidden
option and do all of this with internal functions.  Then we can just
re-use the new function that also takes a prefix at that point (after
moving the function to 'libgit.a' of course.

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

Let me think through some of the cases here, of 'git worktre add
<path> <commit-ish>' with various flags and what the UI would be with
that added:

  - no flags:

    $ git worktree add ../test origin/master
    Checking out 'origin/master'
    Checking out files: ...%
    New worktree HEAD is now at c2a499e6c Merge branch 'jh/partial-clone'

  - -b branch:

    $ git worktree add -b test ../test origin/master
    Creating branch 'test'
    Checking out 'origin/master'
    Checking out files: ...%
    New worktree HEAD is now at c2a499e6c Merge branch 'jh/partial-clone'

    Would we want to omit the "Checking out ..." here?  I'm leaning
    towards yes, but dunno?

  - --no-checkout

    $ git worktree add --no-checkout test ../test origin/master
    New worktree HEAD is now at c2a499e6c Merge branch 'jh/partial-clone'

  - Original dwim with --detach flag

    $ git worktree add --detach ../test
    Checking out 'c2a499e6c'
    Checking out files: ...%
    New worktree HEAD is now at c2a499e6c Merge branch 'jh/partial-clone'

Looking at this, I'm not sure what's best here.  I'm not sure I'm a
fan of the duplicate "Checking out " message (I assume that's what you
meant above, or did you mean just "Checkout ..."?)

I als don't think it gives too much context compared to just "Checking
out files: ...%".  I think it gives a bit more context when that
message is not displayed at all, as it shows whether files are checked
out or not, but if we do that, when we create a new branch, the amount
of output we'd display is getting a bit long, to the point where I
suspect users would just not read it anymore.

So I personally don't feel like this is worth it, even though it may
give some context in some cases.  But I'm also far from an expert in
UI design, so if you (or others) feel this would be nicer I'm happy to
implement it :)

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

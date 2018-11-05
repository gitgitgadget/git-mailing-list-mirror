Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A6EA1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 22:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388129AbeKFHid (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 02:38:33 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:54447 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387441AbeKFHid (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 02:38:33 -0500
Received: by mail-wm1-f53.google.com with SMTP id r63-v6so9923698wma.4
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 14:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=np7YOeNJdl20qKxCD68S/FAhudeoEh1noQsfghb7D30=;
        b=g7mdL0+4wJ3zpKRZ+XfkaLbFbAe0ohzsPuz2qmi0uBaPhB9lhEkv+U5y/BnhfTnZyV
         Yk9IfmbqYh+b40idnl2Eys2x/zTIbI8c56NL/Kwt6Ssh5T+LPDyrUYzoo2eVD15ciqBg
         zDlsTCnMef81pxbu9Bu+/j7r7n5O8/rEqSWBPwBGBrWKXbXjnSQhyM0jVm0b27NqqZcB
         HoRjNNWLQmqqgfDIR53Sdv7HoglGyjj7hg1L9vU7Y3KHYIBRT6Jj2Etxd1MDJClEaNA1
         trF67dh3dcJBX+kBzVZv6vbW2ZVIO9Jazhw9XOm2G8EiU4MKuWFILsAgp2H2Xvugoa/a
         2IiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=np7YOeNJdl20qKxCD68S/FAhudeoEh1noQsfghb7D30=;
        b=YwVEpkE2ghh55ZiJ/kPgyWBOgzYczinODrldTpeFbJonxmIqIOLO/ciRYMCQ/GTQjK
         kb4jT6T7zfXkGDXVdB8nnQxLc+Ix+YSjrwGzeXE8h6IOzBWZ4hTgS3eVWQCTAFRPbPAQ
         fZUrP9ohttYcGdrvdEjgp06YMLz16bnO5PwpxgBXPTevAVtdIStcxstXgZ4TQK3wUy+6
         WG0xLXRUOesZv4jE7Tms3GpsvC18E00o03eVglYOiK32BXOYj1WS9PXLVFVqHxBQ0rr2
         lSlrADcq+OUI9o1y3k8I8C7/nP7LHawx+4w2dGUfPMoDqGhc1wtsvY1MIMO8VaWbh0EW
         dyDg==
X-Gm-Message-State: AGRZ1gIJRJX6l6ld+Z/S+7xGxrmmu70zdffqA8ZF6WFLPKBJnsdA1MBY
        hvly2H5eM3mSvsy6Lv6aVzYA1BSk
X-Google-Smtp-Source: AJdET5cVUhtOqR4i7dTkqCAe9Pgj5OPZTzc4HqC52AbtL6xxtlZNvx0rYVPqvShYekSsxNmNDRPnEQ==
X-Received: by 2002:a1c:410a:: with SMTP id o10-v6mr30123wma.19.1541456198161;
        Mon, 05 Nov 2018 14:16:38 -0800 (PST)
Received: from localhost ([31.127.45.106])
        by smtp.gmail.com with ESMTPSA id r1-v6sm10205944wrt.59.2018.11.05.14.16.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 14:16:37 -0800 (PST)
Date:   Mon, 5 Nov 2018 22:16:36 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     "Quinn, David" <David.Quinn@cmegroup.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Failed stash caused untracked changes to be lost
Message-ID: <20181105221636.GA21842@hank.intra.tgummerer.com>
References: <1540292560837.94684@cmegroup.com>
 <20181103153458.GG4883@hank.intra.tgummerer.com>
 <f1dd8c7097e94602a4508be4ceffbda0@SMD1OACSEXC0003.prod.ad.merc.chicago.cme.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1dd8c7097e94602a4508be4ceffbda0@SMD1OACSEXC0003.prod.ad.merc.chicago.cme.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/05, Quinn, David wrote:
> Hi,
>
> Thanks for the reply. Sorry I forgot the version number, completely
> slipped my mind. At the time of writing the report it was Git ~ 2.17
> I believe. All of our software is updated centrally at my work, we
> have received an update since writing this to 2.19.1. Unfortunately
> because of it being centrally controlled, I couldn't update and try
> the latest version at the time (and now I can't go back and check
> exactly what version I had).
>
> I've never even looked at the git source or contributing before so I
> wouldn't be sure where to start. If you (or someone) is happy to
> point me in the right direction I'd be happy to take a look, I can't
> promise I'll be able to get anything done in a timely manner (or at
> all)

Sure I'd be happy to help :) There's a nice document in the
git-for-windows repository [*1*] that gives a good introduction into
developing git.  Some of the advise is applicable to both Windows and
linux, but it should be especially helpful for you as you seem to be
working in a windows environment.

The stash implementation is currently written in shell script, and
lives in 'git-stash.sh'.  There is currently an effort under way of
re-writing this in C, but as we don't know when that's going to be
merged yet, it's probably worth fixing this in the shell script for
now.

Don't worry about making any promises, or getting it done very soon.
This is no longer a data loss bug at this time, so it's not critical
to fix it immediately, but it should definitely be fixed at some
point.

 Some of us also hang out on the #git-devel IRC channel on freenode,
which can be a good place to ask questions.

[*1*]: https://github.com/git-for-windows/git/blob/master/CONTRIBUTING.md

> Thanks
> 
> -----Original Message-----
> From: Thomas Gummerer <t.gummerer@gmail.com> 
> Sent: 03 November 2018 15:35
> To: Quinn, David <David.Quinn@cmegroup.com>
> Cc: git@vger.kernel.org
> Subject: Re: Failed stash caused untracked changes to be lost
> 
> Exercise Caution: This email is from an external source.
> 
> 
> On 10/23, Quinn, David wrote:
> >
> > Issue: While running a git stash command including the '-u' flag to include untracked files, the command failed due to arguments in the incorrect order. After this untracked files the were present had been removed and permanently lost.
> 
> Thanks for your report (and sorry for the late reply)!
> 
> I believe this (somewhat) fixed in 833622a945 ("stash push: avoid printing errors", 2018-03-19), which was first included in Git 2.18.
> Your message doesn't state which version of Git you encountered the bug, but I'm going to assume with something below 2.18 (For future reference, please include the version of Git in bug reports, or even better test with the latest version of Git, as the bug may have been fixed in the meantime).
> 
> Now I'm saying somewhat fixed above, because we still create an stash if a pathspec that doesn't match any files is passed to the command, but then don't remove anything from the working tree, which is a bit confusing.
> 
> I think the right solution here would be to error out early if we were given a pathspec that doesn't match anything.  I'll look into that, unless you're interested in giving it a try? :)
> 
> > Environment: Windows 10, Powershell w/ PoshGit
> >
> >
> > State before running command: 9 Modified files, 2 (new) untracked 
> > files
> >
> > Note: I only wanted to commit some of the modified files (essentially 
> > all the files/changes I wanted to commit were in one directory)
> >
> > Actual command run:  git stash push -u -- Directory/To/Files/* -m "My Message"
> >
> > Returned:
> >
> >     Saved working directory and index state WIP on [BranchName]: [Commit hash] [Commit Message]
> >     fatal: pathspec '-m' did not match any files
> >     error: unrecognized input
> >
> > State after Command ran: 9 Modifed files, 0 untracked files
> >
> >
> > The command I should have ran should have been
> >
> >     git stash push -u -m "My Message"? -- Directory/To/Files/*
> >
> >
> > I have found the stash that was created by running this command:
> >
> >     gitk --all $(git fsck --no-reflog | Select-String "(dangling 
> > commit )(.*)" | %{ $_.Line.Split(' ')[2] }) ?
> > and searching for the commit number that was returned from the original (paritally failed??) stash command. However there is nothing in that stash. It is empty.
> >
> >
> >
> > I think that the fact my untracked files were lost is not correct 
> > behaviour and hence why I'm filing this bug report
> >
> >
> >
> >
> > ________________________________
> > NOTICE: This message, and any attachments, are for the intended recipient(s) only, may contain information that is privileged, confidential and/or proprietary and subject to important terms and conditions available at E-Communication Disclaimer<http://www.cmegroup.com/tools-information/communications/e-communication-disclaimer.html>. If you are not the intended recipient, please delete this message. CME Group and its subsidiaries reserve the right to monitor all email communications that occur on CME Group information systems.

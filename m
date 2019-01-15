Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F81A1F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 14:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbfAOOHA (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 09:07:00 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:40859 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729920AbfAOOG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 09:06:59 -0500
Received: by mail-lj1-f178.google.com with SMTP id n18-v6so2419671lji.7
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 06:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ok6j/P0OKaZt8gIhTQNSOTYetY+YezXymLt+vmbB8Gg=;
        b=CQgs0ivSgABJcXNzM4VYz+BJXZg9mzlieRpwsTHbvgx5xc8Zw+0eCjq1lSAw6XpIAg
         Vu6FCNHYLOP5O2T/kubg5b+za4ma5UbHGpocWAZNZiIKPJfKOZX/SbKcBgVISsyiT+SE
         +kUCE7FvVL2uo4T3IPiReBFH+WWc3Yz1wNA5enSBR9SM9otejeAGhxaZykRXQcp34o3l
         s7VsscFXezujz2GVWFi89cvmXM9iCXqDiR2YCdu+AY2EoFUseCUnLoNw6Dj7xCkOgK3u
         qyCUua6ooJGWi1VcIGcrYkEFA6+AEjlXj3CzOKCJLHSudZaSFIxlWEYm0478bwi4YZUW
         O9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ok6j/P0OKaZt8gIhTQNSOTYetY+YezXymLt+vmbB8Gg=;
        b=Tw8YUfgPFwIPt5rBB1ux1UYBpIfXkn5UWEToZITfBXo2e1JYzgRSjZifh1dfZNUd0D
         n2n/jf1pj6WrPaWlaTf5g+EoeGj8Ebf+yVAh6fUJgbB04tMI1L5HevmICA1NSFS1lLbh
         r31evkJay92AgLuwT+jiZAS1tuUaUfjThNVLKBu5hGQVOIJ1P3o7O8+cl0pzEKv8eefr
         WiRaverD+EYtJMCIaMVjHnkZbuWSE5QAWW2xTSP9vCrKXe1uhXw81osFqmwMZBWPYXUg
         ltHYKZr+/HHRbdJcXXmOpUD++vedsd1D7vMsQsFcNIbBYkGltNxpRNDZUohYz/ubSFW5
         KIGA==
X-Gm-Message-State: AJcUukev+eRL4yf2VVHPNX8ISAeL/cmlUSGr3UspbbH6BYFzxpG+bKBa
        wkSM8y514h+tQmWJV0rDToa8cs72K0sOHJDf/PrtI8gk
X-Google-Smtp-Source: ALg8bN4e/+EoFfkJDnpBMxEisRUoaimCAZmrOrUPr8d0JL3qzk3JIZxod2D4zMcc/OZWu4WIsIK+no784f4MZ5ntgx4=
X-Received: by 2002:a2e:9bc3:: with SMTP id w3-v6mr2868107ljj.70.1547561216948;
 Tue, 15 Jan 2019 06:06:56 -0800 (PST)
MIME-Version: 1.0
From:   Lewis Cawthorne <llcawthorne@gmail.com>
Date:   Tue, 15 Jan 2019 09:06:45 -0500
Message-ID: <CABvi_gsnpyeJAxJr3xyi6XC1byTsbbFU3EKnJhJmem7vJ-OHtA@mail.gmail.com>
Subject: 'git add .' failing to stage files in OS X
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm having a problem on my MacBook.  When I do `git add .` and then do
`git status`, all my files in the current directory and subdirectory
remain untracked.  I'm not sure if it's a bug in the OS X version of
git I'm using (I tried upgrading) or something specific to the setup
on my Mac (I've tried eliminating possibilities).

The problem started with a directory I had named 'micronaut-guides'
that I wanted to initialize as a repo.  It had a subdirectory called
apprentice and one called data-access.  apprentice has a subfolder
named 'java' with five or six subfolders containing java projects, and
data-access had one folder 'jpa' containing a java application.  If I
cd to micronaut-guides, then `git init`, then `git add .` and then
`git status`, I get the following:

-----------------
On branch master

Initial commit

Untracked files:
    .gitignore
    README.md
    apprentice/
    data-access/

nothing added to commit but untracked files present
-----------------

If I try to track a specific file in a subdirectory (`git add
apprentice/java/commit-info/Dockerfile`), it successfully stages the
single file, and then lists other files in the
apprentice/java/commit-info directory as specifically untracked,
rather than just listing the directory as untracked.  I can
successfully stage a single file in the root directory of the
repository by doing `git add .gitignore`, and then when I do `git
status` the .gitignore file shows as staged and the other files remain
untracked.

I've since verified the command-line client is exhibiting the same
behavior in other repos cloned from github when I try to add content.
I cloned my spring-guides repository from github and created a
directory for the actuator-service guide, worked through the tutorial
to create a functioning project in the subdirectory, then did `git add
.` and `git status` and it said the new folder was untracked still.

I've found a work around.  Instead of using the command-line client, I
have to open the Github Desktop client, and then add my files and sync
to get changes up to my repo.  Everything works fine adding files and
pushing changes there.

So far, I've tried adding files in both a new and existing repository.
I've tried `git add -A` instead of  `git add .`.  I've tried `git add
--all ./` with no luck.  It has been doing the same thing for both the
Apple version of git I started with, and the 2.20.1 version that I
upgraded to (installed via homebrew).  I've also tried deleting my
.gitignore file, even though the same .gitignore works with repos on
Windows fine.  I made sure there was no .gitignore in any parent
directories and that there were no .git folders in any parent
directories.  `git check-ignore -v -- /path/to/a/file` didn't produce
any output.  I've also tried changing my shell to bash instead of zsh,
in case something in my shell was interfering.  I've checked my
aliases to make sure I'm not aliasing git to some other command.  And
I've tried moving the repo directory to / and adding files there, to
be extra sure nothing in any parent directory was interfering with the
operation.

As I recall, git used to work fine on this Mac, but it's been a while
since I've tried to use it (it being both the Mac and git on the Mac).
The Mac in question was recently upgraded to OS X Mojave (it bugged me
to upgrade when I dusted it off and turned it on).  I don't remember
when the last time I used git on it for anything before the upgrade
was..

I've asked about this in StackOverflow, so there are a little bit more
details and ideas from other people at
https://stackoverflow.com/questions/54175235/cant-git-add-to-stage-files-in-new-repo,
but I tried to summarize everything here.

Any ideas to fix this or even work around this without using a GUI
client would be appreciated.

Thanks,

Lewis Cawthorne

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D25E0201A4
	for <e@80x24.org>; Mon, 15 May 2017 00:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751645AbdEOAXF (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 20:23:05 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:33708 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751005AbdEOAXE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 20:23:04 -0400
Received: by mail-io0-f178.google.com with SMTP id p24so64588013ioi.0
        for <git@vger.kernel.org>; Sun, 14 May 2017 17:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=toqyc6vaaxASYpcER1oN0wcPDwPR+FIZk1PhhNH3TsE=;
        b=Bwp0j8bjWoCigyZLcncLlwVUmgw+CMQO/xIIJ3zbZRA2sUGyDmn9SL0DeNWgnu/8nM
         bMalHlwX3EM1YI/um2QOY5uDOlNpdCXTEyQZx9RBIiGhWwsYXrVi96/7EAww1WqFNbxV
         iEfWPXco/sSMwWibmIIzRaMM1CMUFanq0IL7uCP47jArESL7gVOE5Zf6kzF27ceDy6/Z
         U2tBaYviWA89CDq+F3xd5/d6qf0kaEgDr28ZmbvYDZY0L2PTU7Fq+vYZFhC1yuE7SZzR
         GIS27ow5ActFIWRVmFO8r6dM+nPsK0BB0CYZG24o7CChNfTd19aTcS/eXb1RqbQ9DVVx
         7u+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=toqyc6vaaxASYpcER1oN0wcPDwPR+FIZk1PhhNH3TsE=;
        b=B06wb7sWZ9Q67VsYd7JpHngvvc1qM/sCqTbE5+76UfKav6H7/toA8ftN4E2gXOikZN
         OcvlL8/ZDkjbgikfg0Vhl0NEo1bBP8qKIw56z56Bz828bgCz0rrSWVHYAwI3krwXfE+F
         m2Sz0VU4O827HjaoF65Ml2nVHWabTSGAPLU6mgbtjAlEVHZe4e9CxnRUFo9i6oNHRQS8
         q8pnse/hKe+LQBVxBIORjngK12S7d+iGxwSYlD/Zn2QAwhRHFO9ipCWoc9RZdZfUSMiw
         giqH8obphwHEbVqlo163qYNe1ekquU9Ae75ayqsVpbN6bIwbcNVIZ75aNCMl0j6/BdI6
         LUmQ==
X-Gm-Message-State: AODbwcA3mMGmZP2ZWrVwdzs4blEJTUrh4ovO6zNLgVGajincDWKm1nZa
        5tGp7jGYyjTytmsAk7Nhe9RWhQW5dw==
X-Received: by 10.107.10.24 with SMTP id u24mr3545440ioi.82.1494807783954;
 Sun, 14 May 2017 17:23:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.38.6 with HTTP; Sun, 14 May 2017 17:22:33 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1705121643180.146734@virtualbox>
References: <CANuW5x0pBwfQeha50mxN8pVQKm67u_b3UKTCQ8ZbJA6FUGvYbw@mail.gmail.com>
 <alpine.DEB.2.21.1.1705121643180.146734@virtualbox>
From:   Josh Hagins <hagins.josh@gmail.com>
Date:   Sun, 14 May 2017 20:22:33 -0400
Message-ID: <CANuW5x0rOKm29SDR_jF9ZydAA5UPyjmvnoH9At+M_uXUzdV5HA@mail.gmail.com>
Subject: Re: [Git 2.13.0] BUG: setup_git_env called without repository
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Here's the full text of the gdb session, including backtrace. Hope it helps!

$ pwd
/Users/jhagins/dev/github
$ gdb -args ./git/git config --local --get user.name
GNU gdb (GDB) 7.12.1
Copyright (C) 2017 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "x86_64-apple-darwin16.4.0".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
<http://www.gnu.org/software/gdb/documentation/>.
For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from ./git/git...done.
(gdb) b die_builtin
Breakpoint 1 at 0x100210757: file usage.c, line 33.
(gdb) r
Starting program: /Volumes/git/github/git/git config --local --get user.name
[New Thread 0x1403 of process 64101]
warning: unhandled dyld version (15)

Thread 2 hit Breakpoint 1, die_builtin (err=0x100270d95 "BUG:
setup_git_env called without repository", params=0x7fff5fbfdbe0) at
usage.c:33
33 vreportf("fatal: ", err, params);
(gdb) bt
#0  die_builtin (err=0x100270d95 "BUG: setup_git_env called without
repository", params=0x7fff5fbfdbe0) at usage.c:33
#1  0x000000010020fc80 in die (err=0x100270d95 "BUG: setup_git_env
called without repository") at usage.c:120
#2  0x000000010012cb2b in setup_git_env () at environment.c:172
#3  0x000000010012cab7 in get_git_dir () at environment.c:214
#4  0x0000000100214e9c in get_worktree_git_dir (wt=0x0) at worktree.c:215
#5  0x000000010017968c in do_git_path (wt=0x0, buf=0x7fff5fbfde50,
fmt=0x10024c24d "config", args=0x7fff5fbfde70) at path.c:395
#6  0x0000000100179c78 in git_pathdup (fmt=0x10024c24d "config") at path.c:437
#7  0x0000000100030449 in cmd_config (argc=1, argv=0x7fff5fbfe180,
prefix=0x0) at builtin/config.c:527
#8  0x0000000100001ac5 in run_builtin (p=0x10028c3a8, argc=4,
argv=0x7fff5fbfe180) at git.c:371
#9  0x0000000100000cc6 in handle_builtin (argc=4, argv=0x7fff5fbfe180)
at git.c:572
#10 0x0000000100001883 in run_argv (argcp=0x7fff5fbfe12c,
argv=0x7fff5fbfe120) at git.c:624
#11 0x0000000100000a4f in cmd_main (argc=4, argv=0x7fff5fbfe180) at git.c:701
#12 0x00000001000c3772 in main (argc=5, argv=0x7fff5fbfe178) at common-main.c:43

Cheers,
Josh

On Fri, May 12, 2017 at 10:48 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Josh,
>
> On Fri, 12 May 2017, Josh Hagins wrote:
>
>> Since upgrading to Git 2.13.0 I'm seeing this error message whenever
>> `git config --local <whatever>` is called outside a Git repository.
>> For example, note the difference in behavior between Git 2.13 and
>> Apple Git:
>>
>>     $ pwd
>>     /Users/jhagins
>>     $ /usr/bin/git --version
>>     git version 2.11.0 (Apple Git-81)
>>     $ /usr/bin/git config --local --get user.name
>>     $ /usr/local/bin/git --version
>>     git version 2.13.0
>>     $ /usr/local/bin/git config --local --get user.name
>>     fatal: BUG: setup_git_env called without repository
>>
>> Apple Git outputs nothing, as expected. The summarized release notes
>> published by GitHub specifically mentioned that instances of this
>> error message should be reported, so here you go!
>>
>> Please let me know if I can provide any more information that would be
>> helpful.
>
> Since this is in /usr/local/bin/, there are two possibilities:
>
> 1) you built and installed it yourself (but then it would be more likely
>    in your $HOME/bin), or
>
> 2) you installed it via HomeBrew.
>
> I guess it is the latter.
>
> In both cases, however, you have XCode installed, so you can dig further.
> Yay.
>
> The thing I would do in your case would be to clone Git:
>
>         git clone https://github.com/git/git
>
> then check out v2.13.0:
>
>         git checkout v2.13.0
>
> then edit the Makefile to remove the -O2 from the CFLAGS (the next step is
> to use the GNU debugger, and in my hands the -O2 optimization made that
> pretty useless), and then build with
>
>         make
>
> After that, you should be able to start the command in your local GNU
> debugger:
>
>         gdb -args ./git config --local --get user.name
>
> You will then want to set a breakpoint on the die_builtin() function:
>
>         b die_builtin
>
> Now run it with the `r` command, and it should stop in the die_builtin
> routine, in which case a backtrace would be most helpful to figure out
> what is going wrong:
>
>         bt
>
> If the output is not enlightening on its own, it would be nice to paste it
> into a reply to this mail so that the entire Git developer community can
> have a look.
>
> Ciao,
> Johannes



-- 
Josh Hagins

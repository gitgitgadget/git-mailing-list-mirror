Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43A4B2027C
	for <e@80x24.org>; Mon, 29 May 2017 11:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751058AbdE2LTa (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 07:19:30 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:34238 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750988AbdE2LT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 07:19:29 -0400
Received: by mail-oi0-f46.google.com with SMTP id b204so75411285oii.1
        for <git@vger.kernel.org>; Mon, 29 May 2017 04:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OtdV096IWkScEnUdOwsrKC90z3JzrueWONP63ZH1QEU=;
        b=Is2QiGGg3BCX+WgqiRzZ0JFDi53S8biAkE3Byv0htUKtkl4liVtz5GiY/rL/zSafK5
         TZ6BEe+1LvWWBBOcEcHGYg05i9ckA6xX03CEpA676viLxiZxAMwYZcG8rAJ6F0nGN4mY
         Sc0Bn8KaF1N3ixyiJc0g8te288eV9XNgW01W5IXj2TuTRwVmtRkMN2xJ5to+T55phD8w
         8QjwkKCArlp2k8ivGT0lHRHkUuH0MaggSixjcUQJ3ESl1uplXAohtM938TpiEbw8M85I
         jkn8CH7WfhWiAXFRFtdXqhJJtj/ZYeFPLvRv/7T+/zkACIrvEvnKjqCg7GxbJS6qjmSO
         mqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OtdV096IWkScEnUdOwsrKC90z3JzrueWONP63ZH1QEU=;
        b=gNIys6SOivZXPD1Bk6DPbQw7Z6WZZUPnK7vtkKSnvcVxASKMcaqc8qH55dVkC9Mjei
         6JPZi7/8kG4FNpkacPD0sYutAB/Ds2BV7icSPjz5w4QFyL0/sy+R7MVa8Y20HuqT0/Re
         cs2pNldef8026nZoSZd6ZvhYUtaG2ZgO4HuXng1QgFSto9R0dDN+6Ux62H9HjALF0ixB
         toGqxUcvy1uYVdP5Sild0/yzrDkPNDsw3GZkAYcYOadY7+tL1qsYhisFo0wZ3qqv5BO7
         /h4t4QjAVn6xcMVoOZ3rRA44o+150MT47c051dqbKnrS2pBeCg7Mky7hazbjz7gmqiqy
         d6pg==
X-Gm-Message-State: AODbwcA2HzNk8fh8pMj8c8ewNurj3aWDfwe9i/RHi0JQpWOJ1OUNP4v6
        4gnZXFSja4XSwt10n6yN13uaimwMDw==
X-Received: by 10.202.81.12 with SMTP id f12mr7314412oib.66.1496056768567;
 Mon, 29 May 2017 04:19:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.145.17 with HTTP; Mon, 29 May 2017 04:18:58 -0700 (PDT)
In-Reply-To: <63F1AEE13FAE864586D589C671A6E18B0D5F2C@MX203CL03.corp.emc.com>
References: <63F1AEE13FAE864586D589C671A6E18B0D5F2C@MX203CL03.corp.emc.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 29 May 2017 18:18:58 +0700
Message-ID: <CACsJy8AGVDCR0uO--txR2-6B6tF1w8mhZ4G6BPMznHVWS-vzGA@mail.gmail.com>
Subject: Re: git worktrees must exist even if locked
To:     "taylor, david" <David.Taylor@dell.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 3:24 AM, taylor, david <David.Taylor@dell.com> wrote:
> The Git documentation in describing worktrees says that one reason
> why you might want to lock a worktree is to prevent it from being pruned
> if it is on a removable media that isn't currently mounted.
>
> So, my expectation was that if the worktree is inaccessible (and locked), Git
> would pretend that there is no worktree by that name.
>
> In reality, if you have such a worktree, Git gets an error.
>
>  On local systems, /home is local to a machine; home directories are elsewhere.
> Home directories are NFS mounted; /home is not.
>
> . create a repository in /my/home/dir/my-repo.git with
>
>     git clone --bare <some arguments>
>
> . create an empty directory /home/somedir/worktree-tests
>
> . use 'git worktree add' to add /home/somedir/worktree-tests/<branch-name>
>   as a worktree on branch <branch-name>.  It gets populated with the correct
>   content.
>
> . lock it using'git worktree lock'
>
> So far, so good.  Now, go to a different computer -- one on which
> /home/somedir/worktree-tests does not exist (and therefore
> /home/somedir/worktree-tests/<branch-name> does not exist).
>
> . cd /my/home/dir/my-repo.git
>
> Now, try issuing Git commands.  Many will fail.
>
>   git fetch ==> fails:
>
>   fatal: Invalid path '/home/somedir/worktree-tests': No such file or directory
>
>   git status ==> fails -- same error as above
>   git help worktree ==> fails -- same error as above

FWIW I couldn't reproduce this. The fact that "git help" also fails
suggests this is triggered by some early setup code, which narrows
down the starting point to strbuf_realpath (that can print "Invalid
path", the other call in read-cache.c involves adding index entries
and can be ignored). But I fail to see how early setup code needs to
look at any worktree at all, especially when you issue command
standing from my-repo.git (i.e. bare repo setup, even current worktree
is ignored). An strace output, if possible, might help pinpoint the
problem.
-- 
Duy

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E76A31F453
	for <e@80x24.org>; Mon, 18 Feb 2019 15:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730658AbfBRPDC (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 10:03:02 -0500
Received: from mail-it1-f175.google.com ([209.85.166.175]:35966 "EHLO
        mail-it1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729905AbfBRPDC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 10:03:02 -0500
Received: by mail-it1-f175.google.com with SMTP id h6so40404233itl.1
        for <git@vger.kernel.org>; Mon, 18 Feb 2019 07:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O0iYDm/tNMxjt1QHD2D2aRh2+V2L7VFFXZl976Iy1T4=;
        b=GufkrLd5ngjZrKlQRzpM4qf7VipSE9wMnhWSW5D7rq+hOvCWben6nS1hHxfL6tTec7
         9x3LFal+7lh8flYTfZE1htMioJr4oMkrc5NsrkD4iKIcOOPOnJUsahL8WNJWJ8hFNalY
         jJqDHclXsDRn7IFCcMwEUL6dvBImz9dBkOn4L8T3V8pmeyDwGOR0xUSeQ0YsntKcWq2I
         Gd1vRMdi7laPWAPpvat1aws1GoFiCLdPMwffFF6ucJdyauvbYNvfa2j1EYthvCsLC6gS
         XaZfuadmDdbk0ELa0d3lyBqKAr5Eo8ZTnf5ZMcW2jER4ubESS2j6tyVipwZKSn9n8XDs
         zpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O0iYDm/tNMxjt1QHD2D2aRh2+V2L7VFFXZl976Iy1T4=;
        b=MLBekYSSChYtEf1K7jNlO4X752LfJD661MgR1R9N+0TLJQZmqxR8Oqq1hx/5Ntwp7y
         MjShKQMlprMFzCR3ZiLGa4ZGRxhApAFNrXEjE6nyQkiwRXFXxzgDmqBFOwsm4bzGbo+m
         YiCikGrVoAsLl1uih1zJluKYWIseR98h+VrigitzL5yPqpQ7FKg+wJu7G4OaKLNaGbXM
         d3w5khcpGOG0zt2paQRsq7r82t+8m82L69bseuM1L/pzsI/paMGBGGn0wfxtQkUOU73r
         ckMg426xK8jq3oypcR8hgYx1h65fysxFjr3uzsiebGNugvlVFyK3Uyoab3c4mP2dOu8F
         FJZw==
X-Gm-Message-State: AHQUAuZANRmiRKIG+1WuQaiARHQxjfL8DKGqjyf1MmOJ5gMRliuImFG7
        FnUbqOYNDChyWfMnYcATzE3wNr7oPqXw5met60c=
X-Google-Smtp-Source: AHgI3IaVsb1NCxjMiW0eA8FzZIzVfuo2scYChjpKKnUY7J3UISQTSS37OEAbviMYwvNfKd6D5GEoqTg4M/rQ5uLrP1o=
X-Received: by 2002:a6b:6b18:: with SMTP id g24mr12090081ioc.282.1550502181255;
 Mon, 18 Feb 2019 07:03:01 -0800 (PST)
MIME-Version: 1.0
References: <1550500586.2865.0@yandex.ru>
In-Reply-To: <1550500586.2865.0@yandex.ru>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 18 Feb 2019 22:02:34 +0700
Message-ID: <CACsJy8Bjryv5Of0kN-wwiQs5S3Km=z=WRDTPcBD_Sgsm6Mvjag@mail.gmail.com>
Subject: Re: git gc fails with "unable to resolve reference" for worktree
To:     hi-angel@yandex.ru
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 18, 2019 at 9:44 PM <hi-angel@yandex.ru> wrote:
>
> # Steps to reproduce (in terms of terminal commands)
>
>     $ mkdir foo
>     $ cd foo
>     $ git init
>     Initialized empty Git repository in /tmp/foo/.git/
>     $ echo hello > testfile
>     $ git add testfile && git commit -m "my commit1"
>     [master (root-commit) d5f0b47] my commit1
>     1 file changed, 1 insertion(+)
>     create mode 100644 testfile
>     $ git checkout -b bar
>     Switched to a new branch 'bar'
>     $ git worktree add ../bar\ \(worktree\) master
>     Preparing worktree (checking out 'master')
>     HEAD is now at d5f0b47 my commit1
>     $ git gc
>     error: cannot lock ref 'worktrees/bar (worktree)/HEAD': unable to
> resolve reference 'worktrees/bar (worktree)/HEAD': Invalid argument

Thanks for reporting. This is not a valid reference and causes the
problem. The worktree's name has to sanitized. I'll fix it tomorrow.

>     fatal: failed to run reflog
>
> # Expected
>
> No errors
>
> # Actual
>
> error: cannot lock ref 'worktrees/bar (worktree)/HEAD': unable to
> resolve reference 'worktrees/bar (worktree)/HEAD': Invalid argument
>
>


-- 
Duy

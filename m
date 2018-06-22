Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75DF61F516
	for <e@80x24.org>; Fri, 22 Jun 2018 20:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932981AbeFVU7N (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 16:59:13 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:44583 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754283AbeFVU7M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 16:59:12 -0400
Received: by mail-io0-f195.google.com with SMTP id g7-v6so7259254ioh.11
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 13:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NYbxZo1+QTxuRY0RaXS0wrMwCs6RmEYUE9MyhP56EMQ=;
        b=oOw9LZU5NI0UPzBcNGRkh13hfBRDUBDcSPXcL3ZL749BrTSSnvy5uD0hMmhC3vHYhD
         X0S8Sh3KHmCpqj8bFRdNEtLRUnimDtqHI0rFQRoqfaQDSy1QR3n6UCwQlCNuMZZ+96JZ
         N+Tr7nLdg9MKfTSgqgQanlCW92d8BriR2wCFTrd9SiEmgErvanywOxvrhqF0dPHv7jCj
         6h6Vs25DtNS+Vnj0+9Jobd9NPWLDyP3JEjQwHZ9qKUhTwzWSfD3ESOnT5o06g0M5JgOd
         NzuVAAMedSClKxgF40OCNpKbR56IWvkM/oExulmZ09BBvcZjBJkD7dpT09qiFwiJgrLm
         3neg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NYbxZo1+QTxuRY0RaXS0wrMwCs6RmEYUE9MyhP56EMQ=;
        b=lYSQPLhbuFGTv+o0hvHar8mRiJHOwsnbxS6hpkyPEJTgtRaLO/4/di2zajepKAxqez
         vakAB/N/YEr8euKlrel8f4y+xVnRDXam8PaMrtnUwR8QpCrxvhkrZKQ5p35PY4VlxoQc
         /57Ba955uIo45o0jNG6G0/FL1Z+SX0Yj91Ki/KgdFCWCN9wvknkbldujjgrPLUWj3i46
         QnYvxqkG2INMwIjCPanRFQ+c+7EG2j4P6VKY8pZKzemAHRiYPzCBTvWERNy6R7Zoekvb
         X+ntWEDzIYwdivimBGys/4CXEuOaFuIW5DytrdpkUSWcO1PZkHmDYTIAMKjK4LJRosKf
         xAxg==
X-Gm-Message-State: APt69E0vP9Og5sEm8URf9H63kSEO6WfRrOY6xYzj6NJLx+Enm/F7qQGt
        Oj3FeSTUs7/qfletNqBrp6q2tKC1WtFtTf1uADT+Qwhde94=
X-Google-Smtp-Source: AAOMgpcBi5GeX5pFVzvdCCjKc1L6ZiKD7Ne4J8W5l66LRsNpZLhfjtT5xDhxkGE3l3+iild9iK0KCsF4L9m0mK9K2zo=
X-Received: by 2002:a6b:f314:: with SMTP id m20-v6mr2629860ioh.253.1529701151533;
 Fri, 22 Jun 2018 13:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <c5abdd45-a919-96f6-8560-5fd943069f5e@syntevo.com>
 <1c7e338e-157b-fd2f-5eb1-01373f627acd@kdbg.org> <2cf2d884-de1a-7b9b-5aca-1f396ad205a2@syntevo.com>
In-Reply-To: <2cf2d884-de1a-7b9b-5aca-1f396ad205a2@syntevo.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Fri, 22 Jun 2018 13:58:57 -0700
Message-ID: <CAGyf7-GvcN8EhMgtaZcDJNYNdfLwVH8HVBDmZqJU40nze0NSEA@mail.gmail.com>
Subject: Re: Unexpected ignorecase=false behavior on Windows
To:     marc.strapetz@syntevo.com
Cc:     j6t@kdbg.org, Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 22, 2018 at 1:45 PM Marc Strapetz <marc.strapetz@syntevo.com> wrote:
>
> On 22.06.2018 19:36, Johannes Sixt wrote:
> > Am 22.06.2018 um 14:04 schrieb Marc Strapetz:
> >> On Windows, when creating following repository:
> >>
> >> $ git init
> >> $ echo "1" > file.txt
> >> $ git add .
> >> $ git commit -m "initial import"
> >> $ ren file.txt File.txt
> >> $ git config core.ignorecase false
> >
> > This is a user error. core.ignorecase is *not* an instruction as in
> > "hey, Git, do not ignore the case of file names". It is better regarded
> > as an internal value, with which Git remembers how it should treat the
> > names of files that it receives when it traverses the directories on the
> > disk.
> >
> > Git could probe the file system capabilities each time it runs. But that
> > would be wasteful. Hence, this probe happens only once when the
> > repository is initialized, and the result is recorded in this
> > configuration value. You should not change it.
>
> Sorry, it looks like my example was misleading. I'm actually questioning
> current behavior in case of Windows repositories with core.ignorecase
> initialized to false, like in following setup:
>
> $ git init
> $ git config core.ignorecase false
>
> The repository is now set up to be case-sensitive on Windows. From this
> point on, core.ignorecase won't change anymore and the repository will
> be filled:

I don't think Hannes's point was _when_ you changed it; it was that
you changed it _at all_.

Git on Windows is not designed to run with anything other than
core.ignoreCase=true, and attempting to do so will cause unexpected
behavior. In other words, it's not a behavior toggle so user's can
request the functionality to work one way or the other; it's an
implementation detail that `git init` and `git clone` set when a
repository is created purely so they don't have to probe the file
system each time you run a `git` command.

NTFS is case-preserving-but-case-insensitive by default[1]. So long as
that's the case, the only mode for running Git on Windows is
core.ignoreCase=true.

Hopefully this clarifies things!

Bryan

[1] Windows 10 1803 introduced the ability to set a folder as
case-sensitive[2], but, since it's not inherited automatically by
subdirectories, it still doesn't work well for Git.
[2] https://blogs.msdn.microsoft.com/commandline/2018/02/28/per-directory-case-sensitivity-and-wsl/

>
> $ echo "1" > file.txt
> $ git add .
> $ git commit -m "initial import"
> $ ren file.txt File.txt
>
> Still, status results are:
>
> $ git status --porcelain
> ?? File.txt
>
> With the same setup sequence on Unix, it's:
>
> $ git status --porcelain
>    D file.txt
> ?? File.txt
>
> Is this difference, which is depending on the platform, intended? Why
> not report missing file.txt as well?
>
> The drawback of the current behavior is that a subsequent "git add ."
> will result in two file names in the .git/index which are only differing
> in case. This will break the repository on Windows, because only one of
> both files can be checked out in the working tree. Also, it makes
> case-only renames harder to be performed.
>
> -Marc

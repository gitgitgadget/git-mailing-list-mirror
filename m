Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D93220248
	for <e@80x24.org>; Sun, 14 Apr 2019 01:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfDNB7t (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Apr 2019 21:59:49 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45997 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbfDNB7t (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Apr 2019 21:59:49 -0400
Received: by mail-qk1-f195.google.com with SMTP id z76so7913391qkb.12
        for <git@vger.kernel.org>; Sat, 13 Apr 2019 18:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oidBXCi7/N+ZwUSouwMSxAW/C2te8C9bRL/39xey/Us=;
        b=hhE+LrW5W05Jdntz3xc0czXNVt+3b7LZPoX+F3SPj/D5EXGSyySQGcB08Qjhi2p30A
         5i15IWrfAx1KuQcpCK1+Y4dj+tw+AJbEo0K5fxeCGVOhPdU0sND7G/VzbSIXdtj9RKqI
         dvsz7IQuU2hl1ox/OBRW1CWT52hitiuLOMpVCTrbHPPximpCUSfUhgkhQmlyJO2k54wR
         0PprWo8chGK3iygkfj/0xQ1hNWrIkk/I9YNOu/d11RZ0W5fm0gjAkGee3l4MoDU2f75F
         wqNDKHlLRuB6SJMh5oW8hZj3tXq6RLDyGw0pcuQIswRncTrLA/+GrjBF6zZ5oCENQ5aU
         nfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oidBXCi7/N+ZwUSouwMSxAW/C2te8C9bRL/39xey/Us=;
        b=WNHaEn9zYHSNmimqf8+SZQB3LS8ELyJqM3of66JKm+CsIQ6ZNxhYFBHbA7HbJln9gF
         VbkNCEw38WE1l75mpqB2IScCshTWqrVUTUe9Ja6StKkLkxLkUQSVEqKwbghI6RqENTr+
         5U4EOHSWnHrb/oUQc5zuYZozLZAHafLRYfZ9BXgvyL4WLS/vFe8v8HosJZgosXBJgzTr
         cDODGEnJiRCbW4ZO1IX0NDZ67EbO/UyP+T5fjZ3i7byhhAOAxfVdDtE9VxSCASEy0xZY
         LVosBU+b2RALyzDltoJHeYvWTSy2l3sTsEP6599B+RBf4AHqZrlYtrUYtzKeBrIr5NV5
         6thw==
X-Gm-Message-State: APjAAAX3FTltdERmMVsd4AZn2T7Buz8leNa/1+iIVrD1XF3ikNsKXmLn
        hJpRvnYGAuSoE25SoTypWUquKr2FZAvXh945LPQiCPnA
X-Google-Smtp-Source: APXvYqzFh2lYCYGfbjUtEgYJwQxYnQWIlcTZhxh5D9TuK/shaKM+XCW21KMiNpXjVv8M/B4+mYOyEVp/q/eyqvR/3RU=
X-Received: by 2002:a37:614e:: with SMTP id v75mr50739533qkb.27.1555207187976;
 Sat, 13 Apr 2019 18:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAL_tzDGRQ4BzJ4c6QypXfBXQNQYocbKbJSBOHhBBB2TwQQPCGA@mail.gmail.com>
 <2643a200-5356-f3bc-1715-3f34b5f19a5b@gmail.com>
In-Reply-To: <2643a200-5356-f3bc-1715-3f34b5f19a5b@gmail.com>
From:   wh <microrffr@gmail.com>
Date:   Sat, 13 Apr 2019 18:59:36 -0700
Message-ID: <CAL_tzDFQQtDYMStN+RDVYN_TzJmO+kufMhG9PGHwvsUWREpgWQ@mail.gmail.com>
Subject: Re: [BUG] rebase --interactive silently overwrites ignored files
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the info about the upcoming "precious" attribute. Looks useful.

I didn't get the impression that Git normally overwrites ignored
files. I ran some more experiments:

git rebase FETCH_HEAD        # bails
git rebase -i FETCH_HEAD     # overwrites
git merge FETCH_HEAD         # bails
git reset --keep FETCH_HEAD  # bails
git reset --merge FETCH_HEAD # bails
git checkout FETCH_HEAD      # overwrites
# without feature 2 locally:
git merge FETCH_HEAD         # overwrites, fast-forwards
git merge --no-ff FETCH_HEAD # bails

On Fri, Apr 12, 2019 at 9:30 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi
>
> On 12/04/2019 00:56, wh wrote:
> > I'm using git 2.20.1 from Debian. Git is usually careful not to
> > overwrite untracked files, including ignored files.
>
> Git normally overwrites ignored files, so I think in your example rebase
> -i is working as expected, I'm surprised that the am based rebase does
> not overwrite the ignored file. There has been some discussion about
> introducing 'precious' files that are ignored but protected in the same
> way as untracked files [1].
>
> Best Wishes
>
> Phillip
>
> [1] https://public-inbox.org/git/20190409102649.22115-1-pclouds@gmail.com/
>
>   But interactive
> > rebase doesn't detect this (non-interactive rebase works fine).
> >
> > Reproduction:
> > -----
> >
> > #!/bin/sh
> > mkdir upstream
> > cd upstream
> > git init
> > echo 1 >feature-1
> > git add feature-1
> > git commit -m "feature 1"
> >
> > cd ..
> > git clone upstream local
> > cd local
> > # write some tools for our own convenience
> > echo ours >tools
> > echo /tools >>.git/info/exclude
> > # start working on a feature
> > git checkout -b f2
> > echo wip >feature-2
> > git add feature-2
> > git commit -m "wip"
> >
> > cd ../upstream
> > # official tools are available
> > echo theirs >tools
> > git add tools
> > git commit -m "tools"
> >
> > cd ../local
> > git fetch ../upstream master
> >
> > # this would be okay
> > #git rebase FETCH_HEAD
> >
> > # problem: overwrites tools silently
> > GIT_EDITOR=true git rebase -i FETCH_HEAD
> >
> > cat tools
> >
> > -----
> >
> > Expected: `git rebase -i` fails because it would have to overwrite the
> > untracked "tools" file. Contents of tools file remains `ours`.
> >
> > Actual: Contents of tools file becomes `theirs`.
> >

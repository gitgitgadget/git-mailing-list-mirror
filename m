Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE1641F453
	for <e@80x24.org>; Thu, 31 Jan 2019 14:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbfAaOv5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 09:51:57 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:38385 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfAaOv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 09:51:57 -0500
Received: by mail-it1-f194.google.com with SMTP id z20so4523830itc.3
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 06:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sD/BhUI0K2ueeGNLNh8q+xx34Mn3XjeJXx6iNvshFdA=;
        b=aMu62FkNzHPF0ilf1ro+eROCPZ4ZV3uwsEGo+ejQHnnFdCde04b+b0/4SXgT80+u94
         GS9YjcRqaz3CA/g7HIJbdnTF6XelKu7tkFrTsHzLHPh2ICdR1IZlCpU+uLYh94JCy1JH
         YtUZ5xFlSdr97iDPl+vDsfvEy93Jl9NqmlsQ/BCcMvZkUGKkSNwuYgAXm2CA6mqT4yzI
         lbaY36ZZP0pkmvaqcOhWnc6P02L34LTOIy8XsDZ34ZUp3oeUQa96fWN3jLm/B9RuDe5H
         ujPzUTtCva65bYESIxF8NRm8gFn18vf9vZkQ+PMfb1yDCMeqi0BWCnVO8hYuGrBWJhWN
         RHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sD/BhUI0K2ueeGNLNh8q+xx34Mn3XjeJXx6iNvshFdA=;
        b=a4ZhO0TTUSVVU81EdGMmzwXMFO7RCsFElgMkCYIWB78Ap5B07K2k4sehISw+z/1QeW
         w5z5zl0UMtyt7z1iyvTVo03IcQerB8O+T9Xpu8s4RCUgCqLx9p3iUFXzzjTv3ySmNzZW
         KJxHPzdP61yN53tjRco7AgBbv4wdwHfRHmkYklwgLjpURtgQFYWY55whBre04WdP7MwL
         s/GmngwALHhpcWH69X42do5mJ35kQhhUN/bqvlke2dS+lcC4BfEfTu7C0EopqO+CLdze
         x8EFJe5ZiLHkuCq6VSS9yxmOVOglWwqNa4q/sM8y08p7E1NgGQqFjlPK03jOHmg21+6M
         lwHw==
X-Gm-Message-State: AJcUukeIVuT1UT9Xip+EqLb+tVKdWe0iA7YePi18kN0gEn1v7aPrkSyN
        cFSUooN9cUxX6J+57mzHlJo7ANtn/4pE5+EH+lzhKA==
X-Google-Smtp-Source: ALg8bN5egnN0aUzl9KMNkZea/ZK4T9gBmqL7R06lTpVMzXa4X3GUrO5xZypLYKto9PyYq5t7wxLMhjCydgH9TMrPJZk=
X-Received: by 2002:a24:4606:: with SMTP id j6mr15640286itb.10.1548946316606;
 Thu, 31 Jan 2019 06:51:56 -0800 (PST)
MIME-Version: 1.0
References: <20190130094831.10420-1-pclouds@gmail.com> <20190131133731.GK13764@szeder.dev>
In-Reply-To: <20190131133731.GK13764@szeder.dev>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 31 Jan 2019 21:51:29 +0700
Message-ID: <CACsJy8A7TjYWJsxXETUU31JzZL-aCXcr+rHsQ23Ec1ujeMcQTA@mail.gmail.com>
Subject: Re: [PATCH 00/19] Add new command "switch"
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 31, 2019 at 8:37 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Wed, Jan 30, 2019 at 04:48:12PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> > The
> > only one left is adding options similar to "git reset" (but with
> > better names this time than --soft and --hard, hopefully).
>
> Oh no, what for?!  As the commit message or patch 19/19 'doc: promote
> "git switch"' states:
>
>   The new command "git switch" is added to avoid the confusion of
>   one-command-do-all "git checkout" for new users.
>
> Adding '--soft|--hard' from 'git reset' would go in the opposite
> direction.

If it's about the confusion, I think we can avoid it. If it's about
the one-command-do-all, I think it still fits in the main topic of
git-switch, which is about switching. But in git-reset case it's
switching HEAD, not a normal branch.

What I have in mind so far is this, let's see if it's so bad so I can
find another direction.

git switch --reset-branch [--keep-index] [--keep-worktree] [<commit>]

This updates worktree and index to <commit> and "rewinds" the current
branch to <commit>. If either of those --keep-* is given, that part
will be left untouched. So "git reset --hard" is the same as "git
switch --reset-branch", --soft "--reset-branch --keep-index
--keep-worktree" and --mixed "--reset-branch --keep-worktree".

I've been updating docs with this new format to see what it looks like
and I think it expresses the idea behind git-reset much better.
--=20
Duy

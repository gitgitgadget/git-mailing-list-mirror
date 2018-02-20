Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1899F1F404
	for <e@80x24.org>; Tue, 20 Feb 2018 19:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750988AbeBTTnj (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 14:43:39 -0500
Received: from mail-yw0-f175.google.com ([209.85.161.175]:33609 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbeBTTni (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 14:43:38 -0500
Received: by mail-yw0-f175.google.com with SMTP id l200so2323801ywb.0
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 11:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HGHScYDG4g7ILOOiJR4jbaUUKR0M/Co816NXvhaR8/s=;
        b=kXcAGrKULFHeX0DSkmtuVwBtk0FzOIXXkNLhS4OoHNJrd7MTIsoJ0uy7p0oLRz+t/a
         eTgjBZxQZH/qWV3Z26O8c98+T4ZMU0ZZ6W5tZNHn7hEqKmpcBgbYJv71WSUCqedY65D4
         JehaQ2+8yogMhJENM0VnVxoPqIxR08iS7s5GEs2hp8ODZUpybs5fyGH1O+50eyS2ONsS
         KtAYW9VYgKzBVd1Ci0Mbn31Pbh3ZfnhhE9BLgAuEXtL315piMf6NCeTF2ziGPDs2QLRp
         N6dnxRDlhOgfupCULujCDJ3TEa6wQqljs9DAC2LYMD/YKhPitPTxzGwJNqg+8ajhLxfc
         tGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HGHScYDG4g7ILOOiJR4jbaUUKR0M/Co816NXvhaR8/s=;
        b=Oaz6kFJPmrtvPFpT0d3nTlUm4Ifin6Vvnh5KXS2wCGZTZ7Ikt6omYvPLwDwRK7mln2
         LF5c3bOIuajEEuUFDSf1bsrx0iP/siYLMEWWbp3R1xdxmNgWa4pcxFe+ZUYZrvPKDj6H
         xrvUBeRQ86rj7n86b36Jji7qB7GbmFkjXdZz8F+cZKKfYcIb0Ff1PS1/Nl+cwzNlh+r8
         Fke3r5WOO9GVukMHMVNOTQaIV/HTRK0SFnHFrUVhPd7oBptwHwLJAcb/2jEbY7VJLh6N
         lNHcD5KNSKjmV+yF826gnQp3FwuXwYxFJ5n2ATVqgDk3nD4Jt10vbQr6OqSfPHs5Dwrw
         FqJQ==
X-Gm-Message-State: APf1xPAoM+r4IPBukiKPiQIObMyviYcUQG3+17WmMvk4A/3ZqeiYKuI5
        UThc2sYoOP7xyR6mJDyWcUccH/JUCqdanpuhttbNqA==
X-Google-Smtp-Source: AH8x226wt1eNlO8jjYuO7sziCN5aJmetk4XRL7jLjuBXXn33P76H3/d35LpEihEm0rpNxFG9bXk4/KNdK0dYnPU+Gi8=
X-Received: by 10.129.196.74 with SMTP id s10mr644822ywj.33.1519155817891;
 Tue, 20 Feb 2018 11:43:37 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Tue, 20 Feb 2018 11:43:37
 -0800 (PST)
In-Reply-To: <b85f9654-3552-30c0-79bb-84fe10309d8b@netease.com>
References: <b85f9654-3552-30c0-79bb-84fe10309d8b@netease.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 20 Feb 2018 11:43:37 -0800
Message-ID: <CAGZ79kYytJOFhzdpWnWNs574KeLQ2f1AtkdAQ1-o6P5=VO=r_Q@mail.gmail.com>
Subject: Re: About connection resuming
To:     chenzero <chenzero@netease.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 20, 2018 at 4:49 AM, chenzero <chenzero@netease.com> wrote:
> Hello,
> First, I am a user of git for about 2 years, I really appreciated you all to
> create this great useful software!

Hi, welcome to the mailing list!

> My encountered problem is:
> sometimes, the repo is big and because my networking is not stable(or my
> network proxy has
> some limitations), so, the clone will always fail.
> I tried following ways to solve this, however, not much success.
> 1. clone depth 1
> git clone --depth=1 https://..../repo.git
> however, some repo even depth=1 might fail.(It seemed that my network proxy
> limit tcp connection.
> if transfer over 50M, it will break)
> 2. download bundle file.
> but no all git repo provide bundle files to download.
>
> After some investment on the code, I think, perhaps,
> if enhance the git-http-backend to support http header: Range, or
> Content-Range,
> maybe it will enable connection resuming.

This thought has come up before, for example
https://public-inbox.org/git/1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com/
(Or you can search for "resumable clone" in that mailing list archive,
there are more interesting discussions)

But the current problem is that the bytes of a clone are not stable,
as the packs are ordered racily IIUC: So if you clone the same repository
(with the same branch values), the observed communication over the wire
may differ in the part when the pack file is transferred as the packfile is
packed up in a multi threaded fashion, that has no clear order defined.

> the problem of this way is: it needs to upgrade the current deployed
> "git-http-backend",
> and maybe much code need to change including git-remote-http etc.
>
> This is the very basic thought, and whether I should try other way ?
> Thanks a lot!

I think a more promising approach is to have support for references
inside the packfile for transfer, this could become one of the features
of the new protocol that is being worked on
https://public-inbox.org/git/20180207011312.189834-1-bmwill@google.com/
I do not find a reference for the idea, but Jonathan (cc'd) laid it out
well once upon a time. Jonathan do you have a mailing list reference
for references in packfiles?

Thanks,
Stefan

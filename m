Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF2FB1F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 14:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389195AbfJ2O3O (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 10:29:14 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38459 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbfJ2O3O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 10:29:14 -0400
Received: by mail-ua1-f67.google.com with SMTP id u99so3860235uau.5
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 07:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Y2j5A2hOX1WGySy0iU/E005QhDoDR/KHuF65InquAs=;
        b=OLrdrKYQ9XkmY/Tm5y0kzPgdXGOazYAWDptF5vF1BVb1Jbf9jfRUfPcKiONlKRfZz8
         lveOATQ7hVrBopzSj1LrYD9ZBvn8rphHvDTTAEWQfTG2hTVaodE8p5L7LZigxdi5zKMi
         HpIWhGSS6esvKqkrYRRCTD0vKAcg6e6bsOtF6dxih35Wl7I6i/Pnar+o/lYTvDwE13Hl
         7hj0xtOiQOxAP290MJh8ZPeNTYrtw4XVrenLlr7xwN0rJbbKABKLa1tXCPQCNpyzgzW9
         jPaTRdOSvAqh77S0w/p27glKsAQVRVQHcKVEUZ3wK1xST5/WEQps+H5Fvvj0RRgmZjO1
         YTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Y2j5A2hOX1WGySy0iU/E005QhDoDR/KHuF65InquAs=;
        b=hRtE1oMxf45GV1gpC3bw8b6s+oGb558RbwFMZLdvDNqZqHhhVJVmsjGOjer1JrIZQX
         8jYW2v16pFjKfFzgtn4w5hI++4wyf8ziuguyGFanLP6xVCzYwUiNFCfVJRfLuOyKa5o9
         gECdfb9u26iWO5bhImHqw1KZLWWV6QsqBEYaMjB60XyGUJZIbw8pG42QuVtbBaPZ9tkU
         rrYYtCHbCWPKPXbkTgpDTHwkoYdGaSh23vR9NFnYuAb5JjmCEhASkudneA/uusoTq2/l
         WVCPQOCJqBDU1HCz2EA/l2VVVl25qYnZOKwRUJ9xWkRl2hDqASt9PRnsaocVN7uXFssI
         e66A==
X-Gm-Message-State: APjAAAUJBEFVsEhlZRU7JVKvdUEepgKen2zZA0Su6X7qK+aRndGsMwUZ
        NTWIkrhExiyC28wbxloXjhIqDW4V9sX06Lwnx6A=
X-Google-Smtp-Source: APXvYqwDMHlZiASJkTaDMJqJUpfUugZFv7k5EFs3zhj26Odv+8fhWvx85L9p/rgzjWO6BukDyk5plX9T2EHGC96j4Pw=
X-Received: by 2002:ab0:2044:: with SMTP id g4mr11033268ual.136.1572359352031;
 Tue, 29 Oct 2019 07:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <pull.423.git.1572289087.gitgitgadget@gmail.com>
In-Reply-To: <pull.423.git.1572289087.gitgitgadget@gmail.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Tue, 29 Oct 2019 15:29:00 +0100
Message-ID: <CAKPyHN3WEpVLnxYN5FsovW3G_borc+YrF05Npr0Wyvv6YhbcaQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] Allow the 'revert' option in Git Gui to operate on
 untracked files, deleting them
To:     Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 28, 2019 at 7:58 PM Jonathan Gilbert via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> My development environment sometimes makes automatic changes that I don't
> want to keep. In some cases, this involves new files being added that I
> don't want to commit or keep. I have typically had to explicitly delete
> those files externally to Git Gui, and I want to be able to just select
> those newly-created untracked files and "revert" them into oblivion.
>

I have an entry in the 'Tools" menu for this called 'Delete':

[guitool "Delete"]
    cmd = rm -f \"$FILENAME\"
    noconsole = yes
    needsfile = yes
    confirm = yes

Best,
Bert

> This change updates the revert_helper function to check for untracked files
> as well as changes, and then any changes to be reverted and untracked files
> are handled by independent blocks of code. The user is prompted
> independently for untracked files, since the underlying action is
> fundamentally different (rm -f). If after deleting untracked files, the
> directory containing them becomes empty, then the directory is removed as
> well.
>
> This introduces new strings in index.tcl. I have been told that there is a
> separate process whereby the translations get updated.
>
> Jonathan Gilbert (1):
>   git-gui: Revert untracked files by deleting them
>
>  git-gui/lib/index.tcl | 139 +++++++++++++++++++++++++++++++-----------
>  1 file changed, 104 insertions(+), 35 deletions(-)
>
>

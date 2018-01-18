Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B789C1FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 16:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754964AbeARQcC (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 11:32:02 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:39194 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753527AbeARQcA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 11:32:00 -0500
Received: by mail-wm0-f42.google.com with SMTP id i11so23985946wmf.4
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 08:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iVwWH20MklzMR44EDheTwXkIhQ3HTAP6Ww2jjfv4WVs=;
        b=kyh+sbU00H5qdZ9pp/GxSrqPFJsxgs4PdSUOIENOfXQlvVKJM1AF7Ki3X5jbos20jE
         v8ZzilE9Y6fgRbd03/+ZUEuFTRkhyuP8YertC6HlJZKET89eAZMBw3wZ9hUEo2uwsAEN
         CsagJ+/8CPLK9/h9kSRhZ0d5v4DnhSlxF9aSkrgY/9r60aABYq4IaanNy8PBAAFStYFe
         t6xYtglYeHINfC2wLotl4db1WGtTi4pDt0TSX2aTj61KVWTxZHg/LzTXazt6ppTprfjk
         BepmLW6S1U7wFjdiwQYcjFFMZMGiZQgfDOzqeQh8wBnP9xSXhCvWTyt8evT7mhGzFCvP
         yAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iVwWH20MklzMR44EDheTwXkIhQ3HTAP6Ww2jjfv4WVs=;
        b=bUWPEHFbKI1PyyOFWuG5O1tGXhWMuFnE1QLCWNQs80MFSJoh8o5+F9zqmPAYERNB3b
         2WNupfHNCYMWBdd+crOK/2FbzjOSFWFZVZ7g1vpl0q5iRQTq3UDfcpN9mjwPtEI28HCa
         eZM83ycL0FX8FZiQpJTXlhEXp7jdyCBXCqSQF695wNT+OMy03OyRH0IaadJxsn+xH0/y
         dFYd6Z/TOgxYzIY6uF5FQgYbBEOyXtDdysojjzheOAfJzOH//TkbSue1DIgKbViEvdLo
         wtt2Hp7Rg3O2X+mPr9D7D8MpZTa2mpBTfNQ7K4YP/flS1L/8xo3mXEd5OLmwvPnF+6+8
         yRXw==
X-Gm-Message-State: AKwxytc001ODc76qmBCigu1FpiLICAQxuYtUiRbYD/WEM138SKPY8fVU
        0OpHoH4Lu8T96ud1in+rmWWUjxIi/VoCfj5H/lo=
X-Google-Smtp-Source: ACJfBothJ0dq/haPsnoIAAGyK8Op2KtibK4M6Z+3YQdnD2wWeavwZc/z421jFyNIwh4TN2q+PxJ9/fxV1b/1ROXNvgY=
X-Received: by 10.80.211.7 with SMTP id g7mr8902195edh.76.1516293119154; Thu,
 18 Jan 2018 08:31:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.212.44 with HTTP; Thu, 18 Jan 2018 08:31:38 -0800 (PST)
In-Reply-To: <647382ac70bfb7035345304a32d08f4e7b51cd40.1516225925.git.johannes.schindelin@gmx.de>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <647382ac70bfb7035345304a32d08f4e7b51cd40.1516225925.git.johannes.schindelin@gmx.de>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 18 Jan 2018 08:31:38 -0800
Message-ID: <CA+P7+xrLrU=s4EgPYs7HP4JRBj1fW2YJNUEpswJENBxHAvz5LQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] sequencer: introduce the `merge` command
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 18, 2018 at 7:35 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> This patch is part of the effort to reimplement `--preserve-merges` with
> a substantially improved design, a design that has been developed in the
> Git for Windows project to maintain the dozens of Windows-specific patch
> series on top of upstream Git.
>
> The previous patch implemented the `label`, `bud` and `reset` commands
> to label commits and to reset to a labeled commits. This patch adds the
> `merge` command, with the following syntax:
>
>         merge <commit> <rev> <oneline>
>
> The <commit> parameter in this instance is the *original* merge commit,
> whose author and message will be used for the to-be-created merge
> commit.
>
> The <rev> parameter refers to the (possibly rewritten) revision to
> merge. Let's see an example of a todo list:
>
>         label onto
>
>         # Branch abc
>         bud
>         pick deadbeef Hello, world!
>         label abc
>
>         bud
>         pick cafecafe And now for something completely different
>         merge baaabaaa abc Merge the branch 'abc' into master
>
> To support creating *new* merges, i.e. without copying the commit
> message from an existing commit, use the special value `-` as <commit>
> parameter (in which case the text after the <rev> parameter is used as
> commit message):
>
>         merge - abc This will be the actual commit message of the merge
>
> This comes in handy when splitting a branch into two or more branches.
>

Would it be possible to open the editor with the supplied text when
there's no commit? The text after <rev> must be oneline only..

It's difficult to reword merges because of the nature of rebase
interactive, you can't just re-run the rebase command and use
"reword".

I suppose you could cheat by putting in an "edit" command that let you
create an empty commit with a message...

Thanks,
Jake

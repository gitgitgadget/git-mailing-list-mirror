Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C61E61F424
	for <e@80x24.org>; Mon, 23 Apr 2018 17:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755308AbeDWR20 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 13:28:26 -0400
Received: from mail-vk0-f53.google.com ([209.85.213.53]:44292 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754900AbeDWR2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 13:28:25 -0400
Received: by mail-vk0-f53.google.com with SMTP id r184so9891534vke.11
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 10:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=85Eo8yf45nSF9NFkpNV6NONVTVP4h2k/suq/7QXTuss=;
        b=GdzMX6MAA5edSPdtN7DhSs79iWeWtIY8LAvVgxelOEOLAjBYXDeJBAqFSJFOohUCzn
         CtyFEGyQrTzcjvEq3wWZBb9MAy8dosQOUwAo4+t+AeRu3ToSG7S9iROYr3YptgxU/Kk1
         GZhha9J+2RvZ+7dTwh0vOZSlWUY6Ub7tZ5nQFbz8P4GfuDyGapSOhmwUzJOWDjWAdPb6
         c5NogvuyCK9xWe1GMBNhgnUW5VHUPm/fkuvFIwt1yXN/A75fVQElZKr2AnVgJ8ZKQQpr
         RSUbsg5gcNlvdgFJVzeGBvLPqSUV6huZ71mlS4QTvW9KnoYTQQMaWX9B4BAKYh6SpeE+
         AjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=85Eo8yf45nSF9NFkpNV6NONVTVP4h2k/suq/7QXTuss=;
        b=Z/W+z8YBsrCbcAjIzAr2zYOb/ACgc/c3S2DFKTYj/x1JdCvRgkiOWXJ2JbhrgnttxT
         yk9XpacK6S4/HjgU7z7VBL1xm9WSbwz7xRlrL2zcC5C96kbNUZ9FcAURzo2a/zn/zwwJ
         r5oC6OV5ycg3OYQurf5FAMfPhZm+MlW5Et6Ef95s4ajnCEX1IW1mIEM/9+iZDIdmxpA8
         VcF/hVZQRC0RIvFYCbtVcWh4U1vlUUsG4q4EaeR+kuT3Y03vzMHfzPZa/OBszhQtSkIX
         0dM9Zo6F5wVZLnio/nVZG4wQ4CvrFvNH05d3fK2s7eQQJpvviCIAiNlAE8W49JQ3WRpb
         ZITw==
X-Gm-Message-State: ALQs6tBN9d7malbqmnuk294EYLadLnyeHiXpKHef4ydtxQNJVuOMfUdE
        IjwUxOQgQZL8g3uPOqN6QyFgIhJJEpJruvO/f6z99Q==
X-Google-Smtp-Source: AIpwx49KmlA6osxOLUSpKCzPZgec1ont9D6T/BwzMcdqNglxYJ2DWVRsk51xziJ0m/nP7c1UZzzBXWaeqEm032IlCxk=
X-Received: by 10.31.165.10 with SMTP id o10mr15284408vke.187.1524504503918;
 Mon, 23 Apr 2018 10:28:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Mon, 23 Apr 2018 10:28:23 -0700 (PDT)
In-Reply-To: <20180419175823.7946-1-newren@gmail.com>
References: <20180419175823.7946-1-newren@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 23 Apr 2018 10:28:23 -0700
Message-ID: <CABPp-BHMt1Hjr8A_wkxvSExV9ALgG5032vV5uEE2-HtpYuA9QQ@mail.gmail.com>
Subject: Re: [PATCH v10 00/36] Add directory rename detection to git
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 19, 2018 at 10:57 AM, Elijah Newren <newren@gmail.com> wrote:
> Additional testing:
>
>   * I've re-merged all ~13k merge commits in git.git with both
>     git-2.17.0 and this version of git, comparing the results to each
>     other in detail.  (Including stdout & stderr, as well as the output
>     of subsequent commands like `git status`, `git ls-files -s`, `git
>     diff -M`, `git diff -M --staged`).  The only differences were in 23
>     merges of either git-gui or gitk which involved directory renames
>     (e.g. git-2.17.0's merge would result in files like 'lib/tools.tcl'
>     or 'po/ru.po' instead of the expected 'git-gui/lib/tools.tcl' or
>     'gitk-git/po/ru.po')
>
>   * I'm trying to do the same with linux.git, but it looks like that will
>     take nearly a week to complete...

Results after restarting[1] and throwing some big hardware at it to
get faster completion:

Out of 53288 merge commits with exactly two parents in linux.git:
  - 48491 merged identically
  - 4737 merged the same other than a few different "Auto-merging
    <filename>" output lines (as expected due to patch 35/36)
  - 53 merged the same other than different "Checking out files: ..."
    output (I just did a plain merge; no flags like --no-progress)
  - the remaining 7 commits had non-trivial merge differences, all
    attributable to directory rename detection kicking in

So, it looks good to me.  If anyone has suggestions for other testing
to do, let me know.

[1] Restarted so it could include my unpack_trees fix (from
Message-Id20180421193736.12722-1-newren@gmail.com) plus a couple minor
fixup commits (fixing some testcase nits and a comment typo).

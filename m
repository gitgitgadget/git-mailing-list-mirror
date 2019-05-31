Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D0D21F462
	for <e@80x24.org>; Fri, 31 May 2019 06:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfEaGD0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 02:03:26 -0400
Received: from mail-ua1-f44.google.com ([209.85.222.44]:35963 "EHLO
        mail-ua1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfEaGD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 02:03:26 -0400
Received: by mail-ua1-f44.google.com with SMTP id 94so3431943uam.3
        for <git@vger.kernel.org>; Thu, 30 May 2019 23:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eP9tiArOHoRrC0oJdro6qDuwyYDHkbOXlld7/68vioo=;
        b=VjAGyKgLqsa7slqrPWHM6myXcs0rTNiRqPJom7UR1hWAccjogcoKVUazAJ8wDCwuiF
         iBT02EaH15tEcIwcF+a8kaFQK9kvs4joLy1bjU7UUKhCeYVnhrwaGVjqaGteChcJ5Dgn
         67sT1tMxdiT7zC3GciHB9VTRaJpObFXQY18BNPLXX6Q6i1WY5rVOKCPG6kNmJ21iexdo
         Y/X4Y8tInQhDCPzEllFNR5LkUN8dOyb9v0YTd//ZYku+7lsp2++KhpdVYpFpv1y1J5vK
         XNpH/3iXu9ID6JqplrMdflsoGQAdMexxPpGgAtT9H69uuPgmC65qylROyoTi0AuGNp3a
         +Fgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eP9tiArOHoRrC0oJdro6qDuwyYDHkbOXlld7/68vioo=;
        b=SwcTzRaXI2/JK0M1JN1HQPDowAuKe93LFeY1eqDqOYXsTQgTxutDY6JsHX56mElJBW
         oSRJF3zy8yEmZz4hCnnJi113NHErYwJtp68kYxB43Et8C7t3S0vxbtMep8D692UZlWjl
         knwlp3SUd3eHTBduwQFin6zZlYKlPKpCQVdPxQ+e8e3AI1ZuiIAYp6419Zq5FT9iJq8o
         EryIo8g023wfjsCOgH12G9ybf+/YYzmkv9q77vKo9Bq/70C+jeF1uIeF/CjiLDb6crNi
         ERE3ZgvoHhzpBjHxWHIU89F0MzqCdojy8aWMSr4DBhfBoLwAzh+HFiUxAyQdyfw1N74G
         vfOw==
X-Gm-Message-State: APjAAAW+l24jon/7EIBaTHuKBse3dENFK3jxltn6Mnfm1vulvwF0aznV
        xchQGxNiT2NrmzVhSrU4F0uR9OwYCXwZQ+WnTN68oPLi/J8=
X-Google-Smtp-Source: APXvYqxtzKXFdjvDUHy0Iq9HsXVxGCgjc2T0tu2j4gVtkWdtxIQdtGtH/cb8EuZ2uMuFgcIw0Sei4Iq7lYcYkKV64qU=
X-Received: by 2002:ab0:4e12:: with SMTP id g18mr4307185uah.1.1559282604949;
 Thu, 30 May 2019 23:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAGyf7-EgiWtt0xu9nfYdhafZ6D70nSxbNYAguFrN8OWRqWmzGQ@mail.gmail.com>
In-Reply-To: <CAGyf7-EgiWtt0xu9nfYdhafZ6D70nSxbNYAguFrN8OWRqWmzGQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 30 May 2019 23:03:13 -0700
Message-ID: <CABPp-BHramOjqpH0Rz-PEKbi0TX_sKOYvLiZ2Pb=hEpViaShmw@mail.gmail.com>
Subject: Re: "Losing" MERGE_HEAD
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 30, 2019 at 9:19 PM Bryan Turner <bturner@atlassian.com> wrote:
>
> I was looking through the commit history in a repository I work in and
> I found a place where someone had created a merge, but somewhere
> between "git merge" and "git commit" the fact that it was a merge was
> "lost". Instead they ended up with a really big commit that applied
> all the changes from the merged-in branch.
>
> A really easy way to reproduce this is:
> git merge master #Assume this has conflicts, or use --no-commit
> git checkout -b some-new-branch
>
> When the checkout runs, MERGE_HEAD et al are deleted without any sort
> of warning, but the uncommitted changes are not lost. If a user then
> runs "git commit", and doesn't notice that there's no helpful "It
> looks like you may be committing a merge", they'll create a new,
> non-merge commit that essentially reapplies all the changes they
> merged in.
>
> I'm pretty familiar with Git and I make this mistake at least a few
> times a year. So far I've always caught it during the commit, though.
> Unfortunately, in this case, the bad "merge" wasn't noticed before it
> made its way to master, so now it's there for good.
>
> I'm not sure what there is to do about this. It's clear it's a
> long-standing behavior. One approach might be to introduce a warning
> when changing branches deletes MERGE_*. A different one might be to
> fail to change branches without something like --force. I'm not sure
> either is _better_ than the current behavior, but they're certainly
> _clearer_. That said, perhaps this behavior is something someone
> relies on.
>
> Best regards,
> Bryan Turner

Discussed in detail recently starting at
https://public-inbox.org/git/CACsJy8Axa5WsLSjiscjnxVK6jQHkfs-gH959=YtUvQkWriAk5w@mail.gmail.com/

resulting in
https://public-inbox.org/git/20190329103919.15642-8-pclouds@gmail.com/
and
https://public-inbox.org/git/20190329103919.15642-24-pclouds@gmail.com/

I think we should still do the follow up for checkout, as mentioned at
https://public-inbox.org/git/CABPp-BHX1gRhTdurAwrPg60Hk-OuhbrEN=4zatx4OOUo-DkQvw@mail.gmail.com/

It's good to get extra feedback that this isn't just theoretical but
is causing people actual problems.  Do you want to take the time to
make the change I suggested in the last email above and propose it to
the list?  I think the main thing needed is just a good commit message
and getting feedback and thoughts from others; your description above
was well written and I'm busy on other things right now, so if you'd
like to tackle it, I'd appreciate it.  If not, I will hopefully
remember to get back to it eventually.

Hope that helps,
Elijah

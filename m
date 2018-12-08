Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02CDF20A1E
	for <e@80x24.org>; Sat,  8 Dec 2018 02:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbeLHCX3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 21:23:29 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:42465 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeLHCX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 21:23:29 -0500
Received: by mail-vk1-f193.google.com with SMTP id y14so1388062vky.9
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 18:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B3KJCqFIAeouBmy+LaX+f4usRI8+SeiznLKnmE02T/g=;
        b=S+nk5/8T0KC0gPfc5jOCMPg8mX+rhncbdaKFTqMES49BqIIzo9KeDMykOxqt41p163
         RmeqUmhO3adhGoxcvnjvAWZgCthsnvcm8F+gOsy8CCkqbLM+anbVLRRYpBJXZO2Fgzch
         1oKf7bb9tEOWpr05CCQIJYkpuvKkBtcM9ZySvrPHsK8VOdfzb+P/p5sQ8acD10HCbarp
         pERrKG6CWyTqdMaE6SnRUekUH26Fh99fMp2QaQlxPPx8IZtBW1dO21B63W+OGw6dIfeh
         CMv11dXjFzu1VcWMPWO0kav1ZDCHzRz3lqX0P+2E4gB0dYgjm9WyDJe1hKUwNmwAEcZj
         6GAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B3KJCqFIAeouBmy+LaX+f4usRI8+SeiznLKnmE02T/g=;
        b=WO+6bwgqiVPvkVFW0C7YOMfOs9VdNcZb4hzhBWpjOUKoVe+nl6x7JwBiOd7tiuEAX6
         4JyEiOhNUBxQwns8gHR83uvzwxASFxctGxJFCCcIhDd4bKigrUpCvW94cA2b4Bl1qn2J
         haQ9p7BO+8K7jqGUnmLiFKQexEtrTtbwAMvXydToLzHsfceu/HInNKEe2xYkpTlqEYh3
         qm+spYtSilEcdNmHRq5ULX+cBxueVksoNapuvOS9Up4ZQqXAoei6nb5fTcoNbD2utNun
         H3uUvkGtRfCtTPRDpabjAtWQbZeBZY9ARVzVurizQFvzoHEq8oIRe7RqxKv23PLyV8HH
         OKpw==
X-Gm-Message-State: AA+aEWZMlOwA9+heYoWDdjiSobxIcqf1p7o2Q9+jYFS+LZCfcKrQY+vM
        LHidG5kxetVRQfqMdvl5xQrGtR56IhkQ2abgB/EAZ4Xv
X-Google-Smtp-Source: AFSGD/XLqPFGOTSnqv91HYPy5OUfbLINYqd7iN7EOjxQ0rbvyxwbGloRNOqwsz52Jkbqk3jIZU7nDUrPa3JFoLsaOhU=
X-Received: by 2002:a1f:2d89:: with SMTP id t131mr1882212vkt.27.1544235807846;
 Fri, 07 Dec 2018 18:23:27 -0800 (PST)
MIME-Version: 1.0
References: <CAKQQkGppdO5pwOpG+sJ0uc2uPW867TZzWzc0ZntPd6MkqsozFQ@mail.gmail.com>
In-Reply-To: <CAKQQkGppdO5pwOpG+sJ0uc2uPW867TZzWzc0ZntPd6MkqsozFQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 7 Dec 2018 18:23:16 -0800
Message-ID: <CABPp-BE_fvO-pcAT6hYNK2+M0Bt63XhyvZFF3wrrcNp4MsjtYg@mail.gmail.com>
Subject: Re: bug: git fetch reports too many unreachable loose objects
To:     josh@okcupid.com
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 7, 2018 at 6:14 PM Josh Wolfe <josh@okcupid.com> wrote:
>
> git version 2.19.1
> steps to reproduce:
>
> # start in a brand new repo
> git init
>
> # create lots of unreachable loose objects
> for i in {1..10000}; do git commit-tree -m "$(head -c 12 /dev/urandom
> | base64)" "$(git mktree <&-)" <&-; done
> # this prints a lot of output and takes a minute or so to run
>
> # trigger git gc to run in the background
> git fetch
> # Auto packing the repository in background for optimum performance.
> # See "git help gc" for manual housekeeping.
>
> # trigger it again
> git fetch
> # Auto packing the repository in background for optimum performance.
> # See "git help gc" for manual housekeeping.
> # error: The last gc run reported the following. Please correct the root cause
> # and remove .git/gc.log.
> # Automatic cleanup will not be performed until the file is removed.
> #
> # warning: There are too many unreachable loose objects; run 'git
> prune' to remove them.
>
> # to manually fix this, run git prune:
> git prune
>
> # note that `git gc` does not fix the problem, and appears to do
> nothing in this situation:
> git gc
>
>
> According to the `git fetch` output, the `git help gc` docs, and the
> `git help prune` docs, I don't think I shouldn't ever have to run `git
> prune` manually, so this behavior seems like a bug to me. Please
> correct me if this is expected behavior.

Known bug, there are a variety of other ways to trigger it too.  See
the threads here for more info:
  https://public-inbox.org/git/87inc89j38.fsf@evledraar.gmail.com/
  https://public-inbox.org/git/20180716172717.237373-1-jonathantanmy@google.com/
There are probably other threads as well.

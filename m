Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F6FE1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 18:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753088AbeA3SrH (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 13:47:07 -0500
Received: from mail-yw0-f181.google.com ([209.85.161.181]:38685 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeA3SrG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 13:47:06 -0500
Received: by mail-yw0-f181.google.com with SMTP id m84so5527976ywd.5
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 10:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=l3hsx8yh0htGyzBumRZb4t/uebngUX0rCxLpkrKTouY=;
        b=mmKRX0FrXGgxL2X+9QscEOfyUT10vBdLCw3X8z4/y+OTC3hXZzzW2lqPgWnCP0IgbQ
         rfGh0lLUwCK0kVndKS+p2EahDTMXkeHh0oIsnBW4iAKhYU6haL+6D6DIMuhcNoFTdjHn
         R6sPXq3xvlWKfb9hYSj+gp8N4AnHCSIjjnzqfjwd9Qmohkwk59Ab0kF8xY8HFGmv9JLg
         lQwFtPQh5ZIaIVyT4s1uS0+8n66y0SxFNlo+KoyhX2r4L7oTH5wGnk5FfEjHRz1O8UIF
         v9KN49a4w+Qvt8ZGJGrX4lBZI0bNveuLcTCuvgipVaS75hHUybHZv1fZPhQ9UceERjP9
         mTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=l3hsx8yh0htGyzBumRZb4t/uebngUX0rCxLpkrKTouY=;
        b=jr7xiXu8RvG9z2bnyefZvsxIRdZ7ZahQyBxnUNKmyJxfyAhrJCNrUeWEDDYNBRQABE
         HOEmmNmeC1JPEcx3E7RpSuoHoMou4OswAC1D+/9oK8KTkalFIYhBCKuhbEABLYPwFhGA
         Ljh0hfi/KbtF8lagf+qY7c1RK36k7qV7nXowS478ekBCj8EuXJkbNjG72cDls0cQKlBK
         2KKKmbIAB5VMFnpK7+Fv1lNElamzPN3Q/3R7IoIjIC+JNry+KKB9wKMjGMy7/IfaIf7G
         qGiyb4n9ghIV52TMTw14WGGAS/jhNaozfVPGjwb2C3dLsfSmuMFVEcyiJXG4wXBxV7vr
         TxvA==
X-Gm-Message-State: AKwxytewkywwIAm7ovGNn2oGfRKloushp+s9fgbX5yXuvSpd6aLpXtuM
        dELvncetfl1eEsKHf6Y8wBX0/XqFVfUP0mvnS69YpA==
X-Google-Smtp-Source: AH8x2248iD+pJLlqkA/t/bPXCigoMw/JtYlatR1Hob7s4eroe6pynfcvDh8U1jGhmVGj8MsqGm30KUGC7WOAkpJZ18Y=
X-Received: by 10.129.108.196 with SMTP id h187mr20576956ywc.249.1517338025016;
 Tue, 30 Jan 2018 10:47:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Tue, 30 Jan 2018 10:47:04 -0800 (PST)
In-Reply-To: <cover.1517266437.git.johannes.schindelin@gmx.de>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <cover.1517266437.git.johannes.schindelin@gmx.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 30 Jan 2018 10:47:04 -0800
Message-ID: <CAGZ79kYVa1HFG=tP6gJjH_epC_kwNSwjWmQ2gQ+JWzSksY6fSA@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] rebase -i: offer to recreate merge commits
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 29, 2018 at 2:54 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Once upon a time, I dreamt of an interactive rebase that would not
> flatten branch structure, but instead recreate the commit topology
> faithfully.
>
> My original attempt was --preserve-merges, but that design was so
> limited that I did not even enable it in interactive mode.
>
> Subsequently, it *was* enabled in interactive mode, with the predictable
> consequences: as the --preserve-merges design does not allow for
> specifying the parents of merge commits explicitly, all the new commits'
> parents are defined *implicitly* by the previous commit history, and
> hence it is *not possible to even reorder commits*.
>
> This design flaw cannot be fixed. Not without a complete re-design, at
> least. This patch series offers such a re-design.
>
> Think of --recreate-merges as "--preserve-merges done right". It
> introduces new verbs for the todo list, `label`, `reset` and `merge`.
> For a commit topology like this:
>
>             A - B - C
>               \   /
>                 D
>
> the generated todo list would look like this:
>
>             # branch D
>             pick 0123 A
>             label branch-point
>             pick 1234 D
>             label D
>
>             reset branch-point
>             pick 2345 B
>             merge 3456 D C
>
> There are more patches in the pipeline, based on this patch series, but
> left for later in the interest of reviewable patch series: one mini
> series to use the sequencer even for `git rebase -i --root`, and another
> one to add support for octopus merges to --recreate-merges.
>
> Changes since v1:
>
> - reintroduced "sequencer: make refs generated by the `label` command
>   worktree-local" (which was squashed into "sequencer: handle autosquash
>   and post-rewrite for merge commands" by accident)
>
> - got rid of the universally-hated `bud` command

Sorry if you got the impression for that. Maybe I was imprecise.
I had no strong opinion one way or another, I merely pointed out the
collision in abbreviation letters with the potential new 'break', IIRC.

'bud' was a special case for resetting to a specific revision
(and labeling it?)

Maybe we can have default labels, such that there is no need to reset
to the first revision manually, but can just use these defaults in the merge.
(I haven't thought about this in the big picture, just food for thought)


>
> - as per Stefan's suggestion, the help blurb at the end of the todo list
>   now lists the syntax
>
> - the no-rebase-cousins mode was made the default; This not only reflects
>   the experience won from those years of using the Git garden shears, but
>   was also deemed the better default in the discussion on the PR at
>   https://github.com/git/git/pull/447
>
> - I tried to clarify the role of the `onto` label in the commit message of
>   `rebase-helper --make-script: introduce a flag to recreate merges`
>
> - fixed punctuation at the end of error(...) messages, and incorrect
>   upper-case at the start
>
> - changed the generated todo lists to separate the label and the oneline in
>   the `reset` command with a `#`, for readability
>
> - dropped redundant paragraph in the commit message that talked about
>   support for octopus merges
>
> - avoided empty error message when HEAD could not be read during do_label()
>
> - merge commits are fast-forwarded only unless --force-rebase was passed
>
> - do_merge() now errors out a lot earlier when HEAD could not be parsed
>
> - the one-letter variables to hold either abbreviated or full todo list
>   instructions in make_script_recreating_merges() were renamed to clearer
>   names
>
> - The description of rebase's --recreate-merge option has been reworded;
>   Hopefully it is a lot more clear now.
>
>
> Johannes Schindelin (9):
>   sequencer: introduce new commands to reset the revision
>   sequencer: introduce the `merge` command
>   sequencer: fast-forward merge commits, if possible
>   rebase-helper --make-script: introduce a flag to recreate merges
>   rebase: introduce the --recreate-merges option
>   sequencer: make refs generated by the `label` command worktree-local
>   sequencer: handle autosquash and post-rewrite for merge commands
>   pull: accept --rebase=recreate to recreate the branch topology
>   rebase -i: introduce --recreate-merges=[no-]rebase-cousins
>
> Stefan Beller (1):
>   git-rebase--interactive: clarify arguments

No need to honor me with authorship, as I just wrote
that patch in a quick hurry to express the idea.
But this is fine, too.

The interdiff looks good to me, I'll review the patches now.

Thanks,
Stefan

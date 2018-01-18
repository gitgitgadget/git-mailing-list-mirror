Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 550EF1FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 21:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753649AbeARVUc (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 16:20:32 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:32789 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752100AbeARVU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 16:20:27 -0500
Received: by mail-wm0-f54.google.com with SMTP id x4so4503569wmc.0
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 13:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NSvQd/rll4pJwCKpVIBTv5pXHafJfSs4IsjGgxZWhXQ=;
        b=eJSzxgONyQ/70WqPYBzlSL31ISRoat43cmj2UU9v/J9QmyZNXQsisZ11SsuWJeHE+N
         q2FgaRiFVgzPnnMIxeXmbYxkEMB4mhqkDJS/lWvDy8qys4OS5b183xjyJN8rlP8OM3La
         KlcEHmPSlbY90akciJK4EYMaIbuV8T9h8qaz3P/8Cbv1KsQ/docRhCEXOGGMlpKodwrA
         O277dL2jcSeZ/zlwl1ytapOMmQsoIZvVi6aRGwGbdTEb96kyJKJB0KckAsJEpS7MEluB
         T5Z6hm9CsMW5C+kLP8M7CTk6NTBz0i5qKDJBikZUUwxF2UDHr9pkbMCsZZfapZQVhH6O
         1DPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NSvQd/rll4pJwCKpVIBTv5pXHafJfSs4IsjGgxZWhXQ=;
        b=j1P9yht3uqJZNfUGVe8zcZUJTtGed++DTbLaP70Gh/hPKqCVdI+9kmEzljKDmDs/j+
         Oia7DBfw1EZiyCLk9IvF6R59J/SHjJPKfv+N+FhJjShfkHKPE39/N3Em5nvuXGdcaDr7
         o/48e/WR2N8NbVBpoifX9g6RTq/pAR+llCAp7X3EKSekmfeHGZUA/JsjhWx4ypsJ3vaD
         uT8YEvJNTqnb7bS0S7VhwaJCluDG5Na7rYIp/gSqC8DXTw3wihkK9eoToX5VAdjcm/R/
         jqbjN4ebnT0AMOvMpfrn7IaXx173UoIN6qNS/8foYD6d0lPolRPexSuNY92oztEhz3jK
         R8/w==
X-Gm-Message-State: AKwxyteM3PbmZVE/ibTlDMCcLRBWvkEFgasQJESNtZ/oeUE1oVDSHn1+
        8cWoTxBVL2VDY0Psq/s40chlmu4BCSvMvb5+Qcs5Iw==
X-Google-Smtp-Source: ACJfBouueXCiRmU/LvHvbP+Jk3w5Av9P2stKW7xgHnS/Uc/XyqWcSHoMB8duHd1HV8l9TXrO+MbPSlKBdmU1HSUMDsw=
X-Received: by 10.80.164.233 with SMTP id x38mr9741789edb.293.1516310424781;
 Thu, 18 Jan 2018 13:20:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.212.44 with HTTP; Thu, 18 Jan 2018 13:20:04 -0800 (PST)
In-Reply-To: <20180118183618.39853-3-sbeller@google.com>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
 <20180118183618.39853-1-sbeller@google.com> <20180118183618.39853-3-sbeller@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 18 Jan 2018 13:20:04 -0800
Message-ID: <CA+P7+xpwYDeNHfzMtHJkKEB8-A+kZ95wBEn0RC5R8pWbgKOmiQ@mail.gmail.com>
Subject: Re: [PATCH 10/8] [DO NOT APPLY, but improve?] rebase--interactive:
 introduce "stop" command
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 18, 2018 at 10:36 AM, Stefan Beller <sbeller@google.com> wrote:
> Jake suggested using "x false" instead of "edit" for some corner cases.
>
> I do prefer using "x false" for all kinds of things such as stopping
> before a commit (edit only let's you stop after a commit), and the
> knowledge that "x false" does the least amount of actions behind my back.
>
> We should have that command as well, maybe?
>


I agree. I use "x false" very often, and I think stop is probably a
better solution since it avoids spawning an extra shell that will just
fail. Not sure if stop implies too much about "stop the whole thing"
as opposed to "stop here and let me do something manual", but I think
it's clear enough.

Thanks,
Jake

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  git-rebase--interactive.sh |  1 +
>  sequencer.c                | 10 ++++++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 3cd7446d0b..9eac53f0c5 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -166,6 +166,7 @@ l, label <label>= label current HEAD with a name
>  t, reset <label> = reset HEAD to a label
>  b, bud = reset HEAD to the revision labeled 'onto', no arguments
>  m, merge [<label-or-commit>]* = create a merge commit using a given commit's message
> +y, stay = stop for  shortcut for
>
>  These lines can be re-ordered; they are executed from top to bottom.
>  " | git stripspace --comment-lines >>"$todo"
> diff --git a/sequencer.c b/sequencer.c
> index 2b4e6b1232..4b3b9fe59d 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -782,6 +782,7 @@ enum todo_command {
>         TODO_RESET,
>         TODO_BUD,
>         TODO_MERGE,
> +       TODO_STOP,
>         /* commands that do nothing but are counted for reporting progress */
>         TODO_NOOP,
>         TODO_DROP,
> @@ -803,6 +804,7 @@ static struct {
>         { 'l', "label" },
>         { 't', "reset" },
>         { 'b', "bud" },
> +       { 'y', "stay" },
>         { 'm', "merge" },
>         { 0,   "noop" },
>         { 'd', "drop" },
> @@ -1307,6 +1309,12 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
>                 return 0;
>         }
>
> +       if (item->command == TODO_STOP) {
> +               item->commit = NULL;
> +               item->arg = "";
> +               item->arg_len = 0;
> +       }
> +
>         end_of_object_name = (char *) bol + strcspn(bol, " \t\n");
>         item->arg = end_of_object_name + strspn(end_of_object_name, " \t");
>         item->arg_len = (int)(eol - item->arg);
> @@ -2407,6 +2415,8 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
>                                 /* `current` will be incremented below */
>                                 todo_list->current = -1;
>                         }
> +               } else if (item->command == TODO_STOP) {
> +                       todo_list->current = -1;
>                 } else if (item->command == TODO_LABEL)
>                         res = do_label(item->arg, item->arg_len);
>                 else if (item->command == TODO_RESET)
> --
> 2.16.0.rc1.238.g530d649a79-goog
>

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C1B01F576
	for <e@80x24.org>; Fri, 19 Jan 2018 10:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755337AbeASKzp (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 05:55:45 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:39866 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751200AbeASKzl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 05:55:41 -0500
Received: by mail-qt0-f193.google.com with SMTP id f4so2778843qtj.6
        for <git@vger.kernel.org>; Fri, 19 Jan 2018 02:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=8sF8k0b94CjCpviufoo1cEpz1rdVlrowOPHd9dfR/UA=;
        b=CAfG7F2BIMd6QoTHJuw0reGM/KResGJYsh9mOl1/18W2FHj1BvfIU6aZIMw3xtR0bH
         U0Dj71lKBK4DvG0RlgYamPlwJtOqREKMntejGKjShlXinG/yIYjf0TslgqGnb4Y00RmW
         8p+O1NzcIkbU7d72GqORVKgVnd/7EPoVz147Y+ssAqRwS2EY8xrVU+LT7K9G3LGATTRM
         WJ2TezYtr29nXfSNDL11mJCaYmyfGIArK8WB8uJh4KSouVdpoZmBF0U9SiJxGVPvKFYh
         jdqFYtH0xZqJnFx/1sEVaMAlnF7kVdc0tfpOVVDCTO/cPHNN0bw82anhj0GtAaOPhaJa
         uxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=8sF8k0b94CjCpviufoo1cEpz1rdVlrowOPHd9dfR/UA=;
        b=ke1RnfiI8buM9dNlwH5g4KcGZcKygdnFleLnxIwkFneG+2zdbFyI22XUug7SNQFG9j
         wP9wjikkIwTAs4ZdxH2MoNWlzRMopf7wNMDysLHs4iuM7aqzsx1yyVmcAOTTGj6CaotS
         RukGLTlgp5lDwEwy+bA4eaS6KlCf/BHCOS6P2jrIEJvgp00L5ji6coADSdQbvsxTzQKv
         oleY6HBLaio5xnE0K50FwlYxNsq40EOLzh87U0MYrM4uW0U4skGgiWpyNfPAHIxeognf
         UnE1gpgxrsN8q+Y19BSy1nHLfELJ+zbGvF+v7Bv48Z4dkOOuFRnxlIoh7ErYQA7IuNz6
         ydhg==
X-Gm-Message-State: AKwxytfh+qOB8RRA1OXfx+coEtO5ylT1juoAZt/6NTp3JD1m0x9gpnOL
        7cgaCVmuEdB2mXglJHxJEeOHx9FSTjsyaKK5nwM=
X-Google-Smtp-Source: ACJfBou21teRfC98YlRMrFq3mUXRrM+TIZmsa/Xa72/imhtwjOkDZykLMQnsR4QoGJ+GN4iGcE4vRgs4vNqVXS9ZTmQ=
X-Received: by 10.55.177.135 with SMTP id a129mr28262900qkf.112.1516359340313;
 Fri, 19 Jan 2018 02:55:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Fri, 19 Jan 2018 02:55:39 -0800 (PST)
In-Reply-To: <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 19 Jan 2018 05:55:39 -0500
X-Google-Sender-Auth: Ser_ukbAbiDLULTxLR-lCL2XJ1k
Message-ID: <CAPig+cQZTd77oqod8EZbXqroaaYb7oYbXUOW+jWFfRMrOMonPw@mail.gmail.com>
Subject: Re: [PATCH 5/8] rebase: introduce the --recreate-merges option
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 18, 2018 at 10:35 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> [...]
> With this patch, the goodness of the Git garden shears comes to `git
> rebase -i` itself. Passing the `--recreate-merges` option will generate
> a todo list that can be understood readily, and where it is obvious
> how to reorder commits. New branches can be introduced by inserting
> `label` commands and calling `merge - <label> <oneline>`. And once this
> mode has become stable and universally accepted, we can deprecate the
> design mistake that was `--preserve-merges`.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> @@ -900,6 +900,7 @@ fi
>  if test t != "$preserve_merges"
>  then
>         git rebase--helper --make-script ${keep_empty:+--keep-empty} \
> +               ${recreate_merges:+--recreate-merges} \

If the user specifies both --preserve-merges and --recreate-merges, it
looks like --preserve-merges will take precedence.

Should git-rebase.sh have a mutual-exclusion check and error out if
both are specified?

>                 $revisions ${restrict_revision+^$restrict_revision} >"$todo" ||
>         die "$(gettext "Could not generate todo list")"
> diff --git a/git-rebase.sh b/git-rebase.sh
> @@ -262,6 +264,10 @@ do
> +       --recreate-merges)
> +               recreate_merges=t
> +               test -z "$interactive_rebase" && interactive_rebase=implied
> +               ;;
>         --preserve-merges)
>                 preserve_merges=t
>                 test -z "$interactive_rebase" && interactive_rebase=implied

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2851F1F404
	for <e@80x24.org>; Sun, 25 Mar 2018 01:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753129AbeCYBfB (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 21:35:01 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:36010 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752621AbeCYBfA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 21:35:00 -0400
Received: by mail-qk0-f175.google.com with SMTP id o205so5154579qke.3
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 18:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=lzFjOK3mrxBvcVzuc0C1gYye6gRvMibsQw4poKWzV9U=;
        b=biqUkQ0CbOwPWNhIPlU8WaOiLF9phgBnrR0Y7PXxJfqN7zrsBPQElcMt08EuHGqNcJ
         /+Z71yMmzn5rcT2Nbmn8b3b+l5g30tnl7wuttU5q7ScwNU8Fsy32bg+nHd5ZAeEn5XfH
         wb+x865CBrgVnfrnv3hlKeWGNNf3V0MOshzeapE0hDechnmI/Tkryb6q5eDJoearN3Z6
         eiB0PrwW1GQjHtBYCzeG8CZk2wtcmbmcGkp58NM2Wp9qj7pGqdOOVw6K2J9oTiX7ngtM
         EJxZxTOlXzNkZ2i/+Jml8ZIW2nQbwhOjEuxc8bfre0MVwv6LFmQqHH5ohar4Swtcpan/
         SU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=lzFjOK3mrxBvcVzuc0C1gYye6gRvMibsQw4poKWzV9U=;
        b=INKIdljj9X85hto1BT0hlGrdb7/cwYy63nus5kJAb1uJIINZc27Pq6lXLE6pfcEvSw
         r6S5JM5DqXRUq1K+Omi4GvYb63ksGrvQGSgMSdl0UXa781Rp2SuIlH4h4xL7Or/ck9ZF
         l7BHxwas7QMEsRtCPHMFqp7VdsweFEOKUlGiU0b1GcHWt//5lgQwtW+cgimXwCXFp/DR
         hq8/oNN9X9nBPWNA8mNUDy7JYXTFfiJrynSnBdTb4Jcw7Z/Gh26ZhHl19F4liNFZsjxc
         METKdByxUhC1Z4T5LWOcZhGrvEvDj0ZYqWxG+Sgo1cq/4osRSoO8hGFSNlgbU+oItbKv
         zeKA==
X-Gm-Message-State: AElRT7FRCLpGnwbHMKs95O2JUpmIQ6198Ub15aR7KF1dUJ7eilLgZWtT
        2wPUdOk98Coa+TBpJ9E58hIwJwfEXEyQHRIeaUA=
X-Google-Smtp-Source: AG47ELtw7cfzNw9yU91pD/pdpFelISty/xdGvHxqi///s+uAeJjNkraCrCtm2msTtyL+V+lXNEb6ih2wx2oNyY3KZc8=
X-Received: by 10.55.156.79 with SMTP id f76mr47496008qke.36.1521941699722;
 Sat, 24 Mar 2018 18:34:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sat, 24 Mar 2018 18:34:59 -0700 (PDT)
In-Reply-To: <20180324183844.4565-1-kaartic.sivaraam@gmail.com>
References: <20180324183844.4565-1-kaartic.sivaraam@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 24 Mar 2018 21:34:59 -0400
X-Google-Sender-Auth: NqIrhybB-dTYXaOTjhwOCRZ1iAQ
Message-ID: <CAPig+cQ8xw23SGhpx5qtDEyzJGR1v4L2Lm9tEWe56Rh3c8Q3cg@mail.gmail.com>
Subject: Re: [PATCH] branch -l: print useful info whilst rebasing a non-local branch
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 24, 2018 at 2:38 PM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> When rebasing interacitvely (rebase -i), "git branch -l" prints a line

The "git branch -l" threw me since "-l" is short for --create-reflog.
I'm guessing you meant "git branch --list".

> indicating the current branch being rebased. This works well when the
> interactive rebase was intiated when a local branch is checked out.
>
> This doesn't play well when the rebase was initiated on a remote
> branch or an arbitrary commit that is not pointed to by a local
> branch.

A shorter way of saying "arbitrary commit ... not pointed at by local
branch" would be "detached HEAD".

> In this case "git branch -l" tries to print the name of a
> branch using an unintialized variable and thus tries to print a "null
> pointer string". As a consequence, it does not provide useful
> information while also inducing undefined behaviour.
>
> So, print the commit from which the rebase started when interactive
> rebasing a non-local branch.

Makes sense. The commit message gives enough information for the
reader to understand the problem easily.

> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> @@ -1310,8 +1310,16 @@ char *get_head_description(void)
>         wt_status_get_state(&state, 1);
>         if (state.rebase_in_progress ||
>             state.rebase_interactive_in_progress)
> +       {

Style: attach '{' to the line above it (don't make it standalone)

> +               const char *rebasing = NULL;
> +               if (state.branch != NULL)
> +                       rebasing = state.branch;
> +               else
> +                       rebasing = state.detached_from;
> +
>                 strbuf_addf(&desc, _("(no branch, rebasing %s)"),
> -                           state.branch);
> +                           rebasing);

You could collapse the whole thing back down to:

    strbuf_addf(&desc, _("(no branch, rebasing %s)"),
        state.branch ? state.branch : state.detached_from);

which means you don't need the 'rebasing' variable or the braces.

> +       }
>         else if (state.bisect_in_progress)

Style: cuddle 'else' with '}': } else

>                 strbuf_addf(&desc, _("(no branch, bisect started on %s)"),
>                             state.branch);

Can we have a couple new tests: one checking "git branch --list" for
the typical case (when rebasing off a named branch) and one checking
when rebasing from a detached HEAD?

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 473431F404
	for <e@80x24.org>; Wed, 18 Apr 2018 18:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeDRSiT (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 14:38:19 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36773 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751972AbeDRSiS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 14:38:18 -0400
Received: by mail-pl0-f68.google.com with SMTP id m7-v6so1632793plt.3
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 11:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hDn6rLehuH/cAGlI6XfGk5PuHSqb0RLcPI27rZ1FSps=;
        b=mVzdYHWKOul9iX3VquO0fR2C16dnq2OnmGfSf6u1L29iIMCIwpGdlD/rhdoVkFDXaB
         4dszMWAhV0/fkk+szyV+bwTjc+MmeUNETlyjxlyV5bblRhL7LN20/9OSEwz4Lw6JcE8r
         GzWaAq5grOEqUsxSE/fsenbdevBnI4ZSXUhu8rU4owhd5zAaECB3yxeJV+XmhpsbAx1S
         Xvgs8OGshzH9sCu0uhKt5K3tma5uMERSRkiRlABPO/nMavHHx74qcvL3Yr8XJ3f67qEn
         mLzecq2GvbNN7Scw3vnVp7XFLH3Xz4EsJl5bLNGST+mQjR/ktI7TSSKmlGO5ol+jJcme
         NHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hDn6rLehuH/cAGlI6XfGk5PuHSqb0RLcPI27rZ1FSps=;
        b=bSvbfQw20y+/yHpt8NcoXL5j/3QQ9AlM19JVlApLu+DodTufwmtCrZFkk697x+n2lm
         tgLN495piW1xwV8ynZXLysL89nyyQS/1/Vme2h4vdgNnTn1UtcyuatyTFkqa4fqppaxB
         UKgv360l+hSwl3KOS33E/7FJAAekolFHNnTSOnNBXBex1mJLtdjdTSEfW8wZh3LEK4B8
         ogaik03AJ4VQL96tfbYDByZq+0obF53UaY21GTcahDP/kguwiXYzaZbxGgFlwVS9yLN3
         b5Is9zhn3OVuhgpzWCBg0gYns/3tRE6CkOQ8p68u/dfrwZEtXoDxyoS+DlnqQ43g/G8/
         dpjA==
X-Gm-Message-State: ALQs6tCQjqCah7OFfDpH2izg0gd/sFaF6KCNN9OZb0pKjqnaMaejxWqd
        EZaZv1Q0kzZvgIy9ZdaJeGMWIq0qhegWKSqbkaU=
X-Google-Smtp-Source: AIpwx49yjicm3GCx0arPrI2rHEGPTi9ZnsMdakEcZu+WKevAZvKNZrwR4lw+qUXC79ALHrEAW6EEMHyDQnTXDBvtBWI=
X-Received: by 2002:a17:902:1c7:: with SMTP id b65-v6mr876230plb.298.1524076698259;
 Wed, 18 Apr 2018 11:38:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.150.4 with HTTP; Wed, 18 Apr 2018 11:38:17 -0700 (PDT)
In-Reply-To: <20180418030655.19378-2-sxlijin@gmail.com>
References: <20180418030655.19378-1-sxlijin@gmail.com> <20180418030655.19378-2-sxlijin@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 18 Apr 2018 20:38:17 +0200
Message-ID: <CAN0heSqXwVR5cdMwipUdPrnbUyCU8v2GzWK=2-0_ZWoWw3SO2w@mail.gmail.com>
Subject: Re: [PATCH 1/2] commit: fix --short and --porcelain
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Samuel,

Welcome back. :-)

On 18 April 2018 at 05:06, Samuel Lijin <sxlijin@gmail.com> wrote:
> Make invoking `git commit` with `--short` or `--porcelain` return status
> code zero when there is something to commit.
>
> Mark the commitable flag in the wt_status object in the call to
> `wt_status_collect()`, instead of in `wt_longstatus_print_updated()`,
> and simplify the logic in the latter function to take advantage of the
> logic shifted to the former.

The subject is sort of vague about what is being fixed. Maybe "commit:
fix return code of ...", or "wt-status: set `commitable` when
collecting, not when printing". Or something... I can't come up with
something brilliant off the top of my head.

I did not understand the first paragraph until I had read the second and
peaked at the code. Maybe tell the story the other way around? Something
like this:

  Mark the `commitable` flag in the wt_status object in
  `wt_status_collect()`, instead of in `wt_longstatus_print_updated()`,
  and simplify the logic in the latter function to take advantage of the
  logic shifted to the former.

  This means that callers do need to actually use the printer function
  to collect the `commitable` flag -- it is sufficient to call
  `wt_status_collect()`.

  As a result, invoking `git commit` with `--short` or `--porcelain`
  results in return status code zero when there is something to commit.
  This fixes two bugs documented in our test suite.

>  t/t7501-commit.sh |  4 ++--
>  wt-status.c       | 39 +++++++++++++++++++++++++++------------
>  2 files changed, 29 insertions(+), 14 deletions(-)

I tried to find somewhere in the documentation where this bug was
described (git-commit.txt or git-status.txt), but failed. So there
should be nothing to update there.

> +static void wt_status_mark_commitable(struct wt_status *s) {
> +       int i;
> +
> +       for (i = 0; i < s->change.nr; i++) {
> +               struct wt_status_change_data *d = (s->change.items[i]).util;
> +
> +               if (d->index_status && d->index_status != DIFF_STATUS_UNMERGED) {
> +                       s->commitable = 1;
> +                       return;
> +               }
> +       }
> +}

This helper does exactly what the old code did inside
`wt_longstatus_print_updated()` with regards to `commitable`. Ok.

This function does not reset `commitable` to 0, so reusing a `struct
wt_status` won't necessarily work out. I have not thought about whether
such a caller would be horribly broken for other reasons...

>  void wt_status_collect(struct wt_status *s)
>  {
>         wt_status_collect_changes_worktree(s);
> @@ -726,7 +739,10 @@ void wt_status_collect(struct wt_status *s)
>                 wt_status_collect_changes_initial(s);
>         else
>                 wt_status_collect_changes_index(s);
> +
>         wt_status_collect_untracked(s);
> +
> +       wt_status_mark_commitable(s);
>  }

So whenever we `..._collect()`, `commitable` is set for us. This is the
only caller of the new helper, so in order to be able to trust
`commitable`, one needs to call `wt_status_collect()`. Seems a
reasonable assumption to make that the caller will remember to do so
before printing. (And all current users do, so we're not regressing in
some user.)

>  static void wt_longstatus_print_unmerged(struct wt_status *s)
> @@ -754,26 +770,25 @@ static void wt_longstatus_print_unmerged(struct wt_status *s)
>
>  static void wt_longstatus_print_updated(struct wt_status *s)
>  {
> -       int shown_header = 0;
> -       int i;
> +       if (!s->commitable) {
> +               return;
> +       }

Regarding my comment above: If you forget to `..._collect()` first, this
function is a no-op.

> +
> +       wt_longstatus_print_cached_header(s);
>
> +       int i;

You should leave this variable declaration at the top of the function.

>         for (i = 0; i < s->change.nr; i++) {
>                 struct wt_status_change_data *d;
>                 struct string_list_item *it;
>                 it = &(s->change.items[i]);
>                 d = it->util;
> -               if (!d->index_status ||
> -                   d->index_status == DIFF_STATUS_UNMERGED)
> -                       continue;
> -               if (!shown_header) {
> -                       wt_longstatus_print_cached_header(s);
> -                       s->commitable = 1;
> -                       shown_header = 1;
> +               if (d->index_status &&
> +                   d->index_status != DIFF_STATUS_UNMERGED) {
> +                       wt_longstatus_print_change_data(s, WT_STATUS_UPDATED, it);
>                 }
> -               wt_longstatus_print_change_data(s, WT_STATUS_UPDATED, it);
>         }
> -       if (shown_header)
> -               wt_longstatus_print_trailer(s);
> +
> +       wt_longstatus_print_trailer(s);
>  }

This rewrite matches the original logic, assuming we can trust
`commitable`. The result is a function called `print()` which does not
modify the struct it is given for printing. Nice. So you can make the
argument a `const struct wt_status *`. Except this function uses helpers
that are missing the `const`.

You fix that in patch 2/2. I would probably have made that patch as 1/2,
then done this patch as 2/2 ending the commit message with something
like "As a result, we can mark the argument as `const`.", or even just
silently inserting the `const` for this one function. Just a thought.

Martin

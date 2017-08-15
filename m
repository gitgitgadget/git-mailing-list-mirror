Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4069420899
	for <e@80x24.org>; Tue, 15 Aug 2017 02:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753235AbdHOC3V (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 22:29:21 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:33840 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753194AbdHOC3U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 22:29:20 -0400
Received: by mail-yw0-f170.google.com with SMTP id s143so65333760ywg.1
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 19:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=z/cUyAIFGvNa0n2gts9/ZYcHs0nWxLQEa+ZKL3gM6JY=;
        b=C+mqa0VjS7rE6kDxjXti5cd8Expw7SavnmPZ2E1oFGYQsZOIOxvqS+EeKtK0IEmljq
         YlA4lDjcO04ecQNtuyFidb2Bd7oyjxYjamO59G/V4CaUT6I13AjB4K9znt2Wyq6m4zMW
         +47YcwLV+KTszWrxMMkcsPrXCjFc5Rh9fVm0X2HAb4xp24yKTYCacEdZ+GNNhJOMRUA/
         NzfMGuFgXukfJRJUOV6IOUp6HRJ0sWZLR1XFAshKZb95hR+SazD3mwgG4Uncl5bV5Npx
         dLQT88vT1NWvvNl1ayLMs+tGXhOci4OQGwvSFyjNNRg8ed6Lxty2V73b9QcGZG+wUdV5
         9qDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=z/cUyAIFGvNa0n2gts9/ZYcHs0nWxLQEa+ZKL3gM6JY=;
        b=KqLNZMZgjTVSAa23bSr86fNYJGOH2l30bZ1wJf9PbDqyPwRgwr3yIpoZMr7GUNE2Ja
         2CRVivjCByoamZPYwlQJmRdu6uowqyBirNZGkox95MZJDH9oEp+i2/u10jYJ7Z3M2oHs
         zwoi+TPKtNBN2rOF5xB3ZAtW3isAYU8cTWp+kRCEcTl/vwhfiussN2Wy6vNytuFeefUN
         J2y0jG0Sq0AqLje64ZqT+7KJ1BcjoeIYHG07ZeBG4YdDHcuKV3yNNDXjYRSFfms2I+xU
         MbtPMlZZNlw0f3JLo9JGA8a5AdaROQQZAGX0Wo2jvGXX4qkwxXc4E/M4p5OSk6hCeGNl
         Zy0Q==
X-Gm-Message-State: AHYfb5g7w23rZqk7cn879zZ3KWCLqsa2lLXbxqoTZzh7iEUOMAp2jmN1
        vqnEGHsJQklxce/HF1sHYHxe0UCu5wlg
X-Received: by 10.129.120.4 with SMTP id t4mr21694743ywc.422.1502764159871;
 Mon, 14 Aug 2017 19:29:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Mon, 14 Aug 2017 19:29:19 -0700 (PDT)
In-Reply-To: <41a7ff674072559415f98b81ffde798d94aed2fc.1502754962.git.jonathantanmy@google.com>
References: <cover.1502491372.git.jonathantanmy@google.com>
 <cover.1502754962.git.jonathantanmy@google.com> <41a7ff674072559415f98b81ffde798d94aed2fc.1502754962.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 14 Aug 2017 19:29:19 -0700
Message-ID: <CAGZ79kbtscZ_OrXH1iDmiRNhNQkU-636351kaKxVYOYEBtBoeQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] diff: define block by number of non-space chars
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 14, 2017 at 4:57 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> The existing behavior of diff --color-moved=zebra does not define the
> minimum size of a block at all, instead relying on a heuristic applied
> later to filter out sets of adjacent moved lines that are shorter than 3
> lines long. This can be confusing, because a block could thus be colored
> as moved at the source but not at the destination (or vice versa),
> depending on its neighbors.
>
> Instead, teach diff that the minimum size of a block is 10
> non-whitespace characters. This allows diff to still exclude
> uninteresting lines appearing on their own (such as those solely
> consisting of one or a few closing braces), as was the intention of the
> adjacent-moved-line heuristic.

After some thought, I really like this heuristic, however allow me
a moment to bikeshed 10 as a number here.

One could think that 10 equals roughly 3 lines a 3 characters and
in C based languages the shortest meaningful lines have more than
3 characters ("i++;", "a();", "int i;" have 4 or 5 each), but I would still
think that 10 is too much, as we'd want to detect the closing braces
in their own lines.

>  dimmed_zebra::
>         Similar to 'zebra', but additional dimming of uninteresting parts
>         of moved code is performed. The bordering lines of two adjacent
> diff --git a/diff.c b/diff.c
> index f598d8a3a..305ce4126 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -864,19 +864,28 @@ static int shrink_potential_moved_blocks(struct moved_entry **pmb,
>  /*
>   * If o->color_moved is COLOR_MOVED_PLAIN, this function does nothing.
>   *
> - * Otherwise, if the last block has fewer lines than
> - * COLOR_MOVED_MIN_BLOCK_LENGTH, unset DIFF_SYMBOL_MOVED_LINE on all lines in
> - * that block.
> + * Otherwise, if the last block has fewer non-space characters than
> + * COLOR_MOVED_MIN_NON_SPACE_COUNT, unset DIFF_SYMBOL_MOVED_LINE on all lines
> + * in that block.
>   *
>   * The last block consists of the (n - block_length)'th line up to but not
>   * including the nth line.
>   */
>  static void adjust_last_block(struct diff_options *o, int n, int block_length)
>  {
> -       int i;
> -       if (block_length >= COLOR_MOVED_MIN_BLOCK_LENGTH ||
> -           o->color_moved == COLOR_MOVED_PLAIN)
> +       int i, non_space_count = 0;
> +       if (o->color_moved == COLOR_MOVED_PLAIN)
>                 return;
> +       for (i = 1; i < block_length + 1; i++) {
> +               const char *c = o->emitted_symbols->buf[n - i].line;
> +               for (; *c; c++) {
> +                       if (isspace(*c))
> +                               continue;
> +                       non_space_count++;
> +                       if (non_space_count >= COLOR_MOVED_MIN_NON_SPACE_COUNT)
> +                               return;

When we do this counting, we could count the lines ourselves here as well.
`n-block_count` should be equal to the line that has a different
(flags & (DIFF_SYMBOL_MOVED_LINE | DIFF_SYMBOL_MOVED_LINE_ALT))
pattern than those before. (although we'd also have to check for i > 0, too)
Your choice.

> +               }
> +       }
>         for (i = 1; i < block_length + 1; i++)
>                 o->emitted_symbols->buf[n - i].flags &= ~DIFF_SYMBOL_MOVED_LINE;
>  }
> @@ -923,7 +932,6 @@ static void mark_color_as_moved(struct diff_options *o,
>                 }
>
>                 l->flags |= DIFF_SYMBOL_MOVED_LINE;
> -               block_length++;
>
>                 if (o->color_moved == COLOR_MOVED_PLAIN)
>                         continue;
> @@ -953,8 +961,13 @@ static void mark_color_as_moved(struct diff_options *o,
>                         }
>
>                         flipped_block = (flipped_block + 1) % 2;
> +
> +                       adjust_last_block(o, n, block_length);
> +                       block_length = 0;
>                 }
>
> +               block_length++;
> +
>                 if (flipped_block)
>                         l->flags |= DIFF_SYMBOL_MOVED_LINE_ALT;
>         }
> diff --git a/diff.h b/diff.h
> index 5755f465d..9e2fece5b 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -195,7 +195,7 @@ struct diff_options {
>                 COLOR_MOVED_ZEBRA_DIM = 3,
>         } color_moved;
>         #define COLOR_MOVED_DEFAULT COLOR_MOVED_ZEBRA
> -       #define COLOR_MOVED_MIN_BLOCK_LENGTH 3
> +       #define COLOR_MOVED_MIN_NON_SPACE_COUNT 10
>  };
>
>  void diff_emit_submodule_del(struct diff_options *o, const char *line);
> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
> index 6f7758e5c..d8e7b77b9 100755
> --- a/t/t4015-diff-whitespace.sh
> +++ b/t/t4015-diff-whitespace.sh
> @@ -1101,9 +1101,9 @@ test_expect_success 'detect malicious moved code, inside file' '
>         <BRED>-{<RESET>
>         <BLUE>-if (!u->is_allowed_foo)<RESET>
>         <BLUE>-return;<RESET>
> -       <BRED>-foo(u);<RESET>
> -       <BLUE>-}<RESET>
> -       <BLUE>-<RESET>
> +       <RED>-foo(u);<RESET>
> +       <RED>-}<RESET>
> +       <RED>-<RESET>

Here we have 2 blocks, the first has 7 character,
which we may want to detect, the second has only 1 char.

The longest "uninteresting" line in C like languages might
be "\t } else {" which has 6 non-ws characters.

Thinking of other languages (shell "fi" is uninteresting, others are
interesting,
Latex \"custom" all bets are off), I think we may want to go lower and have
COLOR_MOVED_MIN_NON_SPACE_COUNT to be about 6
(~ 2 characters on a 3 line block).

That said this is all bikeshedding, feel free to ignore.

Acked-by: Stefan Beller <sbeller@google.com>

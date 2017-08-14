Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B62920899
	for <e@80x24.org>; Mon, 14 Aug 2017 17:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbdHNRR2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 13:17:28 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:35236 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751617AbdHNRR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 13:17:28 -0400
Received: by mail-yw0-f182.google.com with SMTP id l82so58508227ywc.2
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 10:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+4SoLru5ATgRtGpnT9oVApHaaA/2qgDtyAvQMo6N1fo=;
        b=h7E32byHcroSnVuz64AGLWp0xmuiu9mXqQxB2X8xQVPsf0RlJhVaNi2fZvypAs8hct
         LkIa+FwkRp8yR5RMlxuodcNPbES2/62M0gqasYfPrtrFjhYEAvaHIm7hhKtFKXQfzw/J
         L8lAODSc7WXh516O+Xous3gkuMxEMAk0eQk2D0B7bHVZmtbdRCDo3XhNAtM75k257Mrk
         uFeYbEw5NQA4XK0nGNQzxNMzTJISfXfE/BwzukSawpXjPfBsTHNmyMRqCtpXpCFUSbGC
         5JUaizgMXuzSGvpf/8kYDogwzvlaelpP2IgN8KniIajcxaDArHBqRcsFkgmGowHChwsk
         oLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+4SoLru5ATgRtGpnT9oVApHaaA/2qgDtyAvQMo6N1fo=;
        b=nBi80QC/3FdcnZUhVf2vVU+MzMCrD/RcxJSNyCScB4jOjvy2gFWyQYYY+PURFIsLqC
         Azrq771KgbjZSprfqCU7461KTnCF6XKhaR9ctPPojwTXqX7Lcwhos4zC08LBAxFIPQ7T
         UwRXU43sgu59IBbuOMwbz7Bam3/dgNswM17vh/FSDzMSDr8LhCTFTeUmlMexVb6mfSpg
         iQD4HRLrRe3l43cEstdeWtXIvot3k359IHRXmiVExk813RZlGm2QwpbIrQpeRyODMRsj
         nQTGlQEAwP9t4/0p3rWEs9FevZdHmZP6EdGtQdqD86PhT0K/17Zm1lSXZTIpJ/ltZwRV
         Do3Q==
X-Gm-Message-State: AHYfb5iTd33VIjfaNWfoj6VIiHHWugAm2fytSel6hJc/qSuuuL9PcG9L
        5FKtO2R2ITlpxY6CnADl+eNt+K+T3TA1
X-Received: by 10.37.115.78 with SMTP id o75mr15211868ybc.244.1502731046613;
 Mon, 14 Aug 2017 10:17:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.75.3 with HTTP; Mon, 14 Aug 2017 10:17:25 -0700 (PDT)
In-Reply-To: <ca94745f8d72a1d472462e9cb25ef3d2e1285f86.1502491372.git.jonathantanmy@google.com>
References: <cover.1502491372.git.jonathantanmy@google.com> <ca94745f8d72a1d472462e9cb25ef3d2e1285f86.1502491372.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 14 Aug 2017 10:17:25 -0700
Message-ID: <CAGZ79kbDjV8j_Hhpr9iKau89TipE6+_VNEOwxxeicwuEqwQ8Aw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] diff: respect MIN_BLOCK_LENGTH for last block
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 11, 2017 at 3:49 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> Currently, MIN_BLOCK_LENGTH is only checked when diff encounters a line
> that does not belong to the current block. In particular, this means
> that MIN_BLOCK_LENGTH is not checked after all lines are encountered.
>
> Perform that check.

Thanks for spotting! This fix looks straightforward correct.
(Also thanks for factoring out the adjustment, I am tempted to
start a bike shedding discussion about its name, though. :P)

> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  diff.c                     | 29 ++++++++++++++++++++++-------
>  t/t4015-diff-whitespace.sh | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+), 7 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 4965ffbc4..95620b130 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -858,6 +858,26 @@ static int shrink_potential_moved_blocks(struct moved_entry **pmb,
>         return rp + 1;
>  }
>
> +/*
> + * If o->color_moved is COLOR_MOVED_PLAIN, this function does nothing.
> + *
> + * Otherwise, if the last block has fewer lines than
> + * COLOR_MOVED_MIN_BLOCK_LENGTH, unset DIFF_SYMBOL_MOVED_LINE on all lines in
> + * that block.
> + *
> + * The last block consists of the (n - block_length)'th line up to but not
> + * including the nth line.
> + */
> +static void adjust_last_block(struct diff_options *o, int n, int block_length)
> +{
> +       int i;
> +       if (block_length >= COLOR_MOVED_MIN_BLOCK_LENGTH ||
> +           o->color_moved == COLOR_MOVED_PLAIN)
> +               return;
> +       for (i = 1; i < block_length + 1; i++)
> +               o->emitted_symbols->buf[n - i].flags &= ~DIFF_SYMBOL_MOVED_LINE;
> +}
> +
>  /* Find blocks of moved code, delegate actual coloring decision to helper */
>  static void mark_color_as_moved(struct diff_options *o,
>                                 struct hashmap *add_lines,
> @@ -893,13 +913,7 @@ static void mark_color_as_moved(struct diff_options *o,
>                 }
>
>                 if (!match) {
> -                       if (block_length < COLOR_MOVED_MIN_BLOCK_LENGTH &&
> -                           o->color_moved != COLOR_MOVED_PLAIN) {
> -                               for (i = 1; i < block_length + 1; i++) {
> -                                       l = &o->emitted_symbols->buf[n - i];
> -                                       l->flags &= ~DIFF_SYMBOL_MOVED_LINE;
> -                               }
> -                       }
> +                       adjust_last_block(o, n, block_length);
>                         pmb_nr = 0;
>                         block_length = 0;
>                         continue;
> @@ -941,6 +955,7 @@ static void mark_color_as_moved(struct diff_options *o,
>                 if (flipped_block)
>                         l->flags |= DIFF_SYMBOL_MOVED_LINE_ALT;
>         }
> +       adjust_last_block(o, n, block_length);
>
>         free(pmb);
>  }
> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
> index c3b697411..6f7758e5c 100755
> --- a/t/t4015-diff-whitespace.sh
> +++ b/t/t4015-diff-whitespace.sh
> @@ -1382,6 +1382,41 @@ EOF
>         test_cmp expected actual
>  '
>
> +test_expect_success '--color-moved block at end of diff output respects MIN_BLOCK_LENGTH' '
> +       git reset --hard &&
> +       >bar &&
> +       cat <<-\EOF >foo &&
> +       irrelevant_line
> +       line1
> +       EOF
> +       git add foo bar &&
> +       git commit -m x &&
> +
> +       cat <<-\EOF >bar &&
> +       line1
> +       EOF
> +       cat <<-\EOF >foo &&
> +       irrelevant_line
> +       EOF
> +
> +       git diff HEAD --color-moved=zebra --no-renames | grep -v "index" | test_decode_color >actual &&
> +       cat >expected <<-\EOF &&
> +       <BOLD>diff --git a/bar b/bar<RESET>
> +       <BOLD>--- a/bar<RESET>
> +       <BOLD>+++ b/bar<RESET>
> +       <CYAN>@@ -0,0 +1 @@<RESET>
> +       <GREEN>+<RESET><GREEN>line1<RESET>
> +       <BOLD>diff --git a/foo b/foo<RESET>
> +       <BOLD>--- a/foo<RESET>
> +       <BOLD>+++ b/foo<RESET>
> +       <CYAN>@@ -1,2 +1 @@<RESET>
> +        irrelevant_line<RESET>
> +       <RED>-line1<RESET>
> +       EOF
> +
> +       test_cmp expected actual
> +'
> +
>  test_expect_success 'move detection with submodules' '
>         test_create_repo bananas &&
>         echo ripe >bananas/recipe &&
> --
> 2.14.0.434.g98096fd7a8-goog
>

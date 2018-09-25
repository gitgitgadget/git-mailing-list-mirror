Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 868321F453
	for <e@80x24.org>; Tue, 25 Sep 2018 01:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeIYHML (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 03:12:11 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:43810 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbeIYHML (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 03:12:11 -0400
Received: by mail-yb1-f195.google.com with SMTP id w80-v6so9084162ybe.10
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 18:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W1QE5IvA+dvrHzgJHjX32zqqECqGUGQItIBlKDXPO0w=;
        b=Z45fVaGEzwCbt6hMY9NLFky1o9G8suOAB10s6MZxbBmIYdMwwn86ZHX8IpmKWlf1ca
         EUM3q42EcjtFYmnGnV3Y2ljWg3YKqFbFjd30FmRqF93JTvP3M1YeLbkhy9pqTJxz4URJ
         U2khpxBJs+4LgPBnQy77NF6zEMq/gx29PAcEOrH/UOzASmGi0vJuIZOvv14v+YvIH9hW
         1XXEorVXTqOl0FYWoZKk1irq/OXuAbJhY/UtRfYT1fBGq/T5h2dnpAOAQqmkVK5uoy/9
         s6mVRQi18mGqUJNKE64is+Lj+QeUoMxTCvPf+/LfrPCF5X1wBoicZ2N53K+pDvjPSsed
         u4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W1QE5IvA+dvrHzgJHjX32zqqECqGUGQItIBlKDXPO0w=;
        b=WFjUAJaTsesHiY9JE8P745ZHbaGsaqHHrIawmMU30tUmaTCtDbfm6wOmfQxmA8Vh9S
         XuRFh//JSYECg0OvUBrNEFBYsnlx8wGYPi4EMIOu0UXF0gSyS76w6dbVECo/MiVZRKdr
         MNNsVE6FBbrUikn0gM5yy/WrcV5uDPiPPVdBdB5G/MVSeoz/MTsU+QvKsYemSVcQVY5Q
         sQQWoRsZpT7ikLNjKc4uWK6buu2XWx8t+boZSiNIqkmy/g3zTWAXnRKCstuPVdjzEGfI
         oMF6QCgfkyTv4jzyfIFRe//IbFC5yxPysroy9ro9IvOqQIlg3I5x6e2C9dVWq5vukpNp
         lDLg==
X-Gm-Message-State: ABuFfoiQJ/EnslB1xOnR87B6ukRSRewf4o5zcKh/1Mt4LvIki4qbDGC6
        N4uvupGpnEtZjcgxZxYgne7bEy6eL9MI9JU8sQjMNg==
X-Google-Smtp-Source: ACcGV63gUHR0Axjaz395yQXjJNXurCKNgFy7Y09zWuTQpoyMZQbmD5GpMsiMgjf+PiaUHGUmdv7IufQcmYgvIHfwi8k=
X-Received: by 2002:a25:8892:: with SMTP id d18-v6mr643385ybl.521.1537837635746;
 Mon, 24 Sep 2018 18:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180924100604.32208-1-phillip.wood@talktalk.net> <20180924100604.32208-4-phillip.wood@talktalk.net>
In-Reply-To: <20180924100604.32208-4-phillip.wood@talktalk.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 24 Sep 2018 18:07:04 -0700
Message-ID: <CAGZ79kZjAaLE7G=q9sBeEL_+Q2ufYBTn6p9TDCF8cYFd3k+0oQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] diff: add --color-moved-ws=allow-mixed-indentation-change
To:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 24, 2018 at 3:06 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> This adds another mode for highlighting lines that have moved with an
> indentation change. Unlike the existing
> --color-moved-ws=allow-indentation-change setting this mode uses the
> visible change in the indentation to group lines, rather than the
> indentation string.

Wow! Thanks for putting this RFC out.
My original vision was to be useful to python users as well,
which counts 1 tab as 8 spaces IIUC.

The "visual" indentation you mention here sounds like
a tab is counted as "up to the next position of (n-1) % 8",
i.e. stop at positions 8, 16, 24... which would not be pythonic,
but useful in e.g. our code base.

> This means it works with files that use a mix of
> tabs and spaces for indentation and can cope with whitespace errors
> where there is a space before a tab

Cool!

> (it's the job of
> --ws-error-highlight to deal with those errors, it should affect the
> move detection).

Not sure I understand this side note. So --ws-error-highlight can
highlight them, but the move detection should *not*(?) be affected
by the highlighted parts, or it should do things differently on
whether  --ws-error-highlight is given?

> It will also group the lines either
> side of a blank line if their indentation change matches so short
> lines followed by a blank line followed by more lines with the same
> indentation change will be correctly highlighted.

That sounds very useful (at least for my editor, that strips
blank lines to be empty lines), but I would think this feature is
worth its own commit/patch.

I wonder how much this feature is orthogonal to the existing
problem of detecting the moved indented blocks (existing
allow-indentation-change vs the new feature discussed first
above)

>
> This is a RFC as there are a number of questions about how to proceed
> from here:
>  1) Do we need a second option or should this implementation replace
>     --color-moved-ws=allow-indentation-change. I'm unclear if that mode
>     has any advantages for some people. There seems to have been an
>     intention [1] to get it working with mixes of tabs and spaces but
>     nothing ever came of it.

Oh, yeah, I was working on that, but dropped the ball.

I am not sure what the best end goal is, or if there are many different
modes that are useful to different target audiences.
My own itch at the time was (de-/)in-dented code from refactoring
patches for git.git and JGit (so Java, C, shell); and I think not hurting
python would also be good.

ignoring the mixture of ws seems like it would also cater free text or
other more exotic languages.

What is your use case, what kind of content do you process that
this patch would help you?

I am not overly attached to the current implementation of
 --color-moved-ws=allow-indentation-change,
and I think Junio has expressed the fear of "too many options"
already in this problem space, so if possible I would extend/replace
the current option.

>  2) If we keep two options what should this option be called, the name
>     is long and ambiguous at the moment - mixed could refer to mixed
>     indentation length rather than a mix of tabs and spaces.

Let's first read the code to have an opinion, or re-state the question
from above ("What is this used for?") as I could imagine one of the
modes could be "ws-pythonic" and allow for whitespace indentation
that would have the whole block count as an indented by the same
amount, (e.g. if you wrap a couple functions in python by a class).

> +++ b/diff.c
> @@ -304,7 +304,11 @@ static int parse_color_moved_ws(const char *arg)
>                 else if (!strcmp(sb.buf, "ignore-all-space"))
>                         ret |= XDF_IGNORE_WHITESPACE;
>                 else if (!strcmp(sb.buf, "allow-indentation-change"))
> -                       ret |= COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE;
> +                       ret = COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE |
> +                        (ret & ~COLOR_MOVED_WS_ALLOW_MIXED_INDENTATION_CHANGE);

So this RFC lets "allow-indentation-change" override
"allow-mixed-indentation-change" and vice versa. That
also solves the issue of configuring one and giving the other
as a command line option. Nice.

>         if ((ret & COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE) &&
>             (ret & XDF_WHITESPACE_FLAGS))
>                 die(_("color-moved-ws: allow-indentation-change cannot be combined with other white space modes"));
> +       else if ((ret & COLOR_MOVED_WS_ALLOW_MIXED_INDENTATION_CHANGE) &&
> +                (ret & XDF_WHITESPACE_FLAGS))
> +               die(_("color-moved-ws: allow-mixed-indentation-change cannot be combined with other white space modes"));

Do we want to open a bit mask for all indentation change options? e.g.
#define COLOR_MOVED_WS_INDENTATION_MASK \
    (COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE | \
     COLOR_MOVED_WS_ALLOW_MIXED_INDENTATION_CHANGE)

> @@ -763,11 +770,65 @@ struct moved_entry {
>   * comparision is longer than the second.
>   */
>  struct ws_delta {
> -       char *string;
> +       union {
> +               int delta;
> +               char *string;
> +       };
>         unsigned int current_longer : 1;
> +       unsigned int have_string : 1;
>  };
>  #define WS_DELTA_INIT { NULL, 0 }
>
> +static int compute_mixed_ws_delta(const struct emitted_diff_symbol *a,
> +                                 const struct emitted_diff_symbol *b,
> +                                 int *delta)
> +{
> +       unsigned int i = 0, j = 0;
> +       int la, lb;
> +       int ta = a->flags & WS_TAB_WIDTH_MASK;
> +       int tb = b->flags & WS_TAB_WIDTH_MASK;
> +       const char *sa = a->line;
> +       const char *sb = b->line;
> +
> +       if (xdiff_is_blankline(sa, a->len, 0) &&
> +           xdiff_is_blankline(sb, b->len, 0)) {
> +               *delta = INT_MIN;
> +               return 1;
> +       }
> +
> +       /* skip any \v \f \r at start of indentation */
> +       while (sa[i] == '\f' || sa[i] == '\v' ||
> +              (sa[i] == '\r' && i < a->len - 1))

I do not understand the use of parens here.
I would have expected all comparisons in one
block which is then &&'d to the length requirement.
But this seems to tread \r special if not at EOL.

> +               i++;
> +       while (sb[j] == '\f' || sb[j] == '\v' ||
> +              (sb[j] == '\r' && j < b->len - 1))
> +               j++;
> +
> +       for (la = 0; ; i++) {
> +               if (sa[i] == ' ')
> +                       la++;
> +               else if (sa[i] == '\t')
> +                       la = ((la + ta) / ta) * ta;

multiplication/division may be expensive,
would something like

  la = la - (la % ta) + ta;

work instead? (the modulo is a hidden division,
but at least we do not have another multiplication)

Further I'd find it slightly easier to understand as it
"fills up to the next multiple of <ta>" whereas the
divide and re-multiply trick relies on integer logic, but
that might be just me.  Maybe just add a comment.

> +               else
> +                       break;
> +       }
> +       for (lb = 0; ; j++) {
> +               if (sb[j] == ' ')
> +                       lb++;
> +               else if (sb[j] == '\t')
> +                       lb = ((lb + tb) / tb) * tb;
> +               else
> +                       break;
> +       }
> +       if (a->s == DIFF_SYMBOL_PLUS)
> +               *delta = la - lb;
> +       else
> +               *delta = lb - la;

When writing the original feature I had reasons
not to rely on the symbol, as you could have
moved things from + to - (or the other way round)
and added or removed indentation. That is what the
`current_longer` is used for. But given that you only
count here, we can have negative numbers, so it
would work either way for adding or removing indentation.

But then, why do we need to have a different sign
depending on the sign of the line?

> +
> +       return (a->len - i == b->len - j) &&
> +               !memcmp(sa + i, sb + j, a->len - i);
> +}
> +
>  static int compute_ws_delta(const struct emitted_diff_symbol *a,
>                              const struct emitted_diff_symbol *b,
>                              struct ws_delta *out)
> @@ -778,6 +839,7 @@ static int compute_ws_delta(const struct emitted_diff_symbol *a,
>
>         out->string = xmemdupz(longer->line, d);
>         out->current_longer = (a == longer);
> +       out->have_string = 1;
>
>         return !strncmp(longer->line + d, shorter->line, shorter->len);
>  }
> @@ -820,15 +882,34 @@ static int cmp_in_block_with_wsd(const struct diff_options *o,
>          * To do so we need to compare 'l' to 'cur', adjusting the
>          * one of them for the white spaces, depending which was longer.
>          */

The comment above would only apply to the original mode?

> +       if (o->color_moved_ws_handling &
> +           COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE) {
> +               wslen = strlen(pmb->wsd->string);
> +               if (pmb->wsd->current_longer)
> +                       c += wslen;
> +               else
> +                       a += wslen;
>
> -       wslen = strlen(pmb->wsd->string);
> -       if (pmb->wsd->current_longer)
> -               c += wslen;
> -       else
> -               a += wslen;
> +               if (strcmp(a, c))
> +                       return 1;

This could be "return strcmp" instead of falling
through to the last line in the function in case of 0. But this
is just indenting code that is already there.

>
> -       if (strcmp(a, c))
> -               return 1;
> +               return 0;
> +       } else if (o->color_moved_ws_handling &
> +                  COLOR_MOVED_WS_ALLOW_MIXED_INDENTATION_CHANGE) {
> +               int delta;
> +
> +               if (!compute_mixed_ws_delta(cur->es, l, &delta))
> +                   return 1;
> +
> +               if (pmb->wsd->delta == INT_MIN) {
> +                       pmb->wsd->delta = delta;
> +                       return 0;
> +               }
> +
> +               return !(delta == pmb->wsd->delta || delta == INT_MIN);

Most of the code here deals with jumping over empty lines, and the new
mode is just comparing the two numbers.


> +       } else {
> +               BUG("no color_moved_ws_allow_indentation_change set");

Instead of the BUG here could we have a switch/case (or if/else)
covering the complete space of delta->have_string instead?
Then we would not leave a lingering bug in the code base.

> +       }
>
>         return 0;
>  }
> @@ -845,7 +926,8 @@ static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
>                          & XDF_WHITESPACE_FLAGS;
>
>         if (diffopt->color_moved_ws_handling &
> -           COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
> +           (COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE |
> +            COLOR_MOVED_WS_ALLOW_MIXED_INDENTATION_CHANGE))
>                 /*
>                  * As there is not specific white space config given,
>                  * we'd need to check for a new block, so ignore all
> @@ -953,7 +1035,8 @@ static void pmb_advance_or_null_multi_match(struct diff_options *o,
>                         pmb[i] = pmb[i]->next_line;
>                 } else {
>                         if (pmb[i]->wsd) {
> -                               free(pmb[i]->wsd->string);
> +                               if (pmb[i]->wsd->have_string)
> +                                       free(pmb[i]->wsd->string);
>                                 FREE_AND_NULL(pmb[i]->wsd);
>                         }
>                         pmb[i] = NULL;
> @@ -1066,7 +1149,8 @@ static void mark_color_as_moved(struct diff_options *o,
>                         continue;
>
>                 if (o->color_moved_ws_handling &
> -                   COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
> +                   (COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE |
> +                    COLOR_MOVED_WS_ALLOW_MIXED_INDENTATION_CHANGE))
>                         pmb_advance_or_null_multi_match(o, match, hm, pmb, pmb_nr, n);
>                 else
>                         pmb_advance_or_null(o, match, hm, pmb, pmb_nr);
> @@ -1088,6 +1172,17 @@ static void mark_color_as_moved(struct diff_options *o,
>                                                 pmb[pmb_nr++] = match;
>                                         } else
>                                                 free(wsd);
> +                               } else if (o->color_moved_ws_handling &
> +                                          COLOR_MOVED_WS_ALLOW_MIXED_INDENTATION_CHANGE) {
> +                                       int delta;
> +
> +                                       if (compute_mixed_ws_delta(l, match->es, &delta)) {
> +                                               struct ws_delta *wsd = xmalloc(sizeof(*match->wsd));
> +                                               wsd->delta = delta;
> +                                               wsd->have_string = 0;
> +                                               match->wsd = wsd;
> +                                               pmb[pmb_nr++] = match;

I would want to keep mark_color_as_moved and friends smaller, and instead
move the complexity to compute_ws_delta  which would check for the mode
in `o` instead of repeating the modes in all these function.
Just like cmp_in_block_with_wsd takes both modes into account


> +                                       }
>                                 } else {
>                                         pmb[pmb_nr++] = match;
>                                 }
> @@ -5740,7 +5835,8 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
>                         struct hashmap add_lines, del_lines;
>
>                         if (o->color_moved_ws_handling &
> -                           COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
> +                           (COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE |
> +                            COLOR_MOVED_WS_ALLOW_MIXED_INDENTATION_CHANGE))
>                                 o->color_moved_ws_handling |= XDF_IGNORE_WHITESPACE;
>
>                         hashmap_init(&del_lines, moved_entry_cmp, o, 0);
> diff --git a/diff.h b/diff.h
> index 5e6bcf0926..03628cda45 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -217,6 +217,7 @@ struct diff_options {
>
>         /* XDF_WHITESPACE_FLAGS regarding block detection are set at 2, 3, 4 */
>         #define COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE (1<<5)
> +       #define COLOR_MOVED_WS_ALLOW_MIXED_INDENTATION_CHANGE (1<<6)
>         int color_moved_ws_handling;
>  };
>
> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
> index 41facf7abf..737dbd4a42 100755
> --- a/t/t4015-diff-whitespace.sh
> +++ b/t/t4015-diff-whitespace.sh
> @@ -1902,4 +1902,93 @@ test_expect_success 'compare whitespace delta incompatible with other space opti
>         test_i18ngrep allow-indentation-change err
>  '
>
> +NUL=''
> +test_expect_success 'compare mixed whitespace delta across moved blocks' '
> +
> +       git reset --hard &&
> +       tr Q_ "\t " <<-EOF >text.txt &&

So this is the extended version of q_to_tab, as it also
translates _ to blank.

> +       ${NUL}

is an empty line? So maybe s/NUL/EMPTY/ ?

I think the following test cases may be useful:

    (3x_) too short without
    $EMPTY
    (4x_)  being grouped across blank line

that will be indented to

    (3x_+n) too short without
    $EMPTY
    (4x_+n)  being grouped across blank line

i.e. the current test of grouping across an empty line
always has the same indentation before and after, but we
only care about the change in indentation, such that
we should be able to have different indentation levels
before and after an empty line in the code, and
still count it as a block when they are indented the
same amount.


Is it possible for a block to start with an empty line?
How do we handle multiple adjacent empty lines?

Do we need tests for such special cases?

-

I hope this helps, as I gave the feedback above
mostly unstructured.

I'm excited about the skip blank lines mode, but
I am not quite sure about the "just count" mode,
as that is what I had originally IIRC but Jonathan
seemed to not be fond of it. Maybe he remembers
why.

Thanks,
Stefan

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CCE41F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 19:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754550AbeGIT3t (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 15:29:49 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:36480 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754525AbeGIT3r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 15:29:47 -0400
Received: by mail-yb0-f196.google.com with SMTP id s1-v6so7648826ybk.3
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 12:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bJhqH9WQQ35nMYwfFiqeBCnBM+UeHuhZf3xhI99NeK4=;
        b=TJxCAludE8As3VZA6EPOA5ebd/vJ6u+jjklEHRAMe0HyznU4tTppBUyDYkQiydvgzf
         XdSic2FPt9JeF34QFCrnRzjmV/sU21mGeuFVG2flALCxnxSNV6oiVN5Kw2S1u/Oy5Gpu
         ScC60wcDpUyTpXuM0CiHapNuTpPhNqGaG2pwJE3LX64RW/I50YzCOrZF6/oIDeqpo68P
         UyVTeAmF++5EjB9MF4aEH+SShQM3ORkRLXzvKxg2B0q7qPx0OgzrIEIYvegkuE+iKDbo
         ptaW9eh8ShzEDQGb0C42JBCSxszpPfta3rP+gM+PCAkKgtMeVmxhXCwS40fezuRdC4Un
         yKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bJhqH9WQQ35nMYwfFiqeBCnBM+UeHuhZf3xhI99NeK4=;
        b=GqqBuP77Tdg4eld/l3DyJN9ZJ8S80XoruIRxQaw8RLSfbO874QVbwoSBTpD19VQeqv
         mPGR6xyMtv7iDlKnAummYuvIKo79CzWth9hQKIeZihLOuhVE4Xhgf06kJIDljoKiJsao
         t1Ta8n9AkKvRy8H6vqvQ4olNtGkmwT9EzwQYmXzsNeoM6HkMdwruUo4WfnWysrDXRRb/
         ZxoDLumm41NBHNzEMFVtoZYFh8zobSzxOfX7wgu4fEBsnJ5N5JvzmIuxVAlFqnV7oFrd
         GKowKdfy+ZwCIXyrEdWouUFIGtmYrJfjZ8V3R90xOF1prO4OSnQ7XkNnzmne7TfFWrqV
         g/yQ==
X-Gm-Message-State: APt69E2MBVpFfv/hsfXn/qnd13BnDNuTsSecnUfqfHPu/qYomiWwwhNw
        XwJbe8pEYilQDhJ/pgb8GhpryebInS51DDnNWOPnAg==
X-Google-Smtp-Source: AAOMgpd1NECeGvVHSKSz/Bky3Da9ljrEP1LaPh+h+YIDPfLjq1qvnbnePIxp8PwUzgeh+vMrLOXdi13tVGCxxb7DZuQ=
X-Received: by 2002:a25:b091:: with SMTP id f17-v6mr11296668ybj.167.1531164586824;
 Mon, 09 Jul 2018 12:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
 <pull.1.v3.git.gitgitgadget@gmail.com> <6be4baf60b0376e77ec164cedea2b58fc21d16ee.1530617166.git.gitgitgadget@gmail.com>
In-Reply-To: <6be4baf60b0376e77ec164cedea2b58fc21d16ee.1530617166.git.gitgitgadget@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 9 Jul 2018 12:29:35 -0700
Message-ID: <CAGZ79kb4RS-KxEX+x07XsFiGwgG+1AiRUha=zcxexe1=RLL8kg@mail.gmail.com>
Subject: Re: [PATCH v3 14/20] diff: add an internal option to dual-color diffs
 of diffs
To:     gitgitgadget@gmail.com
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 3, 2018 at 4:27 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When diffing diffs, it can be quite daunting to figure out what the heck
> is going on, as there are nested +/- signs.
>
> Let's make this easier by adding a flag in diff_options that allows
> color-coding the outer diff sign with inverted colors, so that the
> preimage and postimage is colored like the diff it is.
>
> Of course, this really only makes sense when the preimage and postimage
> *are* diffs. So let's not expose this flag via a command-line option for
> now.
>
> This is a feature that was invented by git-tbdiff, and it will be used
> by `git range-diff` in the next commit, by offering it via a new option:
> `--dual-color`.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  diff.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++-----------
>  diff.h |  1 +
>  2 files changed, 69 insertions(+), 15 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 8c568cbe0..26445ffa1 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -562,14 +562,18 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
>         ecbdata->blank_at_eof_in_postimage = (at - l2) + 1;
>  }
>
> -static void emit_line_0(struct diff_options *o, const char *set, const char *reset,
> +static void emit_line_0(struct diff_options *o,
> +                       const char *set, unsigned reverse, const char *reset,
>                         int first, const char *line, int len)
>  {
>         int has_trailing_newline, has_trailing_carriage_return;
>         int nofirst;
>         FILE *file = o->file;
>
> -       fputs(diff_line_prefix(o), file);
> +       if (first)
> +               fputs(diff_line_prefix(o), file);
> +       else if (!len)
> +               return;

This case is not a problem for empty lines in e.g. "git-log --line-prefix"
because first would contain the LF.

>         if (len == 0) {
>                 has_trailing_newline = (first == '\n');
> @@ -587,8 +591,10 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
>         }
>
>         if (len || !nofirst) {
> +               if (reverse && want_color(o->use_color))
> +                       fputs(GIT_COLOR_REVERSE, file);

Would it make sense to have the function signature take a char* for reverse
and we pass in diff_get_color(o, GIT_COLOR_REVERSE), that would align
with the set and reset color passed in?

>                 fputs(set, file);
> -               if (!nofirst)
> +               if (first && !nofirst)
>                         fputc(first, file);

'first' is line[0] and comes from user data, so I think this could change
the output of diffs that has lines with the NUL character first in a line
as then that character would be silently eaten?

The 'nofirst' (which is a bad name) is used to detect if we do not
want to double print the first character in case of an empty line.
(Before this series we always had 'first' as a valid character, now we also
have 0 encoded for "do not print anything?"

> @@ -962,7 +968,8 @@ static void dim_moved_lines(struct diff_options *o)
>
>  static void emit_line_ws_markup(struct diff_options *o,
>                                 const char *set, const char *reset,
> -                               const char *line, int len, char sign,
> +                               const char *line, int len,
> +                               const char *set_sign, char sign,
>                                 unsigned ws_rule, int blank_at_eof)
>  {
>         const char *ws = NULL;
> @@ -973,14 +980,20 @@ static void emit_line_ws_markup(struct diff_options *o,
>                         ws = NULL;
>         }
>
> -       if (!ws)
> -               emit_line_0(o, set, reset, sign, line, len);
> -       else if (blank_at_eof)
> +       if (!ws && !set_sign)
> +               emit_line_0(o, set, 0, reset, sign, line, len);
> +       else if (!ws) {
> +               /* Emit just the prefix, then the rest. */
> +               emit_line_0(o, set_sign ? set_sign : set, !!set_sign, reset,
> +                           sign, "", 0);
> +               emit_line_0(o, set, 0, reset, 0, line, len);

(FYI:)
My long term vision for the emit_line_* functions was to have them actually
line oriented, and here we observe that the preimage already breaks
this assumption but just uses it as it sees fit.
I added that wart when refactoring the diff code to use the emit_ functionality
as I wanted to stay backwards compatible.

The actual issue is that each emit_line_0 will encapsulate its content
with its designated color and then end it with a reset. Looking at t4015
a common occurrence is output like:

  <GREEN>+<RESET><GREEN>{<RESET>

which we'd add one more layer to it now when set_sign is set.

I think this is ok for now (I value having this series land over insisting
on the perfect code), but just wanted to note my concern.

Ideally we'd refactor to only call emit_line once per line and when
the set sign (and the newly introduced set_sign) are the same as the
line color we'd avoid the intermediate RESET-and-SAME_COLOR
pattern that the test suite expects a lot currently.

> @@ -990,7 +1003,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
>                                          struct emitted_diff_symbol *eds)
>  {
>         static const char *nneof = " No newline at end of file\n";
> -       const char *context, *reset, *set, *meta, *fraginfo;
> +       const char *context, *reset, *set, *set_sign, *meta, *fraginfo;
>         struct strbuf sb = STRBUF_INIT;
>
>         enum diff_symbol s = eds->s;
> @@ -1003,7 +1016,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
>                 context = diff_get_color_opt(o, DIFF_CONTEXT);
>                 reset = diff_get_color_opt(o, DIFF_RESET);
>                 putc('\n', o->file);
> -               emit_line_0(o, context, reset, '\\',
> +               emit_line_0(o, context, 0, reset, '\\',



> @@ -1030,7 +1043,18 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
>         case DIFF_SYMBOL_CONTEXT:
>                 set = diff_get_color_opt(o, DIFF_CONTEXT);
>                 reset = diff_get_color_opt(o, DIFF_RESET);
> -               emit_line_ws_markup(o, set, reset, line, len, ' ',
> +               set_sign = NULL;
> +               if (o->flags.dual_color_diffed_diffs) {
> +                       char c = !len ? 0 : line[0];
> +
> +                       if (c == '+')
> +                               set = diff_get_color_opt(o, DIFF_FILE_NEW);
> +                       else if (c == '@')
> +                               set = diff_get_color_opt(o, DIFF_FRAGINFO);
> +                       else if (c == '-')
> +                               set = diff_get_color_opt(o, DIFF_FILE_OLD);
> +               }

This hunk is replicated below very similarly/
'set' depends on the initial symbol (the case we're in), and the first character
of line.

Would it make sense to have a function

  diff_get_color_set_sign(struct diffopt *, \
      struct emitted_diff_symbol *)

that takes care of all the computation and doesn't need
repetition in each case? For example @ always maps to DIFF_FRAGINFO,
and +/- have either DIFF_FILE_{OLD, NEW}, with the exception of
(sign == set_sign), when they become CONTEXT AFAICT?

> +               emit_line_ws_markup(o, set, reset, line, len, set_sign, ' ',
>                                     flags & (DIFF_SYMBOL_CONTENT_WS_MASK), 0);
>                 break;
>         case DIFF_SYMBOL_PLUS:
> @@ -1057,7 +1081,20 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
>                         set = diff_get_color_opt(o, DIFF_FILE_NEW);
>                 }
>                 reset = diff_get_color_opt(o, DIFF_RESET);
> -               emit_line_ws_markup(o, set, reset, line, len, '+',
> +               if (!o->flags.dual_color_diffed_diffs)
> +                       set_sign = NULL;
> +               else {
> +                       char c = !len ? 0 : line[0];
> +
> +                       set_sign = set;
> +                       if (c == '-')
> +                               set = diff_get_color_opt(o, DIFF_FILE_OLD);
> +                       else if (c == '@')
> +                               set = diff_get_color_opt(o, DIFF_FRAGINFO);
> +                       else if (c != '+')
> +                               set = diff_get_color_opt(o, DIFF_CONTEXT);
> +               }
> +               emit_line_ws_markup(o, set, reset, line, len, set_sign, '+',
>                                     flags & DIFF_SYMBOL_CONTENT_WS_MASK,
>                                     flags & DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF);
>                 break;
> @@ -1085,7 +1122,20 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
>                         set = diff_get_color_opt(o, DIFF_FILE_OLD);
>                 }
>                 reset = diff_get_color_opt(o, DIFF_RESET);
> -               emit_line_ws_markup(o, set, reset, line, len, '-',
> +               if (!o->flags.dual_color_diffed_diffs)
> +                       set_sign = NULL;
> +               else {
> +                       char c = !len ? 0 : line[0];
> +
> +                       set_sign = set;
> +                       if (c == '+')
> +                               set = diff_get_color_opt(o, DIFF_FILE_NEW);
> +                       else if (c == '@')
> +                               set = diff_get_color_opt(o, DIFF_FRAGINFO);
> +                       else if (c != '-')
> +                               set = diff_get_color_opt(o, DIFF_CONTEXT);
> +               }
> +               emit_line_ws_markup(o, set, reset, line, len, set_sign, '-',
>                                     flags & DIFF_SYMBOL_CONTENT_WS_MASK, 0);
>                 break;
>         case DIFF_SYMBOL_WORDS_PORCELAIN:
> @@ -1276,6 +1326,7 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
>         const char *frag = diff_get_color(ecbdata->color_diff, DIFF_FRAGINFO);
>         const char *func = diff_get_color(ecbdata->color_diff, DIFF_FUNCINFO);
>         const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
> +       const char *reverse = ecbdata->color_diff ? GIT_COLOR_REVERSE : "";
>         static const char atat[2] = { '@', '@' };
>         const char *cp, *ep;
>         struct strbuf msgbuf = STRBUF_INIT;
> @@ -1296,6 +1347,8 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
>         ep += 2; /* skip over @@ */
>
>         /* The hunk header in fraginfo color */
> +       if (ecbdata->opt->flags.dual_color_diffed_diffs)
> +               strbuf_addstr(&msgbuf, reverse);
>         strbuf_addstr(&msgbuf, frag);
>         strbuf_add(&msgbuf, line, ep - line);
>         strbuf_addstr(&msgbuf, reset);
> diff --git a/diff.h b/diff.h
> index 928f48995..79beb6eea 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -95,6 +95,7 @@ struct diff_flags {
>         unsigned default_follow_renames:1;
>         unsigned stat_with_summary:1;
>         unsigned suppress_diff_headers:1;
> +       unsigned dual_color_diffed_diffs:1;
>  };
>
>  static inline void diff_flags_or(struct diff_flags *a,
> --
> gitgitgadget
>

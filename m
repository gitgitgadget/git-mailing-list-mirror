Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18476201A7
	for <e@80x24.org>; Tue, 16 May 2017 04:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750786AbdEPEeI (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 00:34:08 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36706 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbdEPEeH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 00:34:07 -0400
Received: by mail-wm0-f53.google.com with SMTP id u65so106725471wmu.1
        for <git@vger.kernel.org>; Mon, 15 May 2017 21:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1oYwePaffY6zh74byXdZDJWAu/0FdvCjprSCNJOFhtE=;
        b=mPFOQ6TRw0Vvf+A4CsyD519IJeJc70NzuseUF33O/TgZ8gvaZJ2qaIYBFBezsX1j4H
         vH8QTLCP5IiybFqp4U8LQgjO5brTp3YXgvgaKbsON1KULNGA2w6/0Le9bL6mbWiwv3PD
         NgEwMO5QpCzw3Vr/wUt9jgJ5JFRRsgNdW/oW2JIpmT9P4hM2pQN65227bCkJ37oznnQ6
         eiPV2w0oWpS6S2kM06RZoSQ9SCsWep265WFnJJz/zz+9C5lp8yd/MU9E3ZNPbTiajJmX
         zawllmz3btELH8o9CJD+sbugpbdEDW9DSjkHKTzTNeTI7FIjHk5OpkyGldbPBoSXgv+A
         4cMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1oYwePaffY6zh74byXdZDJWAu/0FdvCjprSCNJOFhtE=;
        b=Kifzx3bnXNzmN8+4PciRTn9W3pm3i70vaKpTtFMmQGypyMGoBDcLPmXWtn80rsmwTq
         1DFTqmhoxXcqDgQSBb8BD99ZQ4ouihPqJZhVyvF4qPxt3W6yP5v5mGUrNCf9hILoULGt
         NTIh8Kk221YMpx6mEOksp4uV2iF/SPAECAoONAyp1IV/bP5K3fIAdJFKpRp1Kb+g+DW6
         FrEsndviR+TATArJ7c9+2wuP+TFV89qVwdeKMBlCOlFgcgFKXYC7eRpjY5LpAUwfdRqU
         9q0M3TzOpOCLzdWUYq4w/fiu/KPWlAdOUIvaPYLce6Y38lB9bVJAOXOBe79TTaOoWUef
         Z7Pg==
X-Gm-Message-State: AODbwcAT/9/38XWzmBfuMsSX5vvtXlmdhLlWP4zN++t6Hd2J96nY6CNe
        yRERbgJXWpdDvTNHKiQZIiV/ja8TemEUW94=
X-Received: by 10.223.138.137 with SMTP id y9mr5987645wry.26.1494909244642;
 Mon, 15 May 2017 21:34:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.18.149 with HTTP; Mon, 15 May 2017 21:34:04 -0700 (PDT)
In-Reply-To: <20170514040117.25865-20-sbeller@google.com>
References: <20170514040117.25865-1-sbeller@google.com> <20170514040117.25865-20-sbeller@google.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Date:   Mon, 15 May 2017 21:34:04 -0700
Message-ID: <CAGf8dgLuJLn=X4gmVGQ0tfTo2=py4XhBw-WSYtw2acy9x3NSJQ@mail.gmail.com>
Subject: Re: [PATCH 19/19] diff.c: color moved lines differently
To:     Stefan Beller <sbeller@google.com>
Cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I expected there to be one main function that takes in a diff options
and returns the appropriate output without much (if any) changes in
other functions...but (as with the previous patch) maybe there are
some complications that I didn't foresee.

On Sat, May 13, 2017 at 9:01 PM, Stefan Beller <sbeller@google.com> wrote:
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 475e874d51..90403c06e3 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1051,14 +1051,22 @@ This does not affect linkgit:git-format-patch[1] or the
>  'git-diff-{asterisk}' plumbing commands.  Can be overridden on the
>  command line with the `--color[=<when>]` option.
>
> +color.moved::
> +       A boolean value, whether a diff should color moved lines
> +       differently. The moved lines are searched for in the diff only.
> +       Duplicated lines from somewhere in the project that are not
> +       part of the diff are not colored as moved.
> +       Defaults to false.
> +
>  color.diff.<slot>::
>         Use customized color for diff colorization.  `<slot>` specifies
>         which part of the patch to use the specified color, and is one
>         of `context` (context text - `plain` is a historical synonym),
>         `meta` (metainformation), `frag`
>         (hunk header), 'func' (function in hunk header), `old` (removed lines),
> -       `new` (added lines), `commit` (commit headers), or `whitespace`
> -       (highlighting whitespace errors).
> +       `new` (added lines), `commit` (commit headers), `whitespace`
> +       (highlighting whitespace errors), `movedFrom` (removed lines that
> +       reappear), `movedTo` (added lines that were removed elsewhere).

There should be 4 "moved" colors. I think the code below is correct
(oldmoved, oldmovedalternate, etc.) but the documentation above is
wrong.

>
>  color.decorate.<slot>::
>         Use customized color for 'git log --decorate' output.  `<slot>` is one
> diff --git a/diff.c b/diff.c
> index dbab7fb44e..6372e0eb25 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -31,6 +31,7 @@ static int diff_indent_heuristic; /* experimental */
>  static int diff_rename_limit_default = 400;
>  static int diff_suppress_blank_empty;
>  static int diff_use_color_default = -1;
> +static int diff_color_moved_default;
>  static int diff_context_default = 3;
>  static int diff_interhunk_context_default;
>  static const char *diff_word_regex_cfg;
> @@ -55,6 +56,10 @@ static char diff_colors[][COLOR_MAXLEN] = {
>         GIT_COLOR_YELLOW,       /* COMMIT */
>         GIT_COLOR_BG_RED,       /* WHITESPACE */
>         GIT_COLOR_NORMAL,       /* FUNCINFO */
> +       GIT_COLOR_BOLD_RED,     /* OLD_MOVED_A */
> +       GIT_COLOR_BG_RED,       /* OLD_MOVED_B */
> +       GIT_COLOR_BOLD_GREEN,   /* NEW_MOVED_A */
> +       GIT_COLOR_BG_GREEN,     /* NEW_MOVED_B */
>  };
>
>  static NORETURN void die_want_option(const char *option_name)
> @@ -80,6 +85,14 @@ static int parse_diff_color_slot(const char *var)
>                 return DIFF_WHITESPACE;
>         if (!strcasecmp(var, "func"))
>                 return DIFF_FUNCINFO;
> +       if (!strcasecmp(var, "oldmoved"))
> +               return DIFF_FILE_OLD_MOVED;
> +       if (!strcasecmp(var, "oldmovedalternative"))
> +               return DIFF_FILE_OLD_MOVED_ALT;
> +       if (!strcasecmp(var, "newmoved"))
> +               return DIFF_FILE_NEW_MOVED;
> +       if (!strcasecmp(var, "newmovedalternative"))
> +               return DIFF_FILE_NEW_MOVED_ALT;
>         return -1;
>  }
>
> @@ -234,6 +247,10 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
>                 diff_use_color_default = git_config_colorbool(var, value);
>                 return 0;
>         }
> +       if (!strcmp(var, "color.moved")) {
> +               diff_color_moved_default = git_config_bool(var, value);
> +               return 0;
> +       }
>         if (!strcmp(var, "diff.context")) {
>                 diff_context_default = git_config_int(var, value);
>                 if (diff_context_default < 0)
> @@ -354,6 +371,81 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
>         return git_default_config(var, value, cb);
>  }
>
> +struct moved_entry {
> +       struct hashmap_entry ent;
> +       const struct buffered_patch_line *line;
> +       struct moved_entry *next_line;
> +};
> +
> +static void get_ws_cleaned_string(const struct buffered_patch_line *l,
> +                                 struct strbuf *out)
> +{
> +       int i;
> +       for (i = 0; i < l->len; i++) {
> +               if (isspace(l->line[i]))
> +                       continue;
> +               strbuf_addch(out, l->line[i]);
> +       }
> +}
> +
> +static int buffered_patch_line_cmp_no_ws(const struct buffered_patch_line *a,
> +                                        const struct buffered_patch_line *b,
> +                                        const void *keydata)
> +{
> +       struct strbuf sba = STRBUF_INIT;
> +       struct strbuf sbb = STRBUF_INIT;
> +       get_ws_cleaned_string(a, &sba);
> +       get_ws_cleaned_string(b, &sbb);
> +       return sba.len != sbb.len || strncmp(sba.buf, sbb.buf, sba.len);
> +}
> +
> +static int buffered_patch_line_cmp(const struct buffered_patch_line *a,
> +                                  const struct buffered_patch_line *b,
> +                                  const void *keydata)
> +{
> +       return a->len != b->len || strncmp(a->line, b->line, a->len);
> +}
> +
> +static int moved_entry_cmp(const struct moved_entry *a,
> +                          const struct moved_entry *b,
> +                          const void *keydata)
> +{
> +       return buffered_patch_line_cmp(a->line, b->line, keydata);
> +}
> +
> +static int moved_entry_cmp_no_ws(const struct moved_entry *a,
> +                                const struct moved_entry *b,
> +                                const void *keydata)
> +{
> +       return buffered_patch_line_cmp_no_ws(a->line, b->line, keydata);
> +}
> +
> +static unsigned get_line_hash(struct buffered_patch_line *line, unsigned ignore_ws)
> +{
> +       static struct strbuf sb = STRBUF_INIT;
> +
> +       if (ignore_ws) {
> +               strbuf_reset(&sb);
> +               get_ws_cleaned_string(line, &sb);
> +               return memhash(sb.buf, sb.len);
> +       } else
> +               return memhash(line->line, line->len);
> +}
> +
> +static struct moved_entry *prepare_entry(struct diff_options *o,
> +                                        int line_no)
> +{
> +       struct moved_entry *ret = xmalloc(sizeof(*ret));
> +       unsigned ignore_ws = DIFF_XDL_TST(o, IGNORE_WHITESPACE);
> +       struct buffered_patch_line *l = &o->line_buffer[line_no];
> +
> +       ret->ent.hash = get_line_hash(l, ignore_ws);
> +       ret->line = l;
> +       ret->next_line = NULL;
> +
> +       return ret;
> +}
> +
>  static char *quote_two(const char *one, const char *two)
>  {
>         int need_one = quote_c_style(one, NULL, NULL, 1);
> @@ -516,8 +608,98 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
>         ecbdata->blank_at_eof_in_postimage = (at - l2) + 1;
>  }
>
> +static void mark_color_as_moved(struct diff_options *o, int line_no)
> +{
> +       struct hashmap *hm = NULL;
> +       struct moved_entry *key = prepare_entry(o, line_no);
> +       struct moved_entry *match = NULL;
> +       struct buffered_patch_line *l = &o->line_buffer[line_no];
> +       int alt_flag;
> +       int i, lp, rp;
> +
> +       switch (l->sign) {
> +       case '+':
> +               hm = o->deleted_lines;
> +               break;
> +       case '-':
> +               hm = o->added_lines;
> +               break;
> +       default:
> +               /* reset to standard, on-alt move color */
> +               o->color_moved = 1;
> +               break;
> +       }
> +
> +       /* Check for any match to color it as a move. */
> +       if (!hm)
> +               return;
> +       match = hashmap_get(hm, key, o);
> +       free(key);
> +       if (!match)
> +               return;
> +
> +       /* Check any potential block runs, advance each or nullify */
> +       for (i = 0; i < o->pmb_nr; i++) {
> +               struct moved_entry *p = o->pmb[i];
> +               if (p && p->next_line &&
> +                   !buffered_patch_line_cmp(p->next_line->line, l, o)) {
> +                       o->pmb[i] = p->next_line;
> +               } else {
> +                       o->pmb[i] = NULL;
> +               }
> +       }
> +
> +       /* Shrink the set to the remaining runs */
> +       for (lp = 0, rp = o->pmb_nr - 1; lp <= rp;) {
> +               while (lp < o->pmb_nr && o->pmb[lp])
> +                       lp ++;
> +               /* lp points at the first NULL now */
> +
> +               while (rp > -1 && !o->pmb[rp])
> +                       rp--;
> +               /* rp points at the last non-NULL */
> +
> +               if (lp < o->pmb_nr && rp > -1 && lp < rp) {
> +                       o->pmb[lp] = o->pmb[rp];
> +                       o->pmb[rp] = NULL;
> +                       rp--;
> +                       lp++;
> +               }
> +       }
> +
> +       if (rp > -1) {
> +               /* Remember the number of running sets */
> +               o->pmb_nr = rp + 1;
> +       } else {
> +               /* Toggle color */
> +               o->color_moved = o->color_moved == 2 ? 1 : 2;
> +
> +               /* Build up a new set */
> +               i = 0;
> +               for (; match; match = hashmap_get_next(hm, match)) {
> +                       ALLOC_GROW(o->pmb, i + 1, o->pmb_alloc);
> +                       o->pmb[i] = match;
> +                       i++;
> +               }
> +               o->pmb_nr = i;
> +       }
> +
> +       alt_flag = o->color_moved - 1;
> +       switch (l->sign) {
> +       case '+':
> +               l->set = diff_get_color_opt(o, DIFF_FILE_NEW_MOVED + alt_flag);
> +               break;
> +       case '-':
> +               l->set = diff_get_color_opt(o, DIFF_FILE_OLD_MOVED + alt_flag);
> +               break;
> +       default:
> +               ; /* nothing */
> +       }
> +}
> +
>  static void emit_buffered_patch_line(struct diff_options *o,
> -                                    struct buffered_patch_line *e)
> +                                    struct buffered_patch_line *e,
> +                                    int pass)

1. I didn't expect such a function to need to be modified in this patch.
2. What does "pass" do?

>  {
>         int has_trailing_newline, has_trailing_carriage_return, len = e->len;
>         FILE *file = o->file;
> @@ -548,11 +730,11 @@ static void emit_buffered_patch_line(struct diff_options *o,
>
>  static void emit_buffered_patch_line_ws(struct diff_options *o,
>                                         struct buffered_patch_line *e,
> -                                       const char *ws, unsigned ws_rule)
> +                                       const char *ws, unsigned ws_rule,
> +                                       int pass)
>  {
>         struct buffered_patch_line s = {e->set, e->reset, "", 0, e->sign};
> -
> -       emit_buffered_patch_line(o, &s);
> +       emit_buffered_patch_line(o, &s, 0);
>         ws_check_emit(e->line, e->len, ws_rule,
>                       o->file, e->set, e->reset, ws);
>  }
> @@ -564,12 +746,14 @@ static void process_next_buffered_patch_line(struct diff_options *o, int line_no
>         const char *ws = o->current_filepair->ws;
>         unsigned ws_rule = o->current_filepair->ws_rule;
>
> +       mark_color_as_moved(o, line_no);
> +
>         switch (e->state) {
>                 case BPL_EMIT_LINE_ASIS:
> -                       emit_buffered_patch_line(o, e);
> +                       emit_buffered_patch_line(o, e, 1);
>                         break;
>                 case BPL_EMIT_LINE_WS:
> -                       emit_buffered_patch_line_ws(o, e, ws, ws_rule);
> +                       emit_buffered_patch_line_ws(o, e, ws, ws_rule, 1);
>                         break;
>                 case BPL_HANDOVER:
>                         o->current_filepair++;
> @@ -602,7 +786,7 @@ static void emit_line_0(struct diff_options *o,
>         if (o->use_buffer)
>                 append_buffered_patch_line(o, &e);
>         else
> -               emit_buffered_patch_line(o, &e);
> +               emit_buffered_patch_line(o, &e, 0);
>  }
>
>  void emit_line(struct diff_options *o, const char *set, const char *reset,
> @@ -621,7 +805,7 @@ static void emit_line_ws(struct diff_options *o,
>         if (o->use_buffer)
>                 append_buffered_patch_line(o, &e);
>         else
> -               emit_buffered_patch_line_ws(o, &e, ws, ws_rule);
> +               emit_buffered_patch_line_ws(o, &e, ws, ws_rule, 0);
>  }
>
>  void emit_line_fmt(struct diff_options *o,
> @@ -676,6 +860,36 @@ static void emit_line_checked(const char *reset,
>                              ws, ecbdata->ws_rule);
>  }
>
> +static void add_line_to_move_detection(struct diff_options *o, int line_idx)
> +{
> +       int sign = 0;
> +       struct hashmap *hm;
> +       struct moved_entry *key;
> +
> +       switch (o->line_buffer[line_idx].sign) {
> +       case '+':
> +               sign = '+';
> +               hm = o->added_lines;
> +               break;
> +       case '-':
> +               sign = '-';
> +               hm = o->deleted_lines;
> +               break;
> +       case ' ':
> +       default:
> +               o->prev_line = NULL;
> +               return;
> +       }
> +
> +       key = prepare_entry(o, line_idx);
> +       if (o->prev_line &&
> +           o->prev_line->line->sign == sign)
> +               o->prev_line->next_line = key;
> +
> +       hashmap_add(hm, key);
> +       o->prev_line = key;
> +}
> +
>  static void emit_add_line(const char *reset,
>                           struct emit_callback *ecbdata,
>                           const char *line, int len)
> @@ -3649,6 +3863,9 @@ void diff_setup_done(struct diff_options *options)
>
>         if (DIFF_OPT_TST(options, FOLLOW_RENAMES) && options->pathspec.nr != 1)
>                 die(_("--follow requires exactly one pathspec"));
> +
> +       if (!options->use_color || external_diff())
> +               options->color_moved = 0;
>  }
>
>  static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *val)
> @@ -4073,6 +4290,10 @@ int diff_opt_parse(struct diff_options *options,
>         }
>         else if (!strcmp(arg, "--no-color"))
>                 options->use_color = 0;
> +       else if (!strcmp(arg, "--color-moved"))
> +               options->color_moved = 1;
> +       else if (!strcmp(arg, "--no-color-moved"))
> +               options->color_moved = 0;
>         else if (!strcmp(arg, "--color-words")) {
>                 options->use_color = 1;
>                 options->word_diff = DIFF_WORDS_COLOR;
> @@ -4878,16 +5099,19 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
>  {
>         int i;
>         struct diff_queue_struct *q = &diff_queued_diff;
> -       /*
> -        * For testing purposes we want to make sure the diff machinery
> -        * works completely with the buffer. If there is anything emitted
> -        * outside the emit_buffered_patch_line, then the order is screwed
> -        * up and the tests will fail.
> -        *
> -        * TODO (later in this series):
> -        * We'll unset this flag in a later patch.
> -        */
> -       o->use_buffer = 1;
> +
> +       if (o->color_moved) {
> +               unsigned ignore_ws = DIFF_XDL_TST(o, IGNORE_WHITESPACE);
> +               o->use_buffer = 1;
> +               o->deleted_lines = xmallocz(sizeof(*o->deleted_lines));
> +               o->added_lines = xmallocz(sizeof(*o->added_lines));
> +               hashmap_init(o->deleted_lines, ignore_ws ?
> +                       (hashmap_cmp_fn)moved_entry_cmp_no_ws :
> +                       (hashmap_cmp_fn)moved_entry_cmp, 0);
> +               hashmap_init(o->added_lines, ignore_ws ?
> +                       (hashmap_cmp_fn)moved_entry_cmp_no_ws :
> +                       (hashmap_cmp_fn)moved_entry_cmp, 0);
> +       }
>
>         if (o->use_buffer) {
>                 ALLOC_GROW(o->filepair_buffer,
> @@ -4902,6 +5126,10 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
>         }
>
>         if (o->use_buffer) {
> +               o->current_filepair = &o->filepair_buffer[0];
> +               for (i = 0; i < o->line_buffer_nr; i++)
> +                       add_line_to_move_detection(o, i);
> +
>                 o->current_filepair = &o->filepair_buffer[0];
>                 for (i = 0; i < o->line_buffer_nr; i++)
>                         process_next_buffered_patch_line(o, i);
> @@ -4992,6 +5220,7 @@ void diff_flush(struct diff_options *options)
>                 if (!options->file)
>                         die_errno("Could not open /dev/null");
>                 options->close_file = 1;
> +               options->color_moved = 0;
>                 for (i = 0; i < q->nr; i++) {
>                         struct diff_filepair *p = q->queue[i];
>                         if (check_pair_status(p))
> diff --git a/diff.h b/diff.h
> index c334aac02e..b83d6fefcc 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -7,6 +7,7 @@
>  #include "tree-walk.h"
>  #include "pathspec.h"
>  #include "object.h"
> +#include "hashmap.h"
>
>  struct rev_info;
>  struct diff_options;
> @@ -145,6 +146,8 @@ struct buffered_filepair {
>         unsigned ws_rule;
>  };
>
> +struct moved_entry;
> +
>  struct diff_options {
>         const char *orderfile;
>         const char *pickaxe;
> @@ -217,6 +220,8 @@ struct diff_options {
>
>         int diff_path_counter;
>
> +       /* Determines color moved code. Flipped between 1, 2 for alt. color. */
> +       int color_moved;
>         int use_buffer;
>
>         struct buffered_patch_line *line_buffer;
> @@ -225,6 +230,16 @@ struct diff_options {
>         struct buffered_filepair *filepair_buffer;
>         int filepair_buffer_nr, filepair_buffer_alloc;
>         struct buffered_filepair *current_filepair;
> +
> +       /* built up in the first pass: */
> +       struct hashmap *deleted_lines;
> +       struct hashmap *added_lines;
> +       /* needed for building up */
> +       struct moved_entry *prev_line;
> +
> +       /* state in the second pass */
> +       struct moved_entry **pmb; /* potentially moved blocks */
> +       int pmb_nr, pmb_alloc;

Placing these in the public API makes the scope unnecessarily large -
could these be stored in a struct (or better, in local variables)
private to the .c file? In particular, prev_line should not need a
scope greater than a function - a function could just loop through all
the buffered lines and construct the two hash maps, and prev_line
would not be needed elsewhere.

>  };
>
>  void emit_line_fmt(struct diff_options *o, const char *set, const char *reset,
> @@ -241,7 +256,11 @@ enum color_diff {
>         DIFF_FILE_NEW = 5,
>         DIFF_COMMIT = 6,
>         DIFF_WHITESPACE = 7,
> -       DIFF_FUNCINFO = 8
> +       DIFF_FUNCINFO = 8,
> +       DIFF_FILE_OLD_MOVED = 9,
> +       DIFF_FILE_OLD_MOVED_ALT = 10,
> +       DIFF_FILE_NEW_MOVED = 11,
> +       DIFF_FILE_NEW_MOVED_ALT = 12
>  };
>  const char *diff_get_color(int diff_use_color, enum color_diff ix);
>  #define diff_get_color_opt(o, ix) \
> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
> index 289806d0c7..232d9ad55e 100755
> --- a/t/t4015-diff-whitespace.sh
> +++ b/t/t4015-diff-whitespace.sh
[snip]

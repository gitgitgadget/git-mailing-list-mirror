Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA9D2201A7
	for <e@80x24.org>; Mon, 15 May 2017 22:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752144AbdEOWmc (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 18:42:32 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35734 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbdEOWma (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 18:42:30 -0400
Received: by mail-pg0-f41.google.com with SMTP id q125so47271903pgq.2
        for <git@vger.kernel.org>; Mon, 15 May 2017 15:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PWeGi55mRONxq/y0QW1Vgswznh8/y02s9C9I1gLI0tY=;
        b=AygHAk/7uLV/r8dxNj2Q0hP7/Vir5IqA8BahOPQhdp3r9STEHJY/tISqWDa19/Qmo+
         RUkYhPG/VNzyLAni/x5r1Ix45uULxAVDEtfEZ4RoxFmfwBzSof7bDYSotUCPKb1ccPSH
         8QdaOcCsYXXM3lb5e2rL6j99U2JWzM1bUOr7Ik3/Dz3NDOwTJkkZF/yKRrr0OSWfmjft
         odK2SwRnaZr28aW93IbsiVNrScfnOTyD4P7lYHkxeTYgDYypt+m/rIfMPQt+FUlHcn2F
         BDg36Al8ZojCSxA0d1LEafo7g8rGAfK9BFICCQZMpBqJLMtfhvBYKNLr/gtMm5RXxOOT
         hjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PWeGi55mRONxq/y0QW1Vgswznh8/y02s9C9I1gLI0tY=;
        b=LAye93WHCbS8d5oKUJMhO4+54fc3ugpKVjCPf3JQkAdwcApZlBAmiSjLqFxtQF+lRe
         JotSBjwjkIMvtPatmq5Opo64OhcXZy8bbPnjwv4ElARV6cLLhCLQsTfFqGjprzxWlj0q
         MwiscRqCxiBZHgFBqI2T74qmdWZLfjkS96NPVtaVHVBkGOc1FeyxhqKzymC5VM8wAXUm
         PePHwqa6yMgaidhhh7jeyKNZLew5Ey0TZsxyNATCPNMszycCEPUJaIaUgJOMd1EkZvVp
         aQ2iPsaIeFFrPXEm6qIQPfrF52LpS1fCqNvskvZ1xQDgIakQO+XY8ityMDLPI+eZCfAX
         2UEQ==
X-Gm-Message-State: AODbwcAy/dN2SjIvRMhrGBt2QkB18YBQva+Jx7hkFhFgUyVIiQ5rOZFG
        A9m6EGGVKda3LGhf
X-Received: by 10.98.152.214 with SMTP id d83mr8733649pfk.7.1494888148694;
        Mon, 15 May 2017 15:42:28 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:8923:f8dd:f0f0:f864])
        by smtp.gmail.com with ESMTPSA id s18sm22096031pfi.16.2017.05.15.15.42.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 May 2017 15:42:27 -0700 (PDT)
Date:   Mon, 15 May 2017 15:42:26 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, peff@peff.net,
        gitster@pobox.com, mhagger@alum.mit.edu, jrnieder@gmail.com
Subject: Re: [PATCH 19/19] diff.c: color moved lines differently
Message-ID: <20170515224226.GE79147@google.com>
References: <20170514040117.25865-1-sbeller@google.com>
 <20170514040117.25865-20-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170514040117.25865-20-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/13, Stefan Beller wrote:
> When there is a lot of code moved around such as in 11979b9 (2005-11-18,
> "http.c: reorder to avoid compilation failure.") for example, the review
> process is quite hard, as it is not mentally challenging.  It is a rather
> tedious process, that gets boring quickly. However you still need to read
> through all of the code to make sure the moved lines are there as supposed.
> 
> While it is trivial to color up a patch like the following
> 
>     $ git diff
>     diff --git a/file2.c b/file2.c
>     index 9163a0f..8e66dc0 100644
>     --- a/file2.c
>     +++ b/file2.c
>     @@ -3,13 +3,6 @@ void *xmemdupz(const void *data, size_t len)
>             return memcpy(xmallocz(len), data, len);
>      }
> 
>     -int secure_foo(struct user *u)
>     -{
>     -       if (!u->is_allowed_foo)
>     -               return;
>     -       foo(u);
>     -}
>     -
>      char *xstrndup(const char *str, size_t len)
>      {
>             char *p = memchr(str, '\0', len);
>     diff --git a/test.c b/test.c
>     index a95e6fe..81eb0eb 100644
>     --- a/test.c
>     +++ b/test.c
>     @@ -18,6 +18,13 @@ ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset)
>             return total;
>      }
> 
>     +int secure_foo(struct user *u)
>     +{
>     +       if (!u->is_allowed_foo)
>     +               return;
>     +       foo(u);
>     +}
>     +
>      int xdup(int fd)
>      {
>             int ret = dup(fd);
> 
> as in this patch all lines that add or remove lines
> should be colored in the new color that indicates moved
> lines.
> 
> However the intention of this patch is to aid reviewers
> to spotting permutations in the moved code. So consider the
> following malicious move:
> 
>     diff --git a/file2.c b/file2.c
>     index 9163a0f..8e66dc0 100644
>     --- a/file2.c
>     +++ b/file2.c
>     @@ -3,13 +3,6 @@ void *xmemdupz(const void *data, size_t len)
>             return memcpy(xmallocz(len), data, len);
>      }
> 
>     -int secure_foo(struct user *u)
>     -{
>     -       if (!u->is_allowed_foo)
>     -               return;
>     -       foo(u);
>     -}
>     -
>      char *xstrndup(const char *str, size_t len)
>      {
>             char *p = memchr(str, '\0', len);
>     diff --git a/test.c b/test.c
>     index a95e6fe..a679c40 100644
>     --- a/test.c
>     +++ b/test.c
>     @@ -18,6 +18,13 @@ ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset)
>             return total;
>      }
> 
>     +int secure_foo(struct user *u)
>     +{
>     +       foo(u);
>     +       if (!u->is_allowed_foo)
>     +               return;
>     +}
>     +
>      int xdup(int fd)
>      {
>             int ret = dup(fd);
> 
> If the moved code is larger, it is easier to hide some permutation in the
> code, which is why we would not want to color all lines as "moved" in this
> case. So we do not just need to color lines differently that are added and
> removed in the same diff, we need to tweak the algorithm a bit more.
> 
> As the reviewers attention should be brought to the places, where the
> difference is introduced to the moved code, we cannot just have one new
> color for all of moved code.
> 
> First I implemented an alternative design, which would show a moved hunk
> in one color, and its boundaries in another color. This idea was error
> prone as it inspected each line and its neighboring lines to determine
> if the line was (a) moved and (b) if was deep inside a hunk by having
> matching neighboring lines. This is unreliable as the we can construct
> hunks which have equal neighbors that just exceed the number of lines
> inspected. See one of the tests as an example.
> 
> Instead this provides a dynamic programming greedy algorithm that finds
> the largest moved hunk and then switches color to the alternative color
> for the next hunk. By doing this any permutation is recognized and
> displayed. That implies that there is no dedicated boundary or
> inside-hunk color, but instead we'll have just two colors alternating
> for hunks.
> 
> It would be a bit more UX friendly if the two corresponding hunks
> (of added and deleted lines) for one move would get the same color id.
> (Both get "regular moved" or "alternative moved"). This problem is
> deferred to a later patch for now.
> 
> Algorithm-by: Jonathan Tan <jonathantanmy@google.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  Documentation/config.txt   |  12 +-
>  diff.c                     | 265 ++++++++++++++++++++++++++++++++++++++++++---
>  diff.h                     |  21 +++-
>  t/t4015-diff-whitespace.sh | 229 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 506 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 475e874d51..90403c06e3 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1051,14 +1051,22 @@ This does not affect linkgit:git-format-patch[1] or the
>  'git-diff-{asterisk}' plumbing commands.  Can be overridden on the
>  command line with the `--color[=<when>]` option.
>  
> +color.moved::
> +	A boolean value, whether a diff should color moved lines
> +	differently. The moved lines are searched for in the diff only.
> +	Duplicated lines from somewhere in the project that are not
> +	part of the diff are not colored as moved.
> +	Defaults to false.
> +
>  color.diff.<slot>::
>  	Use customized color for diff colorization.  `<slot>` specifies
>  	which part of the patch to use the specified color, and is one
>  	of `context` (context text - `plain` is a historical synonym),
>  	`meta` (metainformation), `frag`
>  	(hunk header), 'func' (function in hunk header), `old` (removed lines),
> -	`new` (added lines), `commit` (commit headers), or `whitespace`
> -	(highlighting whitespace errors).
> +	`new` (added lines), `commit` (commit headers), `whitespace`
> +	(highlighting whitespace errors), `movedFrom` (removed lines that
> +	reappear), `movedTo` (added lines that were removed elsewhere).
>  
>  color.decorate.<slot>::
>  	Use customized color for 'git log --decorate' output.  `<slot>` is one
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
>  	GIT_COLOR_YELLOW,	/* COMMIT */
>  	GIT_COLOR_BG_RED,	/* WHITESPACE */
>  	GIT_COLOR_NORMAL,	/* FUNCINFO */
> +	GIT_COLOR_BOLD_RED,	/* OLD_MOVED_A */
> +	GIT_COLOR_BG_RED,	/* OLD_MOVED_B */
> +	GIT_COLOR_BOLD_GREEN,	/* NEW_MOVED_A */
> +	GIT_COLOR_BG_GREEN,	/* NEW_MOVED_B */
>  };
>  
>  static NORETURN void die_want_option(const char *option_name)
> @@ -80,6 +85,14 @@ static int parse_diff_color_slot(const char *var)
>  		return DIFF_WHITESPACE;
>  	if (!strcasecmp(var, "func"))
>  		return DIFF_FUNCINFO;
> +	if (!strcasecmp(var, "oldmoved"))
> +		return DIFF_FILE_OLD_MOVED;
> +	if (!strcasecmp(var, "oldmovedalternative"))
> +		return DIFF_FILE_OLD_MOVED_ALT;
> +	if (!strcasecmp(var, "newmoved"))
> +		return DIFF_FILE_NEW_MOVED;
> +	if (!strcasecmp(var, "newmovedalternative"))
> +		return DIFF_FILE_NEW_MOVED_ALT;
>  	return -1;
>  }
>  
> @@ -234,6 +247,10 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
>  		diff_use_color_default = git_config_colorbool(var, value);
>  		return 0;
>  	}
> +	if (!strcmp(var, "color.moved")) {
> +		diff_color_moved_default = git_config_bool(var, value);
> +		return 0;
> +	}
>  	if (!strcmp(var, "diff.context")) {
>  		diff_context_default = git_config_int(var, value);
>  		if (diff_context_default < 0)
> @@ -354,6 +371,81 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
>  	return git_default_config(var, value, cb);
>  }
>  
> +struct moved_entry {
> +	struct hashmap_entry ent;
> +	const struct buffered_patch_line *line;
> +	struct moved_entry *next_line;
> +};
> +
> +static void get_ws_cleaned_string(const struct buffered_patch_line *l,
> +				  struct strbuf *out)
> +{
> +	int i;
> +	for (i = 0; i < l->len; i++) {
> +		if (isspace(l->line[i]))
> +			continue;
> +		strbuf_addch(out, l->line[i]);
> +	}
> +}
> +
> +static int buffered_patch_line_cmp_no_ws(const struct buffered_patch_line *a,
> +					 const struct buffered_patch_line *b,
> +					 const void *keydata)
> +{
> +	struct strbuf sba = STRBUF_INIT;
> +	struct strbuf sbb = STRBUF_INIT;
> +	get_ws_cleaned_string(a, &sba);
> +	get_ws_cleaned_string(b, &sbb);
> +	return sba.len != sbb.len || strncmp(sba.buf, sbb.buf, sba.len);

You have a memory leak here, the strbufs need to be released before
returning.  Also this seems very computationally heavy in that you would
need to reconstruct a string every time you perform this comparison.
Maybe that's ok because the alternative (storing the string w/o
whitespace would be too memory intensive).

> +}
> +
> +static int buffered_patch_line_cmp(const struct buffered_patch_line *a,
> +				   const struct buffered_patch_line *b,
> +				   const void *keydata)
> +{
> +	return a->len != b->len || strncmp(a->line, b->line, a->len);
> +}
> +
> +static int moved_entry_cmp(const struct moved_entry *a,
> +			   const struct moved_entry *b,
> +			   const void *keydata)
> +{
> +	return buffered_patch_line_cmp(a->line, b->line, keydata);
> +}
> +
> +static int moved_entry_cmp_no_ws(const struct moved_entry *a,
> +				 const struct moved_entry *b,
> +				 const void *keydata)
> +{
> +	return buffered_patch_line_cmp_no_ws(a->line, b->line, keydata);
> +}
> +
> +static unsigned get_line_hash(struct buffered_patch_line *line, unsigned ignore_ws)
> +{
> +	static struct strbuf sb = STRBUF_INIT;
> +
> +	if (ignore_ws) {
> +		strbuf_reset(&sb);
> +		get_ws_cleaned_string(line, &sb);
> +		return memhash(sb.buf, sb.len);
> +	} else
> +		return memhash(line->line, line->len);

nit: braces on the else block.
I know other may not agree but I will still point it out when its
mismatched with a block with braces.

> +}
> +
> +static struct moved_entry *prepare_entry(struct diff_options *o,
> +					 int line_no)
> +{
> +	struct moved_entry *ret = xmalloc(sizeof(*ret));
> +	unsigned ignore_ws = DIFF_XDL_TST(o, IGNORE_WHITESPACE);
> +	struct buffered_patch_line *l = &o->line_buffer[line_no];
> +
> +	ret->ent.hash = get_line_hash(l, ignore_ws);
> +	ret->line = l;
> +	ret->next_line = NULL;
> +
> +	return ret;
> +}
> +
>  static char *quote_two(const char *one, const char *two)
>  {
>  	int need_one = quote_c_style(one, NULL, NULL, 1);
> @@ -516,8 +608,98 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
>  	ecbdata->blank_at_eof_in_postimage = (at - l2) + 1;
>  }
>  
> +static void mark_color_as_moved(struct diff_options *o, int line_no)
> +{
> +	struct hashmap *hm = NULL;
> +	struct moved_entry *key = prepare_entry(o, line_no);
> +	struct moved_entry *match = NULL;
> +	struct buffered_patch_line *l = &o->line_buffer[line_no];
> +	int alt_flag;
> +	int i, lp, rp;
> +
> +	switch (l->sign) {
> +	case '+':
> +		hm = o->deleted_lines;
> +		break;
> +	case '-':
> +		hm = o->added_lines;
> +		break;
> +	default:
> +		/* reset to standard, on-alt move color */
> +		o->color_moved = 1;
> +		break;
> +	}
> +
> +	/* Check for any match to color it as a move. */
> +	if (!hm)
> +		return;
> +	match = hashmap_get(hm, key, o);
> +	free(key);

memory leak? if (!hm), then 'key' is never freed.

> +	if (!match)
> +		return;
> +
> +	/* Check any potential block runs, advance each or nullify */
> +	for (i = 0; i < o->pmb_nr; i++) {
> +		struct moved_entry *p = o->pmb[i];
> +		if (p && p->next_line &&
> +		    !buffered_patch_line_cmp(p->next_line->line, l, o)) {
> +			o->pmb[i] = p->next_line;
> +		} else {
> +			o->pmb[i] = NULL;
> +		}
> +	}
> +
> +	/* Shrink the set to the remaining runs */
> +	for (lp = 0, rp = o->pmb_nr - 1; lp <= rp;) {
> +		while (lp < o->pmb_nr && o->pmb[lp])
> +			lp ++;
> +		/* lp points at the first NULL now */
> +
> +		while (rp > -1 && !o->pmb[rp])
> +			rp--;
> +		/* rp points at the last non-NULL */
> +
> +		if (lp < o->pmb_nr && rp > -1 && lp < rp) {
> +			o->pmb[lp] = o->pmb[rp];
> +			o->pmb[rp] = NULL;
> +			rp--;
> +			lp++;
> +		}
> +	}
> +
> +	if (rp > -1) {
> +		/* Remember the number of running sets */
> +		o->pmb_nr = rp + 1;
> +	} else {
> +		/* Toggle color */
> +		o->color_moved = o->color_moved == 2 ? 1 : 2;
> +
> +		/* Build up a new set */
> +		i = 0;
> +		for (; match; match = hashmap_get_next(hm, match)) {
> +			ALLOC_GROW(o->pmb, i + 1, o->pmb_alloc);
> +			o->pmb[i] = match;
> +			i++;
> +		}
> +		o->pmb_nr = i;

why not just use o->pmb_nr directly instead of using 'i'?  I was
immediately concerned when 'i' was used in the ALLOC_GROW macro.

> +	}
> +
> +	alt_flag = o->color_moved - 1;
> +	switch (l->sign) {
> +	case '+':
> +		l->set = diff_get_color_opt(o, DIFF_FILE_NEW_MOVED + alt_flag);
> +		break;
> +	case '-':
> +		l->set = diff_get_color_opt(o, DIFF_FILE_OLD_MOVED + alt_flag);
> +		break;
> +	default:
> +		; /* nothing */
> +	}
> +}
> +
>  static void emit_buffered_patch_line(struct diff_options *o,
> -				     struct buffered_patch_line *e)
> +				     struct buffered_patch_line *e,
> +				     int pass)
>  {
>  	int has_trailing_newline, has_trailing_carriage_return, len = e->len;
>  	FILE *file = o->file;
> @@ -548,11 +730,11 @@ static void emit_buffered_patch_line(struct diff_options *o,
>  
>  static void emit_buffered_patch_line_ws(struct diff_options *o,
>  					struct buffered_patch_line *e,
> -					const char *ws, unsigned ws_rule)
> +					const char *ws, unsigned ws_rule,
> +					int pass)
>  {
>  	struct buffered_patch_line s = {e->set, e->reset, "", 0, e->sign};
> -
> -	emit_buffered_patch_line(o, &s);
> +	emit_buffered_patch_line(o, &s, 0);
>  	ws_check_emit(e->line, e->len, ws_rule,
>  		      o->file, e->set, e->reset, ws);
>  }
> @@ -564,12 +746,14 @@ static void process_next_buffered_patch_line(struct diff_options *o, int line_no
>  	const char *ws = o->current_filepair->ws;
>  	unsigned ws_rule = o->current_filepair->ws_rule;
>  
> +	mark_color_as_moved(o, line_no);
> +
>  	switch (e->state) {
>  		case BPL_EMIT_LINE_ASIS:
> -			emit_buffered_patch_line(o, e);
> +			emit_buffered_patch_line(o, e, 1);
>  			break;
>  		case BPL_EMIT_LINE_WS:
> -			emit_buffered_patch_line_ws(o, e, ws, ws_rule);
> +			emit_buffered_patch_line_ws(o, e, ws, ws_rule, 1);
>  			break;
>  		case BPL_HANDOVER:
>  			o->current_filepair++;
> @@ -602,7 +786,7 @@ static void emit_line_0(struct diff_options *o,
>  	if (o->use_buffer)
>  		append_buffered_patch_line(o, &e);
>  	else
> -		emit_buffered_patch_line(o, &e);
> +		emit_buffered_patch_line(o, &e, 0);
>  }
>  
>  void emit_line(struct diff_options *o, const char *set, const char *reset,
> @@ -621,7 +805,7 @@ static void emit_line_ws(struct diff_options *o,
>  	if (o->use_buffer)
>  		append_buffered_patch_line(o, &e);
>  	else
> -		emit_buffered_patch_line_ws(o, &e, ws, ws_rule);
> +		emit_buffered_patch_line_ws(o, &e, ws, ws_rule, 0);
>  }
>  
>  void emit_line_fmt(struct diff_options *o,
> @@ -676,6 +860,36 @@ static void emit_line_checked(const char *reset,
>  			     ws, ecbdata->ws_rule);
>  }
>  
> +static void add_line_to_move_detection(struct diff_options *o, int line_idx)
> +{
> +	int sign = 0;
> +	struct hashmap *hm;
> +	struct moved_entry *key;
> +
> +	switch (o->line_buffer[line_idx].sign) {
> +	case '+':
> +		sign = '+';
> +		hm = o->added_lines;
> +		break;
> +	case '-':
> +		sign = '-';
> +		hm = o->deleted_lines;
> +		break;
> +	case ' ':
> +	default:
> +		o->prev_line = NULL;
> +		return;
> +	}
> +
> +	key = prepare_entry(o, line_idx);
> +	if (o->prev_line &&
> +	    o->prev_line->line->sign == sign)
> +		o->prev_line->next_line = key;
> +
> +	hashmap_add(hm, key);
> +	o->prev_line = key;

'key' was freed in another function, does it need to be freed here?

> +}
> +
>  static void emit_add_line(const char *reset,
>  			  struct emit_callback *ecbdata,
>  			  const char *line, int len)
> @@ -3649,6 +3863,9 @@ void diff_setup_done(struct diff_options *options)
>  
>  	if (DIFF_OPT_TST(options, FOLLOW_RENAMES) && options->pathspec.nr != 1)
>  		die(_("--follow requires exactly one pathspec"));
> +
> +	if (!options->use_color || external_diff())
> +		options->color_moved = 0;
>  }
>  
>  static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *val)
> @@ -4073,6 +4290,10 @@ int diff_opt_parse(struct diff_options *options,
>  	}
>  	else if (!strcmp(arg, "--no-color"))
>  		options->use_color = 0;
> +	else if (!strcmp(arg, "--color-moved"))
> +		options->color_moved = 1;
> +	else if (!strcmp(arg, "--no-color-moved"))
> +		options->color_moved = 0;
>  	else if (!strcmp(arg, "--color-words")) {
>  		options->use_color = 1;
>  		options->word_diff = DIFF_WORDS_COLOR;
> @@ -4878,16 +5099,19 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
>  {
>  	int i;
>  	struct diff_queue_struct *q = &diff_queued_diff;
> -	/*
> -	 * For testing purposes we want to make sure the diff machinery
> -	 * works completely with the buffer. If there is anything emitted
> -	 * outside the emit_buffered_patch_line, then the order is screwed
> -	 * up and the tests will fail.
> -	 *
> -	 * TODO (later in this series):
> -	 * We'll unset this flag in a later patch.
> -	 */
> -	o->use_buffer = 1;
> +
> +	if (o->color_moved) {
> +		unsigned ignore_ws = DIFF_XDL_TST(o, IGNORE_WHITESPACE);
> +		o->use_buffer = 1;
> +		o->deleted_lines = xmallocz(sizeof(*o->deleted_lines));
> +		o->added_lines = xmallocz(sizeof(*o->added_lines));
> +		hashmap_init(o->deleted_lines, ignore_ws ?
> +			(hashmap_cmp_fn)moved_entry_cmp_no_ws :
> +			(hashmap_cmp_fn)moved_entry_cmp, 0);
> +		hashmap_init(o->added_lines, ignore_ws ?
> +			(hashmap_cmp_fn)moved_entry_cmp_no_ws :
> +			(hashmap_cmp_fn)moved_entry_cmp, 0);
> +	}
>  
>  	if (o->use_buffer) {
>  		ALLOC_GROW(o->filepair_buffer,
> @@ -4902,6 +5126,10 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
>  	}
>  
>  	if (o->use_buffer) {
> +		o->current_filepair = &o->filepair_buffer[0];
> +		for (i = 0; i < o->line_buffer_nr; i++)
> +			add_line_to_move_detection(o, i);
> +
>  		o->current_filepair = &o->filepair_buffer[0];
>  		for (i = 0; i < o->line_buffer_nr; i++)
>  			process_next_buffered_patch_line(o, i);
> @@ -4992,6 +5220,7 @@ void diff_flush(struct diff_options *options)
>  		if (!options->file)
>  			die_errno("Could not open /dev/null");
>  		options->close_file = 1;
> +		options->color_moved = 0;
>  		for (i = 0; i < q->nr; i++) {
>  			struct diff_filepair *p = q->queue[i];
>  			if (check_pair_status(p))
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
>  	unsigned ws_rule;
>  };
>  
> +struct moved_entry;
> +
>  struct diff_options {
>  	const char *orderfile;
>  	const char *pickaxe;
> @@ -217,6 +220,8 @@ struct diff_options {
>  
>  	int diff_path_counter;
>  
> +	/* Determines color moved code. Flipped between 1, 2 for alt. color. */
> +	int color_moved;
>  	int use_buffer;
>  
>  	struct buffered_patch_line *line_buffer;
> @@ -225,6 +230,16 @@ struct diff_options {
>  	struct buffered_filepair *filepair_buffer;
>  	int filepair_buffer_nr, filepair_buffer_alloc;
>  	struct buffered_filepair *current_filepair;
> +
> +	/* built up in the first pass: */
> +	struct hashmap *deleted_lines;
> +	struct hashmap *added_lines;
> +	/* needed for building up */
> +	struct moved_entry *prev_line;
> +
> +	/* state in the second pass */
> +	struct moved_entry **pmb; /* potentially moved blocks */
> +	int pmb_nr, pmb_alloc;
>  };
>  
>  void emit_line_fmt(struct diff_options *o, const char *set, const char *reset,
> @@ -241,7 +256,11 @@ enum color_diff {
>  	DIFF_FILE_NEW = 5,
>  	DIFF_COMMIT = 6,
>  	DIFF_WHITESPACE = 7,
> -	DIFF_FUNCINFO = 8
> +	DIFF_FUNCINFO = 8,
> +	DIFF_FILE_OLD_MOVED = 9,
> +	DIFF_FILE_OLD_MOVED_ALT = 10,
> +	DIFF_FILE_NEW_MOVED = 11,
> +	DIFF_FILE_NEW_MOVED_ALT = 12
>  };
>  const char *diff_get_color(int diff_use_color, enum color_diff ix);
>  #define diff_get_color_opt(o, ix) \
> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
> index 289806d0c7..232d9ad55e 100755
> --- a/t/t4015-diff-whitespace.sh
> +++ b/t/t4015-diff-whitespace.sh
> @@ -972,4 +972,233 @@ test_expect_success 'option overrides diff.wsErrorHighlight' '
>  
>  '
>  
> +test_expect_success 'detect moved code, complete file' '
> +	git reset --hard &&
> +	cat <<-\EOF >test.c &&
> +	#include<stdio.h>
> +	main()
> +	{
> +	printf("Hello World");
> +	}
> +	EOF
> +	git add test.c &&
> +	git commit -m "add main function" &&
> +	git mv test.c main.c &&
> +	git diff HEAD --color-moved --no-renames | test_decode_color >actual &&
> +	cat >expected <<-\EOF &&
> +	<BOLD>diff --git a/main.c b/main.c<RESET>
> +	<BOLD>new file mode 100644<RESET>
> +	<BOLD>index 0000000..a986c57<RESET>
> +	<BOLD>--- /dev/null<RESET>
> +	<BOLD>+++ b/main.c<RESET>
> +	<CYAN>@@ -0,0 +1,5 @@<RESET>
> +	<BGREEN>+<RESET><BGREEN>#include<stdio.h><RESET>
> +	<BGREEN>+<RESET><BGREEN>main()<RESET>
> +	<BGREEN>+<RESET><BGREEN>{<RESET>
> +	<BGREEN>+<RESET><BGREEN>printf("Hello World");<RESET>
> +	<BGREEN>+<RESET><BGREEN>}<RESET>
> +	<BOLD>diff --git a/test.c b/test.c<RESET>
> +	<BOLD>deleted file mode 100644<RESET>
> +	<BOLD>index a986c57..0000000<RESET>
> +	<BOLD>--- a/test.c<RESET>
> +	<BOLD>+++ /dev/null<RESET>
> +	<CYAN>@@ -1,5 +0,0 @@<RESET>
> +	<BRED>-#include<stdio.h><RESET>
> +	<BRED>-main()<RESET>
> +	<BRED>-{<RESET>
> +	<BRED>-printf("Hello World");<RESET>
> +	<BRED>-}<RESET>
> +	EOF
> +
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'detect moved code, inside file' '
> +	git reset --hard &&
> +	cat <<-\EOF >main.c &&
> +		#include<stdio.h>
> +		int stuff()
> +		{
> +			printf("Hello ");
> +			printf("World\n");
> +		}
> +
> +		int secure_foo(struct user *u)
> +		{
> +			if (!u->is_allowed_foo)
> +				return;
> +			foo(u);
> +		}
> +
> +		int main()
> +		{
> +			foo();
> +		}
> +	EOF
> +	cat <<-\EOF >test.c &&
> +		#include<stdio.h>
> +		int bar()
> +		{
> +			printf("Hello World, but different\n");
> +		}
> +
> +		int another_function()
> +		{
> +			bar();
> +		}
> +	EOF
> +	git add main.c test.c &&
> +	git commit -m "add main and test file" &&
> +	cat <<-\EOF >main.c &&
> +		#include<stdio.h>
> +		int stuff()
> +		{
> +			printf("Hello ");
> +			printf("World\n");
> +		}
> +
> +		int main()
> +		{
> +			foo();
> +		}
> +	EOF
> +	cat <<-\EOF >test.c &&
> +		#include<stdio.h>
> +		int bar()
> +		{
> +			printf("Hello World, but different\n");
> +		}
> +
> +		int secure_foo(struct user *u)
> +		{
> +			if (!u->is_allowed_foo)
> +				return;
> +			foo(u);
> +		}
> +
> +		int another_function()
> +		{
> +			bar();
> +		}
> +	EOF
> +	git diff HEAD --no-renames --color-moved| test_decode_color >actual &&
> +	cat <<-\EOF >expected &&
> +	<BOLD>diff --git a/main.c b/main.c<RESET>
> +	<BOLD>index 27a619c..7cf9336 100644<RESET>
> +	<BOLD>--- a/main.c<RESET>
> +	<BOLD>+++ b/main.c<RESET>
> +	<CYAN>@@ -5,13 +5,6 @@<RESET> <RESET>printf("Hello ");<RESET>
> +	 printf("World\n");<RESET>
> +	 }<RESET>
> +	 <RESET>
> +	<BRED>-int secure_foo(struct user *u)<RESET>
> +	<BRED>-{<RESET>
> +	<BRED>-if (!u->is_allowed_foo)<RESET>
> +	<BRED>-return;<RESET>
> +	<BRED>-foo(u);<RESET>
> +	<BRED>-}<RESET>
> +	<BRED>-<RESET>
> +	 int main()<RESET>
> +	 {<RESET>
> +	 foo();<RESET>
> +	<BOLD>diff --git a/test.c b/test.c<RESET>
> +	<BOLD>index 1dc1d85..e34eb69 100644<RESET>
> +	<BOLD>--- a/test.c<RESET>
> +	<BOLD>+++ b/test.c<RESET>
> +	<CYAN>@@ -4,6 +4,13 @@<RESET> <RESET>int bar()<RESET>
> +	 printf("Hello World, but different\n");<RESET>
> +	 }<RESET>
> +	 <RESET>
> +	<BGREEN>+<RESET><BGREEN>int secure_foo(struct user *u)<RESET>
> +	<BGREEN>+<RESET><BGREEN>{<RESET>
> +	<BGREEN>+<RESET><BGREEN>if (!u->is_allowed_foo)<RESET>
> +	<BGREEN>+<RESET><BGREEN>return;<RESET>
> +	<BGREEN>+<RESET><BGREEN>foo(u);<RESET>
> +	<BGREEN>+<RESET><BGREEN>}<RESET>
> +	<BGREEN>+<RESET>
> +	 int another_function()<RESET>
> +	 {<RESET>
> +	 bar();<RESET>
> +	EOF
> +
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'detect permutations inside moved code, ' '
> +	# reusing the move example from last test:
> +	cat <<-\EOF >main.c &&
> +		#include<stdio.h>
> +		int stuff()
> +		{
> +			printf("Hello ");
> +			printf("World\n");
> +		}
> +
> +		int main()
> +		{
> +			foo();
> +		}
> +	EOF
> +	cat <<-\EOF >test.c &&
> +		#include<stdio.h>
> +		int bar()
> +		{
> +			printf("Hello World, but different\n");
> +		}
> +
> +		int secure_foo(struct user *u)
> +		{
> +			foo(u);
> +			if (!u->is_allowed_foo)
> +				return;
> +		}
> +
> +		int another_function()
> +		{
> +			bar();
> +		}
> +	EOF
> +	git diff HEAD --no-renames --color-moved| test_decode_color >actual &&
> +	cat <<-\EOF >expected &&
> +	<BOLD>diff --git a/main.c b/main.c<RESET>
> +	<BOLD>index 27a619c..7cf9336 100644<RESET>
> +	<BOLD>--- a/main.c<RESET>
> +	<BOLD>+++ b/main.c<RESET>
> +	<CYAN>@@ -5,13 +5,6 @@<RESET> <RESET>printf("Hello ");<RESET>
> +	 printf("World\n");<RESET>
> +	 }<RESET>
> +	 <RESET>
> +	<BRED>-int secure_foo(struct user *u)<RESET>
> +	<BRED>-{<RESET>
> +	<BOLD;RED>-if (!u->is_allowed_foo)<RESET>
> +	<BOLD;RED>-return;<RESET>
> +	<BRED>-foo(u);<RESET>
> +	<BOLD;RED>-}<RESET>
> +	<BOLD;RED>-<RESET>
> +	 int main()<RESET>
> +	 {<RESET>
> +	 foo();<RESET>
> +	<BOLD>diff --git a/test.c b/test.c<RESET>
> +	<BOLD>index 1dc1d85..2bedec9 100644<RESET>
> +	<BOLD>--- a/test.c<RESET>
> +	<BOLD>+++ b/test.c<RESET>
> +	<CYAN>@@ -4,6 +4,13 @@<RESET> <RESET>int bar()<RESET>
> +	 printf("Hello World, but different\n");<RESET>
> +	 }<RESET>
> +	 <RESET>
> +	<BGREEN>+<RESET><BGREEN>int secure_foo(struct user *u)<RESET>
> +	<BGREEN>+<RESET><BGREEN>{<RESET>
> +	<BOLD;GREEN>+<RESET><BOLD;GREEN>foo(u);<RESET>
> +	<BGREEN>+<RESET><BGREEN>if (!u->is_allowed_foo)<RESET>
> +	<BGREEN>+<RESET><BGREEN>return;<RESET>
> +	<BOLD;GREEN>+<RESET><BOLD;GREEN>}<RESET>
> +	<BOLD;GREEN>+<RESET>
> +	 int another_function()<RESET>
> +	 {<RESET>
> +	 bar();<RESET>
> +	EOF
> +
> +	test_cmp expected actual
> +'
> +
>  test_done
> -- 
> 2.13.0.18.g183880de0a
> 

-- 
Brandon Williams

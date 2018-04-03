Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BFFB1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 16:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752320AbeDCQ2T (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 12:28:19 -0400
Received: from mout.gmx.net ([212.227.15.15]:52987 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751488AbeDCQ2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 12:28:16 -0400
Received: from MININT-AIVCFQ2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LwJRe-1eSSV10TEc-0181g7; Tue, 03 Apr 2018 18:27:57 +0200
Date:   Tue, 3 Apr 2018 18:27:55 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 00/15] Assorted fixes for `git config` (including the
 "empty sections" bug)
In-Reply-To: <cover.1522336130.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1522772789.git.johannes.schindelin@gmx.de>
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:J2etuJJ5JSdwpoEuDFc/DTvDnLx9IMNQRBWiOk/1yALSItPkMEd
 gnr/zYQvYvjXe3wzAaLotqLwVht2ijmLYH1elRBKi+GF9QCzA9Tk7pIHMe+/Y2Qqxw2Bfyp
 xn6HjxRa1cCOhhE3NFsfI7sNMfufPsm2XrL2SblB6zpbX72YM/cDvuN1FOiW5hwPsQ/WSEk
 4CQXEqM2PVV8R/l4+gesQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:h6yl9LtqFXM=:nwwnXnrZB/6voAXx/ZQ4HF
 mupjIB7pGJVU8exzbb4qkx1r4jiwTuLbg1hVEEj64qmu6rJ4GU+tpwM0pVJYBP8HCgZG3LyWN
 b8miRaSdCz7hcxjd/1THpRwT8qWbTMrwBozJyPv2UcpBwIwVSnoYN45STqCgSO4/nYgtcTlGK
 xxnJpJ0XRBnGNKWRwI5dIbPA3B3qkJFQkUvzc8VLeXq89uLQy6YvKjqmQgBRVpHeAJgB2hU6c
 XzPLtKARCgLO72r2GUYvvE5iM5mhnbLLdpKdLNUsdcZyVu51sQCPmWAvpTGafCA9g7Q64DKII
 iRqcM2iLv16qaXUYVLNYcApWOf0MgU4oFP4nF2d+QcgUU2P4mfg5MXTP3LTUWZLf5VFM0vJuc
 KotvYF/+ZR7Fp/5V9r+PiVEcchZuVJLLd1sVweCW+3/hSyeKYDvQrGyWSR3sBR/CVW5tBzMVx
 dhux+3pOae3ySVbBP5pjSWVrnaDl2v2w9e2EazeU4xjufKy3JYMWbjV+b9yZXYjK3fmcURmh7
 F5AXA5OiveCUA3o6wZWxApWPOJDknwj4Wklxxh2M8o/LECd2Oi8zMjRv5P7Nku/HmWQqnbXcm
 w8idefspnlkYhit0L6SlNNsUe+h6VfFkcKGQ4EZ0X+56orElLXBPWyiWVld7qwJ0pzTf0Jr1y
 y/Evz4nwTFpqYuc58BALojyIhYmbhPK0tNw9M2uBllS4NUhnro1Ulp5uW19YHrgBtKmxfmYk2
 fJ0HGKV4Qa77th6eK/ce8rFPur3wql5gUP0ux1hM48j75JwZN738/MQDgbAeYxnC6L+zAQPLV
 91F4w2Ro6SzjLu2rKxqImRkurfrkjafmY8oITqmSZ7+BLHI6lMo//OG9aAkevsg9ku9M1vN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series originally only tried to help fixing that annoying bug that
has been reported several times over the years, where `git config --unset`
would leave empty sections behind, and `git config --add` would not reuse them.

The first patch is somewhat of a "while at it" bug fix that I first thought
would be a lot more critical than it actually is: It really only affects config
files that start with a section followed immediately (i.e. without a newline)
by a one-letter boolean setting (i.e. without a `= <value>` part). So while it
is a real bug fix, I doubt anybody ever got bitten by it.

The next swath of patches add and fix some tests, while also fixing the bug
where --replace-all would sometimes insert extra line breaks.

These fixes are pretty straight-forward, and I always try to keep my added
tests as concise as possible, so please tell me if you find a way to make them
smaller (without giving up readability and debuggability).

Then, I introduce a couple of building blocks: a "config parser event stream",
i.e. an optional callback that can be used to report events such as "comment", "white-space", etc together with the corresponding extents in the config file.

Finally, the interesting part, where I do two things, essentially (with
preparatory steps for each thing):

1. I add the ability for `git config --unset/--unset-all` to detect that it
   can remove a section that has just become empty (see below for some more
   discussion of what I consider "become empty"), and

2. I add the ability for `git config [--add] key value` to re-use empty
   sections.

I am very, very grateful for the time Peff spent on reviewing the previous
iteration, and hope that he realizes just how much the elegance of the
event-stream-based version is due to his excellent review.

To reiterate why does this patch series not conflict with my very early
statements that we cannot simply remove empty sections because we may end up
with stale comments?

Well, the patch in question takes pains to determine *iff* there are any
comments surrounding, or included in, the section. If any are found: previous
behavior. Under the assumption that the user edited the file, we keep it as
intact as possible (see below for some argument against this). If no comments
are found, and let's face it, this is probably *the* common case, as few people
edit their config files by hand these days (neither should they because it is
too easy to end up with an unparseable one), the now-empty section *is*
removed.

So what is the argument against this extra care to detect comments? Well, if
you have something like this:

	[section]
		; Here we comment about the variable called snarf
		snarf = froop

and we run `git config --unset section.snarf`, we end up with this config:

	[section]
		; Here we comment about the variable called snarf

which obviously does not make sense. However, that is already established
behavior for quite a few years, and I do not even try to think of a way how
this could be solved.

Changes since v1:

- a new feature was introduced where the config parser can be asked to report
  all "events" (like, section header or comment) via a callback function.

- the patches to reuse empty sections, and to remove sections that just became
  empty (without any surrounding comments) were rewritten to make use of that
  config parser event stream (incidentally fixing a couple of problems with
  the backtracking version which were pointed out by Peff).

- to make those changes easier to review, they have been split up into several
  tiny logical steps: the file-local `store` was replaced with callback data,
  some fields were renamed for consistency, the state machine when parsing the
  config was replaced by easier-to-understand flags, etc.

- while pouring over the code, I managed to find another obscure bug: under
  certain circumstances, --replace-all could produce extra new-lines. This is
  now fixed as part of the preparatory patches.


Johannes Schindelin (15):
  git_config_set: fix off-by-two
  t1300: rename it to reflect that `repo-config` was deprecated
  t1300: demonstrate that --replace-all can "invent" newlines
  config --replace-all: avoid extra line breaks
  t1300: avoid relying on a bug
  t1300: remove unreasonable expectation from TODO
  t1300: `--unset-all` can leave an empty section behind (bug)
  config: introduce an optional event stream while parsing
  config: avoid using the global variable `store`
  config_set_store: rename some fields for consistency
  git_config_set: do not use a state machine
  git_config_set: make use of the config parser's event stream
  git config --unset: remove empty sections (in the common case)
  git_config_set: reuse empty sections
  TODOs

 config.c                                    | 449 ++++++++++++++++++++--------
 config.h                                    |  25 ++
 t/{t1300-repo-config.sh => t1300-config.sh} |  57 +++-
 3 files changed, 396 insertions(+), 135 deletions(-)
 rename t/{t1300-repo-config.sh => t1300-config.sh} (97%)


base-commit: 468165c1d8a442994a825f3684528361727cd8c0
Published-As: https://github.com/dscho/git/releases/tag/empty-config-section-v2
Fetch-It-Via: git fetch https://github.com/dscho/git empty-config-section-v2

Interdiff vs v1 (sorry for the size, it is essentially a rewrite of more
than half of the previous iteration):
 diff --git a/config.c b/config.c
 index b04c40f76bc..ee7ea24123d 100644
 --- a/config.c
 +++ b/config.c
 @@ -653,21 +653,65 @@ static int get_base_var(struct strbuf *name)
  	}
  }
  
 +struct parse_event_data {
 +	enum config_event_t previous_type;
 +	size_t previous_offset;
 +	const struct config_options *opts;
 +};
 +
 +static inline int do_event(enum config_event_t type,
 +			   struct parse_event_data *data)
 +{
 +	size_t offset;
 +
 +	if (!data->opts || !data->opts->event_fn)
 +		return 0;
 +
 +	if (type == CONFIG_EVENT_WHITESPACE &&
 +	    data->previous_type == type)
 +		return 0;
 +
 +	offset = cf->do_ftell(cf);
 +	/*
 +	 * At EOF, the parser always "inserts" an extra '\n', therefore
 +	 * the end offset of the event is the current file position, otherwise
 +	 * we will already have advanced to the next event.
 +	 */
 +	if (type != CONFIG_EVENT_EOF)
 +		offset--;
 +
 +	if (data->previous_type != CONFIG_EVENT_EOF &&
 +	    data->opts->event_fn(data->previous_type, data->previous_offset,
 +				 offset, data->opts->event_fn_data) < 0)
 +		return -1;
 +
 +	data->previous_type = type;
 +	data->previous_offset = offset;
 +
 +	return 0;
 +}
 +
  static int git_parse_source(config_fn_t fn, void *data,
 -			    int include_section_headers)
 +			    const struct config_options *opts)
  {
  	int comment = 0;
  	int baselen = 0;
  	struct strbuf *var = &cf->var;
  	int error_return = 0;
  	char *error_msg = NULL;
 -	int saw_section_header = 0;
  
  	/* U+FEFF Byte Order Mark in UTF8 */
  	const char *bomptr = utf8_bom;
  
 +	/* For the parser event callback */
 +	struct parse_event_data event_data = {
 +		CONFIG_EVENT_EOF, 0, opts
 +	};
 +
  	for (;;) {
 -		int c = get_next_char();
 +		int c;
 +
 +		c = get_next_char();
  		if (bomptr && *bomptr) {
  			/* We are at the file beginning; skip UTF8-encoded BOM
  			 * if present. Sane editors won't put this in on their
 @@ -684,39 +728,47 @@ static int git_parse_source(config_fn_t fn, void *data,
  			}
  		}
  		if (c == '\n') {
 -			if (cf->eof)
 +			if (cf->eof) {
 +				if (do_event(CONFIG_EVENT_EOF, &event_data) < 0)
 +					return -1;
  				return 0;
 -			comment = 0;
 -			if (saw_section_header) {
 -				if (include_section_headers) {
 -					cf->linenr--;
 -					error_return = fn(var->buf, NULL, data);
 -					if (error_return < 0)
 -						break;
 -					cf->linenr++;
 -				}
 -				saw_section_header = 0;
  			}
 +			if (do_event(CONFIG_EVENT_WHITESPACE, &event_data) < 0)
 +				return -1;
 +			comment = 0;
  			continue;
  		}
 -		if (comment || isspace(c))
 +		if (comment)
  			continue;
 +		if (isspace(c)) {
 +			if (do_event(CONFIG_EVENT_WHITESPACE, &event_data) < 0)
 +					return -1;
 +			continue;
 +		}
  		if (c == '#' || c == ';') {
 +			if (do_event(CONFIG_EVENT_COMMENT, &event_data) < 0)
 +					return -1;
  			comment = 1;
  			continue;
  		}
  		if (c == '[') {
 +			if (do_event(CONFIG_EVENT_SECTION, &event_data) < 0)
 +					return -1;
 +
  			/* Reset prior to determining a new stem */
  			strbuf_reset(var);
  			if (get_base_var(var) < 0 || var->len < 1)
  				break;
  			strbuf_addch(var, '.');
  			baselen = var->len;
 -			saw_section_header = 1;
  			continue;
  		}
  		if (!isalpha(c))
  			break;
 +
 +		if (do_event(CONFIG_EVENT_ENTRY, &event_data) < 0)
 +			return -1;
 +
  		/*
  		 * Truncate the var name back to the section header
  		 * stem prior to grabbing the suffix part of the name
 @@ -728,6 +780,9 @@ static int git_parse_source(config_fn_t fn, void *data,
  			break;
  	}
  
 +	if (do_event(CONFIG_EVENT_ERROR, &event_data) < 0)
 +		return -1;
 +
  	switch (cf->origin_type) {
  	case CONFIG_ORIGIN_BLOB:
  		error_msg = xstrfmt(_("bad config line %d in blob %s"),
 @@ -1412,7 +1467,7 @@ int git_default_config(const char *var, const char *value, void *dummy)
   * this function.
   */
  static int do_config_from(struct config_source *top, config_fn_t fn, void *data,
 -			  int include_section_headers)
 +			  const struct config_options *opts)
  {
  	int ret;
  
 @@ -1424,7 +1479,7 @@ static int do_config_from(struct config_source *top, config_fn_t fn, void *data,
  	strbuf_init(&top->var, 1024);
  	cf = top;
  
 -	ret = git_parse_source(fn, data, include_section_headers);
 +	ret = git_parse_source(fn, data, opts);
  
  	/* pop config-file parsing state stack */
  	strbuf_release(&top->value);
 @@ -1437,7 +1492,7 @@ static int do_config_from(struct config_source *top, config_fn_t fn, void *data,
  static int do_config_from_file(config_fn_t fn,
  		const enum config_origin_type origin_type,
  		const char *name, const char *path, FILE *f,
 -		void *data, int include_section_headers)
 +		void *data, const struct config_options *opts)
  {
  	struct config_source top;
  
 @@ -1450,15 +1505,18 @@ static int do_config_from_file(config_fn_t fn,
  	top.do_ungetc = config_file_ungetc;
  	top.do_ftell = config_file_ftell;
  
 -	return do_config_from(&top, fn, data, include_section_headers);
 +	return do_config_from(&top, fn, data, opts);
  }
  
  static int git_config_from_stdin(config_fn_t fn, void *data)
  {
 -	return do_config_from_file(fn, CONFIG_ORIGIN_STDIN, "", NULL, stdin, data, 0);
 +	return do_config_from_file(fn, CONFIG_ORIGIN_STDIN, "", NULL, stdin,
 +				   data, NULL);
  }
  
 -int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 +int git_config_from_file_with_options(config_fn_t fn, const char *filename,
 +				      void *data,
 +				      const struct config_options *opts)
  {
  	int ret = -1;
  	FILE *f;
 @@ -1466,13 +1524,19 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
  	f = fopen_or_warn(filename, "r");
  	if (f) {
  		flockfile(f);
 -		ret = do_config_from_file(fn, CONFIG_ORIGIN_FILE, filename, filename, f, data, 0);
 +		ret = do_config_from_file(fn, CONFIG_ORIGIN_FILE, filename,
 +					  filename, f, data, opts);
  		funlockfile(f);
  		fclose(f);
  	}
  	return ret;
  }
  
 +int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 +{
 +	return git_config_from_file_with_options(fn, filename, data, NULL);
 +}
 +
  int git_config_from_mem(config_fn_t fn, const enum config_origin_type origin_type,
  			const char *name, const char *buf, size_t len, void *data)
  {
 @@ -1489,7 +1553,7 @@ int git_config_from_mem(config_fn_t fn, const enum config_origin_type origin_typ
  	top.do_ungetc = config_buf_ungetc;
  	top.do_ftell = config_buf_ftell;
  
 -	return do_config_from(&top, fn, data, 0);
 +	return do_config_from(&top, fn, data, NULL);
  }
  
  int git_config_from_blob_oid(config_fn_t fn,
 @@ -2233,96 +2297,98 @@ void git_die_config(const char *key, const char *err, ...)
   * Find all the stuff for git_config_set() below.
   */
  
 -static struct {
 +struct config_set_store {
  	int baselen;
  	char *key;
  	int do_not_match;
  	regex_t *value_regex;
  	int multi_replace;
 -	size_t *offset;
 -	unsigned int offset_alloc;
 -	enum { START, SECTION_SEEN, SECTION_END_SEEN, KEY_SEEN } state;
 -	unsigned int seen;
 -} store;
 +	struct {
 +		size_t begin, end;
 +		enum config_event_t type;
 +		int is_keys_section;
 +	} *parsed;
 +	unsigned int parsed_nr, parsed_alloc, *seen, seen_nr, seen_alloc;
 +	unsigned int key_seen:1, section_seen:1, is_keys_section:1;
 +};
  
 -static int matches(const char *key, const char *value)
 +static int matches(const char *key, const char *value,
 +		   const struct config_set_store *store)
  {
 -	if (strcmp(key, store.key))
 +	if (strcmp(key, store->key))
  		return 0; /* not ours */
 -	if (!store.value_regex)
 +	if (!store->value_regex)
  		return 1; /* always matches */
 -	if (store.value_regex == CONFIG_REGEX_NONE)
 +	if (store->value_regex == CONFIG_REGEX_NONE)
  		return 0; /* never matches */
  
 -	return store.do_not_match ^
 -		(value && !regexec(store.value_regex, value, 0, NULL, 0));
 +	return store->do_not_match ^
 +		(value && !regexec(store->value_regex, value, 0, NULL, 0));
 +}
 +
 +static int store_aux_event(enum config_event_t type,
 +			   size_t begin, size_t end, void *data)
 +{
 +	struct config_set_store *store = data;
 +
 +	ALLOC_GROW(store->parsed, store->parsed_nr + 1, store->parsed_alloc);
 +	store->parsed[store->parsed_nr].begin = begin;
 +	store->parsed[store->parsed_nr].end = end;
 +	store->parsed[store->parsed_nr].type = type;
 +
 +	if (type == CONFIG_EVENT_SECTION) {
 +		if (cf->var.len < 2 || cf->var.buf[cf->var.len - 1] != '.')
 +			BUG("Invalid section name '%s'", cf->var.buf);
 +
 +		/* Is this the section we were looking for? */
 +		store->is_keys_section =
 +			store->parsed[store->parsed_nr].is_keys_section =
 +			cf->var.len - 1 == store->baselen &&
 +			!strncasecmp(cf->var.buf, store->key, store->baselen);
 +		if (store->is_keys_section) {
 +			store->section_seen = 1;
 +			ALLOC_GROW(store->seen, store->seen_nr + 1,
 +				   store->seen_alloc);
 +			store->seen[store->seen_nr] = store->parsed_nr;
 +		}
 +	}
 +
 +	store->parsed_nr++;
 +
 +	return 0;
  }
  
  static int store_aux(const char *key, const char *value, void *cb)
  {
 -	const char *ep;
 -	size_t section_len;
 +	struct config_set_store *store = cb;
  
 -	switch (store.state) {
 -	case KEY_SEEN:
 -		if (matches(key, value)) {
 -			if (store.seen == 1 && store.multi_replace == 0) {
 +	if (store->key_seen) {
 +		if (matches(key, value, store)) {
 +			if (store->seen_nr == 1 && store->multi_replace == 0) {
  				warning(_("%s has multiple values"), key);
  			}
  
 -			ALLOC_GROW(store.offset, store.seen + 1,
 -				   store.offset_alloc);
 +			ALLOC_GROW(store->seen, store->seen_nr + 1,
 +				   store->seen_alloc);
  
 -			store.offset[store.seen] = cf->do_ftell(cf);
 -			store.seen++;
 +			store->seen[store->seen_nr] = store->parsed_nr;
 +			store->seen_nr++;
  		}
 -		break;
 -	case SECTION_SEEN:
 +	} else if (store->is_keys_section) {
  		/*
 -		 * What we are looking for is in store.key (both
 -		 * section and var), and its section part is baselen
 -		 * long.  We found key (again, both section and var).
 -		 * We would want to know if this key is in the same
 -		 * section as what we are looking for.  We already
 -		 * know we are in the same section as what should
 -		 * hold store.key.
 +		 * Do not increment matches yet: this may not be a match, but we
 +		 * are in the desired section.
  		 */
 -		ep = strrchr(key, '.');
 -		section_len = ep - key;
 -
 -		if ((section_len != store.baselen) ||
 -		    memcmp(key, store.key, section_len+1)) {
 -			store.state = SECTION_END_SEEN;
 -			break;
 -		}
 +		ALLOC_GROW(store->seen, store->seen_nr + 1, store->seen_alloc);
 +		store->seen[store->seen_nr] = store->parsed_nr;
 +		store->section_seen = 1;
  
 -		/*
 -		 * Do not increment matches: this is no match, but we
 -		 * just made sure we are in the desired section.
 -		 */
 -		ALLOC_GROW(store.offset, store.seen + 1,
 -			   store.offset_alloc);
 -		store.offset[store.seen] = cf->do_ftell(cf);
 -		/* fallthru */
 -	case SECTION_END_SEEN:
 -	case START:
 -		if (matches(key, value)) {
 -			ALLOC_GROW(store.offset, store.seen + 1,
 -				   store.offset_alloc);
 -			store.offset[store.seen] = cf->do_ftell(cf);
 -			store.state = KEY_SEEN;
 -			store.seen++;
 -		} else {
 -			if (strrchr(key, '.') - key == store.baselen &&
 -			      !strncmp(key, store.key, store.baselen)) {
 -					store.state = SECTION_SEEN;
 -					ALLOC_GROW(store.offset,
 -						   store.seen + 1,
 -						   store.offset_alloc);
 -					store.offset[store.seen] = cf->do_ftell(cf);
 -			}
 +		if (matches(key, value, store)) {
 +			store->seen_nr++;
 +			store->key_seen = 1;
  		}
  	}
 +
  	return 0;
  }
  
 @@ -2334,31 +2400,33 @@ static int write_error(const char *filename)
  	return 4;
  }
  
 -static struct strbuf store_create_section(const char *key)
 +static struct strbuf store_create_section(const char *key,
 +					  const struct config_set_store *store)
  {
  	const char *dot;
  	int i;
  	struct strbuf sb = STRBUF_INIT;
  
 -	dot = memchr(key, '.', store.baselen);
 +	dot = memchr(key, '.', store->baselen);
  	if (dot) {
  		strbuf_addf(&sb, "[%.*s \"", (int)(dot - key), key);
 -		for (i = dot - key + 1; i < store.baselen; i++) {
 +		for (i = dot - key + 1; i < store->baselen; i++) {
  			if (key[i] == '"' || key[i] == '\\')
  				strbuf_addch(&sb, '\\');
  			strbuf_addch(&sb, key[i]);
  		}
  		strbuf_addstr(&sb, "\"]\n");
  	} else {
 -		strbuf_addf(&sb, "[%.*s]\n", store.baselen, key);
 +		strbuf_addf(&sb, "[%.*s]\n", store->baselen, key);
  	}
  
  	return sb;
  }
  
 -static ssize_t write_section(int fd, const char *key)
 +static ssize_t write_section(int fd, const char *key,
 +			     const struct config_set_store *store)
  {
 -	struct strbuf sb = store_create_section(key);
 +	struct strbuf sb = store_create_section(key, store);
  	ssize_t ret;
  
  	ret = write_in_full(fd, sb.buf, sb.len);
 @@ -2367,11 +2435,12 @@ static ssize_t write_section(int fd, const char *key)
  	return ret;
  }
  
 -static ssize_t write_pair(int fd, const char *key, const char *value)
 +static ssize_t write_pair(int fd, const char *key, const char *value,
 +			  const struct config_set_store *store)
  {
  	int i;
  	ssize_t ret;
 -	int length = strlen(key + store.baselen + 1);
 +	int length = strlen(key + store->baselen + 1);
  	const char *quote = "";
  	struct strbuf sb = STRBUF_INIT;
  
 @@ -2391,7 +2460,7 @@ static ssize_t write_pair(int fd, const char *key, const char *value)
  		quote = "\"";
  
  	strbuf_addf(&sb, "\t%.*s = %s",
 -		    length, key + store.baselen + 1, quote);
 +		    length, key + store->baselen + 1, quote);
  
  	for (i = 0; value[i]; i++)
  		switch (value[i]) {
 @@ -2417,201 +2486,85 @@ static ssize_t write_pair(int fd, const char *key, const char *value)
  	return ret;
  }
  
 -static ssize_t find_beginning_of_line(const char *contents, size_t size,
 -	size_t offset_, int *found_bracket)
 -{
 -	size_t equal_offset = size, bracket_offset = size;
 -	ssize_t offset;
 -
 -contline:
 -	for (offset = offset_-2; offset > 0
 -			&& contents[offset] != '\n'; offset--)
 -		switch (contents[offset]) {
 -			case '=': equal_offset = offset; break;
 -			case ']': bracket_offset = offset; break;
 -		}
 -	if (offset > 0 && contents[offset-1] == '\\') {
 -		offset_ = offset;
 -		goto contline;
 -	}
 -	if (bracket_offset < equal_offset) {
 -		*found_bracket = 1;
 -		offset = bracket_offset+1;
 -	} else
 -		offset++;
 -
 -	return offset;
 -}
 -
 -/*
 - * This function determines whether the offset is in a line that starts with a
 - * comment character.
 - *
 - * Note: it does *not* report when a regular line (section header, config
 - * setting) *ends* in a comment.
 - */
 -static int is_in_comment_line(const char *contents, size_t offset)
 -{
 -	int comment = 0;
 -
 -	while (offset > 0)
 -		switch (contents[--offset]) {
 -		case ';':
 -		case '#':
 -			comment = 1;
 -			break;
 -		case '\n':
 -			break;
 -		case ' ':
 -		case '\t':
 -			continue;
 -		default:
 -			comment = 0;
 -		}
 -
 -	return comment;
 -}
 -
  /*
   * If we are about to unset the last key(s) in a section, and if there are
   * no comments surrounding (or included in) the section, we will want to
   * extend begin/end to remove the entire section.
   *
 - * Note: the parameter `i_ptr` points to the index into the store.offset
 - * array, reflecting the end offset of the respective entry to be deleted.
 - * This index may be incremented if a section has more than one entry (which
 - * all are to be removed).
 + * Note: the parameter `seen_ptr` points to the index into the store.seen
 + * array.  * This index may be incremented if a section has more than one
 + * entry (which all are to be removed).
   */
 -static void maybe_remove_section(const char *contents, size_t size,
 -				 const char *section_name,
 -				 size_t section_name_len,
 -				 size_t *begin, int *i_ptr, int *new_line)
 +static void maybe_remove_section(struct config_set_store *store,
 +				 const char *contents,
 +				 size_t *begin_offset, size_t *end_offset,
 +				 int *seen_ptr)
  {
 -	size_t begin2, end2;
 -	int seen_section = 0, dummy, i = *i_ptr;
 +	size_t begin;
 +	int i, seen, section_seen = 0;
  
  	/*
 -	 * First, make sure that this is the last key in the section, and that
 -	 * there are no comments that are possibly about the current section.
 +	 * First, ensure that this is the first key, and that there are no
 +	 * comments before the entry nor before the section header.
  	 */
 -next_entry:
 -	for (end2 = store.offset[i]; end2 < size; end2++) {
 -		switch (contents[end2]) {
 -		case ' ':
 -		case '\t':
 -		case '\n':
 -			continue;
 -		case '\r':
 -			if (++end2 < size && contents[end2] == '\n')
 -				continue;
 -			break;
 -		case '[':
 -			/* If the section name is repeated, continue */
 -			if (end2 + 1 + section_name_len < size &&
 -			    contents[end2 + section_name_len] == ']' &&
 -			    !memcmp(contents + end2 + 1, section_name,
 -				    section_name_len)) {
 -				end2 += section_name_len;
 -				continue;
 -			}
 -			goto look_before;
 -		case ';':
 -		case '#':
 -			/* There is a comment, cannot remove this section */
 +	seen = *seen_ptr;
 +	for (i = store->seen[seen]; i > 0; i--) {
 +		enum config_event_t type = store->parsed[i - 1].type;
 +
 +		if (type == CONFIG_EVENT_COMMENT)
 +			/* There is a comment before this entry or section */
  			return;
 -		default:
 -			/* There are other keys in that section */
 +		if (type == CONFIG_EVENT_ENTRY) {
 +			if (!section_seen)
 +				/* This is not the section's first entry. */
 +				return;
 +			/* We encountered no comment before the section. */
  			break;
  		}
 -
 -		/*
 -		 * Uh oh... we found something else in this section. But do
 -		 * we want to remove this, too?
 -		 */
 -		if (++i >= store.seen)
 -			return;
 -
 -		begin2 = find_beginning_of_line(contents, size, store.offset[i],
 -						&dummy);
 -		if (begin2 > end2)
 -			return;
 -
 -		/* Looks like we want to remove the next one, too... */
 -		goto next_entry;
 +		if (type == CONFIG_EVENT_SECTION) {
 +			if (!store->parsed[i - 1].is_keys_section)
 +				break;
 +			section_seen = 1;
 +		}
  	}
 +	begin = store->parsed[i].begin;
  
 -look_before:
  	/*
 -	 * Now, ensure that this is the first key, and that there are no
 -	 * comments before the entry nor before the section header.
 +	 * Next, make sure that we are removing he last key(s) in the section,
 +	 * and that there are no comments that are possibly about the current
 +	 * section.
  	 */
 -	for (begin2 = *begin; begin2 > 0; )
 -		switch (contents[begin2 - 1]) {
 -		case ' ':
 -		case '\t':
 -			begin2--;
 -			continue;
 -		case '\n':
 -			if (--begin2 > 0 && contents[begin2 - 1] == '\r')
 -				begin2--;
 -			continue;
 -		case ']':
 -			if (begin2 > section_name_len + 1 &&
 -			    contents[begin2 - section_name_len - 2] == '[' &&
 -			    !memcmp(contents + begin2 - section_name_len - 1,
 -				    section_name, section_name_len)) {
 -				begin2 -= section_name_len + 2;
 -				seen_section = 1;
 -				continue;
 -			}
 -
 -			/*
 -			 * It looks like a section header, but it could be a
 -			 * comment instead...
 -			 */
 -			if (is_in_comment_line(contents, begin2))
 -				return;
 -
 -			/*
 -			 * We encountered the previous section header: This
 -			 * really was the only entry, so remove the entire
 -			 * section.
 -			 */
 -			if (contents[begin2] != '\n') {
 -				begin2--;
 -				*new_line = 1;
 -			}
 +	for (i = store->seen[seen] + 1; i < store->parsed_nr; i++) {
 +		enum config_event_t type = store->parsed[i].type;
  
 -			store.offset[i] = end2;
 -			*begin = begin2;
 -			*i_ptr = i;
 +		if (type == CONFIG_EVENT_COMMENT)
  			return;
 -		default:
 -			/*
 -			 * Any other character means it is either a comment or
 -			 * a config setting; if it is a comment, we do not want
 -			 * to remove this section. If it is a config setting,
 -			 * we only want to remove this section if this is
 -			 * already the next section.
 -			 */
 -			if (seen_section &&
 -			    !is_in_comment_line(contents, begin2)) {
 -				if (contents[begin2] != '\n') {
 -					begin2--;
 -					*new_line = 1;
 -				}
 -
 -				store.offset[i] = end2;
 -				*begin = begin2;
 -				*i_ptr = i;
 -			}
 +		if (type == CONFIG_EVENT_SECTION) {
 +			if (store->parsed[i].is_keys_section)
 +				continue;
 +			break;
 +		}
 +		if (type == CONFIG_EVENT_ENTRY) {
 +			if (++seen < store->seen_nr &&
 +			    i == store->seen[seen])
 +				/* We want to remove this entry, too */
 +				continue;
 +			/* There is another entry in this section. */
  			return;
  		}
 +	}
  
 -	/* This section extends to the beginning of the file. */
 -	store.offset[i] = end2;
 -	*begin = begin2;
 -	*i_ptr = i;
 +	/*
 +	 * We are really removing the last entry/entries from this section, and
 +	 * there are no enclosed or surrounding comments. Remove the entire,
 +	 * now-empty section.
 +	 */
 +	*seen_ptr = seen;
 +	*begin_offset = begin;
 +	if (i < store->parsed_nr)
 +		*end_offset = store->parsed[i].begin;
 +	else
 +		*end_offset = store->parsed[store->parsed_nr - 1].end;
  }
  
  int git_config_set_in_file_gently(const char *config_filename,
 @@ -2671,14 +2624,15 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
  	struct lock_file lock = LOCK_INIT;
  	char *filename_buf = NULL;
  	char *contents = NULL;
 -	char *section_name = NULL;
  	size_t contents_sz;
 +	struct config_set_store store;
 +
 +	memset(&store, 0, sizeof(store));
  
  	/* parse-key returns negative; flip the sign to feed exit(3) */
 -	ret = 0 - git_config_parse_key(key, &section_name, &store.baselen);
 +	ret = 0 - git_config_parse_key(key, &store.key, &store.baselen);
  	if (ret)
  		goto out_free;
 -	store.key = section_name;
  
  	store.multi_replace = multi_replace;
  
 @@ -2692,6 +2646,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
  	fd = hold_lock_file_for_update(&lock, config_filename, 0);
  	if (fd < 0) {
  		error_errno("could not lock config file %s", config_filename);
 +		free(store.key);
  		ret = CONFIG_NO_LOCK;
  		goto out_free;
  	}
 @@ -2701,6 +2656,8 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
  	 */
  	in_fd = open(config_filename, O_RDONLY);
  	if ( in_fd < 0 ) {
 +		free(store.key);
 +
  		if ( ENOENT != errno ) {
  			error_errno("opening %s", config_filename);
  			ret = CONFIG_INVALID_FILE; /* same as "invalid config file" */
 @@ -2713,14 +2670,14 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
  		}
  
  		store.key = (char *)key;
 -		if (write_section(fd, key) < 0 ||
 -		    write_pair(fd, key, value) < 0)
 +		if (write_section(fd, key, &store) < 0 ||
 +		    write_pair(fd, key, value, &store) < 0)
  			goto write_err_out;
  	} else {
  		struct stat st;
  		size_t copy_begin, copy_end;
  		int i, new_line = 0;
 -		FILE *f;
 +		struct config_options opts;
  
  		if (value_regex == NULL)
  			store.value_regex = NULL;
 @@ -2743,34 +2700,36 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
  			}
  		}
  
 -		ALLOC_GROW(store.offset, 1, store.offset_alloc);
 -		store.offset[0] = 0;
 -		store.state = START;
 -		store.seen = 0;
 +		ALLOC_GROW(store.parsed, 1, store.parsed_alloc);
 +		store.parsed[0].end = 0;
 +
 +		memset(&opts, 0, sizeof(opts));
 +		opts.event_fn = store_aux_event;
 +		opts.event_fn_data = &store;
  
  		/*
 -		 * After this, store.offset will contain the *end* offset
 -		 * of the last match, or remain at 0 if no match was found.
 +		 * After this, store.parsed will contain offsets of all the
 +		 * parsed elements, and store.seen will contain a list of
 +		 * matches, as indices into store.parsed.
 +		 *
  		 * As a side effect, we make sure to transform only a valid
  		 * existing config file.
  		 */
 -		f = fopen_or_warn(config_filename, "r");
 -		if (!f || do_config_from_file(store_aux, CONFIG_ORIGIN_FILE,
 -					      config_filename, config_filename,
 -					      f, NULL, 1)) {
 +		if (git_config_from_file_with_options(store_aux,
 +						      config_filename,
 +						      &store, &opts)) {
  			error("invalid config file %s", config_filename);
 +			free(store.key);
  			if (store.value_regex != NULL &&
  			    store.value_regex != CONFIG_REGEX_NONE) {
  				regfree(store.value_regex);
  				free(store.value_regex);
  			}
  			ret = CONFIG_INVALID_FILE;
 -			if (f)
 -				fclose(f);
  			goto out_free;
 -		} else
 -			fclose(f);
 +		}
  
 +		free(store.key);
  		if (store.value_regex != NULL &&
  		    store.value_regex != CONFIG_REGEX_NONE) {
  			regfree(store.value_regex);
 @@ -2778,8 +2737,8 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
  		}
  
  		/* if nothing to unset, or too many matches, error out */
 -		if ((store.seen == 0 && value == NULL) ||
 -				(store.seen > 1 && multi_replace == 0)) {
 +		if ((store.seen_nr == 0 && value == NULL) ||
 +		    (store.seen_nr > 1 && multi_replace == 0)) {
  			ret = CONFIG_NOTHING_SET;
  			goto out_free;
  		}
 @@ -2810,25 +2769,48 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
  			goto out_free;
  		}
  
 -		if (store.seen == 0)
 -			store.seen = 1;
 +		if (store.seen_nr == 0) {
 +			if (!store.seen_alloc) {
 +				/* Did not see key nor section */
 +				ALLOC_GROW(store.seen, 1, store.seen_alloc);
 +				store.seen[0] = store.parsed_nr
 +					- !!store.parsed_nr;
 +			}
 +			store.seen_nr = 1;
 +		}
  
 -		for (i = 0, copy_begin = 0; i < store.seen; i++) {
 -			if (store.offset[i] == 0) {
 -				store.offset[i] = copy_end = contents_sz;
 -			} else if (store.state != KEY_SEEN) {
 -				copy_end = store.offset[i];
 +		for (i = 0, copy_begin = 0; i < store.seen_nr; i++) {
 +			size_t replace_end;
 +			int j = store.seen[i];
 +
 +			new_line = 0;
 +			if (!store.key_seen) {
 +				copy_end = store.parsed[j].end;
 +				/* include '\n' when copying section header */
 +				if (copy_end > 0 && copy_end < contents_sz &&
 +				    contents[copy_end - 1] != '\n' &&
 +				    contents[copy_end] == '\n')
 +					copy_end++;
 +				replace_end = copy_end;
  			} else {
 -				copy_end = find_beginning_of_line(
 -					contents, contents_sz,
 -					store.offset[i], &new_line);
 +				replace_end = store.parsed[j].end;
 +				copy_end = store.parsed[j].begin;
  				if (!value)
 -					maybe_remove_section(contents,
 -							     contents_sz,
 -							     section_name,
 -							     store.baselen,
 -							     &copy_end, &i,
 -							     &new_line);
 +					maybe_remove_section(&store, contents,
 +							     &copy_end,
 +							     &replace_end, &i);
 +				/*
 +				 * Swallow preceding white-space on the same
 +				 * line.
 +				 */
 +				while (copy_end > 0 ) {
 +					char c = contents[copy_end - 1];
 +
 +					if (isspace(c) && c != '\n')
 +						copy_end--;
 +					else
 +						break;
 +				}
  			}
  
  			if (copy_end > 0 && contents[copy_end-1] != '\n')
 @@ -2843,16 +2825,16 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
  				    write_str_in_full(fd, "\n") < 0)
  					goto write_err_out;
  			}
 -			copy_begin = store.offset[i];
 +			copy_begin = replace_end;
  		}
  
  		/* write the pair (value == NULL means unset) */
  		if (value != NULL) {
 -			if (store.state == START) {
 -				if (write_section(fd, key) < 0)
 +			if (!store.section_seen) {
 +				if (write_section(fd, key, &store) < 0)
  					goto write_err_out;
  			}
 -			if (write_pair(fd, key, value) < 0)
 +			if (write_pair(fd, key, value, &store) < 0)
  				goto write_err_out;
  		}
  
 @@ -2879,7 +2861,6 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
  
  out_free:
  	rollback_lock_file(&lock);
 -	free(section_name);
  	free(filename_buf);
  	if (contents)
  		munmap(contents, contents_sz);
 @@ -2977,7 +2958,8 @@ static int section_name_is_ok(const char *name)
  
  /* if new_name == NULL, the section is removed instead */
  static int git_config_copy_or_rename_section_in_file(const char *config_filename,
 -				      const char *old_name, const char *new_name, int copy)
 +				      const char *old_name,
 +				      const char *new_name, int copy)
  {
  	int ret = 0, remove = 0;
  	char *filename_buf = NULL;
 @@ -2987,6 +2969,9 @@ static int git_config_copy_or_rename_section_in_file(const char *config_filename
  	FILE *config_file = NULL;
  	struct stat st;
  	struct strbuf copystr = STRBUF_INIT;
 +	struct config_set_store store;
 +
 +	memset(&store, 0, sizeof(store));
  
  	if (new_name && !section_name_is_ok(new_name)) {
  		ret = error("invalid section name: %s", new_name);
 @@ -3056,7 +3041,7 @@ static int git_config_copy_or_rename_section_in_file(const char *config_filename
  				}
  				store.baselen = strlen(new_name);
  				if (!copy) {
 -					if (write_section(out_fd, new_name) < 0) {
 +					if (write_section(out_fd, new_name, &store) < 0) {
  						ret = write_error(get_lock_file_path(&lock));
  						goto out;
  					}
 @@ -3077,7 +3062,7 @@ static int git_config_copy_or_rename_section_in_file(const char *config_filename
  						output[0] = '\t';
  					}
  				} else {
 -					copystr = store_create_section(new_name);
 +					copystr = store_create_section(new_name, &store);
  				}
  			}
  			remove = 0;
 diff --git a/config.h b/config.h
 index ef70a9cac1e..5a2394daae2 100644
 --- a/config.h
 +++ b/config.h
 @@ -28,15 +28,40 @@ enum config_origin_type {
  	CONFIG_ORIGIN_CMDLINE
  };
  
 +enum config_event_t {
 +	CONFIG_EVENT_SECTION,
 +	CONFIG_EVENT_ENTRY,
 +	CONFIG_EVENT_WHITESPACE,
 +	CONFIG_EVENT_COMMENT,
 +	CONFIG_EVENT_EOF,
 +	CONFIG_EVENT_ERROR
 +};
 +
 +/*
 + * The parser event function (if not NULL) is called with the event type and
 + * the begin/end offsets of the parsed elements.
 + *
 + * Note: for CONFIG_EVENT_ENTRY (i.e. config variables), the trailing newline
 + * character is considered part of the element.
 + */
 +typedef int (*config_parser_event_fn_t)(enum config_event_t type,
 +					size_t begin_offset, size_t end_offset,
 +					void *event_fn_data);
 +
  struct config_options {
  	unsigned int respect_includes : 1;
  	const char *commondir;
  	const char *git_dir;
 +	config_parser_event_fn_t event_fn;
 +	void *event_fn_data;
  };
  
  typedef int (*config_fn_t)(const char *, const char *, void *);
  extern int git_default_config(const char *, const char *, void *);
  extern int git_config_from_file(config_fn_t fn, const char *, void *);
 +extern int git_config_from_file_with_options(config_fn_t fn, const char *,
 +					     void *,
 +					     const struct config_options *);
  extern int git_config_from_mem(config_fn_t fn, const enum config_origin_type,
  					const char *name, const char *buf, size_t len, void *data);
  extern int git_config_from_blob_oid(config_fn_t fn, const char *name,
 diff --git a/t/t1300-config.sh b/t/t1300-config.sh
 index 867397ae930..6d0e13020d1 100755
 --- a/t/t1300-config.sh
 +++ b/t/t1300-config.sh
 @@ -1643,4 +1643,25 @@ test_expect_success '--local requires a repo' '
  	test_expect_code 128 nongit git config --local foo.bar
  '
  
 +test_expect_success '--replace-all does not invent newlines' '
 +	q_to_tab >.git/config <<-\EOF &&
 +	[abc]key
 +	QkeepSection
 +	[xyz]
 +	Qkey = 1
 +	[abc]
 +	Qkey = a
 +	EOF
 +	q_to_tab >expect <<-\EOF &&
 +	[abc]
 +	QkeepSection
 +	[xyz]
 +	Qkey = 1
 +	[abc]
 +	Qkey = b
 +	EOF
 +	git config --replace-all abc.key b &&
 +	test_cmp .git/config expect
 +'
 +
  test_done
-- 
2.16.2.windows.1.26.g2cc3565eb4b


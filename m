Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D13133CEB9
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 23:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771026924; cv=none; b=lCq02lY+pWCXma4GPAbdBy+j1pgTeRduFiMv4RY5eXslkB+gWpgoMpExP0a0hVNU715cH5foh4Myss5+CbPTWK18PtTX+Q6LVozuCm9rAekQIqqxogruICmyxUMdU+30ECUgyG/Z82+HFOy266k7GzkAOo/ro2DNxWCWV5f4odQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771026924; c=relaxed/simple;
	bh=75/Y8oaBTFEMK9PoFi9TLCiw2oXZ4Mp3K7E6MRCrDwM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ggaByWgRPGmjRZRvjHD3YhmwFb96P/d+Nql4jKEOk5vP9c1A+/ABdvH9pGQxYdAZE6uj7D7gjD+kcy2xKLFsQ8C2NJ2JzV6wmszuqgUW0NGBiGf1RjyFhs9Sq2XGJgt01NzRbVHOJ9IP8CXxU3fSehZNfinW8g6y7f0K1mVheb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/bd6qEU; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/bd6qEU"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-896f44dc48dso12416826d6.2
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 15:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771026921; x=1771631721; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJBrzYSS+dKs+nwpHlBjaKTUmHm1yrC2oteHekxHFsM=;
        b=Q/bd6qEUtw4qmMyBr6TbiopB/pVHnTiADErrtZtigFHbJMDfuyVFR94UKvHRiZ8sLs
         DNCoVRZFrndrPSZEKo29h08eGzqeKlfAkVqVRugEtqhPUWT8Zd+GZdKC7udT680Hn1+z
         WWvqHbprqZAIwHEB/MSHuD7aHe9r/vyjGP+4sgJ4YjCViJH+Sw17kDnijibNaKOkAIal
         YFz3l5KstlUEFRxwHUbEVxaaGynlw6ZipPIgBBYEPKK8iMp38TTOZECwTzPyh4MRRjOW
         b7H/fuG+x8ogz7u2N25xcztM3jiOSjT8malEyENljPca0zoYbYueSMw2Dt/dkDoDEwc0
         N+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771026921; x=1771631721;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RJBrzYSS+dKs+nwpHlBjaKTUmHm1yrC2oteHekxHFsM=;
        b=jIqjmBJ0TQjvXiEh+CQZUq5wxij0K4eitraDMql/5Gbu11tiWjM4ZttaSSDGSuQliP
         fxYqi5AIPYFaniXtdd2jDfgatFErysqb8meE/a1SflUv/R+sRjFOZnvTQvnNEJ/7z+eC
         zC10tvUq4qKa16csTXTGIX2KLzwDYOVSscRQinnRzx5glreCfCdKoxj3eN/rPdKx/bBF
         sOi2vW2uvgpq3Xy+zZ3fhM7f9L8ConZ6xHm8Ixh1AeKM81z4IiBt57neqmMlxY5nQYxS
         N6wU1i7a05IGDc6RXmqFNlIyT9RnDk/wyOhECOysUd/ANmhdJmCj0bxLOFouLFl3Kf87
         iSrA==
X-Gm-Message-State: AOJu0YzmZwHFjVR5afxeMcW7mQvrP6cOHDd+GnnvofA6vo7G4RnC7EEG
	oQSzOasZaiiY3SCnKh0kYU6C5eEV5HVZK11d5RGXCUs8l0JIoVCCDpmrTnYcPfBx
X-Gm-Gg: AZuq6aIhVniL12+Y8XEolKhc9xTmJVM/VWTwAcgnWP3nWFBPQIVMETXGRuTJFCsS9XI
	CDmRtE6dauxzk3Hvvw+NGbBywD7vKUJzf6GGX1GMLD5KpL7+3Sbc8VROKHeHo5O7XCbPkMsQ1iF
	jMSYCpZzjE/3HfA4sI9A30y067QsEjCTYZsQs60VT/lHBWjCCbHI7f9zR1PzzKXyYKPGuYdtKGq
	2Y0Bsm3jUI7OF4uFIAJQLp/BzETWmDuVd6/M5oh2QIiT2z4vNopmNEy7WxB9Fl79LlR7tJzGHts
	7nodBh2TSc8UFWLBVUBhoGSdzDZvhePDsLN4YA3VnvSZCObkrLkYpQNkq8NFmvZXMCRa1uy8m/w
	dgQBcsxWfK6tAH05ey/+zgMpT1sxaZmxD+GRaV/yr2pHnitQjhQb5PqQdIvW4moTX8uV9pcYilw
	fF/FOPkSxwzz5Byj0dPYIpkhbv
X-Received: by 2002:a05:6214:b6c:b0:894:6901:cb3e with SMTP id 6a1803df08f44-897360a6c23mr50743556d6.19.1771026920842;
        Fri, 13 Feb 2026 15:55:20 -0800 (PST)
Received: from [127.0.0.1] ([145.132.99.17])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b1c7ef7sm762295885a.28.2026.02.13.15.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 15:55:20 -0800 (PST)
Message-Id: <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
In-Reply-To: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Feb 2026 23:55:05 +0000
Subject: [PATCH v2 00/13] Make 'git config list --type=' parse and filter types
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    Patrick Steinhardt <ps@pks.im>,
    Derrick Stolee <stolee@gmail.com>

I started down this road based on feedback on my 'git config-batch' RFC [1].

[1]
https://lore.kernel.org/git/pull.2033.git.1770214803.gitgitgadget@gmail.com/

I had described my intention to use 'git config-batch' as a single process
to load multiple config values one-by-one. Brian mentioned that 'git config
list -z' would probably suffice, so I started experimenting in that
direction [2].

[2]
https://github.com/git-ecosystem/git-credential-manager/compare/main...derrickstolee:config-list

However, I ran into a problem: the most critical performance bottleneck is
related to path-formatted config values that are queried with 'git config
get --type=path -z'. It wasn't hard to update things to lazily load the full
list of config values by type [3], but I then noticed a big problem!

[3]
https://github.com/git-ecosystem/git-credential-manager/commit/d403c8e24ce6f37da920cce23842dd5a6cf6481d

Problem: 'git config list' doesn't respect --type=<X>!

This boils down to the fact that the iterator function show_all_config()
doesn't call format_config(), which includes the type-parsing code.

This wasn't super trivial to update:

 1. format_config() uses git_config_parse_*() methods, which die() on a bad
    parse.
 2. The path parsing code didn't have a gentle version.
 3. The two paths ('git config list' and 'git config --list') needed to
    standardize their display options to work with format_config().
 4. Finally, we need to filter out key-value pairs that don't match the
    given type.


Updates in v2
=============

Based on the positive feedback in round one, this is no longer an RFC.

 * format_config() now uses a 'gently' parameter instead of 'die_on_parse'
   (flipped).
 * format_config() is more carefully updated with helper methods and a
   global refactor.
 * New gentle parsing code is introduced right before the format_config()
   helper is created to use it.
 * I squashed the change that updates the display_opts initial state into
   the patch that uses format_config() for the 'list' command. The initial
   state change on its own leads to test failures, so I am making a slightly
   bigger patch to keep things passing tests at every change.
 * More tests for 'git config list --type=<X>' are added.
 * I rearranged things so the 'git config list --type' integration follows
   the format_config() update immediately. The tests at that time show what
   such a trivial implementation would do, including failing on bool parsing
   and having several error messages for color and expiry-date parsing. The
   tests modify as these issues are fixed with gentle parsers.
 * I have a prototype implementation of GCM using this option in [4] and it
   gets the performance improvements I was hoping for. It requires polish
   and a compatibility check that uses the Git version to guarantee that
   this --type behavior change is recognized.

[4] https://github.com/git-ecosystem/git-credential-manager/pull/2268

Thanks for any and all feedback, -Stolee

Derrick Stolee (13):
  config: move show_all_config()
  config: add 'gently' parameter to format_config()
  config: make 'git config list --type=<X>' work
  config: format int64s gently
  config: format bools gently
  config: format bools or ints gently
  config: format bools or strings in helper
  parse: add git_parse_maybe_pathname()
  config: format paths gently
  config: format expiry dates gently
  color: add color_parse_gently()
  config: format colors gently
  config: restructure format_config()

 Documentation/git-config.adoc |   3 +
 builtin/config.c              | 283 +++++++++++++++++++++++++---------
 color.c                       |  25 ++-
 color.h                       |   1 +
 config.c                      |  14 +-
 parse.c                       |  24 +++
 parse.h                       |   2 +
 t/t1300-config.sh             |  58 ++++++-
 8 files changed, 318 insertions(+), 92 deletions(-)


base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2044%2Fderrickstolee%2Fconfig-list-type-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2044/derrickstolee/config-list-type-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2044

Range-diff vs v1:

  1:  bca83d8ca8 =  1:  bca83d8ca8 config: move show_all_config()
  3:  d9e0424010 !  2:  93c94a1b25 config: allow format_config() to filter
     @@ Metadata
      Author: Derrick Stolee <stolee@gmail.com>
      
       ## Commit message ##
     -    config: allow format_config() to filter
     +    config: add 'gently' parameter to format_config()
      
     -    The format_config() method in builtin/config.c currently only uses
     -    git_config_*() methods for parsing. This allows parsing errors to result
     -    in die() messages appropriate with keys in the error message.
     -
     -    In a future change we will want to use format_config() within 'git
     -    config list' to help format the output, including when --type=<X>
     -    arguments are provided. When the parsing fails in that case, that
     -    key-value pair should be omitted instead of causing a failure across the
     -    entire command.
     -
     -    This change is formatted in such a way that the if/else-if structure
     -    allows the default die_on_error version to appear first and then be
     -    followed by the gentle parsing mode immediately afterwards.
     -
     -    The only callers right now have die_on_parse set to 1.
     +    This parameter is set to 0 for all current callers and is UNUSED.
     +    However, we will start using this option in future changes and in a
     +    critical change that requires gentle parsing (not using die()) to try
     +    parsing all values in a list.
      
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## builtin/config.c ##
     -@@
     - #include "abspath.h"
     - #include "config.h"
     - #include "color.h"
     -+#include "date.h"
     - #include "editor.h"
     - #include "environment.h"
     - #include "gettext.h"
      @@ builtin/config.c: struct strbuf_list {
     +  * append it into strbuf `buf`.  Returns a negative value on failure,
     +  * 0 on success, 1 on a missing optional value (i.e., telling the
     +  * caller to pretend that <key_,value_> did not exist).
     ++ *
     ++ * Note: 'gently' is currently ignored, but will be implemented in
     ++ * a future change.
        */
       static int format_config(const struct config_display_options *opts,
       			 struct strbuf *buf, const char *key_,
      -			 const char *value_, const struct key_value_info *kvi)
      +			 const char *value_, const struct key_value_info *kvi,
     -+			 int die_on_parse)
     ++			 int gently UNUSED)
       {
       	if (opts->show_scope)
       		show_config_scope(opts, kvi, buf);
     -@@ builtin/config.c: static int format_config(const struct config_display_options *opts,
     - 		if (opts->show_keys)
     - 			strbuf_addch(buf, opts->key_delim);
     - 
     --		if (opts->type == TYPE_INT)
     -+		if (opts->type == TYPE_INT && die_on_parse) {
     - 			strbuf_addf(buf, "%"PRId64,
     - 				    git_config_int64(key_, value_ ? value_ : "", kvi));
     --		else if (opts->type == TYPE_BOOL)
     -+		} else if (opts->type == TYPE_INT) {
     -+			int64_t v;
     -+			int ret = git_parse_int64(value_, &v);
     -+
     -+			if (ret)
     -+				return -1;
     -+
     -+			strbuf_addf(buf, "%"PRId64, v);
     -+		}
     -+		else if (opts->type == TYPE_BOOL && die_on_parse) {
     - 			strbuf_addstr(buf, git_config_bool(key_, value_) ?
     - 				      "true" : "false");
     --		else if (opts->type == TYPE_BOOL_OR_INT) {
     --			int is_bool, v;
     --			v = git_config_bool_or_int(key_, value_, kvi,
     --						   &is_bool);
     -+		} else if (opts->type == TYPE_BOOL) {
     -+			int value = git_parse_maybe_bool(value_);
     -+
     -+			if (value < 0)
     -+				return -1;
     -+
     -+			strbuf_addstr(buf, value ? "true" : "false");
     -+		} else if (opts->type == TYPE_BOOL_OR_INT && die_on_parse) {
     -+			int is_bool = 0;
     -+			int v = git_config_bool_or_int(key_, value_, kvi,
     -+						       &is_bool);
     -+			if (is_bool)
     -+				strbuf_addstr(buf, v ? "true" : "false");
     -+			else
     -+				strbuf_addf(buf, "%d", v);
     -+		} else if (opts->type == TYPE_BOOL_OR_INT) {
     -+			int is_bool = 0;
     -+			int v = git_parse_maybe_bool_text(value_);
     -+
     -+			if (v < 0)
     -+				return -1;
     -+
     - 			if (is_bool)
     - 				strbuf_addstr(buf, v ? "true" : "false");
     - 			else
     - 				strbuf_addf(buf, "%d", v);
     - 		} else if (opts->type == TYPE_BOOL_OR_STR) {
     -+			/* Note: this can't fail to parse! */
     - 			int v = git_parse_maybe_bool(value_);
     - 			if (v < 0)
     - 				strbuf_addstr(buf, value_);
     - 			else
     - 				strbuf_addstr(buf, v ? "true" : "false");
     --		} else if (opts->type == TYPE_PATH) {
     -+		} else if (opts->type == TYPE_PATH && die_on_parse) {
     - 			char *v;
     - 			if (git_config_pathname(&v, key_, value_) < 0)
     - 				return -1;
     -@@ builtin/config.c: static int format_config(const struct config_display_options *opts,
     - 			else
     - 				return 1; /* :(optional)no-such-file */
     - 			free((char *)v);
     --		} else if (opts->type == TYPE_EXPIRY_DATE) {
     -+		} else if (opts->type == TYPE_PATH) {
     -+			char *v;
     -+			if (git_parse_maybe_pathname(value_, &v) < 0)
     -+				return -1;
     -+			if (v)
     -+				strbuf_addstr(buf, v);
     -+			else
     -+				return 1; /* :(optional)no-such-file */
     -+			free((char *)v);
     -+		} else if (opts->type == TYPE_EXPIRY_DATE && die_on_parse) {
     - 			timestamp_t t;
     - 			if (git_config_expiry_date(&t, key_, value_) < 0)
     - 				return -1;
     - 			strbuf_addf(buf, "%"PRItime, t);
     --		} else if (opts->type == TYPE_COLOR) {
     -+		} else if (opts->type == TYPE_EXPIRY_DATE) {
     -+			timestamp_t t;
     -+			if (parse_expiry_date(value_, &t) < 0)
     -+				return -1;
     -+			strbuf_addf(buf, "%"PRItime, t);
     -+		} else if (opts->type == TYPE_COLOR && die_on_parse) {
     - 			char v[COLOR_MAXLEN];
     - 			if (git_config_color(v, key_, value_) < 0)
     - 				return -1;
     - 			strbuf_addstr(buf, v);
     -+		} else if (opts->type == TYPE_COLOR) {
     -+			char v[COLOR_MAXLEN];
     -+			if (color_parse(value_, v) < 0)
     -+				return -1;
     -+			strbuf_addstr(buf, v);
     - 		} else if (value_) {
     - 			strbuf_addstr(buf, value_);
     - 		} else {
      @@ builtin/config.c: static int collect_config(const char *key_, const char *value_,
       	strbuf_init(&values->items[values->nr], 0);
       
       	status = format_config(data->display_opts, &values->items[values->nr++],
      -			       key_, value_, kvi);
     -+			       key_, value_, kvi, 1);
     ++			       key_, value_, kvi, 0);
       	if (status < 0)
       		return status;
       	if (status) {
     @@ builtin/config.c: static int get_value(const struct config_location_options *opt
       
       		status = format_config(display_opts, item, key_,
      -				       display_opts->default_value, &kvi);
     -+				       display_opts->default_value, &kvi, 1);
     ++				       display_opts->default_value, &kvi, 0);
       		if (status < 0)
       			die(_("failed to format default config value: %s"),
       			    display_opts->default_value);
     @@ builtin/config.c: static int get_urlmatch(const struct config_location_options *
       		status = format_config(&display_opts, &buf, item->string,
       				       matched->value_is_null ? NULL : matched->value.buf,
      -				       &matched->kvi);
     -+				       &matched->kvi, 1);
     ++				       &matched->kvi, 0);
       		if (!status)
       			fwrite(buf.buf, 1, buf.len, stdout);
       		strbuf_release(&buf);
  5:  e27d52c4a5 !  3:  6d2a48a3b7 config: make 'git config list --type=<X>' work
     @@ Commit message
          Previously, the --type=<X> argument to 'git config list' was ignored and
          did nothing. Now, we add the use of format_config() to the
          show_all_config() function so each key-value pair is attempted to be
     -    parsed.
     +    parsed. This is our first use of the 'gently' parameter with a nonzero
     +    value.
     +
     +    When listing multiple values, our initial settings for the output format
     +    is different. Add a new init helper to specify the fact that keys should
     +    be shown and also add the default delimiters as they were unset in some
     +    cases.
      
          If there is an error in parsing, then the row is not output.
      
     @@ Commit message
          behavior at all previously, so users can get the behavior they expect by
          removing the --type argument or adding the --no-type argument.
      
     +    t1300-config.sh is updated with the current behavior of this formatting
     +    logic to justify the upcoming refactoring of format_config() that will
     +    incrementally fix some of these cases to be more user-friendly.
     +
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## Documentation/git-config.adoc ##
     @@ builtin/config.c: static int show_all_config(const char *key_, const char *value
      -		printf("%s%c%s%c", key_, opts->delim, value_, opts->term);
      -	else
      -		printf("%s%c", key_, opts->term);
     -+	if (format_config(opts, &formatted, key_, value_, kvi, 0) >= 0)
     ++	if (format_config(opts, &formatted, key_, value_, kvi, 1) >= 0)
      +		fwrite(formatted.buf, 1, formatted.len, stdout);
      +
      +	strbuf_release(&formatted);
       	return 0;
       }
       
     +@@ builtin/config.c: static void display_options_init(struct config_display_options *opts)
     + 	}
     + }
     + 
     ++static void display_options_init_list(struct config_display_options *opts)
     ++{
     ++	opts->show_keys = 1;
     ++
     ++	if (opts->end_nul) {
     ++		display_options_init(opts);
     ++	} else {
     ++		opts->term = '\n';
     ++		opts->delim = ' ';
     ++		opts->key_delim = '=';
     ++	}
     ++}
     ++
     + static int cmd_config_list(int argc, const char **argv, const char *prefix,
     + 			   struct repository *repo UNUSED)
     + {
     +@@ builtin/config.c: static int cmd_config_list(int argc, const char **argv, const char *prefix,
     + 	check_argc(argc, 0, 0);
     + 
     + 	location_options_init(&location_opts, prefix);
     +-	display_options_init(&display_opts);
     ++	display_options_init_list(&display_opts);
     + 
     + 	setup_auto_pager("config", 1);
     + 
     +@@ builtin/config.c: static int cmd_config_actions(int argc, const char **argv, const char *prefix)
     + 
     + 	if (actions == ACTION_LIST) {
     + 		check_argc(argc, 0, 0);
     ++		display_options_init_list(&display_opts);
     + 		if (config_with_options(show_all_config, &display_opts,
     + 					&location_opts.source, the_repository,
     + 					&location_opts.options) < 0) {
      
       ## t/t1300-config.sh ##
      @@ t/t1300-config.sh: done
     @@ t/t1300-config.sh: done
       number = 10
       big = 1M
      +path = ~/dir
     ++red = red
     ++blue = Blue
     ++date = Fri Jun 4 15:46:55 2010
       EOF
       
       test_expect_success 'identical modern --type specifiers are allowed' '
     @@ t/t1300-config.sh: test_expect_success 'unset type specifiers may be reset to co
      +	section.big=true
      +	EOF
      +
     -+	git config ${mode_prefix}list --type=bool >actual &&
     -+	test_cmp expect actual
     ++	test_must_fail git config ${mode_prefix}list --type=bool
      +'
      +
      +test_expect_success 'list --type=path shows only canonicalizable path values' '
     @@ t/t1300-config.sh: test_expect_success 'unset type specifiers may be reset to co
      +	section.number=10
      +	section.big=1M
      +	section.path=$HOME/dir
     ++	section.red=red
     ++	section.blue=Blue
     ++	section.date=Fri Jun 4 15:46:55 2010
     ++	EOF
     ++
     ++	git config ${mode_prefix}list --type=path >actual 2>err &&
     ++	test_cmp expect actual &&
     ++	test_must_be_empty err
     ++'
     ++
     ++test_expect_success 'list --type=expiry-date shows only canonicalizable dates' '
     ++	cat >expecterr <<-EOF &&
     ++	error: '\''True'\'' for '\''section.foo'\'' is not a valid timestamp
     ++	error: '\''~/dir'\'' for '\''section.path'\'' is not a valid timestamp
     ++	error: '\''red'\'' for '\''section.red'\'' is not a valid timestamp
     ++	error: '\''Blue'\'' for '\''section.blue'\'' is not a valid timestamp
     ++	EOF
     ++
     ++	git config ${mode_prefix}list --type=expiry-date >actual 2>err &&
     ++
     ++	# section.number and section.big parse as relative dates that could
     ++	# have clock skew in their results.
     ++	test_grep section.big actual &&
     ++	test_grep section.number actual &&
     ++	test_grep "section.date=$(git config --type=expiry-date section.$key)" actual &&
     ++	test_cmp expecterr err
     ++'
     ++
     ++test_expect_success 'list --type=color shows only canonicalizable color values' '
     ++	cat >expect <<-EOF &&
     ++	section.number=<>
     ++	section.red=<RED>
     ++	section.blue=<BLUE>
     ++	EOF
     ++
     ++	cat >expecterr <<-EOF &&
     ++	error: invalid color value: True
     ++	error: invalid color value: 1M
     ++	error: invalid color value: ~/dir
     ++	error: invalid color value: Fri Jun 4 15:46:55 2010
      +	EOF
      +
     -+	git config ${mode_prefix}list --type=path >actual &&
     -+	test_cmp expect actual
     ++	git config ${mode_prefix}list --type=color >actual.raw 2>err &&
     ++	test_decode_color <actual.raw >actual &&
     ++	test_cmp expect actual &&
     ++	test_cmp expecterr err
      +'
      +
       test_expect_success '--type rejects unknown specifiers' '
  4:  5601a5a84f !  4:  2bca4d2316 config: create special init for list mode
     @@ Metadata
      Author: Derrick Stolee <stolee@gmail.com>
      
       ## Commit message ##
     -    config: create special init for list mode
     +    config: format int64s gently
      
     -    When listing multiple values, our initial settings for the output format
     -    is different. Add a new init helper to specify the fact that keys should
     -    be shown and also add the default delimiters as they were unset in some
     -    cases.
     -
     -    There are two places, differing by the 'git config list' and 'git config
     -    --list' modes.
     +    Move the logic for formatting int64 config values into a helper method
     +    and use gentle parsing when needed.
      
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## builtin/config.c ##
     -@@ builtin/config.c: static void display_options_init(struct config_display_options *opts)
     - 	}
     - }
     +@@ builtin/config.c: struct strbuf_list {
     + 	int alloc;
     + };
       
     -+static void display_options_init_list(struct config_display_options *opts)
     ++static int format_config_int64(struct strbuf *buf,
     ++			       const char *key_,
     ++			       const char *value_,
     ++			       const struct key_value_info *kvi,
     ++			       int gently)
      +{
     -+	opts->show_keys = 1;
     -+
     -+	if (opts->end_nul) {
     -+		display_options_init(opts);
     ++	int64_t v = 0;
     ++	if (gently) {
     ++		if (git_parse_int64(value_, &v))
     ++			return -1;
      +	} else {
     -+		opts->term = '\n';
     -+		opts->delim = ' ';
     -+		opts->key_delim = '=';
     ++		/* may die() */
     ++		v = git_config_int64(key_, value_ ? value_ : "", kvi);
      +	}
     ++
     ++	strbuf_addf(buf, "%"PRId64, v);
     ++	return 0;
      +}
      +
     - static int cmd_config_list(int argc, const char **argv, const char *prefix,
     - 			   struct repository *repo UNUSED)
     + /*
     +  * Format the configuration key-value pair (`key_`, `value_`) and
     +  * append it into strbuf `buf`.  Returns a negative value on failure,
     +@@ builtin/config.c: struct strbuf_list {
     + static int format_config(const struct config_display_options *opts,
     + 			 struct strbuf *buf, const char *key_,
     + 			 const char *value_, const struct key_value_info *kvi,
     +-			 int gently UNUSED)
     ++			 int gently)
       {
     -@@ builtin/config.c: static int cmd_config_list(int argc, const char **argv, const char *prefix,
     - 	check_argc(argc, 0, 0);
     ++	int res = 0;
     + 	if (opts->show_scope)
     + 		show_config_scope(opts, kvi, buf);
     + 	if (opts->show_origin)
     +@@ builtin/config.c: static int format_config(const struct config_display_options *opts,
     + 			strbuf_addch(buf, opts->key_delim);
       
     - 	location_options_init(&location_opts, prefix);
     --	display_options_init(&display_opts);
     -+	display_options_init_list(&display_opts);
     - 
     - 	setup_auto_pager("config", 1);
     - 
     -@@ builtin/config.c: static int cmd_config_actions(int argc, const char **argv, const char *prefix)
     + 		if (opts->type == TYPE_INT)
     +-			strbuf_addf(buf, "%"PRId64,
     +-				    git_config_int64(key_, value_ ? value_ : "", kvi));
     ++			res = format_config_int64(buf, key_, value_, kvi, gently);
     + 		else if (opts->type == TYPE_BOOL)
     + 			strbuf_addstr(buf, git_config_bool(key_, value_) ?
     + 				      "true" : "false");
     +@@ builtin/config.c: static int format_config(const struct config_display_options *opts,
     + 		}
     + 	}
     + 	strbuf_addch(buf, opts->term);
     +-	return 0;
     ++	return res;
     + }
       
     - 	if (actions == ACTION_LIST) {
     - 		check_argc(argc, 0, 0);
     -+		display_options_init_list(&display_opts);
     - 		if (config_with_options(show_all_config, &display_opts,
     - 					&location_opts.source, the_repository,
     - 					&location_opts.options) < 0) {
     + static int show_all_config(const char *key_, const char *value_,
  -:  ---------- >  5:  f8e0b8304f config: format bools gently
  -:  ---------- >  6:  0a428d2ffe config: format bools or ints gently
  -:  ---------- >  7:  3fec3abbd6 config: format bools or strings in helper
  2:  8d3a6a8265 !  8:  fafafc5465 parse: add git_parse_maybe_pathname()
     @@ Metadata
       ## Commit message ##
          parse: add git_parse_maybe_pathname()
      
     -    This extraction of logic from config.c's git_config_pathname() allows
     -    for parsing a fully-qualified path from a relative path along with
     -    validation of the existence of the path without failing with a die().
     +    The git_config_pathname() method parses a config value as a path, but
     +    always die()s on an error. Move this logic into a gentler parsing
     +    algorithm that will return an error value instead of ending the process.
      
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
  -:  ---------- >  9:  d1cfa0c5e1 config: format paths gently
  -:  ---------- > 10:  9221ca2352 config: format expiry dates gently
  -:  ---------- > 11:  ddf6131ac9 color: add color_parse_gently()
  -:  ---------- > 12:  d14937e6d1 config: format colors gently
  -:  ---------- > 13:  48fc882785 config: restructure format_config()

-- 
gitgitgadget

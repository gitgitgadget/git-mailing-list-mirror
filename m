Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2DD01F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 20:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfKNUrJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 15:47:09 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35544 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfKNUrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 15:47:09 -0500
Received: by mail-pf1-f195.google.com with SMTP id q13so5102443pff.2
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 12:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mNU3AhItLlGaXh0ygsfu9IYZb/BIhTUe0ZXzpCu001g=;
        b=QFDLyMn7NHYjIpzgRkXiPM94IAbokSkPWWAKQA2vnlXedst2MPU+7Pkb6MHiJ8Gmm7
         tXunfu4TtsyDVAO0vH+k8fR/qrb7RfJiRkpiTZy1wA4xCXpflwJEpgsr/hTAmeYfs+Ci
         68pFrm8wZ0bxxC4MHyKjwqNEhggR7bxKnb2xxKYWX4nXh6qHH7iE4AupvvBws3kWK0ae
         ZbQZb7aWG4IU1rxmAQQ6NCuDoIkkGz744nUJeuumt4PLpL5lwA8B74hNWG/Qv/q9OKwk
         6IdRURXKn0xBjOlwbqbtLfBeD/Ds4420ysbqalmUQmJiWAjHBMMirJ6kkntzKUMJ4TVM
         HCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mNU3AhItLlGaXh0ygsfu9IYZb/BIhTUe0ZXzpCu001g=;
        b=iew3m1qaxz6IlUEKEEoCMlTcBSIf8KIs/2o7LlfqQpinB3mynYs0/f6JvNNHZTqv+d
         lSXY47Uv2ZcpfYBnEWcWkGg8GwzNeXHmSwbmLUztVGJ3/WIvaUG+jYDFWLRGBv32NCy5
         w+wlnahBjIqGSbJLeqJYUJt5ts6xJPHuDYZs6bf4Ck8Uy8kAl0+jjlSuFqnaHwGYcoSU
         g4Ua6YHOXvEII6zvnFw32Z8qNil+A7krS5liW1ShLNhxFWiMEPIfov5zoGY3krqkDFyZ
         8XRxE9s0GcrlUg1vRDV27Y5W9cBKLOWtv4iwjhMivW7gKZnFdIB/447bG37WW1KPeaBc
         Qm+w==
X-Gm-Message-State: APjAAAUOLsy/l8x0HZzMCAqAKyOl7ueYo8IjPOqB/yemltopW16fFP2b
        rKe3Kw9/MsHOcrLmimmZO/tAyY/X
X-Google-Smtp-Source: APXvYqwe0CtKYunEe7NsKyyV56EzF7044xg03DVP9WWhlnCZeEM/eyLnhyqHfYaELHC5XslhjeohWg==
X-Received: by 2002:a65:41c5:: with SMTP id b5mr11965423pgq.78.1573764427433;
        Thu, 14 Nov 2019 12:47:07 -0800 (PST)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id v19sm6621480pjr.14.2019.11.14.12.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 12:47:06 -0800 (PST)
Date:   Thu, 14 Nov 2019 12:47:04 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 00/10] learn the "reference" pretty format
Message-ID: <cover.1573764280.git.liu.denton@gmail.com>
References: <cover.1573241590.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1573241590.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Thanks for the feedback from the last round. I've implemented it as a
canned user-format which reduces the amount of code we need to touch.
Thanks for the advice!


On this mailing list (and many others) the standard way to reference
other commits with the "reference" format, e.g. "f86a374 (pack-bitmap.c:
fix a memleak, 2015-03-30)". Since it's so commonly used, let's
standardise it as a pretty format.

Patches 5-7 were cleanup patches that were critical in earlier
iterations of the series but no longer are critical for the rest of the
patchset. Nonetheless, let's include them since they improve the quality
of the codebase.

Changes since v2:

* Rename from "summary" to "reference"

* Implement the feature as a canned userformat

* Implement the %*s (short date) format string element

* Remove the enclosing dqs around the subject

Changes since v1:

* Replace more references to "sha1" with "hash"

* Clean up 8/10 by losing the allocation and making the subject less
  misleading

* Add tests in 7/10 to ensure 8/10 does not change any behaviour

Denton Liu (9):
  SubmittingPatches: use generic terms for hash
  pretty-formats.txt: use generic terms for hash
  SubmittingPatches: remove dq from commit reference
  completion: complete `tformat:` pretty format
  revision: make get_revision_mark() return const pointer
  pretty.c: inline initalize format_context
  t4205: cover `git log --reflog -z` blindspot
  pretty: implement 'reference' format
  SubmittingPatches: use `--pretty=reference`

René Scharfe (1):
  pretty: provide short date format

 Documentation/SubmittingPatches        | 16 ++++--
 Documentation/pretty-formats.txt       | 28 +++++++---
 Documentation/pretty-options.txt       |  2 +-
 Documentation/rev-list-options.txt     |  4 +-
 contrib/completion/git-completion.bash |  2 +-
 pretty.c                               | 17 +++---
 revision.c                             |  4 +-
 revision.h                             |  4 +-
 t/t4205-log-pretty-formats.sh          | 72 ++++++++++++++++++++++++++
 9 files changed, 123 insertions(+), 26 deletions(-)

Range-diff against v2:
 1:  38a55e978f =  1:  5a9e19b37e SubmittingPatches: use generic terms for hash
 2:  9080b0db1f =  2:  4f2a9bef32 pretty-formats.txt: use generic terms for hash
 -:  ---------- >  3:  277d2b2506 SubmittingPatches: remove dq from commit reference
 -:  ---------- >  4:  442394eca8 completion: complete `tformat:` pretty format
 3:  1abab57072 =  5:  ca01bfa085 revision: make get_revision_mark() return const pointer
 4:  50ee13202c <  -:  ---------- revision: change abbrev_commit_given to abbrev_commit_explicit
 5:  45f0ceb476 !  6:  301e3adcdc pretty.c: inline initalize format_context
    @@ Commit message
         Instead of memsetting and then initializing the fields in the struct,
         move the initialization of `format_context` to its assignment.
     
    -    In preparation for a future commit where we mechanically move lines from
    -    repo_format_commit_message() into a helper function,
    -    `format_context.wrap_start` is not generically used so move its
    -    assignment closer to its use.
    -
         Signed-off-by: Denton Liu <liu.denton@gmail.com>
     
      ## pretty.c ##
    @@ pretty.c: void repo_format_commit_message(struct repository *r,
     -	struct format_commit_context context;
     +	struct format_commit_context context = {
     +		.commit = commit,
    -+		.pretty_ctx = pretty_ctx
    ++		.pretty_ctx = pretty_ctx,
    ++		.wrap_start = sb->len
     +	};
      	const char *output_enc = pretty_ctx->output_encoding;
      	const char *utf8 = "UTF-8";
    @@ pretty.c: void repo_format_commit_message(struct repository *r,
      	/*
      	 * convert a commit message to UTF-8 first
      	 * as far as 'format_commit_item' assumes it in UTF-8
    -@@ pretty.c: void repo_format_commit_message(struct repository *r,
    - 					       &context.commit_encoding,
    - 					       utf8);
    - 
    -+	context.wrap_start = sb->len;
    - 	strbuf_expand(sb, format, format_commit_item, &context);
    - 	rewrap_message_tail(sb, &context, 0, 0, 0);
    - 
 6:  e036a1a86d <  -:  ---------- pretty.c: extract functionality to repo_format_commit_generic()
 7:  7de6fe3282 !  7:  b1256c52ba t4205: cover `git log --reflog -z` blindspot
    @@ t/t4205-log-pretty-formats.sh: test_expect_failure C_LOCALE_OUTPUT 'NUL terminat
      	test_cmp expected actual
      '
      
    -+emit_nul () {
    -+	echo | tr '\n' '\000'
    -+}
    -+
     +for p in short medium full fuller email raw
     +do
     +	test_expect_success "NUL termination with --reflog --pretty=$p" '
    -+		>expect &&
     +		revs="$(git rev-list --reflog)" &&
     +		for r in $revs
     +		do
    -+			git show -s "$r" --pretty='$p' >>expect || return 1
    -+			emit_nul >>expect
    -+		done &&
    -+		git log -z --reflog --pretty='$p' >actual &&
    -+		emit_nul >>actual &&
    ++			git show -s "$r" --pretty="$p" &&
    ++			printf "\0" || return 1
    ++		done >expect &&
    ++		{
    ++			git log -z --reflog --pretty="$p" &&
    ++			printf "\0"
    ++		} >actual &&
     +		test_cmp expect actual
     +	'
     +done
     +
     +test_expect_success 'NUL termination with --reflog --pretty=oneline' '
    -+	>expect &&
     +	revs="$(git rev-list --reflog)" &&
     +	for r in $revs
     +	do
    -+		# trim trailing newline
    -+		output="$(git show -s --pretty=oneline "$r")" || return 1
    -+		printf "%s" "$output" >>expect
    -+		emit_nul >>expect
    -+	done &&
    ++		git show -s --pretty=oneline "$r" >raw &&
    ++		cat raw | lf_to_nul || exit 1
    ++	done >expect &&
    ++	# the trailing NUL is already produced so we do not need to
    ++	# output another one
     +	git log -z --pretty=oneline --reflog >actual &&
    -+	# no trailing NUL
     +	test_cmp expect actual
     +'
     +
 8:  3bda0f0ad7 <  -:  ---------- reflog-walk.c: move where the newline is added
 -:  ---------- >  8:  fe5cb165ae pretty: provide short date format
 9:  28c4f7f517 !  9:  470a2b0f4f pretty: implement 'summary' format
    @@ Metadata
     Author: Denton Liu <liu.denton@gmail.com>
     
      ## Commit message ##
    -    pretty: implement 'summary' format
    +    pretty: implement 'reference' format
     
         The standard format for referencing other commits within some projects
    -    (such as git.git) is the summary format. This is described in
    +    (such as git.git) is the reference format. This is described in
         Documentation/SubmittingPatches as
     
                 If you want to reference a previous commit in the history of a stable
    -            branch, use the format "abbreviated hash (subject, date)",
    -            with the subject enclosed in a pair of double-quotes, like this:
    +            branch, use the format "abbreviated hash (subject, date)", like this:
     
                 ....
    -                    Commit f86a374 ("pack-bitmap.c: fix a memleak", 2015-03-30)
    +                    Commit f86a374 (pack-bitmap.c: fix a memleak, 2015-03-30)
                         noticed that ...
                 ....
     
         Since this format is so commonly used, standardize it as a pretty
         format.
     
    -    This format is implemented as a separate flow that skips most of
    -    pretty_print_commit() and instead calls format_commit_summary(). The
    -    reason why this is done is because the other pretty formats expect
    -    output to be generated in a specific order. Specifically, the header,
    -    including the date, is always printed before the commit message,
    -    including the subject. Reversing the order would be possible but would
    -    involve butchering pretty_print_commit() so it is implemented as a
    -    separate flow.
    +    The tests that are implemented essentially show that the format-string
    +    does not change in response to various log options. This is useful
    +    because, for future developers, it shows that we've considered the
    +    limitations of the "canned format-string" approach and we are fine with
    +    them.
     
    +    Based-on-a-patch-by: SZEDER Gábor <szeder.dev@gmail.com>
         Signed-off-by: Denton Liu <liu.denton@gmail.com>
     
      ## Documentation/pretty-formats.txt ##
    @@ Documentation/pretty-formats.txt: This is designed to be as compact as possible.
      
      	       <full commit message>
      
    -+* 'summary'
    ++* 'reference'
     +
    -+	  <abbrev hash> ("<title line>", <short author date>)
    ++	  <abbrev hash> (<title line>, <short author date>)
     ++
     +This format is useful for referring to other commits when writing a new
    -+commit message. Although by default, '<abbrev hash>' is used, this can
    -+be overridden with '--no-abbrev'. In addition, '<short author date>' can
    -+be overridden by with '--date='.
    ++commit message. It uses the following canned user format:
    ++`%C(auto)%h (%s, %as)`. This means it will not respect options that
    ++change the output format such as `--date` `--no-abbrev-commit`, and
    ++`--walk-reflogs`.
     +
      * 'email'
      
    @@ Documentation/pretty-options.txt
      	Pretty-print the contents of the commit logs in a given format,
      	where '<format>' can be one of 'oneline', 'short', 'medium',
     -	'full', 'fuller', 'email', 'raw', 'format:<string>'
    -+	'full', 'fuller', 'summary', 'email', 'raw', 'format:<string>'
    ++	'full', 'fuller', 'reference', 'email', 'raw', 'format:<string>'
      	and 'tformat:<string>'.  When '<format>' is none of the above,
      	and has '%placeholder' in it, it acts as if
      	'--pretty=tformat:<format>' were given.
     
      ## Documentation/rev-list-options.txt ##
    -@@ Documentation/rev-list-options.txt: depending on a few rules:
    - 4. Otherwise, show the index format.
    - --
    +@@ Documentation/rev-list-options.txt: list.
    + 	exclude (that is, '{caret}commit', 'commit1..commit2',
    + 	and 'commit1\...commit2' notations cannot be used).
      +
    --Under `--pretty=oneline`, the commit message is
    -+Under `--pretty=oneline` and `--pretty=summary`, the commit message is
    +-With `--pretty` format other than `oneline` (for obvious reasons),
    ++With `--pretty` format other than `oneline` and `reference` (for obvious reasons),
    + this causes the output to have two extra lines of information
    + taken from the reflog.  The reflog designator in the output may be shown
    + as `ref@{Nth}` (where `Nth` is the reverse-chronological index in the
    +@@ Documentation/rev-list-options.txt: Under `--pretty=oneline`, the commit message is
      prefixed with this information on the same line.
      This option cannot be combined with `--reverse`.
      See also linkgit:git-reflog[1].
    +++
    ++Under `--pretty=summary`, this information will not be shown at all.
    + 
    + --merge::
    + 	After a failed merge, show refs that touch files having a
     
    - ## builtin/log.c ##
    -@@ builtin/log.c: static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
    - 		read_mailmap(rev->mailmap, NULL);
    - 	}
    + ## contrib/completion/git-completion.bash ##
    +@@ contrib/completion/git-completion.bash: __git_log_shortlog_options="
    + 	--all-match --invert-grep
    + "
      
    --	if (rev->pretty_given && rev->commit_format == CMIT_FMT_RAW) {
    -+	if (rev->pretty_given) {
    -+		switch (rev->commit_format) {
    -+
    - 		/*
    - 		 * "log --pretty=raw" is special; ignore UI oriented
    - 		 * configuration variables such as decoration.
    - 		 */
    --		if (!decoration_given)
    --			decoration_style = 0;
    --		if (!rev->abbrev_commit_explicit)
    --			rev->abbrev_commit = 0;
    -+		case CMIT_FMT_RAW:
    -+			if (!decoration_given)
    -+				decoration_style = 0;
    -+			if (!rev->abbrev_commit_explicit)
    -+				rev->abbrev_commit = 0;
    -+			break;
    -+
    -+		/*
    -+		 * "log --pretty=summary" is special; ignore UI oriented
    -+		 * configuration variables such as decoration but keep
    -+		 * abbreviations.
    -+		 */
    -+		case CMIT_FMT_SUMMARY:
    -+			if (!decoration_given)
    -+				decoration_style = 0;
    -+			if (!rev->abbrev_commit_explicit)
    -+				rev->abbrev_commit = 1;
    -+			break;
    -+
    -+		default:
    -+			break;
    -+		}
    - 	}
    +-__git_log_pretty_formats="oneline short medium full fuller email raw format: tformat: mboxrd"
    ++__git_log_pretty_formats="oneline short medium full fuller reference email raw format: tformat: mboxrd"
    + __git_log_date_formats="relative iso8601 iso8601-strict rfc2822 short local default raw unix format:"
      
    - 	if (decoration_style) {
    -
    - ## log-tree.c ##
    -@@ log-tree.c: void show_log(struct rev_info *opt)
    - 		ctx.print_email_subject = 1;
    - 	} else if (opt->commit_format != CMIT_FMT_USERFORMAT) {
    - 		fputs(diff_get_color_opt(&opt->diffopt, DIFF_COMMIT), opt->diffopt.file);
    --		if (opt->commit_format != CMIT_FMT_ONELINE)
    -+		if (opt->commit_format != CMIT_FMT_ONELINE &&
    -+		    opt->commit_format != CMIT_FMT_SUMMARY)
    - 			fputs("commit ", opt->diffopt.file);
    - 
    - 		if (!opt->graph)
    -@@ log-tree.c: void show_log(struct rev_info *opt)
    - 			       find_unique_abbrev(&parent->object.oid, abbrev_commit));
    - 		fputs(diff_get_color_opt(&opt->diffopt, DIFF_RESET), opt->diffopt.file);
    - 		show_decorations(opt, commit);
    --		if (opt->commit_format == CMIT_FMT_ONELINE) {
    -+		if (opt->commit_format == CMIT_FMT_ONELINE ||
    -+		    opt->commit_format == CMIT_FMT_SUMMARY) {
    - 			putc(' ', opt->diffopt.file);
    - 		} else {
    - 			putc('\n', opt->diffopt.file);
    -@@ log-tree.c: void show_log(struct rev_info *opt)
    - 			 * graph info here.
    - 			 */
    - 			show_reflog_message(opt->reflog_info,
    --					    opt->commit_format == CMIT_FMT_ONELINE,
    -+					    (opt->commit_format == CMIT_FMT_ONELINE ||
    -+					     opt->commit_format == CMIT_FMT_SUMMARY),
    - 					    &opt->date_mode,
    - 					    opt->date_mode_explicit);
    - 			if (opt->commit_format == CMIT_FMT_ONELINE) {
    - 				putc('\n', opt->diffopt.file);
    - 				return;
    -+			} else if (opt->commit_format == CMIT_FMT_SUMMARY) {
    -+				putc(' ', opt->diffopt.file);
    - 			}
    - 		}
    - 	}
    + _git_log ()
     
      ## pretty.c ##
     @@ pretty.c: static void setup_commit_formats(void)
    @@ pretty.c: static void setup_commit_formats(void)
      		{ "full",	CMIT_FMT_FULL,		0,	8 },
     -		{ "oneline",	CMIT_FMT_ONELINE,	1,	0 }
     +		{ "oneline",	CMIT_FMT_ONELINE,	1,	0 },
    -+		{ "summary",	CMIT_FMT_SUMMARY,	1,	0 },
    ++		{ "reference",	CMIT_FMT_USERFORMAT,	1,	0,
    ++			0, "%C(auto)%h (%s, %as)" },
      		/*
      		 * Please update $__git_log_pretty_formats in
      		 * git-completion.bash when you add new formats.
    -@@ pretty.c: void repo_format_commit_message(struct repository *r,
    - 				   do_repo_format_commit_message, (void *)format);
    - }
    - 
    -+static void do_repo_format_commit_summary(struct strbuf *sb,
    -+					  struct format_commit_context *context,
    -+					  void *additional_context)
    -+{
    -+	struct ident_split ident;
    -+
    -+	parse_commit_header(context);
    -+	parse_commit_message(context);
    -+
    -+	strbuf_addstr(sb, "(\"");
    -+	format_subject(sb, context->message + context->subject_off, " ");
    -+	if (!split_ident_line(&ident,
    -+			      context->message + context->author.off,
    -+			      context->author.len)) {
    -+		strbuf_addstr(sb, "\", ");
    -+		strbuf_addstr(sb, show_ident_date(&ident, &context->pretty_ctx->date_mode));
    -+	}
    -+	strbuf_addstr(sb, ")");
    -+}
    -+
    - static void pp_header(struct pretty_print_context *pp,
    - 		      const char *encoding,
    - 		      const struct commit *commit,
    -@@ pretty.c: void pretty_print_commit(struct pretty_print_context *pp,
    - 		format_commit_message(commit, user_format, sb, pp);
    - 		return;
    - 	}
    -+	if (pp->fmt == CMIT_FMT_SUMMARY) {
    -+		if (!pp->date_mode_explicit)
    -+			pp->date_mode = *DATE_MODE(SHORT);
    -+
    -+		repo_format_commit_generic(the_repository, commit, sb, pp,
    -+					   do_repo_format_commit_summary, NULL);
    -+		return;
    -+	}
    - 
    - 	encoding = get_log_output_encoding();
    - 	msg = reencoded = logmsg_reencode(commit, NULL, encoding);
    -
    - ## pretty.h ##
    -@@ pretty.h: enum cmit_fmt {
    - 	CMIT_FMT_FULL,
    - 	CMIT_FMT_FULLER,
    - 	CMIT_FMT_ONELINE,
    -+	CMIT_FMT_SUMMARY,
    - 	CMIT_FMT_EMAIL,
    - 	CMIT_FMT_MBOXRD,
    - 	CMIT_FMT_USERFORMAT,
     
      ## t/t4205-log-pretty-formats.sh ##
    -@@ t/t4205-log-pretty-formats.sh: do
    - 	'
    - done
    - 
    --test_expect_success 'NUL termination with --reflog --pretty=oneline' '
    --	>expect &&
    --	revs="$(git rev-list --reflog)" &&
    --	for r in $revs
    --	do
    --		# trim trailing newline
    --		output="$(git show -s --pretty=oneline "$r")" || return 1
    --		printf "%s" "$output" >>expect
    --		emit_nul >>expect
    --	done &&
    --	git log -z --pretty=oneline --reflog >actual &&
    --	# no trailing NUL
    --	test_cmp expect actual
    --'
    -+for p in oneline summary
    -+do
    -+	test_expect_success "NUL termination with --reflog --pretty=$p" '
    -+		>expect &&
    -+		revs="$(git rev-list --reflog)" &&
    -+		for r in $revs
    -+		do
    -+			# trim trailing newline
    -+			output="$(git show -s --pretty='$p' "$r")" || return 1
    -+			printf "%s" "$output" >>expect
    -+			emit_nul >>expect
    -+		done &&
    -+		git log -z --pretty='$p' --reflog >actual &&
    -+		# no trailing NUL
    -+		test_cmp expect actual
    -+	'
    -+done
    - 
    - test_expect_success 'setup more commits' '
    - 	test_commit "message one" one one message-one &&
     @@ t/t4205-log-pretty-formats.sh: test_expect_success '%S in git log --format works with other placeholders (part
      	test_cmp expect actual
      '
      
    -+test_expect_success 'log --pretty=summary' '
    -+	git log --date=short --pretty="tformat:%h (\"%s\", %ad)" >expect &&
    -+	git log --pretty=summary >actual &&
    ++test_expect_success 'log --pretty=reference' '
    ++	git log --pretty="tformat:%h (%s, %as)" >expect &&
    ++	git log --pretty=reference >actual &&
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'log --pretty=summary with log.date is overridden by short date' '
    -+	git log --date=short --pretty="tformat:%h (\"%s\", %ad)" >expect &&
    -+	test_config log.date rfc &&
    -+	git log --pretty=summary >actual &&
    ++test_expect_success 'log --pretty=reference always uses short date' '
    ++	git log --pretty="tformat:%h (%s, %as)" >expect &&
    ++	git log --date=rfc --pretty=reference >actual &&
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'log --pretty=summary with explicit date overrides short date' '
    -+	git log --date=rfc --pretty="tformat:%h (\"%s\", %ad)" >expect &&
    -+	git log --date=rfc --pretty=summary >actual &&
    ++test_expect_success 'log --pretty=reference is never unabbreviated' '
    ++	git log --pretty="tformat:%h (%s, %as)" >expect &&
    ++	git log --no-abbrev-commit --pretty=reference >actual &&
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'log --pretty=summary with log.abbrevCommit is overidden' '
    -+	git log --date=short --pretty="tformat:%h (\"%s\", %ad)" >expect &&
    -+	test_config log.abbrevCommit false &&
    -+	git log --pretty=summary >actual &&
    ++test_expect_success 'log --pretty=reference is never decorated' '
    ++	git log --pretty="tformat:%h (%s, %as)" >expect &&
    ++	git log --decorate=short --pretty=reference >actual &&
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'log --pretty=summary with explicit --no-abbrev overrides abbreviated' '
    -+	git log --date=short --pretty="tformat:%H (\"%s\", %ad)" >expect &&
    -+	git log --no-abbrev --pretty=summary >actual &&
    ++test_expect_success 'log --pretty=reference does not output reflog info' '
    ++	git log --walk-reflogs --pretty="tformat:%h (%s, %as)" >expect &&
    ++	git log --walk-reflogs --pretty=reference >actual &&
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'log --pretty=summary with log.decorate is overridden' '
    -+	git log --date=short --pretty="tformat:%h (\"%s\", %ad)" >expect &&
    -+	test_config log.decorate short &&
    -+	git log --pretty=summary >actual &&
    -+	test_cmp expect actual
    -+'
    -+
    -+test_expect_success 'log --pretty=summary with explicit decorate overrides no decoration' '
    -+	git log --date=short --pretty="tformat:%h%d (\"%s\", %ad)" >expect &&
    -+	git log --decorate=short --pretty=summary >actual &&
    -+	test_cmp expect actual
    -+'
    -+
    -+test_expect_success 'log --pretty=summary with --walk-reflogs' '
    -+	test_config log.date short &&
    -+	git log --walk-reflogs --pretty="tformat:%h %gd: %gs (\"%s\", %ad)" >expect &&
    -+	git log --walk-reflogs --pretty=summary >actual &&
    ++test_expect_success 'log --pretty=reference is colored appropriately' '
    ++	git log --color=always --pretty="tformat:%C(auto)%h (%s, %as)" >expect &&
    ++	git log --color=always --pretty=reference >actual &&
     +	test_cmp expect actual
     +'
     +
10:  a6638f0c7c ! 10:  5f80e4633d SubmittingPatches: use `--pretty=summary`
    @@ Metadata
     Author: Denton Liu <liu.denton@gmail.com>
     
      ## Commit message ##
    -    SubmittingPatches: use `--pretty=summary`
    +    SubmittingPatches: use `--pretty=reference`
     
    -    Since Git was taught the `--pretty=summary` option, it is no longer
    +    Since Git was taught the `--pretty=reference` option, it is no longer
         necessary to manually specify the format string to get the commit
    -    summary. Teach users to use the new option while keeping the old
    +    reference. Teach users to use the new option while keeping the old
         invocation around in case they have an older version of Git.
     
         Signed-off-by: Denton Liu <liu.denton@gmail.com>
     
      ## Documentation/SubmittingPatches ##
    -@@ Documentation/SubmittingPatches: with the subject enclosed in a pair of double-quotes, like this:
    - The "Copy commit summary" command of gitk can be used to obtain this
    - format, or this invocation of `git show`:
    +@@ Documentation/SubmittingPatches: The "Copy commit summary" command of gitk can be used to obtain this
    + format (with the subject enclosed in a pair of double-quotes), or this
    + invocation of `git show`:
      
     +....
    -+	git show -s --pretty=summary <commit>
    ++	git show -s --pretty=reference <commit>
     +....
     +
    -+or, on an older version of Git without support for --pretty=summary:
    ++or, on an older version of Git without support for --pretty=reference:
     +
      ....
    - 	git show -s --date=short --pretty='format:%h ("%s", %ad)' <commit>
    + 	git show -s --date=short --pretty='format:%h (%s, %ad)' <commit>
      ....
-- 
2.24.0.346.gee0de6d492


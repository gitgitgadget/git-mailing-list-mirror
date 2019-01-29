Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE4491F453
	for <e@80x24.org>; Tue, 29 Jan 2019 10:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfA2KVU (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 05:21:20 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41077 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfA2KVU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 05:21:20 -0500
Received: by mail-pl1-f196.google.com with SMTP id u6so9151604plm.8
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 02:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EnBTk49f4AulpbZeUH1ZJIMjhJnx3nxSXBJ7W1yiRjw=;
        b=K6ns+c2I2oGxDxpmxKdKgce5z4BfjYGlSzbqKYuIClLZpQ4X4Dbe/vuNKNnICznEWY
         js1GUBmlB5/zMHh1lBk7owGQ2b4Pxiv2NP562SA+s+wl+2ArjSN+NDQhD4yAfgGHx0kY
         61YQEeRUKNhbHJUxqtv3EBuAGBBfaew5RFmvqVaDV/iIHpKdVX1yBWu31DPcZhDMjEbZ
         qK5gRkw1+qH08eY8Ms6Bd5Z67iSZW1s0pcFUp4r5Atn14vnwmecdCxr6kwARy7RrLrUC
         eV0AjmgZbaGLcCzbeKjj50gsTpdGSsQV4WDCq0265SyxSI4+lYed7CUTpyEIU0F8Lx0t
         6PXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EnBTk49f4AulpbZeUH1ZJIMjhJnx3nxSXBJ7W1yiRjw=;
        b=AlUiG+fILH8ufrdpFzu8aP5VtWLGZjf49GQEAP6SBlbCWHDUHrB/PiF3jPo8vhNw7X
         4yj9OEWs6/TPuBCY1FZZSVYJLxaas4H+98xpykw4XcZQjg1HletPCFuJThGyRSRNSC1J
         uOssHIvxyiKet4r4MCc5M77SewDJb86gf0cSPiON290ktnz9K81+RQl1MncExHZgmEbQ
         GWdukbHE1ps+BGgrojJ/x+oLTisNG1HYM+nKrzu+O9G3V4WqlUeOn4hM6iPiFG9VC2bt
         yFxXJ7iDnmVwASXbeYFTzQ+RxSO3X85bJ/zL6WyLeo6OX7QAE+yXReXEy8FB3sl8+aED
         v4+g==
X-Gm-Message-State: AJcUukeuXMrsNeK0HIf1wTWBRLzJ5KDO76L34aEkbgoYZRNS7L2cR4ov
        Y2OCNtCBJCnjnUlFtdFLh3boUPkR
X-Google-Smtp-Source: ALg8bN7fuK+xLI2UzXe+pyduz63mv8WFP9tiBpQkf143HQKEmYcV6niq2DlU8yKilrvos9Kw02Aolw==
X-Received: by 2002:a17:902:1745:: with SMTP id i63mr24846089pli.145.1548757279210;
        Tue, 29 Jan 2019 02:21:19 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id b2sm62578817pfm.3.2019.01.29.02.21.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 02:21:17 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 29 Jan 2019 17:21:13 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] completion: add more parameter value completion
Date:   Tue, 29 Jan 2019 17:21:11 +0700
Message-Id: <20190129102111.15333-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.560.g70ca8b83ee
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds value completion for a couple more paramters. To make it
easier to maintain these hard coded lists, add a comment at the original
list/code to remind people to update git-completion.bash too.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 This 6 month old patch was part of the attempt to automate value
 completion. That might never come, but at least this is still good.

 apply.c                                |  4 +++
 builtin/am.c                           |  4 +++
 builtin/commit.c                       |  8 +++++
 builtin/help.c                         |  4 +++
 builtin/log.c                          |  8 +++++
 builtin/pull.c                         |  4 +++
 builtin/replace.c                      |  4 +++
 contrib/completion/git-completion.bash | 43 ++++++++++++++++++++++++--
 date.c                                 |  4 +++
 diff.c                                 |  8 +++++
 git-send-email.perl                    |  6 ++++
 list-objects-filter-options.c          |  4 +++
 merge-recursive.c                      |  4 +++
 pretty.c                               |  4 +++
 ref-filter.c                           |  4 +++
 submodule-config.c                     |  9 +++++-
 submodule.c                            |  4 +++
 xdiff-interface.c                      |  4 +++
 18 files changed, 126 insertions(+), 4 deletions(-)

diff --git a/apply.c b/apply.c
index 3703bfc8d0..1d09cd30bf 100644
--- a/apply.c
+++ b/apply.c
@@ -56,6 +56,10 @@ static int parse_whitespace_option(struct apply_state *state, const char *option
 		state->ws_error_action = correct_ws_error;
 		return 0;
 	}
+	/*
+	 * Please update $__git_whitespacelist in git-completion.bash
+	 * when you add new options.
+	 */
 	return error(_("unrecognized whitespace option '%s'"), option);
 }
 
diff --git a/builtin/am.c b/builtin/am.c
index 95370313b6..b8fda67df0 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2125,6 +2125,10 @@ static int parse_opt_patchformat(const struct option *opt, const char *arg, int
 		*opt_value = PATCH_FORMAT_HG;
 	else if (!strcmp(arg, "mboxrd"))
 		*opt_value = PATCH_FORMAT_MBOXRD;
+	/*
+	 * Please update $__git_patchformat in git-completion.bash
+	 * when you add new options
+	 */
 	else
 		return error(_("Invalid value for --patch-format: %s"), arg);
 	return 0;
diff --git a/builtin/commit.c b/builtin/commit.c
index 004b816635..11cd807f0c 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1036,6 +1036,10 @@ static void handle_untracked_files_arg(struct wt_status *s)
 		s->show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
 	else if (!strcmp(untracked_files_arg, "all"))
 		s->show_untracked_files = SHOW_ALL_UNTRACKED_FILES;
+	/*
+	 * Please update $__git_untracked_file_modes in
+	 * git-completion.bash when add new options
+	 */
 	else
 		die(_("Invalid untracked files mode '%s'"), untracked_files_arg);
 }
@@ -1177,6 +1181,10 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	else if (!strcmp(cleanup_arg, "scissors"))
 		cleanup_mode = use_editor ? COMMIT_MSG_CLEANUP_SCISSORS :
 					    COMMIT_MSG_CLEANUP_SPACE;
+	/*
+	 * Please update _git_commit() in git-completion.bash when you
+	 * add new options.
+	 */
 	else
 		die(_("Invalid cleanup mode %s"), cleanup_arg);
 
diff --git a/builtin/help.c b/builtin/help.c
index 7739a5c155..eef8b7c802 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -70,6 +70,10 @@ static enum help_format parse_help_format(const char *format)
 		return HELP_FORMAT_INFO;
 	if (!strcmp(format, "web") || !strcmp(format, "html"))
 		return HELP_FORMAT_WEB;
+	/*
+	 * Please update _git_config() in git-completion.bash when you
+	 * add new rebase modes.
+	 */
 	die(_("unrecognized help format '%s'"), format);
 }
 
diff --git a/builtin/log.c b/builtin/log.c
index 3e145fe502..68a2411b2f 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -83,6 +83,10 @@ static int parse_decoration_style(const char *value)
 		return DECORATE_SHORT_REFS;
 	else if (!strcmp(value, "auto"))
 		return auto_decoration_style();
+	/*
+	 * Please update _git_log() in git-completion.bash when you
+	 * add new decoration styles.
+	 */
 	return -1;
 }
 
@@ -1225,6 +1229,10 @@ static int thread_callback(const struct option *opt, const char *arg, int unset)
 		*thread = THREAD_SHALLOW;
 	else if (!strcmp(arg, "deep"))
 		*thread = THREAD_DEEP;
+	/*
+	 * Please update _git_formatpatch() in git-completion.bash
+	 * when you add new options.
+	 */
 	else
 		return 1;
 	return 0;
diff --git a/builtin/pull.c b/builtin/pull.c
index 74808b9455..ab8da063b4 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -55,6 +55,10 @@ static enum rebase_type parse_config_rebase(const char *key, const char *value,
 		return REBASE_MERGES;
 	else if (!strcmp(value, "interactive") || !strcmp(value, "i"))
 		return REBASE_INTERACTIVE;
+	/*
+	 * Please update _git_config() in git-completion.bash when you
+	 * add new rebase modes.
+	 */
 
 	if (fatal)
 		die(_("Invalid value for %s: %s"), key, value);
diff --git a/builtin/replace.c b/builtin/replace.c
index affcdfb416..1c312725d1 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -82,6 +82,10 @@ static int list_replace_refs(const char *pattern, const char *format)
 		data.format = REPLACE_FORMAT_MEDIUM;
 	else if (!strcmp(format, "long"))
 		data.format = REPLACE_FORMAT_LONG;
+	/*
+	 * Please update _git_replace() in git-completion.bash when
+	 * you add ne format
+	 */
 	else
 		return error(_("invalid replace format '%s'\n"
 			       "valid formats are 'short', 'medium' and 'long'"),
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 499e56f83d..907855184c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -853,6 +853,11 @@ __git_compute_merge_strategies ()
 	__git_merge_strategies=$(__git_list_merge_strategies)
 }
 
+__git_merge_strategy_options="ours theirs subtree subtree= patience
+	histogram diff-algorithm= ignore-space-change ignore-all-space
+	ignore-space-at-eol renormalize no-renormalize no-renames
+	find-renames find-renames= rename-threshold="
+
 __git_complete_revlist_file ()
 {
 	local dequoted_word pfx ls ref cur_="$cur"
@@ -996,12 +1001,21 @@ __git_complete_strategy ()
 	-s|--strategy)
 		__gitcomp "$__git_merge_strategies"
 		return 0
+		;;
+	-X)
+		__gitcomp "$__git_merge_strategy_options"
+		return 0
+		;;
 	esac
 	case "$cur" in
 	--strategy=*)
 		__gitcomp "$__git_merge_strategies" "" "${cur##--strategy=}"
 		return 0
 		;;
+	--strategy-option=*)
+		__gitcomp "$__git_merge_strategy_options" "" "${cur##--strategy-option=}"
+		return 0
+		;;
 	esac
 	return 1
 }
@@ -1163,6 +1177,7 @@ __git_count_arguments ()
 }
 
 __git_whitespacelist="nowarn warn error error-all fix"
+__git_patchformat="mbox stgit stgit-series hg mboxrd"
 __git_am_inprogress_options="--skip --continue --resolved --abort --quit --show-current-patch"
 
 _git_am ()
@@ -1177,6 +1192,10 @@ _git_am ()
 		__gitcomp "$__git_whitespacelist" "" "${cur##--whitespace=}"
 		return
 		;;
+	--patch-format=*)
+		__gitcomp "$__git_patchformat" "" "${cur##--patch-format=}"
+		return
+		;;
 	--*)
 		__gitcomp_builtin am "" \
 			"$__git_am_inprogress_options"
@@ -1200,6 +1219,10 @@ _git_apply ()
 _git_add ()
 {
 	case "$cur" in
+	--chmod=*)
+		__gitcomp "+x -x" "" "${cur##--chmod=}"
+		return
+		;;
 	--*)
 		__gitcomp_builtin add
 		return
@@ -1260,6 +1283,8 @@ _git_bisect ()
 	esac
 }
 
+__git_ref_fieldlist="refname objecttype objectsize objectname upstream push HEAD symref"
+
 _git_branch ()
 {
 	local i c=1 only_local_ref="n" has_r="n"
@@ -1343,6 +1368,9 @@ _git_cherry_pick ()
 		__gitcomp "$__git_cherry_pick_inprogress_options"
 		return
 	fi
+
+	__git_complete_strategy && return
+
 	case "$cur" in
 	--*)
 		__gitcomp_builtin cherry-pick "" \
@@ -1506,6 +1534,10 @@ _git_fetch ()
 		__gitcomp "$__git_fetch_recurse_submodules" "" "${cur##--recurse-submodules=}"
 		return
 		;;
+	--filter=*)
+		__gitcomp "blob:none blob:limit= sparse:oid= sparse:path=" "" "${cur##--filter=}"
+		return
+		;;
 	--*)
 		__gitcomp_builtin fetch
 		return
@@ -1702,8 +1734,8 @@ __git_log_shortlog_options="
 	--all-match --invert-grep
 "
 
-__git_log_pretty_formats="oneline short medium full fuller email raw format:"
-__git_log_date_formats="relative iso8601 rfc2822 short local default raw"
+__git_log_pretty_formats="oneline short medium full fuller email raw format: mboxrd"
+__git_log_date_formats="relative iso8601 iso8601-strict rfc2822 short local default raw unix format:"
 
 _git_log ()
 {
@@ -2221,7 +2253,7 @@ _git_config ()
 		return
 		;;
 	diff.submodule)
-		__gitcomp "log short"
+		__gitcomp "$__git_diff_submodule_formats"
 		return
 		;;
 	help.format)
@@ -2388,6 +2420,10 @@ _git_remote ()
 _git_replace ()
 {
 	case "$cur" in
+	--format=*)
+		__gitcomp "short medium long" "" "${cur##--format=}"
+		return
+		;;
 	--*)
 		__gitcomp_builtin replace
 		return
@@ -2429,6 +2465,7 @@ _git_revert ()
 		__gitcomp "$__git_revert_inprogress_options"
 		return
 	fi
+	__git_complete_strategy && return
 	case "$cur" in
 	--*)
 		__gitcomp_builtin revert "" \
diff --git a/date.c b/date.c
index 9bc15df6f9..6d517871f4 100644
--- a/date.c
+++ b/date.c
@@ -825,6 +825,10 @@ static enum date_mode_type parse_date_type(const char *format, const char **end)
 		return DATE_UNIX;
 	if (skip_prefix(format, "format", end))
 		return DATE_STRFTIME;
+	/*
+	 * Please update $__git_log_date_formats in
+	 * git-completion.bash when you add new formats.
+	 */
 
 	die("unknown date format %s", format);
 }
diff --git a/diff.c b/diff.c
index 1b5f276360..ffa497b203 100644
--- a/diff.c
+++ b/diff.c
@@ -178,6 +178,10 @@ static int parse_submodule_params(struct diff_options *options, const char *valu
 		options->submodule_format = DIFF_SUBMODULE_SHORT;
 	else if (!strcmp(value, "diff"))
 		options->submodule_format = DIFF_SUBMODULE_INLINE_DIFF;
+	/*
+	 * Please update $__git_diff_submodule_formats in
+	 * git-completion.bash when you add new formats.
+	 */
 	else
 		return -1;
 	return 0;
@@ -204,6 +208,10 @@ long parse_algorithm_value(const char *value)
 		return XDF_PATIENCE_DIFF;
 	else if (!strcasecmp(value, "histogram"))
 		return XDF_HISTOGRAM_DIFF;
+	/*
+	 * Please update $__git_diff_algorithms in git-completion.bash
+	 * when you add new algorithms.
+	 */
 	return -1;
 }
 
diff --git a/git-send-email.perl b/git-send-email.perl
index 8eb63b5a2f..8200d58cdc 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -465,6 +465,8 @@ sub read_config {
 my(%suppress_cc);
 if (@suppress_cc) {
 	foreach my $entry (@suppress_cc) {
+		# Please update $__git_send_email_suppresscc_options
+		# in git-completion.bash when you add new options.
 		die sprintf(__("Unknown --suppress-cc field: '%s'\n"), $entry)
 			unless $entry =~ /^(?:all|cccmd|cc|author|self|sob|body|bodycc|misc-by)$/;
 		$suppress_cc{$entry} = 1;
@@ -494,6 +496,8 @@ sub read_config {
 if ($confirm_unconfigured) {
 	$confirm = scalar %suppress_cc ? 'compose' : 'auto';
 };
+# Please update $__git_send_email_confirm_options in
+# git-completion.bash when you add new options.
 die sprintf(__("Unknown --confirm setting: '%s'\n"), $confirm)
 	unless $confirm =~ /^(?:auto|cc|compose|always|never)/;
 
@@ -587,6 +591,8 @@ sub parse_sendmail_aliases {
 		if (/\(define-mail-alias\s+"(\S+?)"\s+"(\S+?)"\)/) {
 			$aliases{$1} = [ $2 ];
 		}}}
+	# Please update _git_config() in git-completion.bash when you
+	# add new MUAs.
 );
 
 if (@alias_files and $aliasfiletype and defined $parse_alias{$aliasfiletype}) {
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index e8da2e8581..24f1c95560 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -82,6 +82,10 @@ static int gently_parse_list_objects_filter(
 		filter_options->sparse_path_value = strdup(v0);
 		return 0;
 	}
+	/*
+	 * Please update _git_fetch() in git-completion.bash when you
+	 * add new filter
+	 */
 
 	if (errbuf)
 		strbuf_addf(errbuf, "invalid filter-spec '%s'", arg);
diff --git a/merge-recursive.c b/merge-recursive.c
index 59ba4b4a1a..be08f74ea4 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3749,6 +3749,10 @@ int parse_merge_opt(struct merge_options *o, const char *s)
 			return -1;
 		o->merge_detect_rename = 1;
 	}
+	/*
+	 * Please update $__git_merge_strategy_options in
+	 * git-completion.bash when you add new options
+	 */
 	else
 		return -1;
 	return 0;
diff --git a/pretty.c b/pretty.c
index b83a3ecd23..876c1195f5 100644
--- a/pretty.c
+++ b/pretty.c
@@ -98,6 +98,10 @@ static void setup_commit_formats(void)
 		{ "fuller",	CMIT_FMT_FULLER,	0,	8 },
 		{ "full",	CMIT_FMT_FULL,		0,	8 },
 		{ "oneline",	CMIT_FMT_ONELINE,	1,	0 }
+		/*
+		 * Please update $__git_log_pretty_formats in
+		 * git-completion.bash when you add new formats.
+		 */
 	};
 	commit_formats_len = ARRAY_SIZE(builtin_formats);
 	builtin_formats_len = commit_formats_len;
diff --git a/ref-filter.c b/ref-filter.c
index 422a9c9ae3..cf80d4d69b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -485,6 +485,10 @@ static struct {
 	{ "if", SOURCE_NONE, FIELD_STR, if_atom_parser },
 	{ "then", SOURCE_NONE },
 	{ "else", SOURCE_NONE },
+	/*
+	 * Please update $__git_ref_fieldlist in git-completion.bash
+	 * when you add new atoms
+	 */
 };
 
 #define REF_FORMATTING_STATE_INIT  { 0, NULL }
diff --git a/submodule-config.c b/submodule-config.c
index 52702c62d9..66653e86b9 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -281,7 +281,10 @@ static int parse_fetch_recurse(const char *opt, const char *arg,
 	default:
 		if (!strcmp(arg, "on-demand"))
 			return RECURSE_SUBMODULES_ON_DEMAND;
-
+		/*
+		 * Please update $__git_fetch_recurse_submodules in
+		 * git-completion.bash when you add new options.
+		 */
 		if (die_on_error)
 			die("bad %s argument: %s", opt, arg);
 		else
@@ -362,6 +365,10 @@ static int parse_push_recurse(const char *opt, const char *arg,
 			return RECURSE_SUBMODULES_CHECK;
 		else if (!strcmp(arg, "only"))
 			return RECURSE_SUBMODULES_ONLY;
+		/*
+		 * Please update $__git_push_recurse_submodules in
+		 * git-completion.bash when you add new modes.
+		 */
 		else if (die_on_error)
 			die("bad %s argument: %s", opt, arg);
 		else
diff --git a/submodule.c b/submodule.c
index d393e947e6..f8c6ac11be 100644
--- a/submodule.c
+++ b/submodule.c
@@ -434,6 +434,10 @@ void handle_ignore_submodules_arg(struct diff_options *diffopt,
 		diffopt->flags.ignore_dirty_submodules = 1;
 	else if (strcmp(arg, "none"))
 		die("bad --ignore-submodules argument: %s", arg);
+	/*
+	 * Please update _git_status() in git-completion.bash when you
+	 * add new options
+	 */
 }
 
 static int prepare_submodule_summary(struct rev_info *rev, const char *path,
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 80f060d278..8509f9ea22 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -306,6 +306,10 @@ int git_xmerge_config(const char *var, const char *value, void *cb)
 			git_xmerge_style = XDL_MERGE_DIFF3;
 		else if (!strcmp(value, "merge"))
 			git_xmerge_style = 0;
+		/*
+		 * Please update _git_checkout() in
+		 * git-completion.bash when you add new merge config
+		 */
 		else
 			die("unknown style '%s' given for '%s'",
 			    value, var);
-- 
2.20.1.560.g70ca8b83ee


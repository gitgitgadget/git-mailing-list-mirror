Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3222200B9
	for <e@80x24.org>; Sat,  5 May 2018 02:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751736AbeEECmz (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 22:42:55 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:37867 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751572AbeEECmx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 22:42:53 -0400
Received: by mail-pf0-f175.google.com with SMTP id e9so14786189pfi.4
        for <git@vger.kernel.org>; Fri, 04 May 2018 19:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WZoIiX7/1aM63XkNZ+BRHO/zCBxlIw1BUh6fZn2Y87g=;
        b=Tx3YYX3dVGFRvtBCkHOzgF42qXBI6thfSXfQlOluX8ys0dT42q6IEx11kLmuSCNZIq
         k8N01BxWYrBQMNOpuXScfi9PwOA0PNdBhbReEwHTRmGybHHj0DJlef2RpmaXaC0LhxRJ
         xMvKanstxhAW6ktHyMt2zQv3hmV6xedNp0m2spha4FGF/doB2ptWz4xk3ydZ7IOtrfU5
         dW7c15fmWfCsjAIsNf/p07JNpFyHGv5WLCEj7AsxBUM/R0PctmNRyYhXDbb22bmkwJpe
         8WMTFW61FGxsKfo8HLq72aG4TMVUI6QSMo8Yi5VKZn0neWKVHtykCYulYrsE3Pki9SUZ
         3Tzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WZoIiX7/1aM63XkNZ+BRHO/zCBxlIw1BUh6fZn2Y87g=;
        b=iaPQew14FRk/pK2nhCGarpCVis8BmZo+/bHTznxK0/QpRw7s9bl/JAJ3kQc4Op+w68
         +w4OpqLBrQEOgulaJ2HaZ5qGmh/4YTxCf4yEstIKiKLdPsyR1ErskJNzABa6n6haFYTX
         r3wbS6X+5QEvydI/PPWrC1x4EjjPpOdv2Xt/FRqLeWYN5WINeQ1fjqFdoIBZx93fAXA3
         whN6RoCAOG/+KsEg0I0d3Sn+3cvFlGW72PieVRpJeyCYaz1g8/DcKJ1RQldbM0/o+Bwv
         t2rKVvjpYG0IxkPFfbuEHvfrS9GYehYnxZ4f+DSrHD0VpFVIqhEfYrGeAIy/bBiajJcX
         X21g==
X-Gm-Message-State: ALQs6tB2DlbMIpXBTgDuBBvixCD098SVs8zTyWZlR8QwvDtdOItBc4y5
        ripefGZ7I/xNYsSX0IMMordQKnN2fxTUuQ==
X-Google-Smtp-Source: AB8JxZqUYWlCJQNIhr5CYLPA/0nWRYJwpP2qPtoLO4F1Fa+Q6RhINYUcdvjaGiV8A2Z/whNjDlsiVg==
X-Received: by 2002:a17:902:76c3:: with SMTP id j3-v6mr5682185plt.376.1525488172279;
        Fri, 04 May 2018 19:42:52 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:a961:c277:c90f:2435])
        by smtp.gmail.com with ESMTPSA id p24sm25685913pfk.58.2018.05.04.19.42.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 May 2018 19:42:51 -0700 (PDT)
Date:   Fri, 4 May 2018 19:42:50 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, l.s.r@web.de,
        martin.agren@gmail.com, peff@peff.net, sunshine@sunshineco.com
Subject: [PATCH v4 0/7] Teach '--column' to 'git-grep(1)'
Message-ID: <cover.1525488108.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180421034530.GB24606@syl.local>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Attached is my fourth--and what I anticipate to be the final--re-roll of
my series to add teach 'git-grep(1)' a new '--column' flag.

Since last time, I have changed the following:

  * Respond to Ævar's review suggesting that I (1) change git-jump's
    README, (2) use --column over --column-number, and (3) use /*\n, not
    /**\n. [1].

This change comprises the majority of the inter-diff between v3..v4,
which is added below for conveniency. I have chosen to additionally
rename the configuration variables from columnNumber to column, to be
consistent with the new flag name.

Thanks in advance for your review. I am going to send out my next patch
(which Ævar suggested) to add '--only-matching' to 'git-grep(1)'.


Thanks,
Taylor

[1]: https://public-inbox.org/git/874lk2e4he.fsf@evledraar.gmail.com

Taylor Blau (7):
  Documentation/config.txt: camel-case lineNumber for consistency
  grep.c: expose matched column in match_line()
  grep.[ch]: extend grep_opt to allow showing matched column
  grep.c: display column number of first match
  builtin/grep.c: add '--column' option to 'git-grep(1)'
  grep.c: add configuration variables to show matched option
  contrib/git-jump/git-jump: jump to match column in addition to line

 Documentation/config.txt   |  7 ++++++-
 Documentation/git-grep.txt |  8 +++++++-
 builtin/grep.c             |  1 +
 contrib/git-jump/README    |  6 +++---
 contrib/git-jump/git-jump  |  2 +-
 grep.c                     | 39 +++++++++++++++++++++++++++++---------
 grep.h                     |  2 ++
 t/t7810-grep.sh            | 22 +++++++++++++++++++++
 8 files changed, 72 insertions(+), 15 deletions(-)

Inter-diff (since v3):

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8a2893d1e1..b3c861c5c3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1159,8 +1159,8 @@ color.grep.<slot>::
 	function name lines (when using `-p`)
 `lineNumber`;;
 	line number prefix (when using `-n`)
-`columnNumber`;;
-	column number prefix (when using `--column-number`)
+`column`;;
+	column number prefix (when using `--column`)
 `match`;;
 	matching text (same as setting `matchContext` and `matchSelected`)
 `matchContext`;;
@@ -1710,8 +1710,8 @@ gitweb.snapshot::
 grep.lineNumber::
 	If set to true, enable `-n` option by default.

-grep.columnNumber::
-	If set to true, enable the `--column-number` option by default.
+grep.column::
+	If set to true, enable the `--column` option by default.

 grep.patternType::
 	Set the default matching behavior. Using a value of 'basic', 'extended',
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index c5c4d712e6..d451cd8883 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	   [-v | --invert-match] [-h|-H] [--full-name]
 	   [-E | --extended-regexp] [-G | --basic-regexp]
 	   [-P | --perl-regexp]
-	   [-F | --fixed-strings] [-n | --line-number] [--column-number]
+	   [-F | --fixed-strings] [-n | --line-number] [--column]
 	   [-l | --files-with-matches] [-L | --files-without-match]
 	   [(-O | --open-files-in-pager) [<pager>]]
 	   [-z | --null]
@@ -44,8 +44,8 @@ CONFIGURATION
 grep.lineNumber::
 	If set to true, enable `-n` option by default.

-grep.columnNumber::
-	If set to true, enable the `--column-number` option by default.
+grep.column::
+	If set to true, enable the `--column` option by default.

 grep.patternType::
 	Set the default matching behavior. Using a value of 'basic', 'extended',
@@ -172,7 +172,7 @@ providing this option will cause it to die.
 --line-number::
 	Prefix the line number to matching lines.

---column-number::
+--column::
 	Prefix the 1-indexed column number of the first match on non-context lines.

 -l::
diff --git a/builtin/grep.c b/builtin/grep.c
index 512f60c591..5c83f17759 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -829,7 +829,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			    GREP_PATTERN_TYPE_PCRE),
 		OPT_GROUP(""),
 		OPT_BOOL('n', "line-number", &opt.linenum, N_("show line numbers")),
-		OPT_BOOL(0, "column-number", &opt.columnnum, N_("show column number of first match")),
+		OPT_BOOL(0, "column", &opt.columnnum, N_("show column number of first match")),
 		OPT_NEGBIT('h', NULL, &opt.pathname, N_("don't show filenames"), 1),
 		OPT_BIT('H', NULL, &opt.pathname, N_("show filenames"), 1),
 		OPT_NEGBIT(0, "full-name", &opt.relative,
diff --git a/contrib/git-jump/README b/contrib/git-jump/README
index 4484bda410..7630e16854 100644
--- a/contrib/git-jump/README
+++ b/contrib/git-jump/README
@@ -35,7 +35,7 @@ Git-jump can generate four types of interesting lists:

   2. The beginning of any merge conflict markers.

-  3. Any grep matches.
+  3. Any grep matches, including the column of the first match on a line.

   4. Any whitespace errors detected by `git diff --check`.

@@ -65,7 +65,7 @@ git jump grep foo_bar
 git jump grep -i foo_bar

 # use the silver searcher for git jump grep
-git config jump.grepCmd "ag --column"
+git config jump.grepCmd "ag"
 --------------------------------------------------


@@ -82,7 +82,7 @@ which does something similar to `git jump grep`. However, it is limited
 to positioning the cursor to the correct line in only the first file,
 leaving you to locate subsequent hits in that file or other files using
 the editor or pager. By contrast, git-jump provides the editor with a
-complete list of files and line numbers for each match.
+complete list of files, lines, and a column number for each match.


 Limitations
diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index 8bc57ea0f8..931b0fe3a9 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -52,7 +52,7 @@ mode_merge() {
 # editor shows them to us in the status bar.
 mode_grep() {
 	cmd=$(git config jump.grepCmd)
-	test -n "$cmd" || cmd="git grep -n --column-number"
+	test -n "$cmd" || cmd="git grep -n --column"
 	$cmd "$@" |
 	perl -pe '
 	s/[ \t]+/ /g;
diff --git a/grep.c b/grep.c
index 7284dec155..37bb39a4a8 100644
--- a/grep.c
+++ b/grep.c
@@ -96,7 +96,7 @@ int grep_config(const char *var, const char *value, void *cb)
 		opt->linenum = git_config_bool(var, value);
 		return 0;
 	}
-	if (!strcmp(var, "grep.columnnumber")) {
+	if (!strcmp(var, "grep.column")) {
 		opt->columnnum = git_config_bool(var, value);
 		return 0;
 	}
@@ -116,7 +116,7 @@ int grep_config(const char *var, const char *value, void *cb)
 		color = opt->color_function;
 	else if (!strcmp(var, "color.grep.linenumber"))
 		color = opt->color_lineno;
-	else if (!strcmp(var, "color.grep.columnnumber"))
+	else if (!strcmp(var, "color.grep.column"))
 		color = opt->color_columnno;
 	else if (!strcmp(var, "color.grep.matchcontext"))
 		color = opt->color_match_context;
@@ -1405,7 +1405,7 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 		output_color(opt, buf, strlen(buf), opt->color_lineno);
 		output_sep(opt, sign);
 	}
-	/**
+	/*
 	 * Treat 'cno' as the 1-indexed offset from the start of a non-context
 	 * line to its first match. Otherwise, 'cno' is 0 indicating that we are
 	 * being called with a context line.
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index bbce57c8b1..a03c3416e7 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -99,14 +99,14 @@ do
 		test_cmp expected actual
 	'

-	test_expect_success "grep -w $L (with --column-number)" '
+	test_expect_success "grep -w $L (with --column)" '
 		{
 			echo ${HC}file:5:foo mmap bar
 			echo ${HC}file:14:foo_mmap bar mmap
 			echo ${HC}file:5:foo mmap bar_mmap
 			echo ${HC}file:14:foo_mmap bar mmap baz
 		} >expected &&
-		git grep --column-number -w -e mmap $H >actual &&
+		git grep --column -w -e mmap $H >actual &&
 		test_cmp expected actual
 	'

@@ -117,7 +117,7 @@ do
 			echo ${HC}file:4:5:foo mmap bar_mmap
 			echo ${HC}file:5:14:foo_mmap bar mmap baz
 		} >expected &&
-		git grep -n --column-number -w -e mmap $H >actual &&
+		git grep -n --column -w -e mmap $H >actual &&
 		test_cmp expected actual
 	'

--
2.17.0

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B9331F406
	for <e@80x24.org>; Sat, 12 May 2018 03:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750858AbeELDLC (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 23:11:02 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34549 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbeELDLB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 23:11:01 -0400
Received: by mail-pl0-f67.google.com with SMTP id ay10-v6so4274441plb.1
        for <git@vger.kernel.org>; Fri, 11 May 2018 20:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4s3bX/bEZzzuJnpQDpDkOU4CZMSq3zPephCNcvpzp8A=;
        b=TbxZo1m5pgswuuv/Njeum8BUDAvgIVJYFZSVEAfdLaCrAhMWkhMAFVgCnmlAdub8mE
         YjKpq43bhVxoeKOcJbiHATl9dr7+E1ve8+m/ZjP5MUfiZ7g18z+hrjJl8j6AAfizBf2j
         m3sFMRZcLZaD3HTZDpmZcoCRXngXV/UESv15vrT+jn6ifnsL9jCDzx4V144OB8o7jwah
         +roWhBZE11HWn14g+fO9yP3yZkYNiEPvotX86Qr8soUpEzFcBZAg93RIxHDaMDXjICog
         dJPCM7TMz6GiOntmnlyRWSdZWKbDxmOWcY5wnfTiZn6fdI/uDfDgz/QZ79e7ifImpbpV
         Fn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4s3bX/bEZzzuJnpQDpDkOU4CZMSq3zPephCNcvpzp8A=;
        b=SpEXa2TvZjwaSUyEMSSj6j5gBm5953VxT7BzU0U+9E8VYb8MOTQ8zb616FPfCnHmGK
         Ul7Ppvc76KpgHirGugnovSL5ot6gHonacQvzHNeC3hAKzvX1ILUxUYHri+nyA7VjBKwV
         jUQv9K5VPyQf9/2IXS9IDrGsjnVGvK3DZehVHcx/L+K4gKCOMaKjbk9FrJqJahsXdUvE
         RNizFCAk4rWgu6V6kBpVDn6N8mC54AYRB87mBjP9n8mvDnSjayl0/riOkkxegeXdRCE4
         7WrwLboO4kdElNKGl32onh6jyo1WPK+QSP53gdqcm/x+Sw7MDpcDxSpnsQz0wls5mQvw
         gsKg==
X-Gm-Message-State: ALKqPweB7LQF0ybi8nLbN+A6IxNIifn4c71W8ZJh+g4i55/MyMPPUpDO
        BJgWAWZ70P1RqRrRG9O7WfuibUJVl2U=
X-Google-Smtp-Source: AB8JxZox+V8Z76JBE4Uql9y3RGxhYj491Hp+TE7tqJamP9xrPrLwr62QzAqiHD0MMXFJdgX3siD9TA==
X-Received: by 2002:a17:902:1683:: with SMTP id h3-v6mr394314plh.266.1526094659850;
        Fri, 11 May 2018 20:10:59 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:81b:33bd:f4a4:78cd])
        by smtp.gmail.com with ESMTPSA id h23-v6sm7001251pfi.175.2018.05.11.20.10.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 May 2018 20:10:58 -0700 (PDT)
Date:   Fri, 11 May 2018 20:10:57 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, l.s.r@web.de, martin.agren@gmail.com,
        peff@peff.net, phillip.wood@talktalk.net
Subject: [PATCH v6 0/7] Teach '--column' to 'git-grep(1)'
Message-ID: <cover.1526094383.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180421034530.GB24606@syl.local>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Attached is my sixth re-roll of a series to add '--column' to 'git
grep'.

The main change since v5 is supporting --column with queries containing
--and, --or, or --not. Previously, I had chosen to die() in this case
since there isn't always a good answer to "what is the first column of
<complicated expression>?" but have gone back on this for two reasons:

  1. It is important not to regress calls to git-jump/contrib/git-jump
  that contain --and, --or, or --not.

  2. It is not that hard to detect the absence of column data in scripts.
     Likewise, git-jump will happily accept lines with or without
     columnar information, and Vim will accept it as-is.

So, let's support --column and only die() when also given
--invert-match. When we don't have a good answer, print nothing.

Thanks,
Taylor

Taylor Blau (7):
  Documentation/config.txt: camel-case lineNumber for consistency
  grep.c: expose matched column in match_line()
  grep.[ch]: extend grep_opt to allow showing matched column
  grep.c: display column number of first match
  builtin/grep.c: add '--column' option to 'git-grep(1)'
  grep.c: add configuration variables to show matched option
  contrib/git-jump/git-jump: jump to match column in addition to line

 Documentation/config.txt   |  7 ++++++-
 Documentation/git-grep.txt | 10 +++++++++-
 builtin/grep.c             |  4 ++++
 contrib/git-jump/README    | 12 ++++++++++--
 contrib/git-jump/git-jump  |  2 +-
 grep.c                     | 40 +++++++++++++++++++++++++++++---------
 grep.h                     |  2 ++
 t/t7810-grep.sh            | 39 +++++++++++++++++++++++++++++++++++++
 8 files changed, 102 insertions(+), 14 deletions(-)

Inter-diff (since v5):

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index dc8f76ce99..c48a578cb1 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -173,8 +173,9 @@ providing this option will cause it to die.
 	Prefix the line number to matching lines.

 --column::
-	Prefix the 1-indexed byte-offset of the first match on non-context lines. This
-	option is incompatible with '--invert-match', and extended expressions.
+	Prefix the 1-indexed byte-offset of the first match from the start of the
+	matching line. This option is incompatible with '--invert-match', and
+	ignored with expressions using '--and', '--or', '--not'.

 -l::
 --files-with-matches::
diff --git a/grep.c b/grep.c
index 5d904810ad..5ba1b05526 100644
--- a/grep.c
+++ b/grep.c
@@ -1001,9 +1001,6 @@ static void compile_grep_patterns_real(struct grep_opt *opt)
 	else if (!opt->extended && !opt->debug)
 		return;

-	if (opt->columnnum && opt->extended)
-		die(_("--column and extended expressions cannot be combined"));
-
 	p = opt->pattern_list;
 	if (p)
 		opt->pattern_expression = compile_pattern_expr(&p);
@@ -1411,9 +1408,10 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 	/*
 	 * Treat 'cno' as the 1-indexed offset from the start of a non-context
 	 * line to its first match. Otherwise, 'cno' is 0 indicating that we are
-	 * being called with a context line.
+	 * being called with a context line, or we are --extended, and cannot
+	 * always show an answer.
 	 */
-	if (opt->columnnum && cno) {
+	if (opt->columnnum && sign == ':' && !opt->extended) {
 		char buf[32];
 		xsnprintf(buf, sizeof(buf), "%d", cno);
 		output_color(opt, buf, strlen(buf), opt->color_columnno);
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index aa56b21ed9..491b2e044a 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -110,6 +110,18 @@ do
 		test_cmp expected actual
 	'

+	test_expect_success "grep -w $L (with --column, -C)" '
+		{
+			echo ${HC}file:5:foo mmap bar
+			echo ${HC}file-foo_mmap bar
+			echo ${HC}file:14:foo_mmap bar mmap
+			echo ${HC}file:5:foo mmap bar_mmap
+			echo ${HC}file:14:foo_mmap bar mmap baz
+		} >expected &&
+		git grep --column -w -C1 -e mmap $H >actual &&
+		test_cmp expected actual
+	'
+
 	test_expect_success "grep -w $L (with --line-number, --column)" '
 		{
 			echo ${HC}file:1:5:foo mmap bar
@@ -1617,9 +1629,4 @@ test_expect_success 'grep does not allow --column, --invert-match' '
 	test_i18ngrep "\-\-column and \-\-invert-match cannot be combined" err
 '

-test_expect_success 'grep does not allow --column, extended' '
-	test_must_fail git grep --column --not -e pat 2>err &&
-	test_i18ngrep "\-\-column and extended expressions cannot be combined" err
-'
-
 test_done

--
2.17.0

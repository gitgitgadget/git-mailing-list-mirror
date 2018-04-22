Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CA351F42D
	for <e@80x24.org>; Sun, 22 Apr 2018 20:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753551AbeDVUr0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 16:47:26 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37704 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753490AbeDVUrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 16:47:25 -0400
Received: by mail-pg0-f65.google.com with SMTP id a13so2464355pgu.4
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 13:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Ej7YjmOQ3c7gFUgBOfss9JVU+zgiNakHUI+JzMCVaQA=;
        b=M0giaGVfeeYiu1zKHud3G+f0MHZkS6G0MdiGCqkmMrnwEp/Mc+GEAK9nWTLa1iOKWl
         OpvfpCw6oXvxcxziiZQQOh+iMBxnA6IpYTLVs6Q4x7aTnjymqcDh6mZ3HUlHPUH94fSp
         LQ6yw6RKsMMFsymmsw2VUvDurEwVpKtnU4VG+WhJeKybylL0nYC/bCD3arASe6pMUju2
         9GP4RdGG+s8noD6bXdpOiAIJBgIdzxBX5ZMwNERC9voFvFCJ36No91mfNKvOyEbePFaA
         hy1OPteJ+EkgM5/Ob9+cLAV0H4i46axnMs0Yz5LR12ZsGoqrQXqwsMsnin3+658a+Z5N
         W4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Ej7YjmOQ3c7gFUgBOfss9JVU+zgiNakHUI+JzMCVaQA=;
        b=FlnngDGDHuNV+CU93iTfb3RmVdxmZxlzagFavcZ6COr6j2eklJfWONYz0H6P72SKTo
         9sNHzfW/TlDPlKodMhhsnE+9PaVPiu3mCj+D6S9Bji5P4ffjMPOFrdzt1rVXalkwTNjo
         Y1DjnR4vykJd3xlBL4xJ4C3yiP/O9pUAMhQq96Y2xJTX/eVuuwvab0VGFtLtPi2Bk5P0
         /MyNcweOhZnpTHEY+afbvlNfpkdZS/M7NjP8TMACAxl3Pe2j3UA5geeFff27yh5w7CsD
         k0H/T755RwD6NsvNz7f18m8QTMz1aPqnJqzPK713Ppzeq1uGg0Azn4Gv31N2iauJSgku
         VKpw==
X-Gm-Message-State: ALQs6tCNTIqa7325CHukeVTLaO8CqpVSQqEOk9RtIa4JH0JGbYgYDQN6
        v94KekD1n2f42G/MH9Sf8IAj4iFUIfM=
X-Google-Smtp-Source: AIpwx4++kBdWIVbL16fvLtomn5VGK9DW6Y93pJspQ5Q/8BYhvkZPeDmCNR5+N9uBKbb/r9dwa6VGQw==
X-Received: by 2002:a17:902:1744:: with SMTP id i62-v6mr14201300pli.267.1524430043717;
        Sun, 22 Apr 2018 13:47:23 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:e8b3:eaad:c134:baec])
        by smtp.gmail.com with ESMTPSA id s7sm18130291pfm.114.2018.04.22.13.47.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Apr 2018 13:47:22 -0700 (PDT)
Date:   Sun, 22 Apr 2018 13:47:20 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, l.s.r@web.de, martin.agren@gmail.com,
        peff@peff.net
Subject: [PATCH v2 0/6] Teach '--column-number' to 'git-grep(1)'
Message-ID: <cover.1524429778.git.me@ttaylorr.com>
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

Attached is a re-roll of the series to add --column-number to
'git-grep(1)'.

Since last time, I have changed the following (an inter-diff is
available below for easier consumption):

  * Removed '-m' as an alias for '--column-number', per René's
    suggestion [1].

  * Fix some incorrect spelling of 'columnnumber'.

  * Change casing of 'color.grep.linenumber' to 'color.grep.lineNumber'
    to be consistent with 'color.grep.columnNumber'. This is an
    unrelated change, and one which I am happy to drop from this series.
    It was suggested by Martin in [2].

Thanks in advance for your second round of review :-).


Thanks,
Taylor

[1]: https://public-inbox.org/git/cef29224-718f-21e9-0242-8bcd8e9c20a6@web.de/
[2]: https://public-inbox.org/git/CAN0heSp_bGqKF26g4TDOw6WpsvR2cEW6EqF3aJtKCv5POU_HmQ@mail.gmail.com/

Taylor Blau (6):
  grep.c: take regmatch_t as argument in match_line()
  grep.c: take column number as argument to show_line()
  grep.[ch]: teach columnnum, color_columnno to grep_opt
  grep.c: display column number of first match
  builtin/grep.c: show column numbers via --column-number
  contrib/git-jump/git-jump: use column number when grep-ing

 Documentation/config.txt   |  7 ++++++-
 Documentation/git-grep.txt |  8 +++++++-
 builtin/grep.c             |  1 +
 contrib/git-jump/git-jump  |  2 +-
 grep.c                     | 33 ++++++++++++++++++++++++---------
 grep.h                     |  2 ++
 t/t7810-grep.sh            | 22 ++++++++++++++++++++++
 7 files changed, 63 insertions(+), 12 deletions(-)

Inter-diff (since v1):

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 02fd4b662b..1645fcf2ae 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1157,10 +1157,10 @@ color.grep.<slot>::
 	filename prefix (when not using `-h`)
 `function`;;
 	function name lines (when using `-p`)
-`linenumber`;;
+`lineNumber`;;
 	line number prefix (when using `-n`)
-`columnnumber`;;
-	column number prefix (when using `-m`)
+`columnNumber`;;
+	column number prefix (when using `--column-number`)
 `match`;;
 	matching text (same as setting `matchContext` and `matchSelected`)
 `matchContext`;;
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index dd90f74ded..b75a039768 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	   [-v | --invert-match] [-h|-H] [--full-name]
 	   [-E | --extended-regexp] [-G | --basic-regexp]
 	   [-P | --perl-regexp]
-	   [-F | --fixed-strings] [-n | --line-number] [-m | --column-number]
+	   [-F | --fixed-strings] [-n | --line-number] [--column-number]
 	   [-l | --files-with-matches] [-L | --files-without-match]
 	   [(-O | --open-files-in-pager) [<pager>]]
 	   [-z | --null]
@@ -172,7 +172,6 @@ providing this option will cause it to die.
 --line-number::
 	Prefix the line number to matching lines.

--m::
 --column-number::
 	Prefix the 1-indexed column number of the first match on non-context lines.

diff --git a/builtin/grep.c b/builtin/grep.c
index faa65abab5..23ce97f998 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -829,7 +829,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			    GREP_PATTERN_TYPE_PCRE),
 		OPT_GROUP(""),
 		OPT_BOOL('n', "line-number", &opt.linenum, N_("show line numbers")),
-		OPT_BOOL('m', "column-number", &opt.columnnum, N_("show column numbers")),
+		OPT_BOOL(0, "column-number", &opt.columnnum, N_("show column numbers")),
 		OPT_NEGBIT('h', NULL, &opt.pathname, N_("don't show filenames"), 1),
 		OPT_BIT('H', NULL, &opt.pathname, N_("show filenames"), 1),
 		OPT_NEGBIT(0, "full-name", &opt.relative,
diff --git a/grep.c b/grep.c
index 5aeb893263..23250e60d0 100644
--- a/grep.c
+++ b/grep.c
@@ -115,7 +115,7 @@ int grep_config(const char *var, const char *value, void *cb)
 		color = opt->color_function;
 	else if (!strcmp(var, "color.grep.linenumber"))
 		color = opt->color_lineno;
-	else if (!strcmp(var, "color.grep.columnumber"))
+	else if (!strcmp(var, "color.grep.columnnumber"))
 		color = opt->color_columnno;
 	else if (!strcmp(var, "color.grep.matchcontext"))
 		color = opt->color_match_context;
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 0cf654824d..7349c7fadc 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -106,7 +106,7 @@ do
 			echo ${HC}file:5:foo mmap bar_mmap
 			echo ${HC}file:14:foo_mmap bar mmap baz
 		} >expected &&
-		git -c grep.linenumber=false grep -m -w -e mmap $H >actual &&
+		git grep --column-number -w -e mmap $H >actual &&
 		test_cmp expected actual
 	'

@@ -117,7 +117,7 @@ do
 			echo ${HC}file:4:5:foo mmap bar_mmap
 			echo ${HC}file:5:14:foo_mmap bar mmap baz
 		} >expected &&
-		git -c grep.linenumber=false grep -n -m -w -e mmap $H >actual &&
+		git grep -n --column-number -w -e mmap $H >actual &&
 		test_cmp expected actual
 	'

--
2.17.0

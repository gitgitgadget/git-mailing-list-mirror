Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E04A51F463
	for <e@80x24.org>; Thu, 12 Sep 2019 22:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbfILWM7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 18:12:59 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46892 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729494AbfILWM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 18:12:58 -0400
Received: by mail-pl1-f195.google.com with SMTP id t1so12354795plq.13
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 15:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IxPZ/9inq47N7zubTgJBZOmv4mrJiIQ9kGrNDHxoRBw=;
        b=sHjvpg8KwB8jniL08UcECirhOmT275vwSKNng8SnE3Jb1wf4Mbs+nkROkMCH+xdVqO
         aZ5al79kn73gbSAs92J64+QrMVNHVwBymlo8OdShLM+FRhQrmRnEmfK4zOXT/8AqjBD7
         XC5D4Ehfvcp2Z1fMosZWYkAg7g2PulpRaDf2itk9tnxUnekDmEkYVAoRqn3FmLQI6LTT
         /bf4B/Id4jZDU+co5YW+fQ9gdli5UP1gy5fRrSbM4qjCorEQWA8vbsyLAFoV1AbiEJSd
         ToWl94aXg5WE1FLZanuKifvGji2bzHcHePj5F2y9dz9rOVTdVNIb03maE0lbQzQJjySW
         o2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IxPZ/9inq47N7zubTgJBZOmv4mrJiIQ9kGrNDHxoRBw=;
        b=YHo208O2PHs1HN93htbr5GpUuhWjcdV0Tw7EI5UyKELM5wwMSRsYTrxhEeeg2cWWwQ
         WCRJkGKjQkPsnzX7gvQZ72dBepxa9ja1g8oYgZnqEWicFeRfy+55vPfLMxp0X1nYmKTN
         8FWpzY7IjIiXgfZUypkW905xfRTiokWAO7a6C/vnLgJzdSeLibMLtuWVQRNoLWlGJyO0
         qpSQoHsEk3jr+ewUd/RYo+zeC+yp6kBmU1qOHhfaAnCOZUQ+p71M9rJashwZSseh8ijP
         ujEDaUXHalqE5nWDxIFQ4eJgCUYDx6DfWHsJKxinj2a4K62MZEmO5+ZQgJYQ9TGauZqf
         +mHg==
X-Gm-Message-State: APjAAAXjDQbZ5R7t7Cis2zw1gWmjfoDe0NKDEBMPhY+Q6wV0ry5i6Oio
        Bf5Q5lXOFUqWqIuK6j/KvvVnU0U09jc=
X-Google-Smtp-Source: APXvYqz3n58dCLLAGV2Oi6HdI8jWHHlgNRx9+vyX/VuEOp1qzgw8Ay2UNWb3iQted0keds8YqIut4A==
X-Received: by 2002:a17:902:424:: with SMTP id 33mr46120361ple.34.1568326375718;
        Thu, 12 Sep 2019 15:12:55 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id y13sm24358188pfn.73.2019.09.12.15.12.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Sep 2019 15:12:54 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 09/12] clean: disambiguate the definition of -d
Date:   Thu, 12 Sep 2019 15:12:37 -0700
Message-Id: <20190912221240.18057-10-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.173.gad11b3a635.dirty
In-Reply-To: <20190912221240.18057-1-newren@gmail.com>
References: <20190905154735.29784-1-newren@gmail.com>
 <20190912221240.18057-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The -d flag pre-dated git-clean's ability to have paths specified.  As
such, the default for git-clean was to only remove untracked files in
the current directory, and -d existed to allow it to recurse into
subdirectories.

The interaction of paths and the -d option appears to not have been
carefully considered, as evidenced by numerous bugs and a dearth of
tests covering such pairings in the testsuite.  The definition turns out
to be important, so let's look at some of the various ways one could
interpret the -d option:

  A) Without -d, only look in subdirectories which contain tracked
     files under them; with -d, also look in subdirectories which
     are untracked for files to clean.

  B) Without specified paths from the user for us to delete, we need to
     have some kind of default, so...without -d, only look in
     subdirectories which contain tracked files under them; with -d,
     also look in subdirectories which are untracked for files to clean.

The important distinction here is that choice B says that the presence
or absence of '-d' is irrelevant if paths are specified.  The logic
behind option B is that if a user explicitly asked us to clean a
specified pathspec, then we should clean anything that matches that
pathspec.  Some examples may clarify.  Should

   git clean -f untracked_dir/file

remove untracked_dir/file or not?  It seems crazy not to, but a strict
reading of option A says it shouldn't be removed.  How about

   git clean -f untracked_dir/file1 tracked_dir/file2

or

   git clean -f untracked_dir_1/file1 untracked_dir_2/file2

?  Should it remove either or both of these files?  Should it require
multiple runs to remove both the files listed?  (If this sounds like a
crazy question to even ask, see the commit message of "t7300: Add some
testcases showing failure to clean specified pathspecs" added earlier in
this patch series.)  What if -ffd were used instead of -f -- should that
allow these to be removed?  Should it take multiple invocations with
-ffd?  What if a glob (such as '*tracked*') were used instead of
spelling out the directory names?  What if the filenames involved globs,
such as

   git clean -f '*.o'

or

   git clean -f '*/*.o'

?

The current documentation actually suggests a definition that is
slightly different than choice A, and the implementation prior to this
series provided something radically different than either choices A or
B. (The implementation, though, was clearly just buggy).  There may be
other choices as well.  However, for almost any given choice of
definition for -d that I can think of, some of the examples above will
appear buggy to the user.  The only case that doesn't have negative
surprises is choice B: treat a user-specified path as a request to clean
all untracked files which match that path specification, including
recursing into any untracked directories.

Change the documentation and basic implementation to use this
definition.

There were two regression tests that indirectly depended on the current
implementation, but neither was about subdirectory handling.  These two
tests were introduced in commit 5b7570cfb41c ("git-clean: add tests for
relative path", 2008-03-07) which was solely created to add coverage for
the changes in commit fb328947c8e ("git-clean: correct printing relative
path", 2008-03-07).  Both tests specified a directory that happened to
have an untracked subdirectory, but both were only checking that the
resulting printout of a file that was removed was shown with a relative
path.  Update these tests appropriately.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-clean.txt | 10 ++++++----
 builtin/clean.c             |  8 ++++++++
 t/t7300-clean.sh            |  2 ++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index e84ffc9396..3ab749b921 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -26,10 +26,12 @@ are affected.
 OPTIONS
 -------
 -d::
-	Remove untracked directories in addition to untracked files.
-	If an untracked directory is managed by a different Git
-	repository, it is not removed by default.  Use -f option twice
-	if you really want to remove such a directory.
+	Normally, when no <path> is specified, git clean will not
+	recurse into untracked directories to avoid removing too much.
+	Specify -d to have it recurse into such directories as well.
+	If any paths are specified, -d is irrelevant; all untracked
+	files matching the specified paths (with exceptions for nested
+	git directories mentioned under `--force`) will be removed.
 
 -f::
 --force::
diff --git a/builtin/clean.c b/builtin/clean.c
index d5579da716..68d70e41c0 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -949,6 +949,14 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 
 	dir.flags |= DIR_SHOW_OTHER_DIRECTORIES;
 
+	if (argc) {
+		/*
+		 * Remaining args implies pathspecs specified, and we should
+		 * recurse within those.
+		 */
+		remove_directories = 1;
+	}
+
 	if (remove_directories)
 		dir.flags |= DIR_SHOW_IGNORED_TOO | DIR_KEEP_UNTRACKED_CONTENTS;
 
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index d83aeb7dc2..530dfdab34 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -117,6 +117,7 @@ test_expect_success C_LOCALE_OUTPUT 'git clean with relative prefix' '
 	would_clean=$(
 		cd docs &&
 		git clean -n ../src |
+		grep part3 |
 		sed -n -e "s|^Would remove ||p"
 	) &&
 	verbose test "$would_clean" = ../src/part3.c
@@ -129,6 +130,7 @@ test_expect_success C_LOCALE_OUTPUT 'git clean with absolute path' '
 	would_clean=$(
 		cd docs &&
 		git clean -n "$(pwd)/../src" |
+		grep part3 |
 		sed -n -e "s|^Would remove ||p"
 	) &&
 	verbose test "$would_clean" = ../src/part3.c
-- 
2.23.0.173.gad11b3a635.dirty


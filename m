Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DC9E1F463
	for <e@80x24.org>; Tue, 17 Sep 2019 16:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbfIQQf0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 12:35:26 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35485 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730520AbfIQQfY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 12:35:24 -0400
Received: by mail-pl1-f194.google.com with SMTP id s17so1770529plp.2
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 09:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YiNPiKy43IT7Qv88TvuVOyIXRHfRqSANJK6OfCSrX1w=;
        b=Oysog1uN+Anmmrvikmgz3VRuC970b8ujKT57i1eeeYKtkygJywR2DFmsktEU3M+zGR
         bpimOacTDseQEzCMCgpcmA/rzzx6milx/YRtVVJVXU36nPxvXhZCC5WCHdyY+u/yVK+S
         nISiXgqwXULgbYh/dLNMDLmLc6lKZfgdYzBYlDQfB5jZBxDHH+vPZxZEB2VfpCtMogYs
         CKtU6A4KYxpaLUkh7NVU+atT2TWz4vHGXoedNdhDzBxAJLUaWGOy9qIqi9y3LrBBdltZ
         7mW7mq3NDth8zRUNH6t7dIA5oHJ2Bz+fBHAB0qAZSiVUwlhXiJ6BC7DlYeMTD/6w5LQ/
         J8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YiNPiKy43IT7Qv88TvuVOyIXRHfRqSANJK6OfCSrX1w=;
        b=VpFR4kMdx11wosTl4w4A/UyEuB+a2ipuagg7QBwYA7wCB6d6B4Vj5bKupjpU2nYrzm
         2ooI9pn4CpUXx5NwIC+lOEDJPS/nrx2+jSr6R53pBc/p9w7BwDmth7w+wLoiH/SK3ICH
         U2DoZOxP2tqjZ8tXZ9BmnwKXpOjG6YZmmdBCAm8PmVLF+LHT2gaHH8D59v+pp6I19E5N
         vvDgd0ph3N22Q/GoAhOgvupYcj3jyWSP3kzAFlSYnvZMExEkckCGM9RD+631nxIQt468
         HbDIkyvQyVJO33chqIjjglbpuVc5AQGwctDwLbs0jSZLReyDTwMivMYSt8aKRXXXY2UU
         r6OA==
X-Gm-Message-State: APjAAAXxc7dxUbibkeZ/Ldb5GX5Pqlem7838Q7+AN/2TVzja5bMNrn+2
        C0ycRIgEd3IgfgOwdKoQBqq6g3pRleE=
X-Google-Smtp-Source: APXvYqzRGh23/hd1gh+WCtbhd5xFDQDSqJ5Y+njGoUl/QK7IcKFO9jtK86/KXcthVvglP5MCCojkow==
X-Received: by 2002:a17:902:8e84:: with SMTP id bg4mr4677086plb.43.1568738123639;
        Tue, 17 Sep 2019 09:35:23 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id s5sm3202452pfe.52.2019.09.17.09.35.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Sep 2019 09:35:21 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 09/12] clean: disambiguate the definition of -d
Date:   Tue, 17 Sep 2019 09:35:01 -0700
Message-Id: <20190917163504.14566-10-newren@gmail.com>
X-Mailer: git-send-email 2.22.1.17.g6e632477f7
In-Reply-To: <20190917163504.14566-1-newren@gmail.com>
References: <20190912221240.18057-1-newren@gmail.com>
 <20190917163504.14566-1-newren@gmail.com>
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
2.22.1.17.g6e632477f7.dirty


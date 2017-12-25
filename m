Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C971D1F424
	for <e@80x24.org>; Mon, 25 Dec 2017 00:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751278AbdLYA3T (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Dec 2017 19:29:19 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34523 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751178AbdLYA3I (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Dec 2017 19:29:08 -0500
Received: by mail-wm0-f41.google.com with SMTP id y82so31699303wmg.1
        for <git@vger.kernel.org>; Sun, 24 Dec 2017 16:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=VxWcsa1cb5w2RPSVz/7mNAnJ+djkdwEbRoJyyDSYvg8=;
        b=ouZOZT7zcX+Esk73xp5KLRecb9/wNWOQb4ECNNV2JiNagx3dVaxDyNKXp8WNwk+a47
         MO4u/Pnti1MlEG1OseyAZSD+EdLwqvyaiLGgiwwacZ+Eoa4pPGXfGZ0aBuD9sqIKJtNb
         Px53H9Njn6FDWShuDmBMPInbVy6J0aCXIQZhWNVjcH6eqI0N5QTCUb3PyoLLtXBQFYq7
         5VDE/j2VLVNF+hwoTlgbJexIWoXlmPQOTvBrqXwWmHiai4XGqS9kZ5G/pk0BPhHHfufA
         TYSZy64+JyPkeLJvMMHJ/7uqxE3FY/d/dSvLSQEeRwCmgy1LCZ1BtfXroxNiYiePk47R
         ZYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VxWcsa1cb5w2RPSVz/7mNAnJ+djkdwEbRoJyyDSYvg8=;
        b=IViXWHB96eQaElJ9qhiqvXMiMm00VgI85+bQM0YqYhImFZpizzfV8fXIAMmKLdq7v9
         rEeYevVf2n2zowxN7io8jzZ5OUn0TkO+Rd2X741pK5/JiDpA67MfuhE8Gm1NlF2tLY8Y
         7rrqhQQFF3elGYwD7csnnUue+rBDyO4lgGVXS1geUFQsjCeeubd77gE6Zz2wwUg/JhGA
         9U0oQvirS7vEBnJJbc7H3zgDyqOWNw4DTzs86COZ7LYSkWqN1p9v8IMm5aYK2R+CZukO
         Krj5IhuRqiQNZtxa94fywLK0hyDUjeReVT99aYNJK7UzyTm890wjIqny6PNBMtlHDaEz
         xQsQ==
X-Gm-Message-State: AKGB3mJYjcrPvnB0KZ/2a4lbaxov/3x7eJlZeZJmLRe0MTVzUty46vpP
        jaZ5p0Z+pyNDz6L8WiAgYhX36+gE
X-Google-Smtp-Source: ACJfBov26Dstp3oiaz/ko1ikCm0F7yoWleOKeTmwPpdPDYr7xVOqMRbWRSHR/KHgnbeIDWVepoaGww==
X-Received: by 10.28.120.19 with SMTP id t19mr19051980wmc.64.1514161747002;
        Sun, 24 Dec 2017 16:29:07 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id i65sm52923574wme.20.2017.12.24.16.29.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Dec 2017 16:29:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Anthony Ramine <n.oxyde@gmail.com>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 7/7] wildmatch test: create & test files on disk in addition to in-memory
Date:   Mon, 25 Dec 2017 00:28:35 +0000
Message-Id: <20171225002835.29005-8-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20171225002835.29005-1-avarab@gmail.com>
References: <20171225002835.29005-1-avarab@gmail.com>
In-Reply-To: <20171223213012.1962-1-avarab@gmail.com>
References: <20171223213012.1962-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There has never been any full roundtrip testing of what git-ls-files
and other functions that use wildmatch() actually do, rather we've
been satisfied with just testing the underlying C function.

Due to git-ls-files and friends having their own codepaths before they
call wildmatch() there's sometimes differences in the behavior between
the two, and even when we test for those (as with
9e4e8a64c2 ("pathspec: die on empty strings as pathspec", 2017-06-06))
there was no one place where you can review how these two modes
differ.

Now there is. We now attempt to create a file called $haystack and
match $needle against it for each pair of $needle and $haystack that
we were passing to test-wildmatch.

If we can't create the file we skip the test. This ensures that we can
run this on all platforms and not maintain some infinitely growing
whitelist of e.g. platforms that don't support certain characters in
filenames.

As a result of doing this we can now see the cases where these two
ways of testing wildmatch differ:

 * Creating a file called 'a[]b' and running ls-files 'a[]b' will show
   that file, but wildmatch("a[]b", "a[]b") will not match

 * wildmatch() won't match a file called \ against \, but ls-files
   will.

 * `git --glob-pathspecs ls-files 'foo**'` will match a file
   'foo/bba/arr', but wildmatch won't, however pathmatch will.

   This seems like a bug to me, the two are otherwise equivalent as
   these tests show.

This also reveals the case discussed in 9e4e8a64c2 above, where '' is
now an error as far as ls-files is concerned, but wildmatch() itself
happily accepts it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3070-wildmatch.sh | 285 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 273 insertions(+), 12 deletions(-)

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index 593b25b278..80d13b5b60 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -4,14 +4,95 @@ test_description='wildmatch tests'
 
 . ./test-lib.sh
 
+create_test_file() {
+	file=$1
+
+	case $file in
+	# `touch .` will succeed but obviously not do what we intend
+	# here.
+	".")
+		return 1
+		;;
+	# We cannot create a file with an empty filename.
+	"")
+		return 1
+		;;
+	# The tests that are testing that e.g. foo//bar is matched by
+	# foo/*/bar can't be tested on filesystems since there's no
+	# way we're getting a double slash.
+	*//*)
+		return 1
+		;;
+	# When testing the difference between foo/bar and foo/bar/ we
+	# can't test the latter.
+	*/)
+		return 1
+		;;
+	esac
+
+	# Turn foo/bar/baz into foo/bar to create foo/bar as a
+	# directory structure.
+	dirs=$(echo "$file" | sed -r 's!/[^/]+$!!')
+
+	# We touch "./$file" instead of "$file" because even an
+	# escaped "touch -- -" means get arguments from stdin.
+	if test "$file" != "$dirs"
+	then
+		mkdir -p -- "$dirs" &&
+		touch -- "./$file" &&
+		return 0
+	else
+		touch -- "./$file" &&
+		return 0
+	fi
+	return 1
+}
+
+wildtest_file_setup() {
+	test_when_finished "
+		rm -rf -- * &&
+		git reset
+	" &&
+	git add -A &&
+	>expect.err
+}
+
+wildtest_stdout_stderr_cmp() {
+	tr -d '\0' <actual.raw >actual &&
+	test_cmp expect.err actual.err &&
+	test_cmp expect actual
+}
+
 wildtest() {
-	match_w_glob=$1
-	match_w_globi=$2
-	match_w_pathmatch=$3
-	match_w_pathmatchi=$4
-	text=$5
-	pattern=$6
+	if test "$#" = 6
+	then
+		# When test-wildmatch and git ls-files produce the same
+		# result.
+		match_w_glob=$1
+		match_f_w_glob=$match_w_glob
+		match_w_globi=$2
+		match_f_w_globi=$match_w_globi
+		match_w_pathmatch=$3
+		match_f_w_pathmatch=$match_w_pathmatch
+		match_w_pathmatchi=$4
+		match_f_w_pathmatchi=$match_w_pathmatchi
+		text=$5
+		pattern=$6
+	elif test "$#" = 10
+	then
+		match_w_glob=$1
+		match_w_globi=$2
+		match_w_pathmatch=$3
+		match_w_pathmatchi=$4
+		match_f_w_glob=$5
+		match_f_w_globi=$6
+		match_f_w_pathmatch=$7
+		match_f_w_pathmatchi=$8
+		text=$9
+		pattern=$10
+	fi
 
+	# $1: Case sensitive glob match: test-wildmatch
 	if test "$match_w_glob" = 1
 	then
 		test_expect_success "wildmatch: match '$text' '$pattern'" "
@@ -26,6 +107,50 @@ wildtest() {
 		test_expect_success "PANIC: Test framework error. Unknown matches value $match_w_glob" 'false'
 	fi
 
+	# $1: Case sensitive glob match: ls-files
+	if test "$match_f_w_glob" = 'E'
+	then
+		if create_test_file "$text"
+		then
+			test_expect_success "wildmatch(ls): match dies on '$pattern' '$text'" "
+				wildtest_file_setup &&
+				printf '%s' '$text' >expect &&
+				test_must_fail git --glob-pathspecs ls-files -z -- '$pattern'
+			"
+		else
+			test_expect_failure "wildmatch(ls): match skip '$pattern' '$text'" 'false'
+		fi
+	elif test "$match_f_w_glob" = 1
+	then
+		if create_test_file "$text"
+		then
+			test_expect_success "wildmatch(ls): match '$pattern' '$text'" "
+				wildtest_file_setup &&
+				printf '%s' '$text' >expect &&
+				git --glob-pathspecs ls-files -z -- '$pattern' >actual.raw 2>actual.err &&
+				wildtest_stdout_stderr_cmp
+			"
+		else
+			test_expect_failure "wildmatch(ls): match skip '$pattern' '$text'" 'false'
+		fi
+	elif test "$match_f_w_glob" = 0
+	then
+		if create_test_file "$text"
+		then
+			test_expect_success "wildmatch(ls): no match '$pattern' '$text'" "
+				wildtest_file_setup &&
+				>expect &&
+				git --glob-pathspecs ls-files -z -- '$pattern' >actual.raw 2>actual.err &&
+				wildtest_stdout_stderr_cmp
+			"
+		else
+			test_expect_failure "wildmatch(ls): no match skip '$pattern' '$text'" 'false'
+		fi
+	else
+		test_expect_success "PANIC: Test framework error. Unknown matches value $match_f_w_glob" 'false'
+	fi
+
+	# $2: Case insensitive glob match: test-wildmatch
 	if test "$match_w_globi" = 1
 	then
 		test_expect_success "iwildmatch: match '$text' '$pattern'" "
@@ -40,6 +165,50 @@ wildtest() {
 		test_expect_success "PANIC: Test framework error. Unknown matches value $match_w_globi" 'false'
 	fi
 
+	# $2: Case insensitive glob match: ls-files
+	if test "$match_f_w_globi" = 'E'
+	then
+		if create_test_file "$text"
+		then
+			test_expect_success "wildmatch(ls): match dies on '$pattern' '$text'" "
+				wildtest_file_setup &&
+				printf '%s' '$text' >expect &&
+				test_must_fail git --glob-pathspecs --icase-pathspecs ls-files -z -- '$pattern'
+			"
+		else
+			test_expect_failure "wildmatch(ls): match skip '$pattern' '$text'" 'false'
+		fi
+	elif test "$match_f_w_globi" = 1
+	then
+		if create_test_file "$text"
+		then
+			test_expect_success "wildmatch(ls): match '$pattern' '$text'" "
+				wildtest_file_setup &&
+				printf '%s' '$text' >expect &&
+				git --glob-pathspecs --icase-pathspecs ls-files -z -- '$pattern' >actual.raw 2>actual.err &&
+				wildtest_stdout_stderr_cmp
+			"
+		else
+			test_expect_failure "wildmatch(ls): match skip '$pattern' '$text'" 'false'
+		fi
+	elif test "$match_f_w_globi" = 0
+	then
+		if create_test_file "$text"
+		then
+			test_expect_success "wildmatch(ls): no match '$pattern' '$text'" "
+				wildtest_file_setup &&
+				>expect &&
+				git --glob-pathspecs --icase-pathspecs ls-files -z -- '$pattern' >actual.raw 2>actual.err &&
+				wildtest_stdout_stderr_cmp
+			"
+		else
+			test_expect_failure "wildmatch(ls): no match skip '$pattern' '$text'" 'false'
+		fi
+	else
+		test_expect_success "PANIC: Test framework error. Unknown matches value $match_f_w_globi" 'false'
+	fi
+
+	# $3: Case sensitive path match: test-wildmatch
 	if test "$match_w_pathmatch" = 1
 	then
 		test_expect_success "pathmatch: match '$text' '$pattern'" "
@@ -54,9 +223,53 @@ wildtest() {
 		test_expect_success "PANIC: Test framework error. Unknown matches value $match_w_pathmatch" 'false'
 	fi
 
+	# $4: Case sensitive path match: ls-files
+	if test "$match_f_w_pathmatch" = 'E'
+	then
+		if create_test_file "$text"
+		then
+			test_expect_success "pathmatch(ls): match dies on '$pattern' '$text'" "
+				wildtest_file_setup &&
+				printf '%s' '$text' >expect &&
+				test_must_fail git ls-files -z -- '$pattern'
+			"
+		else
+			test_expect_failure "pathmatch(ls): match skip '$pattern' '$text'" 'false'
+		fi
+	elif test "$match_f_w_pathmatch" = 1
+	then
+		if create_test_file "$text"
+		then
+			test_expect_success "pathmatch(ls): match '$pattern' '$text'" "
+				wildtest_file_setup &&
+				printf '%s' '$text' >expect &&
+				git ls-files -z -- '$pattern' >actual.raw 2>actual.err &&
+				wildtest_stdout_stderr_cmp
+			"
+		else
+			test_expect_failure "pathmatch(ls): match skip '$pattern' '$text'" 'false'
+		fi
+	elif test "$match_f_w_pathmatch" = 0
+	then
+		if create_test_file "$text"
+		then
+			test_expect_success "pathmatch(ls): no match '$pattern' '$text'" "
+				wildtest_file_setup &&
+				>expect &&
+				git ls-files -z -- '$pattern' >actual.raw 2>actual.err &&
+				wildtest_stdout_stderr_cmp
+			"
+		else
+			test_expect_failure "pathmatch(ls): no match skip '$pattern' '$text'" 'false'
+		fi
+	else
+		test_expect_success "PANIC: Test framework error. Unknown matches value $match_f_w_pathmatch" 'false'
+	fi
+
+	# $4: Case insensitive path match: test-wildmatch
 	if test "$match_w_pathmatchi" = 1
 	then
-		test_expect_success "ipathmatch:    match '$text' '$pattern'" "
+		test_expect_success "ipathmatch: match '$text' '$pattern'" "
 			test-wildmatch ipathmatch '$text' '$pattern'
 		"
 	elif test "$match_w_pathmatchi" = 0
@@ -67,6 +280,49 @@ wildtest() {
 	else
 		test_expect_success "PANIC: Test framework error. Unknown matches value $match_w_pathmatchi" 'false'
 	fi
+
+	# $4: Case insensitive path match: ls-files
+	if test "$match_f_w_pathmatchi" = 'E'
+	then
+		if create_test_file "$text"
+		then
+			test_expect_success "ipathmatch(ls): match dies on '$pattern' '$text'" "
+				wildtest_file_setup &&
+				printf '%s' '$text' >expect &&
+				test_must_fail git --icase-pathspecs ls-files -z -- '$pattern'
+			"
+		else
+			test_expect_failure "pathmatch(ls): match skip '$pattern' '$text'" 'false'
+		fi
+	elif test "$match_f_w_pathmatchi" = 1
+	then
+		if create_test_file "$text"
+		then
+			test_expect_success "ipathmatch(ls): match '$pattern' '$text'" "
+				wildtest_file_setup &&
+				printf '%s' '$text' >expect &&
+				git --icase-pathspecs ls-files -z -- '$pattern' >actual.raw 2>actual.err &&
+				wildtest_stdout_stderr_cmp
+			"
+		else
+			test_expect_failure "pathmatch(ls): match skip '$pattern' '$text'" 'false'
+		fi
+	elif test "$match_f_w_pathmatchi" = 0
+	then
+		if create_test_file "$text"
+		then
+			test_expect_success "ipathmatch(ls): no match '$pattern' '$text'" "
+				wildtest_file_setup &&
+				>expect &&
+				git ls-files -z -- '$pattern' >actual.raw 2>actual.err &&
+				wildtest_stdout_stderr_cmp
+			"
+		else
+			test_expect_failure "pathmatch(ls): no match skip '$pattern' '$text'" 'false'
+		fi
+	else
+		test_expect_success "PANIC: Test framework error. Unknown matches value $match_f_w_pathmatchi" 'false'
+	fi
 }
 
 # Basic wildmatch features
@@ -135,7 +391,8 @@ wildtest 1 1 1 1 'acrt' 'a[c-c]rt'
 wildtest 0 0 0 0 ']' '[!]-]'
 wildtest 1 1 1 1 'a' '[!]-]'
 wildtest 0 0 0 0 '' '\'
-wildtest 0 0 0 0 '\' '\'
+wildtest 0 0 0 0 \
+	 1 1 1 1 '\' '\'
 wildtest 0 0 0 0 'XXX/\' '*/\'
 wildtest 1 1 1 1 'XXX/\' '*/\\'
 wildtest 1 1 1 1 'foo' 'foo'
@@ -149,7 +406,8 @@ wildtest 1 1 1 1 '[ab]' '[[:digit]ab]'
 wildtest 1 1 1 1 '[ab]' '[\[:]ab]'
 wildtest 1 1 1 1 '?a?b' '\??\?b'
 wildtest 1 1 1 1 'abc' '\a\b\c'
-wildtest 0 0 0 0 'foo' ''
+wildtest 0 0 0 0 \
+	 E E E E 'foo' ''
 wildtest 1 1 1 1 'foo/bar/baz/to' '**/t[o]'
 
 # Character class tests
@@ -179,8 +437,10 @@ wildtest 1 1 1 1 ']' '[\]]'
 wildtest 0 0 0 0 '\]' '[\]]'
 wildtest 0 0 0 0 '\' '[\]]'
 wildtest 0 0 0 0 'ab' 'a[]b'
-wildtest 0 0 0 0 'a[]b' 'a[]b'
-wildtest 0 0 0 0 'ab[' 'ab['
+wildtest 0 0 0 0 \
+	 1 1 1 1 'a[]b' 'a[]b'
+wildtest 0 0 0 0 \
+	 1 1 1 1 'ab[' 'ab['
 wildtest 0 0 0 0 'ab' '[!'
 wildtest 0 0 0 0 'ab' '[-'
 wildtest 1 1 1 1 '-' '[-]'
@@ -248,7 +508,8 @@ wildtest 1 1 1 1 foo/bar 'foo/*'
 wildtest 0 0 1 1 foo/bba/arr 'foo/*'
 wildtest 1 1 1 1 foo/bba/arr 'foo/**'
 wildtest 0 0 1 1 foo/bba/arr 'foo*'
-wildtest 0 0 1 1 foo/bba/arr 'foo**'
+wildtest 0 0 1 1 \
+	 1 1 1 1 foo/bba/arr 'foo**'
 wildtest 0 0 1 1 foo/bba/arr 'foo/*arr'
 wildtest 0 0 1 1 foo/bba/arr 'foo/**arr'
 wildtest 0 0 0 0 foo/bba/arr 'foo/*z'
-- 
2.15.1.424.g9478a66081


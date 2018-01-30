Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADBEA1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 21:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752300AbeA3VWm (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 16:22:42 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:53554 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752308AbeA3VWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 16:22:09 -0500
Received: by mail-wm0-f52.google.com with SMTP id t74so4016599wme.3
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 13:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=l2FQkd9umTkXf1NOQQrQZtvyfaYBhE+oghiJLDNwpgQ=;
        b=G619Q0afYrKAPfIeY7mBf9KFnZ/mM83a4EIuZ/IS6XOyYHVym0U6Gli3CjmbZnbWKS
         0G+Vzu/xiw7fr3PlWhfP3gMCAdi4ynr/aRuD9/5BMZQx6rkGf7EOMA2SMx6i4hbEqXdm
         252p/hCK1g/BfF4wQpHXHSqMGbOwat32pgb8+xN4VyOx/7uZtGwj2RrsvJKcqTolLgiP
         mLxSu1y3Ee0fX02CBPVJuczefQyWSyq70lovRFcKGIaWmDwx9UHSXkTI3ePhw3LO6+dj
         N+PLbs+H73sIenQ8Ni/UZMphQffKI5Ocv2dYK5byUtEXqRiJbbu+mMaDH6MGIRbAlGxk
         uTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=l2FQkd9umTkXf1NOQQrQZtvyfaYBhE+oghiJLDNwpgQ=;
        b=PsTNr/RWB13DnlsEUO1PTDDE22UN4pSOFkb78PVYu4GRi7WT44tRmXLImGihSxCL7G
         wc5bvpg5QVtJHlTl9aSEYWVkwrIyST+2fvgo+Vg78PkmO0WKSdHEeLlpGkzSrb4d9GyJ
         oMeN2ORZniCH1IRh8Z+btyKQn5f4SHZiop0MvF1KJS5xk0oZRtWmOJk7L2w5xF7P/ZYg
         Tfbd7kBj5UbA4kbGaC104n8o70p9xoTCgYW2WRMQAJT64I34vuJC9ixqRxwFMIuQP5Tq
         r0aDzZNKTi31ru6MYfAzKSTafoAs0EKf4HWLRi5GCT6epqzrkSyuU/4tfq3CaxWNG2Vh
         Fv+Q==
X-Gm-Message-State: AKwxytclK+gtS8+I7GBIj3tHqXwC48gcq+qdbzae6rcTDpnm6ei9l7QB
        zAuu+BvxZq5Y9NEpyzKavI7QAK1b
X-Google-Smtp-Source: AH8x226L2gqKQZ4P384Y7iAhewUq+5Clv23jmfyNzMGdLJRN2o08El3/k7U0HdGcxJ0+jg9mp5rQhg==
X-Received: by 10.80.205.221 with SMTP id h29mr52531520edj.159.1517347327476;
        Tue, 30 Jan 2018 13:22:07 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id c5sm8487748ede.30.2018.01.30.13.22.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jan 2018 13:22:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Anthony Ramine <n.oxyde@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Kyle J . McKay" <mackyle@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 08/10] wildmatch test: create & test files on disk in addition to in-memory
Date:   Tue, 30 Jan 2018 21:21:22 +0000
Message-Id: <20180130212124.2099-9-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180130212124.2099-1-avarab@gmail.com>
References: <20180130212124.2099-1-avarab@gmail.com>
In-Reply-To: <20180104192657.28019-1-avarab@gmail.com>
References: <20180104192657.28019-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There has never been any full roundtrip testing of what git-ls-files
and other commands that use wildmatch() actually do, rather we've been
satisfied with just testing the underlying C function.

Due to git-ls-files and friends having their own codepaths before they
call wildmatch() there's sometimes differences in the behavior between
the two. Even when we test for those (as with [1]), there was no one
place where you can review how these two modes differ.

Now there is. We now attempt to create a file called $haystack and
match $needle against it for each pair of $needle and $haystack that
we were passing to test-wildmatch.

If we can't create the file we skip the test. This ensures that we can
run this on all platforms and not maintain some infinitely growing
whitelist of e.g. platforms that don't support certain characters in
filenames.

A notable exception to this is Windows, where due to the reasons
explained in [2] the shellscript emulation layer might fake the
creation of a file such as "*", and "test -e" for it will succeed
since it just got created with some character that maps to "*", but
git ls-files won't be fooled by this.

Thus we need to skip creating certain filenames entirely on Windows,
the list here might be overly aggressive. I don't have access to a
Windows system to test this.

As a result of doing these tests we can now see the cases where these
two ways of testing wildmatch differ:

 * Creating a file called 'a[]b' and running ls-files 'a[]b' will show
   that file, but wildmatch("a[]b", "a[]b") will not match

 * wildmatch() won't match a file called \ against \, but ls-files
   will.

 * `git --glob-pathspecs ls-files 'foo**'` will match a file
   'foo/bba/arr', but wildmatch won't, however pathmatch will.

   This seems like a bug to me, the two are otherwise equivalent as
   these tests show.

This also reveals the case discussed in [1], since 2.16.0 '' is now an
error as far as ls-files is concerned, but wildmatch() itself happily
accepts it.

1. 9e4e8a64c2 ("pathspec: die on empty strings as pathspec",
   2017-06-06)

2. nycvar.QRO.7.76.6.1801052133380.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet
   (https://public-inbox.org/git/?q=nycvar.QRO.7.76.6.1801052133380.1337%40wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3070-wildmatch.sh | 201 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 190 insertions(+), 11 deletions(-)

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index 3e75cb0cbe..bd11e5acb0 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -4,6 +4,72 @@ test_description='wildmatch tests'
 
 . ./test-lib.sh
 
+should_create_test_file() {
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
+	# On Windows, \ in paths is silently converted to /, which
+	# would result in the "touch" below working, but the test
+	# itself failing. See 6fd1106aa4 ("t3700: Skip a test with
+	# backslashes in pathspec", 2009-03-13) for prior art and
+	# details.
+	*\\*)
+		if ! test_have_prereq BSLASHPSPEC
+		then
+			return 1
+		fi
+		# NOTE: The ;;& bash extension is not portable, so
+		# this test needs to be at the end of the pattern
+		# list.
+		#
+		# If we want to add more conditional returns we either
+		# need a new case statement, or turn this whole thing
+		# into a series of "if" tests.
+		;;
+	esac
+
+
+	# On Windows proper (i.e. not Cygwin) many file names which
+	# under Cygwin would be emulated don't work.
+	if test_have_prereq MINGW
+	then
+		case $file in
+		" ")
+			# Files called " " are forbidden on Windows
+			return 1
+			;;
+		*\<*|*\>*|*:*|*\"*|*\|*|*\?*|*\**)
+			# Files with various special characters aren't
+			# allowed on Windows. Sourced from
+			# https://stackoverflow.com/a/31976060
+			return 1
+			;;
+		esac
+	fi
+
+	return 0
+}
+
 match_with_function() {
 	text=$1
 	pattern=$2
@@ -26,25 +92,133 @@ match_with_function() {
 
 }
 
+match_with_ls_files() {
+	text=$1
+	pattern=$2
+	match_expect=$3
+	match_function=$4
+	ls_files_args=$5
+
+	match_stdout_stderr_cmp="
+		tr -d '\0' <actual.raw >actual &&
+		>expect.err &&
+		test_cmp expect.err actual.err &&
+		test_cmp expect actual"
+
+	if test "$match_expect" = 'E'
+	then
+		if test -e .git/created_test_file
+		then
+			test_expect_success "$match_function (via ls-files): match dies on '$pattern' '$text'" "
+				printf '%s' '$text' >expect &&
+				test_must_fail git$ls_files_args ls-files -z -- '$pattern'
+			"
+		else
+			test_expect_failure "$match_function (via ls-files): match skip '$pattern' '$text'" 'false'
+		fi
+	elif test "$match_expect" = 1
+	then
+		if test -e .git/created_test_file
+		then
+			test_expect_success "$match_function (via ls-files): match '$pattern' '$text'" "
+				printf '%s' '$text' >expect &&
+				git$ls_files_args ls-files -z -- '$pattern' >actual.raw 2>actual.err &&
+				$match_stdout_stderr_cmp
+			"
+		else
+			test_expect_failure "$match_function (via ls-files): match skip '$pattern' '$text'" 'false'
+		fi
+	elif test "$match_expect" = 0
+	then
+		if test -e .git/created_test_file
+		then
+			test_expect_success "$match_function (via ls-files): no match '$pattern' '$text'" "
+				>expect &&
+				git$ls_files_args ls-files -z -- '$pattern' >actual.raw 2>actual.err &&
+				$match_stdout_stderr_cmp
+			"
+		else
+			test_expect_failure "$match_function (via ls-files): no match skip '$pattern' '$text'" 'false'
+		fi
+	else
+		test_expect_success "PANIC: Test framework error. Unknown matches value $match_expect" 'false'
+	fi
+}
+
 match() {
-	match_glob=$1
-	match_iglob=$2
-	match_pathmatch=$3
-	match_pathmatchi=$4
-	text=$5
-	pattern=$6
+	if test "$#" = 6
+	then
+		# When test-wildmatch and git ls-files produce the same
+		# result.
+		match_glob=$1
+		match_file_glob=$match_glob
+		match_iglob=$2
+		match_file_iglob=$match_iglob
+		match_pathmatch=$3
+		match_file_pathmatch=$match_pathmatch
+		match_pathmatchi=$4
+		match_file_pathmatchi=$match_pathmatchi
+		text=$5
+		pattern=$6
+	elif test "$#" = 10
+	then
+		match_glob=$1
+		match_iglob=$2
+		match_pathmatch=$3
+		match_pathmatchi=$4
+		match_file_glob=$5
+		match_file_iglob=$6
+		match_file_pathmatch=$7
+		match_file_pathmatchi=$8
+		text=$9
+		pattern=${10}
+	fi
+
+	test_expect_success 'cleanup after previous file test' '
+		if test -e .git/created_test_file
+		then
+			git reset &&
+			git clean -df
+		fi
+	'
+
+	printf '%s' "$text" >.git/expected_test_file
+
+	test_expect_success "setup match file test for $text" '
+		file=$(cat .git/expected_test_file) &&
+		if should_create_test_file "$file"
+		then
+			dirs=${file%/*}
+			if test "$file" != "$dirs"
+			then
+				mkdir -p -- "$dirs" &&
+				touch -- "./$text"
+			else
+				touch -- "./$file"
+			fi &&
+			git add -A &&
+			printf "%s" "$file" >.git/created_test_file
+		elif test -e .git/created_test_file
+		then
+			rm .git/created_test_file
+		fi
+	'
 
 	# $1: Case sensitive glob match: test-wildmatch & ls-files
 	match_with_function "$text" "$pattern" $match_glob "wildmatch"
+	match_with_ls_files "$text" "$pattern" $match_file_glob "wildmatch" " --glob-pathspecs"
 
 	# $2: Case insensitive glob match: test-wildmatch & ls-files
 	match_with_function "$text" "$pattern" $match_iglob "iwildmatch"
+	match_with_ls_files "$text" "$pattern" $match_file_iglob "iwildmatch" " --glob-pathspecs --icase-pathspecs"
 
 	# $3: Case sensitive path match: test-wildmatch & ls-files
 	match_with_function "$text" "$pattern" $match_pathmatch "pathmatch"
+	match_with_ls_files "$text" "$pattern" $match_file_pathmatch "pathmatch" ""
 
 	# $4: Case insensitive path match: test-wildmatch & ls-files
 	match_with_function "$text" "$pattern" $match_pathmatchi "ipathmatch"
+	match_with_ls_files "$text" "$pattern" $match_file_pathmatchi "ipathmatch" " --icase-pathspecs"
 }
 
 # Basic wildmatch features
@@ -113,7 +287,8 @@ match 1 1 1 1 'acrt' 'a[c-c]rt'
 match 0 0 0 0 ']' '[!]-]'
 match 1 1 1 1 'a' '[!]-]'
 match 0 0 0 0 '' '\'
-match 0 0 0 0 '\' '\'
+match 0 0 0 0 \
+      1 1 1 1 '\' '\'
 match 0 0 0 0 'XXX/\' '*/\'
 match 1 1 1 1 'XXX/\' '*/\\'
 match 1 1 1 1 'foo' 'foo'
@@ -127,7 +302,8 @@ match 1 1 1 1 '[ab]' '[[:digit]ab]'
 match 1 1 1 1 '[ab]' '[\[:]ab]'
 match 1 1 1 1 '?a?b' '\??\?b'
 match 1 1 1 1 'abc' '\a\b\c'
-match 0 0 0 0 'foo' ''
+match 0 0 0 0 \
+      E E E E 'foo' ''
 match 1 1 1 1 'foo/bar/baz/to' '**/t[o]'
 
 # Character class tests
@@ -157,8 +333,10 @@ match 1 1 1 1 ']' '[\]]'
 match 0 0 0 0 '\]' '[\]]'
 match 0 0 0 0 '\' '[\]]'
 match 0 0 0 0 'ab' 'a[]b'
-match 0 0 0 0 'a[]b' 'a[]b'
-match 0 0 0 0 'ab[' 'ab['
+match 0 0 0 0 \
+      1 1 1 1 'a[]b' 'a[]b'
+match 0 0 0 0 \
+      1 1 1 1 'ab[' 'ab['
 match 0 0 0 0 'ab' '[!'
 match 0 0 0 0 'ab' '[-'
 match 1 1 1 1 '-' '[-]'
@@ -226,7 +404,8 @@ match 1 1 1 1 foo/bar 'foo/*'
 match 0 0 1 1 foo/bba/arr 'foo/*'
 match 1 1 1 1 foo/bba/arr 'foo/**'
 match 0 0 1 1 foo/bba/arr 'foo*'
-match 0 0 1 1 foo/bba/arr 'foo**'
+match 0 0 1 1 \
+      1 1 1 1 foo/bba/arr 'foo**'
 match 0 0 1 1 foo/bba/arr 'foo/*arr'
 match 0 0 1 1 foo/bba/arr 'foo/**arr'
 match 0 0 0 0 foo/bba/arr 'foo/*z'
-- 
2.15.1.424.g9478a66081


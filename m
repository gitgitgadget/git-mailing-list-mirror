Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F6FD1F404
	for <e@80x24.org>; Sat, 23 Dec 2017 21:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757265AbdLWVan (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Dec 2017 16:30:43 -0500
Received: from mail-wr0-f175.google.com ([209.85.128.175]:37784 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757225AbdLWVai (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Dec 2017 16:30:38 -0500
Received: by mail-wr0-f175.google.com with SMTP id f8so19823942wre.4
        for <git@vger.kernel.org>; Sat, 23 Dec 2017 13:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rpG5uy+ME0FteU5oGnQUECYbPymhKhMtKK7O08DFxeU=;
        b=ltNcDGqVXhuyD3qxdtOJEjbulSlTeTFT404Fm7605RAct88IWi9wKevx8wfNjxFa+x
         U4UYCHKA1ghU2sRPNgHoWRB37BZ21gDCslYzHeT/1UT4450tXb66s5G8tnj4syKstwrE
         Oupmv9RtCLz7UIongshIYkykSTNRS5Qz7lbjpQm0GKlhy7ItMgURJJuzYYfSoNDwOcTh
         FSnAdzvCsIypXDD7tdy7ssq+U9HzJ/YGVOkPycSHAbz2nkBub5z0FUb3QSxtWPRbsnte
         AD/Am6SuCZe9bysr0euxIsugObhQHicAnCQdj+o9EJ/1Amwn4d1Se7n+3G0Q7obVlkB2
         l1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rpG5uy+ME0FteU5oGnQUECYbPymhKhMtKK7O08DFxeU=;
        b=Xo6w68Il78HV+feqAyaTrvcMvCGKN4EwHmpwK7mbv/nvFzBvjXkpQI1LtHbpDXJJZ8
         Br3oWuC7EljGz3/8uj5LYkF5iX+zJ9jeR1PJsLsZk+nP+rQzhS75suqfg4Oc8AmsTkkN
         wALDzdhFstWTHSoFsyYq3PMBfEQvjZJFC/fAN33jXjnUENgT43wzEQ0vHjkrFDzToset
         eay/EOwatZkdePWmL61l+mfEMJ/a6PAM0ysc7ijTbhvDFaCv9OFnbo8WZY+4RNkeuSqE
         +QAuIYgShhHEkaGToF0Of3CCIB1rIq1dGj907JQBVitrbCj+iHpM2uCcBQuLLVI9HVb0
         M1Tg==
X-Gm-Message-State: AKGB3mLdQ5IhE20jBVABmbdN0X1b0X2/1h4nW9l+zzt5dVDaq92CbQ7D
        O+ZySS+AWLssAQrpDuHu8CS6i+Qh
X-Google-Smtp-Source: ACJfBovuziYPnnwDl97e242ghgS8jko6atqg9C/sPmZLsG/lwvrNKMMVbKgZOO1P7ZNmAJdPrP0tfA==
X-Received: by 10.223.172.114 with SMTP id v105mr18640574wrc.229.1514064635911;
        Sat, 23 Dec 2017 13:30:35 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id c2sm29074950wrc.81.2017.12.23.13.30.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Dec 2017 13:30:35 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Anthony Ramine <n.oxyde@gmail.com>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/6] wildmatch test: create & test files on disk in addition to in-memory
Date:   Sat, 23 Dec 2017 21:30:12 +0000
Message-Id: <20171223213012.1962-7-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
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

Now there is. With this admittedly very verbose code that's mostly
copy-pasted (it doesn't look worth the effort to me in clarity to
factor this into functions) we now attempt to create a file called
$haystack and match $needle against it for each pair of $needle and
$haystack that we were passing to test-wildmatch.

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
 a[]b                 |   0
 t/t3070-wildmatch.sh | 336 ++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 319 insertions(+), 17 deletions(-)
 create mode 100644 a[]b

diff --git a/a[]b b/a[]b
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index 47b479e423..d423bb01f3 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -4,31 +4,146 @@ test_description='wildmatch tests'
 
 . ./test-lib.sh
 
+create_test_file() {
+	file=$1
+
+	# `touch .` will succeed but obviously not do what we intend
+	# here.
+	test "$file" = "." && return 1
+	# We cannot create a file with an empty filename.
+	test "$file" = "" && return 1
+	# The tests that are testing that e.g. foo//bar is matched by
+	# foo/*/bar can't be tested on filesystems since there's no
+	# way we're getting a double slash.
+	echo "$file" | grep -q -F '//' && return 1
+	# When testing the difference between foo/bar and foo/bar/ we
+	# can't test the latter.
+	echo "$file" | grep -q -E '/$' && return 1
+
+	dirs=$(echo "$file" | sed -r 's!/[^/]+$!!')
+
+	# We touch "./$file" instead of "$file" because even an
+	# escaped "touch -- -" means something different.
+	if test "$file" != "$dirs"
+	then
+		mkdir -p -- "$dirs" 2>/dev/null &&
+		touch -- "./$file" 2>/dev/null &&
+		return 0
+	else
+		touch -- "./$file" 2>/dev/null &&
+		return 0
+	fi
+	return 1
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
-		test_expect_success "wildmatch:     match '$text' '$pattern'" "
+		test_expect_success "wildmatch: match '$text' '$pattern'" "
 			test-wildmatch wildmatch '$text' '$pattern'
 		"
 	elif test "$match_w_glob" = 0
 	then
-		test_expect_success "wildmatch:  no match '$text' '$pattern'" "
+		test_expect_success "wildmatch: no match '$text' '$pattern'" "
 			! test-wildmatch wildmatch '$text' '$pattern'
 		"
 	else
 		test_expect_success "PANIC: Test framework error. Unknown matches value $match_w_glob" 'false'
 	fi
 
+	# $1: Case sensitive glob match: ls-files
+	if test "$match_f_w_glob" = 'E'
+	then
+		if create_test_file "$text"
+		then
+			test_expect_success "wildmatch(ls): match dies on '$pattern' '$text'" "
+				test_when_finished \"
+					rm -rf -- * &&
+					git reset
+				\" &&
+				git add -A &&
+				>expect.err &&
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
+				test_when_finished \"
+					rm -rf -- * &&
+					git reset
+				\" &&
+				git add -A &&
+				>expect.err &&
+				printf '%s' '$text' >expect &&
+				git --glob-pathspecs ls-files -z -- '$pattern' 2>actual.err | tr -d '\0' >actual &&
+				test_cmp expect.err actual.err &&
+				test_cmp expect actual
+			"
+		else
+			test_expect_failure "wildmatch(ls): match skip '$pattern' '$text'" 'false'
+		fi
+	elif test "$match_f_w_glob" = 0
+	then
+		if create_test_file "$text"
+		then
+			test_expect_success "wildmatch(ls): no match '$pattern' '$text'" "
+				test_when_finished \"
+					rm -rf -- * &&
+					git reset
+				\" &&
+				git add -A &&
+				>expect.err &&
+				>expect &&
+				git --glob-pathspecs ls-files -z -- '$pattern' 2>actual.err | tr -d '\0' >actual &&
+				test_cmp expect.err actual.err &&
+				test_cmp expect actual
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
-		test_expect_success "iwildmatch:    match '$text' '$pattern'" "
+		test_expect_success "iwildmatch: match '$text' '$pattern'" "
 			test-wildmatch iwildmatch '$text' '$pattern'
 		"
 	elif test "$match_w_globi" = 0
@@ -40,23 +155,145 @@ wildtest() {
 		test_expect_success "PANIC: Test framework error. Unknown matches value $match_w_globi" 'false'
 	fi
 
+	# $2: Case insensitive glob match: ls-files
+	if test "$match_f_w_globi" = 'E'
+	then
+		if create_test_file "$text"
+		then
+			test_expect_success "wildmatch(ls): match dies on '$pattern' '$text'" "
+				test_when_finished \"
+					rm -rf -- * &&
+					git reset
+				\" &&
+				git add -A &&
+				>expect.err &&
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
+				test_when_finished \"
+					rm -rf -- * &&
+					git reset
+				\" &&
+				git add -A &&
+				>expect.err &&
+				printf '%s' '$text' >expect &&
+				git --glob-pathspecs --icase-pathspecs ls-files -z -- '$pattern' 2>actual.err | tr -d '\0' >actual &&
+				test_cmp expect.err actual.err &&
+				test_cmp expect actual
+			"
+		else
+			test_expect_failure "wildmatch(ls): match skip '$pattern' '$text'" 'false'
+		fi
+	elif test "$match_f_w_globi" = 0
+	then
+		if create_test_file "$text"
+		then
+			test_expect_success "wildmatch(ls): no match '$pattern' '$text'" "
+				test_when_finished \"
+					rm -rf -- * &&
+					git reset
+				\" &&
+				git add -A &&
+				>expect.err &&
+				>expect &&
+				git --glob-pathspecs --icase-pathspecs ls-files -z -- '$pattern' 2>actual.err | tr -d '\0' >actual &&
+				test_cmp expect.err actual.err &&
+				test_cmp expect actual
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
-		test_expect_success "pathmatch:     match '$text' '$pattern'" "
+		test_expect_success "pathmatch: match '$text' '$pattern'" "
 			test-wildmatch pathmatch '$text' '$pattern'
 		"
 	elif test "$match_w_pathmatch" = 0
 	then
-		test_expect_success "pathmatch:  no match '$text' '$pattern'" "
+		test_expect_success "pathmatch: no match '$text' '$pattern'" "
 			! test-wildmatch pathmatch '$text' '$pattern'
 		"
 	else
 		test_expect_success "PANIC: Test framework error. Unknown matches value $match_w_pathmatch" 'false'
 	fi
 
+	# $4: Case sensitive path match: ls-files
+	if test "$match_f_w_pathmatch" = 'E'
+	then
+		if create_test_file "$text"
+		then
+			test_expect_success "pathmatch(ls): match dies on '$pattern' '$text'" "
+				test_when_finished \"
+					rm -rf -- * &&
+					git reset
+				\" &&
+				git add -A &&
+				>expect.err &&
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
+				test_when_finished \"
+					rm -rf -- * &&
+					git reset
+				\" &&
+				git add -A &&
+				>expect.err &&
+				printf '%s' '$text' >expect &&
+				git ls-files -z -- '$pattern' 2>actual.err | tr -d '\0' >actual &&
+				test_cmp expect.err actual.err &&
+				test_cmp expect actual
+			"
+		else
+			test_expect_failure "pathmatch(ls): match skip '$pattern' '$text'" 'false'
+		fi
+	elif test "$match_f_w_pathmatch" = 0
+	then
+		if create_test_file "$text"
+		then
+			test_expect_success "pathmatch(ls): no match '$pattern' '$text'" "
+				test_when_finished \"
+					rm -rf -- * &&
+					git reset
+				\" &&
+				git add -A &&
+				>expect.err &&
+				>expect &&
+				git ls-files -z -- '$pattern' 2>actual.err | tr -d '\0' >actual &&
+				test_cmp expect.err actual.err &&
+				test_cmp expect actual
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
@@ -67,6 +304,66 @@ wildtest() {
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
+				test_when_finished \"
+					rm -rf -- * &&
+					git reset
+				\" &&
+				git add -A &&
+				>expect.err &&
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
+				test_when_finished \"
+					rm -rf -- * &&
+					git reset
+				\" &&
+				git add -A &&
+				>expect.err &&
+				printf '%s' '$text' >expect &&
+				git --icase-pathspecs ls-files -z -- '$pattern' 2>actual.err | tr -d '\0' >actual &&
+				test_cmp expect.err actual.err &&
+				test_cmp expect actual
+			"
+		else
+			test_expect_failure "pathmatch(ls): match skip '$pattern' '$text'" 'false'
+		fi
+	elif test "$match_f_w_pathmatchi" = 0
+	then
+		if create_test_file "$text"
+		then
+			test_expect_success "ipathmatch(ls): no match '$pattern' '$text'" "
+				test_when_finished \"
+					rm -rf -- * &&
+					git reset
+				\" &&
+				git add -A &&
+				>expect.err &&
+				>expect &&
+				git ls-files -z -- '$pattern' 2>actual.err | tr -d '\0' >actual &&
+				test_cmp expect.err actual.err &&
+				test_cmp expect actual
+			"
+		else
+			test_expect_failure "pathmatch(ls): no match skip '$pattern' '$text'" 'false'
+		fi
+	else
+		test_expect_success "PANIC: Test framework error. Unknown matches value $match_f_w_pathmatchi" 'false'
+	fi
 }
 
 # Basic wildmatch features
@@ -135,7 +432,8 @@ wildtest 1 1 1 1 'acrt' 'a[c-c]rt'
 wildtest 0 0 0 0 ']' '[!]-]'
 wildtest 1 1 1 1 'a' '[!]-]'
 wildtest 0 0 0 0 '' '\'
-wildtest 0 0 0 0 '\' '\'
+wildtest 0 0 0 0 \
+	 1 1 1 1 '\' '\'
 wildtest 0 0 0 0 'XXX/\' '*/\'
 wildtest 1 1 1 1 'XXX/\' '*/\\'
 wildtest 1 1 1 1 'foo' 'foo'
@@ -149,7 +447,8 @@ wildtest 1 1 1 1 '[ab]' '[[:digit]ab]'
 wildtest 1 1 1 1 '[ab]' '[\[:]ab]'
 wildtest 1 1 1 1 '?a?b' '\??\?b'
 wildtest 1 1 1 1 'abc' '\a\b\c'
-wildtest 0 0 0 0 'foo' ''
+wildtest 0 0 0 0 \
+	 E E E E 'foo' ''
 wildtest 1 1 1 1 'foo/bar/baz/to' '**/t[o]'
 
 # Character class tests
@@ -179,8 +478,10 @@ wildtest 1 1 1 1 ']' '[\]]'
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
@@ -248,7 +549,8 @@ wildtest 1 1 1 1 foo/bar 'foo/*'
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


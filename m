Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F0ED1F45F
	for <e@80x24.org>; Mon,  6 May 2019 23:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfEFXX0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 19:23:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45015 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfEFXXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 19:23:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id c5so19477961wrs.11
        for <git@vger.kernel.org>; Mon, 06 May 2019 16:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bwSyaE7yhM+s7i8oZTsc1is77iqY7ySNlzb05eRwAgs=;
        b=JRjpPYw8wOnVZGw4k0bAFSc9k7JV8DNF9s5C+jmmxfGKooA84wrExwfxjvco3VLT4Y
         nzMgH5RVyelsEMpDvSlB0O5qfybXwSnGG3yEIWj3AIVKkPEE/cM+Qr+Yr5gkRetZGKVW
         PwKJ1Lf9tEF8tM0VGihbb+9TzfEQJw+yOTLWhe0A9BbtYQ56MI9grvQNP5KPxP+3pkw8
         lR/P0fufJP6omNV2V1grH1Ne1x+c4aCCp+VjsWVcN6hmcryPTx6m5tRieEZ7ZCa+m9Gm
         JywKzmEOlsLPgJNMVUqzTL8xBtpw8fiytmij2KMdsZkRfO/iLAnmhJ8pjQS68+C5E9Ek
         rYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bwSyaE7yhM+s7i8oZTsc1is77iqY7ySNlzb05eRwAgs=;
        b=tBP5nT58+0dnNvfXHS5RmfjzJucurlKc7Jk4v8J+SknEC4oCFCyuetwjtRYUhDWFMJ
         Ot+y14xb72rNUmxbgI/D+VYqu+GCsqTtZWzqRkfO54ZJOdrAPVfFdMTNM+KgLKLoeZZZ
         Mvk1z8Pr6c/2NeIjl97ksAa3d7ib4m7DAHuO6mcFx11xw87iM4dzbGVR531pMtFUOcDP
         ofRUckNxcvZFYMDPHvHr6J32CI+ZT0GXbu4dgfH6dHojUKAyEB+OblpqaKg4eLMtBco4
         QfG7mzAzmed/XACKmDqHTQLDdbbpGYUNtaugIM0AXiljIIOePBp2meWHMb3BSWtaTYEZ
         kCmg==
X-Gm-Message-State: APjAAAXZsG18tYsD+wHEE9rTijQY7rC/HZS5UkXXJQoBpPOUn2rBQgDI
        kDjoDYJ8BNp1shS5vYEYCfrLORXzUWA=
X-Google-Smtp-Source: APXvYqzutdcnElYVCu+YWrMtBlU1sxjv01ElOYCcMyr1scpsNGXo4eeDwxRzgeMwZkvAli0P9u52QA==
X-Received: by 2002:adf:f588:: with SMTP id f8mr7898342wro.282.1557185002383;
        Mon, 06 May 2019 16:23:22 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c131sm9094436wma.31.2019.05.06.16.23.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 16:23:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/2] perf-lib.sh: remove GIT_TEST_INSTALLED from perf-lib.sh
Date:   Tue,  7 May 2019 01:23:09 +0200
Message-Id: <20190506232309.28538-3-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18
In-Reply-To: <20190506202451.GA19850@sigill.intra.peff.net>
References: <20190506202451.GA19850@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Follow-up my preceding change which fixed the immediate "./run
<revisions>" regression in 0baf78e7bc ("perf-lib.sh: rely on
test-lib.sh for --tee handling", 2019-03-15) and entirely get rid of
GIT_TEST_INSTALLED from perf-lib.sh (and aggregate.perl).

As noted in that change the dance we're doing with GIT_TEST_INSTALLED
perf-lib.sh isn't necessary, but there I was doing the most minimal
set of changes to quickly fix a regression.

But it's much simpler to never deal with the "GIT_TEST_INSTALLED" we
were setting in perf-lib.sh at all. Instead the run_dirs_helper() sets
the previously inferred $PERF_RESULTS_PREFIX directly.

Setting this at the callsite that's already best positioned to
exhaustively know about all the different cases we need to handle
where PERF_RESULTS_PREFIX isn't what we want already (the empty
string) makes the most sense. In one-off cases like:

    ./run ./p0000-perf-lib-sanity.sh
    ./p0000-perf-lib-sanity.sh

We'll just do the right thing because PERF_RESULTS_PREFIX will be
empty, and test-lib.sh takes care of finding where our git is.

Refactoring this revealed a few bugs, e.g. while a relative git path
was supported via e.g.:

    ./run ../../ -- <test>

We'd just print out ".." as the header, since we'd always take the
content after the last slash. Now we'll always resolve the absolute
path to something we detect to be be a manually supplied bindir, and
print the full path in the aggregation.

There was also a long-standing bug in the codespeed output where the
"environment" for N number of tests would be whatever our
GIT_TEST_INSTALLED had been set to by the last of those N runs. Let's
instead just fall back to "uname -r", which is a more sensible
"environment" than some random build directory path, even for the N=1
case.

Also simplify the "[_*]" on the RHS of "tr -c", we're trimming
everything to "_", so we don't need that.

https://public-inbox.org/git/20190502222409.GA15631@sigill.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/perf/aggregate.perl | 13 ++++++-------
 t/perf/perf-lib.sh    | 15 +--------------
 t/perf/run            | 45 +++++++++++++++++++++++++++++--------------
 3 files changed, 38 insertions(+), 35 deletions(-)

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index 494907a892..c8f4a78903 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -6,6 +6,7 @@
 use JSON;
 use Getopt::Long;
 use Git;
+use Cwd qw(realpath);
 
 sub get_times {
 	my $name = shift;
@@ -103,13 +104,14 @@ sub format_size {
 	if (! -d $arg) {
 		my $rev = Git::command_oneline(qw(rev-parse --verify), $arg);
 		$dir = "build/".$rev;
+	} elsif ($arg eq '.') {
+		$dir = '.';
 	} else {
-		$arg =~ s{/*$}{};
-		$dir = $arg;
-		$dirabbrevs{$dir} = $dir;
+		$dir = realpath($arg);
+		$dirnames{$dir} = $dir;
 	}
 	push @dirs, $dir;
-	$dirnames{$dir} = $arg;
+	$dirnames{$dir} ||= $arg;
 	my $prefix = $dir;
 	$prefix =~ tr/^a-zA-Z0-9/_/c;
 	$prefixes{$dir} = $prefix . '.';
@@ -312,9 +314,6 @@ sub print_codespeed_results {
 		$environment = $reponame;
 	} elsif (exists $ENV{GIT_PERF_REPO_NAME} and $ENV{GIT_PERF_REPO_NAME} ne "") {
 		$environment = $ENV{GIT_PERF_REPO_NAME};
-	} elsif (exists $ENV{GIT_TEST_INSTALLED} and $ENV{GIT_TEST_INSTALLED} ne "") {
-		$environment = $ENV{GIT_TEST_INSTALLED};
-		$environment =~ s|/bin-wrappers$||;
 	} else {
 		$environment = `uname -r`;
 		chomp $environment;
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index b15ee1d262..9cdccba222 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -21,25 +21,12 @@
 # because it will change our working directory.
 TEST_DIRECTORY=$(pwd)/..
 TEST_OUTPUT_DIRECTORY=$(pwd)
-ABSOLUTE_GIT_TEST_INSTALLED=$(
-	test -n "$GIT_TEST_INSTALLED" && cd "$GIT_TEST_INSTALLED" && pwd)
 
 TEST_NO_CREATE_REPO=t
 TEST_NO_MALLOC_CHECK=t
 
 . ../test-lib.sh
 
-if test -z "$GIT_TEST_INSTALLED"; then
-	perf_results_prefix=
-else
-	if test -n "$GIT_PERF_DIR_MYDIR_REL"
-	then
-		GIT_TEST_INSTALLED=$GIT_PERF_DIR_MYDIR_REL
-	fi
-	perf_results_prefix=$(printf "%s" "${GIT_TEST_INSTALLED%/bin-wrappers}" | tr -c "[a-zA-Z0-9]" "[_*]")"."
-	GIT_TEST_INSTALLED=$ABSOLUTE_GIT_TEST_INSTALLED
-fi
-
 # Variables from test-lib that are normally internal to the tests; we
 # need to export them for test_perf subshells
 export TEST_DIRECTORY TRASH_DIRECTORY GIT_BUILD_DIR GIT_TEST_CMP
@@ -183,7 +170,7 @@ test_wrapper_ () {
 		base=$(basename "$0" .sh)
 		echo "$test_count" >>"$perf_results_dir"/$base.subtests
 		echo "$1" >"$perf_results_dir"/$base.$test_count.descr
-		base="$perf_results_dir"/"$perf_results_prefix$(basename "$0" .sh)"."$test_count"
+		base="$perf_results_dir"/"$PERF_RESULTS_PREFIX$(basename "$0" .sh)"."$test_count"
 		"$test_wrapper_func_" "$@"
 	fi
 
diff --git a/t/perf/run b/t/perf/run
index 0a7c8744ab..85b7bd31d5 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -70,6 +70,22 @@ build_git_rev () {
 	) || die "failed to build revision '$mydir'"
 }
 
+set_git_test_installed () {
+	mydir=$1
+
+	mydir_abs=$(cd $mydir && pwd)
+	mydir_abs_wrappers="$mydir_abs_wrappers/bin-wrappers"
+	if test -d "$mydir_abs_wrappers"
+	then
+		GIT_TEST_INSTALLED=$mydir_abs_wrappers
+	else
+		# Older versions of git lacked bin-wrappers;
+		# fallback to the files in the root.
+		GIT_TEST_INSTALLED=$mydir_abs
+	fi
+	export GIT_TEST_INSTALLED
+}
+
 run_dirs_helper () {
 	mydir=${1%/}
 	shift
@@ -79,7 +95,16 @@ run_dirs_helper () {
 	if test $# -gt 0 -a "$1" = --; then
 		shift
 	fi
-	if [ ! -d "$mydir" ]; then
+
+	PERF_RESULTS_PREFIX=
+	if test "$mydir" = "."
+	then
+		unset GIT_TEST_INSTALLED
+	elif test -d "$mydir"
+	then
+		PERF_RESULTS_PREFIX=$(cd $mydir && printf "%s" "$(pwd)" | tr -c "[a-zA-Z0-9]" "_").
+		set_git_test_installed "$mydir"
+	else
 		rev=$(git rev-parse --verify "$mydir" 2>/dev/null) ||
 		die "'$mydir' is neither a directory nor a valid revision"
 		if [ ! -d build/$rev ]; then
@@ -87,20 +112,12 @@ run_dirs_helper () {
 		fi
 		build_git_rev $rev "$mydir"
 		mydir=build/$rev
+
+		PERF_RESULTS_PREFIX=build_$rev.
+		set_git_test_installed "$mydir"
 	fi
-	if test "$mydir" = .; then
-		unset GIT_TEST_INSTALLED
-	else
-		GIT_PERF_DIR_MYDIR_REL=$mydir
-		GIT_PERF_DIR_MYDIR_ABS=$(cd $mydir && pwd)
-		export GIT_PERF_DIR_MYDIR_REL GIT_PERF_DIR_MYDIR_ABS
-
-		GIT_TEST_INSTALLED="$GIT_PERF_DIR_MYDIR_ABS/bin-wrappers"
-		# Older versions of git lacked bin-wrappers; fallback to the
-		# files in the root.
-		test -d "$GIT_TEST_INSTALLED" || GIT_TEST_INSTALLED=$GIT_PERF_DIR_MYDIR_ABS
-		export GIT_TEST_INSTALLED
-	fi
+	export PERF_RESULTS_PREFIX
+
 	run_one_dir "$@"
 }
 
-- 
2.21.0.593.g511ec345e18


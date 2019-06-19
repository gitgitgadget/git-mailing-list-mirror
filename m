Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CD351F462
	for <e@80x24.org>; Wed, 19 Jun 2019 23:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbfFSXbF (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 19:31:05 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:55965 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730747AbfFSXbE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 19:31:04 -0400
Received: by mail-wm1-f42.google.com with SMTP id a15so1120292wmj.5
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 16:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BOKarEEAdG3LkHbv06JofqJHfsqof2DwY3Sj/B/olYY=;
        b=h18lc9BjHYfwhz+cboE4wGVux34f6eEV4uj9Xac+1r2UPePJTpeh+7q+2iJVY0IEsr
         m97WOQ8mHnLxTeA1Q92bkVA6YbkdCveiEft6k9wXFNM+bLi8yd6HvHylU7pB+GkS8oRu
         qfg2DJNsLDT0WxTceQV9du7A9T28GMhtSUdUe+NHVew1XHhzy574XkVZigTLxEJMYamB
         OOt78EQSuCz6fiq/jblp5O0sqmtsdd8QD+3/o2Mcku3QZo9rtxMdW1g7wVkDa7aqNv4q
         e0Jdse0WpWe3RJEZBj/UMVIMExE0/03rE6PJK9QsaHsnJ0s+mvqEO2GHjyXUP76hCAc4
         Lv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BOKarEEAdG3LkHbv06JofqJHfsqof2DwY3Sj/B/olYY=;
        b=ML399ye1Rd+PLfCVU/JZFo51cdQztSqAwB7ll9Beniuk/FUIVWpdWQxIS+gkfKXu2Z
         WubtD4fG6fSXWhBjX7pKHGXqfYqGZkWee7RM4zi+WlZV8TPwY12839OFowYXVvuEPmTT
         UG/WR0g5Ut9Lt2ddYQuQKuWt2XjQUv6T2X6tIMZJW+p0m2VPBXEfOk/A76Cy83qp/hoa
         B3pd3PqJ6YV/PHTOyY5Ln5PvGs93VVKZ8kaR+eyhizEgng8oMZHOGPmY1HlTwkhDRdnt
         XZ4KeO7UvoHIJbAS2vVLIAl5Yly5EJzD/yfBe2ObdUTnyB3uKxwH/Cfi88+fZExrx24M
         o+7Q==
X-Gm-Message-State: APjAAAVksq/JJz4Amtt289ZxQt8PkbRyY8K9yaVvqT0m5FeQIUcrtrLt
        EOzQWXDib5HyaK0/nPSJXoPA75P4AyM=
X-Google-Smtp-Source: APXvYqzQWSGio/o947YXTc4UiqrS5J/6rF7QZqSXR65kFVDbQDx6Da8rJBSOOIJUCTQlMiSahCPfNg==
X-Received: by 2002:a05:600c:2201:: with SMTP id z1mr9519241wml.59.1560987061896;
        Wed, 19 Jun 2019 16:31:01 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b6sm17964958wrx.85.2019.06.19.16.31.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 16:31:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/6] tests: replace test_tristate with "git env--helper"
Date:   Thu, 20 Jun 2019 01:30:45 +0200
Message-Id: <20190619233046.27503-6-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244
In-Reply-To: <87imt18a2r.fsf@evledraar.gmail.com>
References: <87imt18a2r.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_tristate helper introduced in 83d842dc8c ("tests: turn on
network daemon tests by default", 2014-02-10) can now be better
implemented with "git env--helper" to give the variables in question
the standard boolean behavior.

The reason for the "tristate" was to have all of false/true/auto,
where "auto" meant either "false" or "true" depending on what the
fallback was. With the --default option to "git env--helper" we can
simply have e.g. GIT_TEST_HTTPD where we know if it's true because the
user asked explicitly ("true"), or true implicitly ("auto").

This breaks backwards compatibility for explicitly setting "auto" for
these variables, but I don't think anyone cares. That was always
intended to be internal.

This means the test_normalize_bool() code in test-lib-functions.sh
goes away in addition to test_tristate(). We still need the
test_skip_or_die() helper, but now it takes the variable name instead
of the value, and uses "git env--bool" to distinguish a default "true"
from an explicit "true" (in those "explicit true" cases we want to
fail the test in question).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-git-daemon.sh     |  7 +++---
 t/lib-git-svn.sh        | 11 +++-----
 t/lib-httpd.sh          | 15 ++++++-----
 t/t5512-ls-remote.sh    |  3 +--
 t/test-lib-functions.sh | 56 ++++++-----------------------------------
 5 files changed, 22 insertions(+), 70 deletions(-)

diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index 7b3407134e..770c5218ea 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -15,8 +15,7 @@
 #
 #	test_done
 
-test_tristate GIT_TEST_GIT_DAEMON
-if test "$GIT_TEST_GIT_DAEMON" = false
+if ! git env--helper --mode-bool --variable=GIT_TEST_GIT_DAEMON --default=1 --exit-code --quiet
 then
 	skip_all="git-daemon testing disabled (unset GIT_TEST_GIT_DAEMON to enable)"
 	test_done
@@ -24,7 +23,7 @@ fi
 
 if test_have_prereq !PIPE
 then
-	test_skip_or_die $GIT_TEST_GIT_DAEMON "file system does not support FIFOs"
+	test_skip_or_die GIT_TEST_GIT_DAEMON "file system does not support FIFOs"
 fi
 
 test_set_port LIB_GIT_DAEMON_PORT
@@ -73,7 +72,7 @@ start_git_daemon() {
 		kill "$GIT_DAEMON_PID"
 		wait "$GIT_DAEMON_PID"
 		unset GIT_DAEMON_PID
-		test_skip_or_die $GIT_TEST_GIT_DAEMON \
+		test_skip_or_die GIT_TEST_GIT_DAEMON \
 			"git daemon failed to start"
 	fi
 }
diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index c1271d6863..853d33a57a 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -69,14 +69,12 @@ svn_cmd () {
 maybe_start_httpd () {
 	loc=${1-svn}
 
-	test_tristate GIT_SVN_TEST_HTTPD
-	case $GIT_SVN_TEST_HTTPD in
-	true)
+	if git env--helper --mode-bool --variable=GIT_TEST_HTTPD --default=0 --exit-code --quiet	
+	then
 		. "$TEST_DIRECTORY"/lib-httpd.sh
 		LIB_HTTPD_SVN="$loc"
 		start_httpd
-		;;
-	esac
+	fi
 }
 
 convert_to_rev_db () {
@@ -106,8 +104,7 @@ EOF
 }
 
 require_svnserve () {
-	test_tristate GIT_TEST_SVNSERVE
-	if ! test "$GIT_TEST_SVNSERVE" = true
+	if ! git env--helper --mode-bool --variable=GIT_TEST_SVNSERVE --default=0 --exit-code --quiet
 	then
 		skip_all='skipping svnserve test. (set $GIT_TEST_SVNSERVE to enable)'
 		test_done
diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index b3cc62bd36..eef3250552 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -41,15 +41,14 @@ then
 	test_done
 fi
 
-test_tristate GIT_TEST_HTTPD
-if test "$GIT_TEST_HTTPD" = false
+if ! git env--helper --mode-bool --variable=GIT_TEST_HTTPD --default=1 --exit-code --quiet
 then
 	skip_all="Network testing disabled (unset GIT_TEST_HTTPD to enable)"
 	test_done
 fi
 
 if ! test_have_prereq NOT_ROOT; then
-	test_skip_or_die $GIT_TEST_HTTPD \
+	test_skip_or_die GIT_TEST_HTTPD \
 		"Cannot run httpd tests as root"
 fi
 
@@ -95,7 +94,7 @@ GIT_TRACE=$GIT_TRACE; export GIT_TRACE
 
 if ! test -x "$LIB_HTTPD_PATH"
 then
-	test_skip_or_die $GIT_TEST_HTTPD "no web server found at '$LIB_HTTPD_PATH'"
+	test_skip_or_die GIT_TEST_HTTPD "no web server found at '$LIB_HTTPD_PATH'"
 fi
 
 HTTPD_VERSION=$($LIB_HTTPD_PATH -v | \
@@ -107,19 +106,19 @@ then
 	then
 		if ! test $HTTPD_VERSION -ge 2
 		then
-			test_skip_or_die $GIT_TEST_HTTPD \
+			test_skip_or_die GIT_TEST_HTTPD \
 				"at least Apache version 2 is required"
 		fi
 		if ! test -d "$DEFAULT_HTTPD_MODULE_PATH"
 		then
-			test_skip_or_die $GIT_TEST_HTTPD \
+			test_skip_or_die GIT_TEST_HTTPD \
 				"Apache module directory not found"
 		fi
 
 		LIB_HTTPD_MODULE_PATH="$DEFAULT_HTTPD_MODULE_PATH"
 	fi
 else
-	test_skip_or_die $GIT_TEST_HTTPD \
+	test_skip_or_die GIT_TEST_HTTPD \
 		"Could not identify web server at '$LIB_HTTPD_PATH'"
 fi
 
@@ -184,7 +183,7 @@ start_httpd() {
 	if test $? -ne 0
 	then
 		cat "$HTTPD_ROOT_PATH"/error.log >&4 2>/dev/null
-		test_skip_or_die $GIT_TEST_HTTPD "web server setup failed"
+		test_skip_or_die GIT_TEST_HTTPD "web server setup failed"
 	fi
 }
 
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index e3c4a48c85..7161148280 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -267,8 +267,7 @@ test_expect_success 'ls-remote --symref omits filtered-out matches' '
 '
 
 test_lazy_prereq GIT_DAEMON '
-	test_tristate GIT_TEST_GIT_DAEMON &&
-	test "$GIT_TEST_GIT_DAEMON" != false
+	git env--helper --mode-bool --variable=GIT_TEST_GIT_DAEMON --default=1 --exit-code --quiet
 '
 
 # This test spawns a daemon, so run it only if the user would be OK with
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 0367cec5fd..527508c350 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1035,62 +1035,20 @@ perl () {
 	command "$PERL_PATH" "$@" 2>&7
 } 7>&2 2>&4
 
-# Is the value one of the various ways to spell a boolean true/false?
-test_normalize_bool () {
-	git -c magic.variable="$1" config --bool magic.variable 2>/dev/null
-}
-
-# Given a variable $1, normalize the value of it to one of "true",
-# "false", or "auto" and store the result to it.
-#
-#     test_tristate GIT_TEST_HTTPD
-#
-# A variable set to an empty string is set to 'false'.
-# A variable set to 'false' or 'auto' keeps its value.
-# Anything else is set to 'true'.
-# An unset variable defaults to 'auto'.
-#
-# The last rule is to allow people to set the variable to an empty
-# string and export it to decline testing the particular feature
-# for versions both before and after this change.  We used to treat
-# both unset and empty variable as a signal for "do not test" and
-# took any non-empty string as "please test".
-
-test_tristate () {
-	if eval "test x\"\${$1+isset}\" = xisset"
-	then
-		# explicitly set
-		eval "
-			case \"\$$1\" in
-			'')	$1=false ;;
-			auto)	;;
-			*)	$1=\$(test_normalize_bool \$$1 || echo true) ;;
-			esac
-		"
-	else
-		eval "$1=auto"
-	fi
-}
-
 # Exit the test suite, either by skipping all remaining tests or by
-# exiting with an error. If "$1" is "auto", we then we assume we were
-# opportunistically trying to set up some tests and we skip. If it is
-# "true", then we report a failure.
+# exiting with an error. If our prerequisite variable $1 falls back
+# on a default assume we were opportunistically trying to set up some
+# tests and we skip. If it is explicitly "true", then we report a failure.
 #
 # The error/skip message should be given by $2.
 #
 test_skip_or_die () {
-	case "$1" in
-	auto)
+	if ! git env--helper --mode-bool --variable=$1 --default=0 --exit-code --quiet
+	then
 		skip_all=$2
 		test_done
-		;;
-	true)
-		error "$2"
-		;;
-	*)
-		error "BUG: test tristate is '$1' (real error: $2)"
-	esac
+	fi
+	error "$2"
 }
 
 # The following mingw_* functions obey POSIX shell syntax, but are actually
-- 
2.22.0.rc1.257.g3120a18244


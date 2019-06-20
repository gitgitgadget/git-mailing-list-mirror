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
	by dcvr.yhbt.net (Postfix) with ESMTP id C93871F461
	for <e@80x24.org>; Thu, 20 Jun 2019 21:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfFTVJi (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 17:09:38 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:52195 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfFTVJh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 17:09:37 -0400
Received: by mail-wm1-f48.google.com with SMTP id 207so4404503wma.1
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 14:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZbsQgxnESEY3YYiMY0agnmvKhmMc3d9HyAlmvav+Onw=;
        b=ps5pS81kgeQWSQcwCd/clr75ZRrIap3aoIxoXejPBZp/3x8E+bATFEpjWU/TiYPDGf
         0FB7kM0ElI4cV7upz0NA7xqXxweSb8gV7sQLs+blA8LB9Y4gKcjAYxqX2UPPy0sPA8Eg
         DW6Ci/sRVBhr/ArsGRF42ByvUAr+m2c5fgyaMS96+xm+kI4VD2dsqGF7yGxjRU3a/e1q
         UUFe9qRYKme40206oEc0q4FOpfZn+PypDmuVRIlPElWcsv2jI4SdcA5uLg5mzRO/KdjD
         AzG5gaOZFFqb9hHXQBxnn8i5ASv9lzeNnlBWw5ZXBFK2Up1cLjugqCOByBjHwKEtgx9J
         rBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZbsQgxnESEY3YYiMY0agnmvKhmMc3d9HyAlmvav+Onw=;
        b=mQ/2jarsfchxMYJeEEfE3R8oZvLQtVd0qBcHi6jLfhb78oU77BzPsc/EB1k75M9+DZ
         a+Q4nQavS5OUf3p/CQk9YCeux9fMphCdJodPtYxgvwvVSpLj05nZ6tbql2nuXclEG0Rc
         0MbH1TTzhopBBP+Ybv3wjHfqO4qgOpt9qJ5OjhQRsV7JIiA1S5IdDkfQPJEW8djbLI18
         DDmNXbK1/+xO9YlfZDKfPSHgFb04WJwINulgAaw/z74DJLRQFi9k9H1n13IF66m6RMRs
         wizynmATFQQ9wdXfj5zJW276QSaYxbqLXj2oFdtH4ib9aDkM2Lj1oUFQuvnua4Zi5xT5
         s7Uw==
X-Gm-Message-State: APjAAAUzNIzcaro+Z1DKg5R0ojBEowb7oYjKrUzJVVb2LR6DmV9zzIEA
        5gqJoLFCd3NVFDEyU4Tt86qbrZXm2dw=
X-Google-Smtp-Source: APXvYqxpnK1WRoyDyXGLuiC9EQ1Z8ET9/ZR44JmsJLRnvDkN9zse7kAx/Su4sHTqZ2Antfv5H3lemQ==
X-Received: by 2002:a7b:c7d7:: with SMTP id z23mr997515wmk.46.1561064974725;
        Thu, 20 Jun 2019 14:09:34 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x8sm1295781wre.73.2019.06.20.14.09.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 14:09:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 7/8] tests: replace test_tristate with "git env--helper"
Date:   Thu, 20 Jun 2019 23:09:14 +0200
Message-Id: <20190620210915.11297-8-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190619233046.27503-1-avarab@gmail.com>
References: <20190619233046.27503-1-avarab@gmail.com>
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
2.22.0.455.g172b71a6c5


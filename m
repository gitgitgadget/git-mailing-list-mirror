From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 4/6] test-lib.sh: Fix some shell coding style violations
Date: Sat, 01 Sep 2012 19:11:49 +0100
Message-ID: <50424FE5.4010301@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 01 20:28:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7sQi-0004P4-Sj
	for gcvg-git-2@plane.gmane.org; Sat, 01 Sep 2012 20:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755574Ab2IAS2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Sep 2012 14:28:14 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:44536 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755451Ab2IAS2M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2012 14:28:12 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 82A81128077;
	Sat,  1 Sep 2012 19:28:11 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 645AF128075;	Sat,  1 Sep 2012 19:28:10 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tch.inty.net (Postfix) with ESMTP;	Sat,  1 Sep 2012 19:28:09 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204645>



Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 t/test-lib.sh | 60 +++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 22 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 78c4286..56b028c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -100,12 +100,12 @@ unset CDPATH
 unset GREP_OPTIONS
 
 case $(echo $GIT_TRACE |tr "[A-Z]" "[a-z]") in
-	1|2|true)
-		echo "* warning: Some tests will not work if GIT_TRACE" \
-			"is set as to trace on STDERR ! *"
-		echo "* warning: Please set GIT_TRACE to something" \
-			"other than 1, 2 or true ! *"
-		;;
+1|2|true)
+	echo "* warning: Some tests will not work if GIT_TRACE" \
+		"is set as to trace on STDERR ! *"
+	echo "* warning: Please set GIT_TRACE to something" \
+		"other than 1, 2 or true ! *"
+	;;
 esac
 
 # Convenience
@@ -172,17 +172,23 @@ do
 	esac
 done
 
-if test -n "$color"; then
+if test -n "$color"
+then
 	say_color () {
 		(
 		TERM=$ORIGINAL_TERM
 		export TERM
 		case "$1" in
-			error) tput bold; tput setaf 1;; # bold red
-			skip)  tput bold; tput setaf 2;; # bold green
-			pass)  tput setaf 2;;            # green
-			info)  tput setaf 3;;            # brown
-			*) test -n "$quiet" && return;;
+		error)
+			tput bold; tput setaf 1;; # bold red
+		skip)
+			tput bold; tput setaf 2;; # bold green
+		pass)
+			tput setaf 2;;            # green
+		info)
+			tput setaf 3;;            # brown
+		*)
+			test -n "$quiet" && return;;
 		esac
 		shift
 		printf "%s" "$*"
@@ -298,7 +304,8 @@ test_run_ () {
 	then
 		test_eval_ "$test_cleanup"
 	fi
-	if test "$verbose" = "t" && test -n "$HARNESS_ACTIVE"; then
+	if test "$verbose" = "t" && test -n "$HARNESS_ACTIVE"
+	then
 		echo ""
 	fi
 	return "$eval_ret"
@@ -346,7 +353,8 @@ test_at_end_hook_ () {
 test_done () {
 	GIT_EXIT_OK=t
 
-	if test -z "$HARNESS_ACTIVE"; then
+	if test -z "$HARNESS_ACTIVE"
+	then
 		test_results_dir="$TEST_OUTPUT_DIRECTORY/test-results"
 		mkdir -p "$test_results_dir"
 		test_results_path="$test_results_dir/${0%.sh}-$$.counts"
@@ -377,7 +385,8 @@ test_done () {
 		# Maybe print SKIP message
 		[ -z "$skip_all" ] || skip_all=" # SKIP $skip_all"
 
-		if test $test_external_has_tap -eq 0; then
+		if test $test_external_has_tap -eq 0
+		then
 			say_color pass "# passed all $msg"
 			say "1..$test_count$skip_all"
 		fi
@@ -391,7 +400,8 @@ test_done () {
 		exit 0 ;;
 
 	*)
-		if test $test_external_has_tap -eq 0; then
+		if test $test_external_has_tap -eq 0
+		then
 			say_color error "# failed $test_failure among $msg"
 			say "1..$test_count"
 		fi
@@ -471,22 +481,26 @@ then
 	PATH=$GIT_VALGRIND/bin:$PATH
 	GIT_EXEC_PATH=$GIT_VALGRIND/bin
 	export GIT_VALGRIND
-elif test -n "$GIT_TEST_INSTALLED" ; then
+elif test -n "$GIT_TEST_INSTALLED"
+then
 	GIT_EXEC_PATH=$($GIT_TEST_INSTALLED/git --exec-path)  ||
 	error "Cannot run git from $GIT_TEST_INSTALLED."
 	PATH=$GIT_TEST_INSTALLED:$GIT_BUILD_DIR:$PATH
 	GIT_EXEC_PATH=${GIT_TEST_EXEC_PATH:-$GIT_EXEC_PATH}
 else # normal case, use ../bin-wrappers only unless $with_dashes:
 	git_bin_dir="$GIT_BUILD_DIR/bin-wrappers"
-	if ! test -x "$git_bin_dir/git" ; then
-		if test -z "$with_dashes" ; then
+	if ! test -x "$git_bin_dir/git"
+	then
+		if test -z "$with_dashes"
+		then
 			say "$git_bin_dir/git is not executable; using GIT_EXEC_PATH"
 		fi
 		with_dashes=t
 	fi
 	PATH="$git_bin_dir:$PATH"
 	GIT_EXEC_PATH=$GIT_BUILD_DIR
-	if test -n "$with_dashes" ; then
+	if test -n "$with_dashes"
+	then
 		PATH="$GIT_BUILD_DIR:$PATH"
 	fi
 fi
@@ -521,7 +535,8 @@ then
 	}
 fi
 
-if ! test -x "$GIT_BUILD_DIR"/test-chmtime; then
+if ! test -x "$GIT_BUILD_DIR"/test-chmtime
+then
 	echo >&2 'You need to build test-chmtime:'
 	echo >&2 'Run "make test-chmtime" in the source (toplevel) directory'
 	exit 1
@@ -544,7 +559,8 @@ rm -fr "$test" || {
 HOME="$TRASH_DIRECTORY"
 export HOME
 
-if test -z "$TEST_NO_CREATE_REPO"; then
+if test -z "$TEST_NO_CREATE_REPO"
+then
 	test_create_repo "$test"
 else
 	mkdir -p "$test"
-- 
1.7.12

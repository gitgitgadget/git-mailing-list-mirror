From: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
Subject: [RFC/PATCH] git-what: explain what to do next
Date: Tue, 27 May 2008 10:34:59 +0200
Message-ID: <1211877299-27255-1-git-send-email-sbejar@gmail.com>
Cc: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 10:36:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0ufN-0001uv-Oo
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 10:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756142AbYE0Ifc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 04:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757451AbYE0Ifc
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 04:35:32 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:44272 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757443AbYE0If3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 04:35:29 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1539500ywe.1
        for <git@vger.kernel.org>; Tue, 27 May 2008 01:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=SJ26FAnb4YOI5EP/LPw8SwZ6A9HYMVhJZVdAkxu1Nro=;
        b=tFQFSxOZYCGGEWk8vUjl0dxwnlVAoZh91xvET/hgnP3so4NM5igfIL7fIBhUgzvzS4CE6p2O4RZV95ym04yjBS1k5YqYOHYQWMTMzVwslkg8hmJWjbzQAyDLcAxpr9Dxjk/FNNzTBfeozEEs3KLBdPK4mQ3ro6voZaVOD4ZY67o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=vjyHDu64+z69CCIbsjd2bAUlh+QvUZR+lYZ7dku+aE+/ZLa0K+QLuARP5OzRrXEB7C1zNXKe/5A4rMb4Ay2ItpF6c/D/czp0uRsgBCU1jF2WhvMGY9UmXZZk/du016ADuAdty4ayCzuoJ6FN673CsNa+qRIeFz42gL98mgc/dRk=
Received: by 10.103.161.16 with SMTP id n16mr1017736muo.134.1211877319891;
        Tue, 27 May 2008 01:35:19 -0700 (PDT)
Received: from localhost ( [91.13.64.240])
        by mx.google.com with ESMTPS id i5sm39257092mue.2.2008.05.27.01.35.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 May 2008 01:35:17 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.rc0.14.g4e34b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82990>

In case you don't know the next step, if it is "git commit",
"git commit --amend", "git rebase --continue" or something else.

---

 Hi *,

 there are some todo, as:

# TODO: explain the context?
#         * which commit you are
#         * which commit you cherry-pick, revert
#         * how many commits left in the bisect
#         * ...
# TODO: Move some logic to "git commit"?
# TODO: Show the help from "git cherry-pick" -> -c $sha1 ...

 What do you think about the idea and the implementation?

 Santi

 .gitignore                    |    1 +
 Makefile                      |    1 +
 git-am.sh                     |   12 ++++++++++++
 git-bisect.sh                 |   37 ++++++++++++++++++++++++++++++++++++-
 git-merge.sh                  |   24 +++++++++++++++++++++---
 git-rebase--interactive.sh    |   25 ++++++++++++++++---------
 git-rebase.sh                 |   10 +++++++++-
 git-what.sh                   |   23 +++++++++++++++++++++++
 t/t3404-rebase-interactive.sh |   37 +++++++++++++++++++++++++++++++++++++
 t/t7800/expect_am             |    3 +++
 t/t7800/expect_bisect_bad     |    2 ++
 t/t7800/expect_bisect_both    |    5 +++++
 t/t7800/expect_bisect_good    |    2 ++
 t/t7800/expect_bisect_start   |    3 +++
 t/t7800/expect_cherry_pick    |    2 ++
 t/t7800/expect_merge          |    2 ++
 t/t7800/expect_merge_squash   |    2 ++
 t/t7800/expect_rebase         |    6 ++++++
 t/t7800/expect_revert         |    2 ++
 19 files changed, 185 insertions(+), 14 deletions(-)
 create mode 100644 git-what.sh
 create mode 100644 t/t7800/expect_am
 create mode 100644 t/t7800/expect_bisect_bad
 create mode 100644 t/t7800/expect_bisect_both
 create mode 100644 t/t7800/expect_bisect_good
 create mode 100644 t/t7800/expect_bisect_start
 create mode 100644 t/t7800/expect_cherry_pick
 create mode 100644 t/t7800/expect_merge
 create mode 100644 t/t7800/expect_merge_squash
 create mode 100644 t/t7800/expect_rebase
 create mode 100644 t/t7800/expect_revert

diff --git a/.gitignore b/.gitignore
index 4ff2fec..7d2b1a6 100644
--- a/.gitignore
+++ b/.gitignore
@@ -137,6 +137,7 @@ git-var
 git-verify-pack
 git-verify-tag
 git-web--browse
+git-what
 git-whatchanged
 git-write-tree
 git-core-*/?*
diff --git a/Makefile b/Makefile
index f08d5f7..1d23241 100644
--- a/Makefile
+++ b/Makefile
@@ -254,6 +254,7 @@ SCRIPT_SH += git-sh-setup.sh
 SCRIPT_SH += git-stash.sh
 SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
+SCRIPT_SH += git-what.sh
 
 SCRIPT_PERL += git-add--interactive.perl
 SCRIPT_PERL += git-archimport.perl
diff --git a/git-am.sh b/git-am.sh
index b48096e..2cfb430 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -22,6 +22,7 @@ p=              pass it through git-apply
 resolvemsg=     override error message when patch failure occurs
 r,resolved      to be used after a patch failure
 skip            skip the current patch
+what            explain what to do if in the middle of an am
 rebasing        (internal use for git-rebase)"
 
 . git-sh-setup
@@ -33,6 +34,7 @@ cd_to_toplevel
 git var GIT_COMMITTER_IDENT >/dev/null || exit
 
 stop_here () {
+    [ "$what" = t ] && exit
     echo "$1" >"$dotest/next"
     exit 1
 }
@@ -122,6 +124,7 @@ dotest=".dotest"
 sign= utf8=t keep= skip= interactive= resolved= binary= rebasing=
 resolvemsg= resume=
 git_apply_opt=
+what=
 
 while test $# != 0
 do
@@ -155,6 +158,8 @@ do
 		git_apply_opt="$git_apply_opt $1=$2"; shift ;;
 	-C|-p)
 		git_apply_opt="$git_apply_opt $1$2"; shift ;;
+	--what)
+		what=t ;;
 	--)
 		shift; break ;;
 	*)
@@ -163,6 +168,13 @@ do
 	shift
 done
 
+if test -n "$what" ; then
+   test ! -e "$dotest/next" && exit 1
+   echo "You are in the middle of a \"git am\":"
+   stop_here_user_resolve
+   exit
+fi
+
 # If the dotest directory exists, but we have finished applying all the
 # patches in them, clear it out.
 if test -d "$dotest" &&
diff --git a/git-bisect.sh b/git-bisect.sh
index 4bcbace..27d3946 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-USAGE='[help|start|bad|good|skip|next|reset|visualize|replay|log|run]'
+USAGE='[help|start|bad|good|skip|next|reset|visualize|replay|log|run|what]'
 LONG_USAGE='git bisect help
         print this long help message.
 git bisect start [<bad> [<good>...]] [--] [<pathspec>...]
@@ -23,6 +23,8 @@ git bisect log
         show bisect log.
 git bisect run <cmd>...
         use <cmd>... to automatically bisect.
+git bisect what...
+        explain what to do if in the midle of a bisect.
 
 Please use "git help bisect" to get the full man page.'
 
@@ -206,6 +208,14 @@ bisect_next_check() {
 	test -n "$(git for-each-ref "refs/bisect/good-*")" || missing_good=t
 
 	case "$missing_good,$missing_bad,$1" in
+	,,what)
+		# have both good and bad - ok
+		echo "Test the commit and mark it as"
+		echo "bad)  $ git bisect bad"
+		echo "good) $ git bisect good"
+		echo "skip) $ git bisect skip"
+		exit
+		;;
 	,,*)
 		: have both good and bad - ok
 		;;
@@ -213,6 +223,16 @@ bisect_next_check() {
 		# do not have both but not asked to fail - just report.
 		false
 		;;
+	,t,what)
+		# have good but not bad.
+		echo "No bad commit, mark one with \"git bisect bad <rev>"\"
+		exit
+		;;
+	t,,what)
+		# have bad but not good.
+		echo "No good commit, mark one with \"git bisect good <rev>\""
+		exit
+		;;
 	t,,good)
 		# have bad but not good.  we could bisect although
 		# this is less optimum.
@@ -224,6 +244,14 @@ bisect_next_check() {
 		fi
 		: bisect without good...
 		;;
+	t,t,what)
+		# TODO: Reuse the text in the next case
+		echo 'You need to give me at least one good' \
+			'and one bad revisions.'
+		echo '(You can use "git bisect bad" and' \
+			'"git bisect good" for that.)'
+		exit
+		;;
 	*)
 		THEN=''
 		test -f "$GIT_DIR/BISECT_NAMES" || {
@@ -497,6 +525,11 @@ bisect_run () {
     done
 }
 
+bisect_what () {
+	test -s "$GIT_DIR/BISECT_START" || return 1
+	echo "You are in the middle of a bisect:"
+	bisect_next_check what
+}
 
 case "$#" in
 0)
@@ -524,6 +557,8 @@ case "$#" in
 	cat "$GIT_DIR/BISECT_LOG" ;;
     run)
         bisect_run "$@" ;;
+    what)
+	bisect_what ;;
     *)
         usage ;;
     esac
diff --git a/git-merge.sh b/git-merge.sh
index 5fc5f52..a729621 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -17,6 +17,7 @@ commit               perform a commit if the merge sucesses (default)
 ff                   allow fast forward (default)
 s,strategy=          merge strategy to use
 m,message=           message to be used for the merge commit (if any)
+what                 explain what to do if in the middle of a merge
 "
 
 SUBDIRECTORY_OK=Yes
@@ -24,9 +25,6 @@ SUBDIRECTORY_OK=Yes
 require_work_tree
 cd_to_toplevel
 
-test -z "$(git ls-files -u)" ||
-	die "You are in the middle of a conflicted merge."
-
 LF='
 '
 
@@ -40,6 +38,7 @@ use_strategies=
 allow_fast_forward=t
 allow_trivial_merge=t
 squash= no_commit= log_arg=
+what=
 
 dropsave() {
 	rm -f -- "$GIT_DIR/MERGE_HEAD" "$GIT_DIR/MERGE_MSG" \
@@ -186,6 +185,9 @@ parse_config () {
 			merge_msg="$1"
 			have_message=t
 			;;
+		--what)
+			shift
+			what=t ;;
 		--)
 			shift
 			break ;;
@@ -212,6 +214,22 @@ fi
 parse_config "$@"
 while test $args_left -lt $#; do shift; done
 
+if test -n "$what" ; then
+     if test -f "$GIT_DIR"/MERGE_HEAD ; then
+	 echo "You are in the middle of a merge:"
+	 echo "Fix conflicts and then commit the result."
+	 exit
+     elif test -f "$GIT_DIR"/SQUASH_MSG ; then
+	 echo "You are in the middle of a merge --squash:"
+	 echo "Fix conflicts and then commit the result."
+	 exit
+     fi
+     exit 1
+fi
+
+test -z "$(git ls-files -u)" ||
+	die "You are in the middle of a conflicted merge."
+
 if test -z "$show_diffstat"; then
     test "$(git config --bool merge.diffstat)" = false && show_diffstat=false
     test "$(git config --bool merge.stat)" = false && show_diffstat=false
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 8ee08ff..0ca35e2 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -35,6 +35,16 @@ mark the corrected paths with 'git add <paths>', and
 run 'git rebase --continue'"
 export GIT_CHERRY_PICK_HELP
 
+AMENDMSG="
+You can amend the commit now, with
+
+	git commit --amend
+
+Once you are satisfied with your changes, run
+
+	git rebase --continue"
+
+
 warn () {
 	echo "$*" >&2
 }
@@ -263,15 +273,7 @@ do_next () {
 			die_with_patch $sha1 "Could not apply $sha1... $rest"
 		make_patch $sha1
 		: > "$DOTEST"/amend
-		warn
-		warn "You can amend the commit now, with"
-		warn
-		warn "	git commit --amend"
-		warn
-		warn "Once you are satisfied with your changes, run"
-		warn
-		warn "	git rebase --continue"
-		warn
+		warn "$AMENDMSG"
 		exit 0
 		;;
 	squash|s)
@@ -437,6 +439,11 @@ do
 			shift ;;
 		esac
 		;;
+	--what)
+		test ! -f "$DOTEST"/interactive && exit 1
+		test -e "$DOTEST"/amend && echo "$AMENDMSG" && exit
+		echo "$GIT_CHERRY_PICK_HELP" && exit
+		;;
 	-m|--merge)
 		# we use merge anyway
 		;;
diff --git a/git-rebase.sh b/git-rebase.sh
index dd7dfe1..20afce5 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Junio C Hamano.
 #
 
-USAGE='[--interactive | -i] [-v] [--onto <newbase>] <upstream> [<branch>]'
+USAGE='[--what] [--interactive | -i] [-v] [--onto <newbase>] <upstream> [<branch>]'
 LONG_USAGE='git-rebase replaces <branch> with a new branch of the
 same name.  When the --onto option is provided the new branch starts
 out with a HEAD equal to <newbase>, otherwise it is equal to <upstream>
@@ -46,6 +46,7 @@ dotest=$GIT_DIR/.dotest-merge
 prec=4
 verbose=
 git_am_opt=
+what=
 
 continue_merge () {
 	test -n "$prev_head" || die "prev_head must be defined"
@@ -249,6 +250,13 @@ do
 	-C*)
 		git_am_opt="$git_am_opt $1"
 		;;
+	--what)
+		test ! -f ".dotest/onto" && exit 1
+		test -f "$dotest"/interactive && exec git-rebase--interactive --what
+		echo "You are in the middle of a rebase:"
+		echo "$RESOLVEMSG"
+		exit
+		;;
 	-*)
 		usage
 		;;
diff --git a/git-what.sh b/git-what.sh
new file mode 100644
index 0000000..316f1e3
--- /dev/null
+++ b/git-what.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+
+commit_what () {
+    # TODO: Move this to "git commit"?
+    # TODO: Show the help from "git cherry-pick" -> -c $sha1 ...
+    GIT_DIR=$(git rev-parse --git-dir) || return 1
+    test -f "$GIT_DIR"/MERGE_MSG || return 1
+    echo "You are in the middle of a prepared commit:"
+    echo "Fix conflicts and then commit the result."
+    return
+}
+
+git bisect what ||
+git merge --what ||
+git rebase --what ||
+commit_what ||
+git am --what
+
+# TODO: explain the context?
+#         * which commit you are
+#         * which commit you cherry-pick, revert
+#         * how many commits left in the bisect
+#         * ...
\ No newline at end of file
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index b9e3dbd..54a6646 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -302,6 +302,12 @@ test_expect_success 'ignore patch if in upstream' '
 	test $HEAD = $(git rev-parse HEAD^)
 '
 
+cat > expect <<EOF
+When you have resolved this problem run \"git rebase --continue\".
+If you would prefer to skip this patch, instead run \"git rebase --skip\".
+To restore the original branch and stop rebasing run \"git rebase --abort\".
+EOF
+
 test_expect_success '--continue tries to commit, even for "edit"' '
 	parent=$(git rev-parse HEAD^) &&
 	test_tick &&
@@ -360,4 +366,35 @@ test_expect_success 'rebase with a file named HEAD in worktree' '
 
 '
 
+cat > expect <<EOF
+  After resolving the conflicts,
+mark the corrected paths with 'git add <paths>', and
+run 'git rebase --continue'
+EOF
+
+test_expect_success 'rebase, git what' '
+	git reset --hard master~1 &&
+	! git rebase -i original-branch1 &&
+	git what > output &&
+	test_cmp expect output
+'
+
+cat > expect <<EOF
+
+You can amend the commit now, with
+
+	git commit --amend
+
+Once you are satisfied with your changes, run
+
+	git rebase --continue
+EOF
+
+test_expect_success 'rebase (amend), git what' '
+	git rebase --abort &&
+	FAKE_LINES="edit 1" git rebase -i HEAD^ &&
+	git what > output &&
+	test_cmp expect output
+'
+
 test_done
diff --git a/t/t7800/expect_am b/t/t7800/expect_am
new file mode 100644
index 0000000..9278d5d
--- /dev/null
+++ b/t/t7800/expect_am
@@ -0,0 +1,3 @@
+You are in the middle of a "git am":
+When you have resolved this problem run "git-am --resolved".
+If you would prefer to skip this patch, instead run "git-am --skip".
diff --git a/t/t7800/expect_bisect_bad b/t/t7800/expect_bisect_bad
new file mode 100644
index 0000000..602751f
--- /dev/null
+++ b/t/t7800/expect_bisect_bad
@@ -0,0 +1,2 @@
+You are in the middle of a bisect:
+No good commit, mark one with "git bisect good <rev>"
diff --git a/t/t7800/expect_bisect_both b/t/t7800/expect_bisect_both
new file mode 100644
index 0000000..8b0f950
--- /dev/null
+++ b/t/t7800/expect_bisect_both
@@ -0,0 +1,5 @@
+You are in the middle of a bisect:
+Test the commit and mark it as
+bad)  $ git bisect bad
+good) $ git bisect good
+skip) $ git bisect skip
diff --git a/t/t7800/expect_bisect_good b/t/t7800/expect_bisect_good
new file mode 100644
index 0000000..c136a27
--- /dev/null
+++ b/t/t7800/expect_bisect_good
@@ -0,0 +1,2 @@
+You are in the middle of a bisect:
+No bad commit, mark one with "git bisect bad <rev>"
diff --git a/t/t7800/expect_bisect_start b/t/t7800/expect_bisect_start
new file mode 100644
index 0000000..923396b
--- /dev/null
+++ b/t/t7800/expect_bisect_start
@@ -0,0 +1,3 @@
+You are in the middle of a bisect:
+You need to give me at least one good and one bad revisions.
+(You can use "git bisect bad" and "git bisect good" for that.)
diff --git a/t/t7800/expect_cherry_pick b/t/t7800/expect_cherry_pick
new file mode 100644
index 0000000..60e733e
--- /dev/null
+++ b/t/t7800/expect_cherry_pick
@@ -0,0 +1,2 @@
+You are in the middle of a prepared commit:
+Fix conflicts and then commit the result.
diff --git a/t/t7800/expect_merge b/t/t7800/expect_merge
new file mode 100644
index 0000000..2c9b821
--- /dev/null
+++ b/t/t7800/expect_merge
@@ -0,0 +1,2 @@
+You are in the middle of a merge:
+Fix conflicts and then commit the result.
diff --git a/t/t7800/expect_merge_squash b/t/t7800/expect_merge_squash
new file mode 100644
index 0000000..3cdd4fa
--- /dev/null
+++ b/t/t7800/expect_merge_squash
@@ -0,0 +1,2 @@
+You are in the middle of a merge --squash:
+Fix conflicts and then commit the result.
diff --git a/t/t7800/expect_rebase b/t/t7800/expect_rebase
new file mode 100644
index 0000000..3975cc0
--- /dev/null
+++ b/t/t7800/expect_rebase
@@ -0,0 +1,6 @@
+You are in the middle of a rebase:
+
+When you have resolved this problem run "git rebase --continue".
+If you would prefer to skip this patch, instead run "git rebase --skip".
+To restore the original branch and stop rebasing run "git rebase --abort".
+
diff --git a/t/t7800/expect_revert b/t/t7800/expect_revert
new file mode 100644
index 0000000..60e733e
--- /dev/null
+++ b/t/t7800/expect_revert
@@ -0,0 +1,2 @@
+You are in the middle of a prepared commit:
+Fix conflicts and then commit the result.
-- 
1.5.6.rc0.14.g4e34b.dirty

From: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH] contrib/what: "git status" for am/bisect/cherry-pick/merge/rebase/revert
Date: Thu, 12 Jun 2008 21:13:53 +0200
Message-ID: <1213298033-6086-2-git-send-email-sbejar@gmail.com>
References: <1213298033-6086-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 21:15:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6sG5-0005N9-NI
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 21:14:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753940AbYFLTNw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jun 2008 15:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753761AbYFLTNw
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 15:13:52 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:40607 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904AbYFLTNu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 15:13:50 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2576373fgg.17
        for <git@vger.kernel.org>; Thu, 12 Jun 2008 12:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=CigNxU8aW+6yoB3hHXhEtzT8vr5Ma6f3hPl0DjZJwCc=;
        b=LhUFid9YmzahBEy9ETh8A92+dG6gDW/vu9bzvB4blBNWrQkb5operNgjSIhgEXFr6J
         wnyUL50BbDw/s5NC9S8x3Fk3J+nU8oMHpkEYsuhJjbPfErs3AMXkRV92qnFOjaHIpFTu
         Irs/DN5h+LKSFzqu7PlqDMx8KW6ZNjAi/f6oA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=VwkKtJIOgo58f25C3gbT32AXdAs2rhqBKM7j+YPOCjMhtQ1p+WZv1okr7i7BniIim1
         I+1J8XJ7aOnoLV62HBwWMkUTdB0bSJyJ9vP4/j2tI7XHJ8SodRZ/NL+Mgac+/hyMQFh6
         a0V8zTUd9BV8VD0PLMzfvPl1bFilnhmtMOObw=
Received: by 10.86.80.17 with SMTP id d17mr2822220fgb.24.1213298029185;
        Thu, 12 Jun 2008 12:13:49 -0700 (PDT)
Received: from localhost ( [91.13.108.184])
        by mx.google.com with ESMTPS id d6sm3827380fga.2.2008.06.12.12.13.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Jun 2008 12:13:47 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.rc2.28.gc1eec
In-Reply-To: <1213298033-6086-1-git-send-email-sbejar@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84773>


Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
Hi *,

  for now, hoping the git-sequencer allows this, I've convert my git-wh=
at script
  to a single script.

  Also I've added some test that can be run thanks to my other path

[PATCH] test-lib: Allow to be used by contrib projects

 But they can also be run if they are copied to the toplevel t/ directo=
ry.=20

 contrib/what/git-what                    |   86 ++++++++++++++++
 contrib/what/t/Makefile                  |    4 +
 contrib/what/t/t7800-what.sh             |  159 ++++++++++++++++++++++=
++++++++
 contrib/what/t/t7800/expect_am           |    3 +
 contrib/what/t/t7800/expect_bisect       |    3 +
 contrib/what/t/t7800/expect_cherry_pick  |    2 +
 contrib/what/t/t7800/expect_merge        |    2 +
 contrib/what/t/t7800/expect_merge_squash |    2 +
 contrib/what/t/t7800/expect_rebase       |    6 +
 contrib/what/t/t7800/expect_rebase_edit  |    9 ++
 contrib/what/t/t7800/expect_rebase_i     |    4 +
 contrib/what/t/t7800/expect_revert       |    2 +
 contrib/what/t/test-lib.sh               |    6 +
 13 files changed, 288 insertions(+), 0 deletions(-)
 create mode 100755 contrib/what/git-what
 create mode 100644 contrib/what/t/Makefile
 create mode 100755 contrib/what/t/t7800-what.sh
 create mode 100644 contrib/what/t/t7800/expect_am
 create mode 100644 contrib/what/t/t7800/expect_bisect
 create mode 100644 contrib/what/t/t7800/expect_cherry_pick
 create mode 100644 contrib/what/t/t7800/expect_merge
 create mode 100644 contrib/what/t/t7800/expect_merge_squash
 create mode 100644 contrib/what/t/t7800/expect_rebase
 create mode 100644 contrib/what/t/t7800/expect_rebase_edit
 create mode 100644 contrib/what/t/t7800/expect_rebase_i
 create mode 100644 contrib/what/t/t7800/expect_revert
 create mode 100644 contrib/what/t/test-lib.sh

diff --git a/contrib/what/git-what b/contrib/what/git-what
new file mode 100755
index 0000000..5ea13b3
--- /dev/null
+++ b/contrib/what/git-what
@@ -0,0 +1,86 @@
+#!/bin/sh
+
+gitdir=3D"$(git rev-parse --git-dir 2>/dev/null)"
+
+test -z "$gitdir" && exit
+
+dotest=3D"$gitdir/../.dotest"
+dotestint=3D"$gitdir/.dotest-merge"
+
+if [ -d "$dotest" ] ; then
+    what=3D"AM"
+    test -f "$dotest/rebasing" && what=3D"REBASE"
+elif test -f "$dotestint/interactive" ; then
+    what=3D"REBASE-I"
+    test -f "$dotestint/amend" && what=3D"REBASE-AMEND"
+elif test -f "$gitdir/SQUASH_MSG" ; then
+    what=3D"MERGE-SQUASH"
+elif test -f "$gitdir/MERGE_HEAD" ; then
+    what=3D"MERGE"
+elif test -f "$gitdir/MERGE_MSG" ; then
+    what=3D"PICK"
+elif test -f "$gitdir/BISECT_LOG" ; then
+    what=3D"BISECT"
+else
+    exit 1
+fi
+
+case $what in
+    REBASE)
+	cmd=3Drebase
+	HELP=3D"
+When you have resolved this problem run \"git rebase --continue\".
+If you would prefer to skip this patch, instead run \"git rebase --ski=
p\".
+To restore the original branch and stop rebasing run \"git rebase --ab=
ort\".
+"
+	;;
+    REBASE-AMEND)
+	cmd=3D"rebase (edit)"
+	HELP=3D"
+You can amend the commit now, with
+
+	git commit --amend
+
+Once you are satisfied with your changes, run
+
+	git rebase --continue"
+	;;
+    REBASE-AM)
+	cmd=3Drebase
+	HELP=3D"  After resolving the conflicts,
+mark the corrected paths with 'git add <paths>', and
+run 'git rebase --continue'"
+	;;
+    REBASE-I)
+	cmd=3D"rebase -i"
+	HELP=3D"  After resolving the conflicts,
+mark the corrected paths with 'git add <paths>', and
+run 'git rebase --continue'"
+	;;
+    AM)
+	cmd=3D"\"git am\""
+	cmdline=3D"git am"
+	HELP=3D"When you have resolved this problem run \"$cmdline --resolved=
\".
+If you would prefer to skip this patch, instead run \"$cmdline --skip\=
"."
+	;;
+    MERGE)
+	cmd=3Dmerge
+	HELP=3D"Fix conflicts and then commit the result."
+	;;
+    MERGE-SQUASH)
+	cmd=3D"merge --squash"
+	HELP=3D"Fix conflicts and then commit the result."
+	;;
+    PICK)
+	cmd=3D"prepared commit"
+	HELP=3D"Fix conflicts and then commit the result."
+	;;
+    BISECT)
+	cmd=3Dbisect
+	HELP=3D'You need to give me at least one good and one bad revisions.
+(You can use "git bisect bad" and "git bisect good" for that.)'
+	;;
+esac
+
+echo "You are in the middle of a $cmd:"
+echo "$HELP"
diff --git a/contrib/what/t/Makefile b/contrib/what/t/Makefile
new file mode 100644
index 0000000..790c81c
--- /dev/null
+++ b/contrib/what/t/Makefile
@@ -0,0 +1,4 @@
+# Run tests
+#
+
+include ../../../t/Makefile
diff --git a/contrib/what/t/t7800-what.sh b/contrib/what/t/t7800-what.s=
h
new file mode 100755
index 0000000..93c5f60
--- /dev/null
+++ b/contrib/what/t/t7800-what.sh
@@ -0,0 +1,159 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Santi B=C3=A9jar, based on t4013 by Junio C Haman=
o
+#
+#
+
+test_description=3D'What next?'
+
+. ./test-lib.sh
+
+LF=3D'
+'
+
+test_expect_success setup '
+	GIT_AUTHOR_DATE=3D"2006-06-26 00:00:00 +0000" &&
+	GIT_COMMITTER_DATE=3D"2006-06-26 00:00:00 +0000" &&
+	export GIT_AUTHOR_DATE GIT_COMMITTER_DATE &&
+
+	echo 1 >file &&
+	git add file &&
+	git commit -a -m 1 &&
+	git tag tag-1 &&
+	git branch 1 &&
+
+	echo 1a >> file &&
+	git commit -a -m 1a &&
+	git tag tag-1a &&
+	git branch 1a &&
+
+	echo 1a1 >> file &&
+	git commit -a -m 1a1 &&
+	git tag tag-1a1 &&
+	git branch 1a1 &&
+
+        git reset --hard tag-1 &&
+	echo 1b >> file &&
+	git commit -a -m 1b &&
+	git tag tag-1b &&
+	git branch 1b
+'
+
+test_output() {
+    if test -f "$1"
+    then
+	test_cmp "$1" "$2" &&
+	rm -f "$2"
+    else
+	# this is to help developing new tests.
+	cp "$2" "$1"
+	false
+    fi
+}
+
+echo "#!$SHELL_PATH" >fake-editor.sh
+cat >> fake-editor.sh <<\EOF
+case "$1" in
+*/COMMIT_EDITMSG)
+	test -z "$FAKE_COMMIT_MESSAGE" || echo "$FAKE_COMMIT_MESSAGE" > "$1"
+	test -z "$FAKE_COMMIT_AMEND" || echo "$FAKE_COMMIT_AMEND" >> "$1"
+	exit
+	;;
+esac
+test -z "$EXPECT_COUNT" ||
+	test "$EXPECT_COUNT" =3D $(sed -e '/^#/d' -e '/^$/d' < "$1" | wc -l) =
||
+	exit
+test -z "$FAKE_LINES" && exit
+grep -v '^#' < "$1" > "$1".tmp
+rm -f "$1"
+cat "$1".tmp
+action=3Dpick
+for line in $FAKE_LINES; do
+	case $line in
+	squash|edit)
+		action=3D"$line";;
+	*)
+		echo sed -n "${line}s/^pick/$action/p"
+		sed -n "${line}p" < "$1".tmp
+		sed -n "${line}s/^pick/$action/p" < "$1".tmp >> "$1"
+		action=3Dpick;;
+	esac
+done
+EOF
+
+test_set_editor "$(pwd)/fake-editor.sh"
+chmod a+x fake-editor.sh
+
+test_expect_success "what: nothing" '
+	! git what
+'
+
+test_expect_success "what: bisect" '
+	git bisect start &&
+	git what > output &&
+	git bisect reset &&
+	test_output ../t7800/expect_bisect output
+'
+
+test_expect_success "what: merge" '
+	git checkout master &&
+	git reset --hard tag-1a &&
+	! git merge tag-1b &&
+	git what > output &&
+	test_output ../t7800/expect_merge output
+'
+
+test_expect_success "what: merge --squash" '
+	git reset --hard tag-1a &&
+	! git merge --squash tag-1b &&
+	git what > output &&
+	test_output ../t7800/expect_merge_squash output
+'
+
+test_expect_success "what: rebase" '
+	git reset --hard tag-1b &&
+	! git rebase tag-1a1 &&
+	git what > output &&
+	git rebase --abort &&
+	test_output ../t7800/expect_rebase output
+'
+
+test_expect_success 'what: rebase -i' '
+	git reset --hard tag-1b &&
+	! git rebase -i tag-1a1 &&
+	git what > output &&
+	git rebase --abort &&
+	test_output ../t7800/expect_rebase_i output
+'
+
+test_expect_success 'what: rebase (amend)' '
+	git reset --hard tag-1b &&
+	FAKE_LINES=3D"edit 1" git rebase -i HEAD^ &&
+	git what > output &&
+	git rebase --abort &&
+	test_output ../t7800/expect_rebase_edit output
+'
+
+test_expect_success "what: cherry-pick" '
+	git reset --hard tag-1b &&
+	! git cherry-pick tag-1a &&
+	git what > output &&
+	test_output ../t7800/expect_cherry_pick output
+'
+
+test_expect_success "what: revert" '
+	git reset --hard tag-1a1 &&
+	! git revert tag-1a &&
+	git what > output &&
+	test_output ../t7800/expect_revert output
+'
+
+test_expect_success "what: am" '
+	git reset --hard tag-1b &&
+	git format-patch --stdout tag-1..tag-1a1 > mbox &&
+	! git am mbox &&
+	git what > output &&
+	test_output ../t7800/expect_am output
+'
+
+test_done
diff --git a/contrib/what/t/t7800/expect_am b/contrib/what/t/t7800/expe=
ct_am
new file mode 100644
index 0000000..618d93e
--- /dev/null
+++ b/contrib/what/t/t7800/expect_am
@@ -0,0 +1,3 @@
+You are in the middle of a "git am":
+When you have resolved this problem run "git am --resolved".
+If you would prefer to skip this patch, instead run "git am --skip".
diff --git a/contrib/what/t/t7800/expect_bisect b/contrib/what/t/t7800/=
expect_bisect
new file mode 100644
index 0000000..923396b
--- /dev/null
+++ b/contrib/what/t/t7800/expect_bisect
@@ -0,0 +1,3 @@
+You are in the middle of a bisect:
+You need to give me at least one good and one bad revisions.
+(You can use "git bisect bad" and "git bisect good" for that.)
diff --git a/contrib/what/t/t7800/expect_cherry_pick b/contrib/what/t/t=
7800/expect_cherry_pick
new file mode 100644
index 0000000..60e733e
--- /dev/null
+++ b/contrib/what/t/t7800/expect_cherry_pick
@@ -0,0 +1,2 @@
+You are in the middle of a prepared commit:
+Fix conflicts and then commit the result.
diff --git a/contrib/what/t/t7800/expect_merge b/contrib/what/t/t7800/e=
xpect_merge
new file mode 100644
index 0000000..2c9b821
--- /dev/null
+++ b/contrib/what/t/t7800/expect_merge
@@ -0,0 +1,2 @@
+You are in the middle of a merge:
+Fix conflicts and then commit the result.
diff --git a/contrib/what/t/t7800/expect_merge_squash b/contrib/what/t/=
t7800/expect_merge_squash
new file mode 100644
index 0000000..3cdd4fa
--- /dev/null
+++ b/contrib/what/t/t7800/expect_merge_squash
@@ -0,0 +1,2 @@
+You are in the middle of a merge --squash:
+Fix conflicts and then commit the result.
diff --git a/contrib/what/t/t7800/expect_rebase b/contrib/what/t/t7800/=
expect_rebase
new file mode 100644
index 0000000..3975cc0
--- /dev/null
+++ b/contrib/what/t/t7800/expect_rebase
@@ -0,0 +1,6 @@
+You are in the middle of a rebase:
+
+When you have resolved this problem run "git rebase --continue".
+If you would prefer to skip this patch, instead run "git rebase --skip=
".
+To restore the original branch and stop rebasing run "git rebase --abo=
rt".
+
diff --git a/contrib/what/t/t7800/expect_rebase_edit b/contrib/what/t/t=
7800/expect_rebase_edit
new file mode 100644
index 0000000..e4d76c2
--- /dev/null
+++ b/contrib/what/t/t7800/expect_rebase_edit
@@ -0,0 +1,9 @@
+You are in the middle of a rebase (edit):
+
+You can amend the commit now, with
+
+	git commit --amend
+
+Once you are satisfied with your changes, run
+
+	git rebase --continue
diff --git a/contrib/what/t/t7800/expect_rebase_i b/contrib/what/t/t780=
0/expect_rebase_i
new file mode 100644
index 0000000..e17f5a7
--- /dev/null
+++ b/contrib/what/t/t7800/expect_rebase_i
@@ -0,0 +1,4 @@
+You are in the middle of a rebase -i:
+  After resolving the conflicts,
+mark the corrected paths with 'git add <paths>', and
+run 'git rebase --continue'
diff --git a/contrib/what/t/t7800/expect_revert b/contrib/what/t/t7800/=
expect_revert
new file mode 100644
index 0000000..60e733e
--- /dev/null
+++ b/contrib/what/t/t7800/expect_revert
@@ -0,0 +1,2 @@
+You are in the middle of a prepared commit:
+Fix conflicts and then commit the result.
diff --git a/contrib/what/t/test-lib.sh b/contrib/what/t/test-lib.sh
new file mode 100644
index 0000000..1ce596a
--- /dev/null
+++ b/contrib/what/t/test-lib.sh
@@ -0,0 +1,6 @@
+#!/bin/sh
+
+GIT_TEST_DIR=3D$(pwd)/../../../t
+PATH=3D$(pwd)/..:$PATH
+. ../../../t/test-lib.sh
+
--=20
1.5.5.3

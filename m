From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCHv3 01/16] bash prompt: fix redirection coding style in tests
Date: Mon, 24 Jun 2013 18:39:11 +0200
Message-ID: <1372091966-19315-2-git-send-email-szeder@ira.uka.de>
References: <1372091966-19315-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eduardo D'Avila <erdavila@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 24 18:42:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur9qt-0002Pv-Me
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 18:42:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011Ab3FXQmr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Jun 2013 12:42:47 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:54415 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168Ab3FXQmr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 12:42:47 -0400
Received: from localhost6.localdomain6 (f050230012.adsl.alicedsl.de [78.50.230.12])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0MeHrG-1UdKBU0tlW-00Pv9S; Mon, 24 Jun 2013 18:42:38 +0200
X-Mailer: git-send-email 1.8.3.1.599.gbe80ec9
In-Reply-To: <1372091966-19315-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:I0LdoGhhgKMLnYXBOwxP8WNtK0BMJKEpAOjAaUgXV4o
 y95JO34YZTbXn1okeH6cAWWqZRClKuwLIOLwsRnABumq0liS/0
 qG8O5qpNv5ik3ZtzsI5gck3sz0FqyLCj8tOfPXhJmw/E7WwLys
 rZCOD8B/r0l7cov/zPh2D32502X29/jL9i56EmC3zpu/W/jFxQ
 m4jM+TdYxmGPLDiHIFa6USY0WJ/ewsRt6nySW2hyQ28WH+DMbL
 Co8tWSE96liCUk3fS1HkYLOrmsYJNoDwig+M5i2RReUVokzkpj
 ivIU9ObFlTqxAJawROCSq6TYjjriJ5yJUMDh/y16GRnuQbx0xc
 a/7NGe+cJNySloUrW8e6hjDu/somQATtPIgUvFpfWfaP9Bwtie
 E+luodV4Uzl8A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228852>

Use '>file' instead of '> file', in accordance with the coding
guidelines.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 t/t9903-bash-prompt.sh | 232 ++++++++++++++++++++++++-----------------=
--------
 1 file changed, 116 insertions(+), 116 deletions(-)

diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 15521cc4..7c7f8b97 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -14,98 +14,98 @@ actual=3D"$TRASH_DIRECTORY/actual"
 test_expect_success 'setup for prompt tests' '
 	mkdir -p subdir/subsubdir &&
 	git init otherrepo &&
-	echo 1 > file &&
+	echo 1 >file &&
 	git add file &&
 	test_tick &&
 	git commit -m initial &&
 	git tag -a -m msg1 t1 &&
 	git checkout -b b1 &&
-	echo 2 > file &&
+	echo 2 >file &&
 	git commit -m "second b1" file &&
-	echo 3 > file &&
+	echo 3 >file &&
 	git commit -m "third b1" file &&
 	git tag -a -m msg2 t2 &&
 	git checkout -b b2 master &&
-	echo 0 > file &&
+	echo 0 >file &&
 	git commit -m "second b2" file &&
-	echo 00 > file &&
+	echo 00 >file &&
 	git commit -m "another b2" file &&
-	echo 000 > file &&
+	echo 000 >file &&
 	git commit -m "yet another b2" file &&
 	git checkout master
 '
=20
 test_expect_success 'gitdir - from command line (through $__git_dir)' =
'
-	echo "$TRASH_DIRECTORY/otherrepo/.git" > expected &&
+	echo "$TRASH_DIRECTORY/otherrepo/.git" >expected &&
 	(
 		__git_dir=3D"$TRASH_DIRECTORY/otherrepo/.git" &&
-		__gitdir > "$actual"
+		__gitdir >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'gitdir - repo as argument' '
-	echo "otherrepo/.git" > expected &&
-	__gitdir "otherrepo" > "$actual" &&
+	echo "otherrepo/.git" >expected &&
+	__gitdir "otherrepo" >"$actual" &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'gitdir - remote as argument' '
-	echo "remote" > expected &&
-	__gitdir "remote" > "$actual" &&
+	echo "remote" >expected &&
+	__gitdir "remote" >"$actual" &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'gitdir - .git directory in cwd' '
-	echo ".git" > expected &&
-	__gitdir > "$actual" &&
+	echo ".git" >expected &&
+	__gitdir >"$actual" &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'gitdir - .git directory in parent' '
-	echo "$(pwd -P)/.git" > expected &&
+	echo "$(pwd -P)/.git" >expected &&
 	(
 		cd subdir/subsubdir &&
-		__gitdir > "$actual"
+		__gitdir >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'gitdir - cwd is a .git directory' '
-	echo "." > expected &&
+	echo "." >expected &&
 	(
 		cd .git &&
-		__gitdir > "$actual"
+		__gitdir >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'gitdir - parent is a .git directory' '
-	echo "$(pwd -P)/.git" > expected &&
+	echo "$(pwd -P)/.git" >expected &&
 	(
 		cd .git/refs/heads &&
-		__gitdir > "$actual"
+		__gitdir >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'gitdir - $GIT_DIR set while .git directory in cwd=
' '
-	echo "$TRASH_DIRECTORY/otherrepo/.git" > expected &&
+	echo "$TRASH_DIRECTORY/otherrepo/.git" >expected &&
 	(
 		GIT_DIR=3D"$TRASH_DIRECTORY/otherrepo/.git" &&
 		export GIT_DIR &&
-		__gitdir > "$actual"
+		__gitdir >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'gitdir - $GIT_DIR set while .git directory in par=
ent' '
-	echo "$TRASH_DIRECTORY/otherrepo/.git" > expected &&
+	echo "$TRASH_DIRECTORY/otherrepo/.git" >expected &&
 	(
 		GIT_DIR=3D"$TRASH_DIRECTORY/otherrepo/.git" &&
 		export GIT_DIR &&
 		cd subdir &&
-		__gitdir > "$actual"
+		__gitdir >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
@@ -119,36 +119,36 @@ test_expect_success 'gitdir - non-existing $GIT_D=
IR' '
 '
=20
 test_expect_success 'gitdir - gitfile in cwd' '
-	echo "$(pwd -P)/otherrepo/.git" > expected &&
-	echo "gitdir: $TRASH_DIRECTORY/otherrepo/.git" > subdir/.git &&
+	echo "$(pwd -P)/otherrepo/.git" >expected &&
+	echo "gitdir: $TRASH_DIRECTORY/otherrepo/.git" >subdir/.git &&
 	test_when_finished "rm -f subdir/.git" &&
 	(
 		cd subdir &&
-		__gitdir > "$actual"
+		__gitdir >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'gitdir - gitfile in parent' '
-	echo "$(pwd -P)/otherrepo/.git" > expected &&
-	echo "gitdir: $TRASH_DIRECTORY/otherrepo/.git" > subdir/.git &&
+	echo "$(pwd -P)/otherrepo/.git" >expected &&
+	echo "gitdir: $TRASH_DIRECTORY/otherrepo/.git" >subdir/.git &&
 	test_when_finished "rm -f subdir/.git" &&
 	(
 		cd subdir/subsubdir &&
-		__gitdir > "$actual"
+		__gitdir >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success SYMLINKS 'gitdir - resulting path avoids symlinks'=
 '
-	echo "$(pwd -P)/otherrepo/.git" > expected &&
+	echo "$(pwd -P)/otherrepo/.git" >expected &&
 	mkdir otherrepo/dir &&
 	test_when_finished "rm -rf otherrepo/dir" &&
 	ln -s otherrepo/dir link &&
 	test_when_finished "rm -f link" &&
 	(
 		cd link &&
-		__gitdir > "$actual"
+		__gitdir >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
@@ -163,96 +163,96 @@ test_expect_success 'gitdir - not a git repositor=
y' '
 '
=20
 test_expect_success 'prompt - branch name' '
-	printf " (master)" > expected &&
-	__git_ps1 > "$actual" &&
+	printf " (master)" >expected &&
+	__git_ps1 >"$actual" &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'prompt - detached head' '
-	printf " ((%s...))" $(git log -1 --format=3D"%h" b1^) > expected &&
+	printf " ((%s...))" $(git log -1 --format=3D"%h" b1^) >expected &&
 	git checkout b1^ &&
 	test_when_finished "git checkout master" &&
-	__git_ps1 > "$actual" &&
+	__git_ps1 >"$actual" &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'prompt - describe detached head - contains' '
-	printf " ((t2~1))" > expected &&
+	printf " ((t2~1))" >expected &&
 	git checkout b1^ &&
 	test_when_finished "git checkout master" &&
 	(
 		GIT_PS1_DESCRIBE_STYLE=3Dcontains &&
-		__git_ps1 > "$actual"
+		__git_ps1 >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'prompt - describe detached head - branch' '
-	printf " ((b1~1))" > expected &&
+	printf " ((b1~1))" >expected &&
 	git checkout b1^ &&
 	test_when_finished "git checkout master" &&
 	(
 		GIT_PS1_DESCRIBE_STYLE=3Dbranch &&
-		__git_ps1 > "$actual"
+		__git_ps1 >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'prompt - describe detached head - describe' '
-	printf " ((t1-1-g%s))" $(git log -1 --format=3D"%h" b1^) > expected &=
&
+	printf " ((t1-1-g%s))" $(git log -1 --format=3D"%h" b1^) >expected &&
 	git checkout b1^ &&
 	test_when_finished "git checkout master" &&
 	(
 		GIT_PS1_DESCRIBE_STYLE=3Ddescribe &&
-		__git_ps1 > "$actual"
+		__git_ps1 >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'prompt - describe detached head - default' '
-	printf " ((t2))" > expected &&
+	printf " ((t2))" >expected &&
 	git checkout --detach b1 &&
 	test_when_finished "git checkout master" &&
-	__git_ps1 > "$actual" &&
+	__git_ps1 >"$actual" &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'prompt - inside .git directory' '
-	printf " (GIT_DIR!)" > expected &&
+	printf " (GIT_DIR!)" >expected &&
 	(
 		cd .git &&
-		__git_ps1 > "$actual"
+		__git_ps1 >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'prompt - deep inside .git directory' '
-	printf " (GIT_DIR!)" > expected &&
+	printf " (GIT_DIR!)" >expected &&
 	(
 		cd .git/refs/heads &&
-		__git_ps1 > "$actual"
+		__git_ps1 >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'prompt - inside bare repository' '
-	printf " (BARE:master)" > expected &&
+	printf " (BARE:master)" >expected &&
 	git init --bare bare.git &&
 	test_when_finished "rm -rf bare.git" &&
 	(
 		cd bare.git &&
-		__git_ps1 > "$actual"
+		__git_ps1 >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'prompt - interactive rebase' '
-	printf " (b1|REBASE-i 2/3)" > expected
+	printf " (b1|REBASE-i 2/3)" >expected
 	echo "#!$SHELL_PATH" >fake_editor.sh &&
 	cat >>fake_editor.sh <<\EOF &&
-echo "exec echo" > "$1"
-echo "edit $(git log -1 --format=3D"%h")" >> "$1"
-echo "exec echo" >> "$1"
+echo "exec echo" >"$1"
+echo "edit $(git log -1 --format=3D"%h")" >>"$1"
+echo "exec echo" >>"$1"
 EOF
 	test_when_finished "rm -f fake_editor.sh" &&
 	chmod a+x fake_editor.sh &&
@@ -261,277 +261,277 @@ EOF
 	test_when_finished "git checkout master" &&
 	git rebase -i HEAD^ &&
 	test_when_finished "git rebase --abort"
-	__git_ps1 > "$actual" &&
+	__git_ps1 >"$actual" &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'prompt - rebase merge' '
-	printf " (b2|REBASE-m 1/3)" > expected &&
+	printf " (b2|REBASE-m 1/3)" >expected &&
 	git checkout b2 &&
 	test_when_finished "git checkout master" &&
 	test_must_fail git rebase --merge b1 b2 &&
 	test_when_finished "git rebase --abort" &&
-	__git_ps1 > "$actual" &&
+	__git_ps1 >"$actual" &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'prompt - rebase' '
-	printf " (b2|REBASE 1/3)" > expected &&
+	printf " (b2|REBASE 1/3)" >expected &&
 	git checkout b2 &&
 	test_when_finished "git checkout master" &&
 	test_must_fail git rebase b1 b2 &&
 	test_when_finished "git rebase --abort" &&
-	__git_ps1 > "$actual" &&
+	__git_ps1 >"$actual" &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'prompt - merge' '
-	printf " (b1|MERGING)" > expected &&
+	printf " (b1|MERGING)" >expected &&
 	git checkout b1 &&
 	test_when_finished "git checkout master" &&
 	test_must_fail git merge b2 &&
 	test_when_finished "git reset --hard" &&
-	__git_ps1 > "$actual" &&
+	__git_ps1 >"$actual" &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'prompt - cherry-pick' '
-	printf " (master|CHERRY-PICKING)" > expected &&
+	printf " (master|CHERRY-PICKING)" >expected &&
 	test_must_fail git cherry-pick b1 &&
 	test_when_finished "git reset --hard" &&
-	__git_ps1 > "$actual" &&
+	__git_ps1 >"$actual" &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'prompt - bisect' '
-	printf " (master|BISECTING)" > expected &&
+	printf " (master|BISECTING)" >expected &&
 	git bisect start &&
 	test_when_finished "git bisect reset" &&
-	__git_ps1 > "$actual" &&
+	__git_ps1 >"$actual" &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'prompt - dirty status indicator - clean' '
-	printf " (master)" > expected &&
+	printf " (master)" >expected &&
 	(
 		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
-		__git_ps1 > "$actual"
+		__git_ps1 >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'prompt - dirty status indicator - dirty worktree'=
 '
-	printf " (master *)" > expected &&
-	echo "dirty" > file &&
+	printf " (master *)" >expected &&
+	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
 	(
 		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
-		__git_ps1 > "$actual"
+		__git_ps1 >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'prompt - dirty status indicator - dirty index' '
-	printf " (master +)" > expected &&
-	echo "dirty" > file &&
+	printf " (master +)" >expected &&
+	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
 	git add -u &&
 	(
 		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
-		__git_ps1 > "$actual"
+		__git_ps1 >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'prompt - dirty status indicator - dirty index and=
 worktree' '
-	printf " (master *+)" > expected &&
-	echo "dirty index" > file &&
+	printf " (master *+)" >expected &&
+	echo "dirty index" >file &&
 	test_when_finished "git reset --hard" &&
 	git add -u &&
-	echo "dirty worktree" > file &&
+	echo "dirty worktree" >file &&
 	(
 		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
-		__git_ps1 > "$actual"
+		__git_ps1 >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'prompt - dirty status indicator - before root com=
mit' '
-	printf " (master #)" > expected &&
+	printf " (master #)" >expected &&
 	(
 		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
 		cd otherrepo &&
-		__git_ps1 > "$actual"
+		__git_ps1 >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'prompt - dirty status indicator - shell variable =
unset with config disabled' '
-	printf " (master)" > expected &&
-	echo "dirty" > file &&
+	printf " (master)" >expected &&
+	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
 	test_config bash.showDirtyState false &&
 	(
 		sane_unset GIT_PS1_SHOWDIRTYSTATE &&
-		__git_ps1 > "$actual"
+		__git_ps1 >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'prompt - dirty status indicator - shell variable =
unset with config enabled' '
-	printf " (master)" > expected &&
-	echo "dirty" > file &&
+	printf " (master)" >expected &&
+	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
 	test_config bash.showDirtyState true &&
 	(
 		sane_unset GIT_PS1_SHOWDIRTYSTATE &&
-		__git_ps1 > "$actual"
+		__git_ps1 >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'prompt - dirty status indicator - shell variable =
set with config disabled' '
-	printf " (master)" > expected &&
-	echo "dirty" > file &&
+	printf " (master)" >expected &&
+	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
 	test_config bash.showDirtyState false &&
 	(
 		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
-		__git_ps1 > "$actual"
+		__git_ps1 >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'prompt - dirty status indicator - shell variable =
set with config enabled' '
-	printf " (master *)" > expected &&
-	echo "dirty" > file &&
+	printf " (master *)" >expected &&
+	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
 	test_config bash.showDirtyState true &&
 	(
 		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
-		__git_ps1 > "$actual"
+		__git_ps1 >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'prompt - dirty status indicator - not shown insid=
e .git directory' '
-	printf " (GIT_DIR!)" > expected &&
-	echo "dirty" > file &&
+	printf " (GIT_DIR!)" >expected &&
+	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
 	(
 		GIT_PS1_SHOWDIRTYSTATE=3Dy &&
 		cd .git &&
-		__git_ps1 > "$actual"
+		__git_ps1 >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'prompt - stash status indicator - no stash' '
-	printf " (master)" > expected &&
+	printf " (master)" >expected &&
 	(
 		GIT_PS1_SHOWSTASHSTATE=3Dy &&
-		__git_ps1 > "$actual"
+		__git_ps1 >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'prompt - stash status indicator - stash' '
-	printf " (master $)" > expected &&
+	printf " (master $)" >expected &&
 	echo 2 >file &&
 	git stash &&
 	test_when_finished "git stash drop" &&
 	(
 		GIT_PS1_SHOWSTASHSTATE=3Dy &&
-		__git_ps1 > "$actual"
+		__git_ps1 >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'prompt - stash status indicator - not shown insid=
e .git directory' '
-	printf " (GIT_DIR!)" > expected &&
+	printf " (GIT_DIR!)" >expected &&
 	echo 2 >file &&
 	git stash &&
 	test_when_finished "git stash drop" &&
 	(
 		GIT_PS1_SHOWSTASHSTATE=3Dy &&
 		cd .git &&
-		__git_ps1 > "$actual"
+		__git_ps1 >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'prompt - untracked files status indicator - no un=
tracked files' '
-	printf " (master)" > expected &&
+	printf " (master)" >expected &&
 	(
 		GIT_PS1_SHOWUNTRACKEDFILES=3Dy &&
 		cd otherrepo &&
-		__git_ps1 > "$actual"
+		__git_ps1 >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'prompt - untracked files status indicator - untra=
cked files' '
-	printf " (master %%)" > expected &&
+	printf " (master %%)" >expected &&
 	(
 		GIT_PS1_SHOWUNTRACKEDFILES=3Dy &&
-		__git_ps1 > "$actual"
+		__git_ps1 >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'prompt - untracked files status indicator - shell=
 variable unset with config disabled' '
-	printf " (master)" > expected &&
+	printf " (master)" >expected &&
 	test_config bash.showUntrackedFiles false &&
 	(
 		sane_unset GIT_PS1_SHOWUNTRACKEDFILES &&
-		__git_ps1 > "$actual"
+		__git_ps1 >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'prompt - untracked files status indicator - shell=
 variable unset with config enabled' '
-	printf " (master)" > expected &&
+	printf " (master)" >expected &&
 	test_config bash.showUntrackedFiles true &&
 	(
 		sane_unset GIT_PS1_SHOWUNTRACKEDFILES &&
-		__git_ps1 > "$actual"
+		__git_ps1 >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'prompt - untracked files status indicator - shell=
 variable set with config disabled' '
-	printf " (master)" > expected &&
+	printf " (master)" >expected &&
 	test_config bash.showUntrackedFiles false &&
 	(
 		GIT_PS1_SHOWUNTRACKEDFILES=3Dy &&
-		__git_ps1 > "$actual"
+		__git_ps1 >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'prompt - untracked files status indicator - shell=
 variable set with config enabled' '
-	printf " (master %%)" > expected &&
+	printf " (master %%)" >expected &&
 	test_config bash.showUntrackedFiles true &&
 	(
 		GIT_PS1_SHOWUNTRACKEDFILES=3Dy &&
-		__git_ps1 > "$actual"
+		__git_ps1 >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'prompt - untracked files status indicator - not s=
hown inside .git directory' '
-	printf " (GIT_DIR!)" > expected &&
+	printf " (GIT_DIR!)" >expected &&
 	(
 		GIT_PS1_SHOWUNTRACKEDFILES=3Dy &&
 		cd .git &&
-		__git_ps1 > "$actual"
+		__git_ps1 >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
=20
 test_expect_success 'prompt - format string starting with dash' '
-	printf -- "-master" > expected &&
-	__git_ps1 "-%s" > "$actual" &&
+	printf -- "-master" >expected &&
+	__git_ps1 "-%s" >"$actual" &&
 	test_cmp expected "$actual"
 '
=20
--=20
1.8.3.1.599.g4459181

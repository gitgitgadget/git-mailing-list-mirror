From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] t3200 (branch): modernize style
Date: Wed, 20 Mar 2013 18:00:12 +0530
Message-ID: <1363782612-19260-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 20 13:29:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UII98-0001pt-NZ
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 13:29:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758041Ab3CTM3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 08:29:06 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:40869 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756611Ab3CTM3E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 08:29:04 -0400
Received: by mail-pb0-f45.google.com with SMTP id ro8so1320457pbb.18
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 05:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:subject:date:message-id:x-mailer;
        bh=1ru5qZ+XOCKZDbQkggabXpbhBnfEuRlYNKy1seJwDUY=;
        b=GkVP0PYgAbXJ9ppZab71JhVPCuGZKPAlw2y5dO3NOZ4vJRez5qsMKYoPzVNddfIZKR
         Z2oWoNNiJyIpM2rYCPJing5E+viXZLW+CFfvcuaPMzl5qDMY2vSFFZ0jZCXlfPcq8PD9
         WbDc/jPqkd38IYTPZ3xkrt9jtYox3XjpW9OXbfl9RHeKVX+3SIRiuSIwBIOGkYUtTntu
         DHorOV8z+G+mp1UwjNy7M/AsVmeBlBB8NBRMUjVFrkrMplgHig4rYEd3l69+9QoB79VP
         2cnWzXmj5dhFoLXqp6yl7zm7AjBdu8FCD2x3LOtypk1EUmobpN2Y74RDi1V7mGMhZY7n
         6ihA==
X-Received: by 10.68.232.162 with SMTP id tp2mr8554488pbc.192.1363782543833;
        Wed, 20 Mar 2013 05:29:03 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id vd4sm1966400pbc.35.2013.03.20.05.29.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 20 Mar 2013 05:29:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218595>

Style is inconsistent throughout the file.  Make the following
changes:

1. Indent everything with tabs.

2. Put the opening quote (') for the test in the same line as
   test_expect_succcess, and the closing quote on a line by itself.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Another random patch. Found it while grep'ping around.  I thought I
 could automate my work, which would have been the case if it was
 consistently inconsistent.  Unfortunately, it wasn't, and I ended up
 doing a lot of manual janitorial work :|

 t/t3200-branch.sh | 475 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 243 insertions(+), 232 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index f3e0e4a..3203b15 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -7,20 +7,18 @@ test_description='git branch assorted tests'
 
 . ./test-lib.sh
 
-test_expect_success \
-    'prepare a trivial repository' \
-    'echo Hello > A &&
-     git update-index --add A &&
-     git commit -m "Initial commit." &&
-     echo World >> A &&
-     git update-index --add A &&
-     git commit -m "Second commit." &&
-     HEAD=$(git rev-parse --verify HEAD)'
-
-test_expect_success \
-    'git branch --help should not have created a bogus branch' '
-     test_might_fail git branch --help </dev/null >/dev/null 2>/dev/null &&
-     test_path_is_missing .git/refs/heads/--help
+test_expect_success 'prepare a trivial repository' '
+	echo Hello > A &&
+	git update-index --add A &&
+	git commit -m "Initial commit." &&
+	echo World >> A &&
+	git update-index --add A &&
+	git commit -m "Second commit." &&
+	HEAD=$(git rev-parse --verify HEAD)'
+
+test_expect_success 'git branch --help should not have created a bogus branch' '
+	test_might_fail git branch --help </dev/null >/dev/null 2>/dev/null &&
+	test_path_is_missing .git/refs/heads/--help
 '
 
 test_expect_success 'branch -h in broken repository' '
@@ -34,63 +32,63 @@ test_expect_success 'branch -h in broken repository' '
 	test_i18ngrep "[Uu]sage" broken/usage
 '
 
-test_expect_success \
-    'git branch abc should create a branch' \
-    'git branch abc && test_path_is_file .git/refs/heads/abc'
+test_expect_success 'git branch abc should create a branch' '
+	git branch abc && test_path_is_file .git/refs/heads/abc
+'
 
-test_expect_success \
-    'git branch a/b/c should create a branch' \
-    'git branch a/b/c && test_path_is_file .git/refs/heads/a/b/c'
+test_expect_success 'git branch a/b/c should create a branch' '
+	git branch a/b/c && test_path_is_file .git/refs/heads/a/b/c
+'
 
 cat >expect <<EOF
 $_z40 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
 EOF
-test_expect_success \
-    'git branch -l d/e/f should create a branch and a log' \
-	'GIT_COMMITTER_DATE="2005-05-26 23:30" \
-     git branch -l d/e/f &&
-	 test_path_is_file .git/refs/heads/d/e/f &&
-	 test_path_is_file .git/logs/refs/heads/d/e/f &&
-	 test_cmp expect .git/logs/refs/heads/d/e/f'
-
-test_expect_success \
-    'git branch -d d/e/f should delete a branch and a log' \
-	'git branch -d d/e/f &&
-	 test_path_is_missing .git/refs/heads/d/e/f &&
-	 test_path_is_missing .git/logs/refs/heads/d/e/f'
-
-test_expect_success \
-    'git branch j/k should work after branch j has been deleted' \
-       'git branch j &&
-        git branch -d j &&
-        git branch j/k'
-
-test_expect_success \
-    'git branch l should work after branch l/m has been deleted' \
-       'git branch l/m &&
-        git branch -d l/m &&
-        git branch l'
-
-test_expect_success \
-    'git branch -m dumps usage' \
-       'test_expect_code 128 git branch -m 2>err &&
-	test_i18ngrep "too many branches for a rename operation" err'
-
-test_expect_success \
-    'git branch -m m m/m should work' \
-       'git branch -l m &&
-        git branch -m m m/m &&
-	test_path_is_file .git/logs/refs/heads/m/m'
-
-test_expect_success \
-    'git branch -m n/n n should work' \
-       'git branch -l n/n &&
+test_expect_success 'git branch -l d/e/f should create a branch and a log' '
+	GIT_COMMITTER_DATE="2005-05-26 23:30" \
+	git branch -l d/e/f &&
+	test_path_is_file .git/refs/heads/d/e/f &&
+	test_path_is_file .git/logs/refs/heads/d/e/f &&
+	test_cmp expect .git/logs/refs/heads/d/e/f
+'
+
+test_expect_success 'git branch -d d/e/f should delete a branch and a log' '
+	git branch -d d/e/f &&
+	test_path_is_missing .git/refs/heads/d/e/f &&
+	test_path_is_missing .git/logs/refs/heads/d/e/f
+'
+
+test_expect_success 'git branch j/k should work after branch j has been deleted' '
+	git branch j &&
+	git branch -d j &&
+	git branch j/k
+'
+
+test_expect_success 'git branch l should work after branch l/m has been deleted' '
+	git branch l/m &&
+	git branch -d l/m &&
+	git branch l
+'
+
+test_expect_success 'git branch -m dumps usage' '
+	test_expect_code 128 git branch -m 2>err &&
+	test_i18ngrep "too many branches for a rename operation" err
+'
+
+test_expect_success 'git branch -m m m/m should work' '
+	git branch -l m &&
+	git branch -m m m/m &&
+	test_path_is_file .git/logs/refs/heads/m/m
+'
+
+test_expect_success 'git branch -m n/n n should work' '
+	git branch -l n/n &&
 	git branch -m n/n n &&
-	test_path_is_file .git/logs/refs/heads/n'
+	test_path_is_file .git/logs/refs/heads/n
+'
 
 test_expect_success 'git branch -m o/o o should fail when o/p exists' '
 	git branch o/o &&
-        git branch o/p &&
+	git branch o/p &&
 	test_must_fail git branch -m o/o o
 '
 
@@ -248,19 +246,20 @@ mv .git/config-saved .git/config
 
 git config branch.s/s.dummy Hello
 
-test_expect_success \
-    'git branch -m s/s s should work when s/t is deleted' \
-       'git branch -l s/s &&
+test_expect_success 'git branch -m s/s s should work when s/t is deleted' '
+	git branch -l s/s &&
 	test_path_is_file .git/logs/refs/heads/s/s &&
-        git branch -l s/t &&
+	git branch -l s/t &&
 	test_path_is_file .git/logs/refs/heads/s/t &&
-        git branch -d s/t &&
-        git branch -m s/s s &&
-	test_path_is_file .git/logs/refs/heads/s'
+	git branch -d s/t &&
+	git branch -m s/s s &&
+	test_path_is_file .git/logs/refs/heads/s
+'
 
-test_expect_success 'config information was renamed, too' \
-	"test $(git config branch.s.dummy) = Hello &&
-	 test_must_fail git config branch.s/s/dummy"
+test_expect_success 'config information was renamed, too' '
+	test $(git config branch.s.dummy) = Hello &&
+	test_must_fail git config branch.s/s/dummy
+'
 
 test_expect_success 'deleting a symref' '
 	git branch target &&
@@ -281,8 +280,7 @@ test_expect_success 'deleting a dangling symref' '
 	test_i18ncmp expect actual
 '
 
-test_expect_success 'renaming a symref is not allowed' \
-'
+test_expect_success 'renaming a symref is not allowed' '
 	git symbolic-ref refs/heads/master2 refs/heads/master &&
 	test_must_fail git branch -m master2 master3 &&
 	git symbolic-ref refs/heads/master2 &&
@@ -290,146 +288,159 @@ test_expect_success 'renaming a symref is not allowed' \
 	test_path_is_missing .git/refs/heads/master3
 '
 
-test_expect_success SYMLINKS \
-    'git branch -m u v should fail when the reflog for u is a symlink' '
-     git branch -l u &&
-     mv .git/logs/refs/heads/u real-u &&
-     ln -s real-u .git/logs/refs/heads/u &&
-     test_must_fail git branch -m u v
-'
-
-test_expect_success 'test tracking setup via --track' \
-    'git config remote.local.url . &&
-     git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-     (git show-ref -q refs/remotes/local/master || git fetch local) &&
-     git branch --track my1 local/master &&
-     test $(git config branch.my1.remote) = local &&
-     test $(git config branch.my1.merge) = refs/heads/master'
-
-test_expect_success 'test tracking setup (non-wildcard, matching)' \
-    'git config remote.local.url . &&
-     git config remote.local.fetch refs/heads/master:refs/remotes/local/master &&
-     (git show-ref -q refs/remotes/local/master || git fetch local) &&
-     git branch --track my4 local/master &&
-     test $(git config branch.my4.remote) = local &&
-     test $(git config branch.my4.merge) = refs/heads/master'
-
-test_expect_success 'test tracking setup (non-wildcard, not matching)' \
-    'git config remote.local.url . &&
-     git config remote.local.fetch refs/heads/s:refs/remotes/local/s &&
-     (git show-ref -q refs/remotes/local/master || git fetch local) &&
-     git branch --track my5 local/master &&
-     ! test "$(git config branch.my5.remote)" = local &&
-     ! test "$(git config branch.my5.merge)" = refs/heads/master'
-
-test_expect_success 'test tracking setup via config' \
-    'git config branch.autosetupmerge true &&
-     git config remote.local.url . &&
-     git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-     (git show-ref -q refs/remotes/local/master || git fetch local) &&
-     git branch my3 local/master &&
-     test $(git config branch.my3.remote) = local &&
-     test $(git config branch.my3.merge) = refs/heads/master'
-
-test_expect_success 'test overriding tracking setup via --no-track' \
-    'git config branch.autosetupmerge true &&
-     git config remote.local.url . &&
-     git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-     (git show-ref -q refs/remotes/local/master || git fetch local) &&
-     git branch --no-track my2 local/master &&
-     git config branch.autosetupmerge false &&
-     ! test "$(git config branch.my2.remote)" = local &&
-     ! test "$(git config branch.my2.merge)" = refs/heads/master'
-
-test_expect_success 'no tracking without .fetch entries' \
-    'git config branch.autosetupmerge true &&
-     git branch my6 s &&
-     git config branch.automsetupmerge false &&
-     test -z "$(git config branch.my6.remote)" &&
-     test -z "$(git config branch.my6.merge)"'
-
-test_expect_success 'test tracking setup via --track but deeper' \
-    'git config remote.local.url . &&
-     git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-     (git show-ref -q refs/remotes/local/o/o || git fetch local) &&
-     git branch --track my7 local/o/o &&
-     test "$(git config branch.my7.remote)" = local &&
-     test "$(git config branch.my7.merge)" = refs/heads/o/o'
-
-test_expect_success 'test deleting branch deletes branch config' \
-    'git branch -d my7 &&
-     test -z "$(git config branch.my7.remote)" &&
-     test -z "$(git config branch.my7.merge)"'
-
-test_expect_success 'test deleting branch without config' \
-    'git branch my7 s &&
-     sha1=$(git rev-parse my7 | cut -c 1-7) &&
-     echo "Deleted branch my7 (was $sha1)." >expect &&
-     git branch -d my7 >actual 2>&1 &&
-     test_i18ncmp expect actual'
-
-test_expect_success 'test --track without .fetch entries' \
-    'git branch --track my8 &&
-     test "$(git config branch.my8.remote)" &&
-     test "$(git config branch.my8.merge)"'
-
-test_expect_success \
-    'branch from non-branch HEAD w/autosetupmerge=always' \
-    'git config branch.autosetupmerge always &&
-     git branch my9 HEAD^ &&
-     git config branch.autosetupmerge false'
-
-test_expect_success \
-    'branch from non-branch HEAD w/--track causes failure' \
-    'test_must_fail git branch --track my10 HEAD^'
-
-test_expect_success \
-    'branch from tag w/--track causes failure' \
-    'git tag foobar &&
-     test_must_fail git branch --track my11 foobar'
-
-test_expect_success 'use --set-upstream-to modify HEAD' \
-    'test_config branch.master.remote foo &&
-     test_config branch.master.merge foo &&
-     git branch my12
-     git branch --set-upstream-to my12 &&
-     test "$(git config branch.master.remote)" = "." &&
-     test "$(git config branch.master.merge)" = "refs/heads/my12"'
-
-test_expect_success 'use --set-upstream-to modify a particular branch' \
-    'git branch my13
-     git branch --set-upstream-to master my13 &&
-     test "$(git config branch.my13.remote)" = "." &&
-     test "$(git config branch.my13.merge)" = "refs/heads/master"'
-
-test_expect_success '--unset-upstream should fail if given a non-existent branch' \
-    'test_must_fail git branch --unset-upstream i-dont-exist'
-
-test_expect_success 'test --unset-upstream on HEAD' \
-    'git branch my14
-     test_config branch.master.remote foo &&
-     test_config branch.master.merge foo &&
-     git branch --set-upstream-to my14 &&
-     git branch --unset-upstream &&
-     test_must_fail git config branch.master.remote &&
-     test_must_fail git config branch.master.merge &&
-     # fail for a branch without upstream set
-     test_must_fail git branch --unset-upstream
-'
-
-test_expect_success 'test --unset-upstream on a particular branch' \
-    'git branch my15
-     git branch --set-upstream-to master my14 &&
-     git branch --unset-upstream my14 &&
-     test_must_fail git config branch.my14.remote &&
-     test_must_fail git config branch.my14.merge'
-
-test_expect_success '--set-upstream shows message when creating a new branch that exists as remote-tracking' \
-    'git update-ref refs/remotes/origin/master HEAD &&
-     git branch --set-upstream origin/master 2>actual &&
-     test_when_finished git update-ref -d refs/remotes/origin/master &&
-     test_when_finished git branch -d origin/master &&
-     cat >expected <<EOF &&
+test_expect_success SYMLINKS 'git branch -m u v should fail when the reflog for u is a symlink' '
+	git branch -l u &&
+	mv .git/logs/refs/heads/u real-u &&
+	ln -s real-u .git/logs/refs/heads/u &&
+	test_must_fail git branch -m u v
+'
+
+test_expect_success 'test tracking setup via --track' '
+	git config remote.local.url . &&
+	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	(git show-ref -q refs/remotes/local/master || git fetch local) &&
+	git branch --track my1 local/master &&
+	test $(git config branch.my1.remote) = local &&
+	test $(git config branch.my1.merge) = refs/heads/master
+'
+
+test_expect_success 'test tracking setup (non-wildcard, matching)' '
+	git config remote.local.url . &&
+	git config remote.local.fetch refs/heads/master:refs/remotes/local/master &&
+	(git show-ref -q refs/remotes/local/master || git fetch local) &&
+	git branch --track my4 local/master &&
+	test $(git config branch.my4.remote) = local &&
+	test $(git config branch.my4.merge) = refs/heads/master
+'
+
+test_expect_success 'test tracking setup (non-wildcard, not matching)' '
+	git config remote.local.url . &&
+	git config remote.local.fetch refs/heads/s:refs/remotes/local/s &&
+	(git show-ref -q refs/remotes/local/master || git fetch local) &&
+	git branch --track my5 local/master &&
+	! test "$(git config branch.my5.remote)" = local &&
+	! test "$(git config branch.my5.merge)" = refs/heads/master
+'
+
+test_expect_success 'test tracking setup via config' '
+	git config branch.autosetupmerge true &&
+	git config remote.local.url . &&
+	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	(git show-ref -q refs/remotes/local/master || git fetch local) &&
+	git branch my3 local/master &&
+	test $(git config branch.my3.remote) = local &&
+	test $(git config branch.my3.merge) = refs/heads/master
+'
+
+test_expect_success 'test overriding tracking setup via --no-track' '
+	git config branch.autosetupmerge true &&
+	git config remote.local.url . &&
+	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	(git show-ref -q refs/remotes/local/master || git fetch local) &&
+	git branch --no-track my2 local/master &&
+	git config branch.autosetupmerge false &&
+	! test "$(git config branch.my2.remote)" = local &&
+	! test "$(git config branch.my2.merge)" = refs/heads/master
+'
+
+test_expect_success 'no tracking without .fetch entries' '
+	git config branch.autosetupmerge true &&
+	git branch my6 s &&
+	git config branch.automsetupmerge false &&
+	test -z "$(git config branch.my6.remote)" &&
+	test -z "$(git config branch.my6.merge)"
+'
+
+test_expect_success 'test tracking setup via --track but deeper' '
+	git config remote.local.url . &&
+	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	(git show-ref -q refs/remotes/local/o/o || git fetch local) &&
+	git branch --track my7 local/o/o &&
+	test "$(git config branch.my7.remote)" = local &&
+	test "$(git config branch.my7.merge)" = refs/heads/o/o
+'
+
+test_expect_success 'test deleting branch deletes branch config' '
+	git branch -d my7 &&
+	test -z "$(git config branch.my7.remote)" &&
+	test -z "$(git config branch.my7.merge)"
+'
+
+test_expect_success 'test deleting branch without config' '
+	git branch my7 s &&
+	sha1=$(git rev-parse my7 | cut -c 1-7) &&
+	echo "Deleted branch my7 (was $sha1)." >expect &&
+	git branch -d my7 >actual 2>&1 &&
+	test_i18ncmp expect actual
+'
+
+test_expect_success 'test --track without .fetch entries' '
+	git branch --track my8 &&
+	test "$(git config branch.my8.remote)" &&
+	test "$(git config branch.my8.merge)"
+'
+
+test_expect_success 'branch from non-branch HEAD w/autosetupmerge=always' '
+	git config branch.autosetupmerge always &&
+	git branch my9 HEAD^ &&
+	git config branch.autosetupmerge false
+'
+
+test_expect_success 'branch from non-branch HEAD w/--track causes failure' '
+	test_must_fail git branch --track my10 HEAD^
+'
+
+test_expect_success 'branch from tag w/--track causes failure' '
+	git tag foobar &&
+	test_must_fail git branch --track my11 foobar
+'
+
+test_expect_success 'use --set-upstream-to modify HEAD' '
+	test_config branch.master.remote foo &&
+	test_config branch.master.merge foo &&
+	git branch my12
+	git branch --set-upstream-to my12 &&
+	test "$(git config branch.master.remote)" = "." &&
+	test "$(git config branch.master.merge)" = "refs/heads/my12"
+'
+
+test_expect_success 'use --set-upstream-to modify a particular branch' '
+	git branch my13
+	git branch --set-upstream-to master my13 &&
+	test "$(git config branch.my13.remote)" = "." &&
+	test "$(git config branch.my13.merge)" = "refs/heads/master"
+'
+
+test_expect_success '--unset-upstream should fail if given a non-existent branch' '
+	test_must_fail git branch --unset-upstream i-dont-exist
+'
+
+test_expect_success 'test --unset-upstream on HEAD' '
+	git branch my14
+	test_config branch.master.remote foo &&
+	test_config branch.master.merge foo &&
+	git branch --set-upstream-to my14 &&
+	git branch --unset-upstream &&
+	test_must_fail git config branch.master.remote &&
+	test_must_fail git config branch.master.merge &&
+	# fail for a branch without upstream set
+	test_must_fail git branch --unset-upstream
+'
+
+test_expect_success 'test --unset-upstream on a particular branch' '
+	git branch my15
+	git branch --set-upstream-to master my14 &&
+	git branch --unset-upstream my14 &&
+	test_must_fail git config branch.my14.remote &&
+	test_must_fail git config branch.my14.merge
+'
+
+test_expect_success '--set-upstream shows message when creating a new branch that exists as remote-tracking' '
+	git update-ref refs/remotes/origin/master HEAD &&
+	git branch --set-upstream origin/master 2>actual &&
+	test_when_finished git update-ref -d refs/remotes/origin/master &&
+	test_when_finished git branch -d origin/master &&
+	cat >expected <<EOF &&
 The --set-upstream flag is deprecated and will be removed. Consider using --track or --set-upstream-to
 
 If you wanted to make '"'master'"' track '"'origin/master'"', do this:
@@ -437,38 +448,38 @@ If you wanted to make '"'master'"' track '"'origin/master'"', do this:
     git branch -d origin/master
     git branch --set-upstream-to origin/master
 EOF
-     test_cmp expected actual
+	test_cmp expected actual
 '
 
-test_expect_success '--set-upstream with two args only shows the deprecation message' \
-    'git branch --set-upstream master my13 2>actual &&
-     test_when_finished git branch --unset-upstream master &&
-     cat >expected <<EOF &&
+test_expect_success '--set-upstream with two args only shows the deprecation message' '
+	git branch --set-upstream master my13 2>actual &&
+	test_when_finished git branch --unset-upstream master &&
+	cat >expected <<EOF &&
 The --set-upstream flag is deprecated and will be removed. Consider using --track or --set-upstream-to
 EOF
-     test_cmp expected actual
+	test_cmp expected actual
 '
 
-test_expect_success '--set-upstream with one arg only shows the deprecation message if the branch existed' \
-    'git branch --set-upstream my13 2>actual &&
-     test_when_finished git branch --unset-upstream my13 &&
-     cat >expected <<EOF &&
+test_expect_success '--set-upstream with one arg only shows the deprecation message if the branch existed' '
+	git branch --set-upstream my13 2>actual &&
+	test_when_finished git branch --unset-upstream my13 &&
+	cat >expected <<EOF &&
 The --set-upstream flag is deprecated and will be removed. Consider using --track or --set-upstream-to
 EOF
-     test_cmp expected actual
+	test_cmp expected actual
 '
 
 # Keep this test last, as it changes the current branch
 cat >expect <<EOF
 $_z40 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
 EOF
-test_expect_success \
-    'git checkout -b g/h/i -l should create a branch and a log' \
-	'GIT_COMMITTER_DATE="2005-05-26 23:30" \
-     git checkout -b g/h/i -l master &&
-	 test_path_is_file .git/refs/heads/g/h/i &&
-	 test_path_is_file .git/logs/refs/heads/g/h/i &&
-	 test_cmp expect .git/logs/refs/heads/g/h/i'
+test_expect_success 'git checkout -b g/h/i -l should create a branch and a log' '
+	GIT_COMMITTER_DATE="2005-05-26 23:30" \
+	git checkout -b g/h/i -l master &&
+	test_path_is_file .git/refs/heads/g/h/i &&
+	test_path_is_file .git/logs/refs/heads/g/h/i &&
+	test_cmp expect .git/logs/refs/heads/g/h/i
+'
 
 test_expect_success 'checkout -b makes reflog by default' '
 	git checkout master &&
-- 
1.8.2

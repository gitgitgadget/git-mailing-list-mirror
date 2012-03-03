From: Tom Grennan <tmgrennan@gmail.com>
Subject: [PATCHv2 3/5] t3200 (branch): modernize style
Date: Fri,  2 Mar 2012 18:15:35 -0800
Message-ID: <1330740942-25130-4-git-send-email-tmgrennan@gmail.com>
References: <1330740942-25130-1-git-send-email-tmgrennan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Carlos Rica <jasampler@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 03:17:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3eX1-00026b-6A
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 03:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160Ab2CCCQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 21:16:34 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37868 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803Ab2CCCQD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 21:16:03 -0500
Received: by mail-vw0-f46.google.com with SMTP id ff1so2055487vbb.19
        for <git@vger.kernel.org>; Fri, 02 Mar 2012 18:16:02 -0800 (PST)
Received-SPF: pass (google.com: domain of tmgrennan@gmail.com designates 10.52.28.200 as permitted sender) client-ip=10.52.28.200;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tmgrennan@gmail.com designates 10.52.28.200 as permitted sender) smtp.mail=tmgrennan@gmail.com; dkim=pass header.i=tmgrennan@gmail.com
Received: from mr.google.com ([10.52.28.200])
        by 10.52.28.200 with SMTP id d8mr20792615vdh.38.1330740962822 (num_hops = 1);
        Fri, 02 Mar 2012 18:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=siTEumhjQfezP/oiCvJV6CUoOtsWt1JdzhrYQAIXRkA=;
        b=l9EHGXGy+wyuvYAK2MSaiwxZNhQfj3ujBhJsb4k7sVr438Kp24jolocymf46HAmuEt
         SHLELvwrczL2i8pIYaFiGPW8maKNMyMb6752cw/onNCKWSXzghZyJI3C32RQHF1uYP2P
         wO/ofgwedI9Il0T+HJStpOlRqi2ZV80j2fM6U5y/vXRGPNsf+yhaIgRlC47ILlxQW4FT
         6z2H4p8vRacQ6YK5nkPAaf1VYArwf1Qp2jtaEXWidBGdicP//Tbte44GcTxBXYZXQhUG
         hkvjRBPfaGH05IJNyT6ua6yMDgD2Yb37+r78BNgbvHPuMg9U7zPqjPjQoAANWcRIPJy1
         t2zw==
Received: by 10.52.28.200 with SMTP id d8mr17729016vdh.38.1330740962692;
        Fri, 02 Mar 2012 18:16:02 -0800 (PST)
Received: from tgrennan-laptop.lab.redback.com ([129.192.185.163])
        by mx.google.com with ESMTPS id e10sm11763981vdj.21.2012.03.02.18.16.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Mar 2012 18:16:01 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1330740942-25130-1-git-send-email-tmgrennan@gmail.com>
In-Reply-To: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
References: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192085>

- Guard setup with test_expect_success
- Single-quoted, tab prefaced test blocks

Signed-off-by: Tom Grennan <tmgrennan@gmail.com>
---
 t/t3200-branch.sh |  365 +++++++++++++++++++++++++++--------------------------
 1 files changed, 186 insertions(+), 179 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index dd1aceb..7191b89 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -7,20 +7,20 @@ test_description='git branch assorted tests'
 
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
+test_expect_success 'prepare a trivial repository' '
+	echo Hello >A &&
+	git update-index --add A &&
+	git commit -m "Initial commit." &&
+	echo World >>A &&
+	git update-index --add A &&
+	git commit -m "Second commit." &&
+	HEAD=$(git rev-parse --verify HEAD)
+'
 
 test_expect_success \
-    'git branch --help should not have created a bogus branch' '
-     test_might_fail git branch --help </dev/null >/dev/null 2>/dev/null &&
-     test_path_is_missing .git/refs/heads/--help
+	'git branch --help should not have created a bogus branch' '
+	test_might_fail git branch --help </dev/null >/dev/null 2>/dev/null &&
+	test_path_is_missing .git/refs/heads/--help
 '
 
 test_expect_success 'branch -h in broken repository' '
@@ -34,63 +34,63 @@ test_expect_success 'branch -h in broken repository' '
 	grep "[Uu]sage" broken/usage
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
 
-cat >expect <<EOF
-$_z40 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
-EOF
-test_expect_success \
-    'git branch -l d/e/f should create a branch and a log' \
-	'GIT_COMMITTER_DATE="2005-05-26 23:30" \
-     git branch -l d/e/f &&
-	 test_path_is_file .git/refs/heads/d/e/f &&
-	 test_path_is_file .git/logs/refs/heads/d/e/f &&
-	 test_cmp expect .git/logs/refs/heads/d/e/f'
+test_expect_success 'git branch -l d/e/f should create a branch and a log' '
+	cat >expect <<-EOF
+		$_z40 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
+	EOF
+	GIT_COMMITTER_DATE="2005-05-26 23:30" \
+		git branch -l d/e/f &&
+	test_path_is_file .git/refs/heads/d/e/f &&
+	test_path_is_file .git/logs/refs/heads/d/e/f &&
+	test_cmp expect .git/logs/refs/heads/d/e/f
+'
 
-test_expect_success \
-    'git branch -d d/e/f should delete a branch and a log' \
-	'git branch -d d/e/f &&
-	 test_path_is_missing .git/refs/heads/d/e/f &&
-	 test_path_is_missing .git/logs/refs/heads/d/e/f'
+test_expect_success 'git branch -d d/e/f should delete a branch and a log' '
+	git branch -d d/e/f &&
+	test_path_is_missing .git/refs/heads/d/e/f &&
+	test_path_is_missing .git/logs/refs/heads/d/e/f
+'
 
-test_expect_success \
-    'git branch j/k should work after branch j has been deleted' \
-       'git branch j &&
-        git branch -d j &&
-        git branch j/k'
+test_expect_success 'git branch j/k should work after branch j has been deleted' '
+	git branch j &&
+	git branch -d j &&
+	git branch j/k
+'
 
-test_expect_success \
-    'git branch l should work after branch l/m has been deleted' \
-       'git branch l/m &&
-        git branch -d l/m &&
-        git branch l'
+test_expect_success 'git branch l should work after branch l/m has been deleted' '
+	git branch l/m &&
+	git branch -d l/m &&
+	git branch l
+'
 
-test_expect_success \
-    'git branch -m dumps usage' \
-       'test_expect_code 129 git branch -m 2>err &&
-	grep "[Uu]sage: git branch" err'
+test_expect_success 'git branch -m dumps usage' '
+	test_expect_code 129 git branch -m 2>err &&
+	grep "[Uu]sage: git branch" err
+'
 
-test_expect_success \
-    'git branch -m m m/m should work' \
-       'git branch -l m &&
-        git branch -m m m/m &&
-	test_path_is_file .git/logs/refs/heads/m/m'
+test_expect_success 'git branch -m m m/m should work' '
+	git branch -l m &&
+	git branch -m m m/m &&
+	test_path_is_file .git/logs/refs/heads/m/m
+'
 
-test_expect_success \
-    'git branch -m n/n n should work' \
-       'git branch -l n/n &&
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
 
@@ -160,33 +160,30 @@ test_expect_success 'git branch --list -d t should fail' '
 	test_path_is_missing .git/refs/heads/t
 '
 
-mv .git/config .git/config-saved
-
 test_expect_success 'git branch -m q q2 without config should succeed' '
+	mv .git/config .git/config-saved &&
+	test_when_finished mv .git/config-saved .git/config &&
 	git branch -m q q2 &&
 	git branch -m q2 q
 '
 
-mv .git/config-saved .git/config
-
-git config branch.s/s.dummy Hello
-
-test_expect_success \
-    'git branch -m s/s s should work when s/t is deleted' \
-       'git branch -l s/s &&
+test_expect_success 'git branch -m s/s s should work when s/t is deleted' '
+	git config branch.s/s.dummy Hello
+	git branch -l s/s &&
 	test_path_is_file .git/logs/refs/heads/s/s &&
-        git branch -l s/t &&
+	git branch -l s/t &&
 	test_path_is_file .git/logs/refs/heads/s/t &&
-        git branch -d s/t &&
-        git branch -m s/s s &&
-	test_path_is_file .git/logs/refs/heads/s'
-
-test_expect_success 'config information was renamed, too' \
-	"test $(git config branch.s.dummy) = Hello &&
-	 test_must_fail git config branch.s/s/dummy"
+	git branch -d s/t &&
+	git branch -m s/s s &&
+	test_path_is_file .git/logs/refs/heads/s
+'
 
-test_expect_success 'renaming a symref is not allowed' \
+test_expect_success 'config information was renamed, too' '
+	test $(git config branch.s.dummy) = Hello &&
+	test_must_fail git config branch.s/s/dummy
 '
+
+test_expect_success 'renaming a symref is not allowed' '
 	git symbolic-ref refs/heads/master2 refs/heads/master &&
 	test_must_fail git branch -m master2 master3 &&
 	git symbolic-ref refs/heads/master2 &&
@@ -194,115 +191,125 @@ test_expect_success 'renaming a symref is not allowed' \
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
+test_expect_success SYMLINKS 'git branch -m u v should fail when the reflog for u is a symlink' '
+	git branch -l u &&
+	mv .git/logs/refs/heads/u real-u &&
+	ln -s real-u .git/logs/refs/heads/u &&
+	test_must_fail git branch -m u v
+'
 
-test_expect_success \
-    'branch from non-branch HEAD w/autosetupmerge=always' \
-    'git config branch.autosetupmerge always &&
-     git branch my9 HEAD^ &&
-     git config branch.autosetupmerge false'
+test_expect_success 'test tracking setup via --track' '
+	git config remote.local.url . &&
+	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	(git show-ref -q refs/remotes/local/master || git fetch local) &&
+	git branch --track my1 local/master &&
+	test $(git config branch.my1.remote) = local &&
+	test $(git config branch.my1.merge) = refs/heads/master
+'
 
-test_expect_success \
-    'branch from non-branch HEAD w/--track causes failure' \
-    'test_must_fail git branch --track my10 HEAD^'
+test_expect_success 'test tracking setup (non-wildcard, matching)' '
+	git config remote.local.url . &&
+	git config remote.local.fetch \
+		refs/heads/master:refs/remotes/local/master &&
+	(git show-ref -q refs/remotes/local/master || git fetch local) &&
+	git branch --track my4 local/master &&
+	test $(git config branch.my4.remote) = local &&
+	test $(git config branch.my4.merge) = refs/heads/master
+'
 
-test_expect_success \
-    'branch from tag w/--track causes failure' \
-    'git tag foobar &&
-     test_must_fail git branch --track my11 foobar'
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
 
 # Keep this test last, as it changes the current branch
-cat >expect <<EOF
-$_z40 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
-EOF
-test_expect_success \
-    'git checkout -b g/h/i -l should create a branch and a log' \
-	'GIT_COMMITTER_DATE="2005-05-26 23:30" \
-     git checkout -b g/h/i -l master &&
-	 test_path_is_file .git/refs/heads/g/h/i &&
-	 test_path_is_file .git/logs/refs/heads/g/h/i &&
-	 test_cmp expect .git/logs/refs/heads/g/h/i'
+test_expect_success 'git checkout -b g/h/i -l should create a branch and a log' '
+	cat >expect <<-EOF
+		$_z40 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
+	EOF
+	GIT_COMMITTER_DATE="2005-05-26 23:30" \
+		git checkout -b g/h/i -l master &&
+	test_path_is_file .git/refs/heads/g/h/i &&
+	test_path_is_file .git/logs/refs/heads/g/h/i &&
+	test_cmp expect .git/logs/refs/heads/g/h/i
+'
 
 test_expect_success 'checkout -b makes reflog by default' '
 	git checkout master &&
-- 
1.7.8

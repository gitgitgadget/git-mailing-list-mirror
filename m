From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 2/2] t/: Use "test_must_fail git" instead of "! git"
Date: Sat, 12 Jul 2008 17:47:52 +0200
Message-ID: <1215877672-17049-2-git-send-email-s-beyer@gmx.net>
References: <1215877672-17049-1-git-send-email-s-beyer@gmx.net>
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 17:49:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHhLm-0006Vl-0x
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 17:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755364AbYGLPsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 11:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753590AbYGLPsE
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 11:48:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:35665 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755228AbYGLPr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 11:47:57 -0400
Received: (qmail invoked by alias); 12 Jul 2008 15:47:54 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp006) with SMTP; 12 Jul 2008 17:47:54 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19JrWkfkZdJPeVv5rzuVvnnG06qzRQc+rPnDDh5TX
	+pJExsJqj+2pL4
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KHhKC-0004RO-Lb; Sat, 12 Jul 2008 17:47:52 +0200
X-Mailer: git-send-email 1.5.6.2.303.g79662
In-Reply-To: <1215877672-17049-1-git-send-email-s-beyer@gmx.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88251>

This patch changes every occurrence of "! git" -- with the meaning
that a git call has to fail -- into "test_must_fail git".

This is useful to
 - make sure the test does not fail because of a signal,
   e.g. SIGSEGV, and
 - advertise the use of "test_must_fail" for new tests.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---

Because test_must_fail has been introduced by Junio, this patch
is only "To:"'ed to him and not to all the authors of the test
cases. I hope this is ok. ;)

 t/t0000-basic.sh                          |    6 +-
 t/t0020-crlf.sh                           |    8 ++--
 t/t0050-filesystem.sh                     |    2 +-
 t/t1200-tutorial.sh                       |    2 +-
 t/t1300-repo-config.sh                    |   19 ++++----
 t/t1302-repo-version.sh                   |    2 +-
 t/t1400-update-ref.sh                     |    4 +-
 t/t2000-checkout-cache-clash.sh           |    2 +-
 t/t2100-update-cache-badpath.sh           |    2 +-
 t/t3020-ls-files-error-unmatch.sh         |    2 +-
 t/t3200-branch.sh                         |    8 ++--
 t/t3210-pack-refs.sh                      |    4 +-
 t/t3403-rebase-skip.sh                    |    8 ++-
 t/t3502-cherry-pick-merge.sh              |   12 +++---
 t/t3600-rm.sh                             |   26 ++++++------
 t/t3700-add.sh                            |    4 +-
 t/t4015-diff-whitespace.sh                |   28 ++++++------
 t/t4018-diff-funcname.sh                  |    2 +-
 t/t4103-apply-binary.sh                   |   16 +++---
 t/t4113-apply-ending.sh                   |    4 +-
 t/t4150-am.sh                             |    8 ++--
 t/t4200-rerere.sh                         |   10 ++--
 t/t5300-pack-object.sh                    |    2 +-
 t/t5302-pack-index.sh                     |   11 +++--
 t/t5401-update-hooks.sh                   |    3 +-
 t/t5404-tracking-branches.sh              |    4 +-
 t/t5406-remote-rejects.sh                 |    2 +-
 t/t5500-fetch-pack.sh                     |    2 +-
 t/t5505-remote.sh                         |   14 +++---
 t/t5510-fetch.sh                          |   12 +++---
 t/t5516-fetch-push.sh                     |    8 ++--
 t/t5530-upload-pack-error.sh              |    6 +-
 t/t5540-http-push.sh                      |    2 +-
 t/t5600-clone-fail-cleanup.sh             |    4 +-
 t/t6023-merge-file.sh                     |   14 +++---
 t/t6024-recursive-merge.sh                |    6 ++-
 t/t6025-merge-symlinks.sh                 |    6 +-
 t/t6101-rev-parse-parents.sh              |    2 +-
 t/t7001-mv.sh                             |    4 +-
 t/t7004-tag.sh                            |   67 +++++++++++++++--------------
 t/t7102-reset.sh                          |   48 ++++++++++----------
 t/t7103-reset-bare.sh                     |    2 +-
 t/t7300-clean.sh                          |    4 +-
 t/t7400-submodule-basic.sh                |    2 +-
 t/t7402-submodule-rebase.sh               |    2 +-
 t/t7500-commit.sh                         |    8 ++--
 t/t7501-commit.sh                         |   18 ++++----
 t/t7503-pre-commit-hook.sh                |    2 +-
 t/t7504-commit-msg-hook.sh                |    2 +-
 t/t7600-merge.sh                          |    2 +-
 t/t7610-mergetool.sh                      |    2 +-
 t/t9100-git-svn-basic.sh                  |   12 +++---
 t/t9106-git-svn-commit-diff-clobber.sh    |    6 +-
 t/t9106-git-svn-dcommit-clobber-series.sh |    2 +-
 t/t9200-git-cvsexportcommit.sh            |    6 +-
 t/t9300-fast-import.sh                    |    8 ++--
 t/t9301-fast-export.sh                    |    4 +-
 57 files changed, 246 insertions(+), 232 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index d7cbc5c..70df15c 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -63,7 +63,7 @@ test_expect_failure 'pretend we have fixed a known breakage' '
 
 # updating a new file without --add should fail.
 test_expect_success 'git update-index without --add should fail adding.' '
-    ! git update-index should-be-empty
+    test_must_fail git update-index should-be-empty
 '
 
 # and with --add it should succeed, even if it is empty (it used to fail).
@@ -83,7 +83,7 @@ test_expect_success \
 # Removing paths.
 rm -f should-be-empty full-of-directories
 test_expect_success 'git update-index without --remove should fail removing.' '
-    ! git update-index should-be-empty
+    test_must_fail git update-index should-be-empty
 '
 
 test_expect_success \
@@ -217,7 +217,7 @@ test_expect_success \
     'git update-index --index-info < badobjects'
 
 test_expect_success 'writing this tree without --missing-ok.' '
-    ! git write-tree
+    test_must_fail git write-tree
 '
 
 test_expect_success \
diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index 2bfeac9..1be7446 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -52,7 +52,7 @@ test_expect_success 'safecrlf: autocrlf=input, all CRLF' '
 	git config core.safecrlf true &&
 
 	for w in I am all CRLF; do echo $w; done | append_cr >allcrlf &&
-	! git add allcrlf
+	test_must_fail git add allcrlf
 '
 
 test_expect_success 'safecrlf: autocrlf=input, mixed LF/CRLF' '
@@ -61,7 +61,7 @@ test_expect_success 'safecrlf: autocrlf=input, mixed LF/CRLF' '
 	git config core.safecrlf true &&
 
 	for w in Oh here is CRLFQ in text; do echo $w; done | q_to_cr >mixed &&
-	! git add mixed
+	test_must_fail git add mixed
 '
 
 test_expect_success 'safecrlf: autocrlf=true, all LF' '
@@ -70,7 +70,7 @@ test_expect_success 'safecrlf: autocrlf=true, all LF' '
 	git config core.safecrlf true &&
 
 	for w in I am all LF; do echo $w; done >alllf &&
-	! git add alllf
+	test_must_fail git add alllf
 '
 
 test_expect_success 'safecrlf: autocrlf=true mixed LF/CRLF' '
@@ -79,7 +79,7 @@ test_expect_success 'safecrlf: autocrlf=true mixed LF/CRLF' '
 	git config core.safecrlf true &&
 
 	for w in Oh here is CRLFQ in text; do echo $w; done | q_to_cr >mixed &&
-	! git add mixed
+	test_must_fail git add mixed
 '
 
 test_expect_success 'safecrlf: print warning only once' '
diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index c5360e2..b177174 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -43,7 +43,7 @@ test_expect_success "detection of case insensitive filesystem during repo init"
 else
 test_expect_success "detection of case insensitive filesystem during repo init" '
 
-	! git config --bool core.ignorecase >/dev/null ||
+	test_must_fail git config --bool core.ignorecase >/dev/null ||
 	test $(git config --bool core.ignorecase) = false
 '
 fi
diff --git a/t/t1200-tutorial.sh b/t/t1200-tutorial.sh
index dcb3108..09a8199 100755
--- a/t/t1200-tutorial.sh
+++ b/t/t1200-tutorial.sh
@@ -102,7 +102,7 @@ echo "Lots of fun" >>example
 git commit -m 'Some fun.' -i hello example
 
 test_expect_success 'git resolve now fails' '
-	! git merge -m "Merge work in mybranch" mybranch
+	test_must_fail git merge -m "Merge work in mybranch" mybranch
 '
 
 cat > hello << EOF
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index afe7e66..64567fb 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -201,7 +201,7 @@ test_expect_success 'non-match value' \
 	'test wow = $(git config --get nextsection.nonewline !for)'
 
 test_expect_success 'ambiguous get' '
-	! git config --get nextsection.nonewline
+	test_must_fail git config --get nextsection.nonewline
 '
 
 test_expect_success 'get multivar' \
@@ -223,15 +223,15 @@ EOF
 test_expect_success 'multivar replace' 'cmp .git/config expect'
 
 test_expect_success 'ambiguous value' '
-	! git config nextsection.nonewline
+	test_must_fail git config nextsection.nonewline
 '
 
 test_expect_success 'ambiguous unset' '
-	! git config --unset nextsection.nonewline
+	test_must_fail git config --unset nextsection.nonewline
 '
 
 test_expect_success 'invalid unset' '
-	! git config --unset somesection.nonewline
+	test_must_fail git config --unset somesection.nonewline
 '
 
 git config --unset nextsection.nonewline "wow3$"
@@ -248,7 +248,7 @@ EOF
 
 test_expect_success 'multivar unset' 'cmp .git/config expect'
 
-test_expect_success 'invalid key' '! git config inval.2key blabla'
+test_expect_success 'invalid key' 'test_must_fail git config inval.2key blabla'
 
 test_expect_success 'correct key' 'git config 123456.a123 987'
 
@@ -430,7 +430,8 @@ EOF
 test_expect_success "rename succeeded" "test_cmp expect .git/config"
 
 test_expect_success "rename non-existing section" '
-	! git config --rename-section branch."world domination" branch.drei
+	test_must_fail git config --rename-section \
+		branch."world domination" branch.drei
 '
 
 test_expect_success "rename succeeded" "test_cmp expect .git/config"
@@ -545,11 +546,11 @@ test_expect_success bool '
 test_expect_success 'invalid bool (--get)' '
 
 	git config bool.nobool foobar &&
-	! git config --bool --get bool.nobool'
+	test_must_fail git config --bool --get bool.nobool'
 
 test_expect_success 'invalid bool (set)' '
 
-	! git config --bool bool.nobool foobar'
+	test_must_fail git config --bool bool.nobool foobar'
 
 rm .git/config
 
@@ -669,7 +670,7 @@ EOF
 test_expect_success 'quoting' 'cmp .git/config expect'
 
 test_expect_success 'key with newline' '
-	! git config "key.with
+	test_must_fail git config "key.with
 newline" 123'
 
 test_expect_success 'value with newline' 'git config key.sub value.with\\\
diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
index 9be0770..8d305b4 100755
--- a/t/t1302-repo-version.sh
+++ b/t/t1302-repo-version.sh
@@ -41,7 +41,7 @@ test_expect_success 'gitdir required mode on normal repos' '
 	cd test && git apply --check --index ../test.patch)'
 
 test_expect_success 'gitdir required mode on unsupported repo' '
-	(cd test2 && ! git apply --check --index ../test.patch)
+	(cd test2 && test_must_fail git apply --check --index ../test.patch)
 '
 
 test_done
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index ca99d37..b31e4b1 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -76,7 +76,7 @@ test_expect_success "delete $m (by HEAD)" '
 rm -f .git/$m
 
 test_expect_success '(not) create HEAD with old sha1' "
-	! git update-ref HEAD $A $B
+	test_must_fail git update-ref HEAD $A $B
 "
 test_expect_success "(not) prior created .git/$m" "
 	! test -f .git/$m
@@ -87,7 +87,7 @@ test_expect_success \
 	"create HEAD" \
 	"git update-ref HEAD $A"
 test_expect_success '(not) change HEAD with wrong SHA1' "
-	! git update-ref HEAD $B $Z
+	test_must_fail git update-ref HEAD $B $Z
 "
 test_expect_success "(not) changed .git/$m" "
 	! test $B"' = $(cat .git/'"$m"')
diff --git a/t/t2000-checkout-cache-clash.sh b/t/t2000-checkout-cache-clash.sh
index 5141fab..f7e1a73 100755
--- a/t/t2000-checkout-cache-clash.sh
+++ b/t/t2000-checkout-cache-clash.sh
@@ -38,7 +38,7 @@ date >path1
 
 test_expect_success \
     'git checkout-index without -f should fail on conflicting work tree.' \
-    '! git checkout-index -a'
+    'test_must_fail git checkout-index -a'
 
 test_expect_success \
     'git checkout-index with -f should succeed.' \
diff --git a/t/t2100-update-cache-badpath.sh b/t/t2100-update-cache-badpath.sh
index 9beaecd..6ef2dcf 100755
--- a/t/t2100-update-cache-badpath.sh
+++ b/t/t2100-update-cache-badpath.sh
@@ -46,6 +46,6 @@ for p in path0/file0 path1/file1 path2 path3
 do
 	test_expect_success \
 	    "git update-index to add conflicting path $p should fail." \
-	    "! git update-index --add -- $p"
+	    "test_must_fail git update-index --add -- $p"
 done
 test_done
diff --git a/t/t3020-ls-files-error-unmatch.sh b/t/t3020-ls-files-error-unmatch.sh
index f4da869..af8c412 100755
--- a/t/t3020-ls-files-error-unmatch.sh
+++ b/t/t3020-ls-files-error-unmatch.sh
@@ -17,7 +17,7 @@ git-commit -m "add foo bar"
 
 test_expect_success \
     'git ls-files --error-unmatch should fail with unmatched path.' \
-    '! git ls-files --error-unmatch foo bar-does-not-match'
+    'test_must_fail git ls-files --error-unmatch foo bar-does-not-match'
 
 test_expect_success \
     'git ls-files --error-unmatch should succeed eith matched paths.' \
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 8d87686..7c583c8 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -78,13 +78,13 @@ test_expect_success \
 test_expect_success 'git branch -m o/o o should fail when o/p exists' '
 	git branch o/o &&
         git branch o/p &&
-	! git branch -m o/o o
+	test_must_fail git branch -m o/o o
 '
 
 test_expect_success 'git branch -m q r/q should fail when r exists' '
 	git branch q &&
 	git branch r &&
-	! git branch -m q r/q
+	test_must_fail git branch -m q r/q
 '
 
 mv .git/config .git/config-saved
@@ -110,14 +110,14 @@ test_expect_success \
 
 test_expect_success 'config information was renamed, too' \
 	"test $(git config branch.s.dummy) = Hello &&
-	 ! git config branch.s/s/dummy"
+	 test_must_fail git config branch.s/s/dummy"
 
 test_expect_success \
     'git branch -m u v should fail when the reflog for u is a symlink' '
      git branch -l u &&
      mv .git/logs/refs/heads/u real-u &&
      ln -s real-u .git/logs/refs/heads/u &&
-     ! git branch -m u v
+     test_must_fail git branch -m u v
 '
 
 test_expect_success 'test tracking setup via --track' \
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index b64ccfb..c2dec1c 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -43,7 +43,7 @@ test_expect_success 'git branch c/d should barf if branch c exists' '
      git branch c &&
      git pack-refs --all &&
      rm -f .git/refs/heads/c &&
-     ! git branch c/d
+     test_must_fail git branch c/d
 '
 
 test_expect_success \
@@ -72,7 +72,7 @@ test_expect_success \
 test_expect_success 'git branch i/j/k should barf if branch i exists' '
      git branch i &&
      git pack-refs --all --prune &&
-     ! git branch i/j/k
+     test_must_fail git branch i/j/k
 '
 
 test_expect_success \
diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
index 0a26099..0d33c71 100755
--- a/t/t3403-rebase-skip.sh
+++ b/t/t3403-rebase-skip.sh
@@ -32,7 +32,7 @@ test_expect_success setup '
 	'
 
 test_expect_success 'rebase with git am -3 (default)' '
-	! git rebase master
+	test_must_fail git rebase master
 '
 
 test_expect_success 'rebase --skip with am -3' '
@@ -43,7 +43,7 @@ test_expect_success 'rebase moves back to skip-reference' '
 	test refs/heads/skip-reference = $(git symbolic-ref HEAD) &&
 	git branch post-rebase &&
 	git reset --hard pre-rebase &&
-	! git rebase master &&
+	test_must_fail git rebase master &&
 	echo "hello" > hello &&
 	git add hello &&
 	git rebase --continue &&
@@ -53,7 +53,9 @@ test_expect_success 'rebase moves back to skip-reference' '
 
 test_expect_success 'checkout skip-merge' 'git checkout -f skip-merge'
 
-test_expect_success 'rebase with --merge' '! git rebase --merge master'
+test_expect_success 'rebase with --merge' '
+	test_must_fail git rebase --merge master
+'
 
 test_expect_success 'rebase --skip with --merge' '
 	git rebase --skip
diff --git a/t/t3502-cherry-pick-merge.sh b/t/t3502-cherry-pick-merge.sh
index 7c92e26..0ab52da 100755
--- a/t/t3502-cherry-pick-merge.sh
+++ b/t/t3502-cherry-pick-merge.sh
@@ -35,7 +35,7 @@ test_expect_success 'cherry-pick a non-merge with -m should fail' '
 
 	git reset --hard &&
 	git checkout a^0 &&
-	! git cherry-pick -m 1 b &&
+	test_must_fail git cherry-pick -m 1 b &&
 	git diff --exit-code a --
 
 '
@@ -44,7 +44,7 @@ test_expect_success 'cherry pick a merge without -m should fail' '
 
 	git reset --hard &&
 	git checkout a^0 &&
-	! git cherry-pick c &&
+	test_must_fail git cherry-pick c &&
 	git diff --exit-code a --
 
 '
@@ -71,7 +71,7 @@ test_expect_success 'cherry pick a merge relative to nonexistent parent should f
 
 	git reset --hard &&
 	git checkout b^0 &&
-	! git cherry-pick -m 3 c
+	test_must_fail git cherry-pick -m 3 c
 
 '
 
@@ -79,7 +79,7 @@ test_expect_success 'revert a non-merge with -m should fail' '
 
 	git reset --hard &&
 	git checkout c^0 &&
-	! git revert -m 1 b &&
+	test_must_fail git revert -m 1 b &&
 	git diff --exit-code c
 
 '
@@ -88,7 +88,7 @@ test_expect_success 'revert a merge without -m should fail' '
 
 	git reset --hard &&
 	git checkout c^0 &&
-	! git revert c &&
+	test_must_fail git revert c &&
 	git diff --exit-code c
 
 '
@@ -115,7 +115,7 @@ test_expect_success 'revert a merge relative to nonexistent parent should fail'
 
 	git reset --hard &&
 	git checkout c^0 &&
-	! git revert -m 3 c &&
+	test_must_fail git revert -m 3 c &&
 	git diff --exit-code c
 
 '
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index f542f0a..316775e 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -67,7 +67,7 @@ test_expect_success \
      echo "other content" > foo
      git add foo
      echo "yet another content" > foo
-     ! git rm --cached foo
+     test_must_fail git rm --cached foo
 '
 
 test_expect_success \
@@ -82,7 +82,7 @@ test_expect_success \
 
 test_expect_success \
     'Post-check that foo exists but is not in index after git rm foo' \
-    '[ -f foo ] && ! git ls-files --error-unmatch foo'
+    '[ -f foo ] && test_must_fail git ls-files --error-unmatch foo'
 
 test_expect_success \
     'Pre-check that bar exists and is in index before "git rm bar"' \
@@ -94,7 +94,7 @@ test_expect_success \
 
 test_expect_success \
     'Post-check that bar does not exist and is not in index after "git rm -f bar"' \
-    '! [ -f bar ] && ! git ls-files --error-unmatch bar'
+    '! [ -f bar ] && test_must_fail git ls-files --error-unmatch bar'
 
 test_expect_success \
     'Test that "git rm -- -q" succeeds (remove a file that looks like an option)' \
@@ -109,7 +109,7 @@ if test "$test_failed_remove" = y; then
 chmod a-w .
 test_expect_success \
     'Test that "git rm -f" fails if its rm fails' \
-    '! git rm -f baz'
+    'test_must_fail git rm -f baz'
 chmod 775 .
 else
     test_expect_success 'skipping removal failure (perhaps running as root?)' :
@@ -151,7 +151,7 @@ test_expect_success 'Re-add foo and baz' '
 
 test_expect_success 'Modify foo -- rm should refuse' '
 	echo >>foo &&
-	! git rm foo baz &&
+	test_must_fail git rm foo baz &&
 	test -f foo &&
 	test -f baz &&
 	git ls-files --error-unmatch foo baz
@@ -161,8 +161,8 @@ test_expect_success 'Modified foo -- rm -f should work' '
 	git rm -f foo baz &&
 	test ! -f foo &&
 	test ! -f baz &&
-	! git ls-files --error-unmatch foo &&
-	! git ls-files --error-unmatch bar
+	test_must_fail git ls-files --error-unmatch foo &&
+	test_must_fail git ls-files --error-unmatch bar
 '
 
 test_expect_success 'Re-add foo and baz for HEAD tests' '
@@ -173,7 +173,7 @@ test_expect_success 'Re-add foo and baz for HEAD tests' '
 '
 
 test_expect_success 'foo is different in index from HEAD -- rm should refuse' '
-	! git rm foo baz &&
+	test_must_fail git rm foo baz &&
 	test -f foo &&
 	test -f baz &&
 	git ls-files --error-unmatch foo baz
@@ -183,8 +183,8 @@ test_expect_success 'but with -f it should work.' '
 	git rm -f foo baz &&
 	test ! -f foo &&
 	test ! -f baz &&
-	! git ls-files --error-unmatch foo
-	! git ls-files --error-unmatch baz
+	test_must_fail git ls-files --error-unmatch foo
+	test_must_fail git ls-files --error-unmatch baz
 '
 
 test_expect_success 'Recursive test setup' '
@@ -195,14 +195,14 @@ test_expect_success 'Recursive test setup' '
 '
 
 test_expect_success 'Recursive without -r fails' '
-	! git rm frotz &&
+	test_must_fail git rm frotz &&
 	test -d frotz &&
 	test -f frotz/nitfol
 '
 
 test_expect_success 'Recursive with -r but dirty' '
 	echo qfwfq >>frotz/nitfol
-	! git rm -r frotz &&
+	test_must_fail git rm -r frotz &&
 	test -d frotz &&
 	test -f frotz/nitfol
 '
@@ -214,7 +214,7 @@ test_expect_success 'Recursive with -r -f' '
 '
 
 test_expect_success 'Remove nonexistent file returns nonzero exit status' '
-	! git rm nonexistent
+	test_must_fail git rm nonexistent
 '
 
 test_done
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index e83fa1f..7d123d1 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -85,12 +85,12 @@ test_expect_success '.gitignore is honored' '
 '
 
 test_expect_success 'error out when attempting to add ignored ones without -f' '
-	! git add a.?? &&
+	test_must_fail git add a.?? &&
 	! (git ls-files | grep "\\.ig")
 '
 
 test_expect_success 'error out when attempting to add ignored ones without -f' '
-	! git add d.?? &&
+	test_must_fail git add d.?? &&
 	! (git ls-files | grep "\\.ig")
 '
 
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 0922c70..a27fccc 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -144,7 +144,7 @@ test_expect_success 'check with no whitespace errors' '
 test_expect_success 'check with trailing whitespace' '
 
 	echo "foo(); " > x &&
-	! git diff --check
+	test_must_fail git diff --check
 
 '
 
@@ -152,7 +152,7 @@ test_expect_success 'check with space before tab in indent' '
 
 	# indent has space followed by hard tab
 	echo " 	foo();" > x &&
-	! git diff --check
+	test_must_fail git diff --check
 
 '
 
@@ -181,7 +181,7 @@ test_expect_success 'check staged with trailing whitespace' '
 
 	echo "foo(); " > x &&
 	git add x &&
-	! git diff --cached --check
+	test_must_fail git diff --cached --check
 
 '
 
@@ -190,7 +190,7 @@ test_expect_success 'check staged with space before tab in indent' '
 	# indent has space followed by hard tab
 	echo " 	foo();" > x &&
 	git add x &&
-	! git diff --cached --check
+	test_must_fail git diff --cached --check
 
 '
 
@@ -206,7 +206,7 @@ test_expect_success 'check with trailing whitespace (diff-index)' '
 
 	echo "foo(); " > x &&
 	git add x &&
-	! git diff-index --check HEAD
+	test_must_fail git diff-index --check HEAD
 
 '
 
@@ -215,7 +215,7 @@ test_expect_success 'check with space before tab in indent (diff-index)' '
 	# indent has space followed by hard tab
 	echo " 	foo();" > x &&
 	git add x &&
-	! git diff-index --check HEAD
+	test_must_fail git diff-index --check HEAD
 
 '
 
@@ -231,7 +231,7 @@ test_expect_success 'check staged with trailing whitespace (diff-index)' '
 
 	echo "foo(); " > x &&
 	git add x &&
-	! git diff-index --cached --check HEAD
+	test_must_fail git diff-index --cached --check HEAD
 
 '
 
@@ -240,7 +240,7 @@ test_expect_success 'check staged with space before tab in indent (diff-index)'
 	# indent has space followed by hard tab
 	echo " 	foo();" > x &&
 	git add x &&
-	! git diff-index --cached --check HEAD
+	test_must_fail git diff-index --cached --check HEAD
 
 '
 
@@ -256,7 +256,7 @@ test_expect_success 'check with trailing whitespace (diff-tree)' '
 
 	echo "foo(); " > x &&
 	git commit -m "another commit" x &&
-	! git diff-tree --check HEAD^ HEAD
+	test_must_fail git diff-tree --check HEAD^ HEAD
 
 '
 
@@ -265,7 +265,7 @@ test_expect_success 'check with space before tab in indent (diff-tree)' '
 	# indent has space followed by hard tab
 	echo " 	foo();" > x &&
 	git commit -m "yet another" x &&
-	! git diff-tree --check HEAD^ HEAD
+	test_must_fail git diff-tree --check HEAD^ HEAD
 
 '
 
@@ -281,7 +281,7 @@ test_expect_success 'check trailing whitespace (trailing-space: on)' '
 
 	git config core.whitespace "trailing-space" &&
 	echo "foo ();   " > x &&
-	! git diff --check
+	test_must_fail git diff --check
 
 '
 
@@ -299,7 +299,7 @@ test_expect_success 'check space before tab in indent (space-before-tab: on)' '
 	# indent contains space followed by HT
 	git config core.whitespace "space-before-tab" &&
 	echo " 	foo ();   " > x &&
-	! git diff --check
+	test_must_fail git diff --check
 
 '
 
@@ -315,7 +315,7 @@ test_expect_success 'check spaces as indentation (indent-with-non-tab: on)' '
 
 	git config core.whitespace "indent-with-non-tab" &&
 	echo "        foo ();" > x &&
-	! git diff --check
+	test_must_fail git diff --check
 
 '
 
@@ -323,7 +323,7 @@ test_expect_success 'check tabs and spaces as indentation (indent-with-non-tab:
 
 	git config core.whitespace "indent-with-non-tab" &&
 	echo "	                foo ();" > x &&
-	! git diff --check
+	test_must_fail git diff --check
 
 '
 
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 6d3ef6c..833d6cb 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -54,7 +54,7 @@ test_expect_success 'custom pattern' '
 
 test_expect_success 'last regexp must not be negated' '
 	git config diff.java.funcname "!static" &&
-	! git diff --no-index Beer.java Beer-correct.java
+	test_must_fail git diff --no-index Beer.java Beer-correct.java
 '
 
 test_done
diff --git a/t/t4103-apply-binary.sh b/t/t4103-apply-binary.sh
index 1b58233..7da0b4b 100755
--- a/t/t4103-apply-binary.sh
+++ b/t/t4103-apply-binary.sh
@@ -48,22 +48,22 @@ test_expect_success 'stat binary diff (copy) -- should not fail.' \
 
 test_expect_success 'check binary diff -- should fail.' \
 	'git-checkout master &&
-	 ! git apply --check B.diff'
+	 test_must_fail git apply --check B.diff'
 
 test_expect_success 'check binary diff (copy) -- should fail.' \
 	'git-checkout master &&
-	 ! git apply --check C.diff'
+	 test_must_fail git apply --check C.diff'
 
 test_expect_success \
 	'check incomplete binary diff with replacement -- should fail.' '
 	git-checkout master &&
-	! git apply --check --allow-binary-replacement B.diff
+	test_must_fail git apply --check --allow-binary-replacement B.diff
 '
 
 test_expect_success \
     'check incomplete binary diff with replacement (copy) -- should fail.' '
 	 git-checkout master &&
-	 ! git apply --check --allow-binary-replacement C.diff
+	 test_must_fail git apply --check --allow-binary-replacement C.diff
 '
 
 test_expect_success 'check binary diff with replacement.' \
@@ -84,19 +84,19 @@ do_reset () {
 
 test_expect_success 'apply binary diff -- should fail.' \
 	'do_reset &&
-	 ! git apply B.diff'
+	 test_must_fail git apply B.diff'
 
 test_expect_success 'apply binary diff -- should fail.' \
 	'do_reset &&
-	 ! git apply --index B.diff'
+	 test_must_fail git apply --index B.diff'
 
 test_expect_success 'apply binary diff (copy) -- should fail.' \
 	'do_reset &&
-	 ! git apply C.diff'
+	 test_must_fail git apply C.diff'
 
 test_expect_success 'apply binary diff (copy) -- should fail.' \
 	'do_reset &&
-	 ! git apply --index C.diff'
+	 test_must_fail git apply --index C.diff'
 
 test_expect_success 'apply binary diff without replacement.' \
 	'do_reset &&
diff --git a/t/t4113-apply-ending.sh b/t/t4113-apply-ending.sh
index d741039..66fa515 100755
--- a/t/t4113-apply-ending.sh
+++ b/t/t4113-apply-ending.sh
@@ -30,7 +30,7 @@ test_expect_success setup \
 # test
 
 test_expect_success 'apply at the end' \
-    '! git apply --index test-patch'
+    'test_must_fail git apply --index test-patch'
 
 cat >test-patch <<\EOF
 diff a/file b/file
@@ -48,6 +48,6 @@ c'
 git update-index file
 
 test_expect_success 'apply at the beginning' \
-	'! git apply --index test-patch'
+	'test_must_fail git apply --index test-patch'
 
 test_done
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index bc98260..476f20b 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -182,7 +182,7 @@ test_expect_success 'am -3 falls back to 3-way merge' '
 
 test_expect_success 'am pauses on conflict' '
 	git checkout lorem2^^ &&
-	! git am lorem-move.patch &&
+	test_must_fail git am lorem-move.patch &&
 	test -d .dotest
 '
 
@@ -195,7 +195,7 @@ test_expect_success 'am --skip works' '
 
 test_expect_success 'am --resolved works' '
 	git checkout lorem2^^ &&
-	! git am lorem-move.patch &&
+	test_must_fail git am lorem-move.patch &&
 	test -d .dotest &&
 	echo resolved >>file &&
 	git add file &&
@@ -212,13 +212,13 @@ test_expect_success 'am takes patches from a Pine mailbox' '
 '
 
 test_expect_success 'am fails on mail without patch' '
-	! git am <failmail &&
+	test_must_fail git am <failmail &&
 	rm -r .dotest/
 '
 
 test_expect_success 'am fails on empty patch' '
 	echo "---" >>failmail &&
-	! git am <failmail &&
+	test_must_fail git am <failmail &&
 	git am --skip &&
 	! test -d .dotest
 '
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index a64727d..746d61f 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -41,7 +41,7 @@ git commit -q -a -m second
 
 test_expect_success 'nothing recorded without rerere' '
 	(rm -rf .git/rr-cache; git config rerere.enabled false) &&
-	! git merge first &&
+	test_must_fail git merge first &&
 	! test -d .git/rr-cache
 '
 
@@ -50,7 +50,7 @@ test_expect_success 'conflicting merge' '
 	git reset --hard &&
 	mkdir .git/rr-cache &&
 	git config --unset rerere.enabled &&
-	! git merge first
+	test_must_fail git merge first
 '
 
 sha1=$(sed -e 's/	.*//' .git/rr-cache/MERGE_RR)
@@ -61,7 +61,7 @@ test_expect_success 'rerere.enabled works, too' '
 	rm -rf .git/rr-cache &&
 	git config rerere.enabled true &&
 	git reset --hard &&
-	! git merge first &&
+	test_must_fail git merge first &&
 	grep ======= $rr/preimage
 '
 
@@ -120,7 +120,7 @@ test_expect_success 'another conflicting merge' '
 	git checkout -b third master &&
 	git show second^:a1 | sed "s/To die: t/To die! T/" > a1 &&
 	git commit -q -a -m third &&
-	! git pull . first
+	test_must_fail git pull . first
 '
 
 git show first:a1 | sed 's/To die: t/To die! T/' > expect
@@ -175,7 +175,7 @@ test_expect_success 'file2 added differently in two branches' '
 	echo Bello > file2 &&
 	git add file2 &&
 	git commit -m version2 &&
-	! git merge fourth &&
+	test_must_fail git merge fourth &&
 	sha1=$(sed -e "s/	.*//" .git/rr-cache/MERGE_RR) &&
 	rr=.git/rr-cache/$sha1 &&
 	echo Cello > file2 &&
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 983a393..645583f 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -266,7 +266,7 @@ test_expect_success \
 
 test_expect_success \
     'make sure index-pack detects the SHA1 collision' \
-    '! git-index-pack -o bad.idx test-3.pack'
+    'test_must_fail git-index-pack -o bad.idx test-3.pack'
 
 test_expect_success \
     'honor pack.packSizeLimit' \
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index ecec591..0639772 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -118,7 +118,7 @@ test_expect_success \
 
 test_expect_success \
     '[index v1] 4) confirm that the pack is actually corrupted' \
-    '! git fsck --full $commit'
+    'test_must_fail git fsck --full $commit'
 
 test_expect_success \
     '[index v1] 5) pack-objects happily reuses corrupted data' \
@@ -127,7 +127,7 @@ test_expect_success \
 
 test_expect_success \
     '[index v1] 6) newly created pack is BAD !' \
-    '! git verify-pack -v "test-4-${pack1}.pack"'
+    'test_must_fail git verify-pack -v "test-4-${pack1}.pack"'
 
 test_expect_success \
     '[index v2] 1) stream pack to repository' \
@@ -156,11 +156,11 @@ test_expect_success \
 
 test_expect_success \
     '[index v2] 4) confirm that the pack is actually corrupted' \
-    '! git fsck --full $commit'
+    'test_must_fail git fsck --full $commit'
 
 test_expect_success \
     '[index v2] 5) pack-objects refuses to reuse corrupted data' \
-    '! git pack-objects test-5 <obj-list'
+    'test_must_fail git pack-objects test-5 <obj-list'
 
 test_expect_success \
     '[index v2] 6) verify-pack detects CRC mismatch' \
@@ -173,7 +173,8 @@ test_expect_success \
      ( while read obj
        do git cat-file -p $obj >/dev/null || exit 1
        done <obj-list ) &&
-     err=$(! git verify-pack ".git/objects/pack/pack-${pack1}.pack" 2>&1) &&
+     err=$(test_must_fail git verify-pack \
+       ".git/objects/pack/pack-${pack1}.pack" 2>&1) &&
      echo "$err" | grep "CRC mismatch"'
 
 test_done
diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index 2fff300..ee769d6 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -61,7 +61,8 @@ EOF
 chmod u+x victim/.git/hooks/post-update
 
 test_expect_success push '
-    ! git-send-pack --force ./victim/.git master tofail >send.out 2>send.err
+	test_must_fail git-send-pack --force ./victim/.git \
+		master tofail >send.out 2>send.err
 '
 
 test_expect_success 'updated as expected' '
diff --git a/t/t5404-tracking-branches.sh b/t/t5404-tracking-branches.sh
index 64fe261..c240035 100755
--- a/t/t5404-tracking-branches.sh
+++ b/t/t5404-tracking-branches.sh
@@ -35,7 +35,9 @@ test_expect_success 'prepare pushable branches' '
 	git commit -a -m aa-master
 '
 
-test_expect_success 'mixed-success push returns error' '! git push'
+test_expect_success 'mixed-success push returns error' '
+	test_must_fail git push
+'
 
 test_expect_success 'check tracking branches updated correctly after push' '
 	test "$(git rev-parse origin/master)" = "$(git rev-parse master)"
diff --git a/t/t5406-remote-rejects.sh b/t/t5406-remote-rejects.sh
index 46b2cb4..59e80a5 100755
--- a/t/t5406-remote-rejects.sh
+++ b/t/t5406-remote-rejects.sh
@@ -17,7 +17,7 @@ test_expect_success 'setup' '
 	git commit -a -m 2
 '
 
-test_expect_success 'push reports error' '! git push 2>stderr'
+test_expect_success 'push reports error' 'test_must_fail git push 2>stderr'
 
 test_expect_success 'individual ref reports error' 'grep rejected stderr'
 
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 140e874..362cf7e 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -177,6 +177,6 @@ test_expect_success "clone shallow object count" \
 	"test \"count: 18\" = \"$(grep count count.shallow)\""
 
 test_expect_success "pull in shallow repo with missing merge base" \
-	"(cd shallow && ! git pull --depth 4 .. A)"
+	"(cd shallow && test_must_fail git pull --depth 4 .. A)"
 
 test_done
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 1e192a2..be9ee93 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -164,7 +164,7 @@ test_expect_success 'prune' '
 	 git fetch origin &&
 	 git remote prune origin &&
 	 git rev-parse refs/remotes/origin/side2 &&
-	 ! git rev-parse refs/remotes/origin/side)
+	 test_must_fail git rev-parse refs/remotes/origin/side)
 '
 
 cat > test/expect << EOF
@@ -179,7 +179,7 @@ test_expect_success 'prune --dry-run' '
 	(cd test &&
 	 git remote prune --dry-run origin > output &&
 	 git rev-parse refs/remotes/origin/side2 &&
-	 ! git rev-parse refs/remotes/origin/side &&
+	 test_must_fail git rev-parse refs/remotes/origin/side &&
 	(cd ../one &&
 	 git branch -m side side2) &&
 	 test_cmp expect output)
@@ -194,10 +194,10 @@ test_expect_success 'add --mirror && prune' '
 	 git branch -m side2 side) &&
 	(cd mirror &&
 	 git rev-parse --verify refs/heads/side2 &&
-	 ! git rev-parse --verify refs/heads/side &&
+	 test_must_fail git rev-parse --verify refs/heads/side &&
 	 git fetch origin &&
 	 git remote prune origin &&
-	 ! git rev-parse --verify refs/heads/side2 &&
+	 test_must_fail git rev-parse --verify refs/heads/side2 &&
 	 git rev-parse --verify refs/heads/side)
 '
 
@@ -212,10 +212,10 @@ test_expect_success 'add alt && prune' '
 	 git branch -m side side2) &&
 	(cd alttst &&
 	 git rev-parse --verify refs/remotes/origin/side &&
-	 ! git rev-parse --verify refs/remotes/origin/side2 &&
+	 test_must_fail git rev-parse --verify refs/remotes/origin/side2 &&
 	 git fetch alt &&
 	 git remote prune alt &&
-	 ! git rev-parse --verify refs/remotes/origin/side &&
+	 test_must_fail git rev-parse --verify refs/remotes/origin/side &&
 	 git rev-parse --verify refs/remotes/origin/side2)
 '
 
@@ -320,7 +320,7 @@ test_expect_success '"remote show" does not show symbolic refs' '
 
 test_expect_success 'reject adding remote with an invalid name' '
 
-	! git remote add some:url desired-name
+	test_must_fail git remote add some:url desired-name
 
 '
 
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index df7750f..13d1d82 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -104,7 +104,7 @@ test_expect_success 'fetch must not resolve short tag name' '
 	cd five &&
 	git init &&
 
-	! git fetch .. anno:five
+	test_must_fail git fetch .. anno:five
 
 '
 
@@ -117,7 +117,7 @@ test_expect_success 'fetch must not resolve short remote name' '
 	cd six &&
 	git init &&
 
-	! git fetch .. six:six
+	test_must_fail git fetch .. six:six
 
 '
 
@@ -143,7 +143,7 @@ test_expect_success 'create bundle 2' '
 test_expect_success 'unbundle 1' '
 	cd "$D/bundle" &&
 	git checkout -b some-branch &&
-	! git fetch "$D/bundle1" master:master
+	test_must_fail git fetch "$D/bundle1" master:master
 '
 
 test_expect_success 'bundle 1 has only 3 files ' '
@@ -236,7 +236,7 @@ test_expect_success 'fetch with a non-applying branch.<name>.merge' '
 
 # the strange name is: a\!'b
 test_expect_success 'quoting of a strangely named repo' '
-	! git fetch "a\\!'\''b" > result 2>&1 &&
+	test_must_fail git fetch "a\\!'\''b" > result 2>&1 &&
 	cat result &&
 	grep "fatal: '\''a\\\\!'\''b'\''" result
 '
@@ -264,7 +264,7 @@ test_expect_success 'explicit fetch should not update tracking' '
 		git fetch origin master &&
 		n=$(git rev-parse --verify refs/remotes/origin/master) &&
 		test "$o" = "$n" &&
-		! git rev-parse --verify refs/remotes/origin/side
+		test_must_fail git rev-parse --verify refs/remotes/origin/side
 	)
 '
 
@@ -278,7 +278,7 @@ test_expect_success 'explicit pull should not update tracking' '
 		git pull origin master &&
 		n=$(git rev-parse --verify refs/remotes/origin/master) &&
 		test "$o" = "$n" &&
-		! git rev-parse --verify refs/remotes/origin/side
+		test_must_fail git rev-parse --verify refs/remotes/origin/side
 	)
 '
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 6805032..f0030ad 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -178,7 +178,7 @@ test_expect_success 'failed (non-fast-forward) push with matching heads' '
 	mk_test heads/master &&
 	git push testrepo : &&
 	git commit --amend -massaged &&
-	! git push testrepo &&
+	test_must_fail git push testrepo &&
 	check_push_result $the_commit heads/master &&
 	git reset --hard $the_commit
 
@@ -374,7 +374,7 @@ test_expect_success 'push with +HEAD' '
 
 	# Without force rewinding should fail
 	git reset --hard HEAD^ &&
-	! git push testrepo HEAD &&
+	test_must_fail git push testrepo HEAD &&
 	check_push_result $the_commit heads/local &&
 
 	# With force rewinding should succeed
@@ -448,7 +448,7 @@ test_expect_success 'push does not update local refs on failure' '
 	git clone parent child &&
 	(cd child &&
 		echo two >foo && git commit -a -m two &&
-		! git push &&
+		test_must_fail git push &&
 		test $(git rev-parse master) != \
 			$(git rev-parse remotes/origin/master))
 
@@ -459,7 +459,7 @@ test_expect_success 'allow deleting an invalid remote ref' '
 	pwd &&
 	rm -f testrepo/.git/objects/??/* &&
 	git push testrepo :refs/heads/master &&
-	(cd testrepo && ! git rev-parse --verify refs/heads/master)
+	(cd testrepo && test_must_fail git rev-parse --verify refs/heads/master)
 
 '
 
diff --git a/t/t5530-upload-pack-error.sh b/t/t5530-upload-pack-error.sh
index 8b05091..1a15817 100755
--- a/t/t5530-upload-pack-error.sh
+++ b/t/t5530-upload-pack-error.sh
@@ -27,7 +27,7 @@ test_expect_success 'setup and corrupt repository' '
 '
 
 test_expect_success 'fsck fails' '
-	! git fsck
+	test_must_fail git fsck
 '
 
 test_expect_success 'upload-pack fails due to error in pack-objects' '
@@ -46,7 +46,7 @@ test_expect_success 'corrupt repo differently' '
 '
 
 test_expect_success 'fsck fails' '
-	! git fsck
+	test_must_fail git fsck
 '
 test_expect_success 'upload-pack fails due to error in rev-list' '
 
@@ -66,7 +66,7 @@ test_expect_success 'create empty repository' '
 
 test_expect_success 'fetch fails' '
 
-	! git fetch .. master
+	test_must_fail git fetch .. master
 
 '
 
diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 21dbb55..f8c17cd 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -73,7 +73,7 @@ test_expect_failure 'create and delete remote branch' '
 	git push origin :dev &&
 	git branch -d -r origin/dev &&
 	git fetch &&
-	! git show-ref --verify refs/remotes/origin/dev
+	test_must_fail git show-ref --verify refs/remotes/origin/dev
 '
 
 stop_httpd
diff --git a/t/t5600-clone-fail-cleanup.sh b/t/t5600-clone-fail-cleanup.sh
index acf34ce..3c013e2 100755
--- a/t/t5600-clone-fail-cleanup.sh
+++ b/t/t5600-clone-fail-cleanup.sh
@@ -13,7 +13,7 @@ remove the directory before attempting a clone again.'
 
 test_expect_success \
     'clone of non-existent source should fail' \
-    '! git-clone foo bar'
+    'test_must_fail git-clone foo bar'
 
 test_expect_success \
     'failed clone should not leave a directory' \
@@ -29,7 +29,7 @@ test_create_repo foo
 # current path not to the target dir
 test_expect_success \
     'clone of non-existent (relative to $PWD) source should fail' \
-    '! git-clone ../foo baz'
+    'test_must_fail git-clone ../foo baz'
 
 test_expect_success \
     'clone should work now that source exists' \
diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
index 74e9e66..f674c48 100755
--- a/t/t6023-merge-file.sh
+++ b/t/t6023-merge-file.sh
@@ -67,7 +67,7 @@ test_expect_success "merge result added missing LF" \
 
 cp test.txt backup.txt
 test_expect_success "merge with conflicts" \
-	"! git merge-file test.txt orig.txt new3.txt"
+	"test_must_fail git merge-file test.txt orig.txt new3.txt"
 
 cat > expect.txt << EOF
 <<<<<<< test.txt
@@ -90,7 +90,7 @@ test_expect_success "expected conflict markers" "test_cmp test.txt expect.txt"
 
 cp backup.txt test.txt
 test_expect_success "merge with conflicts, using -L" \
-	"! git merge-file -L 1 -L 2 test.txt orig.txt new3.txt"
+	"test_must_fail git merge-file -L 1 -L 2 test.txt orig.txt new3.txt"
 
 cat > expect.txt << EOF
 <<<<<<< 1
@@ -114,7 +114,7 @@ test_expect_success "expected conflict markers, with -L" \
 
 sed "s/ tu / TU /" < new1.txt > new5.txt
 test_expect_success "conflict in removed tail" \
-	"! git merge-file -p orig.txt new1.txt new5.txt > out"
+	"test_must_fail git merge-file -p orig.txt new1.txt new5.txt > out"
 
 cat > expect << EOF
 Dominus regit me,
@@ -135,7 +135,8 @@ EOF
 test_expect_success "expected conflict markers" "test_cmp expect out"
 
 test_expect_success 'binary files cannot be merged' '
-	! git merge-file -p orig.txt ../test4012.png new1.txt 2> merge.err &&
+	test_must_fail git merge-file -p \
+		orig.txt ../test4012.png new1.txt 2> merge.err &&
 	grep "Cannot merge binary files" merge.err
 '
 
@@ -144,7 +145,7 @@ sed -e "s/deerit.$/deerit,/" -e "s/me;$/me,/" < new5.txt > new7.txt
 
 test_expect_success 'MERGE_ZEALOUS simplifies non-conflicts' '
 
-	! git merge-file -p new6.txt new5.txt new7.txt > output &&
+	test_must_fail git merge-file -p new6.txt new5.txt new7.txt > output &&
 	test 1 = $(grep ======= < output | wc -l)
 
 '
@@ -154,7 +155,8 @@ sed -e 's/deerit./&\n\n\n\n/' -e "s/locavit,/locavit --/" < new7.txt > new9.txt
 
 test_expect_success 'ZEALOUS_ALNUM' '
 
-	! git merge-file -p new8.txt new5.txt new9.txt > merge.out &&
+	test_must_fail git merge-file -p \
+		new8.txt new5.txt new9.txt > merge.out &&
 	test 1 = $(grep ======= < merge.out | wc -l)
 
 '
diff --git a/t/t6024-recursive-merge.sh b/t/t6024-recursive-merge.sh
index 6a6a130..802d0d0 100755
--- a/t/t6024-recursive-merge.sh
+++ b/t/t6024-recursive-merge.sh
@@ -60,7 +60,9 @@ git update-index a1 &&
 GIT_AUTHOR_DATE="2006-12-12 23:00:08" git commit -m F
 '
 
-test_expect_success "combined merge conflicts" "! git merge -m final G"
+test_expect_success "combined merge conflicts" "
+	test_must_fail git merge -m final G
+"
 
 cat > expect << EOF
 <<<<<<< HEAD:a1
@@ -90,7 +92,7 @@ test_expect_success 'refuse to merge binary files' '
 	printf "\0\0" > binary-file &&
 	git add binary-file &&
 	git commit -m binary2 &&
-	! git merge F > merge.out 2> merge.err &&
+	test_must_fail git merge F > merge.out 2> merge.err &&
 	grep "Cannot merge binary files: HEAD:binary-file vs. F:binary-file" \
 		merge.err
 '
diff --git a/t/t6025-merge-symlinks.sh b/t/t6025-merge-symlinks.sh
index 6004deb..fc58456 100755
--- a/t/t6025-merge-symlinks.sh
+++ b/t/t6025-merge-symlinks.sh
@@ -33,7 +33,7 @@ git-commit -m b-file'
 test_expect_success \
 'merge master into b-symlink, which has a different symbolic link' '
 git-checkout b-symlink &&
-! git-merge master'
+test_must_fail git-merge master'
 
 test_expect_success \
 'the merge result must be a file' '
@@ -42,7 +42,7 @@ test -f symlink'
 test_expect_success \
 'merge master into b-file, which has a file instead of a symbolic link' '
 git-reset --hard && git-checkout b-file &&
-! git-merge master'
+test_must_fail git-merge master'
 
 test_expect_success \
 'the merge result must be a file' '
@@ -52,7 +52,7 @@ test_expect_success \
 'merge b-file, which has a file instead of a symbolic link, into master' '
 git-reset --hard &&
 git-checkout master &&
-! git-merge b-file'
+test_must_fail git-merge b-file'
 
 test_expect_success \
 'the merge result must be a file' '
diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
index 2328b69..efc8313 100755
--- a/t/t6101-rev-parse-parents.sh
+++ b/t/t6101-rev-parse-parents.sh
@@ -26,7 +26,7 @@ test_expect_success 'final^1^1^1 = final^^^' "test $(git rev-parse final^1^1^1)
 test_expect_success 'final^1^2' "test $(git rev-parse start2) = $(git rev-parse final^1^2)"
 test_expect_success 'final^1^2 != final^1^1' "test $(git rev-parse final^1^2) != $(git rev-parse final^1^1)"
 test_expect_success 'final^1^3 not valid' "if git rev-parse --verify final^1^3; then false; else :; fi"
-test_expect_success '--verify start2^1' '! git rev-parse --verify start2^1'
+test_expect_success '--verify start2^1' 'test_must_fail git rev-parse --verify start2^1'
 test_expect_success '--verify start2^0' 'git rev-parse --verify start2^0'
 
 test_expect_success 'repack for next test' 'git repack -a -d'
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index fa382c5..336cfaa 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -80,7 +80,7 @@ test_expect_success \
 
 test_expect_success \
     'do not move directory over existing directory' \
-    'mkdir path0 && mkdir path0/path2 && ! git mv path2 path0'
+    'mkdir path0 && mkdir path0/path2 && test_must_fail git mv path2 path0'
 
 test_expect_success \
     'move into "."' \
@@ -149,7 +149,7 @@ test_expect_success 'absolute pathname outside should fail' '(
 	>sub/file &&
 	git add sub/file &&
 
-	! git mv sub "$out/out" &&
+	test_must_fail git mv sub "$out/out" &&
 	test -d sub &&
 	! test -d ../in &&
 	git ls-files --error-unmatch sub/file
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 241c70d..bc7ce2c 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -30,17 +30,17 @@ test_expect_success 'looking for a tag in an empty tree should fail' \
 	'! (tag_exists mytag)'
 
 test_expect_success 'creating a tag in an empty tree should fail' '
-	! git-tag mynotag &&
+	test_must_fail git-tag mynotag &&
 	! tag_exists mynotag
 '
 
 test_expect_success 'creating a tag for HEAD in an empty tree should fail' '
-	! git-tag mytaghead HEAD &&
+	test_must_fail git-tag mytaghead HEAD &&
 	! tag_exists mytaghead
 '
 
 test_expect_success 'creating a tag for an unknown revision should fail' '
-	! git-tag mytagnorev aaaaaaaaaaa &&
+	test_must_fail git-tag mytagnorev aaaaaaaaaaa &&
 	! tag_exists mytagnorev
 '
 
@@ -85,16 +85,16 @@ test_expect_success \
 
 test_expect_success \
 	'trying to create a tag with the name of one existing should fail' \
-	'! git tag mytag'
+	'test_must_fail git tag mytag'
 
 test_expect_success \
 	'trying to create a tag with a non-valid name should fail' '
 	test `git-tag -l | wc -l` -eq 1 &&
-	! git tag "" &&
-	! git tag .othertag &&
-	! git tag "other tag" &&
-	! git tag "othertag^" &&
-	! git tag "other~tag" &&
+	test_must_fail git tag "" &&
+	test_must_fail git tag .othertag &&
+	test_must_fail git tag "other tag" &&
+	test_must_fail git tag "othertag^" &&
+	test_must_fail git tag "other~tag" &&
 	test `git-tag -l | wc -l` -eq 1
 '
 
@@ -107,7 +107,7 @@ test_expect_success 'creating a tag using HEAD directly should succeed' '
 
 test_expect_success 'trying to delete an unknown tag should fail' '
 	! tag_exists unknown-tag &&
-	! git-tag -d unknown-tag
+	test_must_fail git-tag -d unknown-tag
 '
 
 cat >expect <<EOF
@@ -141,13 +141,13 @@ test_expect_success \
 	'trying to delete two tags, existing and not, should fail in the 2nd' '
 	tag_exists mytag &&
 	! tag_exists myhead &&
-	! git-tag -d mytag anothertag &&
+	test_must_fail git-tag -d mytag anothertag &&
 	! tag_exists mytag &&
 	! tag_exists myhead
 '
 
 test_expect_success 'trying to delete an already deleted tag should fail' \
-	'! git-tag -d mytag'
+	'test_must_fail git-tag -d mytag'
 
 # listing various tags with pattern matching:
 
@@ -266,15 +266,15 @@ test_expect_success \
 '
 
 test_expect_success 'trying to verify an unknown tag should fail' \
-	'! git-tag -v unknown-tag'
+	'test_must_fail git-tag -v unknown-tag'
 
 test_expect_success \
 	'trying to verify a non-annotated and non-signed tag should fail' \
-	'! git-tag -v non-annotated-tag'
+	'test_must_fail git-tag -v non-annotated-tag'
 
 test_expect_success \
 	'trying to verify many non-annotated or unknown tags, should fail' \
-	'! git-tag -v unknown-tag1 non-annotated-tag unknown-tag2'
+	'test_must_fail git-tag -v unknown-tag1 non-annotated-tag unknown-tag2'
 
 # creating annotated tags:
 
@@ -334,7 +334,7 @@ test_expect_success \
 	'trying to create a tag with a non-existing -F file should fail' '
 	! test -f nonexistingfile &&
 	! tag_exists notag &&
-	! git-tag -F nonexistingfile notag &&
+	test_must_fail git-tag -F nonexistingfile notag &&
 	! tag_exists notag
 '
 
@@ -343,11 +343,12 @@ test_expect_success \
 	echo "message file 1" >msgfile1 &&
 	echo "message file 2" >msgfile2 &&
 	! tag_exists msgtag &&
-	! git-tag -m "message 1" -F msgfile1 msgtag &&
+	test_must_fail git-tag -m "message 1" -F msgfile1 msgtag &&
 	! tag_exists msgtag &&
-	! git-tag -F msgfile1 -m "message 1" msgtag &&
+	test_must_fail git-tag -F msgfile1 -m "message 1" msgtag &&
 	! tag_exists msgtag &&
-	! git-tag -m "message 1" -F msgfile1 -m "message 2" msgtag &&
+	test_must_fail git-tag -m "message 1" -F msgfile1 \
+		-m "message 2" msgtag &&
 	! tag_exists msgtag
 '
 
@@ -591,19 +592,19 @@ fi
 test_expect_success \
 	'trying to verify an annotated non-signed tag should fail' '
 	tag_exists annotated-tag &&
-	! git-tag -v annotated-tag
+	test_must_fail git-tag -v annotated-tag
 '
 
 test_expect_success \
 	'trying to verify a file-annotated non-signed tag should fail' '
 	tag_exists file-annotated-tag &&
-	! git-tag -v file-annotated-tag
+	test_must_fail git-tag -v file-annotated-tag
 '
 
 test_expect_success \
 	'trying to verify two annotated non-signed tags should fail' '
 	tag_exists annotated-tag file-annotated-tag &&
-	! git-tag -v annotated-tag file-annotated-tag
+	test_must_fail git-tag -v annotated-tag file-annotated-tag
 '
 
 # creating and verifying signed tags:
@@ -651,13 +652,14 @@ test_expect_success 'sign with a given key id' '
 
 test_expect_success 'sign with an unknown id (1)' '
 
-	! git tag -u author@example.com -m "Another message" o-signed-tag
+	test_must_fail git tag -u author@example.com \
+		-m "Another message" o-signed-tag
 
 '
 
 test_expect_success 'sign with an unknown id (2)' '
 
-	! git tag -u DEADBEEF -m "Another message" o-signed-tag
+	test_must_fail git tag -u DEADBEEF -m "Another message" o-signed-tag
 
 '
 
@@ -718,7 +720,7 @@ test_expect_success \
 	'trying to create a signed tag with non-existing -F file should fail' '
 	! test -f nonexistingfile &&
 	! tag_exists nosigtag &&
-	! git-tag -s -F nonexistingfile nosigtag &&
+	test_must_fail git-tag -s -F nonexistingfile nosigtag &&
 	! tag_exists nosigtag
 '
 
@@ -730,10 +732,11 @@ test_expect_success 'verifying two signed tags in one command should succeed' \
 
 test_expect_success \
 	'verifying many signed and non-signed tags should fail' '
-	! git-tag -v signed-tag annotated-tag &&
-	! git-tag -v file-annotated-tag file-signed-tag &&
-	! git-tag -v annotated-tag file-signed-tag file-annotated-tag &&
-	! git-tag -v signed-tag annotated-tag file-signed-tag
+	test_must_fail git-tag -v signed-tag annotated-tag &&
+	test_must_fail git-tag -v file-annotated-tag file-signed-tag &&
+	test_must_fail git-tag -v annotated-tag \
+		file-signed-tag file-annotated-tag &&
+	test_must_fail git-tag -v signed-tag annotated-tag file-signed-tag
 '
 
 test_expect_success 'verifying a forged tag should fail' '
@@ -741,7 +744,7 @@ test_expect_success 'verifying a forged tag should fail' '
 		sed -e "s/signed-tag/forged-tag/" |
 		git mktag) &&
 	git tag forged-tag $forged &&
-	! git-tag -v forged-tag
+	test_must_fail git-tag -v forged-tag
 '
 
 # blank and empty messages for signed tags:
@@ -1031,7 +1034,7 @@ test_expect_success \
 git config user.signingkey BobTheMouse
 test_expect_success \
 	'git-tag -s fails if gpg is misconfigured' \
-	'! git tag -s -m tail tag-gpg-failure'
+	'test_must_fail git tag -s -m tail tag-gpg-failure'
 git config --unset user.signingkey
 
 # try to verify without gpg:
@@ -1039,7 +1042,7 @@ git config --unset user.signingkey
 rm -rf gpghome
 test_expect_success \
 	'verify signed tag fails when public key is not present' \
-	'! git-tag -v signed-tag'
+	'test_must_fail git-tag -v signed-tag'
 
 test_expect_success \
 	'git-tag -a fails if tag annotation is empty' '
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 96d1508..0bfc1e9 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -52,10 +52,10 @@ secondfile:
 EOF
 
 test_expect_success 'giving a non existing revision should fail' '
-	! git reset aaaaaa &&
-	! git reset --mixed aaaaaa &&
-	! git reset --soft aaaaaa &&
-	! git reset --hard aaaaaa &&
+	test_must_fail git reset aaaaaa &&
+	test_must_fail git reset --mixed aaaaaa &&
+	test_must_fail git reset --soft aaaaaa &&
+	test_must_fail git reset --hard aaaaaa &&
 	check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc
 '
 
@@ -63,29 +63,29 @@ test_expect_success 'reset --soft with unmerged index should fail' '
 	touch .git/MERGE_HEAD &&
 	echo "100644 44c5b5884550c17758737edcced463447b91d42b 1	un" |
 		git update-index --index-info &&
-	! git reset --soft HEAD &&
+	test_must_fail git reset --soft HEAD &&
 	rm .git/MERGE_HEAD &&
 	git rm --cached -- un
 '
 
 test_expect_success \
 	'giving paths with options different than --mixed should fail' '
-	! git reset --soft -- first &&
-	! git reset --hard -- first &&
-	! git reset --soft HEAD^ -- first &&
-	! git reset --hard HEAD^ -- first &&
+	test_must_fail git reset --soft -- first &&
+	test_must_fail git reset --hard -- first &&
+	test_must_fail git reset --soft HEAD^ -- first &&
+	test_must_fail git reset --hard HEAD^ -- first &&
 	check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc
 '
 
 test_expect_success 'giving unrecognized options should fail' '
-	! git reset --other &&
-	! git reset -o &&
-	! git reset --mixed --other &&
-	! git reset --mixed -o &&
-	! git reset --soft --other &&
-	! git reset --soft -o &&
-	! git reset --hard --other &&
-	! git reset --hard -o &&
+	test_must_fail git reset --other &&
+	test_must_fail git reset -o &&
+	test_must_fail git reset --mixed --other &&
+	test_must_fail git reset --mixed -o &&
+	test_must_fail git reset --soft --other &&
+	test_must_fail git reset --soft -o &&
+	test_must_fail git reset --hard --other &&
+	test_must_fail git reset --hard -o &&
 	check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc
 '
 
@@ -102,8 +102,8 @@ test_expect_success \
 	echo "3rd line in branch2" >>secondfile &&
 	git commit -a -m "change in branch2" &&
 
-	! git merge branch1 &&
-	! git reset --soft &&
+	test_must_fail git merge branch1 &&
+	test_must_fail git reset --soft &&
 
 	printf "1st line 2nd file\n2nd line 2nd file\n3rd line" >secondfile &&
 	git commit -a -m "the change in branch2" &&
@@ -126,7 +126,7 @@ test_expect_success \
 	echo "3rd line in branch4" >>secondfile &&
 
 	git checkout -m branch3 &&
-	! git reset --soft &&
+	test_must_fail git reset --soft &&
 
 	printf "1st line 2nd file\n2nd line 2nd file\n3rd line" >secondfile &&
 	git commit -a -m "the line in branch3" &&
@@ -326,7 +326,7 @@ test_expect_success '--hard reset to HEAD should clear a failed merge' '
 	echo "3rd line in branch2" >>secondfile &&
 	git commit -a -m "change in branch2" &&
 
-	! git pull . branch1 &&
+	test_must_fail git pull . branch1 &&
 	git reset --hard &&
 	check_changes 77abb337073fb4369a7ad69ff6f5ec0e4d6b54bb
 '
@@ -388,7 +388,7 @@ test_expect_success 'test --mixed <paths>' '
 	echo 4 > file4 &&
 	echo 5 > file1 &&
 	git add file1 file3 file4 &&
-	! git reset HEAD -- file1 file2 file3 &&
+	test_must_fail git reset HEAD -- file1 file2 file3 &&
 	git diff > output &&
 	test_cmp output expect &&
 	git diff --cached > output &&
@@ -402,11 +402,11 @@ test_expect_success 'test resetting the index at give paths' '
 	>sub/file2 &&
 	git update-index --add sub/file1 sub/file2 &&
 	T=$(git write-tree) &&
-	! git reset HEAD sub/file2 &&
+	test_must_fail git reset HEAD sub/file2 &&
 	U=$(git write-tree) &&
 	echo "$T" &&
 	echo "$U" &&
-	! git diff-index --cached --exit-code "$T" &&
+	test_must_fail git diff-index --cached --exit-code "$T" &&
 	test "$T" != "$U"
 
 '
diff --git a/t/t7103-reset-bare.sh b/t/t7103-reset-bare.sh
index b25a77f..cdecebe 100755
--- a/t/t7103-reset-bare.sh
+++ b/t/t7103-reset-bare.sh
@@ -17,7 +17,7 @@ test_expect_success 'setup bare' '
 '
 
 test_expect_success 'hard reset is not allowed' '
-	! git reset --hard HEAD^
+	test_must_fail  git reset --hard HEAD^
 '
 
 test_expect_success 'soft reset is allowed' '
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index bd77239..2b51c0d 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -316,14 +316,14 @@ test_expect_success 'git-clean -d -X' '
 test_expect_success 'clean.requireForce defaults to true' '
 
 	git config --unset clean.requireForce &&
-	! git-clean
+	test_must_fail git clean
 
 '
 
 test_expect_success 'clean.requireForce' '
 
 	git config clean.requireForce true &&
-	! git-clean
+	test_must_fail git clean
 
 '
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 6c7b902..cbc0c34 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -75,7 +75,7 @@ test_expect_success 'init should register submodule url in .git/config' '
 	then
 		echo "[OOPS] init succeeded but submodule url is wrong"
 		false
-	elif ! git config submodule.example.url ./.subrepo
+	elif test_must_fail git config submodule.example.url ./.subrepo
 	then
 		echo "[OOPS] init succeeded but update of url failed"
 		false
diff --git a/t/t7402-submodule-rebase.sh b/t/t7402-submodule-rebase.sh
index 5becb3e..f919c8d 100755
--- a/t/t7402-submodule-rebase.sh
+++ b/t/t7402-submodule-rebase.sh
@@ -71,7 +71,7 @@ test_expect_success 'rebase with dirty file and submodule fails' '
 	test_tick &&
 	git commit -m rewrite file &&
 	echo dirty > file &&
-	! git rebase --onto HEAD~2 HEAD^
+	test_must_fail git rebase --onto HEAD~2 HEAD^
 
 '
 
diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index baed6ce..d89f91a 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -23,12 +23,12 @@ test_expect_success 'a basic commit in an empty tree should succeed' '
 test_expect_success 'nonexistent template file should return error' '
 	echo changes >> foo &&
 	git add foo &&
-	! git commit --template "$PWD"/notexist
+	test_must_fail git commit --template "$PWD"/notexist
 '
 
 test_expect_success 'nonexistent template file in config should return error' '
 	git config commit.template "$PWD"/notexist &&
-	! git commit &&
+	test_must_fail git commit &&
 	git config --unset commit.template
 '
 
@@ -37,12 +37,12 @@ TEMPLATE="$PWD"/template
 
 test_expect_success 'unedited template should not commit' '
 	echo "template line" > "$TEMPLATE" &&
-	! git commit --template "$TEMPLATE"
+	test_must_fail git commit --template "$TEMPLATE"
 '
 
 test_expect_success 'unedited template with comments should not commit' '
 	echo "# comment in template" >> "$TEMPLATE" &&
-	! git commit --template "$TEMPLATE"
+	test_must_fail git commit --template "$TEMPLATE"
 '
 
 test_expect_success 'a Signed-off-by line by itself should not commit' '
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index d3370ff..0edd9dd 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -19,7 +19,7 @@ test_expect_success \
 
 test_expect_success \
 	"fail initial amend" \
-	"! git-commit --amend"
+	"test_must_fail git-commit --amend"
 
 test_expect_success \
 	"initial commit" \
@@ -27,16 +27,16 @@ test_expect_success \
 
 test_expect_success \
 	"invalid options 1" \
-	"! git-commit -m foo -m bar -F file"
+	"test_must_fail git-commit -m foo -m bar -F file"
 
 test_expect_success \
 	"invalid options 2" \
-	"! git-commit -C HEAD -m illegal"
+	"test_must_fail git-commit -C HEAD -m illegal"
 
 test_expect_success \
 	"using paths with -a" \
 	"echo King of the bongo >file &&
-	! git-commit -m foo -a file"
+	test_must_fail git-commit -m foo -a file"
 
 test_expect_success \
 	"using paths with --interactive" \
@@ -45,11 +45,11 @@ test_expect_success \
 
 test_expect_success \
 	"using invalid commit with -C" \
-	"! git-commit -C bogus"
+	"test_must_fail git-commit -C bogus"
 
 test_expect_success \
 	"testing nothing to commit" \
-	"! git-commit -m initial"
+	"test_must_fail git-commit -m initial"
 
 test_expect_success \
 	"next commit" \
@@ -59,7 +59,7 @@ test_expect_success \
 test_expect_success \
 	"commit message from non-existing file" \
 	"echo 'more bongo: bongo bongo bongo bongo' >file && \
-	 ! git-commit -F gah -a"
+	 test_must_fail git-commit -F gah -a"
 
 # Empty except stray tabs and spaces on a few lines.
 sed -e 's/@$//' >msg <<EOF
@@ -70,7 +70,7 @@ Signed-off-by: hula
 EOF
 test_expect_success \
 	"empty commit message" \
-	"! git-commit -F msg -a"
+	"test_must_fail git-commit -F msg -a"
 
 test_expect_success \
 	"commit message from file" \
@@ -91,7 +91,7 @@ test_expect_success \
 test_expect_success \
 	"passing -m and -F" \
 	"echo 'enough with the bongos' >file && \
-	 ! git-commit -F msg -m amending ."
+	 test_must_fail git-commit -F msg -m amending ."
 
 test_expect_success \
 	"using message from other commit" \
diff --git a/t/t7503-pre-commit-hook.sh b/t/t7503-pre-commit-hook.sh
index 2dd5a5e..b069095 100755
--- a/t/t7503-pre-commit-hook.sh
+++ b/t/t7503-pre-commit-hook.sh
@@ -56,7 +56,7 @@ test_expect_success 'with failing hook' '
 
 	echo "another" >> file &&
 	git add file &&
-	! git commit -m "another"
+	test_must_fail git commit -m "another"
 
 '
 
diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
index 88577af..47680e6 100755
--- a/t/t7504-commit-msg-hook.sh
+++ b/t/t7504-commit-msg-hook.sh
@@ -105,7 +105,7 @@ test_expect_success 'with failing hook' '
 
 	echo "another" >> file &&
 	git add file &&
-	! git commit -m "another"
+	test_must_fail git commit -m "another"
 
 '
 
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index d21cd29..7d182b5 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -126,7 +126,7 @@ verify_merge() {
 		echo "[OOPS] unmerged files"
 		false
 	fi &&
-	if ! git diff --exit-code
+	if test_must_fail git diff --exit-code
 	then
 		echo "[OOPS] working tree != index"
 		false
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 6b0483f..9285071 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -35,7 +35,7 @@ test_expect_success 'custom mergetool' '
     git config mergetool.mytool.cmd "cat \"\$REMOTE\" >\"\$MERGED\"" &&
     git config mergetool.mytool.trustExitCode true &&
 	git checkout branch1 &&
-    ! git merge master >/dev/null 2>&1 &&
+    test_must_fail git merge master >/dev/null 2>&1 &&
     ( yes "" | git mergetool file1>/dev/null 2>&1 ) &&
     ( yes "" | git mergetool file2>/dev/null 2>&1 ) &&
     test "$(cat file1)" = "master updated" &&
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 3bc6164..843a501 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -63,7 +63,7 @@ test_expect_success "$name" "
 	git update-index --remove dir/file &&
 	git update-index --add dir/file/file &&
 	git commit -m '$name' &&
-	! git-svn set-tree --find-copies-harder --rmdir \
+	test_must_fail git-svn set-tree --find-copies-harder --rmdir \
 		remotes/git-svn..mybranch" || true
 
 
@@ -77,7 +77,7 @@ test_expect_success "$name" '
 	git update-index --remove -- bar/zzz &&
 	git update-index --add -- bar &&
 	git commit -m "$name" &&
-	! git-svn set-tree --find-copies-harder --rmdir \
+	test_must_fail git-svn set-tree --find-copies-harder --rmdir \
 		remotes/git-svn..mybranch2' || true
 
 
@@ -91,7 +91,7 @@ test_expect_success "$name" '
 	echo yyy > bar/zzz/yyy &&
 	git update-index --add bar/zzz/yyy &&
 	git commit -m "$name" &&
-	! git-svn set-tree --find-copies-harder --rmdir \
+	test_must_fail git-svn set-tree --find-copies-harder --rmdir \
 		remotes/git-svn..mybranch3' || true
 
 
@@ -105,7 +105,7 @@ test_expect_success "$name" '
 	echo asdf > dir &&
 	git update-index --add -- dir &&
 	git commit -m "$name" &&
-	! git-svn set-tree --find-copies-harder --rmdir \
+	test_must_fail git-svn set-tree --find-copies-harder --rmdir \
 		remotes/git-svn..mybranch4' || true
 
 
@@ -216,7 +216,7 @@ test_expect_success "$name" "test_cmp a expected"
 test_expect_success 'exit if remote refs are ambigious' "
         git config --add svn-remote.svn.fetch \
                               bar:refs/remotes/git-svn &&
-	! git-svn migrate
+	test_must_fail git-svn migrate
 "
 
 test_expect_success 'exit if init-ing a would clobber a URL' '
@@ -224,7 +224,7 @@ test_expect_success 'exit if init-ing a would clobber a URL' '
         svn mkdir -m "mkdir bar" "${svnrepo}2/bar" &&
         git config --unset svn-remote.svn.fetch \
                                 "^bar:refs/remotes/git-svn$" &&
-	! git-svn init "${svnrepo}2/bar"
+	test_must_fail git-svn init "${svnrepo}2/bar"
         '
 
 test_expect_success \
diff --git a/t/t9106-git-svn-commit-diff-clobber.sh b/t/t9106-git-svn-commit-diff-clobber.sh
index 58a3a7b..a57ff68 100755
--- a/t/t9106-git-svn-commit-diff-clobber.sh
+++ b/t/t9106-git-svn-commit-diff-clobber.sh
@@ -27,7 +27,7 @@ test_expect_success 'commit change from svn side' '
 test_expect_success 'commit conflicting change from git' '
 	echo second line from git >> file &&
 	git commit -a -m "second line from git" &&
-	! git-svn commit-diff -r1 HEAD~1 HEAD "$svnrepo"
+	test_must_fail git-svn commit-diff -r1 HEAD~1 HEAD "$svnrepo"
 '
 
 test_expect_success 'commit complementing change from git' '
@@ -52,7 +52,7 @@ test_expect_success 'dcommit fails to commit because of conflict' '
 	rm -rf t.svn &&
 	echo "fourth line from git" >> file &&
 	git commit -a -m "fourth line from git" &&
-	! git-svn dcommit
+	test_must_fail git-svn dcommit
 	'
 
 test_expect_success 'dcommit does the svn equivalent of an index merge' "
@@ -83,7 +83,7 @@ test_expect_success 'multiple dcommit from git-svn will not clobber svn' "
 	git commit -a -m 'new file' &&
 	echo clobber > file &&
 	git commit -a -m 'clobber' &&
-	! git svn dcommit
+	test_must_fail git svn dcommit
 	"
 
 
diff --git a/t/t9106-git-svn-dcommit-clobber-series.sh b/t/t9106-git-svn-dcommit-clobber-series.sh
index f8f4718..bc37db9 100755
--- a/t/t9106-git-svn-dcommit-clobber-series.sh
+++ b/t/t9106-git-svn-dcommit-clobber-series.sh
@@ -57,7 +57,7 @@ test_expect_success 'change file but in unrelated area' "
 test_expect_success 'attempt to dcommit with a dirty index' '
 	echo foo >>file &&
 	git add file &&
-	! git svn dcommit
+	test_must_fail git svn dcommit
 '
 
 test_done
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index b1dc32d..3e32e84 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -100,7 +100,7 @@ test_expect_success \
      git commit -a -m "generation 2" &&
      id=$(git rev-list --max-count=1 HEAD) &&
      (cd "$CVSWORK" &&
-     ! git cvsexportcommit -c $id
+     test_must_fail git cvsexportcommit -c $id
      )'
 
 #test_expect_success \
@@ -112,7 +112,7 @@ test_expect_success \
 #     git commit -a -m "generation 3" &&
 #     id=$(git rev-list --max-count=1 HEAD) &&
 #     (cd "$CVSWORK" &&
-#     ! git cvsexportcommit -c $id
+#     test_must_fail git cvsexportcommit -c $id
 #     )'
 
 # We reuse the state from two tests back here
@@ -222,7 +222,7 @@ test_expect_success \
       git commit -a -m "Update two" &&
       id=$(git rev-list --max-count=1 HEAD) &&
       (cd "$CVSWORK" &&
-      ! git-cvsexportcommit -c $id
+      test_must_fail git-cvsexportcommit -c $id
       )'
 
 case "$(git config --bool core.filemode)" in
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 5edf56f..e17afa8 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -166,7 +166,7 @@ M 755 0000000000000000000000000000000000000001 zero1
 
 INPUT_END
 test_expect_success 'B: fail on invalid blob sha1' '
-    ! git-fast-import <input
+    test_must_fail git-fast-import <input
 '
 rm -f .git/objects/pack_* .git/objects/index_*
 
@@ -181,7 +181,7 @@ from refs/heads/master
 
 INPUT_END
 test_expect_success 'B: fail on invalid branch name ".badbranchname"' '
-    ! git-fast-import <input
+    test_must_fail git-fast-import <input
 '
 rm -f .git/objects/pack_* .git/objects/index_*
 
@@ -196,7 +196,7 @@ from refs/heads/master
 
 INPUT_END
 test_expect_success 'B: fail on invalid branch name "bad[branch]name"' '
-    ! git-fast-import <input
+    test_must_fail git-fast-import <input
 '
 rm -f .git/objects/pack_* .git/objects/index_*
 
@@ -340,7 +340,7 @@ from refs/heads/branch^0
 
 INPUT_END
 test_expect_success 'E: rfc2822 date, --date-format=raw' '
-    ! git-fast-import --date-format=raw <input
+    test_must_fail git-fast-import --date-format=raw <input
 '
 test_expect_success \
     'E: rfc2822 date, --date-format=rfc2822' \
diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
index f1bc5ce..0959f2f 100755
--- a/t/t9301-fast-export.sh
+++ b/t/t9301-fast-export.sh
@@ -59,7 +59,7 @@ test_expect_success 'fast-export master~2..master' '
 		 test $MASTER != $(git rev-parse --verify refs/heads/partial) &&
 		 git diff master..partial &&
 		 git diff master^..partial^ &&
-		 ! git rev-parse partial~2)
+		 test_must_fail git rev-parse partial~2)
 
 '
 
@@ -125,7 +125,7 @@ test_expect_success 'set up faked signed tag' '
 
 test_expect_success 'signed-tags=abort' '
 
-	! git fast-export --signed-tags=abort sign-your-name
+	test_must_fail git fast-export --signed-tags=abort sign-your-name
 
 '
 
-- 
1.5.6.2.303.g79662

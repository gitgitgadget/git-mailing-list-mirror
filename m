From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: 3 failures on test t9100 (svn)
Date: Tue, 2 Mar 2010 20:45:18 +0100
Message-ID: <20100302194518.GA12942@vidovic>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
Content-Transfer-Encoding: 8bit
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 02 20:46:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmY29-0002Fq-VG
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 20:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184Ab0CBTp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 14:45:28 -0500
Received: from mail-iw0-f196.google.com ([209.85.223.196]:44572 "EHLO
	mail-iw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427Ab0CBTp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 14:45:26 -0500
Received: by iwn34 with SMTP id 34so528315iwn.15
        for <git@vger.kernel.org>; Tue, 02 Mar 2010 11:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=my9dLJm88LHWvypiyEceb5Dq6heb9wo9Qp6a9UiX7vY=;
        b=IkAqCwBws0yVJ0ZB54y0MT+5c+k9HWqiolglyWIY+NC44EdvOId7fZb97W/qHEGj/f
         RzdW9PwLattqur7lGHNyxqt+Q6wJaI1AZ9shAIE0msm0noYqtVIFz+klMy2d9TTldrjj
         b3JOh4enuIpjCv7h9700M2ZOVmGRuegkOIICk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=KqEPWyie2I3W2TE/0/ejM7d3RtnzL9REwZjlucvtIX9QtQEMVLjfknTjR7ZlTu55+w
         5fBTevdehMpVHJv6nRILZCbuTi82aUMOxkbsok/FDPMW54lbaGpA1Bfk906hYzCUpUOq
         kPwfOHfsjLWiaR6wlRX+gMhCP4OXi2sjlb6Yk=
Received: by 10.231.174.140 with SMTP id t12mr224199ibz.89.1267559125795;
        Tue, 02 Mar 2010 11:45:25 -0800 (PST)
Received: from @ (91-164-132-214.rev.libertysurf.net [91.164.132.214])
        by mx.google.com with ESMTPS id y67sm282215iby.3.2010.03.02.11.45.21
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 02 Mar 2010 11:45:23 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141411>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

Some tests in t9100 don't pass here with current next (full log
attached). Any idea?


  $ git --version
  git version 1.7.0.1.242.g4aa8

  $ cat test_done-689
  total 23
  success 19
  fixed 0
  broken 0
  failed 3

  $ export GIT_TEST_OPTS='-i -v -d'
  $ make clean && make full-svn-test
  Initialized empty Git repository in /home/nicolas/dev/official_packages/gitrepos/git/t/trash directory.test-lib/.git/
  * define NO_SVN_TESTS to skip git svn tests
  * UTF-8 locale not set, some tests skipped (C)
  
  <...>
  
  * expecting success: 
  	echo git help > help || true &&
  	rm exec-2.sh &&
  	cp help exec-2.sh &&
  	git update-index exec-2.sh &&
  	git commit -m "$name" &&
  	git svn set-tree --find-copies-harder --rmdir \
  		${remotes_git_svn}..mybranch5 &&
  	svn_cmd up "$SVN_TREE" &&
  	test -f "$SVN_TREE"/exec-2.sh &&
  	test ! -L "$SVN_TREE"/exec-2.sh &&
  	test_cmp help "$SVN_TREE"/exec-2.sh
  [mybranch5 da8c65b] modify a symlink to become a file
   Author: A U Thor <author@example.com>
   1 files changed, 1 insertions(+), 1 deletions(-)
   rewrite exec-2.sh (100%)
   mode change 120000 => 100644
  	T	exec-2.sh
  	M	exec-2.sh
  r7 = 029215de766ed32ca649230497785d0c2b25cdce (refs/remotes/git-svn)
  Done committing 1 revisions to SVN
  UU   /home/nicolas/dev/official_packages/gitrepos/git/t/trash directory.test-lib/.git/svn/refs/remotes/git-svn/svn-tree/exec-2.sh
  Updated to revision 7.
  test_cmp:1: command not found: diff -u
  * FAIL 13: modify a symlink to become a file
  	
  		echo git help > help || true &&
  		rm exec-2.sh &&
  		cp help exec-2.sh &&
  		git update-index exec-2.sh &&
  		git commit -m "$name" &&
  		git svn set-tree --find-copies-harder --rmdir \
  			${remotes_git_svn}..mybranch5 &&
  		svn_cmd up "$SVN_TREE" &&
  		test -f "$SVN_TREE"/exec-2.sh &&
  		test ! -L "$SVN_TREE"/exec-2.sh &&
  		test_cmp help "$SVN_TREE"/exec-2.sh
  
  <...>
  
  * expecting success: git svn init "$svnrepo" && git svn fetch &&
       git rev-list --pretty=raw ${remotes_git_svn} | grep ^tree | uniq > a &&
       git rev-list --pretty=raw remotes/alt | grep ^tree | uniq > b &&
       test_cmp a b
  Using existing [svn-remote "svn"]
  	A	foo.link
  	A	foo
  	A	bar/zzz
  	A	exec.sh
  	A	dir/a/b/c/d/e/file
  r1 = 7573d34cdf10b5542f8caa5298e01b279338e333 (refs/remotes/alt)
  	A	file
  	D	dir/a/b/c/d/e/file
  	D	dir/a/
  	A	dir/file
  W: -empty_dir: dir/a
  r2 = c7cb7b4d4365180d5e8008b247efba7cbb2613a3 (refs/remotes/alt)
  	M	exec.sh
  r3 = 5d528b2954a387fb4804137ab6fd20829a90a21c (refs/remotes/alt)
  	M	exec.sh
  r4 = 8b00511e65ab590e00babc4b5fd2cca88dd68202 (refs/remotes/alt)
  	M	exec.sh
  r5 = 2c3498c0659fcec8db0fb11901f22b604d63aef4 (refs/remotes/alt)
  	M	bar/zzz
  	A	exec-2.sh
  r6 = 81736e5906738e41761c795e49f99743f1c00244 (refs/remotes/alt)
  	M	exec-2.sh
  r7 = 5098d81d13fd07e451327a52f22da679ab7c3b9f (refs/remotes/alt)
  test_cmp:1: command not found: diff -u
  * FAIL 15: test fetch functionality (svn => git) with alternate GIT_SVN_ID
  	git svn init "$svnrepo" && git svn fetch &&
  	     git rev-list --pretty=raw ${remotes_git_svn} | grep ^tree | uniq > a &&
  	     git rev-list --pretty=raw remotes/alt | grep ^tree | uniq > b &&
  	     test_cmp a b
  
  * expecting success: test_cmp a expected
  test_cmp:1: command not found: diff -u
  * FAIL 16: check imported tree checksums expected tree checksums
  	test_cmp a expected
  
  <...>
  
  * failed 3 among 23 test(s)

-- 
Nicolas Sebrecht

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="t9100-git-svn-basic.out"
Content-Transfer-Encoding: 8bit

Initialized empty Git repository in /home/nicolas/dev/official_packages/gitrepos/git/t/trash directory.test-lib/.git/
* define NO_SVN_TESTS to skip git svn tests
* UTF-8 locale not set, some tests skipped (C)
* expecting success: 
	mkdir import &&
	cd import &&
	echo foo > foo &&
	ln -s foo foo.link
	mkdir -p dir/a/b/c/d/e &&
	echo "deep dir" > dir/a/b/c/d/e/file &&
	mkdir bar &&
	echo "zzz" > bar/zzz &&
	echo "#!/bin/sh" > exec.sh &&
	chmod +x exec.sh &&
	svn_cmd import -m "import for git svn" . "$svnrepo" >/dev/null &&
	cd .. &&
	rm -rf import &&
	git svn init "$svnrepo"
*   ok 1: initialize git svn

* expecting success: git svn fetch
	A	foo.link
	A	foo
	A	bar/zzz
	A	exec.sh
	A	dir/a/b/c/d/e/file
r1 = 7573d34cdf10b5542f8caa5298e01b279338e333 (refs/remotes/git-svn)
Checked out HEAD:
  file:///home/nicolas/dev/official_packages/gitrepos/git/t/trash directory.test-lib/svnrepo r1
*   ok 2: import an SVN revision into git

* expecting success: svn co "$svnrepo" "$SVN_TREE"
A    /home/nicolas/dev/official_packages/gitrepos/git/t/trash directory.test-lib/.git/svn/refs/remotes/git-svn/svn-tree/foo.link
A    /home/nicolas/dev/official_packages/gitrepos/git/t/trash directory.test-lib/.git/svn/refs/remotes/git-svn/svn-tree/foo
A    /home/nicolas/dev/official_packages/gitrepos/git/t/trash directory.test-lib/.git/svn/refs/remotes/git-svn/svn-tree/bar
A    /home/nicolas/dev/official_packages/gitrepos/git/t/trash directory.test-lib/.git/svn/refs/remotes/git-svn/svn-tree/bar/zzz
A    /home/nicolas/dev/official_packages/gitrepos/git/t/trash directory.test-lib/.git/svn/refs/remotes/git-svn/svn-tree/exec.sh
A    /home/nicolas/dev/official_packages/gitrepos/git/t/trash directory.test-lib/.git/svn/refs/remotes/git-svn/svn-tree/dir
A    /home/nicolas/dev/official_packages/gitrepos/git/t/trash directory.test-lib/.git/svn/refs/remotes/git-svn/svn-tree/dir/a
A    /home/nicolas/dev/official_packages/gitrepos/git/t/trash directory.test-lib/.git/svn/refs/remotes/git-svn/svn-tree/dir/a/b
A    /home/nicolas/dev/official_packages/gitrepos/git/t/trash directory.test-lib/.git/svn/refs/remotes/git-svn/svn-tree/dir/a/b/c
A    /home/nicolas/dev/official_packages/gitrepos/git/t/trash directory.test-lib/.git/svn/refs/remotes/git-svn/svn-tree/dir/a/b/c/d
A    /home/nicolas/dev/official_packages/gitrepos/git/t/trash directory.test-lib/.git/svn/refs/remotes/git-svn/svn-tree/dir/a/b/c/d/e
A    /home/nicolas/dev/official_packages/gitrepos/git/t/trash directory.test-lib/.git/svn/refs/remotes/git-svn/svn-tree/dir/a/b/c/d/e/file
Checked out revision 1.
*   ok 3: checkout from svn

* expecting success: 
	git checkout -f -b mybranch ${remotes_git_svn} &&
	mv dir/a/b/c/d/e/file dir/file &&
	cp dir/file file &&
	git update-index --add --remove dir/a/b/c/d/e/file dir/file file &&
	git commit -m "$name" &&
	git svn set-tree --find-copies-harder --rmdir \
		${remotes_git_svn}..mybranch &&
	svn_cmd up "$SVN_TREE" &&
	test -d "$SVN_TREE"/dir && test ! -d "$SVN_TREE"/dir/a
Switched to a new branch 'mybranch'
[mybranch 30f6488] try a deep --rmdir with a commit
 Author: A U Thor <author@example.com>
 2 files changed, 0 insertions(+), 0 deletions(-)
 copy dir/{a/b/c/d/e => }/file (100%)
 rename dir/a/b/c/d/e/file => file (100%)
	C	dir/a/b/c/d/e/file => dir/file
	R	dir/a/b/c/d/e/file => file
	D+	dir/a/b/c/d/e/
	D+	dir/a/b/c/d/
	D+	dir/a/b/c/
	D+	dir/a/b/
	D+	dir/a/
	A	file
	D	dir/a/b/c/d/e/file
	D	dir/a/
	A	dir/file
W: -empty_dir: dir/a
r2 = 3d70444787449738155d0e02b509bc34de5f6f2e (refs/remotes/git-svn)
Done committing 1 revisions to SVN
A    /home/nicolas/dev/official_packages/gitrepos/git/t/trash directory.test-lib/.git/svn/refs/remotes/git-svn/svn-tree/file
D    /home/nicolas/dev/official_packages/gitrepos/git/t/trash directory.test-lib/.git/svn/refs/remotes/git-svn/svn-tree/dir/a
A    /home/nicolas/dev/official_packages/gitrepos/git/t/trash directory.test-lib/.git/svn/refs/remotes/git-svn/svn-tree/dir/file
Updated to revision 2.
*   ok 4: try a deep --rmdir with a commit

* expecting success: 
	mkdir dir/new_file &&
	mv dir/file dir/new_file/file &&
	mv dir/new_file dir/file &&
	git update-index --remove dir/file &&
	git update-index --add dir/file/file &&
	git commit -m 'detect node change from file to directory #1' &&
	test_must_fail git svn set-tree --find-copies-harder --rmdir 		remotes/git-svn..mybranch
[mybranch 21e81e7] detect node change from file to directory #1
 Author: A U Thor <author@example.com>
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename dir/{ => file}/file (100%)
dir/file already exists in repository at r2 and it is not a directory (file/1)
*   ok 5: detect node change from file to directory #1

* expecting success: 
	rm -rf dir "$GIT_DIR"/index &&
	git checkout -f -b mybranch2 ${remotes_git_svn} &&
	mv bar/zzz zzz &&
	rm -rf bar &&
	mv zzz bar &&
	git update-index --remove -- bar/zzz &&
	git update-index --add -- bar &&
	git commit -m "$name" &&
	test_must_fail git svn set-tree --find-copies-harder --rmdir \
		${remotes_git_svn}..mybranch2
Switched to a new branch 'mybranch2'
[mybranch2 0dd2e60] detect node change from directory to file #1
 Author: A U Thor <author@example.com>
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename bar/zzz => bar (100%)
Transaction is out of date: Directory '/bar' is out of date at /home/nicolas/dev/official_packages/gitrepos/git/t/../git-svn line 3439

*   ok 6: detect node change from directory to file #1

* expecting success: 
	rm -f "$GIT_DIR"/index &&
	git checkout -f -b mybranch3 ${remotes_git_svn} &&
	rm bar/zzz &&
	git update-index --remove bar/zzz &&
	mkdir bar/zzz &&
	echo yyy > bar/zzz/yyy &&
	git update-index --add bar/zzz/yyy &&
	git commit -m "$name" &&
	test_must_fail git svn set-tree --find-copies-harder --rmdir \
		${remotes_git_svn}..mybranch3
Switched to a new branch 'mybranch3'
[mybranch3 f257ca2] detect node change from file to directory #2
 Author: A U Thor <author@example.com>
 2 files changed, 1 insertions(+), 1 deletions(-)
 delete mode 100644 bar/zzz
 create mode 100644 bar/zzz/yyy
	D	bar/zzz
bar/zzz already exists in repository at r2 and it is not a directory (file/1)
*   ok 7: detect node change from file to directory #2

* expecting success: 
	rm -f "$GIT_DIR"/index &&
	git checkout -f -b mybranch4 ${remotes_git_svn} &&
	rm -rf dir &&
	git update-index --remove -- dir/file &&
	touch dir &&
	echo asdf > dir &&
	git update-index --add -- dir &&
	git commit -m "$name" &&
	test_must_fail git svn set-tree --find-copies-harder --rmdir \
		${remotes_git_svn}..mybranch4
Switched to a new branch 'mybranch4'
[mybranch4 6c02763] detect node change from directory to file #2
 Author: A U Thor <author@example.com>
 2 files changed, 1 insertions(+), 1 deletions(-)
 create mode 100644 dir
 delete mode 100644 dir/file
	D	dir/file
Item already exists in filesystem: File already exists: filesystem '/home/nicolas/dev/official_packages/gitrepos/git/t/trash directory.test-lib/svnrepo/db', transaction '2-5', path '/dir' at /home/nicolas/dev/official_packages/gitrepos/git/t/../git-svn line 3439

*   ok 8: detect node change from directory to file #2

* expecting success: 
	rm -f "$GIT_DIR"/index &&
	git checkout -f -b mybranch5 ${remotes_git_svn} &&
	chmod -x exec.sh &&
	git update-index exec.sh &&
	git commit -m "$name" &&
	git svn set-tree --find-copies-harder --rmdir \
		${remotes_git_svn}..mybranch5 &&
	svn_cmd up "$SVN_TREE" &&
	test ! -x "$SVN_TREE"/exec.sh
Switched to a new branch 'mybranch5'
[mybranch5 f27fc06] remove executable bit from a file
 Author: A U Thor <author@example.com>
 0 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 exec.sh
	M	exec.sh
	M	exec.sh
r3 = c31b0e6cdf5d70b0c05a2e3b9b39a3e02c2e06d8 (refs/remotes/git-svn)
Done committing 1 revisions to SVN
UU   /home/nicolas/dev/official_packages/gitrepos/git/t/trash directory.test-lib/.git/svn/refs/remotes/git-svn/svn-tree/exec.sh
Updated to revision 3.
*   ok 9: remove executable bit from a file

* expecting success: 
	chmod +x exec.sh &&
	git update-index exec.sh &&
	git commit -m "$name" &&
	git svn set-tree --find-copies-harder --rmdir \
		${remotes_git_svn}..mybranch5 &&
	svn_cmd up "$SVN_TREE" &&
	test -x "$SVN_TREE"/exec.sh
[mybranch5 c868af9] add executable bit back file
 Author: A U Thor <author@example.com>
 0 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 exec.sh
	M	exec.sh
	M	exec.sh
r4 = 91c7e9fd0952a4274a4ccd099840bddfa9576678 (refs/remotes/git-svn)
Done committing 1 revisions to SVN
UU   /home/nicolas/dev/official_packages/gitrepos/git/t/trash directory.test-lib/.git/svn/refs/remotes/git-svn/svn-tree/exec.sh
Updated to revision 4.
*   ok 10: add executable bit back file

* expecting success: 
	rm exec.sh &&
	ln -s bar/zzz exec.sh &&
	git update-index exec.sh &&
	git commit -m "$name" &&
	git svn set-tree --find-copies-harder --rmdir \
		${remotes_git_svn}..mybranch5 &&
	svn_cmd up "$SVN_TREE" &&
	test -L "$SVN_TREE"/exec.sh
[mybranch5 cdc5cc3] executable file becomes a symlink to bar/zzz (file)
 Author: A U Thor <author@example.com>
 1 files changed, 1 insertions(+), 1 deletions(-)
 rewrite exec.sh (100%)
 mode change 100755 => 120000
	T	exec.sh
	M	exec.sh
r5 = bef12358449635e87e233b214500a9267c0c8a05 (refs/remotes/git-svn)
Done committing 1 revisions to SVN
UU   /home/nicolas/dev/official_packages/gitrepos/git/t/trash directory.test-lib/.git/svn/refs/remotes/git-svn/svn-tree/exec.sh
Updated to revision 5.
*   ok 11: executable file becomes a symlink to bar/zzz (file)

* expecting success: 
	chmod +x bar/zzz &&
	ln -s bar/zzz exec-2.sh &&
	git update-index --add bar/zzz exec-2.sh &&
	git commit -m "$name" &&
	git svn set-tree --find-copies-harder --rmdir \
		${remotes_git_svn}..mybranch5 &&
	svn_cmd up "$SVN_TREE" &&
	test -x "$SVN_TREE"/bar/zzz &&
	test -L "$SVN_TREE"/exec-2.sh
[mybranch5 ce704f0] new symlink is added to a file that was also just made executable
 Author: A U Thor <author@example.com>
 1 files changed, 1 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 bar/zzz
 create mode 120000 exec-2.sh
	C	exec.sh => exec-2.sh
	M	bar/zzz
	M	bar/zzz
	A	exec-2.sh
r6 = c81bb7423d3195ee520cd0ba2d5da04ac5fceeb0 (refs/remotes/git-svn)
Done committing 1 revisions to SVN
UU   /home/nicolas/dev/official_packages/gitrepos/git/t/trash directory.test-lib/.git/svn/refs/remotes/git-svn/svn-tree/bar/zzz
A    /home/nicolas/dev/official_packages/gitrepos/git/t/trash directory.test-lib/.git/svn/refs/remotes/git-svn/svn-tree/exec-2.sh
Updated to revision 6.
*   ok 12: new symlink is added to a file that was also just made executable

* expecting success: 
	echo git help > help || true &&
	rm exec-2.sh &&
	cp help exec-2.sh &&
	git update-index exec-2.sh &&
	git commit -m "$name" &&
	git svn set-tree --find-copies-harder --rmdir \
		${remotes_git_svn}..mybranch5 &&
	svn_cmd up "$SVN_TREE" &&
	test -f "$SVN_TREE"/exec-2.sh &&
	test ! -L "$SVN_TREE"/exec-2.sh &&
	test_cmp help "$SVN_TREE"/exec-2.sh
[mybranch5 da8c65b] modify a symlink to become a file
 Author: A U Thor <author@example.com>
 1 files changed, 1 insertions(+), 1 deletions(-)
 rewrite exec-2.sh (100%)
 mode change 120000 => 100644
	T	exec-2.sh
	M	exec-2.sh
r7 = 029215de766ed32ca649230497785d0c2b25cdce (refs/remotes/git-svn)
Done committing 1 revisions to SVN
UU   /home/nicolas/dev/official_packages/gitrepos/git/t/trash directory.test-lib/.git/svn/refs/remotes/git-svn/svn-tree/exec-2.sh
Updated to revision 7.
test_cmp:1: command not found: diff -u
* FAIL 13: modify a symlink to become a file
	
		echo git help > help || true &&
		rm exec-2.sh &&
		cp help exec-2.sh &&
		git update-index exec-2.sh &&
		git commit -m "$name" &&
		git svn set-tree --find-copies-harder --rmdir \
			${remotes_git_svn}..mybranch5 &&
		svn_cmd up "$SVN_TREE" &&
		test -f "$SVN_TREE"/exec-2.sh &&
		test ! -L "$SVN_TREE"/exec-2.sh &&
		test_cmp help "$SVN_TREE"/exec-2.sh

* skipping test: commit with UTF-8 message: locale: C 
	echo '# hello' >> exec-2.sh &&
	git update-index exec-2.sh &&
	git commit -m 'éï∏' &&
	git svn set-tree HEAD
* skip 14: commit with UTF-8 message: locale: C

* expecting success: git svn init "$svnrepo" && git svn fetch &&
     git rev-list --pretty=raw ${remotes_git_svn} | grep ^tree | uniq > a &&
     git rev-list --pretty=raw remotes/alt | grep ^tree | uniq > b &&
     test_cmp a b
Using existing [svn-remote "svn"]
	A	foo.link
	A	foo
	A	bar/zzz
	A	exec.sh
	A	dir/a/b/c/d/e/file
r1 = 7573d34cdf10b5542f8caa5298e01b279338e333 (refs/remotes/alt)
	A	file
	D	dir/a/b/c/d/e/file
	D	dir/a/
	A	dir/file
W: -empty_dir: dir/a
r2 = c7cb7b4d4365180d5e8008b247efba7cbb2613a3 (refs/remotes/alt)
	M	exec.sh
r3 = 5d528b2954a387fb4804137ab6fd20829a90a21c (refs/remotes/alt)
	M	exec.sh
r4 = 8b00511e65ab590e00babc4b5fd2cca88dd68202 (refs/remotes/alt)
	M	exec.sh
r5 = 2c3498c0659fcec8db0fb11901f22b604d63aef4 (refs/remotes/alt)
	M	bar/zzz
	A	exec-2.sh
r6 = 81736e5906738e41761c795e49f99743f1c00244 (refs/remotes/alt)
	M	exec-2.sh
r7 = 5098d81d13fd07e451327a52f22da679ab7c3b9f (refs/remotes/alt)
test_cmp:1: command not found: diff -u
* FAIL 15: test fetch functionality (svn => git) with alternate GIT_SVN_ID
	git svn init "$svnrepo" && git svn fetch &&
	     git rev-list --pretty=raw ${remotes_git_svn} | grep ^tree | uniq > a &&
	     git rev-list --pretty=raw remotes/alt | grep ^tree | uniq > b &&
	     test_cmp a b

* expecting success: test_cmp a expected
test_cmp:1: command not found: diff -u
* FAIL 16: check imported tree checksums expected tree checksums
	test_cmp a expected

* expecting success: 
        git config --add svn-remote.svn.fetch                               bar:refs/remotes/git-svn &&
	test_must_fail git svn migrate

Remote ref refs/remote/git-svn is tracked by
  "svn-remote.svn.fetch=bar:refs/remotes/git-svn"
and
  "svn-remote.svn.fetch=:refs/remotes/git-svn"
Please resolve this ambiguity in your git configuration file before continuing

*   ok 17: exit if remote refs are ambigious

* expecting success: 
        svnadmin create "${PWD}/svnrepo2" &&
        svn mkdir -m "mkdir bar" "${svnrepo}2/bar" &&
        git config --unset svn-remote.svn.fetch \
                                "^bar:refs/${remotes_git_svn}$" &&
	test_must_fail git svn init "${svnrepo}2/bar"
        

Committed revision 1.
svn-remote.svn.url already set: file:///home/nicolas/dev/official_packages/gitrepos/git/t/trash directory.test-lib/svnrepo
wanted to set to: file:///home/nicolas/dev/official_packages/gitrepos/git/t/trash directory.test-lib/svnrepo2/bar

*   ok 18: exit if init-ing a would clobber a URL

* expecting success: 
        git svn init --minimize-url -i bar "$svnrepo/bar" &&
        git config --get svn-remote.svn.fetch \
                              "^bar:refs/remotes/bar$" &&
        git config --get svn-remote.svn.fetch \
                              "^:refs/${remotes_git_svn}$"
        
Using existing [svn-remote "svn"]
Using higher level of URL: file:///home/nicolas/dev/official_packages/gitrepos/git/t/trash directory.test-lib/svnrepo/bar => file:///home/nicolas/dev/official_packages/gitrepos/git/t/trash directory.test-lib/svnrepo
bar:refs/remotes/bar
:refs/remotes/git-svn
*   ok 19: init allows us to connect to another directory in the same repo

* expecting success: 
	git svn fetch -i bar &&
	git checkout -b my-bar refs/remotes/bar &&
	echo 1 > foo &&
	git add foo &&
	git commit -m "change 1" &&
	echo 2 > foo &&
	git add foo &&
	git commit -m "change 2" &&
	old_head=$(git rev-parse HEAD) &&
	git svn dcommit -i bar HEAD^ &&
	test $old_head = $(git rev-parse HEAD) &&
	test refs/heads/my-bar = $(git symbolic-ref HEAD) &&
	git log refs/remotes/bar | grep "change 1" &&
	! git log refs/remotes/bar | grep "change 2" &&
	git checkout master &&
	git branch -D my-bar
	
	A	zzz
r1 = 02239329d31582d3ac50ea7db0743bb2fa64c2e7 (refs/remotes/bar)
	M	zzz
r6 = 9cc526b53cf6f77bdca1cda99885527af472a276 (refs/remotes/bar)
Switched to a new branch 'my-bar'
[my-bar c238936] change 1
 Author: A U Thor <author@example.com>
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 foo
[my-bar a01e587] change 2
 Author: A U Thor <author@example.com>
 1 files changed, 1 insertions(+), 1 deletions(-)
Committing to file:///home/nicolas/dev/official_packages/gitrepos/git/t/trash directory.test-lib/svnrepo/bar ...
	A	foo
Committed r8
	A	foo
r8 = ef862194088e082f60560ce6bf4058c33c384aaa (refs/remotes/bar)
No changes between current HEAD and refs/remotes/bar
Resetting to the latest refs/remotes/bar
dcommitted on a detached HEAD because you gave a revision argument.
The rewritten commit is: ef862194088e082f60560ce6bf4058c33c384aaa
    change 1
Switched to branch 'master'
Deleted branch my-bar (was a01e587).
*   ok 20: dcommit $rev does not clobber current branch

* expecting success: 
	git svn fetch -i bar &&
	git checkout -b my-bar refs/remotes/bar &&
	echo abc > d &&
	git update-index --add d &&
	git commit -m '/bar/d should be in the log' &&
	git svn dcommit -i bar &&
	test -z "`git diff refs/heads/my-bar refs/remotes/bar`" &&
	mkdir newdir &&
	echo new > newdir/dir &&
	git update-index --add newdir/dir &&
	git commit -m 'add a new directory' &&
	git svn dcommit -i bar &&
	test -z "`git diff refs/heads/my-bar refs/remotes/bar`" &&
	echo foo >> newdir/dir &&
	git update-index newdir/dir &&
	git commit -m 'modify a file in new directory' &&
	git svn dcommit -i bar &&
	test -z "`git diff refs/heads/my-bar refs/remotes/bar`"
	
	A	bar/foo
r8 = 490bfa0b7170d45ae4001a5afbe18c850276cff2 (refs/remotes/alt)
Switched to a new branch 'my-bar'
[my-bar 3ed5564] /bar/d should be in the log
 Author: A U Thor <author@example.com>
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 d
Committing to file:///home/nicolas/dev/official_packages/gitrepos/git/t/trash directory.test-lib/svnrepo/bar ...
	A	d
Committed r9
	A	d
r9 = 3183042ff13ded336c3f3fde238bc3901142e454 (refs/remotes/bar)
No changes between current HEAD and refs/remotes/bar
Resetting to the latest refs/remotes/bar
[my-bar ff72ce4] add a new directory
 Author: A U Thor <author@example.com>
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 newdir/dir
Committing to file:///home/nicolas/dev/official_packages/gitrepos/git/t/trash directory.test-lib/svnrepo/bar ...
	A	newdir/dir
Committed r10
	A	newdir/dir
r10 = e095f32f8a89045ff566f9f098f20470167e56ff (refs/remotes/bar)
No changes between current HEAD and refs/remotes/bar
Resetting to the latest refs/remotes/bar
[my-bar 1fe4815] modify a file in new directory
 Author: A U Thor <author@example.com>
 1 files changed, 1 insertions(+), 0 deletions(-)
Committing to file:///home/nicolas/dev/official_packages/gitrepos/git/t/trash directory.test-lib/svnrepo/bar ...
	M	newdir/dir
Committed r11
	M	newdir/dir
r11 = 4d83186c6ffd935735084bc924b16227f4515f5f (refs/remotes/bar)
No changes between current HEAD and refs/remotes/bar
Resetting to the latest refs/remotes/bar
*   ok 21: able to dcommit to a subdirectory

* expecting success: 
	echo cba > d &&
	git update-index d &&
	git commit -m 'update /bar/d' &&
	git svn set-tree -i bar HEAD &&
	test -z "`git diff refs/heads/my-bar refs/remotes/bar`"
	
[my-bar 41e3701] update /bar/d
 Author: A U Thor <author@example.com>
 1 files changed, 1 insertions(+), 1 deletions(-)
	M	d
	M	d
r12 = 999a30fff02df39afb024a80bcf73d029f8bb58f (refs/remotes/bar)
Done committing 1 revisions to SVN
*   ok 22: able to set-tree to a subdirectory

* expecting success: 
	mkdir bare-repo &&
	( cd bare-repo &&
	git init --bare &&
	GIT_DIR=. git svn init "$svnrepo" &&
	git svn fetch ) &&
	rm -rf bare-repo
	
Initialized empty Git repository in /home/nicolas/dev/official_packages/gitrepos/git/t/trash directory.test-lib/bare-repo/
	A	foo.link
	A	foo
	A	bar/zzz
	A	exec.sh
	A	dir/a/b/c/d/e/file
r1 = 7573d34cdf10b5542f8caa5298e01b279338e333 (refs/remotes/alt)
	A	file
	D	dir/a/b/c/d/e/file
	D	dir/a/
	A	dir/file
W: -empty_dir: dir/a
r2 = c7cb7b4d4365180d5e8008b247efba7cbb2613a3 (refs/remotes/alt)
	M	exec.sh
r3 = 5d528b2954a387fb4804137ab6fd20829a90a21c (refs/remotes/alt)
	M	exec.sh
r4 = 8b00511e65ab590e00babc4b5fd2cca88dd68202 (refs/remotes/alt)
	M	exec.sh
r5 = 2c3498c0659fcec8db0fb11901f22b604d63aef4 (refs/remotes/alt)
	M	bar/zzz
	A	exec-2.sh
r6 = 81736e5906738e41761c795e49f99743f1c00244 (refs/remotes/alt)
	M	exec-2.sh
r7 = 5098d81d13fd07e451327a52f22da679ab7c3b9f (refs/remotes/alt)
	A	bar/foo
r8 = 490bfa0b7170d45ae4001a5afbe18c850276cff2 (refs/remotes/alt)
	A	bar/d
r9 = 886d51e27ef561f5700a77ea2b92d16f8a432da1 (refs/remotes/alt)
	A	bar/newdir/dir
r10 = 99b162b8b7160a82b8f56cbb50f3d1ac0c7182e9 (refs/remotes/alt)
	M	bar/newdir/dir
r11 = 7d5433c53f679562f1896008fb000de39cf59c01 (refs/remotes/alt)
	M	bar/d
r12 = 13b90b1bb888796b71d8e98d775f0a9f5f5c5481 (refs/remotes/alt)
*   ok 23: git-svn works in a bare repository

* failed 3 among 23 test(s)

--bp/iNruPH9dso1Pn--

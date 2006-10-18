From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: t9100-git-svn-basic.sh fails
Date: Wed, 18 Oct 2006 10:59:49 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20061018085948.GA27357@cepheus.pub>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
X-From: git-owner@vger.kernel.org Wed Oct 18 10:54:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga7Bl-0001PW-C0
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 10:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWJRIyI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 04:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWJRIyI
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 04:54:08 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:3278 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S932132AbWJRIyF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 04:54:05 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1Ga7Bb-0004qT-18
	for git@vger.kernel.org; Wed, 18 Oct 2006 10:54:03 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.6/8.12.11) with ESMTP id k9I8rxhe008557
	for <git@vger.kernel.org>; Wed, 18 Oct 2006 10:53:59 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.6/8.12.11/Submit) id k9I8rnm5008550
	for git@vger.kernel.org; Wed, 18 Oct 2006 10:53:49 +0200 (MEST)
To: git@vger.kernel.org
Mail-Followup-To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29204>


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

zeisberg@cepheus:~$ uname -a
Linux cepheus 2.6.19-rc2-g51018b0a #17 SMP Mon Oct 16 12:51:05 CEST 2006 i686 GNU/Linux

zeisberg@cepheus:~$ dpkg -l subversion libsvn1 libapr1 libaprutil1 libdb4.4
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Installed/Config-files/Unpacked/Failed-config/Half-installed
|/ Err?=(none)/Hold/Reinst-required/X=both-problems (Status,Err: uppercase=bad)
||/ Name           Version        Description
+++-==============-==============-============================================
ii  libapr1        1.2.7-6        The Apache Portable Runtime Library
ii  libaprutil1    1.2.7+dfsg-2   The Apache Portable Runtime Utility Library
ii  libdb4.4       4.4.20-3       Berkeley v4.4 Database Libraries [runtime]
ii  libsvn1        1.4.0-5        Shared libraries used by Subversion
ii  subversion     1.4.0-5        Advanced version control system

zeisberg@cepheus:~/gsrc/git$ sh GIT-VERSION-GEN 
GIT_VERSION = 1.4.2.4.g3453

(BTW, why that:
zeisberg@cepheus:~/gsrc/git$ grep ^DEF_VER GIT-VERSION-GEN 
DEF_VER=v1.4.3.GIT
)

zeisberg@cepheus:~/gsrc/git/t$ sh t9100-git-svn-basic.sh 
Perl SVN libraries not found, tests requiring those will be skipped
define NO_SVN_TESTS to skip git-svn tests
*   ok 1: initialize git-svn
*   ok 2: import an SVN revision into git
*   ok 3: checkout from svn
*   ok 4: try a deep --rmdir with a commit
*   ok 5: detect node change from file to directory #1
*   ok 6: detect node change from directory to file #1
*   ok 7: detect node change from file to directory #2
*   ok 8: detect node change from directory to file #2
*   ok 9: remove executable bit from a file
*   ok 10: add executable bit back file
*   ok 11: executable file becomes a symlink to bar/zzz (file)
*   ok 12: new symlink is added to a file that was also just made executable
FATAL: Unexpected exit with code 9

There is a warning about installing SVN Perl libraries to get fewer
bugs.  Is that one of those?  Is that test failure already known?

The output of the verbose run is attached.

Best regards
Uwe

-- 
Uwe Zeisberger

http://www.google.com/search?q=i+squared

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="t9100-git-svn-basic-out.txt"

Perl SVN libraries not found, tests requiring those will be skipped
define NO_SVN_TESTS to skip git-svn tests
* expecting success: git-svn init file:///home/zeisberg/gsrc/git/t/trash/svnrepo/test-git-svn
*   ok 1: initialize git-svn

* expecting success: git-svn fetch
A    /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/tree/foo.link
A    /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/tree/foo
A    /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/tree/bar
A    /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/tree/bar/zzz
A    /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/tree/exec.sh
A    /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/tree/dir
A    /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/tree/dir/a
A    /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/tree/dir/a/b
A    /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/tree/dir/a/b/c
A    /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/tree/dir/a/b/c/d
A    /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/tree/dir/a/b/c/d/e
A    /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/tree/dir/a/b/c/d/e/file
Checked out revision 1.
r1 = efbb057bfd612e3cd1890112efd96b4a2e397d89
*   ok 2: import an SVN revision into git

* expecting success: svn co file:///home/zeisberg/gsrc/git/t/trash/svnrepo/test-git-svn /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/svn-tree
A    /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/svn-tree/foo.link
A    /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/svn-tree/foo
A    /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/svn-tree/bar
A    /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/svn-tree/bar/zzz
A    /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/svn-tree/exec.sh
A    /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/svn-tree/dir
A    /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/svn-tree/dir/a
A    /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/svn-tree/dir/a/b
A    /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/svn-tree/dir/a/b/c
A    /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/svn-tree/dir/a/b/c/d
A    /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/svn-tree/dir/a/b/c/d/e
A    /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/svn-tree/dir/a/b/c/d/e/file
Checked out revision 1.
*   ok 3: checkout from svn

* expecting success: git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch &&
     svn up /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/svn-tree &&
     test -d /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/svn-tree/dir && test ! -d /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/svn-tree/dir/a
diff-tree efbb057bfd612e3cd1890112efd96b4a2e397d89 78d4a6294c9d0dcac49c38ece1c1f20c74edcc68
A         dir/file
A         file
D         dir/a/b/c/d/e/file
D         dir/a/b/c/d/e/file
D         dir/a/b/c/d/e
D         dir/a/b/c/d/e/file
D         dir/a/b/c/d/e
D         dir/a/b/c/d
D         dir/a/b/c/d/e/file
D         dir/a/b/c/d/e
D         dir/a/b/c/d
D         dir/a/b/c
D         dir/a/b/c/d/e/file
D         dir/a/b/c/d/e
D         dir/a/b/c/d
D         dir/a/b/c
D         dir/a/b
D         dir/a/b/c/d/e/file
D         dir/a/b/c/d/e
D         dir/a/b/c/d
D         dir/a/b/c
D         dir/a/b
D         dir/a
Committing 78d4a6294c9d0dcac49c38ece1c1f20c74edcc68: try a deep --rmdir with a commit
At revision 2.
r2 = f303d50d91b0f8353e1c8950b04b74ad1da89074
Done committing 1 revisions to SVN
A    /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/svn-tree/file
D    /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/svn-tree/dir/a
A    /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/svn-tree/dir/file
Updated to revision 2.
*   ok 4: try a deep --rmdir with a commit

* expecting failure: git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch
diff-tree f303d50d91b0f8353e1c8950b04b74ad1da89074 c3711a70e5dfac068e95b43b0778dce17d3f3c53
*   ok 5: detect node change from file to directory #1

* expecting failure: git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch2
diff-tree f303d50d91b0f8353e1c8950b04b74ad1da89074 5eba97b4b68c76437c6a3dfd8c1712c235e6dbf1
*   ok 6: detect node change from directory to file #1

* expecting failure: git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch3
diff-tree f303d50d91b0f8353e1c8950b04b74ad1da89074 db5f4bce8265b9807ef76a92717af6a846c941dd
*   ok 7: detect node change from file to directory #2

* expecting failure: git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch4
diff-tree f303d50d91b0f8353e1c8950b04b74ad1da89074 97060150727530f2fa4b34e13ca83566501a0274
*   ok 8: detect node change from directory to file #2

* expecting success: git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch5 &&
     svn up /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/svn-tree &&
     test ! -x /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/svn-tree/exec.sh
diff-tree f303d50d91b0f8353e1c8950b04b74ad1da89074 f56cfd05f6959633698abb413a76e3879568fe6a
property 'svn:executable' deleted from 'exec.sh'.
Committing f56cfd05f6959633698abb413a76e3879568fe6a: remove executable bit from a file
At revision 3.
r3 = 150272d4f56833af23385f41289fa133fef9061d
Done committing 1 revisions to SVN
 U   /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/svn-tree/exec.sh
Updated to revision 3.
*   ok 9: remove executable bit from a file

* expecting success: git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch5 &&
     svn up /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/svn-tree &&
     test -x /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/svn-tree/exec.sh
diff-tree 150272d4f56833af23385f41289fa133fef9061d 835354f30dee357f2292e0d8457534d3c36a9ee0
property 'svn:executable' set on 'exec.sh'
Committing 835354f30dee357f2292e0d8457534d3c36a9ee0: add executable bit back file
At revision 4.
r4 = 5ff396d7d67dae86e0d031f10971bbd01c7dbc7a
Done committing 1 revisions to SVN
 U   /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/svn-tree/exec.sh
Updated to revision 4.
*   ok 10: add executable bit back file

* expecting success: git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch5 &&
	     svn up /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/svn-tree &&
	     test -L /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/svn-tree/exec.sh
diff-tree 5ff396d7d67dae86e0d031f10971bbd01c7dbc7a aecafe170fda3a28cffa283084038a78e0b9453a
D         exec.sh
A         exec.sh
Committing aecafe170fda3a28cffa283084038a78e0b9453a: executable file becomes a symlink to bar/zzz (file)
At revision 5.
r5 = b11753149d160cd083342368a6a817b67ebe5343
Done committing 1 revisions to SVN
D    /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/svn-tree/exec.sh
A    /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/svn-tree/exec.sh
Updated to revision 5.
*   ok 11: executable file becomes a symlink to bar/zzz (file)

* expecting success: git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch5 &&
	     svn up /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/svn-tree &&
	     test -x /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/svn-tree/bar/zzz &&
	     test -L /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/svn-tree/exec-2.sh
diff-tree b11753149d160cd083342368a6a817b67ebe5343 e68439578ed56b3c33137a4f1fb7f9f74a4c5abf
A         exec-2.sh
Committing e68439578ed56b3c33137a4f1fb7f9f74a4c5abf: new symlink is added to a file that was also just made executable
At revision 6.
r6 = 601ae0df2203d0b8c81774101d426b4b009b0f59
Done committing 1 revisions to SVN
A    /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/svn-tree/exec-2.sh
Updated to revision 6.
*   ok 12: new symlink is added to a file that was also just made executable

* expecting success: git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch5 &&
	     svn up /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/svn-tree &&
	     test -f /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/svn-tree/exec-2.sh &&
	     test ! -L /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/svn-tree/exec-2.sh &&
	     diff -u help /home/zeisberg/gsrc/git/t/trash/.git/svn/git-svn/svn-tree/exec-2.sh
diff-tree 601ae0df2203d0b8c81774101d426b4b009b0f59 69fa6b2e91eb2b7af80e86b4af01d6c539f0aa21
D         exec-2.sh
A         exec-2.sh
FATAL: Unexpected exit with code 9

--k+w/mQv8wyuph6w0--

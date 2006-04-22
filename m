From: "Tim O'Callaghan" <timo@dspsrv.com>
Subject: Problem with Git in Cygwin on x86-64 platform
Date: Sat, 22 Apr 2006 04:30:30 +0200
Message-ID: <20060422023029.GC2444@Zangband>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Apr 22 23:06:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXPIx-0007Tj-8z
	for gcvg-git@gmane.org; Sat, 22 Apr 2006 23:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWDVVFz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Apr 2006 17:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWDVVFz
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Apr 2006 17:05:55 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:62680 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751212AbWDVVFh (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Apr 2006 17:05:37 -0400
Received: from dspsrv.com (vir.dspsrv.com [193.120.211.34])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id k3M2VdZj031192
	for <git@vger.kernel.org>; Sat, 22 Apr 2006 02:31:40 GMT
Received: from [213.46.16.78] (helo=localhost)
	by dspsrv.com with asmtp (Exim 3.36 #1)
	id 1FX7tO-00023P-00
	for git@vger.kernel.org; Sat, 22 Apr 2006 03:30:38 +0100
To: git@vger.kernel.org
Mail-Followup-To: Tim O'Callaghan <timo@dspsrv.com>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: mutt-ng/devel-r655 (CYGWIN_NT-5.1)
X-Virus-Scanned: ClamAV 0.88/1414/Fri Apr 21 22:58:39 2006 on zeus1.kernel.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19061>

When running a 'make test' under cygwin on my 64bit machine, and got
the output below. The reason i cite the 64bit cygwin platform being a
difference is that i have run 'make test' on the exact same codebase
on a 32 bit machine. The only difference in compile environment is
that the cygwin install on the 64 bit machine is as of today, and the
32 bit machine was about three days ago.

----

*** t0000-basic.sh ***
*   ok 1: .git/objects should be empty after git-init-db in an empty repo.
*   ok 2: .git/objects should have 3 subdirectories.
*   ok 3: git-update-index without --add should fail adding.
*   ok 4: git-update-index with --add should succeed.
*   ok 5: writing tree out with git-write-tree
*   ok 6: validate object ID of a known tree.
*   ok 7: git-update-index without --remove should fail removing.
* FAIL 8: git-update-index with --remove should be able to remove.
        git-update-index --remove should-be-empty
*   ok 9: git-write-tree should be able to write an empty tree.
* FAIL 10: validate object ID of a known tree.
        test "$tree" = 4b825dc642cb6eb9a060e54bf8d69288fbee4904
* FAIL 11: adding various types of objects with git-update-index --add.
        find path* ! -type d -print | xargs git-update-index --add
*   ok 12: showing stage with git-ls-files --stage
* FAIL 13: validate git-ls-files output for a known tree.
        diff current expected
*   ok 14: writing tree out with git-write-tree.
* FAIL 15: validate object ID for a known tree.
        test "$tree" = 087704a96baf1c2d1c869a8b084481e121c88b5b
*   ok 16: showing tree with git-ls-tree
* FAIL 17: git-ls-tree output for a known tree.
        diff current expected
*   ok 18: showing tree with git-ls-tree -r
* FAIL 19: git-ls-tree -r output for a known tree.
        diff current expected
* FAIL 20: git-read-tree followed by write-tree should be idempotent.
        git-read-tree $tree &&
             test -f .git/index &&
             newtree=$(git-write-tree) &&
             test "$newtree" = "$tree"
* FAIL 21: validate git-diff-files output for a know cache/work tree state.
        git-diff-files >current && diff >/dev/null -b current expected
* FAIL 22: git-update-index --refresh should succeed.
        git-update-index --refresh
*   ok 23: no diff after checkout and git-update-index --refresh.
* failed 10 among 23 test(s)

-----

Any ideas on how to start tracking this one down?

Tim.

From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v8 16/16] Add a test script for remote-svn
Date: Wed, 19 Sep 2012 17:21:30 +0200
Message-ID: <1348068090-31988-17-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1348068090-31988-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1348068090-31988-16-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 17:23:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEM7j-0006Jl-HU
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 17:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754314Ab2ISPXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 11:23:16 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64575 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932153Ab2ISPXG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 11:23:06 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so596995bkw.19
        for <git@vger.kernel.org>; Wed, 19 Sep 2012 08:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=mpLbr1xuRweydZU1h+9wExh/NcubaTf4DQebPR/VME8=;
        b=BGMWhO4KmGqyzbayk7ZtZLDUokhaiXH26vnRa1jYaMOZh3VHfyh524SLR6z5NVVF64
         m37geMIt1AIuORHhKipgslxmUkobtIrZ8WxnfLKAHpgLV2eFxBdfc5Z47QkNhol6mDIv
         /A/XiNO+iW4cFI1nV/JPWRnSGROTCVx1ix6QhVtMHYxrfnuaybmbQ4a5J69xtjYJZE+H
         3dq6q8eXOkwWGpABDowSEciag/JZRZSmWTa7BrQ2sOtqleJzAOpJP2DUwbYfa/byhCzH
         62MxJluqOwiJo5zIDQH6y5UYIcebEAWLnL6AStVO1mO59U9AhHwt2YgV/qjvUTydOfwG
         HMvQ==
Received: by 10.204.148.15 with SMTP id n15mr1455558bkv.47.1348068186205;
        Wed, 19 Sep 2012 08:23:06 -0700 (PDT)
Received: from flobuntu.lan (91-115-94-56.adsl.highway.telekom.at. [91.115.94.56])
        by mx.google.com with ESMTPS id d13sm1570686bkw.12.2012.09.19.08.23.03
        (version=SSLv3 cipher=OTHER);
        Wed, 19 Sep 2012 08:23:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1348068090-31988-16-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205940>

Use svnrdump_sim.py to emulate svnrdump without an svn server.
Tests fetching, incremental fetching, fetching from file://,
and the regeneration of fast-import's marks file.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
diff:
- move pathname of marks file to a variable to compact the code.

 t/t9020-remote-svn.sh |   84 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100755 t/t9020-remote-svn.sh

diff --git a/t/t9020-remote-svn.sh b/t/t9020-remote-svn.sh
new file mode 100755
index 0000000..4f2dfe0
--- /dev/null
+++ b/t/t9020-remote-svn.sh
@@ -0,0 +1,84 @@
+#!/bin/sh
+
+test_description='tests remote-svn'
+
+. ./test-lib.sh
+
+MARKSPATH=.git/info/fast-import/remote-svn
+
+if ! test_have_prereq PYTHON
+then
+	skip_all='skipping remote-svn tests, python not available'
+	test_done
+fi
+
+# We override svnrdump by placing a symlink to the svnrdump-emulator in .
+export PATH="$HOME:$PATH"
+ln -sf $GIT_BUILD_DIR/contrib/svn-fe/svnrdump_sim.py "$HOME/svnrdump"
+
+init_git () {
+	rm -fr .git &&
+	git init &&
+	#git remote add svnsim testsvn::sim:///$TEST_DIRECTORY/t9020/example.svnrdump
+	# let's reuse an exisiting dump file!?
+	git remote add svnsim testsvn::sim://$TEST_DIRECTORY/t9154/svn.dump
+	git remote add svnfile testsvn::file://$TEST_DIRECTORY/t9154/svn.dump
+}
+
+if test -e "$GIT_BUILD_DIR/git-remote-testsvn"
+then
+	test_set_prereq REMOTE_SVN
+fi
+
+test_debug '
+	git --version
+	which git
+	which svnrdump
+'
+
+test_expect_success REMOTE_SVN 'simple fetch' '
+	init_git &&
+	git fetch svnsim &&
+	test_cmp .git/refs/svn/svnsim/master .git/refs/remotes/svnsim/master  &&
+	cp .git/refs/remotes/svnsim/master master.good
+'
+
+test_debug '
+	cat .git/refs/svn/svnsim/master
+	cat .git/refs/remotes/svnsim/master
+'
+
+test_expect_success REMOTE_SVN 'repeated fetch, nothing shall change' '
+	git fetch svnsim &&
+	test_cmp master.good .git/refs/remotes/svnsim/master
+'
+
+test_expect_success REMOTE_SVN 'fetch from a file:// url gives the same result' '
+	git fetch svnfile
+'
+
+test_expect_failure REMOTE_SVN 'the sha1 differ because the git-svn-id line in the commit msg contains the url' '
+	test_cmp .git/refs/remotes/svnfile/master .git/refs/remotes/svnsim/master
+'
+
+test_expect_success REMOTE_SVN 'mark-file regeneration' '
+	# filter out any other marks, that can not be regenerated. Only up to 3 digit revisions are allowed here
+	grep ":[0-9]\{1,3\} " $MARKSPATH/svnsim.marks > $MARKSPATH/svnsim.marks.old &&
+	rm $MARKSPATH/svnsim.marks &&
+	git fetch svnsim &&
+	test_cmp $MARKSPATH/svnsim.marks.old $MARKSPATH/svnsim.marks
+'
+
+test_expect_success REMOTE_SVN 'incremental imports must lead to the same head' '
+	export SVNRMAX=3 &&
+	init_git &&
+	git fetch svnsim &&
+	test_cmp .git/refs/svn/svnsim/master .git/refs/remotes/svnsim/master  &&
+	unset SVNRMAX &&
+	git fetch svnsim &&
+	test_cmp master.good .git/refs/remotes/svnsim/master
+'
+
+test_debug 'git branch -a'
+
+test_done
-- 
1.7.9.5

From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v7 16/16] Add a test script for remote-svn
Date: Tue, 28 Aug 2012 10:49:50 +0200
Message-ID: <1346143790-23491-17-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1346143790-23491-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-16-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Joachim Schmitz <jojo@schmitz-digital.de>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 28 10:52:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6HWr-0002Rb-JD
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 10:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220Ab2H1Ivi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 04:51:38 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:51578 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389Ab2H1Ivf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 04:51:35 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so1533185bkw.19
        for <git@vger.kernel.org>; Tue, 28 Aug 2012 01:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=F3tpmhsm0NRoXg0mxuha4D7NkpFjKoOyEBZI/ciayOU=;
        b=DYSCeYE0Tsvm1jqNNsdsLsoiBGr5ZCPc5fy/3ihZsNoXvXIa2ASLucSobC9X3xGUrj
         UTQzjXoTv6yr1hWyZUIovkH7PstJP6vScKxvqmU87moKTMKPbdGNNFZvIocElIHAIj61
         kOtPHMw9f8Pi5ndxwIT+m7ujHxxw7FLNcXuWiI8VTn3s/pPOUoi6VomBhjT0WWH1YcAL
         wOsuR+7jcunGeJfgf/HSejtVTGFpz/bcsD4zu2rIOaeYhGMtFyo1Q5TxKPbqvdiKXNW/
         sYCEQJvsb1MDF+svbZgKzpC8Usn3G3hgeXrhhqk0ksgW4heyB9TWPqi2ScuMZl3Z6IfM
         Vvgw==
Received: by 10.204.157.7 with SMTP id z7mr4742223bkw.14.1346143895124;
        Tue, 28 Aug 2012 01:51:35 -0700 (PDT)
Received: from flobuntu.lan (91-115-85-203.adsl.highway.telekom.at. [91.115.85.203])
        by mx.google.com with ESMTPS id m9sm12047800bkm.10.2012.08.28.01.51.32
        (version=SSLv3 cipher=OTHER);
        Tue, 28 Aug 2012 01:51:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1346143790-23491-16-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204417>

Use svnrdump_sim.py to emulate svnrdump without an svn server.
Tests fetching, incremental fetching, fetching from file://,
and the regeneration of fast-import's marks file.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9020-remote-svn.sh |   82 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100755 t/t9020-remote-svn.sh

diff --git a/t/t9020-remote-svn.sh b/t/t9020-remote-svn.sh
new file mode 100755
index 0000000..e6ed4ca
--- /dev/null
+++ b/t/t9020-remote-svn.sh
@@ -0,0 +1,82 @@
+#!/bin/sh
+
+test_description='tests remote-svn'
+
+. ./test-lib.sh
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
+	grep ":[0-9]\{1,3\} " .git/info/fast-import/remote-svn/svnsim.marks > .git/info/fast-import/remote-svn/svnsim.marks.old &&
+	rm .git/info/fast-import/remote-svn/svnsim.marks &&
+	git fetch svnsim &&
+	test_cmp .git/info/fast-import/remote-svn/svnsim.marks.old .git/info/fast-import/remote-svn/svnsim.marks
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

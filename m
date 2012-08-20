From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH v5 16/16] Add a test script for remote-svn
Date: Mon, 20 Aug 2012 23:52:22 +0200
Message-ID: <1345499542-15536-17-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345499542-15536-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-13-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-14-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499542-15536-16-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 23:53:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3Zuy-0008V9-5N
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 23:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756003Ab2HTVxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 17:53:44 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:57659 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755980Ab2HTVxe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 17:53:34 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so5688635wgb.1
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 14:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=QOjmIW8GaMbq8ClIal17mxRh6Jf6Lj86/J0HJr3kjWI=;
        b=LxLSfQTBbsMJ4k7Rjf5Hu0FeBHfdroXKhZo6vAPryBhv99PjLWz/qo8M9nrsg3OteE
         hcOR5NhgjQZ1+2Tb/Sv+VbvjA8nxUk3lGxmCFH1AYj1OcCdJh1g/ZBUtZdttwdT0nZgE
         PvTpTgsF88Lv3yEJ5OJm2axiBty9xnPJUkSun6dgYIDdljB1nPIZUa+Ag2LK/kD0FYw5
         8yTQarwTC4FqDsmMb8c0qafy/rIAmNYxTJY2mGvSgBZ/+odgtHYQ62akmBCvLcPq4bEv
         51CDokcFSlBjNwPMgu3v3kEPjnpZqHUUDRWNdrSMZmGdv5jXL0IK0c6xo0+51eYn5JZs
         Je+g==
Received: by 10.217.4.139 with SMTP id u11mr7755250wes.190.1345499613755;
        Mon, 20 Aug 2012 14:53:33 -0700 (PDT)
Received: from flomedio.lan (91-115-90-54.adsl.highway.telekom.at. [91.115.90.54])
        by mx.google.com with ESMTPS id w7sm30196654wiz.0.2012.08.20.14.53.32
        (version=SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 14:53:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345499542-15536-16-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203889>

Use svnrdump_sim.py to emulate svnrdump without an svn server.
Tests fetching, incremental fetching, fetching from file://,
and the regeneration of fast-import's marks file.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9020-remote-svn.sh |   76 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100755 t/t9020-remote-svn.sh

diff --git a/t/t9020-remote-svn.sh b/t/t9020-remote-svn.sh
new file mode 100755
index 0000000..9ae9997
--- /dev/null
+++ b/t/t9020-remote-svn.sh
@@ -0,0 +1,76 @@
+#!/bin/sh
+
+test_description='tests remote-svn'
+
+. ./test-lib.sh
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
+	git remote add svnsim testsvn::sim:///$TEST_DIRECTORY/t9154/svn.dump
+	git remote add svnfile testsvn::file:///$TEST_DIRECTORY/t9154/svn.dump
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

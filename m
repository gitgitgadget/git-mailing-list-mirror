From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 28/40] whitespace: remediate t9104-git-svn-follow-parent.sh
Date: Sat,  6 Aug 2011 18:44:42 +1000
Message-ID: <1312620294-18616-28-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:46:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcWy-0005WP-1L
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039Ab1HFIqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:46:22 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:53446 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755351Ab1HFIqK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:46:10 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so5182831iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=zCtvVewIkW1N0L+yzRbSC8RY6IBPS/xYhJNonXL1fgk=;
        b=mKGhobKKYgV1YeKVe7eFwOAr/UsqRd8yWFrR6MkGsFEb7x9Q1lofdD3WEU3Ic+buQS
         1iVJwMvOQ+japzJdzUSynJnrxSMFhp36sBpfuTtKyCJlUU0P7rIP4IOGnYQI5yeCEgJR
         ov/Qpsy1VeixebU1P1r/LnguQ/QqiKNQWECPs=
Received: by 10.42.165.2 with SMTP id i2mr3028864icy.387.1312620370667;
        Sat, 06 Aug 2011 01:46:10 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.46.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:46:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178865>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t9104-git-svn-follow-parent.sh |   88 +++++++++++++++++++-------------------
 1 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
index 13b179e..1ba69f4 100755
--- a/t/t9104-git-svn-follow-parent.sh
+++ b/t/t9104-git-svn-follow-parent.sh
@@ -32,57 +32,57 @@ test_expect_success 'init and fetch a moved directory' '
 	git svn init --minimize-url -i thunk "$svnrepo"/thunk &&
 	git svn fetch -i thunk &&
 	test "`git rev-parse --verify refs/remotes/thunk@2`" \
-           = "`git rev-parse --verify refs/remotes/thunk~1`" &&
-        test "`git cat-file blob refs/remotes/thunk:readme |\
-                 sed -n -e "3p"`" = goodbye &&
+	   = "`git rev-parse --verify refs/remotes/thunk~1`" &&
+	test "`git cat-file blob refs/remotes/thunk:readme |\
+		 sed -n -e "3p"`" = goodbye &&
 	test -z "`git config --get svn-remote.svn.fetch \
-	         "^trunk:refs/remotes/thunk@2$"`"
+		 "^trunk:refs/remotes/thunk@2$"`"
 	'
 
 test_expect_success 'init and fetch from one svn-remote' '
-        git config svn-remote.svn.url "$svnrepo" &&
-        git config --add svn-remote.svn.fetch \
-          trunk:refs/remotes/svn/trunk &&
-        git config --add svn-remote.svn.fetch \
-          thunk:refs/remotes/svn/thunk &&
-        git svn fetch -i svn/thunk &&
+	git config svn-remote.svn.url "$svnrepo" &&
+	git config --add svn-remote.svn.fetch \
+	  trunk:refs/remotes/svn/trunk &&
+	git config --add svn-remote.svn.fetch \
+	  thunk:refs/remotes/svn/thunk &&
+	git svn fetch -i svn/thunk &&
 	test "`git rev-parse --verify refs/remotes/svn/trunk`" \
-           = "`git rev-parse --verify refs/remotes/svn/thunk~1`" &&
-        test "`git cat-file blob refs/remotes/svn/thunk:readme |\
-                 sed -n -e "3p"`" = goodbye
-        '
+	   = "`git rev-parse --verify refs/remotes/svn/thunk~1`" &&
+	test "`git cat-file blob refs/remotes/svn/thunk:readme |\
+		 sed -n -e "3p"`" = goodbye
+	'
 
 test_expect_success 'follow deleted parent' '
-        (svn_cmd cp -m "resurrecting trunk as junk" \
-               "$svnrepo"/trunk@2 "$svnrepo"/junk ||
-         svn cp -m "resurrecting trunk as junk" \
-               -r2 "$svnrepo"/trunk "$svnrepo"/junk) &&
-        git config --add svn-remote.svn.fetch \
-          junk:refs/remotes/svn/junk &&
-        git svn fetch -i svn/thunk &&
-        git svn fetch -i svn/junk &&
-        test -z "`git diff svn/junk svn/trunk`" &&
-        test "`git merge-base svn/junk svn/trunk`" \
-           = "`git rev-parse svn/trunk`"
-        '
+	(svn_cmd cp -m "resurrecting trunk as junk" \
+	       "$svnrepo"/trunk@2 "$svnrepo"/junk ||
+	 svn cp -m "resurrecting trunk as junk" \
+	       -r2 "$svnrepo"/trunk "$svnrepo"/junk) &&
+	git config --add svn-remote.svn.fetch \
+	  junk:refs/remotes/svn/junk &&
+	git svn fetch -i svn/thunk &&
+	git svn fetch -i svn/junk &&
+	test -z "`git diff svn/junk svn/trunk`" &&
+	test "`git merge-base svn/junk svn/trunk`" \
+	   = "`git rev-parse svn/trunk`"
+	'
 
 test_expect_success 'follow larger parent' '
-        mkdir -p import/trunk/thunk/bump/thud &&
-        echo hi > import/trunk/thunk/bump/thud/file &&
-        svn import -m "import a larger parent" import "$svnrepo"/larger-parent &&
-        svn cp -m "hi" "$svnrepo"/larger-parent "$svnrepo"/another-larger &&
-        git svn init --minimize-url -i larger \
-          "$svnrepo"/another-larger/trunk/thunk/bump/thud &&
-        git svn fetch -i larger &&
-        git rev-parse --verify refs/remotes/larger &&
-        git rev-parse --verify \
-           refs/remotes/larger-parent/trunk/thunk/bump/thud &&
-        test "`git merge-base \
-                 refs/remotes/larger-parent/trunk/thunk/bump/thud \
-                 refs/remotes/larger`" = \
-             "`git rev-parse refs/remotes/larger`"
-        true
-        '
+	mkdir -p import/trunk/thunk/bump/thud &&
+	echo hi > import/trunk/thunk/bump/thud/file &&
+	svn import -m "import a larger parent" import "$svnrepo"/larger-parent &&
+	svn cp -m "hi" "$svnrepo"/larger-parent "$svnrepo"/another-larger &&
+	git svn init --minimize-url -i larger \
+	  "$svnrepo"/another-larger/trunk/thunk/bump/thud &&
+	git svn fetch -i larger &&
+	git rev-parse --verify refs/remotes/larger &&
+	git rev-parse --verify \
+	   refs/remotes/larger-parent/trunk/thunk/bump/thud &&
+	test "`git merge-base \
+		 refs/remotes/larger-parent/trunk/thunk/bump/thud \
+		 refs/remotes/larger`" = \
+	     "`git rev-parse refs/remotes/larger`"
+	true
+	'
 
 test_expect_success 'follow higher-level parent' '
 	svn mkdir -m "follow higher-level parent" "$svnrepo"/blob &&
@@ -96,8 +96,8 @@ test_expect_success 'follow higher-level parent' '
 	svn mkdir -m "new glob at top level" "$svnrepo"/glob &&
 	svn mv -m "move blob down a level" "$svnrepo"/blob "$svnrepo"/glob/blob &&
 	git svn init --minimize-url -i blob "$svnrepo"/glob/blob &&
-        git svn fetch -i blob
-        '
+	git svn fetch -i blob
+	'
 
 test_expect_success 'follow deleted directory' '
 	svn_cmd mv -m "bye!" "$svnrepo"/glob/blob/hi "$svnrepo"/glob/blob/bye &&
-- 
1.7.6.362.gf0e6

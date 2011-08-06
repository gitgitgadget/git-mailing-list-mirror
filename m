From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 27/40] whitespace: remediate t9100-git-svn-basic.sh
Date: Sat,  6 Aug 2011 18:44:41 +1000
Message-ID: <1312620294-18616-27-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:47:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcXP-0005kJ-MT
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755979Ab1HFIrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:47:00 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:43546 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755216Ab1HFIqI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:46:08 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so5183461iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=EiAoq/B/CxPJpRS1kvkYRqXW+wpZgEFctk5m5k8sxNE=;
        b=H/jMeLy7soNKrOIefffVFft7yj4s1adukDetWQJFooitMgwz9c1k6M80TYFE0dfA+P
         SUOZVApuALrDDeOiwa7Y4A+IgIzgJCHP1Yd8YLUO20fxk9tuuAeifW1U1X61a4SjxVXA
         cjp5F1qJHqV3SlvmmpjSHimJB6gqCmp63YVrU=
Received: by 10.231.35.73 with SMTP id o9mr942295ibd.46.1312620368343;
        Sat, 06 Aug 2011 01:46:08 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.46.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:46:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178871>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t9100-git-svn-basic.sh |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index b041516..225d88b 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -210,27 +210,27 @@ EOF
 test_expect_success "$name" "test_cmp a expected"
 
 test_expect_success 'exit if remote refs are ambigious' "
-        git config --add svn-remote.svn.fetch \
-                              bar:refs/${remotes_git_svn} &&
+	git config --add svn-remote.svn.fetch \
+			      bar:refs/${remotes_git_svn} &&
 	test_must_fail git svn migrate
 "
 
 test_expect_success 'exit if init-ing a would clobber a URL' '
-        svnadmin create "${PWD}/svnrepo2" &&
-        svn mkdir -m "mkdir bar" "${svnrepo}2/bar" &&
-        git config --unset svn-remote.svn.fetch \
-                                "^bar:refs/${remotes_git_svn}$" &&
+	svnadmin create "${PWD}/svnrepo2" &&
+	svn mkdir -m "mkdir bar" "${svnrepo}2/bar" &&
+	git config --unset svn-remote.svn.fetch \
+				"^bar:refs/${remotes_git_svn}$" &&
 	test_must_fail git svn init "${svnrepo}2/bar"
-        '
+	'
 
 test_expect_success \
   'init allows us to connect to another directory in the same repo' '
-        git svn init --minimize-url -i bar "$svnrepo/bar" &&
-        git config --get svn-remote.svn.fetch \
-                              "^bar:refs/remotes/bar$" &&
-        git config --get svn-remote.svn.fetch \
-                              "^:refs/${remotes_git_svn}$"
-        '
+	git svn init --minimize-url -i bar "$svnrepo/bar" &&
+	git config --get svn-remote.svn.fetch \
+			      "^bar:refs/remotes/bar$" &&
+	git config --get svn-remote.svn.fetch \
+			      "^:refs/${remotes_git_svn}$"
+	'
 
 test_expect_success 'dcommit $rev does not clobber current branch' '
 	git svn fetch -i bar &&
-- 
1.7.6.362.gf0e6

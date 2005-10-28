From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] fix testsuite to tolerate spaces in path
Date: Thu, 27 Oct 2005 23:00:43 -0400
Message-ID: <1130468443.2186.31.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Oct 28 05:01:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVKUD-0003Hv-Oz
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 05:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965072AbVJ1DAx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 23:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965073AbVJ1DAx
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 23:00:53 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:1256 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S965072AbVJ1DAw
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 23:00:52 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EVKU0-00015P-OR
	for git@vger.kernel.org; Thu, 27 Oct 2005 23:00:45 -0400
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EVKTz-0000C6-QZ
	for git@vger.kernel.org; Thu, 27 Oct 2005 23:00:43 -0400
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10750>

This patch allows the testsuite to run properly when the full path to
the git sources contains spaces or other symbols that need to be quoted.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 96db98b..5b50536 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -49,7 +49,7 @@ test_expect_success \
      git-unpack-objects <test-1-${packname_1}.pack"
 
 unset GIT_OBJECT_DIRECTORY
-cd $TRASH/.git2
+cd "$TRASH/.git2"
 
 test_expect_success \
     'check unpack without delta' \
@@ -61,7 +61,7 @@ test_expect_success \
 	     return 1
 	 }
      done'
-cd $TRASH
+cd "$TRASH"
 
 test_expect_success \
     'pack with delta' \
@@ -80,7 +80,7 @@ test_expect_success \
      git-unpack-objects <test-2-${packname_2}.pack'
 
 unset GIT_OBJECT_DIRECTORY
-cd $TRASH/.git2
+cd "$TRASH/.git2"
 test_expect_success \
     'check unpack with delta' \
     '(cd ../.git && find objects -type f -print) |
@@ -91,7 +91,7 @@ test_expect_success \
 	     return 1
 	 }
      done'
-cd $TRASH
+cd "$TRASH"
 
 rm -fr .git2
 mkdir .git2


-- 
Regards,
Pavel Roskin

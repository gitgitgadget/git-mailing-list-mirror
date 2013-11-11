From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH 2/7] test-bzr.sh, test-hg.sh: allow running from any dir
Date: Sun, 10 Nov 2013 23:05:07 -0500
Message-ID: <1384142712-2936-3-git-send-email-rhansen@bbn.com>
References: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
Cc: felipe.contreras@gmail.com, Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 11 05:08:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vfin9-00042U-VZ
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 05:08:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925Ab3KKEH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Nov 2013 23:07:57 -0500
Received: from smtp.bbn.com ([128.33.1.81]:23765 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751762Ab3KKEHz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Nov 2013 23:07:55 -0500
Received: from socket.bbn.com ([192.1.120.102]:44755)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Vfin4-000JVB-3X; Sun, 10 Nov 2013 23:07:54 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 69B1E3FF72
X-Mailer: git-send-email 1.8.5.rc1.207.gc17dd22
In-Reply-To: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237599>

cd to the t/ subdirectory so that the user doesn't already have to be
in the test directory to run these test scripts.

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 contrib/remote-helpers/test-bzr.sh | 1 +
 contrib/remote-helpers/test-hg.sh  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helpers/test-bzr.sh
index 5c50251..094062c 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -5,6 +5,7 @@
 
 test_description='Test remote-bzr'
 
+cd "${0%/*}"/../../t || exit 1
 . ./test-lib.sh
 
 if ! test_have_prereq PYTHON
diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 72f745d..dbe0eec 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -8,6 +8,7 @@
 
 test_description='Test remote-hg'
 
+cd "${0%/*}"/../../t || exit 1
 . ./test-lib.sh
 
 if ! test_have_prereq PYTHON
-- 
1.8.5.rc1.207.gc17dd22

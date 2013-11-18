From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v3 3/9] test-bzr.sh, test-hg.sh: allow running from any dir
Date: Sun, 17 Nov 2013 23:12:44 -0500
Message-ID: <1384747970-25481-4-git-send-email-rhansen@bbn.com>
References: <1384235688-9655-1-git-send-email-rhansen@bbn.com>
 <1384747970-25481-1-git-send-email-rhansen@bbn.com>
Cc: git@vger.kernel.org, felipe.contreras@gmail.com,
	Richard Hansen <rhansen@bbn.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 18 05:13:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViGDR-00040D-M0
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 05:13:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416Ab3KREN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Nov 2013 23:13:29 -0500
Received: from smtp.bbn.com ([128.33.1.81]:12029 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751343Ab3KRENX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Nov 2013 23:13:23 -0500
Received: from socket.bbn.com ([192.1.120.102]:45048)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1ViGD9-000PlI-Ml; Sun, 17 Nov 2013 23:13:19 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id E36883FFEF
X-Mailer: git-send-email 1.8.5.rc1.208.g8ff7964
In-Reply-To: <1384747970-25481-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237970>

From: Felipe Contreras <felipe.contreras@gmail.com>

Set TEST_DIRECTORY to the t/ directory (if TEST_DIRECTORY is not
already set) so that the user doesn't already have to be in the test
directory to run these test scripts.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Based-on-patch-by: Richard Hansen <rhansen@bbn.com>
Reviewed-by: Richard Hansen <rhansen@bbn.com>
Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 contrib/remote-helpers/test-bzr.sh | 3 ++-
 contrib/remote-helpers/test-hg.sh  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helpers/test-bzr.sh
index 5c50251..1e850c3 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -5,7 +5,8 @@
 
 test_description='Test remote-bzr'
 
-. ./test-lib.sh
+test -n "$TEST_DIRECTORY" || TEST_DIRECTORY=${0%/*}/../../t
+. "$TEST_DIRECTORY"/test-lib.sh
 
 if ! test_have_prereq PYTHON
 then
diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 72f745d..fa7d17b 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -8,7 +8,8 @@
 
 test_description='Test remote-hg'
 
-. ./test-lib.sh
+test -n "$TEST_DIRECTORY" || TEST_DIRECTORY=${0%/*}/../../t
+. "$TEST_DIRECTORY"/test-lib.sh
 
 if ! test_have_prereq PYTHON
 then
-- 
1.8.5.rc1.208.g8ff7964

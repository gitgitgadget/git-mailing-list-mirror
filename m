From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v3 0/9] remote-hg, remote-bzr fixes
Date: Sun, 17 Nov 2013 23:12:41 -0500
Message-ID: <1384747970-25481-1-git-send-email-rhansen@bbn.com>
References: <1384235688-9655-1-git-send-email-rhansen@bbn.com>
Cc: git@vger.kernel.org, felipe.contreras@gmail.com,
	Richard Hansen <rhansen@bbn.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 18 05:13:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViGDH-0003vc-MO
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 05:13:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363Ab3KRENX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Nov 2013 23:13:23 -0500
Received: from smtp.bbn.com ([128.33.0.80]:42891 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750992Ab3KRENV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Nov 2013 23:13:21 -0500
Received: from socket.bbn.com ([192.1.120.102]:57932)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1ViGD7-0009cY-21; Sun, 17 Nov 2013 23:13:17 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 3B0883FFEF
X-Mailer: git-send-email 1.8.5.rc1.208.g8ff7964
In-Reply-To: <1384235688-9655-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237966>

A handful of fixes for the git-remote-hg and git-remote-bzr remote
helpers and their unit tests.

Changes from v2:
  * changed the author on the following patches to Felipe Contreras:
    - [2/9] test-lib.sh: convert $TEST_DIRECTORY to an absolute path
    - [3/9] test-bzr.sh, test-hg.sh: allow running from any dir
  * added 'Reviewed-by: Felipe Contreras <felipe.contreras@gmail.com>'
    to the other patches
  * made the following comment change:

diff --git a/t/test-lib.sh b/t/test-lib.sh
index af172d9..d303e6c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -28,7 +28,7 @@ then
 	TEST_DIRECTORY=$(pwd)
 else
 	# ensure that TEST_DIRECTORY is an absolute path so that it
-	# works even if the current working directory is changed
+	# is valid even if the current working directory is changed
 	TEST_DIRECTORY=$(cd "$TEST_DIRECTORY" && pwd) || exit 1
 fi
 if test -z "$TEST_OUTPUT_DIRECTORY"

Felipe Contreras (2):
  test-lib.sh: convert $TEST_DIRECTORY to an absolute path
  test-bzr.sh, test-hg.sh: allow running from any dir

Richard Hansen (7):
  remote-hg:  don't decode UTF-8 paths into Unicode objects
  test-bzr.sh, test-hg.sh: prepare for change to push.default=simple
  test-hg.sh: eliminate 'local' bashism
  test-hg.sh: avoid obsolete 'test' syntax
  test-hg.sh: fix duplicate content strings in author tests
  test-hg.sh: help user correlate verbose output with email test
  remote-bzr, remote-hg: fix email address regular expression

 contrib/remote-helpers/git-remote-bzr |  7 +++----
 contrib/remote-helpers/git-remote-hg  |  9 ++++-----
 contrib/remote-helpers/test-bzr.sh    |  5 +++--
 contrib/remote-helpers/test-hg.sh     | 30 ++++++++++++++++--------------
 t/test-lib.sh                         |  4 ++++
 5 files changed, 30 insertions(+), 25 deletions(-)

-- 
1.8.5.rc1.208.g8ff7964

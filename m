From: Dan Williams <dan.j.williams@intel.com>
Subject: [StGit PATCH] mail: add some commonly used tags to --auto
Date: Wed, 03 Dec 2008 11:51:22 -0700
Message-ID: <20081203185122.6977.91624.stgit@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Wed Dec 03 19:53:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7wqU-0002G9-96
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 19:53:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbYLCSve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 13:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbYLCSve
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 13:51:34 -0500
Received: from mga03.intel.com ([143.182.124.21]:44928 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751536AbYLCSvd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 13:51:33 -0500
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101.ch.intel.com with ESMTP; 03 Dec 2008 10:51:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.33,709,1220252400"; 
   d="scan'208";a="86077743"
Received: from dwillia2-linux.ch.intel.com (HELO dwillia2-linux.localdomain) ([10.2.42.224])
  by azsmga001.ch.intel.com with ESMTP; 03 Dec 2008 10:51:23 -0800
Received: from dwillia2-linux.ch.intel.com (localhost.localdomain [127.0.0.1])
	by dwillia2-linux.localdomain (Postfix) with ESMTP id 88BCD248B69;
	Wed,  3 Dec 2008 11:51:22 -0700 (MST)
User-Agent: StGit/0.14.3.288.g123b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102277>

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 stgit/commands/mail.py |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index 72d0133..2dd88c3 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -283,8 +283,17 @@ def __get_signers_list(msg):
     acked-by lines in the message.
     """
     addr_list = []
-
-    r = re.compile('^(signed-off-by|acked-by|cc):\s+(.+)$', re.I)
+    tags = '%s|%s|%s|%s|%s|%s|%s' % (
+            'signed-off-by',
+            'acked-by',
+            'cc',
+            'reviewed-by',
+            'reported-by',
+            'tested-by',
+            'reported-and-tested-by')
+    regex = '^(%s):\s+(.+)$' % tags
+
+    r = re.compile(regex, re.I)
     for line in msg.split('\n'):
         m = r.match(line)
         if m:

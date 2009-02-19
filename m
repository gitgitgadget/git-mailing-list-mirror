From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 6/8] Test log --decorate
Date: Thu, 19 Feb 2009 12:13:40 +0100
Message-ID: <e7a3131051b18403c111d0f202544bd3a8822979.1235041345.git.trast@student.ethz.ch>
References: <cover.1235041345.git.trast@student.ethz.ch>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 12:16:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La6sy-0000Pm-6b
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 12:16:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383AbZBSLON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 06:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752906AbZBSLOM
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 06:14:12 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:16533 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751712AbZBSLOI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 06:14:08 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 19 Feb 2009 12:13:53 +0100
Received: from localhost.localdomain ([129.132.153.233]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 19 Feb 2009 12:13:52 +0100
X-Mailer: git-send-email 1.6.2.rc1.266.gce6c4
In-Reply-To: <cover.1235041345.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 19 Feb 2009 11:13:52.0868 (UTC) FILETIME=[25C30A40:01C99283]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110678>

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Same as v1.

 t/t4013-diff-various.sh           |    1 +
 t/t4013/diff.log_--decorate_--all |   34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 0 deletions(-)
 create mode 100644 t/t4013/diff.log_--decorate_--all

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 0289336..ef16f69 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -207,6 +207,7 @@ log --root -c --patch-with-stat --summary master
 log --root --cc --patch-with-stat --summary master
 log -SF master
 log -SF -p master
+log --decorate --all
 
 whatchanged master
 whatchanged -p master
diff --git a/t/t4013/diff.log_--decorate_--all b/t/t4013/diff.log_--decorate_--all
new file mode 100644
index 0000000..12da8ac
--- /dev/null
+++ b/t/t4013/diff.log_--decorate_--all
@@ -0,0 +1,34 @@
+$ git log --decorate --all
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (refs/heads/master)
+Merge: 9a6d494 c7a2ab9
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:04:00 2006 +0000
+
+    Merge branch 'side'
+
+commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a (refs/heads/side)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:03:00 2006 +0000
+
+    Side
+
+commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:02:00 2006 +0000
+
+    Third
+
+commit 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:01:00 2006 +0000
+
+    Second
+    
+    This is the second commit.
+
+commit 444ac553ac7612cc88969031b02b3767fb8a353a (refs/heads/initial)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:00:00 2006 +0000
+
+    Initial
+$
-- 
1.6.2.rc1.266.gce6c4

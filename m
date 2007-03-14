From: Don Zickus <dzickus@redhat.com>
Subject: [PATCH 4/5] Add a couple more test cases to the suite.
Date: Wed, 14 Mar 2007 16:12:25 -0400
Message-ID: <11739031473249-git-send-email-dzickus@redhat.com>
References: <11739031463211-git-send-email-dzickus@redhat.com>
Cc: Don Zickus <dzickus@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 14 21:14:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRZrD-0003IB-Jn
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 21:13:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933100AbXCNUNz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 16:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933120AbXCNUNz
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 16:13:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38211 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933100AbXCNUNx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 16:13:53 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l2EKDrjv014190
	for <git@vger.kernel.org>; Wed, 14 Mar 2007 16:13:53 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l2EKDqDR025158
	for <git@vger.kernel.org>; Wed, 14 Mar 2007 16:13:53 -0400
Received: from drseuss.boston.redhat.com (drseuss.boston.redhat.com [172.16.80.234])
	by mail.boston.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l2EKDqMl007063;
	Wed, 14 Mar 2007 16:13:52 -0400
Received: from drseuss.boston.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.boston.redhat.com (8.13.7/8.13.4) with ESMTP id l2EKCRgo009155;
	Wed, 14 Mar 2007 16:12:27 -0400
Received: (from dzickus@localhost)
	by drseuss.boston.redhat.com (8.13.7/8.13.7/Submit) id l2EKCRjK009154;
	Wed, 14 Mar 2007 16:12:27 -0400
X-Mailer: git-send-email 1.5.0.2.213.g18c8-dirty
In-Reply-To: <11739031463211-git-send-email-dzickus@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42222>

They handle cases where there is no attached patch.

Signed-off-by: Don Zickus <dzickus@redhat.com>
---
 t/t5100-mailinfo.sh |    2 +-
 t/t5100/info0007    |    5 +++++
 t/t5100/info0008    |    5 +++++
 t/t5100/msg0007     |    2 ++
 t/t5100/msg0008     |    4 ++++
 t/t5100/sample.mbox |   18 ++++++++++++++++++
 6 files changed, 35 insertions(+), 1 deletions(-)
 create mode 100644 t/t5100/info0007
 create mode 100644 t/t5100/info0008
 create mode 100644 t/t5100/msg0007
 create mode 100644 t/t5100/msg0008
 create mode 100644 t/t5100/patch0007
 create mode 100644 t/t5100/patch0008

diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index 4d2b781..ca96918 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -11,7 +11,7 @@ test_expect_success 'split sample box' \
 	'git-mailsplit -o. ../t5100/sample.mbox >last &&
 	last=`cat last` &&
 	echo total is $last &&
-	test `cat last` = 6'
+	test `cat last` = 8'
 
 for mail in `echo 00*`
 do
diff --git a/t/t5100/info0007 b/t/t5100/info0007
new file mode 100644
index 0000000..49bb0fe
--- /dev/null
+++ b/t/t5100/info0007
@@ -0,0 +1,5 @@
+Author: A U Thor
+Email: a.u.thor@example.com
+Subject: another patch
+Date: Fri, 9 Jun 2006 00:44:16 -0700
+
diff --git a/t/t5100/info0008 b/t/t5100/info0008
new file mode 100644
index 0000000..e8a2951
--- /dev/null
+++ b/t/t5100/info0008
@@ -0,0 +1,5 @@
+Author: Junio C Hamano
+Email: junio@kernel.org
+Subject: another patch
+Date: Fri, 9 Jun 2006 00:44:16 -0700
+
diff --git a/t/t5100/msg0007 b/t/t5100/msg0007
new file mode 100644
index 0000000..71b23c0
--- /dev/null
+++ b/t/t5100/msg0007
@@ -0,0 +1,2 @@
+Here is an empty patch from A U Thor.
+
diff --git a/t/t5100/msg0008 b/t/t5100/msg0008
new file mode 100644
index 0000000..a80ecb9
--- /dev/null
+++ b/t/t5100/msg0008
@@ -0,0 +1,4 @@
+>Here is an empty patch from A U Thor.
+
+Hey you forgot the patch!
+
diff --git a/t/t5100/patch0007 b/t/t5100/patch0007
new file mode 100644
index 0000000..e69de29
diff --git a/t/t5100/patch0008 b/t/t5100/patch0008
new file mode 100644
index 0000000..e69de29
diff --git a/t/t5100/sample.mbox b/t/t5100/sample.mbox
index 86bfc27..b80c981 100644
--- a/t/t5100/sample.mbox
+++ b/t/t5100/sample.mbox
@@ -386,3 +386,21 @@ index 9123cdc..918dcf8 100644
 -- 
 1.4.0.g6f2b
 
+From nobody Mon Sep 17 00:00:00 2001
+From: A U Thor <a.u.thor@example.com>
+Date: Fri, 9 Jun 2006 00:44:16 -0700
+Subject: [PATCH] another patch
+
+Here is an empty patch from A U Thor.
+
+From nobody Mon Sep 17 00:00:00 2001
+From: Junio C Hamano <junio@kernel.org>
+Date: Fri, 9 Jun 2006 00:44:16 -0700
+Subject: re: [PATCH] another patch
+
+From: A U Thor <a.u.thor@example.com>
+Subject: [PATCH] another patch
+>Here is an empty patch from A U Thor.
+
+Hey you forgot the patch!
+
-- 
1.5.0.2.211.g2ca9-dirty

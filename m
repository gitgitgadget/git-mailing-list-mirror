From: Don Zickus <dzickus@redhat.com>
Subject: [PATCH 4/5] Add a couple more test cases to the suite.
Date: Tue,  6 Mar 2007 16:57:42 -0500
Message-ID: <11732182641895-git-send-email-dzickus@redhat.com>
References: <1173218263315-git-send-email-dzickus@redhat.com> <11732182643385-git-send-email-dzickus@redhat.com> <117321826466-git-send-email-dzickus@redhat.com>
Cc: Don Zickus <dzickus@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 06 22:59:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOhhJ-0007Zu-2i
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 22:59:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030359AbXCFV7Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 16:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030369AbXCFV7Q
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 16:59:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49733 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030363AbXCFV7L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 16:59:11 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l26LxAIc007014
	for <git@vger.kernel.org>; Tue, 6 Mar 2007 16:59:10 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l26Lx9iN013048
	for <git@vger.kernel.org>; Tue, 6 Mar 2007 16:59:09 -0500
Received: from drseuss.boston.redhat.com (drseuss.boston.redhat.com [172.16.80.234])
	by mail.boston.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l26Lx8kx007411;
	Tue, 6 Mar 2007 16:59:08 -0500
Received: from drseuss.boston.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.boston.redhat.com (8.13.7/8.13.4) with ESMTP id l26LviiY007898;
	Tue, 6 Mar 2007 16:57:44 -0500
Received: (from dzickus@localhost)
	by drseuss.boston.redhat.com (8.13.7/8.13.7/Submit) id l26LviNc007897;
	Tue, 6 Mar 2007 16:57:44 -0500
X-Mailer: git-send-email 1.5.0.2.212.gd52f-dirty
In-Reply-To: <117321826466-git-send-email-dzickus@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41601>

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
1.5.0.2.212.gd52f-dirty

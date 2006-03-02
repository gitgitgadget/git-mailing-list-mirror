From: "Aneesh Kumar K.V" <aneesh.kumar@hp.com>
Subject: gitview:  Use horizontal scroll bar in the tree view
Date: Thu, 2 Mar 2006 09:59:53 +0530
Message-ID: <20060302042953.GA6919@satan.india.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 02 05:30:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEfRw-0006Mf-V6
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 05:30:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWCBE36 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 23:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbWCBE36
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 23:29:58 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:42388 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1750854AbWCBE35 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 23:29:57 -0500
Received: from localhost (unknown [15.76.101.80])
	by atlrel8.hp.com (Postfix) with ESMTP id 58F5334F65;
	Wed,  1 Mar 2006 23:29:56 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: mutt-ng/devel-r655 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17047>


From: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
Subject: gitview:  Use horizontal scroll bar in the tree view

Earlier we set up the window to never scroll
horizontally, which made it harder to use on a narrow screen.
This patch allows scrollbar to be used as needed by Gtk

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>

---

 contrib/gitview/gitview |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

d08429a55c3c4fb565cc3481e1263d04ecafebdd
diff --git a/contrib/gitview/gitview b/contrib/gitview/gitview
index ea05cd4..de9f3f3 100755
--- a/contrib/gitview/gitview
+++ b/contrib/gitview/gitview
@@ -513,7 +513,7 @@ class GitView:
 
 
 		scrollwin = gtk.ScrolledWindow()
-		scrollwin.set_policy(gtk.POLICY_NEVER, gtk.POLICY_AUTOMATIC)
+		scrollwin.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
 		scrollwin.set_shadow_type(gtk.SHADOW_IN)
 		vbox.pack_start(scrollwin, expand=True, fill=True)
 		scrollwin.show()
@@ -526,9 +526,6 @@ class GitView:
 		self.treeview.show()
 
 		cell = CellRendererGraph()
-		#  Set the default width to 265
-		#  This make sure that we have nice display with large tag names
-		cell.set_property("width", 265)
 		column = gtk.TreeViewColumn()
 		column.set_resizable(True)
 		column.pack_start(cell, expand=True)
-- 
1.2.3.gc55f-dirty

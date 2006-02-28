From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: gitview: Some  window layout changes.
Date: Tue, 28 Feb 2006 19:12:18 +0530
Message-ID: <4404533A.5070906@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000106080409040408060301"
X-From: git-owner@vger.kernel.org Tue Feb 28 14:42:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FE57T-0005eW-PU
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 14:42:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWB1NmZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 08:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWB1NmZ
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 08:42:25 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:60489 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750798AbWB1NmZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Feb 2006 08:42:25 -0500
Received: by zproxy.gmail.com with SMTP id v1so1248949nzb
        for <git@vger.kernel.org>; Tue, 28 Feb 2006 05:42:24 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type;
        b=tiJp28rzi/XZdHbc7Ec1dF3B3GR/7LQL46vKvHZAoAyJcGg3tFcJ1mNb722AbTJg+e83QzP8PTDg0dEfZY8u3At4PjlNChO0NUOzFOEl3N8YTyHrSCN/1weG3THhWq3t6ok9BjDGiv+56oiCvhQsZ3UJoY0mglouuv+kYrqBm3E=
Received: by 10.35.79.5 with SMTP id g5mr620039pyl;
        Tue, 28 Feb 2006 05:42:23 -0800 (PST)
Received: from ?192.168.2.39? ( [59.92.150.81])
        by mx.gmail.com with ESMTP id t5sm2524464pyc.2006.02.28.05.42.21;
        Tue, 28 Feb 2006 05:42:23 -0800 (PST)
User-Agent: Mail/News 1.5 (X11/20060213)
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16935>

This is a multi-part message in MIME format.
--------------000106080409040408060301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------000106080409040408060301
Content-Type: text/plain;
 name="0002-gitview-Some-window-layout-changes.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0002-gitview-Some-window-layout-changes.txt"

Subject: gitview: Some  window layout changes.

This makes menubar look nice

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>

---

 contrib/gitview/gitview |   27 +++++++++++++++------------
 1 files changed, 15 insertions(+), 12 deletions(-)

bc288bd1cd9c70e7eb1e8742527553d1c2dea61d
diff --git a/contrib/gitview/gitview b/contrib/gitview/gitview
index aded7ed..47ecaa3 100755
--- a/contrib/gitview/gitview
+++ b/contrib/gitview/gitview
@@ -368,7 +368,7 @@ class DiffWindow:
 		save_menu.connect("activate", self.save_menu_response, "save")
 		save_menu.show()
 		menu_bar.append(save_menu)
-		vbox.pack_start(menu_bar, False, False, 2)
+		vbox.pack_start(menu_bar, expand=False, fill=True)
 		menu_bar.show()
 
 		scrollwin = gtk.ScrolledWindow()
@@ -482,19 +482,10 @@ class GitView:
 
 	def construct(self):
 		"""Construct the window contents."""
+		vbox = gtk.VBox()
 		paned = gtk.VPaned()
 		paned.pack1(self.construct_top(), resize=False, shrink=True)
 		paned.pack2(self.construct_bottom(), resize=False, shrink=True)
-		self.window.add(paned)
-		paned.show()
-
-
-	def construct_top(self):
-		"""Construct the top-half of the window."""
-		vbox = gtk.VBox(spacing=6)
-		vbox.set_border_width(12)
-		vbox.show()
-
 		menu_bar = gtk.MenuBar()
 		menu_bar.set_pack_direction(gtk.PACK_DIRECTION_RTL)
 		help_menu = gtk.MenuItem("Help")
@@ -506,8 +497,20 @@ class GitView:
 		help_menu.set_submenu(menu)
 		help_menu.show()
 		menu_bar.append(help_menu)
-		vbox.pack_start(menu_bar, False, False, 2)
 		menu_bar.show()
+		vbox.pack_start(menu_bar, expand=False, fill=True)
+		vbox.pack_start(paned, expand=True, fill=True)
+		self.window.add(vbox)
+		paned.show()
+		vbox.show()
+
+
+	def construct_top(self):
+		"""Construct the top-half of the window."""
+		vbox = gtk.VBox(spacing=6)
+		vbox.set_border_width(12)
+		vbox.show()
+
 
 		scrollwin = gtk.ScrolledWindow()
 		scrollwin.set_policy(gtk.POLICY_NEVER, gtk.POLICY_AUTOMATIC)
-- 
1.2.3.gc55f-dirty


--------------000106080409040408060301--

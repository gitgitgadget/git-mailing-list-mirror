From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: gitview: Add some useful keybindings.
Date: Sun, 04 Jun 2006 23:37:48 +0530
Message-ID: <44832174.8010305@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060202020500000800020404"
X-From: git-owner@vger.kernel.org Sun Jun 04 20:08:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fmx1D-0000dD-MU
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 20:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWFDSH7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 14:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbWFDSH7
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 14:07:59 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:58316 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750869AbWFDSH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jun 2006 14:07:59 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1243582wri
        for <git@vger.kernel.org>; Sun, 04 Jun 2006 11:07:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type;
        b=fTQ4ulBOgOHLoncHPuUor0TVn4UNBFRJkCD5fvktXUs1nuqh1eg2Ybp6BMmK570nz8L6hqWZZI6WUPUkpQ09WKIMDZHWouvOX97IK+ShNTDkFGmSsMf+T3bVgx90eAtkiFxLZwBSN9NwQLHIF8e+1sugBN1aQ+o+14NuPbAEgBs=
Received: by 10.65.215.12 with SMTP id s12mr2932372qbq;
        Sun, 04 Jun 2006 11:07:58 -0700 (PDT)
Received: from ?192.168.2.11? ( [59.92.147.185])
        by mx.gmail.com with ESMTP id e14sm1751957qbe.2006.06.04.11.07.56;
        Sun, 04 Jun 2006 11:07:58 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.2 (X11/20060522)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21273>

This is a multi-part message in MIME format.
--------------060202020500000800020404
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------060202020500000800020404
Content-Type: text/plain;
 name="0001-gitview-Add-some-useful-keybindings.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-gitview-Add-some-useful-keybindings.txt"

gitview: Add some useful keybindings.
key binding for maximize, fullscreen, unfullscreen

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
---
 contrib/gitview/gitview     |   15 +++++++++++++++
 contrib/gitview/gitview.txt |    6 ++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/contrib/gitview/gitview b/contrib/gitview/gitview
index b836047..3b6bdce 100755
--- a/contrib/gitview/gitview
+++ b/contrib/gitview/gitview
@@ -450,6 +450,9 @@ class GitView:
 		self.accel_group = gtk.AccelGroup()
 		self.window.add_accel_group(self.accel_group)
 		self.accel_group.connect_group(0xffc2, 0, gtk.ACCEL_LOCKED, self.refresh);
+		self.accel_group.connect_group(0xffc1, 0, gtk.ACCEL_LOCKED, self.maximize);
+		self.accel_group.connect_group(0xffc8, 0, gtk.ACCEL_LOCKED, self.fullscreen);
+		self.accel_group.connect_group(0xffc9, 0, gtk.ACCEL_LOCKED, self.unfullscreen);
 
 		self.window.add(self.construct())
 
@@ -461,6 +464,18 @@ class GitView:
 		self.window.show()
 		return True
 
+	def maximize(self, widget, event=None, *arguments, **keywords):
+		self.window.maximize()
+		return True
+
+	def fullscreen(self, widget, event=None, *arguments, **keywords):
+		self.window.fullscreen()
+		return True
+
+	def unfullscreen(self, widget, event=None, *arguments, **keywords):
+		self.window.unfullscreen()
+		return True
+
 	def get_bt_sha1(self):
 		""" Update the bt_sha1 dictionary with the
 		respective sha1 details """
diff --git a/contrib/gitview/gitview.txt b/contrib/gitview/gitview.txt
index e3bc4f4..6924df2 100644
--- a/contrib/gitview/gitview.txt
+++ b/contrib/gitview/gitview.txt
@@ -26,8 +26,14 @@ OPTIONS
 	<args>
 		All the valid option for git-rev-list(1)
 	Key Bindings:
+	F4:
+		To maximize the window
 	F5:
 		To reread references.
+	F11:
+		Full screen
+	F12:
+		Leave full screen
 
 EXAMPLES
 ------
-- 
1.3.3.g16a4-dirty


--------------060202020500000800020404--

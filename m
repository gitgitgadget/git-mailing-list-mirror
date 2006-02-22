From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: gitview: Use monospace font to draw the branch and tag name
Date: Wed, 22 Feb 2006 21:36:10 +0530
Message-ID: <43FC8BF2.60205@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010908070209050106050601"
X-From: git-owner@vger.kernel.org Wed Feb 22 17:07:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBwVY-0001Wa-RS
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 17:06:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWBVQGT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Feb 2006 11:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbWBVQGT
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Feb 2006 11:06:19 -0500
Received: from pproxy.gmail.com ([64.233.166.182]:42611 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932288AbWBVQGS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Feb 2006 11:06:18 -0500
Received: by pproxy.gmail.com with SMTP id z59so1793989pyg
        for <git@vger.kernel.org>; Wed, 22 Feb 2006 08:06:17 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type;
        b=CEhQeS94rC/qCwu9NaEhTCwc8uzXh49/GwpZKUNG5cBxcBru43sRXdHi3VO2sKbbro/l9JX/5UMQA0Tm1d9iVL/LDyNG6kXLmqgWiafoeq52X3wMXzYf6hWxjmtFbg4PUHzGAt86yN7rQJxq16/4DU0iKIcJvXBlt7kqbhHIXi8=
Received: by 10.35.127.7 with SMTP id e7mr674207pyn;
        Wed, 22 Feb 2006 08:06:17 -0800 (PST)
Received: from ?192.168.2.11? ( [59.92.206.254])
        by mx.gmail.com with ESMTP id i72sm172483pye.2006.02.22.08.06.14;
        Wed, 22 Feb 2006 08:06:17 -0800 (PST)
User-Agent: Mail/News 1.5 (X11/20060213)
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	aneesh.kumar@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16600>

This is a multi-part message in MIME format.
--------------010908070209050106050601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------010908070209050106050601
Content-Type: text/plain;
 name*0="0001-gitview-Use-monospace-font-to-draw-the-branch-and-tag-name.";
 name*1="txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-gitview-Use-monospace-font-to-draw-the-branch-and-tag-n";
 filename*1="ame.txt"


This patch address the below:
Use monospace font to draw branch and tag name
set the font size to 13.
Make the graph column resizable. This helps to accommodate large tag names

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>

---

 contrib/gitview/gitview |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

725c7d29cbe4efd0a7f7d9f218dc12e36f5920de
diff --git a/contrib/gitview/gitview b/contrib/gitview/gitview
index 5862fcc..0e52c78 100755
--- a/contrib/gitview/gitview
+++ b/contrib/gitview/gitview
@@ -174,9 +174,9 @@ class CellRendererGraph(gtk.GenericCellR
 		names_len = 0
 		if (len(names) != 0):
 			for item in names:
-				names_len += len(item)/3
+				names_len += len(item)
 
-		width = box_size * (cols + 1 + names_len )
+		width = box_size * (cols + 1 ) + names_len 
 		height = box_size
 
 		# FIXME I have no idea how to use cell_area properly
@@ -258,6 +258,8 @@ class CellRendererGraph(gtk.GenericCellR
 			for item in names:
 				name = name + item + " "
 
+			ctx.select_font_face("Monospace")
+			ctx.set_font_size(13)
 			ctx.text_path(name)
 
 		self.set_colour(ctx, colour, 0.0, 0.5)
@@ -537,8 +539,8 @@ class GitView:
 
 		cell = CellRendererGraph()
 		column = gtk.TreeViewColumn()
-		column.set_resizable(False)
-		column.pack_start(cell, expand=False)
+		column.set_resizable(True)
+		column.pack_start(cell, expand=True)
 		column.add_attribute(cell, "node", 1)
 		column.add_attribute(cell, "in-lines", 2)
 		column.add_attribute(cell, "out-lines", 3)
-- 
1.2.0-dirty


--------------010908070209050106050601--

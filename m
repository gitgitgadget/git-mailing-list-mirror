From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: Select the text color based on whether the entry in highlighted.
Date: Tue, 28 Feb 2006 19:11:08 +0530
Message-ID: <440452F4.1010803@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040209070508010306070707"
X-From: git-owner@vger.kernel.org Tue Feb 28 14:41:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FE56R-0005MV-VW
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 14:41:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWB1NlT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 08:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWB1NlT
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 08:41:19 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:28424 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750795AbWB1NlS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Feb 2006 08:41:18 -0500
Received: by wproxy.gmail.com with SMTP id i20so1091661wra
        for <git@vger.kernel.org>; Tue, 28 Feb 2006 05:41:18 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type;
        b=sLnOPqtj4Vb4+BiT8ze7bCgHIxLuaRHfG48lgxVJ9+lnBU9SYYJgKJmuaulUqz0ks8vyCwdHuFsh3G9cb45tzHdaNLH40IK+k1Sq+rUZED2UbRF8TO72ReI4dPCjLIIJKug2jDAJA6aS2MemgKNmuyX+ynmxwadY1Vj6gSUQPrM=
Received: by 10.35.121.2 with SMTP id y2mr613151pym;
        Tue, 28 Feb 2006 05:41:17 -0800 (PST)
Received: from ?192.168.2.39? ( [59.92.150.81])
        by mx.gmail.com with ESMTP id t5sm2523820pyc.2006.02.28.05.41.14;
        Tue, 28 Feb 2006 05:41:16 -0800 (PST)
User-Agent: Mail/News 1.5 (X11/20060213)
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Pavel Roskin <proski@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16934>

This is a multi-part message in MIME format.
--------------040209070508010306070707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------040209070508010306070707
Content-Type: text/plain;
 name*0="0001-Select-the-text-color-based-on-whether-the-entry-in-highlig";
 name*1="hted.-Use.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-Select-the-text-color-based-on-whether-the-entry-in-hig";
 filename*1="hlighted.-Use.txt"

From: Pavel Roskin <proski@gnu.org>
Subject: Select the text color based on whether the entry in highlighted.  Use
standard font.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>

---

 contrib/gitview/gitview |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

21154c68bf8b95e0db49d507ea34e0b8a51308df
diff --git a/contrib/gitview/gitview b/contrib/gitview/gitview
index 048caf6..aded7ed 100755
--- a/contrib/gitview/gitview
+++ b/contrib/gitview/gitview
@@ -239,20 +239,23 @@ class CellRendererGraph(gtk.GenericCellR
 				box_size / 4, 0, 2 * math.pi)
 
 
+		self.set_colour(ctx, colour, 0.0, 0.5)
+		ctx.stroke_preserve()
+
+		self.set_colour(ctx, colour, 0.5, 1.0)
+		ctx.fill_preserve()
+
 		if (len(names) != 0):
 			name = " "
 			for item in names:
 				name = name + item + " "
 
-			ctx.select_font_face("Monospace")
 			ctx.set_font_size(13)
-			ctx.text_path(name)
-
-		self.set_colour(ctx, colour, 0.0, 0.5)
-		ctx.stroke_preserve()
-
-		self.set_colour(ctx, colour, 0.5, 1.0)
-		ctx.fill()
+			if (flags & 1):
+				self.set_colour(ctx, colour, 0.5, 1.0)
+			else:
+				self.set_colour(ctx, colour, 0.0, 0.5)
+			ctx.show_text(name)
 
 class Commit:
 	""" This represent a commit object obtained after parsing the git-rev-list
-- 
1.2.3.gc55f-dirty


--------------040209070508010306070707--

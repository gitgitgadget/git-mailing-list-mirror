From: "Thomas Kolejka" <Thomas.Kolejka@gmx.at>
Subject: [PATCH] Display "gitweb/test/file with spaces" in gitk
Date: Thu, 20 Jul 2006 12:12:23 +0200
Message-ID: <20060720101223.116320@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jul 20 12:12:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3VWD-0005fK-8T
	for gcvg-git@gmane.org; Thu, 20 Jul 2006 12:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbWGTKMZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 20 Jul 2006 06:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbWGTKMZ
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Jul 2006 06:12:25 -0400
Received: from mail.gmx.de ([213.165.64.21]:35276 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932570AbWGTKMZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Jul 2006 06:12:25 -0400
Received: (qmail 22774 invoked by uid 0); 20 Jul 2006 10:12:23 -0000
Received: from 141.130.250.71 by www047.gmx.net with HTTP;
 Thu, 20 Jul 2006 12:12:23 +0200 (CEST)
To: Paul Mackerras <paulus@samba.org>
X-Authenticated: #20307258
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24027>

Hello,

with this patch files with spaces in their names are displayed
in the treeview of gitk.

I use git to make a "backup"/"dump" of a DOS-FS .. and there are=20
those filenames ;-).

Take care .. it's my first tcl hack!

Thomas

--
diff --git a/gitk b/gitk
index ba4644f..93af19c 100755
--- a/gitk
+++ b/gitk
@@ -3938,7 +3938,7 @@ proc gettreeline {gtf id} {
     while {[gets $gtf line] >=3D 0} {
        if {[lindex $line 1] ne "blob"} continue
        set sha1 [lindex $line 2]
-       set fname [lindex $line 3]
+       set fname [join [lrange $line 3 end]]
        lappend treefilelist($id) $fname
        lappend treeidlist($id) $sha1
     }
@@ -4147,7 +4147,7 @@ proc gettreediffline {gdtf ids} {
        }
        return
     }
-    set file [lindex $line 5]
+    set file [join [lrange $line 5 end]]
     lappend treediff $file
 }



--=20


Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
Ideal f=FCr Modem und ISDN: http://www.gmx.net/de/go/smartsurfer

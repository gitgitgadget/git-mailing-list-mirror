From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Colored log on any ANSI capable terminal
Date: Thu, 21 Apr 2005 21:42:17 -0400
Message-ID: <1114134137.12771.7.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Apr 22 03:38:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOn7J-0000Fr-5U
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 03:38:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbVDVBmY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 21:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbVDVBmY
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 21:42:24 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:53638
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S261912AbVDVBmT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 21:42:19 -0400
Received: by localhost.localdomain (Postfix, from userid 500)
	id 3FF73EFF85; Thu, 21 Apr 2005 21:42:17 -0400 (EDT)
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

setterm only works on Linux terminal.  It should be safe to use raw ANSI
sequences -they work on most terminals, including xterm.  Nobody forces
you to use the "-c" option to "git log" on those stone-age terminals
that neither support nor ignore ANSI color codes.

I'm aware of $'...' but it may not work in bash 1.x.

Signed-off-by: Pavel Roskin <proski@gnu.org>

--- a/gitlog.sh
+++ b/gitlog.sh
@@ -12,11 +12,11 @@
 
 if [ "$1" = "-c" ]; then
 	shift
-	colheader=$(setterm -foreground green)
-	colauthor=$(setterm -foreground cyan)
-	colcommitter=$(setterm -foreground magenta)
-	colsignoff=$(setterm -foreground yellow)
-	coldefault=$(setterm -foreground default)
+	colheader=$(echo -ne '\e[32m')
+	colauthor=$(echo -ne '\e[36m')
+	colcommitter=$(echo -ne '\e[35m')
+	colsignoff=$(echo -ne '\e[33m')
+	coldefault=$(echo -ne '\e[39m')
 else
 	colheader=
 	colauthor=


-- 
Regards,
Pavel Roskin


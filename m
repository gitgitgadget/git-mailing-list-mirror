From: =?ISO-8859-1?Q?V=E4in=F6_J=E4rvel=E4?= <v@pp.inet.fi>
Subject: [PATCH] git-gui: Added support for OS X right click
Date: Fri, 03 Aug 2007 12:27:39 +0300
Message-ID: <C4431971-A1F1-463E-B238-D351FCBB57F8@pp.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 03 11:28:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGtSi-0000EV-2n
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 11:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757439AbXHCJ2p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 3 Aug 2007 05:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757368AbXHCJ2o
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 05:28:44 -0400
Received: from hyatt.suomi.net ([82.128.152.22]:63251 "EHLO hyatt.suomi.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757266AbXHCJ2o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Aug 2007 05:28:44 -0400
Received: from tiku.suomi.net ([82.128.154.67])
 by hyatt.suomi.net (Sun Java System Messaging Server 6.2-3.04 (built Jul 15
 2005)) with ESMTP id <0JM600K2BY8UZ930@hyatt.suomi.net> for
 git@vger.kernel.org; Fri, 03 Aug 2007 12:26:54 +0300 (EEST)
Received: from spam3.suomi.net (spam3.suomi.net [212.50.131.167])
 by mailstore.suomi.net
 (Sun Java(tm) System Messaging Server 6.3-1.04 (built May  9 2007; 32bit))
 with ESMTP id <0JM600GEQYBUFKH0@mailstore.suomi.net> for git@vger.kernel.org;
 Fri, 03 Aug 2007 12:28:42 +0300 (EEST)
Received: from [192.168.0.138]
 (addr-213-139-166-27.baananet.fi [213.139.166.27])
	by spam3.suomi.net (Postfix) with ESMTP id 30B6C1F561D; Fri,
 03 Aug 2007 12:28:15 +0300 (EEST)
X-Mailer: Apple Mail (2.752.3)
X-OPOY-MailScanner-Information: Please contact OPOY for more information
X-OPOY-MailScanner: Found to be clean
X-OPOY-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,	score=-0.734,
 required 5, autolearn=not spam, AWL 0.27,	BAYES_00 -1.00)
X-OPOY-MailScanner-From: v@pp.inet.fi
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54700>

OS X sends Button-2 on a "real" right click, such as with a three
button mouse, or by using the two-finger trackpad click.

Signed-off-by: V=E4in=F6 J=E4rvel=E4 <v@pp.inet.fi>
---
git-gui.sh |    3 +++
1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 2c7eb3c..29a790e 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1348,6 +1348,9 @@ unset i
proc bind_button3 {w cmd} {
	bind $w <Any-Button-3> $cmd
	if {[is_MacOSX]} {
+		# Mac OS X sends Button-2 on right click through three-button mouse,
+		# or through trackpad right-clicking (two-finger touch + click).
+		bind $w <Any-Button-2> $cmd
		bind $w <Control-Button-1> $cmd
	}
}
--
1.5.2

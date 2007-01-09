From: Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>
Subject: [PATCH] gitk errors out if launched in a subdirectory
Date: Tue, 9 Jan 2007 15:30:19 +0100
Message-ID: <20070109143019.GA24688@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Jan 09 15:36:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4I5u-00046F-JD
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 15:36:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbXAIOgn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 09:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbXAIOgn
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 09:36:43 -0500
Received: from matlock.hofmann.stw.uni-erlangen.de ([131.188.24.35]:42622 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750896AbXAIOgm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jan 2007 09:36:42 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Jan 2007 09:36:42 EST
Received: (qmail 9741 invoked by uid 0); 9 Jan 2007 14:29:58 -0000
Received: from p54aaa085.dip0.t-ipconnect.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@84.170.160.133)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 9 Jan 2007 14:29:58 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Paul Mackerras <paulus@samba.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36364>

Make gitk use git-rev-parse --git-dir to find the repository.

Signed-off-by: Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>
---
 gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 3dabc69..ec4f1bd 100755
--- a/gitk
+++ b/gitk
@@ -12,7 +12,7 @@ proc gitdir {} {
     if {[info exists env(GIT_DIR)]} {
 	return $env(GIT_DIR)
     } else {
-	return ".git"
+	return [exec git rev-parse --git-dir]
     }
 }
 
-- 
1.4.4.2

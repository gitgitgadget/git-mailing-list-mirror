From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Git.xs: older perl do not know const char *
Date: Sun, 2 Jul 2006 11:53:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607021152200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 02 11:53:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwydZ-0005Rz-GZ
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 11:53:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932800AbWGBJxG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 05:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932805AbWGBJxG
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 05:53:06 -0400
Received: from mail.gmx.de ([213.165.64.21]:22752 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932800AbWGBJxF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Jul 2006 05:53:05 -0400
Received: (qmail invoked by alias); 02 Jul 2006 09:53:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 02 Jul 2006 11:53:04 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23100>


Both of these casts _should_ be safe, since you do not want to muck around 
with the version or the path anyway.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 perl/Git.xs |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/perl/Git.xs b/perl/Git.xs
index 51bfac3..c824210 100644
--- a/perl/Git.xs
+++ b/perl/Git.xs
@@ -59,7 +59,7 @@ BOOT:
 # /* TODO: xs_call_gate(). See Git.pm. */
 
 
-const char *
+char *
 xs_version()
 CODE:
 {
@@ -69,11 +69,11 @@ OUTPUT:
 	RETVAL
 
 
-const char *
+char *
 xs_exec_path()
 CODE:
 {
-	RETVAL = git_exec_path();
+	RETVAL = (char *)git_exec_path();
 }
 OUTPUT:
 	RETVAL

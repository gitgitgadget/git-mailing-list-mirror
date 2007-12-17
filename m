From: Andy Dougherty <doughera@lafayette.edu>
Subject: [PATCH] Explain what 'ginstall' is
Date: Mon, 17 Dec 2007 16:46:09 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0712171641370.24957@fractal.phys.lafayette.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 17 23:47:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Oju-0006re-6p
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 23:47:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760090AbXLQWqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 17:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759879AbXLQWqN
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 17:46:13 -0500
Received: from mail.lafayette.edu ([139.147.8.42]:55574 "EHLO lafayette.edu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S937210AbXLQWqL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 17:46:11 -0500
Received: from fractal.phys.lafayette.edu (account doughera [139.147.232.21] verified)
  by lafayette.edu (CommuniGate Pro SMTP 5.0.13)
  with ESMTPSA id 14350716 for git@vger.kernel.org; Mon, 17 Dec 2007 16:46:10 -0500
X-X-Sender: doughera@fractal.phys.lafayette.edu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68643>

While trying git out on Solaris 8, the 'make install' step failed because
I don't have a 'ginstall' command.  After puzzling over it for a while,
I finally figured out that
    a)	it's referring to the 'install' command that is now part of the
	GNU coreutils package, and
    b)	it's probably unnecessary, as using the Solaris install command
	gave me the same results.  (However, I didn't do anything fancy,
	so it may be that in some scenarios using 'ginstall' matters.
	I didn't do anything other than a very simple test.)

Anyway, this patch documents it a tiny bit more.  Perhaps configure
should just go looking for a suitable install program instead of
assuming everyone has one.

--- git-1.5.4.rc0/Makefile	2007-12-12 21:29:16.000000000 -0500
+++ git-andy/Makefile	2007-12-17 15:15:12.000000000 -0500
@@ -416,6 +416,9 @@
 	NO_STRLCPY = YesPlease
 	NO_MEMMEM = YesPlease
 endif
+# For SunOS, this assumes you have ginstall from the
+# GNU coreutils package.  It's not clear whether that
+# is actually necessary.
 ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET = YesPlease
 	NEEDS_NSL = YesPlease

-- 
    Andy Dougherty		doughera@lafayette.edu

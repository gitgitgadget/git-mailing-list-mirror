From: Patrick Welche <prlw1@newn.cam.ac.uk>
Subject: NI_MAXSERV trivial patch
Date: Thu, 18 Oct 2007 18:17:39 +0100
Message-ID: <20071018171739.GC580@quartz.itdept.newn.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 19:50:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiZVx-0006nb-Kj
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 19:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758579AbXJRRuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 13:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758312AbXJRRuU
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 13:50:20 -0400
Received: from henry.newn.cam.ac.uk ([131.111.204.130]:57868 "EHLO
	henry.newn.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757477AbXJRRuT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 13:50:19 -0400
X-Greylist: delayed 1958 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Oct 2007 13:50:19 EDT
Received: from quartz.itdept.newn.cam.ac.uk ([192.168.200.180])
	by henry.newn.cam.ac.uk with esmtp (Exim 4.66)
	(envelope-from <prlw1@newn.cam.ac.uk>)
	id 1IiZ08-0004mM-0y
	for git@vger.kernel.org; Thu, 18 Oct 2007 18:17:40 +0100
Received: from prlw1 by quartz.itdept.newn.cam.ac.uk with local (Exim 4.66)
	(envelope-from <prlw1@newn.cam.ac.uk>)
	id 1IiZ07-0003iq-Ut
	for git@vger.kernel.org; Thu, 18 Oct 2007 18:17:39 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-03-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61550>

I found I needed

--- daemon.c.orig       2007-09-02 06:57:44.000000000 +0100
+++ daemon.c    2007-10-18 16:04:00.000000000 +0100
@@ -9,6 +9,10 @@
 #define HOST_NAME_MAX 256
 #endif
 
+#ifndef NI_MAXSERV
+#define NI_MAXSERV 32
+#endif
+
 static int log_syslog;
 static int verbose;
 static int reuseaddr;




to compile git, as for me NI_MAXSERV is defined in netdb.h, and it
doesn't seem worthwhile to include the whole header.

Cheers,

Patrick

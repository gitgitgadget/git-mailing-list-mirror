From: Gerrit Pape <pape@smarden.org>
Subject: git-apply fails to apply some patches
Date: Fri, 15 Sep 2006 13:22:25 +0000
Message-ID: <20060915132225.12040.qmail@a0896f98af57b2.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Sep 15 15:23:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GODe7-0000qC-6F
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 15:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbWIONWG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 09:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWIONWG
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 09:22:06 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:40634 "HELO a.mx.smarden.org")
	by vger.kernel.org with SMTP id S1751409AbWIONWE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Sep 2006 09:22:04 -0400
Received: (qmail 12041 invoked by uid 1000); 15 Sep 2006 13:22:25 -0000
To: git@vger.kernel.org, 386495@bugs.debian.org
Mail-Followup-To: git@vger.kernel.org, 386495@bugs.debian.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27086>

Hi, please see http://bugs.debian.org/386495 or below.  I can reproduce
the problem with 1.4.2.1.

Thanks, Gerrit.

----- Forwarded message from Matthew Wilcox <matthew@wil.cx> -----

Trying to apply a patch that was created with interdiff fails ...
Here's the first patch (which works)

--- pciutils-2.1.11.orig/debian/dirs
+++ pciutils-2.1.11/debian/dirs
@@ -0,0 +1,6 @@
+usr/share/misc
+usr/share/man
+usr/bin
+usr/lib
+usr/share/lintian/overrides
+bin

On top of that, I try to apply this interdiff generated patch:

diff -u pciutils-2.1.11/debian/dirs pciutils-2.1.11/debian/dirs
--- pciutils-2.1.11/debian/dirs
+++ pciutils-2.1.11/debian/dirs
@@ -6,0 +7 @@
+var/lib/pciutils

and git-apply says:

error: debian/dirs: already exists in working directory

I suspect it's confused by the '-x,0' thinking that means "file does not
exist" rather than "we have 0 context for this diff".


----- End forwarded message -----

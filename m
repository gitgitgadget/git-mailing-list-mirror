From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] Makefile: remove test-chmtime program in target clean.
Date: Tue, 27 Mar 2007 10:13:42 +0000
Message-ID: <20070327101342.16737.qmail@50ebf3781ede25.315fe32.mid.smarden.org>
References: <20070327093843.14074.qmail@7a32cdb4370c3b.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 27 12:13:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW8gA-0001HU-QB
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 12:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753567AbXC0KNY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 06:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753638AbXC0KNY
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 06:13:24 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:46481 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753623AbXC0KNX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 06:13:23 -0400
Received: (qmail 16738 invoked by uid 1000); 27 Mar 2007 10:13:42 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070327093843.14074.qmail@7a32cdb4370c3b.315fe32.mid.smarden.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43245>

While running 'make test', the test-chmtime program is created, and should
be cleaned up on 'make clean'.
---

On Tue, Mar 27, 2007 at 11:46:38AM +0200, Johannes Sixt wrote:
> Gerrit Pape wrote:
> > -               $(LIB_FILE) $(XDIFF_LIB)
> > +               test-chmtime $(LIB_FILE) $(XDIFF_LIB)
>
> test-chmtime$X you mean, right?

Yes, thanks.

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 51c1fed..960f98e 100644
--- a/Makefile
+++ b/Makefile
@@ -963,7 +963,7 @@ dist-doc:
 
 clean:
 	rm -f *.o mozilla-sha1/*.o arm/*.o ppc/*.o compat/*.o xdiff/*.o \
-		$(LIB_FILE) $(XDIFF_LIB)
+		test-chmtime$X $(LIB_FILE) $(XDIFF_LIB)
 	rm -f $(ALL_PROGRAMS) $(BUILT_INS) git$X
 	rm -f *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags
 	rm -rf autom4te.cache
-- 
1.5.1-rc2.GIT

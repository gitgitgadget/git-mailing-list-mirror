From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH 2/3] Documentation/Makefile: Some `git-*.txt' files aren't manpages.
Date: Sun, 05 Mar 2006 09:36:33 +0000
Message-ID: <20060305093633.26650.65452.stgit@metalzone.distorted.org.uk>
References: <20060305093351.26650.84677.stgit@metalzone.distorted.org.uk>
X-From: git-owner@vger.kernel.org Sun Mar 05 10:36:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFpfJ-0001zP-Lx
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 10:36:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157AbWCEJgf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 04:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752159AbWCEJgf
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 04:36:35 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:63130 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1752157AbWCEJge (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Mar 2006 04:36:34 -0500
Received: (qmail 26946 invoked from network); 5 Mar 2006 09:36:33 -0000
Received: from localhost (HELO metalzone.distorted.org.uk) (127.0.0.1)
  by localhost with SMTP; 5 Mar 2006 09:36:33 -0000
To: git@vger.kernel.org
In-Reply-To: <20060305093351.26650.84677.stgit@metalzone.distorted.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17211>

From: Mark Wooding <mdw@distorted.org.uk>

In particular, git-tools.txt isn't a manpage, and my Asciidoc gets upset
by it.  The simplest fix is to Remove articles from the list of manpages
the Makefile.

Signed-off-by: Mark Wooding <mdw@distorted.org.uk>
---

 Documentation/Makefile |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index a3bca86..f4cbf7e 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -1,4 +1,7 @@
-MAN1_TXT=$(wildcard git-*.txt) gitk.txt
+MAN1_TXT= \
+	$(filter-out $(addsuffix .txt, $(ARTICLES) $(SP_ARTICLES)), \
+		$(wildcard git-*.txt)) \
+	gitk.txt
 MAN7_TXT=git.txt
 
 DOC_HTML=$(patsubst %.txt,%.html,$(MAN1_TXT) $(MAN7_TXT))
@@ -11,6 +14,7 @@ ARTICLES += howto-index
 ARTICLES += repository-layout
 ARTICLES += hooks
 ARTICLES += everyday
+ARTICLES += git-tools
 # with their own formatting rules.
 SP_ARTICLES = glossary howto/revert-branch-rebase
 

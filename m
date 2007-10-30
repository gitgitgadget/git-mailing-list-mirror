From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] no longer install git-svnimport, move to contrib/examples
Date: Tue, 30 Oct 2007 14:24:27 +0000
Message-ID: <20071030142427.6467.qmail@76c770d547b63d.315fe32.mid.smarden.org>
References: <31e679430710250225w39a876d0w738d819245e514e@mail.gmail.com> <Pine.LNX.4.64.0710251132580.25221@racer.site> <20071026145520.2141.qmail@7a6a65599aed61.315fe32.mid.smarden.org> <Pine.LNX.4.64.0710261745110.4362@racer.site> <47222CB3.9070100@midwinter.com> <7vy7dpy8qf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 15:24:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ims12-00053a-P7
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 15:24:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753036AbXJ3OYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 10:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752750AbXJ3OYK
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 10:24:10 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:56620 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751251AbXJ3OYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 10:24:09 -0400
Received: (qmail 6468 invoked by uid 1000); 30 Oct 2007 14:24:27 -0000
Content-Disposition: inline
In-Reply-To: <7vy7dpy8qf.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 26, 2007 at 12:30:16PM -0700, Junio C Hamano wrote:
> Steven Grimm <koreth@midwinter.com> writes:
> > Johannes Schindelin wrote:
> >>> I'm not sure these are worth fixing, I'd rather suggest to drop
> >>> git-svnimport in favor of git-svn, and not installing it in future
> >>> versions.
> >>>
> >> I already proposed this.  The outcome was... silent.
> >
> > Me too, and same reaction.
> >
> > So I vote we interpret that as, "No objections from anyone."
>
> Likewise.

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 .gitignore                                         |    1 -
 Documentation/cmd-list.perl                        |    1 -
 Makefile                                           |    3 +--
 contrib/completion/git-completion.bash             |    1 -
 .../examples/git-svnimport.perl                    |    0 
 .../examples}/git-svnimport.txt                    |    0 
 6 files changed, 1 insertions(+), 5 deletions(-)
 rename git-svnimport.perl => contrib/examples/git-svnimport.perl (100%)
 rename {Documentation => contrib/examples}/git-svnimport.txt (100%)

diff --git a/.gitignore b/.gitignore
index 62afef2..8670081 100644
--- a/.gitignore
+++ b/.gitignore
@@ -128,7 +128,6 @@ git-status
 git-stripspace
 git-submodule
 git-svn
-git-svnimport
 git-symbolic-ref
 git-tag
 git-tar-tree
diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 1061fd8..8d21d42 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -185,7 +185,6 @@ git-status                              mainporcelain
 git-stripspace                          purehelpers
 git-submodule                           mainporcelain
 git-svn                                 foreignscminterface
-git-svnimport                           foreignscminterface
 git-symbolic-ref                        plumbingmanipulators
 git-tag                                 mainporcelain
 git-tar-tree                            plumbinginterrogators
diff --git a/Makefile b/Makefile
index 72f5ef4..eb98d91 100644
--- a/Makefile
+++ b/Makefile
@@ -225,8 +225,7 @@ SCRIPT_SH = \
 SCRIPT_PERL = \
 	git-add--interactive.perl \
 	git-archimport.perl git-cvsimport.perl git-relink.perl \
-	git-cvsserver.perl git-remote.perl \
-	git-svnimport.perl git-cvsexportcommit.perl \
+	git-cvsserver.perl git-remote.perl git-cvsexportcommit.perl \
 	git-send-email.perl git-svn.perl
 
 SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e760930..599b2fc 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -346,7 +346,6 @@ __git_commands ()
 		ssh-*)            : transport;;
 		stripspace)       : plumbing;;
 		svn)              : import export;;
-		svnimport)        : import;;
 		symbolic-ref)     : plumbing;;
 		tar-tree)         : deprecated;;
 		unpack-file)      : plumbing;;
diff --git a/git-svnimport.perl b/contrib/examples/git-svnimport.perl
similarity index 100%
rename from git-svnimport.perl
rename to contrib/examples/git-svnimport.perl
diff --git a/Documentation/git-svnimport.txt b/contrib/examples/git-svnimport.txt
similarity index 100%
rename from Documentation/git-svnimport.txt
rename to contrib/examples/git-svnimport.txt
-- 
1.5.3.4

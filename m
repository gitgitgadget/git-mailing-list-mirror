From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] builtin-push: New long option --verbose
Date: Mon, 27 Aug 2007 09:49:11 +0300
Organization: Private
Message-ID: <y7fxeal4.fsf@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 27 08:45:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPYM2-00039o-RE
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 08:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbXH0GpM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 02:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbXH0GpM
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 02:45:12 -0400
Received: from main.gmane.org ([80.91.229.2]:57777 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751026AbXH0GpK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 02:45:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IPYLU-0001QD-67
	for git@vger.kernel.org; Mon, 27 Aug 2007 08:45:08 +0200
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 08:45:08 +0200
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 08:45:08 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.3 (windows-nt)
Cancel-Lock: sha1:6ETSLA2MwCVcYw1uxN+heExEyyg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56768>

Implemented and documented new option.

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-push.txt |    4 ++--
 builtin-push.c             |    5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index f8cc2b5..fb9dc7f 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -8,7 +8,7 @@ git-push - Update remote refs along with associated objects
 
 SYNOPSIS
 --------
-'git-push' [--all] [--tags] [--receive-pack=<git-receive-pack>] [--repo=all] [-f | --force] [-v] [<repository> <refspec>...]
+'git-push' [--all] [--tags] [--receive-pack=<git-receive-pack>] [--repo=all] [-f | --force] [-v | --verbose] [<repository> <refspec>...]
 
 DESCRIPTION
 -----------
@@ -91,7 +91,7 @@ the remote repository.
 	transfer spends extra cycles to minimize the number of
 	objects to be sent and meant to be used on slower connection.
 
--v::
+-v, \--verbose::
 	Run verbosely.
 
 include::urls.txt[]
diff --git a/builtin-push.c b/builtin-push.c
index cb78401..613f6c2 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -8,7 +8,7 @@
 
 #define MAX_URI (16)
 
-static const char push_usage[] = "git-push [--all] [--tags] [--receive-pack=<git-receive-pack>] [--repo=all] [-f | --force] [-v] [<repository> <refspec>...]";
+static const char push_usage[] = "git-push [--all] [--tags] [--receive-pack=<git-receive-pack>] [--repo=all] [-f | --force] [-v | --verbose] [<repository> <refspec>...]";
 
 static int all, tags, force, thin = 1, verbose;
 static const char *receivepack;
@@ -372,7 +372,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 			i++;
 			break;
 		}
-		if (!strcmp(arg, "-v")) {
+		if (!strcmp(arg, "-v") ||
+                    !strcmp(arg, "--verbose")) {
 			verbose=1;
 			continue;
 		}
-- 
1.5.3.rc5

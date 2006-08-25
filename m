From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH 2/7] git-ls-remote(1): document --upload-pack
Date: Fri, 25 Aug 2006 02:58:20 +0200
Message-ID: <20060825005820.GC4069@diku.dk>
References: <20060818084545.GB4717@diku.dk> <7virkqbcq3.fsf@assigned-by-dhcp.cox.net> <20060825005655.GB4069@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 25 02:58:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGQ1m-0004Rr-Bv
	for gcvg-git@gmane.org; Fri, 25 Aug 2006 02:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422798AbWHYA60 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 20:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422797AbWHYA6Z
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 20:58:25 -0400
Received: from [130.225.96.91] ([130.225.96.91]:23492 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1422796AbWHYA6Y (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Aug 2006 20:58:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 9AB1F770079;
	Fri, 25 Aug 2006 02:58:21 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26103-09; Fri, 25 Aug 2006 02:58:20 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 70E9C770076;
	Fri, 25 Aug 2006 02:58:20 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 517D66DF8AC; Fri, 25 Aug 2006 02:57:02 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 5D27A629FB; Fri, 25 Aug 2006 02:58:20 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060825005655.GB4069@diku.dk>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25985>

... and mention that '.' will list the local repo references.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 Documentation/git-ls-remote.txt |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index ae4c1a2..c8a4c5a 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -3,16 +3,19 @@ git-ls-remote(1)
 
 NAME
 ----
-git-ls-remote - Look at references other repository has
+git-ls-remote - List references in a remote repository
 
 
 SYNOPSIS
 --------
-'git-ls-remote' [--heads] [--tags] <repository> <refs>...
+[verse]
+'git-ls-remote' [--heads] [--tags]  [-u <exec> | --upload-pack <exec>]
+	      <repository> <refs>...
 
 DESCRIPTION
 -----------
-Displays the references other repository has.
+Displays references available in a remote repository along with the associated
+commit IDs.
 
 
 OPTIONS
@@ -23,9 +26,16 @@ OPTIONS
 	both, references stored in refs/heads and refs/tags are
 	displayed.
 
+-u <exec>, --upload-pack=<exec>::
+	Specify the full path of gitlink:git-upload-pack[1] on the remote
+	host. This allows listing references from repositories accessed via
+	SSH and where the SSH deamon does not use the PATH configured by the
+	user. Also see the '--exec' option for gitlink:git-peek-remote[1].
+
 <repository>::
 	Location of the repository.  The shorthand defined in
-	$GIT_DIR/branches/ can be used.
+	$GIT_DIR/branches/ can be used. Use "." (dot) to list references in
+	the local repository.
 
 <refs>...::
 	When unspecified, all references, after filtering done
-- 
1.4.2.GIT

-- 
Jonas Fonseca

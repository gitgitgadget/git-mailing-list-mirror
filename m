From: Torsten =?iso-8859-1?q?B=F6gershausen?= <tboegi@web.de>
Subject: [PATCH] git-fetch-pack uses URLs like git-fetch
Date: Fri, 8 Nov 2013 18:54:05 +0100
Message-ID: <201311081854.06201.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 08 18:54:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeqGE-0005cs-EW
	for gcvg-git-2@plane.gmane.org; Fri, 08 Nov 2013 18:54:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757645Ab3KHRyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Nov 2013 12:54:18 -0500
Received: from mout.web.de ([212.227.17.12]:56497 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757530Ab3KHRyR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Nov 2013 12:54:17 -0500
Received: from appes.localnet ([78.72.74.102]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0MhliZ-1VJCmJ03kZ-00MpUa for <git@vger.kernel.org>; Fri,
 08 Nov 2013 18:54:16 +0100
X-Provags-ID: V03:K0:Jo2H/OyD6HNAd1VDC3TbZF6xQinyywpDvEs4lAgXCUVasOn2nDO
 SuvI5dDBDy+e3w+Uvawsk807yIzdAc3T1KthnVbT4pbd8FSVJgUcNUwoe3+YBW9pmI/b8kU
 SFK/b2w6yDYz5r2evEpmYD97KZe7Wi+GRnR7/yQDye26wG8uSvoMNRDMi0WaV0zmRkcch0C
 ZAzdJhiFo7mwFd057J71g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237459>

"git fetch-pack" allows [<host>:]<directory> to point out the source
repository.
Use the term <repository>, which is already used in "git fetch" or "git pull"
to describe URLs supported by Git.
---
 Documentation/git-fetch-pack.txt | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index 444b805..93b5067 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git fetch-pack' [--all] [--quiet|-q] [--keep|-k] [--thin] [--include-tag]
 	[--upload-pack=<git-upload-pack>]
 	[--depth=<n>] [--no-progress]
-	[-v] [<host>:]<directory> [<refs>...]
+	[-v] <repository> [<refs>...]
 
 DESCRIPTION
 -----------
@@ -97,19 +97,18 @@ be in a separate packet, and the list must end with a flush packet.
 -v::
 	Run verbosely.
 
-<host>::
-	A remote host that houses the repository.  When this
-	part is specified, 'git-upload-pack' is invoked via
-	ssh.
-
-<directory>::
-	The repository to sync from.
+<repository>::
+	The URL to the remote repository.
 
 <refs>...::
 	The remote heads to update from. This is relative to
 	$GIT_DIR (e.g. "HEAD", "refs/heads/master").  When
 	unspecified, update from all heads the remote side has.
 
+SEE ALSO
+--------
+linkgit:git-fetch[1]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
1.8.4.457.g424cb08

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 5/8] bash: Classify more commends out of completion.
Date: Sun, 4 Feb 2007 02:38:30 -0500
Message-ID: <20070204073830.GE17603@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 04 08:38:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDbxZ-0007Y3-R4
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 08:38:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbXBDHif (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 02:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752149AbXBDHif
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 02:38:35 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:55517 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbXBDHie (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 02:38:34 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HDbxH-0008WB-Bb; Sun, 04 Feb 2007 02:38:31 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DF5BE20FBAE; Sun,  4 Feb 2007 02:38:30 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38660>

Most of these commands are not ones you want to invoke from the
command line on a frequent basis, or have been renamed in 1.5.0 to
more friendly versions, but the old names are being left behind to
support existing scripts in the wild.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1cf576e..382c817 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -250,16 +250,24 @@ __git_commands ()
 	do
 		case $i in
 		add--interactive) : plumbing;;
+		applymbox)        : ask gittus;;
+		applypatch)       : ask gittus;;
+		archimport)       : import;;
 		cat-file)         : plumbing;;
 		check-ref-format) : plumbing;;
 		commit-tree)      : plumbing;;
 		convert-objects)  : plumbing;;
+		cvsexportcommit)  : export;;
+		cvsimport)        : import;;
 		cvsserver)        : daemon;;
 		daemon)           : daemon;;
+		fsck-objects)     : plumbing;;
 		fetch-pack)       : plumbing;;
+		fmt-merge-msg)    : plumbing;;
 		hash-object)      : plumbing;;
 		http-*)           : transport;;
 		index-pack)       : plumbing;;
+		init-db)          : deprecated;;
 		local-fetch)      : plumbing;;
 		mailinfo)         : plumbing;;
 		mailsplit)        : plumbing;;
@@ -272,9 +280,13 @@ __git_commands ()
 		parse-remote)     : plumbing;;
 		patch-id)         : plumbing;;
 		peek-remote)      : plumbing;;
+		prune)            : plumbing;;
+		prune-packed)     : plumbing;;
+		quiltimport)      : import;;
 		read-tree)        : plumbing;;
 		receive-pack)     : plumbing;;
 		reflog)           : plumbing;;
+		repo-config)      : plumbing;;
 		rerere)           : plumbing;;
 		rev-list)         : plumbing;;
 		rev-parse)        : plumbing;;
@@ -285,14 +297,19 @@ __git_commands ()
 		show-index)       : plumbing;;
 		ssh-*)            : transport;;
 		stripspace)       : plumbing;;
+		svn)              : import export;;
+		svnimport)        : import;;
 		symbolic-ref)     : plumbing;;
+		tar-tree)         : deprecated;;
 		unpack-file)      : plumbing;;
 		unpack-objects)   : plumbing;;
+		update-index)     : plumbing;;
 		update-ref)       : plumbing;;
 		update-server-info) : daemon;;
 		upload-archive)   : plumbing;;
 		upload-pack)      : plumbing;;
 		write-tree)       : plumbing;;
+		verify-tag)       : plumbing;;
 		*) echo $i;;
 		esac
 	done
@@ -834,7 +851,6 @@ _git ()
 	pull)        _git_pull ;;
 	push)        _git_push ;;
 	rebase)      _git_rebase ;;
-	repo-config) _git_config ;;
 	reset)       _git_reset ;;
 	show)        _git_show ;;
 	show-branch) _git_log ;;
-- 
1.5.0.rc3.22.g5057

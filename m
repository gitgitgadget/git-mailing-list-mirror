From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/6] bash: Offer --prune completion for git-gc.
Date: Mon, 5 Feb 2007 15:44:28 -0500
Message-ID: <20070205204428.GC8824@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 05 21:44:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEAhk-0007ZE-Ld
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 21:44:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933440AbXBEUoe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 15:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933447AbXBEUoe
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 15:44:34 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:36100 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933440AbXBEUob (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 15:44:31 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HEAhJ-0008IA-C9; Mon, 05 Feb 2007 15:44:21 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2754A20FBAE; Mon,  5 Feb 2007 15:44:28 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38783>

I'm lazy.  I don't want to type out --prune if bash can do it for
me with --<tab>.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c4d433f..dcf5e4b 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -508,6 +508,18 @@ _git_format_patch ()
 	__git_complete_revlist
 }
 
+_git_gc ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--*)
+		__gitcomp "--prune"
+		return
+		;;
+	esac
+	COMPREPLY=()
+}
+
 _git_ls_remote ()
 {
 	__gitcomp "$(__git_remotes)"
@@ -907,6 +919,7 @@ _git ()
 	diff-tree)   _git_diff_tree ;;
 	fetch)       _git_fetch ;;
 	format-patch) _git_format_patch ;;
+	gc)          _git_gc ;;
 	log)         _git_log ;;
 	ls-remote)   _git_ls_remote ;;
 	ls-tree)     _git_ls_tree ;;
@@ -950,6 +963,7 @@ complete -o default -o nospace -F _git_diff git-diff
 complete -o default -o nospace -F _git_diff_tree git-diff-tree
 complete -o default -o nospace -F _git_fetch git-fetch
 complete -o default -o nospace -F _git_format_patch git-format-patch
+complete -o default -o nospace -F _git_gc git-gc
 complete -o default -o nospace -F _git_log git-log
 complete -o default -o nospace -F _git_ls_remote git-ls-remote
 complete -o default -o nospace -F _git_ls_tree git-ls-tree
-- 
1.5.0.rc3.58.g79812

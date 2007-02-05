From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/6] bash: Support completion on git-cherry.
Date: Mon, 5 Feb 2007 15:44:22 -0500
Message-ID: <20070205204422.GA8824@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 05 21:44:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEAhS-0007S9-I6
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 21:44:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933442AbXBEUo1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 15:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933445AbXBEUo0
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 15:44:26 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:36094 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933442AbXBEUoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 15:44:25 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HEAhD-0008Hx-Rf; Mon, 05 Feb 2007 15:44:15 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7C03920FBAE; Mon,  5 Feb 2007 15:44:22 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38781>

I just realized I did not support ref name completion for git-cherry.
This tool is just too useful to contributors who submit patches
upstream by email; completion support for it is very handy.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2387506..c22ff48 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -415,6 +415,11 @@ _git_checkout ()
 	__gitcomp "$(__git_refs)"
 }
 
+_git_cherry ()
+{
+	__gitcomp "$(__git_refs)"
+}
+
 _git_cherry_pick ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
@@ -893,6 +898,7 @@ _git ()
 	apply)       _git_apply ;;
 	branch)      _git_branch ;;
 	checkout)    _git_checkout ;;
+	cherry)      _git_cherry ;;
 	cherry-pick) _git_cherry_pick ;;
 	commit)      _git_commit ;;
 	config)      _git_config ;;
@@ -936,6 +942,7 @@ complete -o default -o nospace -F _git_am git-am
 complete -o default -o nospace -F _git_apply git-apply
 complete -o default -o nospace -F _git_branch git-branch
 complete -o default -o nospace -F _git_checkout git-checkout
+complete -o default -o nospace -F _git_cherry git-cherry
 complete -o default -o nospace -F _git_cherry_pick git-cherry-pick
 complete -o default -o nospace -F _git_commit git-commit
 complete -o default -o nospace -F _git_diff git-diff
@@ -967,6 +974,7 @@ complete -o default -o nospace -F _git_add git-add.exe
 complete -o default -o nospace -F _git_apply git-apply.exe
 complete -o default -o nospace -F _git git.exe
 complete -o default -o nospace -F _git_branch git-branch.exe
+complete -o default -o nospace -F _git_cherry git-cherry.exe
 complete -o default -o nospace -F _git_diff git-diff.exe
 complete -o default -o nospace -F _git_diff_tree git-diff-tree.exe
 complete -o default -o nospace -F _git_format_patch git-format-patch.exe
-- 
1.5.0.rc3.58.g79812

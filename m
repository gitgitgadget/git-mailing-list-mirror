From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/8] bash: Remove short option completions for branch/checkout/diff.
Date: Sun, 4 Feb 2007 02:38:17 -0500
Message-ID: <20070204073817.GA17603@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 04 08:38:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDbxI-0007PP-9t
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 08:38:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbXBDHiW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 02:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752136AbXBDHiW
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 02:38:22 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:55504 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbXBDHiW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 02:38:22 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HDbx5-0008VP-6O; Sun, 04 Feb 2007 02:38:19 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2E0BE20FBAE; Sun,  4 Feb 2007 02:38:18 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38659>

The short options (-l, -f, -d) for git-branch are rather silly to
include in the completion generation as these options must be fully
typed out by the user and most users already know what the options
are anyway, so including them in the suggested completions does
not offer huge value.  (The same goes for git-checkout and git-diff.)

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 83c69ec..971fefb 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -359,7 +359,7 @@ _git_apply ()
 _git_branch ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
-	COMPREPLY=($(compgen -W "-l -f -d -D $(__git_refs)" -- "$cur"))
+	COMPREPLY=($(compgen -W "$(__git_refs)" -- "$cur"))
 }
 
 _git_cat_file ()
@@ -381,7 +381,7 @@ _git_cat_file ()
 _git_checkout ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
-	COMPREPLY=($(compgen -W "-l -b $(__git_refs)" -- "$cur"))
+	COMPREPLY=($(compgen -W "$(__git_refs)" -- "$cur"))
 }
 
 _git_cherry_pick ()
@@ -421,7 +421,7 @@ _git_diff ()
 _git_diff_tree ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
-	COMPREPLY=($(compgen -W "-r -p -M $(__git_refs)" -- "$cur"))
+	COMPREPLY=($(compgen -W "$(__git_refs)" -- "$cur"))
 }
 
 _git_fetch ()
-- 
1.5.0.rc3.22.g5057

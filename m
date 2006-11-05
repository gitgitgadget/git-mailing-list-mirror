X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/6] Added missing completions for show-branch and merge-base.
Date: Sun, 5 Nov 2006 06:20:02 -0500
Message-ID: <20061105112002.GA20495@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 5 Nov 2006 11:20:48 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
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
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30966>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ggg2z-0006nA-8Q for gcvg-git@gmane.org; Sun, 05 Nov
 2006 12:20:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932642AbWKELUH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 06:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932645AbWKELUH
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 06:20:07 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:36224 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S932642AbWKELUF
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 06:20:05 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Ggg2i-0008IO-F2; Sun, 05 Nov 2006 06:20:00 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 532DA20E491; Sun,  5 Nov 2006 06:20:02 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

The show-branch and merge-base commands were partially supported
when it came to bash completions as they were only specified in
one form another.  Now we specify them in both forms.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a3fbb90..fdfbf95 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -309,6 +309,7 @@ _git ()
 		log)         _git_log ;;
 		ls-remote)   _git_ls_remote ;;
 		ls-tree)     _git_ls_tree ;;
+		merge-base)  _git_merge_base ;;
 		pull)        _git_pull ;;
 		push)        _git_push ;;
 		reset)       _git_reset ;;
@@ -342,12 +343,14 @@ complete -o default -o nospace -F _git_p
 complete -o default -o nospace -F _git_push git-push
 complete -o default            -F _git_reset git-reset
 complete -o default            -F _git_show git-show
+complete -o default -o nospace -F _git_log git-show-branch
 complete -o default -o nospace -F _git_log git-whatchanged
 
 # The following are necessary only for Cygwin, and only are needed
 # when the user has tab-completed the executable name and consequently
 # included the '.exe' suffix.
 #
+complete -o default -o nospace -F _git git.exe
 complete -o default            -F _git_branch git-branch.exe
 complete -o default -o nospace -F _git_cat_file git-cat-file.exe
 complete -o default -o nospace -F _git_diff git-diff.exe
@@ -356,4 +359,5 @@ complete -o default -o nospace -F _git_l
 complete -o default -o nospace -F _git_ls_tree git-ls-tree.exe
 complete -o default            -F _git_merge_base git-merge-base.exe
 complete -o default -o nospace -F _git_push git-push.exe
+complete -o default -o nospace -F _git_log git-show-branch.exe
 complete -o default -o nospace -F _git_log git-whatchanged.exe
-- 
1.4.3.3.g9621

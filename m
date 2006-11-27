X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/10] Teach bash how to complete options for git-name-rev.
Date: Mon, 27 Nov 2006 03:41:12 -0500
Message-ID: <20061127084112.GC19745@spearce.org>
References: <de7beb117fb963e68e1085b773593be326ffd495.1164616814.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 08:41:32 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <de7beb117fb963e68e1085b773593be326ffd495.1164616814.git.spearce@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32393>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Goc3D-0007XE-Qh for gcvg-git@gmane.org; Mon, 27 Nov
 2006 09:41:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757412AbWK0IlR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 03:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757418AbWK0IlR
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 03:41:17 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:64907 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1757412AbWK0IlQ
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 03:41:16 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Goc36-0004RL-Dn; Mon, 27 Nov 2006 03:41:12 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 DDBBB20FB7F; Mon, 27 Nov 2006 03:41:12 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b55431f..1dfb592 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -326,6 +326,12 @@ _git_merge_base ()
 	COMPREPLY=($(compgen -W "$(__git_refs)" -- "$cur"))
 }
 
+_git_name_rev ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	COMPREPLY=($(compgen -W "--tags --all --stdin" -- "$cur"))
+}
+
 _git_pull ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
@@ -430,6 +436,7 @@ _git ()
 	ls-tree)     _git_ls_tree ;;
 	merge)       _git_merge;;
 	merge-base)  _git_merge_base ;;
+	name-rev)    _git_name_rev ;;
 	pull)        _git_pull ;;
 	push)        _git_push ;;
 	reset)       _git_reset ;;
@@ -459,6 +466,7 @@ complete -o default            -F _git_ls_remote git-ls-remote
 complete -o default -o nospace -F _git_ls_tree git-ls-tree
 complete -o default            -F _git_merge git-merge
 complete -o default            -F _git_merge_base git-merge-base
+complete -o default            -F _git_name_rev git-name-rev
 complete -o default -o nospace -F _git_pull git-pull
 complete -o default -o nospace -F _git_push git-push
 complete -o default            -F _git_reset git-reset
@@ -479,6 +487,7 @@ complete -o default -o nospace -F _git_diff_tree git-diff-tree.exe
 complete -o default -o nospace -F _git_log git-log.exe
 complete -o default -o nospace -F _git_ls_tree git-ls-tree.exe
 complete -o default            -F _git_merge_base git-merge-base.exe
+complete -o default            -F _git_name_rev git-name-rev.exe
 complete -o default -o nospace -F _git_push git-push.exe
 complete -o default -o nospace -F _git_log git-show-branch.exe
 complete -o default -o nospace -F _git_log git-whatchanged.exe
-- 
1.4.4.1.ge3fb

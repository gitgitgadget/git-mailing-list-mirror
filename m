From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] bash completion: add diff options
Date: Fri, 23 Nov 2007 01:11:35 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711230111110.27959@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Nov 23 02:12:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvN5L-00040v-Jy
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 02:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993AbXKWBLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 20:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800AbXKWBLl
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 20:11:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:37997 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751787AbXKWBLk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 20:11:40 -0500
Received: (qmail invoked by alias); 23 Nov 2007 01:11:38 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp035) with SMTP; 23 Nov 2007 02:11:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX181AJB4sVY1fL9yyJnxLdFORbSBsso0+epNFpHLc5
	naxxoWYHta1EqS
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65866>


I use "git diff" (the porcelain) really often, and am almost as often
annoyed that the completions do not know how to complete something simple
as --cached.  Now they do.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/completion/git-completion.bash |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 599b2fc..58e0e53 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -551,6 +551,20 @@ _git_describe ()
 
 _git_diff ()
 {
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--*)
+		__gitcomp "--cached --stat --numstat --shortstat --summary
+			--patch-with-stat --name-only --name-status --color
+			--no-color --color-words --no-renames --check
+			--full-index --binary --abbrev --diff-filter
+			--find-copies-harder --pickaxe-all --pickaxe-regex
+			--text --ignore-space-at-eol --ignore-space-change
+			--ignore-all-space --exit-code --quiet --ext-diff
+			--no-ext-diff"
+		return
+		;;
+	esac
 	__git_complete_file
 }
 
-- 
1.5.3.6.1977.g54d30

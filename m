From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] rebase -i --root: fix check for number of arguments
Date: Mon, 26 Jan 2009 00:32:13 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901260032000.14855@racer>
References: <alpine.DEB.1.00.0901260029480.14855@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 26 00:33:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRETU-0001f9-JZ
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 00:33:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbZAYXbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 18:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbZAYXbo
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 18:31:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:51674 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750971AbZAYXbn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 18:31:43 -0500
Received: (qmail invoked by alias); 25 Jan 2009 23:31:42 -0000
Received: from pD9EB3E0E.dip0.t-ipconnect.de (EHLO noname) [217.235.62.14]
  by mail.gmx.net (mp038) with SMTP; 26 Jan 2009 00:31:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18xNZ9/VWAxrRTjKCMu8tS2Xd3/H0LysPuTmehTl4
	UuCOjvmsND4LNu
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0901260029480.14855@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107132>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 6e2bf25..5df35b2 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -571,7 +571,8 @@ first and then run 'git rebase --continue' again."
 		;;
 	--)
 		shift
-		test ! -z "$REBASE_ROOT" -o $# -eq 1 -o $# -eq 2 || usage
+		test -z "$REBASE_ROOT" -a $# -ge 1 -a $# -le 2 ||
+		test ! -z "$REBASE_ROOT" -a $# -le 1 || usage
 		test -d "$DOTEST" &&
 			die "Interactive rebase already started"
 
-- 
1.6.1.482.g7d54be

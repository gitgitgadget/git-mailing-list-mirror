From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: clarify the "Ignoring error from SVN" piece
Date: Mon, 7 Jan 2008 02:40:40 -0800
Message-ID: <20080107104040.GA1594@soma>
References: <EA596F68-D87B-49AD-9DEF-2C2E07127BDE@gmail.com> <20080107103040.GA28557@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	"Michael J. Cohen" <michael.joseph.cohen@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 11:41:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBpPs-0006Hf-8g
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 11:41:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754468AbYAGKkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 05:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754538AbYAGKkm
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 05:40:42 -0500
Received: from hand.yhbt.net ([66.150.188.102]:32951 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754371AbYAGKkm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 05:40:42 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id F0A712DC08B;
	Mon,  7 Jan 2008 02:40:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20080107103040.GA28557@soma>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69782>

I've heard of several users puzzled by this, and it sometimes it
appears as if git-svn is doing nothing on slower connections and
larger repositories.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 2c97b05..3308fe1 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4085,6 +4085,10 @@ sub skip_unknown_revs {
 			warn "W: Ignoring error from SVN, path probably ",
 			     "does not exist: ($errno): ",
 			     $err->expanded_message,"\n";
+			warn "W: Do not be alarmed at the above message ",
+			     "git-svn is just searching aggressively for ",
+			     "old history.\n",
+			     "This may take a while on large repositories\n";
 			$ignored_err{$err_key} = 1;
 		}
 		return;
-- 
Eric Wong

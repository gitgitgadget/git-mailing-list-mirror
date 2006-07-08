From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] templates/hooks--update: replace diffstat calls with git diff --stat
Date: Sat, 8 Jul 2006 01:50:02 -0700
Message-ID: <20060708085002.GA3428@soma>
References: <11522670452824-git-send-email-normalperson@yhbt.net> <11522670473116-git-send-email-normalperson@yhbt.net> <7v7j2p3eac.fsf@assigned-by-dhcp.cox.net> <20060707110123.GA23400@soma> <7vpsghzmr1.fsf@assigned-by-dhcp.cox.net> <7v64i9zk0j.fsf@assigned-by-dhcp.cox.net> <20060708015844.GA13769@soma> <7vsllcr077.fsf@assigned-by-dhcp.cox.net> <20060708084121.GD29036@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 08 10:50:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fz8Vu-0004AJ-B5
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 10:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWGHIuG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Jul 2006 04:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWGHIuG
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 04:50:06 -0400
Received: from hand.yhbt.net ([66.150.188.102]:16064 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751274AbWGHIuE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jul 2006 04:50:04 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 59EE37DC021;
	Sat,  8 Jul 2006 01:50:03 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat,  8 Jul 2006 01:50:02 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060708084121.GD29036@hand.yhbt.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23484>

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 This was part of the previous patch, but useful on its own since
 we have our own internal diffstat

 templates/hooks--update |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/templates/hooks--update b/templates/hooks--update
index d7a8f0a..76d5ac2 100644
--- a/templates/hooks--update
+++ b/templates/hooks--update
@@ -60,7 +60,7 @@ then
 			echo "Changes since $prev:"
 			git rev-list --pretty $prev..$3 | $short
 			echo ---
-			git diff $prev..$3 | diffstat -p1
+			git diff --stat $prev..$3
 			echo ---
 		fi
 		;;
@@ -75,7 +75,7 @@ else
 	base=$(git-merge-base "$2" "$3")
 	case "$base" in
 	"$2")
-		git diff "$3" "^$base" | diffstat -p1
+		git diff --stat "$3" "^$base"
 		echo
 		echo "New commits:"
 		;;
-- 
1.4.1.g6a62

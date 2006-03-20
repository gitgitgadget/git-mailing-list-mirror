From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Add missing semicolon to sed command.
Date: Sun, 19 Mar 2006 19:18:08 -0500
Message-ID: <20060320001808.GB20765@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Mar 20 01:18:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FL86N-0007ao-7P
	for gcvg-git@gmane.org; Mon, 20 Mar 2006 01:18:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWCTASQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Mar 2006 19:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWCTASQ
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Mar 2006 19:18:16 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:26502 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751257AbWCTASP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Mar 2006 19:18:15 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FL860-0004cG-D7
	for git@vger.kernel.org; Sun, 19 Mar 2006 19:18:04 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 026F020FBA0; Sun, 19 Mar 2006 19:18:08 -0500 (EST)
To: git@vger.kernel.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17737>

generate-cmdlist.sh is giving errors messages from sed on Mac OS
10.4 due to a missing semicolon.

---

 generate-cmdlist.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

base f81e7c626f34658289594386b0273755f47912a2
last 09913c10d93adbfa61138b7ac7ae6a8a210aa29f
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 6ee85d5..76ba49c 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -42,7 +42,7 @@ EOF
 while read cmd
 do
     sed -n "/NAME/,/git-$cmd/H;
-	    \$ {x; s/.*git-$cmd - \\(.*\\)/  {\"$cmd\", \"\1\"},/; p}" \
+	    \$ {x; s/.*git-$cmd - \\(.*\\)/  {\"$cmd\", \"\1\"},/; p;}" \
 	"Documentation/git-$cmd.txt"
 done
 echo "};"
-- 
1.2.4.g41f6

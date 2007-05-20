From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH 2/2] Don't use / as separatar since it is common i branch names
Date: Sun, 20 May 2007 23:24:15 +0200
Message-ID: <20070520212205.17468.71900.stgit@lathund.dewire.com>
References: <20070520204627.GR19253@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: ydirson@altern.org, git@vger.kernel.org
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Sun May 20 23:25:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hpstf-0005Rl-WF
	for gcvg-git@gmane.org; Sun, 20 May 2007 23:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757105AbXETVYx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 17:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757112AbXETVYx
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 17:24:53 -0400
Received: from [83.140.172.130] ([83.140.172.130]:15578 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1757055AbXETVYw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 17:24:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 9D112802E1F;
	Sun, 20 May 2007 23:18:35 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 25790-09; Sun, 20 May 2007 23:18:35 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 4F2FC800783;
	Sun, 20 May 2007 23:18:35 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id CABB129238;
	Sun, 20 May 2007 23:25:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id qAbVEvISfmME; Sun, 20 May 2007 23:24:15 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 33CF829068;
	Sun, 20 May 2007 23:24:15 +0200 (CEST)
In-Reply-To: <20070520204627.GR19253@nan92-1-81-57-214-146.fbx.proxad.net>
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47925>

    Don't use / as separatar since it is common i branch names
    
    Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>

diff --git a/contrib/stgbashprompt.sh b/contrib/stgbashprompt.sh
index f4817a1..5927e67 100755
--- a/contrib/stgbashprompt.sh
+++ b/contrib/stgbashprompt.sh
@@ -9,8 +9,8 @@ if [ "$PS1" ]; then
 		ref=$(git-symbolic-ref HEAD 2> /dev/null) || return
 		br=${ref#refs/heads/}
 		top=$(tail -n 1 $git_dir/patches/$br/applied 2>/dev/null) \
-			&& top="/$top";
-		echo "[$br$top]"
+		top=${top:-(none)}
+		echo "[$top@$br]"
 	}
 	PS1='\u@\h:$(__prompt_git)\W\$ '
 fi

From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [StGit PATCH 1/2] Update the bash prompt from 'applied' instead of
	the obsolete 'current'
Date: Sun, 20 May 2007 22:04:03 +0200
Message-ID: <20070520200403.14633.26644.stgit@lathund.dewire.com>
References: <20070520200113.14633.90705.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: <20070506150852.8985.98091.stgit@yoghurt.dewire.com>
X-From: git-owner@vger.kernel.org Sun May 20 22:04:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hprdi-0000jm-Sz
	for gcvg-git@gmane.org; Sun, 20 May 2007 22:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755926AbXETUET (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 16:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755969AbXETUET
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 16:04:19 -0400
Received: from [83.140.172.130] ([83.140.172.130]:14986 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755888AbXETUER (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 16:04:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id B2D3D8030AC;
	Sun, 20 May 2007 21:58:00 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 25222-05; Sun, 20 May 2007 21:58:00 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 6950B800783;
	Sun, 20 May 2007 21:58:00 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id C949729210;
	Sun, 20 May 2007 22:04:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id pHvCtqEkmKRu; Sun, 20 May 2007 22:04:03 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 1371929238;
	Sun, 20 May 2007 22:04:03 +0200 (CEST)
In-Reply-To: <20070520200113.14633.90705.stgit@lathund.dewire.com>
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47898>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 contrib/stgbashprompt.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/stgbashprompt.sh b/contrib/stgbashprompt.sh
index 16bb39b..7c5dc76 100755
--- a/contrib/stgbashprompt.sh
+++ b/contrib/stgbashprompt.sh
@@ -8,8 +8,8 @@ if [ "$PS1" ]; then
 		git_dir=$(git-rev-parse --git-dir 2> /dev/null) || return
 		ref=$(git-symbolic-ref HEAD 2> /dev/null) || return
 		br=${ref#refs/heads/}
-		top=$(cat $git_dir/patches/$br/current 2>/dev/null) \
-			&& top="/$top"
+		top=$(tail -1 $git_dir/patches/$br/applied 2>/dev/null) \
+			&& top="/$top";
 		echo "[$br$top]"
 	}
 	PS1='\u@\h:$(__prompt_git)\W\$ '

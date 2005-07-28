From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] remove "-r" option to xargs
Date: Thu, 28 Jul 2005 16:48:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0507281647510.25783@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Jul 28 16:50:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dy9gm-0000DK-Lw
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 16:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbVG1Osa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 10:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVG1OsW
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 10:48:22 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:64432 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S261520AbVG1OsP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2005 10:48:15 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id B7582E2585
	for <git@vger.kernel.org>; Thu, 28 Jul 2005 16:48:13 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id 99D7CA8678
	for <git@vger.kernel.org>; Thu, 28 Jul 2005 16:48:13 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id 7D63CA5C84
	for <git@vger.kernel.org>; Thu, 28 Jul 2005 16:48:13 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 679EAE2585
	for <git@vger.kernel.org>; Thu, 28 Jul 2005 16:48:13 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


git-prune-script still contained that non-portable option.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 git-prune-script |    2 +-
 1 files changed, 1 insertion, 1 deletion

diff --git a/git-prune-script b/git-prune-script
--- a/git-prune-script
+++ b/git-prune-script
@@ -20,6 +20,6 @@ sed -ne '/unreachable /{
     s|\(..\)|\1/|p
 }' | {
 	cd "$GIT_OBJECT_DIRECTORY" || exit
-	xargs -r $dryrun rm -f
+	xargs $dryrun rm -f
 }

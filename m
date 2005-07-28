From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] support bc version 1.04
Date: Thu, 28 Jul 2005 16:48:37 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0507281648150.25783@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Jul 28 16:52:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dy9jH-0000T8-OC
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 16:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVG1Oun (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 10:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261480AbVG1Oss
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 10:48:48 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:3249 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S261493AbVG1Osi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2005 10:48:38 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id AF797E25B7
	for <git@vger.kernel.org>; Thu, 28 Jul 2005 16:48:37 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id 96D51913C9
	for <git@vger.kernel.org>; Thu, 28 Jul 2005 16:48:37 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id 7E84191393
	for <git@vger.kernel.org>; Thu, 28 Jul 2005 16:48:37 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 60FF8E25B7
	for <git@vger.kernel.org>; Thu, 28 Jul 2005 16:48:37 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Test t6002 unnecessarily fails when bc is a bit older than average.

Signed-off-by: Johannes.Schindelin <Johannes.Schindelin@gmx.de>

---

 t/t6002-rev-list-bisect.sh |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

ccea5a568914eafc07caf0c291afe5f962672cd3
diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
--- a/t/t6002-rev-list-bisect.sh
+++ b/t/t6002-rev-list-bisect.sh
@@ -11,8 +11,12 @@ bc_expr()
 {
 bc <<EOF
 scale=1
-define abs(x) { if (x>=0) { return x; } else { return -x; } }
-define floor(x) { save=scale; scale=0; result=x/1; scale=save; return result; }
+define abs(x) {
+	if (x>=0) { return (x); } else { return (-x); }
+}
+define floor(x) {
+	save=scale; scale=0; result=x/1; scale=save; return (result);
+}
 $*
 EOF
 }

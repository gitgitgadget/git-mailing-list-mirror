From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix test case for some sed
Date: Thu, 2 Mar 2006 12:43:51 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0603021243280.17912@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Mar 02 12:44:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEmDw-0000eO-5X
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 12:44:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWCBLnz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 06:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWCBLnz
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 06:43:55 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:50311 "EHLO
	mailrelay.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751411AbWCBLnz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Mar 2006 06:43:55 -0500
Received: from virusscan.mail (mail04.mail [172.25.1.103])
	by mailrelay.mail (Postfix) with ESMTP id 144761D72;
	Thu,  2 Mar 2006 12:43:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 0782F5CB2;
	Thu,  2 Mar 2006 12:43:52 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id DC6C9A7F;
	Thu,  2 Mar 2006 12:43:51 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17063>


Some versions of sed lack the "-i" option.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 t/t8001-annotate.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

7f024821ec45dc6eaf36c24f94931d58deb75201
diff --git a/t/t8001-annotate.sh b/t/t8001-annotate.sh
index cae1794..172908a 100755
--- a/t/t8001-annotate.sh
+++ b/t/t8001-annotate.sh
@@ -50,7 +50,8 @@ test_expect_success \
 test_expect_success \
     'merge-setup part 2' \
     'git checkout -b branch2 master &&
-     sed -i -e "s/2A quick brown/4A quick brown lazy dog/" file &&
+     sed -e "s/2A quick brown/4A quick brown lazy dog/" < file > file.new &&
+     mv file.new file &&
      GIT_AUTHOR_NAME="B2" git commit -a -m "Branch2-1"'
 
 test_expect_success \
-- 
1.2.4.g9520

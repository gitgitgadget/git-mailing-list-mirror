From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 1/2] Add test case that shows --topo-order, --max-age break
Date: Thu, 07 Jul 2005 12:38:44 +1000
Message-ID: <20050707023844.12919.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Thu Jul 07 04:43:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqMMX-0006ed-Rf
	for gcvg-git@gmane.org; Thu, 07 Jul 2005 04:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbVGGCnC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 22:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbVGGCkh
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 22:40:37 -0400
Received: from 203-217-64-103.dyn.iinet.net.au ([203.217.64.103]:39811 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S262218AbVGGCit (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2005 22:38:49 -0400
Received: (qmail 12929 invoked by uid 500); 7 Jul 2005 02:38:44 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Uncommented a test case that shows a --topo-order, --max-age break.

A subsequent patch witll fix this defect

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 t/t6003-rev-list-topo-order.sh |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

9b43fa5416abe653fd900abe491a38c5ec919758
diff --git a/t/t6003-rev-list-topo-order.sh b/t/t6003-rev-list-topo-order.sh
--- a/t/t6003-rev-list-topo-order.sh
+++ b/t/t6003-rev-list-topo-order.sh
@@ -289,16 +289,16 @@ EOF
 #
 # this test fails on --topo-order - a fix is required
 #
-#test_output_expect_success '--max-age=c3, --topo-order' "git-rev-list --topo-order --max-age=$(commit_date c3) l5" <<EOF
-#l5
-#l4
-#l3
-#a4
-#c3
-#b4
-#a3
-#a2
-#EOF
+test_output_expect_success '--max-age=c3, --topo-order' "git-rev-list --topo-order --max-age=$(commit_date c3) l5" <<EOF
+l5
+l4
+l3
+a4
+c3
+b4
+a3
+a2
+EOF
 
 test_output_expect_success 'one specified head reachable from another a4, c3, --topo-order' "list_duplicates git-rev-list --topo-order a4 c3" <<EOF
 EOF
------------

From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 2/3] Fix broken t6001 test case
Date: Thu, 30 Jun 2005 12:41:57 +1000
Message-ID: <20050630024157.32530.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Thu Jun 30 04:36:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dnou7-0007aq-9t
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 04:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262797AbVF3CmR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 22:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbVF3CmM
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 22:42:12 -0400
Received: from 203-173-52-158.dyn.iinet.net.au ([203.173.52.158]:43648 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S262794AbVF3Cl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2005 22:41:59 -0400
Received: (qmail 32540 invoked by uid 500); 30 Jun 2005 02:41:57 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This fix fixes a t/t6001 test case break that was hidden by a bug in the test case infrastructure.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 t/t6001-rev-list-merge-order.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

91f6943f32af5ef8057049ca551957c0f8e7816d
diff --git a/t/t6001-rev-list-merge-order.sh b/t/t6001-rev-list-merge-order.sh
--- a/t/t6001-rev-list-merge-order.sh
+++ b/t/t6001-rev-list-merge-order.sh
@@ -408,12 +408,12 @@ test_output_expect_success "max-count 10
 | b2
 EOF
 
-test_output_expect_success "max-count 10 - non merge order" 'git-rev-list --max-count=10 l5 | sort' <<EOF
+test_output_expect_success "max-count 10 - non merge order" 'git-rev-list --max-count=10 l5 | entag | sort' <<EOF
+a2
+a3
 a4
-b2
 b3
 b4
-c1
 c2
 c3
 l3
------------

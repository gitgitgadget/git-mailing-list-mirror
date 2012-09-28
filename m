From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 05/21] git p4 test: use client_view to build the initial client
Date: Fri, 28 Sep 2012 08:04:09 -0400
Message-ID: <1348833865-6093-6-git-send-email-pw@padd.com>
References: <1348833865-6093-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 14:06:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THZKl-0001h7-Um
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 14:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755124Ab2I1MGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 08:06:10 -0400
Received: from honk.padd.com ([74.3.171.149]:34961 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751259Ab2I1MGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 08:06:09 -0400
Received: from arf.padd.com (unknown [50.55.148.232])
	by honk.padd.com (Postfix) with ESMTPSA id E38945AF2;
	Fri, 28 Sep 2012 05:06:08 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 749EB31413; Fri, 28 Sep 2012 08:06:06 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.1.457.g468b3ef
In-Reply-To: <1348833865-6093-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206562>

Simplify the code a bit by using an existing function.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/lib-git-p4.sh | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 7061dce..890ee60 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -74,15 +74,8 @@ start_p4d() {
 	fi
 
 	# build a client
-	(
-		cd "$cli" &&
-		p4 client -i <<-EOF
-		Client: client
-		Description: client
-		Root: $cli
-		View: //depot/... //client/...
-		EOF
-	)
+	client_view "//depot/... //client/..." &&
+
 	return 0
 }
 
-- 
1.7.12.1.403.g28165e1

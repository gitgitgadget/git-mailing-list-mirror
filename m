From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 04/21] git p4 test: use client_view to build the initial client
Date: Sat, 26 Jan 2013 22:11:07 -0500
Message-ID: <1359256284-5660-5-git-send-email-pw@padd.com>
References: <1359256284-5660-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 27 04:13:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzIg9-0004ln-AQ
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 04:13:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755472Ab3A0DMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 22:12:49 -0500
Received: from honk.padd.com ([74.3.171.149]:58696 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755415Ab3A0DMr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 22:12:47 -0500
Received: from arf.padd.com (unknown [50.52.174.88])
	by honk.padd.com (Postfix) with ESMTPSA id 57B742F3F;
	Sat, 26 Jan 2013 19:12:47 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 4A23522838; Sat, 26 Jan 2013 22:12:44 -0500 (EST)
X-Mailer: git-send-email 1.8.1.1.517.gf5c753f
In-Reply-To: <1359256284-5660-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214654>

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
1.8.1.1.460.g6fa8886

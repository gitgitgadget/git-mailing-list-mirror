From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 12/21] git p4 test: use LineEnd unix in windows tests too
Date: Fri, 28 Sep 2012 08:04:16 -0400
Message-ID: <1348833865-6093-13-git-send-email-pw@padd.com>
References: <1348833865-6093-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 14:08:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THZN1-000348-6j
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 14:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754025Ab2I1MIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 08:08:30 -0400
Received: from honk.padd.com ([74.3.171.149]:34978 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222Ab2I1MI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 08:08:29 -0400
Received: from arf.padd.com (unknown [50.55.148.232])
	by honk.padd.com (Postfix) with ESMTPSA id 69AC45AF2;
	Fri, 28 Sep 2012 05:08:29 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 11AFD31413; Fri, 28 Sep 2012 08:08:27 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.1.457.g468b3ef
In-Reply-To: <1348833865-6093-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206569>

In all clients, even those created on windows, use unix line
endings.  This makes it possible to verify file contents without
doing OS-specific comparisons in all the tests.

Tests in t9802-git-p4-filetype.sh are used to make sure that
the other LineEnd options continue to work.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/lib-git-p4.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index e2941ac..fbd55ea 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -142,6 +142,7 @@ client_view() {
 		Description: $P4CLIENT
 		Root: $cli
 		AltRoots: $(native_path "$cli")
+		LineEnd: unix
 		View:
 		EOF
 		for arg ; do
-- 
1.7.12.1.403.g28165e1

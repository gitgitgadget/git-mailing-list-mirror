From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] t0003: properly quote $HOME
Date: Sun, 17 Oct 2010 21:13:53 +0200
Message-ID: <decc39532e1706c50964bad14c51d0bcd9ab09a6.1287342744.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Petr Onderka <gsvick@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 17 21:14:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7Ygk-0000mZ-1h
	for gcvg-git-2@lo.gmane.org; Sun, 17 Oct 2010 21:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455Ab0JQTOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Oct 2010 15:14:21 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:18211 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932323Ab0JQTOU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Oct 2010 15:14:20 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sun, 17 Oct
 2010 21:14:18 +0200
Received: from localhost.localdomain (129.132.208.211) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.218.12; Sun, 17 Oct
 2010 21:13:57 +0200
X-Mailer: git-send-email 1.7.3.1.266.g3c065
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159209>

6df42ab (Add global and system-wide gitattributes, 2010-09-01) forgot
to quote one instance of $HOME in the tests.  This broke the test for
me with the shell complaining about an ambiguous redirect (but only
when run with --root for some reason).

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/t0003-attributes.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 25205ac..e75153b 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -38,7 +38,7 @@ test_expect_success 'setup' '
 	) >a/b/.gitattributes
 	(
 		echo "global test=global"
-	) >$HOME/global-gitattributes
+	) >"$HOME"/global-gitattributes
 
 '
 
-- 
1.7.3.1.266.g3c065

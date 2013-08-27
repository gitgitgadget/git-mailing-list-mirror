From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 4/5] t6050-replace: add test to clean up all the replace
 refs
Date: Tue, 27 Aug 2013 21:48:26 +0200
Message-ID: <20130827194828.11172.6562.chriscool@tuxfamily.org>
References: <20130827194022.11172.56453.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 27 21:49:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEPGG-0006de-O4
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 21:49:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753832Ab3H0TtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 15:49:04 -0400
Received: from mail-1y.bbox.fr ([194.158.98.14]:58570 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753493Ab3H0TtB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 15:49:01 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id EB6A083;
	Tue, 27 Aug 2013 21:48:59 +0200 (CEST)
X-git-sha1: 8a24e57327e83157d1daa03d98dcfd67834f5f26 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20130827194022.11172.56453.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233148>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6050-replace.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 5c352c4..05be228 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -276,4 +276,10 @@ test_expect_success 'replaced and replacement objects must be of the same type'
 	grep "$BLOB. points to a replacement object of type .blob" err
 '
 
+test_expect_success 'replace ref cleanup' '
+	test -n "$(git replace)" &&
+	git replace -d $(git replace) &&
+	test -z "$(git replace)"
+'
+
 test_done
-- 
1.8.4.rc1.26.gdd51ee9

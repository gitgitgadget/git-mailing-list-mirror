From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 04/11] t6050-replace: add test to clean up all the replace
 refs
Date: Sat, 31 Aug 2013 21:12:07 +0200
Message-ID: <20130831191215.26699.14888.chriscool@tuxfamily.org>
References: <20130831190528.26699.33964.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 31 21:13:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFqcA-00015H-UV
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 21:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754199Ab3HaTNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 15:13:16 -0400
Received: from [194.158.98.15] ([194.158.98.15]:48094 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752775Ab3HaTNO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 15:13:14 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 392D55E;
	Sat, 31 Aug 2013 21:12:53 +0200 (CEST)
X-git-sha1: dcfbab6bea3df3166503f3084cec2679f10f9e80 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20130831190528.26699.33964.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233532>

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
1.8.4.rc1.31.g530f5ce.dirty

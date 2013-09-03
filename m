From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 04/11] t6050-replace: add test to clean up all the replace
 refs
Date: Tue, 03 Sep 2013 09:10:18 +0200
Message-ID: <20130903071026.29838.37890.chriscool@tuxfamily.org>
References: <20130903070551.29838.43576.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 09:17:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGkrh-00082e-3G
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 09:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548Ab3ICHRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 03:17:23 -0400
Received: from mail-1y.bbox.fr ([194.158.98.14]:53232 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932530Ab3ICHRT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 03:17:19 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 08BEE52;
	Tue,  3 Sep 2013 09:17:18 +0200 (CEST)
X-git-sha1: dcfbab6bea3df3166503f3084cec2679f10f9e80 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20130903070551.29838.43576.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233690>

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

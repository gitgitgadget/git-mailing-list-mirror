From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 4/5] t6050-replace: add test to clean up all the replace refs
Date: Sun, 25 Aug 2013 15:06:07 +0200
Message-ID: <20130825130609.4681.43592.chriscool@tuxfamily.org>
References: <20130825125940.4681.70226.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.orcg>,
	Thomas Rast <trast@inf.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 25 15:06:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDa1r-0003bG-H1
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 15:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295Ab3HYNGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 09:06:38 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:62415 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752946Ab3HYNGh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 09:06:37 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 7BCDD6B;
	Sun, 25 Aug 2013 15:06:36 +0200 (CEST)
X-git-sha1: c8c2bce823ca826b2cbcd5646d141f2efc072eb8 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20130825125940.4681.70226.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232956>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6050-replace.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 8f631ac..4807689 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -276,4 +276,10 @@ test_expect_success 'replaced and replacement objects must be of the same type'
 	grep "replace ref '\''$BLOB'\'' is of type '\''blob'\''" err
 '
 
+test_expect_success 'replace ref cleanup' '
+	test -n "$(git replace)" &&
+	git replace -d $(git replace) &&
+	test -z "$(git replace)"
+'
+
 test_done
-- 
1.8.4.rc1.24.g13dc82a

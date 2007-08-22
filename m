From: David Jack Olrik <david@olrik.dk>
Subject: [PATCH] Fixed non portable use of expr, and incorrect use of test -eq for string comparison.
Date: Wed, 22 Aug 2007 14:02:43 +0200
Message-ID: <11877841633473-git-send-email-david@olrik.dk>
Cc: David Jack Olrik <david@olrik.dk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 14:10:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INp2Y-0003GG-Kv
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 14:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758073AbXHVMKV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 08:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758030AbXHVMKU
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 08:10:20 -0400
Received: from barcrawl.dk ([149.6.48.213]:64917 "EHLO mail.barcrawl.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758036AbXHVMKS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 08:10:18 -0400
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Aug 2007 08:10:18 EDT
Received: from localhost (barcrawl.dk [149.6.48.213])
	by mail.barcrawl.dk (Postfix) with ESMTP id 9DECE7CB447;
	Wed, 22 Aug 2007 14:02:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail.wange.dk
Received: from mail.barcrawl.dk ([149.6.48.213])
	by localhost (barcrawl.dk [149.6.48.213]) (amavisd-new, port 10024)
	with ESMTP id a8GdB3fHSeTP; Wed, 22 Aug 2007 14:02:26 +0200 (CEST)
Received: from localhost.localdomain (barcrawl.dk [149.6.48.213])
	by mail.barcrawl.dk (Postfix) with ESMTP id 5BC7E7CB443;
	Wed, 22 Aug 2007 14:02:26 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.rc6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56371>


Signed-off-by: David Jack Olrik <david@olrik.dk>
---
 git-instaweb.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index b79c6b6..da8eb3f 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -30,7 +30,7 @@ test -z "$port" && port=1234
 
 start_httpd () {
 	httpd_only="`echo $httpd | cut -f1 -d' '`"
-	if test "`expr index $httpd_only /`" -eq '1' || \
+	if test "`echo $httpd_only | cut -c 1`" = '/' || \
 				which $httpd_only >/dev/null
 	then
 		$httpd $fqgitdir/gitweb/httpd.conf
-- 
1.5.3.rc6

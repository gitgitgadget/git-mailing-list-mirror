From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] t3510 (cherry-pick-sequence): add missing '&&'
Date: Mon,  4 Jun 2012 22:12:44 +0530
Message-ID: <1338828164-15316-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 04 18:45:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbaP1-0002Xt-HX
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 18:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524Ab2FDQpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 12:45:04 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54137 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932444Ab2FDQpD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 12:45:03 -0400
Received: by dady13 with SMTP id y13so6059838dad.19
        for <git@vger.kernel.org>; Mon, 04 Jun 2012 09:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer;
        bh=pMEZ/m5Bnfh9XFAyr3JtD+bGXF7/3NBu7edFxsT4L+A=;
        b=Ro09brs5Fu6e0md/r2KyviCsn1Ai3jgrTTRSTKugjkNO8r0bNoTCc0MbeC2fbRUWam
         /u4dadzk01CsUHhES/PrKPp+27Gq89g+QRiy9C/ikoxsac9Y+PY50tcbm49U+5XZYtgZ
         k/qxkuvbtV6AenKpopEiHMshMbiTQ9+9s1p6KD7ogCPthpth3RT4EvvzoY4lI9VBXU6R
         lwJqOWSJ2BZq+dOZ4RCg+p+xoCkT8y+Rusvi343ANl9REtjjmexBai7ne2dA1xYFtfoa
         8C5fM3meF1mRbfLPnIODLFiatsSrHXTQntMX8jbighqdDhBt+JvZu5Q+Yp9qD1vQ7jUn
         2LBg==
Received: by 10.68.222.197 with SMTP id qo5mr25591643pbc.72.1338828302506;
        Mon, 04 Jun 2012 09:45:02 -0700 (PDT)
Received: from localhost.localdomain ([122.174.84.68])
        by mx.google.com with ESMTPS id oy8sm13806712pbc.52.2012.06.04.09.45.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 04 Jun 2012 09:45:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199148>

Breaks in a test assertion's && chain can potentially hide failures
from earlier commands in the chain.  Fix an instance of this in the
setup.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Minor nit.  There aren't any other && chaining breakages in the file.

 t/t3510-cherry-pick-sequence.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 97f3710..f4e6450 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -31,7 +31,7 @@ test_cmp_rev () {
 }
 
 test_expect_success setup '
-	git config advice.detachedhead false
+	git config advice.detachedhead false &&
 	echo unrelated >unrelated &&
 	git add unrelated &&
 	test_commit initial foo a &&
-- 
1.7.10

From: Peter Collingbourne <peter@pcc.me.uk>
Subject: [PATCH 2/2] Truncate the SHA1 part of the submodule name to 7 characters
Date: Sat,  3 Apr 2010 21:04:40 +0100
Message-ID: <1270325080-22951-3-git-send-email-peter@pcc.me.uk>
References: <20100327094427.GA30216@progeny.tock>
Cc: Peter Collingbourne <peter@pcc.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 03 22:05:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ny9bC-0005tJ-Vn
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 22:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755912Ab0DCUF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Apr 2010 16:05:28 -0400
Received: from master.pcc.me.uk ([207.192.74.179]:40545 "EHLO master.pcc.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755900Ab0DCUFX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Apr 2010 16:05:23 -0400
Received: from lapas.pcc.me.uk ([10.179.130.3])
	by master.pcc.me.uk with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1Ny9as-0004iA-4W; Sat, 03 Apr 2010 21:05:22 +0100
Received: from peter by lapas.pcc.me.uk with local (Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1Ny9ao-0005zG-3W; Sat, 03 Apr 2010 21:05:18 +0100
X-Mailer: git-send-email 1.6.5
In-Reply-To: <20100327094427.GA30216@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143899>

The rationale is that a submodule naming clash is a highly infrequent
event (as compared to a file naming clash) so we can minimise the
ugliness of generated submodule names by using a smaller number
of characters.

Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
---
 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 4f0d7df..e85f2d1 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -127,7 +127,7 @@ gen_uid()
 	 echo "$path"
 	 echo $$
 	 date
-	) | git hash-object --stdin
+	) | git hash-object --stdin | cut -c1-7
 }
 
 #
-- 
1.6.5

From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 4/5] git-p4: adjust test to adhere to stricter useClientSpec
Date: Wed, 11 Jan 2012 18:31:09 -0500
Message-ID: <1326324670-15967-5-git-send-email-pw@padd.com>
References: <1326324670-15967-1-git-send-email-pw@padd.com>
Cc: Gary Gibbons <ggibbons@perforce.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 00:32:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl7ep-0006VS-KZ
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 00:32:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489Ab2AKXcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 18:32:35 -0500
Received: from honk.padd.com ([74.3.171.149]:34122 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133Ab2AKXcf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 18:32:35 -0500
Received: from arf.padd.com (unknown [50.55.142.76])
	by honk.padd.com (Postfix) with ESMTPSA id BB14C20D2;
	Wed, 11 Jan 2012 15:32:34 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 66F7031442; Wed, 11 Jan 2012 18:32:31 -0500 (EST)
X-Mailer: git-send-email 1.7.9.rc0.47.gc9457
In-Reply-To: <1326324670-15967-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188402>

This test relied on what now is seen as broken behavior
in --use-client-spec.  Change it to make sure it works
according to the new behavior as described in
ecb7cf9 (git-p4: rewrite view handling, 2012-01-02) and
c700b68 (git-p4: test client view handling, 2012-01-02).

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9806-git-p4-options.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9806-git-p4-options.sh b/t/t9806-git-p4-options.sh
index 1f1952a..0571602 100755
--- a/t/t9806-git-p4-options.sh
+++ b/t/t9806-git-p4-options.sh
@@ -146,7 +146,7 @@ test_expect_success 'clone --use-client-spec' '
 	(
 		cd "$git" &&
 		test_path_is_file bus/dir/f4 &&
-		test_path_is_file file1
+		test_path_is_missing file1
 	) &&
 	cleanup_git &&
 
@@ -159,7 +159,7 @@ test_expect_success 'clone --use-client-spec' '
 		"$GITP4" sync //depot/... &&
 		git checkout -b master p4/master &&
 		test_path_is_file bus/dir/f4 &&
-		test_path_is_file file1
+		test_path_is_missing file1
 	)
 '
 
-- 
1.7.8.1.409.g3e338.dirty

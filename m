From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Missing test_done
Date: Wed, 10 Aug 2005 22:15:02 -0400
Message-ID: <1123726502.18644.16.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Aug 11 04:16:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E32bH-0000hp-S5
	for gcvg-git@gmane.org; Thu, 11 Aug 2005 04:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbVHKCPG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Aug 2005 22:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbVHKCPF
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Aug 2005 22:15:05 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:20450 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932210AbVHKCPE
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2005 22:15:04 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1E32Yt-00071M-3f
	for git@vger.kernel.org; Wed, 10 Aug 2005 22:12:51 -0400
Received: from [127.0.0.1] (helo=dv.roinet.com)
	by dv.roinet.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.52)
	id 1E32b0-0004tu-Pe
	for git@vger.kernel.org; Wed, 10 Aug 2005 22:15:02 -0400
Received: (from proski@localhost)
	by dv.roinet.com (8.13.4/8.13.4/Submit) id j7B2F28p018839
	for git@vger.kernel.org; Wed, 10 Aug 2005 22:15:02 -0400
X-Authentication-Warning: dv.roinet.com: proski set sender to proski@gnu.org using -f
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

All test scripts should end with test_done, which reports the test
results.  In the future, it could be used for other purposes, e.g. to
distinguish graceful end from "exit" in a test.  This patch fixes
scripts that don't call test_done.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/t/t2003-checkout-cache-mkdir.sh b/t/t2003-checkout-cache-mkdir.sh
--- a/t/t2003-checkout-cache-mkdir.sh
+++ b/t/t2003-checkout-cache-mkdir.sh
@@ -93,3 +93,4 @@ test_expect_success \
      test -d tmp-path1 &&
      test -f tmp-path1/file1'
 
+test_done
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -66,3 +66,5 @@ test_expect_success \
        --exclude-from=.git/ignore \
        >output &&
      diff -u expect output'
+
+test_done
diff --git a/t/t4101-apply-nonl.sh b/t/t4101-apply-nonl.sh
--- a/t/t4101-apply-nonl.sh
+++ b/t/t4101-apply-nonl.sh
@@ -30,3 +30,5 @@ do
 	"git-apply <diff.$i-$j && diff frotz.$j frotz"
   done
 done
+
+test_done
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -52,3 +52,5 @@ test_expect_success \
 	git-send-pack --force ./victim/.git/ master &&
 	cmp victim/.git/refs/heads/master .git/refs/heads/master
 '
+
+test_done


-- 
Regards,
Pavel Roskin

From: Don Slutz <Don.Slutz@SierraAtlantic.com>
Subject: [PATCH v2 6/7] Fix tests to work with core.autocrlf=true -- test_cmp to cmp
Date: Wed, 13 May 2009 15:35:47 -0400
Message-ID: <1242243348-6690-7-git-send-email-Don.Slutz@SierraAtlantic.com>
References: <1242070141-2936-1-git-send-email-Don.Slutz@SierraAtlantic.com>
 <1242243348-6690-1-git-send-email-Don.Slutz@SierraAtlantic.com>
 <1242243348-6690-2-git-send-email-Don.Slutz@SierraAtlantic.com>
 <1242243348-6690-3-git-send-email-Don.Slutz@SierraAtlantic.com>
 <1242243348-6690-4-git-send-email-Don.Slutz@SierraAtlantic.com>
 <1242243348-6690-5-git-send-email-Don.Slutz@SierraAtlantic.com>
 <1242243348-6690-6-git-send-email-Don.Slutz@SierraAtlantic.com>
Cc: Don Slutz <Don.Slutz@SierraAtlantic.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 21:36:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4KFe-0005kd-PH
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 21:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510AbZEMTgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 15:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753083AbZEMTgR
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 15:36:17 -0400
Received: from krl.krl.com ([192.147.32.3]:59309 "EHLO krl.krl.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752509AbZEMTgK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 15:36:10 -0400
Received: from krl.krl.com (localhost [127.0.0.1])
	by krl.krl.com (8.13.1/8.13.1) with ESMTP id n4DJa9Xg006812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 May 2009 15:36:09 -0400
Received: (from slutz@localhost)
	by krl.krl.com (8.13.1/8.13.1/Submit) id n4DJa8Tu006811;
	Wed, 13 May 2009 15:36:09 -0400
X-Mailer: git-send-email 1.6.3.15.g49878
In-Reply-To: <1242243348-6690-6-git-send-email-Don.Slutz@SierraAtlantic.com>
X-Virus-Scanned: ClamAV version 0.94.2, clamav-milter version 0.94.2 on krl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119094>

Switch from using test_cmp to using cmp in these tests. They are
checking for correct CRLF handling.

Signed-off-by: Don Slutz <Don.Slutz@SierraAtlantic.com>
---
 t/t0024-crlf-archive.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0024-crlf-archive.sh b/t/t0024-crlf-archive.sh
index c7d0324..af084e5 100755
--- a/t/t0024-crlf-archive.sh
+++ b/t/t0024-crlf-archive.sh
@@ -22,7 +22,7 @@ test_expect_success 'tar archive' '
 	git archive --format=tar HEAD |
 	( mkdir untarred && cd untarred && "$TAR" -xf - )
 
-	test_cmp sample untarred/sample
+	cmp sample untarred/sample
 
 '
 
@@ -39,7 +39,7 @@ test_expect_success UNZIP 'zip archive' '
 
 	( mkdir unzipped && cd unzipped && unzip ../test.zip ) &&
 
-	test_cmp sample unzipped/sample
+	cmp sample unzipped/sample
 
 '
 
-- 
1.6.3.15.g49878

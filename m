From: Johan Herland <johan@herland.net>
Subject: [PATCH] Selftest for verifying 'git verify-pack -v' with multiple arguments
Date: Fri, 22 Aug 2008 15:45:55 +0200
Message-ID: <200808221545.55709.johan@herland.net>
References: <200808221439.31219.johan@herland.net> <200808221527.21971.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 15:47:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWWzQ-0000rC-CF
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 15:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbYHVNqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 09:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbYHVNqk
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 09:46:40 -0400
Received: from sam.opera.com ([213.236.208.81]:37853 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038AbYHVNqk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 09:46:40 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id m7MDjtt3008599
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 22 Aug 2008 13:45:56 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <200808221527.21971.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93297>

This is set to expect failure. Please update when fixing the associated bug.

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t5300-pack-object.sh |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 645583f..339375a 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -186,6 +186,12 @@ test_expect_success \
 			test-2-${packname_2}.idx \
 			test-3-${packname_3}.idx'
 
+test_expect_failure \
+    'verify pack -v' \
+    'git verify-pack -v	test-1-${packname_1}.idx \
+			test-2-${packname_2}.idx \
+			test-3-${packname_3}.idx'
+
 test_expect_success \
     'verify-pack catches mismatched .idx and .pack files' \
     'cat test-1-${packname_1}.idx >test-3.idx &&
-- 
1.6.0.96.g2fad1

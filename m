From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [RFC 1/6] git-check-attr: test that no output is written to stderr
Date: Thu, 28 Jul 2011 12:37:00 +0200
Message-ID: <1311849425-9057-2-git-send-email-mhagger@alum.mit.edu>
References: <1311849425-9057-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 12:37:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmNyI-0007Q2-B4
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 12:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755281Ab1G1KhT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 06:37:19 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:32846 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248Ab1G1KhR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 06:37:17 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1QmNvm-0001Zr-9a; Thu, 28 Jul 2011 12:35:06 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1311849425-9057-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178056>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t0003-attributes.sh |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 5acb2d5..4f2fbc0 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -9,9 +9,10 @@ attr_check () {
 	path="$1"
 	expect="$2"
 
-	git check-attr test -- "$path" >actual &&
+	git check-attr test -- "$path" >actual 2>err &&
 	echo "$path: test: $2" >expect &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+	test_line_count = 0 err
 
 }
 
-- 
1.7.6.8.gd2879

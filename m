From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 1/6] git-check-attr: test that no output is written to stderr
Date: Thu,  4 Aug 2011 06:47:43 +0200
Message-ID: <1312433268-11385-2-git-send-email-mhagger@alum.mit.edu>
References: <1312433268-11385-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 06:48:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoprC-0000n2-9l
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 06:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063Ab1HDEsH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 00:48:07 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:39748 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964Ab1HDEsA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 00:48:00 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB339.dip.t-dialin.net [84.190.179.57])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p744ltPW029942;
	Thu, 4 Aug 2011 06:47:56 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1312433268-11385-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178698>


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

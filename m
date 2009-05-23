From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC/PATCH 2/2] OpenSolaris 200811 (SunOS 5.11) does not want
 OLD_ICONV
Date: Sat, 23 May 2009 12:24:57 -0700
Message-ID: <1243106697-6424-3-git-send-email-gitster@pobox.com>
References: <1243106697-6424-1-git-send-email-gitster@pobox.com>
 <1243106697-6424-2-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 23 21:25:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7wqq-0002Cd-8E
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 21:25:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756700AbZEWTZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 15:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756386AbZEWTZH
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 15:25:07 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54878 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755472AbZEWTZA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 15:25:00 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 36CF119154
	for <git@vger.kernel.org>; Sat, 23 May 2009 15:25:02 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CEB2C19153 for
 <git@vger.kernel.org>; Sat, 23 May 2009 15:25:01 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.1.145.gb74d77
In-Reply-To: <1243106697-6424-2-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 6989A26E-47CF-11DE-A464-B4FDD46C8AFF-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119799>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 26d180c..a23846b 100644
--- a/Makefile
+++ b/Makefile
@@ -698,7 +698,9 @@ ifeq ($(uname_S),SunOS)
 	NO_MEMMEM = YesPlease
 	NO_HSTRERROR = YesPlease
 	NO_MKDTEMP = YesPlease
-	OLD_ICONV = UnfortunatelyYes
+	ifneq ($(uname_R),5.11)
+		OLD_ICONV = UnfortunatelyYes
+	endif
 	ifeq ($(uname_R),5.8)
 		NO_UNSETENV = YesPlease
 		NO_SETENV = YesPlease
-- 
1.6.3.1.145.gb74d77

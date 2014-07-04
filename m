From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 3/5] Run the perf test suite for profile feedback too
Date: Fri,  4 Jul 2014 16:43:50 -0700
Message-ID: <1404517432-25185-4-git-send-email-andi@firstfloor.org>
References: <1404517432-25185-1-git-send-email-andi@firstfloor.org>
Cc: Andi Kleen <ak@linux.intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 05 01:45:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X3DAA-0006Io-A6
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jul 2014 01:45:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760278AbaGDXov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2014 19:44:51 -0400
Received: from one.firstfloor.org ([193.170.194.197]:53375 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757341AbaGDXou (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2014 19:44:50 -0400
Received: from basil.firstfloor.org (184-100-237-164.ptld.qwest.net [184.100.237.164])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id 2701B8677C;
	Sat,  5 Jul 2014 01:44:48 +0200 (CEST)
Received: by basil.firstfloor.org (Postfix, from userid 1000)
	id 36F48A18A9; Fri,  4 Jul 2014 16:43:59 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1404517432-25185-1-git-send-email-andi@firstfloor.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252910>

From: Andi Kleen <ak@linux.intel.com>

Open: If the perf test suite is representative enough it may
be reasonable to only run that and skip the much longer full
test suite. Thoughts?

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index a9770ac..ba64be9 100644
--- a/Makefile
+++ b/Makefile
@@ -1647,6 +1647,7 @@ ifeq ($(filter all,$(MAKECMDGOALS)),all)
 all:: profile-clean
 	$(MAKE) PROFILE=GEN all
 	$(MAKE) PROFILE=GEN -j1 test
+	$(MAKE) PROFILE=GEN -j1 perf
 endif
 endif
 
-- 
2.0.1

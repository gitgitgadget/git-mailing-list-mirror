From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH] Add explanation of the profile feedback build to the README
Date: Mon, 20 Jun 2011 15:41:01 -0700
Message-ID: <1308609661-28650-1-git-send-email-andi@firstfloor.org>
Cc: Andi Kleen <ak@linux.intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 21 00:42:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYnB2-0001mF-3r
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 00:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755587Ab1FTWme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 18:42:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:50264 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755534Ab1FTWme (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 18:42:34 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 20 Jun 2011 15:42:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,396,1304319600"; 
   d="scan'208";a="20599978"
Received: from tassilo.jf.intel.com ([10.7.201.108])
  by fmsmga001.fm.intel.com with ESMTP; 20 Jun 2011 15:42:31 -0700
Received: by tassilo.jf.intel.com (Postfix, from userid 501)
	id 6D6C6241C46; Mon, 20 Jun 2011 15:41:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176105>

From: Andi Kleen <ak@linux.intel.com>

Also explains that the are additional warnings.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 INSTALL |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/INSTALL b/INSTALL
index 16e45f1..bbb9d4d 100644
--- a/INSTALL
+++ b/INSTALL
@@ -25,6 +25,19 @@ set up install paths (via config.mak.autogen), so you can write instead
 	$ make all doc ;# as yourself
 	# make install install-doc install-html;# as root
 
+If you're willing to trade off (much) longer build time for a later
+faster git you can also do a profile feedback build with
+
+	$ make profile-all
+	# make prefix=... install
+
+This will run the complete test suite as training workload and then
+rebuild git with the generated profile feedback. This results in a git
+which is a few percent faster on CPU intensive workloads.  This
+may be a good tradeoff for distribution packagers.
+
+Note that the profile feedback build stage currently generates
+a lot of additional compiler warnings.
 
 Issues of note:
 
-- 
1.7.4.4

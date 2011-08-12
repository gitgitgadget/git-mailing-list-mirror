From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/7] Document struct match_attr
Date: Fri, 12 Aug 2011 23:43:05 +0200
Message-ID: <1313185390-19724-3-git-send-email-mhagger@alum.mit.edu>
References: <1313185390-19724-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 23:43:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrzW5-0008AU-Df
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 23:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752361Ab1HLVnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 17:43:40 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:40853 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336Ab1HLVnj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 17:43:39 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.homenet.telecomitalia.it (p54BEAA34.dip.t-dialin.net [84.190.170.52])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p7CLhCvH007606;
	Fri, 12 Aug 2011 23:43:32 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1313185390-19724-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179250>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 attr.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/attr.c b/attr.c
index 6bc7ae9..c33e413 100644
--- a/attr.c
+++ b/attr.c
@@ -113,6 +113,20 @@ struct attr_state {
 	const char *setto;
 };
 
+/*
+ * One rule, as from a .gitattributes file.
+ *
+ * If is_macro is true, then u.attr is a pointer to the git_attr being
+ * defined.
+ *
+ * If is_macro is false, then u.pattern points at the filename pattern
+ * to which the rule applies.  (The memory pointed to is part of the
+ * memory block allocated for the match_attr instance.)
+ *
+ * In either case, num_attr is the number of attributes affected by
+ * this rule, and state is an array listing them.  The attributes are
+ * listed as they appear in the file (macros unexpanded).
+ */
 struct match_attr {
 	union {
 		char *pattern;
-- 
1.7.6.8.gd2879

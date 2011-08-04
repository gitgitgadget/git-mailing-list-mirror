From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 12/23] Remove redundant check
Date: Thu,  4 Aug 2011 06:36:22 +0200
Message-ID: <1312432593-9841-13-git-send-email-mhagger@alum.mit.edu>
References: <1312432593-9841-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 06:37:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QopgV-0005Mu-4m
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 06:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669Ab1HDEhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 00:37:22 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:39659 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084Ab1HDEhC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 00:37:02 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB339.dip.t-dialin.net [84.190.179.57])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p744agHq029203;
	Thu, 4 Aug 2011 06:36:59 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1312432593-9841-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178679>

bootstrap_attr_stack() also checks whether attr_stack is already set.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 attr.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/attr.c b/attr.c
index b8ce158..ab30c81 100644
--- a/attr.c
+++ b/attr.c
@@ -565,8 +565,7 @@ static void prepare_attr_stack(const char *path)
 	 * .gitattributes in deeper directories to shallower ones,
 	 * and finally use the built-in set as the default.
 	 */
-	if (!attr_stack)
-		bootstrap_attr_stack();
+	bootstrap_attr_stack();
 
 	/*
 	 * Pop the "info" one that is always at the top of the stack.
-- 
1.7.6.8.gd2879

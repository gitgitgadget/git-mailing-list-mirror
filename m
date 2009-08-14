From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH] revert: Remove printing fullstop after the commit hash
Date: Fri, 14 Aug 2009 15:26:12 +0530
Message-ID: <1250243772-17556-1-git-send-email-amit.shah@redhat.com>
Cc: Amit Shah <amit.shah@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 14 11:56:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbtWY-0007WC-Os
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 11:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773AbZHNJ4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 05:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753597AbZHNJ4a
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 05:56:30 -0400
Received: from mx2.redhat.com ([66.187.237.31]:49317 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752621AbZHNJ4a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 05:56:30 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n7E9uV9R018579
	for <git@vger.kernel.org>; Fri, 14 Aug 2009 05:56:31 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n7E9uUVn014853;
	Fri, 14 Aug 2009 05:56:30 -0400
Received: from localhost (vpn-12-66.rdu.redhat.com [10.11.12.66])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n7E9uRTc014778;
	Fri, 14 Aug 2009 05:56:29 -0400
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125923>

Copy-pasting the commit id from a revert message selects
the trailing fullstop as well which has to be removed
after pasting. That's inefficient.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 builtin-revert.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index 151aa6a..7f0c22c 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -346,7 +346,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 			add_to_msg(", reversing\nchanges made to ");
 			add_to_msg(sha1_to_hex(parent->object.sha1));
 		}
-		add_to_msg(".\n");
+		add_to_msg("\n");
 	} else {
 		base = parent;
 		next = commit;
-- 
1.6.2.5

From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] filter-branch: added missing warn function
Date: Wed,  4 Jul 2007 10:36:24 +0200
Message-ID: <11835381843502-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 04 10:36:30 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I60Ld-0007PD-6u
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 10:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756052AbXGDIg1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 04:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755881AbXGDIg1
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 04:36:27 -0400
Received: from mailer.zib.de ([130.73.108.11]:51023 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755246AbXGDIg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 04:36:26 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l648aPth004698
	for <git@vger.kernel.org>; Wed, 4 Jul 2007 10:36:25 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l648aOKR023217;
	Wed, 4 Jul 2007 10:36:24 +0200 (MEST)
X-Mailer: git-send-email 1.5.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51581>

--tag-name-filter may have failed before because
warn is used for reporting but was not available.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 git-filter-branch.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index a2fcebc..958f28e 100644
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -194,6 +194,10 @@ set -e
 USAGE="git-filter-branch [-d TEMPDIR] [FILTERS] DESTBRANCH [REV-RANGE]"
 . git-sh-setup
 
+warn () {
+        echo "$*" >&2
+}
+
 map()
 {
 	# if it was not rewritten, take the original
-- 
1.5.2.2.647.g75b2fc

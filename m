From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] gitk: add check for required tcl version >= 8.4
Date: Fri, 28 Sep 2007 22:57:22 +0200
Message-ID: <11910130423769-git-send-email-prohaska@zib.de>
References: <915048.40970.qm@web38908.mail.mud.yahoo.com>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 22:57:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbMuF-0000Qy-CC
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 22:57:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173AbXI1U50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 16:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753053AbXI1U5Z
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 16:57:25 -0400
Received: from mailer.zib.de ([130.73.108.11]:38506 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752624AbXI1U5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 16:57:25 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l8SKvNLl015659
	for <git@vger.kernel.org>; Fri, 28 Sep 2007 22:57:23 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l8SKvMJp016690;
	Fri, 28 Sep 2007 22:57:22 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <915048.40970.qm@web38908.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59419>

gitk requires tcl version >= 8.4 to work flawlessly. So let's
check the tcl version and quit if it's too low.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 gitk |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index 300fdce..6ea6489 100755
--- a/gitk
+++ b/gitk
@@ -7,6 +7,11 @@ exec wish "$0" -- "$@"
 # and distributed under the terms of the GNU General Public Licence,
 # either version 2, or (at your option) any later version.
 
+if {[info tclversion] < 8.4} {
+   puts stderr "Sorry, gitk requires tcl version >= 8.4."
+   exit 1 
+}
+
 proc gitdir {} {
     global env
     if {[info exists env(GIT_DIR)]} {
-- 
1.5.3.2.111.g5166

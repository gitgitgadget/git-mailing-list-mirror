From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] git-gui: accept versions containing text annotations, like 1.5.3.mingw.1
Date: Sat,  6 Oct 2007 15:27:22 +0200
Message-ID: <11916772423623-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Oct 06 15:27:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ie9hB-0001HR-7u
	for gcvg-git-2@gmane.org; Sat, 06 Oct 2007 15:27:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755242AbXJFN1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2007 09:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753408AbXJFN1i
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Oct 2007 09:27:38 -0400
Received: from mailer.zib.de ([130.73.108.11]:55704 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751199AbXJFN1h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2007 09:27:37 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l96DRN45002831;
	Sat, 6 Oct 2007 15:27:23 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l96DRMG3029603;
	Sat, 6 Oct 2007 15:27:23 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60146>

This commit teaches git-gui to accept versions with annotations
that start with text and optionally end with a dot followed by
a number.

This is needed by the current versioning scheme of msysgit,
which uses versions like 1.5.3.mingw.1. However, the changes
is not limited to this use case. Any version of the form
<numeric version>.<anytext>.<number> would be parsed and only
the starting <numeric version> used for validation.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 git-gui/git-gui.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index bb1e7f3..f671eea 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -666,6 +666,7 @@ regsub -- {-dirty$} $_git_version {} _git_version
 regsub {\.[0-9]+\.g[0-9a-f]+$} $_git_version {} _git_version
 regsub {\.rc[0-9]+$} $_git_version {} _git_version
 regsub {\.GIT$} $_git_version {} _git_version
+regsub {\.[a-zA-Z]+(\.[0-9]+)$} $_git_version {} _git_version
 
 if {![regexp {^[1-9]+(\.[0-9]+)+$} $_git_version]} {
 	catch {wm withdraw .}
-- 
1.5.3.mingw.1.106.g1610f-dirty

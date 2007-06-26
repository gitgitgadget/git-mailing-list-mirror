From: Quy Tonthat <qtonthat@gmail.com>
Subject: [PATCH] git.spec: RPM failed, looking for wrong files.
Date: Wed, 27 Jun 2007 01:39:07 +1000
Message-ID: <11828723472594-git-send-email-qtonthat@gmail.com>
Cc: git@vger.kernel.org, Quy Tonthat <qtonthat@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jun 26 21:15:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3GVh-0000MH-Hy
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 21:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759927AbXFZTPO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 15:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759696AbXFZTPN
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 15:15:13 -0400
Received: from pecan.exetel.com.au ([220.233.0.17]:49655 "EHLO
	pecan.exetel.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759610AbXFZTPM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 15:15:12 -0400
X-Greylist: delayed 12961 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Jun 2007 15:15:12 EDT
Received: from 95.69.233.220.exetel.com.au ([220.233.69.95] helo=localhost.localdomain)
	by pecan.exetel.com.au with esmtp (Exim 4.63)
	(envelope-from <qtonthat@gmail.com>)
	id 1I3D8F-0007Sb-KA; Wed, 27 Jun 2007 01:39:08 +1000
X-Mailer: git-send-email 1.5.2.2.2q
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50971>

RPM build broke with "File not found" error on git-gui.1 and git-citool.1
They actually are git-gui.1.gz and git-citool.1.gz

Signed-off-by: Quy Tonthat <qtonthat@gmail.com>
---
 git.spec.in |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/git.spec.in b/git.spec.in
index 287057e..27182ba 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -164,9 +164,9 @@ rm -rf $RPM_BUILD_ROOT
 %{_bindir}/git-gui
 %{_bindir}/git-citool
 %{_datadir}/git-gui/
-%{!?_without_docs: %{_mandir}/man1/git-gui.1}
+%{!?_without_docs: %{_mandir}/man1/git-gui.1*}
 %{!?_without_docs: %doc Documentation/git-gui.html}
-%{!?_without_docs: %{_mandir}/man1/git-citool.1}
+%{!?_without_docs: %{_mandir}/man1/git-citool.1*}
 %{!?_without_docs: %doc Documentation/git-citool.html}
 
 %files -n gitk
@@ -187,6 +187,9 @@ rm -rf $RPM_BUILD_ROOT
 %{!?_without_docs: %doc Documentation/technical}
 
 %changelog
+* Tue Jun 26 2007 Quy Tonthat <qtonthat@gmail.com>
+- Fixed problems looking for wrong manpages.
+
 * Thu Jun 21 2007 Shawn O. Pearce <spearce@spearce.org>
 - Added documentation files for git-gui
 
-- 
1.5.2.2.2q

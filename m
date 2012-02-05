From: Michael <kensington@astralcloak.net>
Subject: [PATCH] Explicitly set X to avoid potential build breakage
Date: Sun, 05 Feb 2012 21:41:11 +1100
Message-ID: <9854382.GTBzd7D6AT@telegraph>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 05 11:49:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rtzet-00015u-Lf
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 11:49:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754123Ab2BEKtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 05:49:17 -0500
Received: from astralcloak.net ([66.246.75.167]:44794 "EHLO
	mail.astralcloak.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152Ab2BEKtR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 05:49:17 -0500
X-Greylist: delayed 479 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Feb 2012 05:49:17 EST
Received: from mail.astralcloak.net (mail.astralcloak.net [127.0.0.1]) by mail.astralcloak.net (Postfix) with ESMTPSA id E382DF0202
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189938>

$X is appended to binary names for Windows builds (ie. git.exe).
Pollution from the environment can inadvertently trigger this behaviour,
resulting in 'git' turning into 'gitwhatever' without warning.

Signed-off-by: Michael <kensington@astralcloak.net>
---
 Makefile |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index c457c34..380d96f 100644
--- a/Makefile
+++ b/Makefile
@@ -388,6 +388,9 @@ SCRIPT_SH =
 SCRIPT_LIB =
 TEST_PROGRAMS_NEED_X =
 
+# Binary suffix used for Windows builds
+X =
+
 # Having this variable in your environment would break pipelines because
 # you cause "cd" to echo its destination to stdout.  It can also take
 # scripts to unexpected places.  If you like CDPATH, define it for your
-- 
1.7.8.4

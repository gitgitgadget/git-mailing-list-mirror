From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 2/3] git-gui (Windows): Switch to relative discovery of oguilib
Date: Sun, 27 Jul 2008 18:49:42 +0200
Message-ID: <1217177383-25272-3-git-send-email-prohaska@zib.de>
References: <1217177383-25272-1-git-send-email-prohaska@zib.de>
 <1217177383-25272-2-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>,
	Steffen Prohaska <prohaska@zib.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jul 27 18:51:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KN9TA-0003zM-AA
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 18:51:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756479AbYG0Qu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 12:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757317AbYG0QuX
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 12:50:23 -0400
Received: from mailer.zib.de ([130.73.108.11]:37022 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752993AbYG0QuW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 12:50:22 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6RGniQX022150;
	Sun, 27 Jul 2008 18:49:53 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6RGnhW2014519;
	Sun, 27 Jul 2008 18:49:44 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1217177383-25272-2-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90344>

Instead of using an absolute path, git-gui can discover its
gui library using a relative path from execdir.  We want to
use the relative path discovery on MinGW to avoid issues
with translation of absolute paths.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 git-gui/Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-gui/Makefile b/git-gui/Makefile
index b19fb2d..ec4b33e 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -156,6 +156,7 @@ endif
 ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_MSGFMT=1
 	GITGUI_WINDOWS_WRAPPER := YesPlease
+	GITGUI_RELATIVE := 1
 endif
 
 ifdef GITGUI_MACOSXAPP
-- 
1.6.0.rc0.79.gb0320

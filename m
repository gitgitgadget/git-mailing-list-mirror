From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH v2] git-gui: set NO_MSGFMT to force using pure tcl replacement in msysgit
Date: Wed, 10 Oct 2007 08:58:58 +0200
Message-ID: <11919995392158-git-send-email-prohaska@zib.de>
References: <8F81028C-9924-4AA2-A58D-961AD10F5315@zib.de>
Cc: Johannes.Schindelin@gmx.de, git@vger.kernel.org,
	Steffen Prohaska <prohaska@zib.de>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Oct 10 08:59:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfVXF-0002Ma-KI
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 08:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752381AbXJJG7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 02:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752420AbXJJG7E
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 02:59:04 -0400
Received: from mailer.zib.de ([130.73.108.11]:34342 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752336AbXJJG7E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 02:59:04 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9A6wxR2012434;
	Wed, 10 Oct 2007 08:58:59 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9A6wxWo006293;
	Wed, 10 Oct 2007 08:58:59 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <8F81028C-9924-4AA2-A58D-961AD10F5315@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60469>

Shawn's git-gui Makefile supports the pure tcl replacement
for msgfmt if setting NO_MSGFMT. This patch sets the NO_MSGFMT
for msysgit.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 git-gui/Makefile |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-gui/Makefile b/git-gui/Makefile
index 818a0ab..c805450 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -126,6 +126,9 @@ ifeq ($(uname_S),Darwin)
 		GITGUI_MACOSXAPP := YesPlease
 	endif
 endif
+ifneq (,$(findstring MINGW,$(uname_S)))
+	NO_MSGFMT=1
+endif
 
 ifdef GITGUI_MACOSXAPP
 GITGUI_MAIN := git-gui.tcl
-- 
1.5.3.mingw.1.105.gf0c04

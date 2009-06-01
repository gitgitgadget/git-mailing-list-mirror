From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 05/11 v2] MinGW: fix warning about implicit declaration of _getch()
Date: Mon,  1 Jun 2009 08:41:45 +0200
Message-ID: <1243838505-27641-1-git-send-email-prohaska@zib.de>
References: <200905312152.11434.j6t@kdbg.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 08:42:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MB1Dd-0004sL-TR
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 08:42:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753943AbZFAGly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 02:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753160AbZFAGlx
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 02:41:53 -0400
Received: from mailer.zib.de ([130.73.108.11]:63609 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752149AbZFAGlw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 02:41:52 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n516fjx8008156;
	Mon, 1 Jun 2009 08:41:50 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n516fjh4016200;
	Mon, 1 Jun 2009 08:41:45 +0200 (MEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <200905312152.11434.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120446>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

conio.h provides the declaration.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 compat/mingw.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

This replaces 05/11.  The original commit messages was
misleading.  Apparently, the original 05/11 solved two things.
First, it fixed a warning in winansi.c, which has been squashed
into 03/11.  Second, it fixed a warning about implict decl of
_getch().  Including conio.h in mingw.c is sufficient to fix
this warning.

diff --git a/compat/mingw.c b/compat/mingw.c
index e190fdd..12d0c2f 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1,5 +1,6 @@
 #include "../git-compat-util.h"
 #include "win32.h"
+#include <conio.h>
 #include "../strbuf.h"
 
 unsigned int _CRT_fmode = _O_BINARY;
-- 
1.6.3.1.54.g99dd

From: David Soria Parra <sn_@gmx.net>
Subject: [PATCH] Fix compiler warning by properly initialize failed_errno
Date: Sun,  2 Aug 2009 21:34:35 +0200
Message-ID: <1249241675-77329-1-git-send-email-sn_@gmx.net>
Cc: David Soria Parra <dsp@php.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 02 21:35:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXgpU-0006n4-Mn
	for gcvg-git-2@gmane.org; Sun, 02 Aug 2009 21:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512AbZHBTel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Aug 2009 15:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753510AbZHBTel
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Aug 2009 15:34:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:60254 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753416AbZHBTek (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2009 15:34:40 -0400
Received: (qmail invoked by alias); 02 Aug 2009 19:34:39 -0000
Received: from e180066103.adsl.alicedsl.de (EHLO localhost.localdomain) [85.180.66.103]
  by mail.gmx.net (mp020) with SMTP; 02 Aug 2009 21:34:39 +0200
X-Authenticated: #4427663
X-Provags-ID: V01U2FsdGVkX18HqTQbutUHzXSsl9OdWdYCnmGasVlgyBnMBbqb/S
	/I51qTmrWOUSfL
X-Mailer: git-send-email 1.6.4.212.g4719.dirty
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124676>

From: David Soria Parra <dsp@php.net>

Initilize failed_error in start_command to avoid compiler warnings

Signed-off-by: David Soria Parra <dsp@php.net>
---
 run-command.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/run-command.c b/run-command.c
index dc09433..510349b 100644
--- a/run-command.c
+++ b/run-command.c
@@ -19,7 +19,7 @@ int start_command(struct child_process *cmd)
 {
 	int need_in, need_out, need_err;
 	int fdin[2], fdout[2], fderr[2];
-	int failed_errno;
+	int failed_errno = 0;
 
 	/*
 	 * In case of errors we must keep the promise to close FDs
-- 
1.6.4.212.g4719.dirty

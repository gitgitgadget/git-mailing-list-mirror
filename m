From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH QGit] Don't hardcode GIT_EXEC_DIR for Windows so much
Date: Sat, 18 Apr 2009 17:04:39 +0200
Message-ID: <1240067079-31358-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 18 17:06:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvC7s-0002Zj-D8
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 17:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755100AbZDRPEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 11:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754737AbZDRPEj
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 11:04:39 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:59794 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591AbZDRPEi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 11:04:38 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 73E1110036FE9;
	Sat, 18 Apr 2009 17:04:37 +0200 (CEST)
Received: from [89.59.75.158] (helo=localhost.localdomain)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LvC5t-0001BJ-00; Sat, 18 Apr 2009 17:04:37 +0200
X-Mailer: git-send-email 1.6.3.rc0.77.g079dc
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18fVmzfFyTkdKH/Exbsi4r24FF2H5T5KtywNtPB
	FwVc85lf4AQvTCZdoll9bv+3AxM/peKj4ve50c6K+IRK+uFPgN
	a4Ww44LzUpg4JOKZe1Sg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116828>

Use the environment variable %ProgramFiles% which points to the right
program installation directory, regardless of your system locale.

Also escape the backslash to play it safe.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 src/src.pro |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/src.pro b/src/src.pro
index 810db28..619a9a8 100644
--- a/src/src.pro
+++ b/src/src.pro
@@ -1,6 +1,6 @@
 # Under Windows launch script start_qgit.bat needs the
 # value GIT_EXEC_DIR to be set to the git bin directory
-GIT_EXEC_DIR = "C:\Program Files\Git\bin"
+GIT_EXEC_DIR = "$(ProgramFiles)\\Git\\bin"
 
 # Under Windows uncomment following line to enable console messages
 #CONFIG += ENABLE_CONSOLE_MSG
-- 
1.6.3.rc0.77.g079dc

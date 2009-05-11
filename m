From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] gitk: use --textconv to generate diff text
Date: Mon, 11 May 2009 09:18:56 +0200
Message-ID: <4A07D160.9020709@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon May 11 09:22:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3PnC-00089d-KI
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 09:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365AbZEKHTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 03:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752061AbZEKHTJ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 03:19:09 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:42582 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbZEKHTI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 03:19:08 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M3Pmu-0003nS-N6; Mon, 11 May 2009 09:19:01 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 6A8CFC6C1; Mon, 11 May 2009 09:19:00 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118777>

From: Johannes Sixt <j6t@kdbg.org>
Date: Tue, 28 Apr 2009 14:03:54 +0200

For the most part gitk's focus is on showing history and changes in
a human readable form. For this reason, it makes sense to generate
the patch text in the diff view using --textconv so that textconv drivers
are used if they are defined.

gitk can also generate patches, but we do not use --textconv because
such patches could not be applied.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 gitk-git/gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 09eac46..a8a6022 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -7194,7 +7194,7 @@ proc getblobdiffs {ids} {
     global limitdiffs vfilelimit curview
     global diffencoding targetline diffnparents

-    set cmd [diffcmd $ids "-p -C --cc --no-commit-id -U$diffcontext"]
+    set cmd [diffcmd $ids "-p --textconv -C --cc --no-commit-id -U$diffcontext"]
     if {$ignorespace} {
 	append cmd " -w"
     }
-- 
1.6.3.1007.g03ec

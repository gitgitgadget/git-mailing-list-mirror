From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] StGIT: Support Cc: fields in stg mail --auto
Date: Fri, 18 May 2007 17:33:30 +0200
Message-ID: <20070518153330.24515.35121.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 18 17:33:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp4SX-0001JX-Q9
	for gcvg-git@gmane.org; Fri, 18 May 2007 17:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756059AbXERPdc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 11:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756100AbXERPdc
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 11:33:32 -0400
Received: from rover.dkm.cz ([62.24.64.27]:55818 "EHLO rover.dkm.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756059AbXERPdc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 11:33:32 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id A23788B711;
	Fri, 18 May 2007 17:33:30 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47618>

Aside of Signed-off-by and Acked-by fields, Cc fields may occur in the
message footer; include them in the auto-composed mail Cc list.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 stgit/commands/mail.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index 151a408..97deb3e 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -223,7 +223,7 @@ def __get_signers_list(msg):
     """
     addr_list = []
 
-    r = re.compile('^(signed-off-by|acked-by):\s+(.+)$', re.I)
+    r = re.compile('^(signed-off-by|acked-by|cc):\s+(.+)$', re.I)
     for line in msg.split('\n'):
         m = r.match(line)
         if m:

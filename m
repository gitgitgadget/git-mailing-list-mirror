From: Matthias Kestenholz <lists@spinlock.ch>
Subject: Bug in diff header generation
Date: Fri, 02 Mar 2007 13:53:50 +0100
Message-ID: <1172840031.22581.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 13:54:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN7Gs-0006MD-Bu
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 13:54:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945913AbXCBMx7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 07:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945915AbXCBMx7
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 07:53:59 -0500
Received: from elephant.oekohosting.ch ([80.74.144.79]:58951 "EHLO
	elephant.oekohosting.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945913AbXCBMx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 07:53:58 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by elephant.oekohosting.ch (Postfix) with ESMTP id 2C8A262C0B2
	for <git@vger.kernel.org>; Fri,  2 Mar 2007 13:53:50 +0100 (CET)
Received: from elephant.oekohosting.ch ([127.0.0.1])
	by localhost (elephant.oekohosting.ch [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 30357-01 for <git@vger.kernel.org>;
	Fri, 2 Mar 2007 13:53:47 +0100 (CET)
Received: from [192.168.1.7] (5.106.78.83.cust.bluewin.ch [83.78.106.5])
	by elephant.oekohosting.ch (Postfix) with ESMTP id 6CBEA62C0AA
	for <git@vger.kernel.org>; Fri,  2 Mar 2007 13:53:47 +0100 (CET)
X-Mailer: Evolution 2.8.2.1 
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41204>

Hello,

I've encountered a small error in the diff header generation when
diffing against files which are not tracked by git:


[13:49] mk@crap ~/Projects/git > git diff git.c ~/bin/viname|head
diff --git a/git.c b/home/mk/bin/viname
old mode 100644
new mode 100755
index 008e016..b64857e
--- a/git.c
+++ b/home/mk/bin/viname
@@ -1,416 +1,106 @@
-#include "builtin.h"
-#include "exec_cmd.h"
-#include "cache.h"
[13:49] mk@crap ~/Projects/git > git diff HEAD:git.c ~/bin/viname|head
diff --git a/home/mk/bin/viname b/home/mk/bin/viname
index 008e016..b64857e 100755
--- a/home/mk/bin/viname
+++ b/home/mk/bin/viname
@@ -1,416 +1,106 @@
-#include "builtin.h"
-#include "exec_cmd.h"
-#include "cache.h"
-#include "quote.h"
-


When a revision is specified, git-diff prints a/home/mk/bin/viname
instead of a/git.c

Because of my final exams I've got no time to look into it right now.


Matthias

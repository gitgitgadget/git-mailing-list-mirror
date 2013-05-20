From: Dmitry Marakasov <amdmi3@amdmi3.ru>
Subject: [PATCH] contrib/git-subtree: Use /bin/sh interpreter instead of
 /bin/bash
Date: Tue, 21 May 2013 00:24:34 +0400
Message-ID: <20130520202434.GA3151@hades.panopticon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 20 22:41:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeWte-0005sJ-Fb
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 22:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758160Ab3ETUlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 16:41:24 -0400
Received: from smtp.timeweb.ru ([92.53.116.10]:6593 "EHLO smtp.timeweb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756637Ab3ETUlX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 16:41:23 -0400
X-Greylist: delayed 980 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 May 2013 16:41:23 EDT
Received: from [213.148.20.85] (helo=hive.panopticon)
	by smtp.timeweb.ru with esmtpsa (TLS1.0:DHE_RSA_CAMELLIA_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <amdmi3@amdmi3.ru>)
	id 1UeWdf-0004eE-K8
	for git@vger.kernel.org; Tue, 21 May 2013 00:24:59 +0400
Received: from hades.panopticon (hades.panopticon [192.168.0.32])
	by hive.panopticon (Postfix) with ESMTP id 29794E7B
	for <git@vger.kernel.org>; Tue, 21 May 2013 00:24:59 +0400 (MSK)
Received: by hades.panopticon (Postfix, from userid 1000)
	id C7F26A1F; Tue, 21 May 2013 00:24:34 +0400 (MSK)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224981>

Use /bin/sh interpreter instead of /bin/bash for contrib/git-subtree:
it's required for systems which don't use bash by default (for example,
FreeBSD), while there seem to be no bashisms in the script (confirmed
by looking through the source and tesing subtree functionality with
FreeBSD's /bin/sh) to require specifically bash and not the generic
posix shell.

Signed-off-by: Dmitry Marakasov <amdmi3@amdmi3.ru>
---
 contrib/subtree/git-subtree.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 8a23f58..5701376 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 #
 # git-subtree.sh: split/join git repositories in subdirectories of this one
 #
-- 
1.8.2.3

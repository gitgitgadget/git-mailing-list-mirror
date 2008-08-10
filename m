From: Anand Kumria <wildfire@progsoc.org>
Subject: [PATCH 01/12]  Create a specific version of the read_pipe_lines command for p4 invocations
Date: Sun, 10 Aug 2008 19:26:24 +0100
Message-ID: <1218392795-4084-2-git-send-email-wildfire@progsoc.org>
References: <1218392795-4084-1-git-send-email-wildfire@progsoc.org>
Cc: simon@lst.de, Anand Kumria <wildfire@progsoc.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 20:47:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSFwk-0005uj-Vi
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 20:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258AbYHJSqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 14:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752707AbYHJSqS
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 14:46:18 -0400
Received: from 133.105.233.220.exetel.com.au ([220.233.105.133]:41053 "EHLO
	giskard.kumria.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753211AbYHJSqR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 14:46:17 -0400
Received: from caliban.kumria.com ([203.7.227.146] helo=eve.kumria.com)
	by giskard.kumria.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <anand@eve.kumria.com>)
	id 1KSFjS-000225-6T; Mon, 11 Aug 2008 04:33:35 +1000
Received: from anand by eve.kumria.com with local (Exim 4.69)
	(envelope-from <anand@eve.kumria.com>)
	id 1KSFch-000158-IS; Sun, 10 Aug 2008 19:26:35 +0100
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1218392795-4084-1-git-send-email-wildfire@progsoc.org>
X-Spam-Score: -2.2
X-Spam-Score-Int: -21
X-Spam-Bar: --
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91873>

 This will make it easier to isolate changes to how 'p4' is invoked
 (whether with parameters or not, etc.).

Signed-off-by: Anand Kumria <wildfire@progsoc.org>
---
 contrib/fast-import/git-p4 |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 6ae0429..fc2a60d 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -57,6 +57,13 @@ def read_pipe_lines(c):
 
     return val
 
+def p4_read_pipe_lines(c):
+    """Specifically invoke p4 on the command supplied. """
+    real_cmd = "%s %s" % ("p4", c)
+    if verbose:
+        print real_cmd
+    return read_pipe_lines(real_cmd)
+
 def system(cmd):
     if verbose:
         sys.stderr.write("executing %s\n" % cmd)
-- 
1.5.6.3

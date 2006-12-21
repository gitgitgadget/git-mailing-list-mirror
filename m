From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] hooks/commit-msg: add example to add Signed-off-by line to message
Date: Thu, 21 Dec 2006 09:24:17 +0000
Message-ID: <200612210924.17357.andyparkins@gmail.com>
References: <7vejqufonm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Dec 21 10:24:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxKAA-00050E-JA
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 10:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965169AbWLUJY2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 04:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965172AbWLUJY2
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 04:24:28 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:48850 "EHLO
	369run02s.360vision.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965165AbWLUJY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 04:24:26 -0500
Received: from dvr.360vision.com ([192.189.1.24]) by 369run02s.360vision.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 21 Dec 2006 09:26:32 +0000
Received: from localhost ([127.0.0.1])
	by dvr.360vision.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GxKA2-0000qW-00
	for <git@vger.kernel.org>; Thu, 21 Dec 2006 09:24:23 +0000
In-Reply-To: <7vejqufonm.fsf@assigned-by-dhcp.cox.net>
To: git@vger.kernel.org
X-TUID: 85b7fffa1c9386bd
X-UID: 201
X-Length: 1694
Content-Disposition: inline
X-OriginalArrivalTime: 21 Dec 2006 09:26:32.0373 (UTC) FILETIME=[1A2D3E50:01C724E2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35040>

After checking to see if the commit message already has the target
signed-off-by (for example in --amend commits), this patch generates a
signed off by line from the repository owner and adds it to the commit
message.

Based on Johannes Schindelin's earlier patch to perform the same
function.

Originally, this was done in the pre-commit hook but Junio pointed out
that the commit-msg hook allows the message to be edited.  This has the
aditional advantage that the commit-msg hook gets passed the name of the
message file as a parameter, so it doesn't have to figure out GIT_DIR for
itself.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 templates/hooks--commit-msg |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/templates/hooks--commit-msg b/templates/hooks--commit-msg
index 0b906ca..ce76bdf 100644
--- a/templates/hooks--commit-msg
+++ b/templates/hooks--commit-msg
@@ -8,6 +8,11 @@
 #
 # To enable this hook, make this file executable.
 
+# Uncomment the below to add a Signed-off-by line to the message.
+#SOB=$(git var GIT_AUTHOR_IDENT | \
+#	sed -n "s/^\(.*\) [0-9]\+ [-+][0-9]\+$/Signed-off-by: \1/p")
+#grep -qs "^$SOB" "$1" || echo "$SOB" >> "$1"
+
 # This example catches duplicate Signed-off-by lines.
 
 test "" = "$(grep '^Signed-off-by: ' "$1" |
-- 
1.4.4.2.g120e3

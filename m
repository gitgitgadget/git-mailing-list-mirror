From: Greg Brockman <gdb@MIT.EDU>
Subject: [PATCH/RFC 2/4] git-shell-commands: Add a command to list bare repos
Date: Tue, 13 Jul 2010 23:01:13 -0400
Message-ID: <1279076475-27730-3-git-send-email-gdb@mit.edu>
References: <1279076475-27730-1-git-send-email-gdb@mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Greg Brockman <gdb@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 14 05:01:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYsE9-00007Q-JK
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 05:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756210Ab0GNDBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 23:01:37 -0400
Received: from DMZ-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.34]:58548 "EHLO
	dmz-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755945Ab0GNDBg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jul 2010 23:01:36 -0400
X-AuditID: 12074422-b7b0eae000000a2e-99-4c3d288f768b
Received: from mailhub-auth-4.mit.edu (MAILHUB-AUTH-4.MIT.EDU [18.7.62.39])
	by dmz-mailsec-scanner-5.mit.edu (Symantec Brightmail Gateway) with SMTP id 2B.EF.02606.F882D3C4; Tue, 13 Jul 2010 23:01:35 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id o6E31Zvw017009;
	Tue, 13 Jul 2010 23:01:35 -0400
Received: from localhost (EASTCAMPUS-NINE-NINETY-FOUR.MIT.EDU [18.238.6.227])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6E31Ypm005120;
	Tue, 13 Jul 2010 23:01:35 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1279076475-27730-1-git-send-email-gdb@mit.edu>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150957>

Signed-off-by: Greg Brockman <gdb@mit.edu>
---
 git-shell-commands/list |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)
 create mode 100755 git-shell-commands/list

diff --git a/git-shell-commands/list b/git-shell-commands/list
new file mode 100755
index 0000000..dca2472
--- /dev/null
+++ b/git-shell-commands/list
@@ -0,0 +1,9 @@
+#!/bin/bash
+
+cd "..";
+# TODO: make safe for spaces
+for dir in $(find -type d -name '*.git'); do
+    if [ "$(git --git-dir="$dir" rev-parse --is-bare-repository)" = "true" ]; then
+	echo "${dir#./}"
+    fi
+done
-- 
1.7.0.4

From: Greg Brockman <gdb@MIT.EDU>
Subject: [PATCH 3/4] git-shell-commands: Add a help command
Date: Tue, 20 Jul 2010 01:16:11 -0400
Message-ID: <1279602972-1264-4-git-send-email-gdb@mit.edu>
References: <1279602972-1264-1-git-send-email-gdb@mit.edu>
Cc: Greg Brockman <gdb@mit.edu>
To: j.sixt@viscovery.net, git@vger.kernel.org, gitster@pobox.com,
	avarab@gmail.com, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue Jul 20 07:17:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ob5CZ-0001ZB-DA
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 07:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753156Ab0GTFQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 01:16:44 -0400
Received: from DMZ-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.36]:63004 "EHLO
	dmz-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753856Ab0GTFQl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jul 2010 01:16:41 -0400
X-AuditID: 12074424-b7c35ae000000a07-ba-4c45313a726a
Received: from mailhub-auth-2.mit.edu (MAILHUB-AUTH-2.MIT.EDU [18.7.62.36])
	by dmz-mailsec-scanner-7.mit.edu (Symantec Brightmail Gateway) with SMTP id E3.42.02567.A31354C4; Tue, 20 Jul 2010 01:16:42 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id o6K5Gd86014606;
	Tue, 20 Jul 2010 01:16:39 -0400
Received: from localhost (STRATTON-FIVE-FIFTY-FOUR.MIT.EDU [18.187.7.43])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6K5GcvD001121;
	Tue, 20 Jul 2010 01:16:38 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1279602972-1264-1-git-send-email-gdb@mit.edu>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151298>

Signed-off-by: Greg Brockman <gdb@mit.edu>
---
 contrib/git-shell-commands/help |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)
 create mode 100755 contrib/git-shell-commands/help

diff --git a/contrib/git-shell-commands/help b/contrib/git-shell-commands/help
new file mode 100755
index 0000000..19d5277
--- /dev/null
+++ b/contrib/git-shell-commands/help
@@ -0,0 +1,18 @@
+#!/bin/sh
+
+set -eu
+
+if tty -s; then
+    echo "Run 'help' for help, or 'exit' to leave.  Available commands:"
+else
+    echo "Run 'help' for help.  Available commands:"
+fi
+
+cd "$(dirname "$0")"
+
+for cmd in *; do
+    case "$cmd" in
+	help) ;;
+	*) [ -f "$cmd" ] && [ -x "$cmd" ] && echo "$cmd" ;;
+    esac
+done
-- 
1.7.0.4

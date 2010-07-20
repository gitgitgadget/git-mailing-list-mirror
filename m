From: Greg Brockman <gdb@MIT.EDU>
Subject: [PATCH 2/4] git-shell-commands: Add a command to list bare repos
Date: Tue, 20 Jul 2010 01:16:10 -0400
Message-ID: <1279602972-1264-3-git-send-email-gdb@mit.edu>
References: <1279602972-1264-1-git-send-email-gdb@mit.edu>
Cc: Greg Brockman <gdb@mit.edu>
To: j.sixt@viscovery.net, git@vger.kernel.org, gitster@pobox.com,
	avarab@gmail.com, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue Jul 20 07:17:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ob5CY-0001ZB-Th
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 07:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753854Ab0GTFQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 01:16:40 -0400
Received: from DMZ-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.37]:55401 "EHLO
	dmz-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753813Ab0GTFQi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jul 2010 01:16:38 -0400
X-AuditID: 12074425-b7bfeae000000a0d-9b-4c453137936b
Received: from mailhub-auth-4.mit.edu (MAILHUB-AUTH-4.MIT.EDU [18.7.62.39])
	by dmz-mailsec-scanner-8.mit.edu (Symantec Brightmail Gateway) with SMTP id BC.74.02573.731354C4; Tue, 20 Jul 2010 01:16:39 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id o6K5GZtC025851;
	Tue, 20 Jul 2010 01:16:35 -0400
Received: from localhost (STRATTON-FIVE-FIFTY-FOUR.MIT.EDU [18.187.7.43])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6K5GXxO001118;
	Tue, 20 Jul 2010 01:16:34 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1279602972-1264-1-git-send-email-gdb@mit.edu>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151299>

Signed-off-by: Greg Brockman <gdb@mit.edu>
---
 contrib/git-shell-commands/list |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)
 create mode 100755 contrib/git-shell-commands/list

diff --git a/contrib/git-shell-commands/list b/contrib/git-shell-commands/list
new file mode 100755
index 0000000..cd8b15a
--- /dev/null
+++ b/contrib/git-shell-commands/list
@@ -0,0 +1,5 @@
+#!/bin/sh
+set -eu
+
+print_if_bare_repo='[ "$(git --git-dir="$1" rev-parse --is-bare-repository)" = true ] && echo "${1#./}"'
+find -type d -name "*.git" -exec sh -c "$print_if_bare_repo" -- \{} \; -prune
-- 
1.7.0.4

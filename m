From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Doc fix for git-reflog: mention @{...} syntax, and <ref> in synopsys.
Date: Mon, 19 Nov 2007 19:35:42 +0100
Message-ID: <1195497342-26334-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqtznirtlk.fsf@bauges.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 19 19:37:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuBTy-0005NR-IZ
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 19:36:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225AbXKSSf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 13:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751976AbXKSSf4
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 13:35:56 -0500
Received: from imag.imag.fr ([129.88.30.1]:62688 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751255AbXKSSfz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 13:35:55 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id lAJIZgBa029991
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 19 Nov 2007 19:35:42 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IuBTC-0007nC-DZ; Mon, 19 Nov 2007 19:35:42 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IuBTC-0006ux-8k; Mon, 19 Nov 2007 19:35:42 +0100
X-Mailer: git-send-email 1.5.3.5.724.g49d9d
In-Reply-To: <vpqtznirtlk.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 19 Nov 2007 19:35:42 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65485>

The HEAD@{...} syntax was documented in git-rev-parse manpage, which
is hard to find by someone looking for the documentation of porcelain.
git-reflog is probably the place where one expects to find this.

While I'm there, "git revlog show whatever" was also undocumented.
---
 Documentation/git-reflog.txt |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 5c7316c..aeac6f0 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -19,7 +19,7 @@ depending on the subcommand:
 git reflog expire [--dry-run] [--stale-fix] [--verbose]
 	[--expire=<time>] [--expire-unreachable=<time>] [--all] <refs>...
 
-git reflog [show] [log-options]
+git reflog [show] [log-options] [<ref>]
 
 Reflog is a mechanism to record when the tip of branches are
 updated.  This command is to manage the information recorded in it.
@@ -32,10 +32,17 @@ directly by the end users -- instead, see gitlink:git-gc[1].
 
 The subcommand "show" (which is also the default, in the absence of any
 subcommands) will take all the normal log options, and show the log of
-`HEAD`, which will cover all recent actions, including branch switches.
+`HEAD`, or of the reference provided in the command-line, which will
+cover all recent actions, including branch switches.
 It is basically an alias for 'git log -g --abbrev-commit
 --pretty=oneline', see gitlink:git-log[1].
 
+The reflog is useful in various git commands, to specify the old value
+of a reference. For example, `HEAD@\{2\}` means "where HEAD used to be
+two moves ago", `master@\{one.week.ago\}` means "where master used to
+point to one week ago", and so on. See gitlink:git-rev-parse[1] for
+more details.
+
 
 OPTIONS
 -------
-- 
1.5.3.5.724.g49d9d

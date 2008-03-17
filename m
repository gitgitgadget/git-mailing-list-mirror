From: Xavier Maillard <xma@gnu.org>
Subject: [PATCH] Shorten and simplify sendemail.alias* configuration variables.
Date: Mon, 17 Mar 2008 23:53:04 +0100
Message-ID: <1205794384-14513-1-git-send-email-xma@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 18 00:36:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbOsH-00071k-Eu
	for gcvg-git-2@gmane.org; Tue, 18 Mar 2008 00:36:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172AbYCQXfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 19:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753021AbYCQXfd
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 19:35:33 -0400
Received: from master.uucpssh.org ([193.218.105.66]:38811 "EHLO
	master.uucpssh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843AbYCQXfc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 19:35:32 -0400
Received: by master.uucpssh.org (Postfix, from userid 10)
	id 38E88D5437; Tue, 18 Mar 2008 00:34:50 +0100 (CET)
Received: from localhost.localdomain (IDENT:1000@localhost [127.0.0.1])
	by localhost.localdomain (8.14.1/8.13.8) with ESMTP id m2HMr5EA014592
	for <git@vger.kernel.org>; Mon, 17 Mar 2008 23:53:05 +0100
Received: (from xma@localhost)
	by localhost.localdomain (8.14.1/8.13.8/Submit) id m2HMr4cl014557
	for git@vger.kernel.org; Mon, 17 Mar 2008 23:53:04 +0100
X-Mailer: git-send-email 1.5.4.4.685.g64f14.dirty
X-uucpssh: Found to be clean
X-uucpssh-SpamCheck: not spam, SpamAssassin (not cached, score=-4.389,
	required 4.6, autolearn=not spam, ALL_TRUSTED -1.80, AWL 0.01,
	BAYES_00 -2.60, SPF_HELO_PASS -0.00)
X-uucpssh-From: xma@gnu.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77470>

I find it more consistent and less error prone to have aliasfile
instead of aliasesfile and aliastype instead of aliasfiletype.

Documentation is also updated to reflect the changes.

Signed-off-by: Xavier Maillard <xma@gnu.org>
---
 Documentation/git-send-email.txt |    8 ++++----
 git-send-email.perl              |    4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 336d797..33fd589 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -192,12 +192,12 @@ sendemail.identity::
 	identities and to hoist sensitive authentication information
 	out of the repository and into the global configuration file.
 
-sendemail.aliasesfile::
+sendemail.aliasfile::
 	To avoid typing long email addresses, point this to one or more
-	email aliases files.  You must also supply 'sendemail.aliasfiletype'.
+	email aliases files.  You must also supply 'sendemail.aliastype'.
 
-sendemail.aliasfiletype::
-	Format of the file(s) specified in sendemail.aliasesfile. Must be
+sendemail.aliastype::
+	Format of the file(s) specified in sendemail.aliasfile. Must be
 	one of 'mutt', 'mailrc', 'pine', or 'gnus'.
 
 sendemail.to::
diff --git a/git-send-email.perl b/git-send-email.perl
index be4a20d..1d8bb8e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -203,9 +203,9 @@ my %config_settings = (
     "smtppass" => \$smtp_authpass,
     "to" => \@to,
     "cccmd" => \$cc_cmd,
-    "aliasfiletype" => \$aliasfiletype,
+    "aliastype" => \$aliasfiletype,
     "bcc" => \@bcclist,
-    "aliasesfile" => \@alias_files,
+    "aliasfile" => \@alias_files,
     "suppresscc" => \@suppress_cc,
 );
 
-- 
1.5.4.4.685.g64f14.dirty
